import 'functions/functions.dart';
import '../common/types/error.dart';
import '../common/types/ref/value.dart';

class Dispatcher {
  Dispatcher(List<Overload> overloads) {
    add(overloads);
  }

  final Map<String, List<Overload>> _overloads = {};

  Overload? findOverload(String name, {int? argCount}) {
    final overloads = _overloads[name];
    if (overloads == null || overloads.isEmpty) {
      return null;
    }

    // If no argument count specified, return first overload (backward compatibility)
    if (argCount == null) {
      return overloads.first;
    }

    // Try to find the most specific overload for the given argument count
    for (final overload in overloads) {
      // Check for exact match based on argument count (prefer specific operators)
      if (argCount == 1 &&
          overload.unaryOperator != null &&
          overload.functionOperator == null) {
        return overload;
      }
      if (argCount == 2 &&
          overload.binaryOperator != null &&
          overload.functionOperator == null) {
        return overload;
      }
    }

    // If still no match, check operators with functionOperator as well
    for (final overload in overloads) {
      if (argCount == 1 && overload.unaryOperator != null) {
        return overload;
      }
      if (argCount == 2 && overload.binaryOperator != null) {
        return overload;
      }
    }

    // Fall back to functionOperator if available
    for (final overload in overloads) {
      if (overload.functionOperator != null) {
        return overload;
      }
    }

    // No suitable overload found
    return null;
  }

  /// Find the best overload based on argument types (CEL-ES style)
  Overload? findOverloadByTypes(String name, List<Value> args) {
    final overloads = _overloads[name];
    if (overloads == null || overloads.isEmpty) {
      return null;
    }

    // Try to find an exact type match first
    for (final overload in overloads) {
      if (overload.matchesArgumentTypes(args)) {
        return overload;
      }
    }

    // If no exact match found, return null (don't fall back)
    // This forces proper type-based dispatch
    return null;
  }

  // Get all overloads for a function name (for handling null returns)
  List<Overload>? findAllOverloads(String name) {
    return _overloads[name];
  }

  void add(List<Overload> functions) {
    for (final o in functions) {
      _overloads.putIfAbsent(o.name, () => []).add(o);
    }
  }
}
