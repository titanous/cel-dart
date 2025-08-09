import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/traits/comparer.dart';
import 'package:cel/src/common/types/traits/math.dart';
import 'package:cel/src/common/types/numeric_compare.dart';
import 'package:cel/src/common/types/error.dart';

final intType = Type_('int');

class IntValue extends Value
    implements Comparer, Adder, Divider, Multiplier, Subtractor, Modder, Negater {
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
    return IntValue((value + other.value).toInt());
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
    return IntValue(value % denominatorValue);
  }

  @override
  multiply(Value other) {
    return IntValue((value * other.value).toInt());
  }

  @override
  subtract(Value subtrahend) {
    return IntValue((value - subtrahend.value).toInt());
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
