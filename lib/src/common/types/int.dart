import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/traits/comparer.dart';
import 'package:cel/src/common/types/traits/math.dart';
import 'package:cel/src/common/types/numeric_compare.dart';
import 'package:cel/src/common/types/error.dart';

final intType = Type_('int');

class IntValue extends Value
    implements
        Comparer,
        Adder,
        Divider,
        Multiplier,
        Subtractor,
        Modder,
        Negater {
  IntValue(this.value);

  @override
  Type_ get type => intType;

  @override
  final int value;

  // https://github.com/google/cel-go/blob/92fda7d38a37f42d4154147896cfd4ebbf8f846e/common/types/int.go#L75
  @override
  Value compare(Value other) {
    return NumericCompare.compare(this, other);
  }

  @override
  add(Value other) {
    final otherValue = other.value as int;
    
    // Check for integer overflow in addition
    // Constants for int64 range
    const int64Min = -9223372036854775808;
    const int64Max = 9223372036854775807;
    
    // Positive overflow: both positive and result would exceed max
    if (value > 0 && otherValue > 0 && value > int64Max - otherValue) {
      return intOverflowError;
    }
    
    // Negative overflow: both negative and result would go below min  
    if (value < 0 && otherValue < 0 && value < int64Min - otherValue) {
      return intOverflowError;
    }
    
    return IntValue(value + otherValue);
  }

  @override
  divide(Value denominator) {
    final denominatorValue = denominator.value as int;
    if (denominatorValue == 0) {
      return divideByZeroError;
    }
    // Check for integer overflow: MinInt64 / -1
    if (value == -9223372036854775808 && denominatorValue == -1) {
      return intOverflowError;
    }
    return IntValue(value ~/ denominatorValue);
  }

  @override
  modulo(Value denominator) {
    final denominatorValue = denominator.value as int;
    if (denominatorValue == 0) {
      return moduloByZeroError;
    }
    // Check for integer overflow: MinInt64 % -1
    if (value == -9223372036854775808 && denominatorValue == -1) {
      return intOverflowError;
    }
    
    // Implement CEL/Go modulo semantics where result has same sign as dividend
    // Go: a % b = a - (a / b) * b (using truncated division)
    final quotient = value ~/ denominatorValue;  // Truncated division
    final result = value - (quotient * denominatorValue);
    
    return IntValue(result);
  }

  @override
  multiply(Value other) {
    final otherValue = other.value as int;
    
    // Constants for int64 range  
    const int64Min = -9223372036854775808;
    const int64Max = 9223372036854775807;
    
    // Handle zero cases (no overflow possible)
    if (value == 0 || otherValue == 0) {
      return IntValue(0);
    }
    
    // Special case: INT64_MIN * -1 would overflow to +2^63 which isn't representable
    if ((value == int64Min && otherValue == -1) || 
        (otherValue == int64Min && value == -1)) {
      return intOverflowError;
    }
    
    // Check for overflow before multiplication to avoid wraparound
    final absValue = value.abs();
    final absOther = otherValue.abs();
    
    // Simple overflow check: if either operand is too large, multiplication will overflow
    if (absValue > 0 && absOther > int64Max ~/ absValue) {
      return intOverflowError;
    }
    
    final result = value * otherValue;
    return IntValue(result);
  }

  @override
  subtract(Value subtrahend) {
    final subtrahendValue = subtrahend.value as int;
    
    // Check for integer overflow in subtraction
    // Constants for int64 range
    const int64Min = -9223372036854775808;
    const int64Max = 9223372036854775807;
    
    // Positive overflow: positive - negative = positive, check if result > max
    if (value > 0 && subtrahendValue < 0 && value > int64Max + subtrahendValue) {
      return intOverflowError;
    }
    
    // Negative overflow: negative - positive = negative, check if result < min
    if (value < 0 && subtrahendValue > 0 && value < int64Min + subtrahendValue) {
      return intOverflowError;
    }
    
    return IntValue(value - subtrahendValue);
  }

  @override
  Value negate() {
    // Check for integer overflow: negating MinInt64 would overflow
    if (value == -9223372036854775808) {
      return intOverflowError;
    }
    return IntValue(-value);
  }
}
