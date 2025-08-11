import '../ref/value.dart';

/// Trait for values that support field testing (has() macro)
abstract class FieldTester {
  /// Test if a field is set
  Value isSet(Value field);
}
