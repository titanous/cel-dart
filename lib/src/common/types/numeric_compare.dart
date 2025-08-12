import 'package:fixnum/fixnum.dart';
import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/int.dart';
import 'package:cel/src/common/types/uint.dart';
import 'package:cel/src/common/types/double.dart';
import 'package:cel/src/common/types/string.dart';
import 'package:cel/src/common/types/error.dart';
import 'package:cel/src/gen/google/protobuf/wrappers.pb.dart' as pb_wrappers;
import 'package:cel/src/common/types/bytes.dart';
import 'package:cel/src/common/types/bool.dart';
import 'package:cel/src/common/types/pb/message.dart';
import 'dart:typed_data';

/// Helper for cross-type numeric comparisons
class NumericCompare {
  static Value compare(Value left, Value right) {
    // Check for errors first
    if (isError(left)) return left;
    if (isError(right)) return right;

    // Get numeric values
    final leftNum = _getNumericValue(left);
    final rightNum = _getNumericValue(right);

    // Compare and return IntValue result
    if (leftNum < rightNum) {
      return IntValue(-1);
    } else if (leftNum > rightNum) {
      return IntValue(1);
    } else {
      return IntValue(0);
    }
  }

  static num _getNumericValue(Value value) {
    if (value.type.name == 'int') {
      return value.value as int;
    } else if (value.type.name == 'uint') {
      // Handle both int and Int64 values in UintValue
      final uintVal = value.value;
      if (uintVal is int) {
        return uintVal;
      } else {
        // Int64 case - convert to int for comparison
        return (uintVal as Int64).toInt();
      }
    } else if (value.type.name == 'double') {
      return value.value as double;
    }
    throw Exception('Not a numeric type: ${value.type.name}');
  }

  static bool equals(Value left, Value right) {
    // Check for errors first
    if (isError(left) || isError(right)) {
      // Errors are never equal to anything
      return false;
    }

    // Unwrap protobuf wrapper types first
    left = _unwrapValue(left);
    right = _unwrapValue(right);

    // Handle cross-type numeric equality
    if (_isNumeric(left) && _isNumeric(right)) {
      final leftNum = _getNumericValue(left);
      final rightNum = _getNumericValue(right);
      return leftNum == rightNum;
    }

    // Handle list equality
    if (_isList(left) && _isList(right)) {
      return _listsEqual(left.value as List, right.value as List);
    }

    // Handle map equality
    if (_isMap(left) && _isMap(right)) {
      return _mapsEqual(left.value as Map, right.value as Map);
    }

    // Handle bytes equality
    if (_isBytes(left) && _isBytes(right)) {
      return _bytesEqual(left, right);
    }

    // For proto messages, handle specially to avoid infinite recursion
    // MessageValue types should use their underlying protobuf equality
    final leftTypeName = left.type.name;
    final rightTypeName = right.type.name;

    // Check if both are proto message types (not primitive types)
    if (leftTypeName == rightTypeName &&
        ![
          'int',
          'uint',
          'double',
          'bool',
          'string',
          'bytes',
          'list',
          'map',
          'null',
          'duration',
          'timestamp'
        ].contains(leftTypeName)) {
      // For proto messages, compare the underlying message values
      return left.value == right.value;
    }

    // For non-numeric types, use standard value equality
    return left.value == right.value;
  }

  static bool _isNumeric(Value value) {
    return value.type.name == 'int' ||
        value.type.name == 'uint' ||
        value.type.name == 'double';
  }

  static bool _isList(Value value) {
    return value.type.name == 'list';
  }

  static bool _isMap(Value value) {
    return value.type.name == 'map';
  }

  static bool _isBytes(Value value) {
    return value.type.name == 'bytes';
  }

  static bool _bytesEqual(Value left, Value right) {
    // Use the BytesValue.equal method for proper comparison
    if (left is BytesValue) {
      final result = left.equal(right);
      if (result is BooleanValue) {
        return result.value;
      }
    }
    return false;
  }

  static bool _listsEqual(List left, List right) {
    if (left.length != right.length) {
      return false;
    }

    for (var i = 0; i < left.length; i++) {
      final leftVal = left[i] is Value ? left[i] : IntValue(left[i]);
      final rightVal = right[i] is Value ? right[i] : IntValue(right[i]);
      if (!equals(leftVal, rightVal)) {
        return false;
      }
    }
    return true;
  }

  static bool _mapsEqual(Map leftMap, Map rightMap) {
    if (leftMap.length != rightMap.length) {
      return false;
    }

    // Track which right map keys we've matched to avoid duplicate matches
    final matchedRightKeys = <dynamic>{};

    for (final leftKey in leftMap.keys) {
      // Find a matching key in the right map using cross-type equality
      dynamic matchingRightKey;
      for (final rightKey in rightMap.keys) {
        if (matchedRightKeys.contains(rightKey)) {
          continue;
        }
        
        // Convert keys to Values for comparison
        final leftKeyVal = leftKey is Value ? leftKey : _convertToValue(leftKey);
        final rightKeyVal = rightKey is Value ? rightKey : _convertToValue(rightKey);
        
        // Check if keys are equal (handles cross-type numeric equality)
        if (_keysEqual(leftKeyVal, rightKeyVal)) {
          matchingRightKey = rightKey;
          break;
        }
      }
      
      if (matchingRightKey == null) {
        return false; // No matching key found
      }
      
      matchedRightKeys.add(matchingRightKey);
      
      // Compare the values for these keys
      final leftVal = leftMap[leftKey] is Value ? leftMap[leftKey] : IntValue(leftMap[leftKey]);
      final rightVal = rightMap[matchingRightKey] is Value ? rightMap[matchingRightKey] : IntValue(rightMap[matchingRightKey]);
      if (!equals(leftVal, rightVal)) {
        return false;
      }
    }
    return true;
  }
  
  // Helper to convert primitive keys to Value types
  static Value _convertToValue(dynamic key) {
    if (key is int) return IntValue(key);
    if (key is double) return DoubleValue(key);
    if (key is String) return StringValue(key);
    if (key is bool) return BooleanValue(key);
    return key;
  }
  
  // Check if two keys are equal with cross-type numeric support
  static bool _keysEqual(Value left, Value right) {
    // For numeric types, use cross-type equality
    if (_isNumeric(left) && _isNumeric(right)) {
      final leftNum = _getNumericValue(left);
      final rightNum = _getNumericValue(right);
      return leftNum == rightNum;
    }
    // For non-numeric types, use regular equality
    return equals(left, right);
  }

  static Value _unwrapValue(Value value) {
    // If value is a MessageValue containing a protobuf wrapper type, unwrap it
    if (value is MessageValue) {
      final msg = value.message;
      
      if (msg is pb_wrappers.BytesValue) {
        // Unwrap BytesValue to BytesValue CEL type
        return BytesValue(Uint8List.fromList(msg.value));
      } else if (msg is pb_wrappers.StringValue) {
        // StringValue wrapper - return as is for now
        return value;
      } else if (msg is pb_wrappers.BoolValue) {
        // BoolValue wrapper - return as is for now
        return value;
      } else if (msg is pb_wrappers.DoubleValue) {
        // DoubleValue wrapper - return as is for now
        return value;
      } else if (msg is pb_wrappers.FloatValue) {
        // FloatValue wrapper - return as is for now
        return value;
      } else if (msg is pb_wrappers.Int32Value) {
        // Int32Value wrapper - return as is for now
        return value;
      } else if (msg is pb_wrappers.Int64Value) {
        // Int64Value wrapper - return as is for now
        return value;
      } else if (msg is pb_wrappers.UInt32Value) {
        // UInt32Value wrapper - return as is for now
        return value;
      } else if (msg is pb_wrappers.UInt64Value) {
        // UInt64Value wrapper - return as is for now
        return value;
      }
    }
    
    return value;
  }
}
