import 'package:cel/src/common/types/bool.dart';
import 'package:cel/src/common/types/traits/receiver.dart';
import 'package:cel/src/common/types/numeric_compare.dart';
import 'package:cel/src/common/types/error.dart';

import '../common/types/ref/provider.dart';
import '../common/types/ref/value.dart';
import 'activation.dart';
import 'attribute.dart';
import 'functions/functions.dart';

abstract class Interpretable {
  Value evaluate(Activation activation);
}

class InterpretableConst implements Interpretable {
  InterpretableConst(this.value);

  final Value value;

  @override
  evaluate(Activation activation) {
    return value;
  }
}

// Port of https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/interpretable.go#L1219.
class AttributeValueInterpretable implements Interpretable {
  AttributeValueInterpretable(this.attribute, this.typeAdapter);

  final Attribute attribute;
  final TypeAdapter typeAdapter;

  @override
  evaluate(Activation activation) {
    return typeAdapter.nativeToValue(attribute.resolve(activation));
  }

  void addQualifier(Qualifier qualifier) {
    attribute.addQualifier(qualifier);
  }
}

class EqualInterpretable implements Interpretable {
  EqualInterpretable(this.leftHandSide, this.rightHandSide);

  final Interpretable leftHandSide;
  final Interpretable rightHandSide;

  @override
  evaluate(Activation activation) {
    final left = leftHandSide.evaluate(activation);
    final right = rightHandSide.evaluate(activation);
    return BooleanValue(NumericCompare.equals(left, right));
  }
}

class NotEqualInterpretable implements Interpretable {
  NotEqualInterpretable(this.leftHandSide, this.rightHandSide);

  final Interpretable leftHandSide;
  final Interpretable rightHandSide;

  @override
  evaluate(Activation activation) {
    final left = leftHandSide.evaluate(activation);
    final right = rightHandSide.evaluate(activation);
    return BooleanValue(!NumericCompare.equals(left, right));
  }
}

class LogicalAndInterpretable implements Interpretable {
  LogicalAndInterpretable(this.leftHandSide, this.rightHandSide);

  final Interpretable leftHandSide;
  final Interpretable rightHandSide;

  @override
  evaluate(Activation activation) {
    final left = leftHandSide.evaluate(activation);
    if (isError(left)) return left;
    if (left is! BooleanValue) {
      return ErrorValue('AND operator requires boolean operands, got ${left.type.name}');
    }
    
    // Short-circuit evaluation: if left is false, don't evaluate right
    if (!left.value) {
      return BooleanValue(false);
    }
    
    final right = rightHandSide.evaluate(activation);
    if (isError(right)) return right;
    if (right is! BooleanValue) {
      return ErrorValue('AND operator requires boolean operands, got ${right.type.name}');
    }
    
    return BooleanValue(right.value);
  }
}

class LogicalOrInterpretable implements Interpretable {
  LogicalOrInterpretable(this.leftHandSide, this.rightHandSide);

  final Interpretable leftHandSide;
  final Interpretable rightHandSide;

  @override
  evaluate(Activation activation) {
    final left = leftHandSide.evaluate(activation);
    if (isError(left)) return left;
    if (left is! BooleanValue) {
      return ErrorValue('OR operator requires boolean operands, got ${left.type.name}');
    }
    
    // Short-circuit evaluation: if left is true, don't evaluate right
    if (left.value) {
      return BooleanValue(true);
    }
    
    final right = rightHandSide.evaluate(activation);
    if (isError(right)) return right;
    if (right is! BooleanValue) {
      return ErrorValue('OR operator requires boolean operands, got ${right.type.name}');
    }
    
    return BooleanValue(right.value);
  }
}

class UnaryInterpretable implements Interpretable {
  UnaryInterpretable(this.unaryOperator, this.value);

  final UnaryOperator unaryOperator;
  final Interpretable value;

  // https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/interpretable.go#L439
  @override
  evaluate(Activation activation) {
    // Skipped porting Traits.
    return unaryOperator(value.evaluate(activation));
  }
}

class BinaryInterpretable implements Interpretable {
  BinaryInterpretable(this.functionName, this.binaryOperator, this.leftHandSide,
      this.rightHandSide);

  final String functionName;
  final BinaryOperator? binaryOperator;
  final Interpretable leftHandSide;
  final Interpretable rightHandSide;

  // https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/interpretable.go#L499
  @override
  evaluate(Activation activation) {
    final leftValue = leftHandSide.evaluate(activation);
    final rightValue = rightHandSide.evaluate(activation);
    assert(binaryOperator != null || leftValue is Receiver);
    return binaryOperator != null
        ? binaryOperator!(leftValue, rightValue)
        : (leftValue as Receiver).receive(functionName, '', [rightValue]);
  }
}

class ListInterpretable implements Interpretable {
  ListInterpretable(this.elements, this.adapter);

  final List<Interpretable> elements;
  final TypeAdapter adapter;

  @override
  evaluate(Activation activation) {
    final native = elements.map((e) => e.evaluate(activation)).toList();
    return adapter.nativeToValue(native);
  }
}

// https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/interpretable.go#L669
class MapInterpretable implements Interpretable {
  MapInterpretable(this.keys, this.values, this.adapter);

  final List<Interpretable> keys;
  final List<Interpretable> values;
  final TypeAdapter adapter;

  @override
  evaluate(Activation activation) {
    final map = Map.fromIterables(keys.map((k) => k.evaluate(activation)),
        values.map((v) => v.evaluate(activation)));
    return adapter.nativeToValue(map);
  }
}
