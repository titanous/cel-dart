import 'package:cel/src/common/types/bool.dart';
import 'package:cel/src/common/types/ref/provider.dart';
import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/traits/container.dart';
import 'package:cel/src/common/types/traits/indexer.dart';
import 'package:cel/src/common/types/traits/math.dart';
import 'package:cel/src/common/types/traits/sizer.dart';
import 'package:cel/src/common/types/traits/traits.dart';
import 'package:cel/src/common/types/error.dart';
import 'package:cel/src/common/types/int.dart';
import 'package:cel/src/common/types/double.dart';
import 'package:cel/src/common/types/uint.dart';
import 'package:cel/src/common/types/numeric_compare.dart';

// https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/list.go

final listType = Type_("list", {
  Traits.AdderType,
  Traits.ContainerType,
  Traits.IndexerType,
  Traits.IterableType,
  Traits.SizerType
});

class ListValue extends Value implements Indexer, Container, Adder, Sizer {
  ListValue(this.value, this.typeAdapter);

  final TypeAdapter typeAdapter;

  @override
  final List<Value> value;

  @override
  Type_ get type => listType;

  @override
  Value get(Value index) {
    // Handle different index types with proper type conversion
    int indexValue;
    
    if (index is IntValue) {
      indexValue = index.value;
    } else if (index is UintValue) {
      indexValue = index.value;
    } else if (index is DoubleValue) {
      // Allow double values that are actually integers
      final doubleVal = index.value;
      if (doubleVal.isFinite && doubleVal == doubleVal.truncateToDouble()) {
        indexValue = doubleVal.toInt();
      } else {
        return ErrorValue('list index must be an integer, got double: $doubleVal');
      }
    } else {
      return ErrorValue('list index must be numeric, got ${index.type.name}');
    }
    
    // Check for negative indices
    if (indexValue < 0) {
      return ErrorValue('list index must be non-negative, got $indexValue');
    }
    
    // Check bounds
    if (indexValue >= value.length) {
      return ErrorValue('index out of range: $indexValue (list size: ${value.length})');
    }
    
    return value[indexValue];
  }

  @override
  convertToNative() {
    return value.map((e) => e.convertToNative()).toList();
  }

  @override
  BooleanValue contains(Value value) {
    // Use NumericCompare.equals for proper cross-type numeric comparison
    for (final item in this.value) {
      if (NumericCompare.equals(item, value)) {
        return BooleanValue(true);
      }
    }
    return BooleanValue(false);
  }

  @override
  add(Value other) {
    if (other is! ListValue) {
      return ErrorValue('cannot add ${other.type.name} to list');
    }
    return ListValue([...value, ...other.value], typeAdapter);
  }
  
  @override
  int size() {
    return value.length;
  }
}
