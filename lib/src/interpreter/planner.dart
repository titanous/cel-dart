import 'package:cel/src/common/types/ref/provider.dart';

import '../cel/expr.dart';
import '../operators/operators.dart';
import 'attribute.dart';
import 'attribute_factory.dart';
import 'dispatcher.dart';
import 'functions/functions.dart';
import 'interpretable.dart';

// Port of
// https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/planner.go.
class Planner {
  Planner(
      {required this.attributeFactory,
      required this.dispatcher,
      required this.adapter});

  final AttributeFactory attributeFactory;
  final Dispatcher dispatcher;
  final TypeAdapter adapter;

  Interpretable plan(Expr expression) {
    if (expression is ConstExpression) {
      return planConst(expression);
    }
    if (expression is IdentExpr) {
      return planIdent(expression);
    }
    if (expression is CallExpr) {
      return planCall(expression);
    }
    if (expression is SelectExpr) {
      return planSelect(expression);
    }
    if (expression is ListExpr) {
      return planCreateList(expression);
    }
    if (expression is MapExpr) {
      return planCreateMap(expression);
    }
    if (expression is MessageExpr) {
      return planCreateMessage(expression);
    }
    if (expression is PresenceTestExpr) {
      return planPresenceTest(expression);
    }
    if (expression is ComprehensionExpr) {
      return planComprehension(expression);
    }
    return ErrorInterpretable(
        'Unsupported Expression type: ${expression.runtimeType}');
  }

  Interpretable planIdent(IdentExpr ident) {
    return AttributeValueInterpretable(
        attributeFactory.maybeAttribute(ident.name), adapter);
  }

  // https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/planner.go#L239
  Interpretable planCall(CallExpr expression) {
    final functionName = expression.function;
    // Skip target, p.resolveFunction.
    final interpretableArguments = [
      // If there is a target, it becomes the first argument.
      if (expression.target != null) plan(expression.target!),
      ...expression.args.map((e) => plan(e))
    ];
    if (functionName == Operators.logicalAnd.name) {
      return planCallLogicalAnd(expression, interpretableArguments);
    }
    if (functionName == Operators.logicalOr.name) {
      return planCallLogicalOr(expression, interpretableArguments);
    }
    if (functionName == Operators.conditional.name) {
      return planCallConditional(interpretableArguments);
    }
    if (functionName == Operators.equals.name) {
      return planCallEqual(expression, interpretableArguments);
    }
    if (functionName == Operators.notEquals.name) {
      return planCallNotEqual(expression, interpretableArguments);
    }
    // TODO: implement indexer, optSelect, optIndex.

    final functionImplementation = dispatcher.findOverload(functionName,
        argCount: interpretableArguments.length);
    if (functionImplementation == null) {
      // If no overload found and this is a method call with a target,
      // try the receiver pattern (e.g., str_var.format([args]))
      if (expression.target != null && interpretableArguments.length == 2) {
        return BinaryInterpretable(functionName, null,
            interpretableArguments[0], interpretableArguments[1]);
      }
      return ErrorInterpretable(
          'No overload found for function: $functionName with ${interpretableArguments.length} arguments');
    }

    // Check the argument count and use the appropriate operator
    switch (interpretableArguments.length) {
      // TODO: handle zero functions.
      case 1:
        if (functionImplementation.unaryOperator != null) {
          return planCallUnary(expression, functionName, functionImplementation,
              interpretableArguments);
        } else if (functionImplementation.functionOperator != null) {
          return planCallFunction(expression, functionName,
              functionImplementation, interpretableArguments);
        }
        return ErrorInterpretable(
            'No unary operator implementation for function: $functionName');
      case 2:
        // Check if there are multiple overloads with explicit type signatures that need type-based dispatch
        final allOverloads = dispatcher.findAllOverloads(functionName);
        if (allOverloads != null && allOverloads.length > 1) {
          // Only use type-aware dispatch if at least one overload has parameter types
          final hasTypedOverloads =
              allOverloads.any((o) => o.parameterTypes != null);
          if (hasTypedOverloads) {
            return TypeAwareBinaryInterpretable(functionName, dispatcher,
                interpretableArguments[0], interpretableArguments[1]);
          }
        }

        if (functionImplementation.binaryOperator != null) {
          return planCallBinary(expression, functionName,
              functionImplementation, interpretableArguments);
        } else if (functionImplementation.functionOperator != null) {
          return planCallFunction(expression, functionName,
              functionImplementation, interpretableArguments);
        }
        return ErrorInterpretable(
            'No binary operator implementation for function: $functionName');
      default:
        if (functionImplementation.functionOperator != null) {
          return planCallFunction(expression, functionName,
              functionImplementation, interpretableArguments);
        }
        throw UnsupportedError(
            "Function $functionName with ${interpretableArguments.length} arguments is not supported.");
    }
  }

  Interpretable planCallLogicalAnd(
      CallExpr expression, List<Interpretable> interpretableArguments) {
    return LogicalAndInterpretable(
        interpretableArguments[0], interpretableArguments[1]);
  }

  Interpretable planCallLogicalOr(
      CallExpr expression, List<Interpretable> interpretableArguments) {
    return LogicalOrInterpretable(
        interpretableArguments[0], interpretableArguments[1]);
  }

  Interpretable planCallEqual(
      CallExpr expression, List<Interpretable> interpretableArguments) {
    return EqualInterpretable(
        interpretableArguments[0], interpretableArguments[1]);
  }

  Interpretable planCallNotEqual(
      CallExpr expression, List<Interpretable> interpretableArguments) {
    return NotEqualInterpretable(
        interpretableArguments[0], interpretableArguments[1]);
  }

  // https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/planner.go#L179
  Interpretable planSelect(SelectExpr select) {
    // Try to build the full qualified identifier name and check if it can be resolved
    // This handles cases like a.b.c where "a.b.c" might be a single variable name
    // But we should only do this for actual qualified identifiers, not field access on variables
    final qualifiedName = _buildQualifiedName(select);
    if (qualifiedName != null) {
      // Check if this looks like field access on a variable rather than a qualified identifier
      // If the base part (before first dot) is a simple identifier that could be a variable,
      // prefer traditional select planning over qualified identifier resolution
      final parts = qualifiedName.split('.');
      if (parts.length == 2 && _isSimpleIdentifier(parts[0])) {
        // This looks like "variable.field" - use traditional select planning
        // Fall through to traditional planning
      } else {
        // This looks like a true qualified identifier - use qualified name resolution
        final qualifiedAttr = attributeFactory.maybeAttribute(qualifiedName);
        return AttributeValueInterpretable(qualifiedAttr, adapter);
      }
    }

    // Fall back to traditional select planning
    final operand = plan(select.operand);

    var attribute = operand;
    if (attribute is! AttributeValueInterpretable) {
      // Set up a relative attribute.
      attribute = relativeAttribute(operand);
    }
    final qualifier = attributeFactory.qualifier(select.field);
    attribute.addQualifier(qualifier);
    return attribute;
  }

  /// Build qualified identifier name from nested select expressions
  /// For SelectExpr(operand: SelectExpr(operand: IdentExpr("a"), field: "b"), field: "c")
  /// returns "a.b.c"
  String? _buildQualifiedName(SelectExpr select) {
    final parts = <String>[];

    // Add the current field
    parts.insert(0, select.field);

    // Walk up the operand chain
    Expr current = select.operand;
    while (true) {
      if (current is SelectExpr) {
        parts.insert(0, current.field);
        current = current.operand;
      } else if (current is IdentExpr) {
        parts.insert(0, current.name);
        break;
      } else {
        // Not a simple qualified identifier - has complex expressions
        return null;
      }
    }

    return parts.join('.');
  }
  
  /// Check if a string is a simple identifier (letters, numbers, underscore)
  bool _isSimpleIdentifier(String name) {
    return RegExp(r'^[a-zA-Z_][a-zA-Z0-9_]*$').hasMatch(name);
  }

  // Plan presence test for has() macro
  Interpretable planPresenceTest(PresenceTestExpr presenceTest) {
    final operand = plan(presenceTest.operand);

    var attribute = operand;
    if (attribute is! AttributeValueInterpretable) {
      // Set up a relative attribute.
      attribute = relativeAttribute(operand);
    }

    // Add a presence test qualifier for the field
    final qualifier = PresenceTestQualifier(presenceTest.field);
    attribute.addQualifier(qualifier);
    return attribute;
  }

  AttributeValueInterpretable relativeAttribute(Interpretable eval) {
    return AttributeValueInterpretable(
        attributeFactory.relativeAttribute(eval), adapter);
  }

  Interpretable planCallBinary(CallExpr expression, String functionName,
      Overload? functionImplementation, List<Interpretable> arguments) {
    return BinaryInterpretable(functionName,
        functionImplementation?.binaryOperator, arguments[0], arguments[1]);
  }

  // https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/planner.go#L516
  Interpretable planCreateList(ListExpr expression) {
    final elements = expression.elements.map((e) => plan(e)).toList();
    return ListInterpretable(elements, adapter);
  }

  Interpretable planCallUnary(CallExpr expression, String functionName,
      Overload functionImplementation, List<Interpretable> arguments) {
    if (functionImplementation.unaryOperator == null) {
      return ErrorInterpretable(
          'No unary operator implementation for function: $functionName');
    }
    return UnaryInterpretable(
        functionImplementation.unaryOperator!, arguments[0]);
  }

  // In cel-go, it's called a Struct, but that's how it is called in the
  // Protobuf. In CEL, it's called a Map. So we use Map.
  Interpretable planCallFunction(CallExpr expression, String functionName,
      Overload functionImplementation, List<Interpretable> arguments) {
    if (functionImplementation.functionOperator == null) {
      return ErrorInterpretable(
          'No function operator implementation for function: $functionName');
    }
    return FunctionInterpretable(
        functionImplementation.functionOperator!, arguments);
  }

  // https://github.com/google/cel-spec/blob/master/doc/langdef.md#dynamic-values
  // https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/parser.go#L682
  Interpretable planCreateMap(MapExpr expression) {
    final keys = expression.entries.map((e) => plan(e.key)).toList();
    final values = expression.entries.map((e) => plan(e.value)).toList();
    return MapInterpretable(keys, values, adapter);
  }

  // https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/planner.go#L453
  Interpretable planCallConditional(List<Interpretable> arguments) {
    return AttributeValueInterpretable(
        ConditionalAttribute(
            condition: arguments[0], truthy: arguments[1], falsy: arguments[2]),
        adapter);
  }

  Interpretable planConst(ConstExpression constant) {
    // https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/planner.go#L644
    final constantValue = adapter.nativeToValue(constant.value);
    return InterpretableConst(constantValue);
  }

  // Plan message creation similar to planCreateMap but for protobuf messages
  Interpretable planCreateMessage(MessageExpr expression) {
    final keys = expression.entries.map((e) => plan(e.key)).toList();
    final values = expression.entries.map((e) => plan(e.value)).toList();
    // For now, treat message creation like map creation - this will need refinement
    // when proper message type support is added
    return MessageInterpretable(expression.typeName, keys, values, adapter);
  }

  // Plan comprehension expressions (.all(), .exists(), .filter(), .map() macros)
  Interpretable planComprehension(ComprehensionExpr expression) {
    final iterRange = plan(expression.iterRange);
    final accuInit = plan(expression.accuInit);
    final loopCondition = plan(expression.loopCondition);
    final loopStep = plan(expression.loopStep);
    final result = plan(expression.result);

    return ComprehensionInterpretable(
      expression.accuVar,
      expression.iterVar,
      iterRange,
      accuInit,
      loopCondition,
      loopStep,
      result,
      expression.iterVar2,
    );
  }
}
