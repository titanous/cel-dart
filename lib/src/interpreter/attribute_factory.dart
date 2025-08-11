import 'package:cel/src/interpreter/attribute.dart';
import 'package:cel/src/interpreter/interpretable.dart';
import '../common/types/int.dart';
import '../common/types/uint.dart';
import '../common/types/double.dart';
import '../common/types/string.dart';
import '../common/types/ref/value.dart';

class AttributeFactory {
  /// Known variable names from the environment bindings
  /// This allows the attribute factory to attempt qualified identifier resolution
  Set<String> knownVariables = <String>{};
  
  void setKnownVariables(Set<String> variables) {
    knownVariables = variables;
  }
  
  Attribute maybeAttribute(String name) {
    // Generate candidate attribute names for qualified identifier resolution
    final candidates = _generateQualifiedCandidates(name);
    return MaybeAttribute(candidates.map((candidate) => AbsoluteAttribute(candidate)).toList());
  }
  
  /// Generate qualified identifier candidates
  /// For input "a.b.c", returns ["a.b.c", "a.b", "a"] in that order
  /// This allows trying the longest match first
  List<String> _generateQualifiedCandidates(String name) {
    final candidates = <String>[];
    
    // Split the name by dots
    final parts = name.split('.');
    
    // Generate candidates from longest to shortest
    for (int i = parts.length; i > 0; i--) {
      final candidate = parts.sublist(0, i).join('.');
      candidates.add(candidate);
    }
    
    return candidates;
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
