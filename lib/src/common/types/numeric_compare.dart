import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/int.dart';

/// Helper for cross-type numeric comparisons
class NumericCompare {
  static Value compare(Value left, Value right) {
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
    if (value.type.name == 'int' || value.type.name == 'uint') {
      return value.value as int;
    } else if (value.type.name == 'double') {
      return value.value as double;
    }
    throw Exception('Not a numeric type: ${value.type.name}');
  }
  
  static bool equals(Value left, Value right) {
    // Handle cross-type numeric equality
    if (_isNumeric(left) && _isNumeric(right)) {
      final leftNum = _getNumericValue(left);
      final rightNum = _getNumericValue(right);
      return leftNum == rightNum;
    }
    
    // For non-numeric types, use standard equality
    return left.value == right.value;
  }
  
  static bool _isNumeric(Value value) {
    return value.type.name == 'int' || 
           value.type.name == 'uint' || 
           value.type.name == 'double';
  }
}