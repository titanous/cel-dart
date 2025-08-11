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
    if (otherValue is Int64) {
      return UintValue.fromInt64(value + otherValue);
    }
    return UintValue.fromInt64(value + Int64(otherValue as int));
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
    if (otherValue is Int64) {
      return UintValue.fromInt64(value * otherValue);
    }
    return UintValue.fromInt64(value * Int64(otherValue as int));
  }

  @override
  subtract(Value subtrahend) {
    final subtrahendValue = subtrahend.value;
    if (subtrahendValue is Int64) {
      return UintValue.fromInt64(value - subtrahendValue);
    }
    return UintValue.fromInt64(value - Int64(subtrahendValue as int));
  }

  @override
  Value negate() {
    // Unsigned integers cannot be negated to a valid unsigned value
    // Following Go implementation, this returns an error
    return ErrorValue('cannot negate unsigned integer');
  }
}
