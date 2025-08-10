import 'dart:typed_data';
import 'package:cel/src/common/types/bool.dart';
import 'package:cel/src/common/types/traits/receiver.dart';
import 'package:cel/src/common/types/numeric_compare.dart';
import 'package:cel/src/common/types/error.dart';
import 'package:cel/src/common/types/int.dart';
import 'package:cel/src/common/types/uint.dart';
import 'package:cel/src/common/types/double.dart';
import 'package:cel/src/common/types/string.dart';
import 'package:cel/src/common/types/bytes.dart';
import 'package:cel/src/common/types/null_.dart';

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

class FunctionInterpretable implements Interpretable {
  FunctionInterpretable(this.functionOperator, this.arguments);

  final FunctionOperator functionOperator;
  final List<Interpretable> arguments;

  @override
  evaluate(Activation activation) {
    final evaluatedArgs = arguments.map((arg) => arg.evaluate(activation)).toList();
    return functionOperator(evaluatedArgs);
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

// Interpretable for creating protobuf messages
// For now, creates a map with a special type name field to distinguish from regular maps
class MessageInterpretable implements Interpretable {
  MessageInterpretable(this.typeName, this.keys, this.values, this.adapter);

  final String typeName;
  final List<Interpretable> keys;
  final List<Interpretable> values;
  final TypeAdapter adapter;

  @override
  evaluate(Activation activation) {
    // Check if this is a wrapper type that should auto-unwrap
    if (_isWrapperType(typeName)) {
      // For wrapper types, evaluate and return the wrapped value directly
      if (keys.isNotEmpty && values.isNotEmpty) {
        final key = keys[0].evaluate(activation);
        if (key is StringValue && key.value == 'value') {
          // Return the wrapped value directly, not the wrapper message
          return values[0].evaluate(activation);
        }
      }
      // Empty wrapper returns default value
      return _getWrapperDefaultValue(typeName);
    }
    
    // For regular messages, create a map representation
    final evaluatedKeys = keys.map((k) => k.evaluate(activation)).toList();
    final evaluatedValues = values.map((v) => v.evaluate(activation)).toList();
    
    final map = <Value, Value>{};
    for (int i = 0; i < evaluatedKeys.length; i++) {
      map[evaluatedKeys[i]] = evaluatedValues[i];
    }
    
    // Add type information for later message reconstruction
    map[adapter.nativeToValue('__message_type__')] = adapter.nativeToValue(typeName);
    return adapter.nativeToValue(map);
  }
  
  bool _isWrapperType(String typeName) {
    return typeName == 'google.protobuf.Int32Value' ||
           typeName == 'google.protobuf.Int64Value' ||
           typeName == 'google.protobuf.UInt32Value' ||
           typeName == 'google.protobuf.UInt64Value' ||
           typeName == 'google.protobuf.FloatValue' ||
           typeName == 'google.protobuf.DoubleValue' ||
           typeName == 'google.protobuf.BoolValue' ||
           typeName == 'google.protobuf.StringValue' ||
           typeName == 'google.protobuf.BytesValue';
  }
  
  Value _getWrapperDefaultValue(String typeName) {
    switch (typeName) {
      case 'google.protobuf.Int32Value':
      case 'google.protobuf.Int64Value':
        return IntValue(0);
      case 'google.protobuf.UInt32Value':  
      case 'google.protobuf.UInt64Value':
        return UintValue(0);
      case 'google.protobuf.FloatValue':
      case 'google.protobuf.DoubleValue':
        return DoubleValue(0.0);
      case 'google.protobuf.BoolValue':
        return BooleanValue(false);
      case 'google.protobuf.StringValue':
        return StringValue('');
      case 'google.protobuf.BytesValue':
        return BytesValue(Uint8List(0));
      default:
        return NullValue();
    }
  }
}
