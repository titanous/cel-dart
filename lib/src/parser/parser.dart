import 'package:collection/collection.dart';
import 'package:antlr4/antlr4.dart';
import 'package:fixnum/fixnum.dart';
import 'package:cel/src/operators/operators.dart';

import '../cel/expr.dart';
import 'gen/CELLexer.dart';
import 'gen/CELParser.dart';
import 'unescape.dart';

/// Low-level Parser that parses CEL code into an [Expr]. Exposed for testing
/// purposes. Most users should use [Environment.compile] insetad. Based on
/// https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/parser.go#L359-L443.
class Parser {
  Expr parse(String input) {
    final lexer = CELLexer(InputStream.fromString(input));
    final tokens = CommonTokenStream(lexer);
    final parser = CELParser(tokens);
    parser.addErrorListener(DiagnosticErrorListener());
    parser.buildParseTree = true;
    final tree = parser.start();
    return visit(tree);
  }
}

Expr visit(ParseTree tree) {
  tree = unnest(tree);
  if (tree is StartContext) {
    return visitStart(tree);
  }
  if (tree is ExprContext) {
    return visitExpr(tree);
  }
  if (tree is ConditionalOrContext) {
    return visitConditionalOr(tree);
  }
  if (tree is ConditionalAndContext) {
    return visitConditionalAnd(tree);
  }
  if (tree is LogicalNotContext) {
    return visitLogicalNot(tree);
  }
  if (tree is RelationContext) {
    return visitRelation(tree);
  }
  if (tree is CalcContext) {
    return visitCalc(tree);
  }
  if (tree is UnaryContext) {
    return visitUnary(tree);
  }
  if (tree is MemberCallContext) {
    return visitMemberCall(tree);
  }
  if (tree is SelectContext) {
    return visitSelect(tree);
  }
  if (tree is StringContext) {
    return visitString(tree);
  }
  if (tree is BoolTrueContext) {
    return visitBoolTrue(tree);
  }
  if (tree is BoolFalseContext) {
    return visitBoolFalse(tree);
  }
  if (tree is IntContext) {
    return visitInt(tree);
  }
  if (tree is UintContext) {
    return visitUint(tree);
  }
  if (tree is DoubleContext) {
    return visitDouble(tree);
  }
  if (tree is BytesContext) {
    return visitBytes(tree);
  }
  if (tree is NullContext) {
    return visitNull(tree);
  }
  if (tree is IdentOrGlobalCallContext) {
    return visitIdentOrGlobalCall(tree);
  }
  if (tree is CreateListContext) {
    return visitCreateList(tree);
  }
  if (tree is CreateStructContext) {
    return visitCreateStruct(tree);
  }
  if (tree is MapInitializerListContext) {
    return visitMapInitializerList(tree);
  }
  if (tree is IndexContext) {
    return visitIndex(tree);
  }
  if (tree is CreateMessageContext) {
    return visitCreateMessage(tree);
  }
  if (tree is SimpleIdentifierContext) {
    return visitSimpleIdentifier(tree);
  }
  if (tree is EscapedIdentifierContext) {
    return visitEscapedIdentifier(tree);
  }

  throw UnsupportedError(
      'Unknown parse element ${tree.text} of type ${tree.runtimeType}');
}

Expr visitIndex(IndexContext tree) {
  // Skipped porting globalCallOrMacro.
  final index = visit(tree.index!);
  return CallExpr(
      function: Operators.index_.name,
      target: visit(tree.member()!),
      args: [index]);
}

// https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/parser.go#L692
Expr visitMapInitializerList(MapInitializerListContext tree) {
  assert(tree.cols.length == tree.keys.length);
  assert(tree.cols.length == tree.values.length);

  // Unlike cel-go, we wrap it in an Expr to avoid using dynamic.
  return CreateStructEntryListExpr(
      IterableZip([tree.keys, tree.values]).map((keyValue) {
    final key = visit((keyValue.first as OptExprContext).e!);
    final value = visit(keyValue.last);
    return CreateStructEntry(key, value);
  }).toList());
}

// https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/parser.go#L682
Expr visitCreateStruct(CreateStructContext tree) {
  final entries = tree.entries != null
      ? (visit(tree.entries!) as CreateStructEntryListExpr).entries
      : <CreateStructEntry>[];
  // For some reason, in the original, they wrap the reslult like this:
  // Expr(exprKind: Expr_StructExpr(structExpr: Expr_CreateStruct(entries: entries))).
  // https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/helper.go#L130
  return MapExpr(entries);
}

Expr visitLogicalNot(LogicalNotContext tree) {
  final target = visit(tree.member()!);
  // Skipped: global call or macro.

  return CallExpr(function: Operators.logicalNot.name, args: [target]);
}

Expr visitCreateList(CreateListContext tree) {
  final elements = visitListInit(tree.elems);
  return ListExpr(elements);
}

// https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/parser.go#L807
List<Expr> visitListInit(ListInitContext? elems) {
  if (elems == null) {
    return [];
  }
  // Skipped porting of Optionals.

  return elems.elems.map((e) => visit(e.e!)).toList();
}

Expr visitBytes(BytesContext tree) {
  // Looks like `b"abc"`.
  // Gotta remove the starting 'b' and unquote the rest.
  final text = tree.text;
  if (text.isEmpty) {
    return BytesLiteralExpr([]);
  }

  try {
    final unescaped = unescape(text.substring(1), true);
    return BytesLiteralExpr(unescaped.codeUnits);
  } catch (e) {
    // Handle empty bytes case
    if (text == 'b""' || text == "b''") {
      return BytesLiteralExpr([]);
    }
    rethrow;
  }
}

Expr visitDouble(DoubleContext tree) {
  return DoubleLiteralExpr((double.parse(tree.text)));
}

Expr visitInt(IntContext tree) {
  return IntLiteralExpr((int.parse(tree.text)));
}

Expr visitUint(UintContext tree) {
  // trim the 'u' designator included in the uint literal.
  final text = tree.text.substring(0, tree.text.length - 1);
  // Use Int64.parseInt to support full uint64 range
  // Handle hexadecimal format by parsing with BigInt first then converting
  if (text.startsWith('0x') || text.startsWith('0X')) {
    final bigInt = BigInt.parse(text);
    return UintLiteralExpr(Int64(bigInt.toInt()));
  } else {
    return UintLiteralExpr(Int64.parseInt(text));
  }
}

Expr visitNull(NullContext tree) {
  return NullLiteralExpr();
}

Expr visitBoolTrue(BoolTrueContext tree) {
  return BoolLiteralExpr((true));
}

Expr visitBoolFalse(BoolFalseContext tree) {
  return BoolLiteralExpr((false));
}

Expr visitStart(StartContext c) {
  return visit(c.expr()!);
}

Expr visitExpr(ExprContext c) {
  final result = visit(c.e!);
  if (c.op == null) {
    return result;
  }
  final condition = result;
  final ifTrue = visit(c.e1!);
  final ifFalse = visit(c.e2!);

  return CallExpr(
      function: Operators.conditional.name, args: [condition, ifTrue, ifFalse]);
}

Expr visitConditionalOr(ConditionalOrContext tree) {
  // TODO: use a balancer like in https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/parser.go#L463-L476.
  return conditionalOrFromConditionalAndContexts(
      Operators.logicalOr.name, [tree.e!, ...tree.e1]);
}

Expr conditionalOrFromConditionalAndContexts(
    String function, List<ParserRuleContext> conditionalAndContexts) {
  if (conditionalAndContexts.length == 1) {
    return visit(conditionalAndContexts.first);
  }
  return CallExpr(function: function, args: [
    visit(conditionalAndContexts.first),
    conditionalOrFromConditionalAndContexts(
        function, conditionalAndContexts.sublist(1))
  ]);
}

Expr visitConditionalAnd(ConditionalAndContext tree) {
  return conditionalOrFromConditionalAndContexts(
      Operators.logicalAnd.name, [tree.e!, ...tree.e1]);
}

Expr visitCalc(CalcContext tree) {
  return CallExpr(
      function: findOperator(tree.op!.text!),
      args: [visit(tree.calc(0)!), visit(tree.calc(1)!)]);
}

Expr visitUnary(UnaryContext tree) {
  return StringLiteralExpr(('<<error>>'));
}

Expr visitMemberCall(MemberCallContext tree) {
  final operand = visit(tree.member()!);
  final id = tree.id!.text!;
  final args = tree.args?.e.map((e) => visit(e)).toList() ?? [];

  // Check for comprehension macros (.all(), .exists(), etc.)
  if (_isComprehensionMacro(id) && args.length == 2) {
    final iterVar = args[0];
    final condition = args[1];

    // The first argument should be an identifier (the iteration variable)
    if (iterVar is IdentExpr) {
      return _expandComprehensionMacro(id, operand, iterVar.name, condition);
    }
  }

  // Check if this is a namespace-qualified function call (e.g., strings.quote)
  if (operand is IdentExpr) {
    final namespaceName = operand.name;

    // Only treat known namespaces as namespace qualifiers
    // Current known namespaces: strings, math, sets, etc.
    const knownNamespaces = {'strings', 'math', 'sets'};

    if (knownNamespaces.contains(namespaceName)) {
      // Create a namespace-qualified function name
      final qualifiedFunctionName = '$namespaceName.$id';

      // Return a global function call with the qualified name
      return CallExpr(function: qualifiedFunctionName, args: args);
    }
  }

  // For variables and other operands, use member call behavior
  // This handles cases like str_var.format([...]) properly
  return CallExpr(function: id, target: operand, args: args);
}

bool _isComprehensionMacro(String functionName) {
  return functionName == 'all' ||
      functionName == 'exists' ||
      functionName == 'exists_one' ||
      functionName == 'filter' ||
      functionName == 'map';
}

Expr _expandComprehensionMacro(
    String macroName, Expr iterRange, String iterVar, Expr condition) {
  switch (macroName) {
    case 'all':
      return _expandAllMacro(iterRange, iterVar, condition);
    case 'exists':
      return _expandExistsMacro(iterRange, iterVar, condition);
    case 'exists_one':
      return _expandExistsOneMacro(iterRange, iterVar, condition);
    case 'filter':
      return _expandFilterMacro(iterRange, iterVar, condition);
    case 'map':
      return _expandMapMacro(iterRange, iterVar, condition);
    default:
      throw ArgumentError('Unknown comprehension macro: $macroName');
  }
}

// Expand .all(x, condition) to a comprehension that returns true if all elements satisfy the condition
Expr _expandAllMacro(Expr iterRange, String iterVar, Expr condition) {
  return ComprehensionExpr(
    iterVar: iterVar,
    iterRange: iterRange,
    accuVar: '__result__',
    accuInit: BoolLiteralExpr(true),
    loopCondition: IdentExpr('__result__'),
    loopStep:
        CallExpr(function: '_&&_', args: [IdentExpr('__result__'), condition]),
    result: IdentExpr('__result__'),
  );
}

// Expand .exists(x, condition) to a comprehension that returns true if any element satisfies the condition
Expr _expandExistsMacro(Expr iterRange, String iterVar, Expr condition) {
  return ComprehensionExpr(
    iterVar: iterVar,
    iterRange: iterRange,
    accuVar: '__result__',
    accuInit: BoolLiteralExpr(false),
    loopCondition: CallExpr(function: '!_', args: [IdentExpr('__result__')]),
    loopStep:
        CallExpr(function: '_||_', args: [IdentExpr('__result__'), condition]),
    result: IdentExpr('__result__'),
  );
}

// Expand .exists_one(x, condition) to a comprehension that returns true if exactly one element satisfies the condition
Expr _expandExistsOneMacro(Expr iterRange, String iterVar, Expr condition) {
  return ComprehensionExpr(
    iterVar: iterVar,
    iterRange: iterRange,
    accuVar: '__result__',
    accuInit: IntLiteralExpr(0),
    loopCondition: CallExpr(
        function: '_<=_', args: [IdentExpr('__result__'), IntLiteralExpr(1)]),
    loopStep: CallExpr(function: '_?_:_', args: [
      condition,
      CallExpr(
          function: '_+_', args: [IdentExpr('__result__'), IntLiteralExpr(1)]),
      IdentExpr('__result__')
    ]),
    result: CallExpr(
        function: '_==_', args: [IdentExpr('__result__'), IntLiteralExpr(1)]),
  );
}

// Expand .filter(x, condition) to a comprehension that returns a list of elements that satisfy the condition
Expr _expandFilterMacro(Expr iterRange, String iterVar, Expr condition) {
  return ComprehensionExpr(
    iterVar: iterVar,
    iterRange: iterRange,
    accuVar: '__result__',
    accuInit: ListExpr([]),
    loopCondition: BoolLiteralExpr(true),
    loopStep: CallExpr(function: '_?_:_', args: [
      condition,
      CallExpr(function: '_+_', args: [
        IdentExpr('__result__'),
        ListExpr([IdentExpr(iterVar)])
      ]),
      IdentExpr('__result__')
    ]),
    result: IdentExpr('__result__'),
  );
}

// Expand .map(x, expr) to a comprehension that returns a list of transformed elements
Expr _expandMapMacro(Expr iterRange, String iterVar, Expr mapExpr) {
  return ComprehensionExpr(
    iterVar: iterVar,
    iterRange: iterRange,
    accuVar: '__result__',
    accuInit: ListExpr([]),
    loopCondition: BoolLiteralExpr(true),
    loopStep: CallExpr(function: '_+_', args: [
      IdentExpr('__result__'),
      ListExpr([mapExpr])
    ]),
    result: IdentExpr('__result__'),
  );
}

Expr visitSelect(SelectContext tree) {
  final operand = visit(tree.member()!);
  final id = getIdentifierText(tree.id!);
  return SelectExpr(field: id, operand: operand);
}

Expr visitRelation(RelationContext tree) {
  final op = findOperator(tree.op!.text!);
  return CallExpr(
      function: op, args: [visit(tree.relation(0)!), visit(tree.relation(1)!)]);
}

Expr visitString(StringContext tree) {
  try {
    return StringLiteralExpr(unescape(tree.text, false));
  } catch (e) {
    // Fallback to simple unquote for backward compatibility
    return StringLiteralExpr(unquote(tree.text));
  }
}

// Based on
// https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/parser.go#L950.
// It unwraps the "concrete" ParseTree. For example, a Member rule is wrapped
// by an empty Unary, which is wrapped by an empty Relation (with no
// operator).
ParseTree unnest(ParseTree t) {
  if (t is ExprContext) {
    return t.op != null
        ? t // conditionalOr op='?' conditionalOr : expr
        : unnest(t.e!); // conditionalOr
  }
  if (t is ConditionalOrContext) {
    return t.ops.isNotEmpty
        ? t // conditionalAnd (ops=|| conditionalAnd)*
        : unnest(t.e!); // conditionalAnd
  }
  if (t is ConditionalAndContext) {
    return t.ops.isNotEmpty
        ? t // relation (ops=&& relation)*
        : unnest(t.e!); // relation
  }
  if (t is RelationContext) {
    return t.op != null
        ? t // relation op relation
        : unnest(t.calc()!); // calc
  }
  if (t is CalcContext) {
    return t.op != null
        ? t // calc op calc
        : unnest(t.unary()!); // unary
  }
  if (t is MemberExprContext) {
    return unnest(t.member()!);
  }
  if (t is PrimaryExprContext) {
    return unnest(t.primary()!);
  }
  if (t is NestedContext) {
    return unnest(t.e!);
  }
  if (t is ConstantLiteralContext) {
    return unnest(t.literal()!);
  }
  // TODO: port the remaining types.
  return t;
}

// Based on
// https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/parser.go#L652.
Expr visitIdentOrGlobalCall(IdentOrGlobalCallContext tree) {
  final name = '${tree.leadingDot?.text ?? ''}${tree.id!.text!}';
  if (tree.op != null) {
    final args = tree.args!.e.map((e) => visit(e)).toList();

    // Handle has() macro expansion
    if (name == 'has' && args.length == 1) {
      final arg = args[0];
      if (arg is SelectExpr) {
        // has(msg.field) -> PresenceTestExpr
        return PresenceTestExpr(operand: arg.operand, field: arg.field);
      }
      // Invalid argument to has() macro - fall through to regular function call
      // The error will be handled at runtime
    }

    return CallExpr(function: name, args: args);
  }
  // TODO: Check for reserved identifiers and throw errors.

  return IdentExpr(name);
}

// Based on cel-go visitCreateMessage implementation
// https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/parser.go#L620-L635
Expr visitCreateMessage(CreateMessageContext tree) {
  String messageName = '';
  for (final id in tree.ids) {
    if (messageName.isNotEmpty) {
      messageName += '.';
    }
    messageName += id.text!;
  }
  if (tree.leadingDot != null) {
    messageName = '.' + messageName;
  }

  final entries = tree.entries != null
      ? visitFieldInitializerList(tree.entries!)
      : <CreateStructEntry>[];

  return MessageExpr(typeName: messageName, entries: entries);
}

// Helper method to visit field initializer list similar to cel-go
// Based on VisitIFieldInitializerList from cel-go parser
List<CreateStructEntry> visitFieldInitializerList(
    FieldInitializerListContext ctx) {
  final result = <CreateStructEntry>[];
  final cols = ctx.cols;
  final vals = ctx.values;
  final fields = ctx.fields;

  for (int i = 0; i < fields.length; i++) {
    if (i >= cols.length || i >= vals.length) {
      // This is the result of a syntax error detected elsewhere
      return <CreateStructEntry>[];
    }

    final field = fields[i];
    // Handle both regular and escaped identifiers
    final fieldName = field.escapeIdent() != null
        ? getIdentifierText(field.escapeIdent()!)
        : null;
    if (fieldName == null) {
      continue; // Skip if no field name
    }
    final value = visit(vals[i]);

    // Create a field entry - key is the field name as a string literal
    result.add(CreateStructEntry(StringLiteralExpr(fieldName), value));
  }

  return result;
}

String findOperator(String operator) => Operators.operators[operator]!.name;

// Helper to extract the text from an identifier (regular or escaped)
String getIdentifierText(ParseTree idContext) {
  if (idContext is SimpleIdentifierContext) {
    return idContext.id!.text!;
  } else if (idContext is EscapedIdentifierContext) {
    // Remove backticks and return the inner text
    final text = idContext.id!.text!;
    return text.substring(1, text.length - 1);
  }
  // Fallback for backward compatibility
  return idContext.text!;
}

Expr visitSimpleIdentifier(SimpleIdentifierContext tree) {
  return StringLiteralExpr(tree.id!.text!);
}

Expr visitEscapedIdentifier(EscapedIdentifierContext tree) {
  // Remove backticks from escaped identifier
  final text = tree.id!.text!;
  return StringLiteralExpr(text.substring(1, text.length - 1));
}

// TODO: implement unescape in the unquote. See
// https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/parser.go#L843.
String unquote(String text) => text.substring(1, text.length - 1);
