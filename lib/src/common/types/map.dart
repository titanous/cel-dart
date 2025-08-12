import 'package:cel/src/common/types/bool.dart';
import 'package:cel/src/common/types/error.dart';
import 'package:cel/src/common/types/ref/provider.dart';
import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/traits/container.dart';
import 'package:cel/src/common/types/traits/indexer.dart';
import 'package:cel/src/common/types/traits/sizer.dart';
import 'package:cel/src/common/types/traits/traits.dart';
import 'package:fixnum/fixnum.dart';

// https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/map.go

final mapType = Type_("map", {
  Traits.ContainerType,
  Traits.IndexerType,
  Traits.IterableType,
  Traits.SizerType
});

class MapValue extends Value implements Indexer, Container, Sizer {
  MapValue(this.value, this.typeAdapter);

  factory MapValue.fromNativeKeyValues(
      Map<dynamic, dynamic> map, TypeAdapter typeAdapter) {
    // Skipped the MapAccessor and Mapper code.
    // https://github.com/google/cel-go/blob/051835c9903525b656a438f778510d9b619b3702/common/types/map.go#L80
    return MapValue(
        Map.fromEntries(map.entries.map((e) => MapEntry(
            typeAdapter.nativeToValue(e.key),
            typeAdapter.nativeToValue(e.value)))),
        typeAdapter);
  }

  final TypeAdapter typeAdapter;

  @override
  final Map<Value, Value> value;

  @override
  Type_ get type => mapType;

  @override
  Value get(Value index) {
    // First try direct key lookup
    final result = value[index];
    if (result != null || value.containsKey(index)) {
      return result!; // result is already a Value, don't convert again
    }

    // If direct lookup fails, try to find a compatible key
    // This handles cases where keys are equivalent but not identical (e.g., 1, 1u, 1.0)
    for (final entry in value.entries) {
      if (_keysEqual(entry.key, index)) {
        return entry
            .value; // entry.value is already a Value, don't convert again
      }
    }

    // Key doesn't exist - return error like cel-go does
    return ErrorValue('no such key');
  }

  /// Check if two Value keys are equal for map lookup purposes
  /// This implements CEL's key equality semantics where numeric types
  /// can be cross-compared if they represent the same value
  bool _keysEqual(Value key1, Value key2) {
    // First check direct equality
    if (key1 == key2) return true;

    // Handle cross-type comparisons for numeric types
    // CEL allows int, uint, and double to be equivalent if they represent the same number
    if (_isNumeric(key1) && _isNumeric(key2)) {
      return _numericEqual(key1, key2);
    }

    return false;
  }

  /// Check if a Value represents a numeric type (int, uint, or double)
  bool _isNumeric(Value val) {
    return val.type.name == 'int' || val.type.name == 'uint' || val.type.name == 'double';
  }

  /// Compare two numeric values for equality (int/uint/double cross-comparison)
  bool _numericEqual(Value val1, Value val2) {
    final n1 = val1.convertToNative();
    final n2 = val2.convertToNative();

    // Convert both to double for comparison
    double? d1, d2;
    
    if (n1 is int) {
      d1 = n1.toDouble();
    } else if (n1 is Int64) {
      d1 = n1.toDouble();
    } else if (n1 is double) {
      d1 = n1;
    }
    
    if (n2 is int) {
      d2 = n2.toDouble();
    } else if (n2 is Int64) {
      d2 = n2.toDouble();
    } else if (n2 is double) {
      d2 = n2;
    }
    
    // Both should be convertible to double
    if (d1 == null || d2 == null) {
      return false;
    }
    
    // Check if they're equal as doubles, but also ensure that
    // if one is supposed to be an integer, it's actually a whole number
    if (d1 != d2) {
      return false;
    }
    
    // Additional check: if either original value was an int/uint,
    // the double value should be a whole number
    if (((n1 is int || n1 is Int64) && d1 != d1.truncate()) || 
        ((n2 is int || n2 is Int64) && d2 != d2.truncate())) {
      return false;
    }
    
    return true;
  }

  @override
  convertToNative() {
    return Map.fromEntries(value.entries
        .map((entry) => MapEntry(
            entry.key.convertToNative(), entry.value.convertToNative()))
        .toList());
  }

  @override
  BooleanValue contains(Value searchValue) {
    // First try direct key lookup
    if (value.containsKey(searchValue)) {
      return BooleanValue(true);
    }

    // If direct lookup fails, try to find a compatible key
    for (final key in value.keys) {
      if (_keysEqual(key, searchValue)) {
        return BooleanValue(true);
      }
    }

    return BooleanValue(false);
  }

  @override
  int size() {
    return value.length;
  }
}
