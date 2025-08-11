import 'package:fixnum/fixnum.dart';
import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/int.dart';
import 'package:cel/src/common/types/error.dart';

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
        !['int', 'uint', 'double', 'bool', 'string', 'bytes', 'list', 'map', 'null', 'duration', 'timestamp'].contains(leftTypeName)) {
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
    // Compare byte values directly
    return left.value == right.value;
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
    
    for (final key in leftMap.keys) {
      if (!rightMap.containsKey(key)) {
        return false;
      }
      
      final leftVal = leftMap[key] is Value ? leftMap[key] : IntValue(leftMap[key]);
      final rightVal = rightMap[key] is Value ? rightMap[key] : IntValue(rightMap[key]);
      if (!equals(leftVal, rightVal)) {
        return false;
      }
    }
    return true;
  }
}