import 'package:cel/src/common/types/numeric_compare.dart';
import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/traits/comparer.dart';
import 'package:cel/src/common/types/traits/math.dart';
import 'package:cel/src/common/types/traits/traits.dart';

// https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/double.go

final doubleType = Type_('double', {
  Traits.AdderType,
  Traits.ComparerType,
  Traits.DividerType,
  Traits.MultiplierType,
  Traits.NegatorType,
  Traits.SubtractorType
});

class DoubleValue extends Value
    implements
        Comparer,
        Adder,
        Divider,
        Multiplier,
        Subtractor,
        Modder,
        Negater {
  DoubleValue(this.value);

  @override
  Type_ get type => doubleType;

  @override
  final double value;

  // https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/double.go#L61
  @override
  Value compare(Value other) {
    return NumericCompare.compare(this, other);
  }

  @override
  add(Value other) {
    return DoubleValue(value + other.value);
  }

  @override
  divide(Value denominator) {
    return DoubleValue(value / denominator.value);
  }

  @override
  modulo(Value denominator) {
    return DoubleValue(value % denominator.value);
  }

  @override
  multiply(Value other) {
    return DoubleValue(value * other.value);
  }

  @override
  subtract(Value subtrahend) {
    return DoubleValue(value - subtrahend.value);
  }

  @override
  Value negate() {
    return DoubleValue(-value);
  }
}
