import 'package:cel/src/common/types/bool.dart';
import 'package:cel/src/common/types/error.dart';
import 'package:cel/src/common/types/ref/provider.dart';
import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/traits/container.dart';
import 'package:cel/src/common/types/traits/indexer.dart';
import 'package:cel/src/common/types/traits/sizer.dart';
import 'package:cel/src/common/types/traits/traits.dart';

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
      return typeAdapter.nativeToValue(result);
    }
    
    // If direct lookup fails, try to find a compatible key
    // This handles cases where keys are equivalent but not identical (e.g., 1, 1u, 1.0)
    for (final entry in value.entries) {
      if (_keysEqual(entry.key, index)) {
        return typeAdapter.nativeToValue(entry.value);
      }
    }
    
    // Key doesn't exist - return error like cel-go does
    return ErrorValue('no such key');
  }
  
  /// Check if two Value keys are equal for map lookup purposes
  /// This implements CEL's key equality semantics where int and uint types
  /// can be cross-compared (1 == 1u) but NOT with doubles
  bool _keysEqual(Value key1, Value key2) {
    // First check direct equality
    if (key1 == key2) return true;
    
    // Handle cross-type comparisons ONLY for int/uint
    // Doubles as map keys use exact equality only
    if (_isIntOrUint(key1) && _isIntOrUint(key2)) {
      return _intEqual(key1, key2);
    }
    
    return false;
  }
  
  /// Check if a Value represents an integer type (int or uint)
  bool _isIntOrUint(Value val) {
    return val.type.name == 'int' || val.type.name == 'uint';
  }
  
  /// Compare two integer values for equality (int/uint cross-comparison)
  bool _intEqual(Value val1, Value val2) {
    final n1 = val1.convertToNative();
    final n2 = val2.convertToNative();
    
    // Both should be integers
    if (n1 is! int || n2 is! int) {
      return false;
    }
    
    return n1 == n2;
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
