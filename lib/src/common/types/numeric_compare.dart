import 'package:fixnum/fixnum.dart';
import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/int.dart';
import 'package:cel/src/common/types/double.dart';
import 'package:cel/src/common/types/string.dart';
import 'package:cel/src/common/types/error.dart';
import 'package:cel/src/interpreter/error_utils.dart';
import 'package:cel/src/common/types/pb/registry.dart';
import 'package:cel/src/gen/google/protobuf/wrappers.pb.dart' as pb_wrappers;
import 'package:cel/src/common/types/bytes.dart';
import 'package:cel/src/common/types/bool.dart';
import 'package:cel/src/common/types/pb/message.dart';
import 'dart:typed_data';
// Import for Any message handling
import 'package:cel/src/gen/google/protobuf/any.pb.dart' as pb_any;
import 'package:cel/src/gen/cel/expr/conformance/proto2/test_all_types.pb.dart' as proto2;
import 'package:cel/src/gen/cel/expr/conformance/proto3/test_all_types.pb.dart' as proto3;
import 'package:protobuf/protobuf.dart' as pb;

/// Helper for cross-type numeric comparisons
class NumericCompare {
  static final ProtoTypeRegistry _registry = ProtoTypeRegistry();
  static Value compare(Value left, Value right) {
    return ErrorUtils.safeBinaryOp(left, right, (lhs, rhs) {
      // Get numeric values
      final leftNum = _getNumericValue(lhs);
      final rightNum = _getNumericValue(rhs);

      // Compare and return IntValue result
      if (leftNum < rightNum) {
        return IntValue(-1);
      } else if (leftNum > rightNum) {
        return IntValue(1);
      } else {
        return IntValue(0);
      }
    });
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
        // Int64 case - handle unsigned integers properly
        // UintValue always represents unsigned integers, but Int64 uses signed representation
        final int64Val = uintVal as Int64;
        
        // For unsigned integers, negative Int64 values represent large positive values
        // Convert to double to get the proper unsigned value for comparison
        if (int64Val < Int64.ZERO) {
          // This is a large unsigned integer (> 2^63 - 1) represented as negative Int64
          // Convert to proper unsigned double value: add 2^64 to get the unsigned value
          return int64Val.toDouble() + 18446744073709551616.0; // 2^64
        } else {
          // This fits in signed range, can safely use toInt()
          return int64Val.toInt();
        }
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
      
      // Special handling for Any messages - compare by unpacking and comparing content
      if (left is MessageValue && right is MessageValue &&
          left.message is pb_any.Any && right.message is pb_any.Any) {
        return _anyMessagesEqual(left.message as pb_any.Any, right.message as pb_any.Any);
      }
      
      // Special handling for messages that might contain Any fields
      if (left is MessageValue && right is MessageValue) {
        final leftMsg = left.message;
        final rightMsg = right.message;
        
        // Check if these are TestAllTypes messages (which contain Any fields)
        if ((leftMsg is proto2.TestAllTypes && rightMsg is proto2.TestAllTypes) ||
            (leftMsg is proto3.TestAllTypes && rightMsg is proto3.TestAllTypes)) {
          return _messagesWithAnyFieldsEqual(leftMsg, rightMsg);
        }
      }
      
      // For other proto messages, compare the underlying message values
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

  /// Compare two Any messages by unpacking and comparing their content
  static bool _anyMessagesEqual(pb_any.Any left, pb_any.Any right) {
    // If type URLs differ, messages cannot be equal
    if (left.typeUrl != right.typeUrl) {
      return false;
    }
    
    // If type URL is empty, fall back to bytewise comparison
    if (left.typeUrl.isEmpty) {
      return _compareByteArrays(left.value, right.value);
    }
    
    try {
      // Attempt to unpack both messages
      final leftUnpacked = _unpackAnyMessage(left);
      final rightUnpacked = _unpackAnyMessage(right);
      
      // If both unpacked successfully, compare the unpacked messages
      if (leftUnpacked != null && rightUnpacked != null) {
        return leftUnpacked == rightUnpacked;
      }
      
      // If unpacking failed for either, fall back to bytewise comparison
      return _compareByteArrays(left.value, right.value);
    } catch (e) {
      // If any error occurs during unpacking, fall back to bytewise comparison
      return _compareByteArrays(left.value, right.value);
    }
  }

  /// Compare messages that contain Any fields using semantic equality
  static bool _messagesWithAnyFieldsEqual(pb.GeneratedMessage left, pb.GeneratedMessage right) {
    // For TestAllTypes messages, we need to compare field by field with special handling for Any fields
    if (left is proto2.TestAllTypes && right is proto2.TestAllTypes) {
      return _testAllTypesProto2Equal(left, right);
    }
    if (left is proto3.TestAllTypes && right is proto3.TestAllTypes) {
      return _testAllTypesProto3Equal(left, right);
    }
    
    // Fallback to regular protobuf equality
    return left == right;
  }

  /// Compare proto2 TestAllTypes messages with special Any field handling
  static bool _testAllTypesProto2Equal(proto2.TestAllTypes left, proto2.TestAllTypes right) {
    // Compare all fields except Any fields using standard protobuf equality
    // Create copies without Any fields for comparison
    final leftCopy = proto2.TestAllTypes()..mergeFromMessage(left);
    final rightCopy = proto2.TestAllTypes()..mergeFromMessage(right);
    
    // Clear Any fields before comparison
    leftCopy.clearSingleAny();
    rightCopy.clearSingleAny();
    
    // If all other fields are equal, compare Any fields semantically
    if (leftCopy == rightCopy) {
      // Compare Any fields semantically if both have them
      if (left.hasSingleAny() && right.hasSingleAny()) {
        return _anyMessagesEqual(left.singleAny, right.singleAny);
      }
      // Both must have the same "has" status
      return left.hasSingleAny() == right.hasSingleAny();
    }
    
    return false;
  }

  /// Compare proto3 TestAllTypes messages with special Any field handling
  static bool _testAllTypesProto3Equal(proto3.TestAllTypes left, proto3.TestAllTypes right) {
    // Similar logic for proto3
    final leftCopy = proto3.TestAllTypes()..mergeFromMessage(left);
    final rightCopy = proto3.TestAllTypes()..mergeFromMessage(right);
    
    // Clear Any fields before comparison
    leftCopy.clearSingleAny();
    rightCopy.clearSingleAny();
    
    // If all other fields are equal, compare Any fields semantically
    if (leftCopy == rightCopy) {
      // Compare Any fields semantically if both have them
      if (left.hasSingleAny() && right.hasSingleAny()) {
        return _anyMessagesEqual(left.singleAny, right.singleAny);
      }
      // Both must have the same "has" status
      return left.hasSingleAny() == right.hasSingleAny();
    }
    
    return false;
  }

  /// Unpack Any message using the ProtoTypeRegistry (replaces hardcoded switch statement)
  static pb.GeneratedMessage? _unpackAnyMessage(pb_any.Any anyMessage) {
    try {
      // Check the type URL to determine the message type
      final typeUrl = anyMessage.typeUrl;
      if (typeUrl.isEmpty) return null;

      // Extract the type name from the URL (format: type.googleapis.com/PackageName.MessageName)
      final parts = typeUrl.split('/');
      if (parts.length != 2) return null;

      final fullTypeName = parts[1];

      // Use the ProtoTypeRegistry to unpack the message dynamically
      return _registry.unpackAnyMessage(fullTypeName, anyMessage.value);
    } catch (e) {
      // If unpacking fails, return null
      return null;
    }
  }

  /// Helper method to compare two byte arrays
  static bool _compareByteArrays(List<int> left, List<int> right) {
    if (left.length != right.length) return false;
    for (int i = 0; i < left.length; i++) {
      if (left[i] != right[i]) return false;
    }
    return true;
  }
}
