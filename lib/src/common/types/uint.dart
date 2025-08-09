import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/traits/comparer.dart';
import 'package:cel/src/common/types/traits/math.dart';
import 'package:cel/src/common/types/numeric_compare.dart';

final uintType = Type_('uint');

class UintValue extends Value
    implements Comparer, Adder, Divider, Multiplier, Subtractor, Modder {
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
    return UintValue(value ~/ (denominator.value as int));
  }

  @override
  modulo(Value denominator) {
    return UintValue(value % (denominator.value as int));
  }

  @override
  multiply(Value other) {
    return UintValue(value * (other.value as int));
  }

  @override
  subtract(Value subtrahend) {
    return UintValue(value - (subtrahend.value as int));
  }
}