import 'package:fixnum/fixnum.dart';
import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/traits/comparer.dart';
import 'package:cel/src/common/types/traits/math.dart';
import 'package:cel/src/common/types/numeric_compare.dart';
import 'package:cel/src/common/types/error.dart';

final uintType = Type_('uint');

class UintValue extends Value
    implements
        Comparer,
        Adder,
        Divider,
        Multiplier,
        Subtractor,
        Modder,
        Negater {
  UintValue(int value) : this.fromInt64(Int64(value));
  UintValue.fromInt64(this.value);

  @override
  Type_ get type => uintType;

  @override
  final Int64 value;

  @override
  Value compare(Value other) {
    return NumericCompare.compare(this, other);
  }

  @override
  add(Value other) {
    final otherValue = other.value;
    final otherInt64 = otherValue is Int64
        ? otherValue
        : Int64(otherValue as int);
    
    // Check for uint64 overflow: both operands should be non-negative
    // and their sum should not exceed uint64 max
    if (value < Int64.ZERO || otherInt64 < Int64.ZERO) {
      return ErrorValue('uint64 arithmetic on negative values');
    }
    
    // Check if addition would overflow uint64 max (2^64 - 1)
    // We can use Int64.MAX_VALUE as an approximation, but need to be careful
    // Int64.MAX_VALUE = 2^63 - 1, but uint64 max = 2^64 - 1
    // Since we can't represent uint64 max in Int64, we check differently:
    // If value + otherInt64 would be negative (due to overflow), it overflowed
    final result = value + otherInt64;
    if (result < Int64.ZERO || result < value || result < otherInt64) {
      return ErrorValue('uint64 addition overflow');
    }
    
    return UintValue.fromInt64(result);
  }

  @override
  divide(Value denominator) {
    final denominatorValue = denominator.value;
    final denom = denominatorValue is Int64
        ? denominatorValue
        : Int64(denominatorValue as int);
    if (denom == Int64.ZERO) {
      return divideByZeroError;
    }
    return UintValue.fromInt64(value ~/ denom);
  }

  @override
  modulo(Value denominator) {
    final denominatorValue = denominator.value;
    final denom = denominatorValue is Int64
        ? denominatorValue
        : Int64(denominatorValue as int);
    if (denom == Int64.ZERO) {
      return moduloByZeroError;
    }
    return UintValue.fromInt64(value % denom);
  }

  @override
  multiply(Value other) {
    final otherValue = other.value;
    final otherInt64 = otherValue is Int64
        ? otherValue
        : Int64(otherValue as int);
    
    // Check for uint64 overflow in multiplication
    if (value < Int64.ZERO || otherInt64 < Int64.ZERO) {
      return ErrorValue('uint64 arithmetic on negative values');
    }
    
    // Handle zero cases (no overflow possible)
    if (value == Int64.ZERO || otherInt64 == Int64.ZERO) {
      return UintValue.fromInt64(Int64.ZERO);
    }
    
    // Check for overflow before multiplication
    // Since we can't represent uint64 max in Int64, we use a different approach:
    // Check if value > uint64_max / otherInt64
    // We approximate this by checking if the result would be negative or less than either operand
    if (otherInt64 > Int64.ZERO && value > Int64.MAX_VALUE ~/ otherInt64) {
      return ErrorValue('uint64 multiplication overflow');
    }
    
    final result = value * otherInt64;
    // Additional check: if result wrapped around, it would be smaller than either operand
    if (result < Int64.ZERO || (value > Int64.ONE && result < value) || (otherInt64 > Int64.ONE && result < otherInt64)) {
      return ErrorValue('uint64 multiplication overflow');
    }
    
    return UintValue.fromInt64(result);
  }

  @override
  subtract(Value subtrahend) {
    final subtrahendValue = subtrahend.value;
    final subtrahendInt64 = subtrahendValue is Int64
        ? subtrahendValue
        : Int64(subtrahendValue as int);
    
    // Check for uint64 underflow: result cannot be negative
    if (value < Int64.ZERO || subtrahendInt64 < Int64.ZERO) {
      return ErrorValue('uint64 arithmetic on negative values');
    }
    
    if (value < subtrahendInt64) {
      return ErrorValue('uint64 subtraction underflow');
    }
    
    return UintValue.fromInt64(value - subtrahendInt64);
  }

  @override
  Value negate() {
    // Unsigned integers cannot be negated to a valid unsigned value
    // Following Go implementation, this returns an error
    return ErrorValue('cannot negate unsigned integer');
  }
}
