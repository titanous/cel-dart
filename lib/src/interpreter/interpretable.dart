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
import 'package:cel/src/common/types/list.dart';
import 'package:cel/src/common/types/map.dart';
import 'package:cel/src/common/types/pb/message.dart';
import 'package:cel/src/common/types/provider.dart';
import 'package:protobuf/protobuf.dart' show GeneratedMessage;

import '../common/types/ref/provider.dart';
import '../common/types/ref/value.dart' show Value;
import 'activation.dart';
import 'dispatcher.dart';
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

class ErrorInterpretable implements Interpretable {
  ErrorInterpretable(this.errorMessage, [this.cause]);

  final String errorMessage;
  final Object? cause;

  @override
  evaluate(Activation activation) {
    return ErrorValue(errorMessage, cause);
  }
}

// Port of https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/interpretable.go#L1219.
class AttributeValueInterpretable implements Interpretable {
  AttributeValueInterpretable(this.attribute, this.typeAdapter);

  final Attribute attribute;
  final TypeAdapter typeAdapter;

  @override
  evaluate(Activation activation) {
    final result = attribute.resolve(activation);
    // If result is already a Value, don't convert again
    if (result is Value) {
      return result;
    }
    return typeAdapter.nativeToValue(result);
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
    if (isError(left)) {
      return left;
    }
    final right = rightHandSide.evaluate(activation);
    if (isError(right)) {
      return right;
    }
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
    if (isError(left)) {
      return left;
    }
    final right = rightHandSide.evaluate(activation);
    if (isError(right)) {
      return right;
    }
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

    // Check if left is a boolean false (short-circuit)
    if (left is BooleanValue && !left.value) {
      return BooleanValue(false);
    }

    // Evaluate right side
    final right = rightHandSide.evaluate(activation);

    // If right is false, return false regardless of left
    if (right is BooleanValue && !right.value) {
      return BooleanValue(false);
    }

    // Both sides have been evaluated, now handle non-boolean cases

    // Collect error if left is not a boolean
    Value? err;
    if (left is! BooleanValue) {
      if (isError(left)) {
        err = left;
      } else {
        err = ErrorValue('no matching overload');
      }
    }

    // If right is not a boolean and we don't have an error yet, use right's error
    if (right is! BooleanValue && err == null) {
      if (isError(right)) {
        err = right;
      } else {
        err = ErrorValue('no matching overload');
      }
    }

    // If we have an error, return it
    if (err != null) {
      return err;
    }

    // Both are true booleans
    return BooleanValue(true);
  }
}

class LogicalOrInterpretable implements Interpretable {
  LogicalOrInterpretable(this.leftHandSide, this.rightHandSide);

  final Interpretable leftHandSide;
  final Interpretable rightHandSide;

  @override
  evaluate(Activation activation) {
    final left = leftHandSide.evaluate(activation);

    // Check if left is a boolean true (short-circuit)
    if (left is BooleanValue && left.value) {
      return BooleanValue(true);
    }

    // Evaluate right side
    final right = rightHandSide.evaluate(activation);

    // If right is true, return true regardless of left
    if (right is BooleanValue && right.value) {
      return BooleanValue(true);
    }

    // Both sides have been evaluated, now handle non-boolean cases

    // Collect error if left is not a boolean
    Value? err;
    if (left is! BooleanValue) {
      if (isError(left)) {
        err = left;
      } else {
        err = ErrorValue('no matching overload');
      }
    }

    // If right is not a boolean and we don't have an error yet, use right's error
    if (right is! BooleanValue && err == null) {
      if (isError(right)) {
        err = right;
      } else {
        err = ErrorValue('no matching overload');
      }
    }

    // If we have an error, return it
    if (err != null) {
      return err;
    }

    // Both are false booleans
    return BooleanValue(false);
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

    if (binaryOperator != null) {
      return binaryOperator!(leftValue, rightValue);
    }

    // Only use receiver pattern if the left value implements Receiver
    if (leftValue is Receiver) {
      return (leftValue as Receiver).receive(functionName, '', [rightValue]);
    }

    // If no binary operator and left value is not a receiver, return error
    return ErrorValue(
        'No implementation found for function: $functionName on ${leftValue.runtimeType}');
  }
}

/// Type-aware binary interpretable that dispatches based on argument types (CEL-ES style)
class TypeAwareBinaryInterpretable implements Interpretable {
  TypeAwareBinaryInterpretable(this.functionName, this.dispatcher,
      this.leftHandSide, this.rightHandSide);

  final String functionName;
  final Dispatcher dispatcher;
  final Interpretable leftHandSide;
  final Interpretable rightHandSide;

  @override
  evaluate(Activation activation) {
    final leftValue = leftHandSide.evaluate(activation);
    final rightValue = rightHandSide.evaluate(activation);

    // Try to find the best overload based on argument types
    final overload =
        dispatcher.findOverloadByTypes(functionName, [leftValue, rightValue]);

    if (overload == null) {
      return ErrorValue('No overload found for function: $functionName with ${[
        leftValue,
        rightValue
      ].map((v) => v.runtimeType).join(', ')}');
    }

    // If it's a binary operator, call it directly
    if (overload.binaryOperator != null) {
      return overload.binaryOperator!(leftValue, rightValue);
    }

    // If it's a function operator, call it with arguments
    if (overload.functionOperator != null) {
      return overload.functionOperator!([leftValue, rightValue]);
    }

    // Fall back to receiver pattern if the left value implements Receiver
    if (leftValue is Receiver) {
      return (leftValue as Receiver).receive(functionName, '', [rightValue]);
    }

    return ErrorValue(
        'No suitable implementation found for function: $functionName');
  }
}

class FunctionInterpretable implements Interpretable {
  FunctionInterpretable(this.functionOperator, this.arguments);

  final FunctionOperator functionOperator;
  final List<Interpretable> arguments;

  @override
  evaluate(Activation activation) {
    final evaluatedArgs =
        arguments.map((arg) => arg.evaluate(activation)).toList();
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
    final evaluatedKeys = <Value>[];
    final evaluatedValues = <Value>[];

    for (int i = 0; i < keys.length; i++) {
      final key = keys[i].evaluate(activation);
      final value = values[i].evaluate(activation);

      // Check for unsupported key types
      if (key is NullValue) {
        return ErrorValue('unsupported key type');
      }
      if (key is DoubleValue) {
        // Float keys are not allowed in CEL maps
        return ErrorValue('unsupported key type');
      }

      // Simple duplicate key check - check if we've seen this exact key
      for (int j = 0; j < evaluatedKeys.length; j++) {
        final existing = evaluatedKeys[j];
        // Check for duplicate by comparing native values
        if (_areKeysEqual(existing, key)) {
          return ErrorValue('Failed with repeated key');
        }
      }

      evaluatedKeys.add(key);
      evaluatedValues.add(value);
    }

    final map = Map.fromIterables(evaluatedKeys, evaluatedValues);
    return adapter.nativeToValue(map);
  }

  // Check if two keys are equal for map purposes
  bool _areKeysEqual(Value k1, Value k2) {
    // Handle cross-type equality for int/uint only (1 == 1u)
    // Note: doubles use exact equality, no cross-type comparison
    if ((k1 is IntValue || k1 is UintValue) &&
        (k2 is IntValue || k2 is UintValue)) {
      // Compare integer values
      final v1 = k1 is IntValue ? k1.value : (k1 as UintValue).value.toInt();
      final v2 = k2 is IntValue ? k2.value : (k2 as UintValue).value.toInt();
      return v1 == v2;
    }

    // For other types, use native value comparison
    try {
      return k1.convertToNative() == k2.convertToNative();
    } catch (_) {
      return false;
    }
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
      // Handle complex wrapper types (ListValue, Struct)
      if (typeName == 'google.protobuf.ListValue') {
        if (keys.isNotEmpty && values.isNotEmpty) {
          final key = keys[0].evaluate(activation);
          if (key is StringValue && key.value == 'values') {
            // Return the list values directly as a native CEL list
            return values[0].evaluate(activation);
          }
        }
        // Empty ListValue returns empty list
        return adapter.nativeToValue([]);
      } else if (typeName == 'google.protobuf.Struct') {
        if (keys.isNotEmpty && values.isNotEmpty) {
          final key = keys[0].evaluate(activation);
          if (key is StringValue && key.value == 'fields') {
            // Return the struct fields directly as a native CEL map
            return values[0].evaluate(activation);
          }
        }
        // Empty Struct returns empty map
        return adapter.nativeToValue({});
      } else {
        // Handle primitive wrapper types (Int32Value, StringValue, etc.)
        if (keys.isNotEmpty && values.isNotEmpty) {
          final key = keys[0].evaluate(activation);
          if (key is StringValue && key.value == 'value') {
            // For FloatValue, we need to create the actual protobuf message 
            // so it can be auto-unwrapped with proper float32 precision
            if (typeName == 'google.protobuf.FloatValue') {
              // Create the actual FloatValue protobuf message
              final value = values[0].evaluate(activation);
              final nativeValue = _convertToNativeValue(value);
              
              // Create the protobuf message through the TypeRegistry
              if (adapter is TypeRegistry) {
                final typeRegistry = adapter as TypeRegistry;
                final result = typeRegistry.createMessage(typeName, {'value': nativeValue});
                if (result != null) {
                  // The result might already be auto-unwrapped if it's a Value type
                  if (result is Value) {
                    return result;
                  } else if (result is MessageValue) {
                    // Now auto-unwrap through the provider's _nativeToValue function
                    return adapter.nativeToValue(result.message);
                  }
                }
              }
            }
            
            // For other wrapper types, return the wrapped value directly
            return values[0].evaluate(activation);
          }
        }
        // Empty wrapper returns default value
        return _getWrapperDefaultValue(typeName);
      }
    }

    // For regular messages, try to create a real protobuf message
    final evaluatedKeys = keys.map((k) => k.evaluate(activation)).toList();
    final evaluatedValues = values.map((v) => v.evaluate(activation)).toList();

    // Convert CEL values to native values for the message fields
    final fieldMap = <String, dynamic>{};
    for (int i = 0; i < evaluatedKeys.length; i++) {
      final key = evaluatedKeys[i];
      final value = evaluatedValues[i];

      if (key is StringValue) {
        // Convert CEL value to native value for the field
        fieldMap[key.value] = _convertToNativeValue(value);
      }
    }

    // Try to create a real protobuf message if we have a TypeRegistry with ProtoTypeRegistry
    if (adapter is TypeRegistry) {
      final typeRegistry = adapter as TypeRegistry;

      // Try to resolve the type name using the proto registry
      // The proto registry should handle namespace resolution
      final result = typeRegistry.createMessage(typeName, fieldMap);
      if (result is ErrorValue) {
        // Range validation or other error occurred
        return result;
      } else if (result != null) {
        // Check if result is a GeneratedMessage (normal case) or auto-unwrapped CEL Value
        if (result is GeneratedMessage) {
          // Result is a GeneratedMessage, wrap it in a MessageValue
          return MessageValue(result, adapter);
        } else if (result is Value) {
          // Result is an auto-unwrapped CEL Value, return it directly
          return result;
        } else {
          // Result is some other native value, convert to CEL Value
          final celValue = adapter.nativeToValue(result);
          return celValue;
        }
      }
    }

    // Fallback: create a map representation with type information
    final map = <Value, Value>{};
    for (int i = 0; i < evaluatedKeys.length; i++) {
      map[evaluatedKeys[i]] = evaluatedValues[i];
    }

    // Add type information for later message reconstruction
    map[adapter.nativeToValue('__message_type__')] =
        adapter.nativeToValue(typeName);
    return adapter.nativeToValue(map);
  }

  // Convert a CEL Value to its native Dart representation
  dynamic _convertToNativeValue(Value value) {
    if (value is BooleanValue) return value.value;
    if (value is IntValue) return value.value;
    if (value is UintValue) return value.value;
    if (value is DoubleValue) return value.value;
    if (value is StringValue) return value.value;
    if (value is BytesValue) return value.value;
    if (value is NullValue) return null;
    if (value is ListValue) {
      return value.value.map((v) => _convertToNativeValue(v)).toList();
    }
    if (value is MapValue) {
      final result = <String, dynamic>{};
      value.value.forEach((k, v) {
        if (k is StringValue) {
          result[k.value] = _convertToNativeValue(v);
        }
      });
      return result;
    }
    if (value is MessageValue) {
      return value.message;
    }
    // For other types, return the value itself
    return value;
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
        typeName == 'google.protobuf.BytesValue' ||
        typeName == 'google.protobuf.ListValue' ||
        typeName == 'google.protobuf.Struct';
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
      case 'google.protobuf.ListValue':
        return adapter.nativeToValue([]);
      case 'google.protobuf.Struct':
        return adapter.nativeToValue({});
      default:
        return NullValue();
    }
  }
}

// ComprehensionInterpretable handles comprehension expressions (.all(), .exists(), etc.)
// Based on EvalFold from cel-es implementation
class ComprehensionInterpretable implements Interpretable {
  ComprehensionInterpretable(this.accuVar, this.iterVar, this.iterRange,
      this.accuInit, this.loopCondition, this.loopStep, this.result,
      [this.iterVar2]);

  final String accuVar;
  final String iterVar;
  final Interpretable iterRange;
  final Interpretable accuInit;
  final Interpretable loopCondition;
  final Interpretable loopStep;
  final Interpretable result;
  final String? iterVar2; // For future map comprehensions

  @override
  evaluate(Activation activation) {
    // Initialize accumulator
    final accuInitValue = accuInit.evaluate(activation);
    if (isError(accuInitValue)) {
      return accuInitValue;
    }

    // Create accumulator activation context
    var accuCtx = activation.extend(accuVar, accuInitValue);

    // Evaluate the iteration range
    final iterRangeValue = iterRange.evaluate(activation);
    if (isError(iterRangeValue)) {
      return iterRangeValue;
    }

    // Get items to iterate over
    List<Value> items = [];
    if (iterRangeValue is MapValue) {
      // For maps, iterate over keys
      items = iterRangeValue.value.keys.toList();
    } else if (iterRangeValue is ListValue) {
      // For lists, iterate over elements
      items = iterRangeValue.value;
    } else {
      return ErrorValue(
          'type mismatch: iterable vs ${iterRangeValue.runtimeType}');
    }

    // Fold/iterate over the items
    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      if (isError(item)) {
        return item;
      }

      // Create iteration context with both accumulator and item
      final iterCtx = accuCtx.extend(iterVar, item);

      // Check loop condition
      final condValue = loopCondition.evaluate(iterCtx);
      if (isError(condValue)) {
        return condValue;
      }

      // If condition is not true, break the loop
      bool shouldBreak = false;
      if (condValue is BooleanValue) {
        shouldBreak = !condValue.value;
      } else if (condValue is bool) {
        shouldBreak = !(condValue as bool);
      } else if (condValue == false) {
        shouldBreak = true;
      }
      
      if (shouldBreak) {
        break;
      }

      // Update accumulator
      final stepValue = loopStep.evaluate(iterCtx);
      if (isError(stepValue)) {
        return stepValue;
      }

      // Update accumulator context with new value
      accuCtx = accuCtx.extend(accuVar, stepValue);
    }

    // Compute and return the result
    return result.evaluate(accuCtx);
  }
}
