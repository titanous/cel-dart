import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/traits/comparer.dart';
import 'package:cel/src/common/types/traits/math.dart';
import 'package:cel/src/common/types/numeric_compare.dart';
import 'package:cel/src/common/types/error.dart';

final uintType = Type_('uint');

class UintValue extends Value
    implements Comparer, Adder, Divider, Multiplier, Subtractor, Modder, Negater {
  UintValue(this.value);

  @override
  Type_ get type => uintType;

  @override
  final int value;

  @override
  Value compare(Value other) {
    return NumericCompare.compare(this, other);
  }

  @override
  add(Value other) {
    return UintValue(value + (other.value as int));
  }

  @override
  divide(Value denominator) {
    final denominatorValue = denominator.value as int;
    if (denominatorValue == 0) {
      return divideByZeroError;
    }
    return UintValue(value ~/ denominatorValue);
  }

  @override
  modulo(Value denominator) {
    final denominatorValue = denominator.value as int;
    if (denominatorValue == 0) {
      return moduloByZeroError;
    }
    return UintValue(value % denominatorValue);
  }

  @override
  multiply(Value other) {
    return UintValue(value * (other.value as int));
  }

  @override
  subtract(Value subtrahend) {
    return UintValue(value - (subtrahend.value as int));
  }

  @override
  Value negate() {
    // Unsigned integers cannot be negated to a valid unsigned value
    // Following Go implementation, this returns an error
    return ErrorValue('cannot negate unsigned integer');
  }
}