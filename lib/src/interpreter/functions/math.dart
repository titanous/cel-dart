import 'package:cel/src/common/types/bool.dart';
import 'package:cel/src/common/types/double.dart';
import 'package:cel/src/common/types/int.dart';
import 'package:cel/src/common/types/ref/value.dart';

/// Math functions for CEL expressions
class MathFunctions {
  /// Check if a double value is NaN
  static BooleanValue isNan(DoubleValue val) {
    return BooleanValue(val.value.isNaN);
  }

  /// Check if a double value is infinite
  /// If sign is provided:
  ///   - sign > 0: check for positive infinity
  ///   - sign < 0: check for negative infinity
  ///   - sign == 0: check for any infinity
  static BooleanValue isInf(DoubleValue val, [IntValue? sign]) {
    if (sign == null) {
      return BooleanValue(val.value.isInfinite);
    }

    if (sign.value > 0) {
      return BooleanValue(val.value == double.infinity);
    } else if (sign.value < 0) {
      return BooleanValue(val.value == double.negativeInfinity);
    } else {
      // sign == 0, check for any infinity
      return BooleanValue(val.value.isInfinite);
    }
  }

  /// Check if a double value is finite (not NaN or infinite)
  static BooleanValue isFinite(DoubleValue val) {
    return BooleanValue(val.value.isFinite);
  }
}
