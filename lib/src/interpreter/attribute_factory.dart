import 'package:cel/src/interpreter/attribute.dart';
import 'package:cel/src/interpreter/interpretable.dart';
import '../common/types/int.dart';
import '../common/types/uint.dart';
import '../common/types/double.dart';
import '../common/types/string.dart';
import '../common/types/ref/value.dart';

class AttributeFactory {
  Attribute maybeAttribute(String name) {
    return MaybeAttribute([
      // Skipped `this.container.ResolveCandidateNames(name)`.
      AbsoluteAttribute(name)
    ]);
  }

  Attribute relativeAttribute(Interpretable eval) {
    return RelativeAttribute(eval);
  }

  // https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/attributes.go#L594
  Qualifier qualifier(dynamic value) {
    if (value is String) {
      // Use StringQualifier for string keys
      return StringQualifier(value);
    } else if (value is int) {
      // Use IndexQualifier for integer indices
      return IndexQualifier(IntValue(value));
    } else if (value is Value) {
      // Handle CEL values directly
      if (value is StringValue) {
        return StringQualifier(value.value);
      } else if (value is IntValue || value is UintValue) {
        return IndexQualifier(value);
      } else if (value is DoubleValue) {
        // For double values, we need a special qualifier
        return DoubleQualifier(value);
      }
    }
    throw StateError('Unsupported qualifier type ${value.runtimeType}');
  }
}
