import 'package:cel/src/common/types/list.dart';
import 'package:cel/src/common/types/map.dart';
import 'package:cel/src/common/types/bool.dart';
import 'package:cel/src/common/types/bytes.dart';
import 'package:cel/src/common/types/double.dart';
import 'package:cel/src/common/types/int.dart';
import 'package:cel/src/common/types/uint.dart';
import 'package:cel/src/common/types/null_.dart';
import 'package:cel/src/common/types/ref/provider.dart';
import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/string.dart';
import 'package:cel/src/common/types/type.dart';
import 'package:protobuf/protobuf.dart';
import 'package:fixnum/fixnum.dart';
// Import wrapper types
import 'package:cel/src/gen/google/protobuf/wrappers.pb.dart' as pb_wrappers;
import 'package:cel/src/gen/google/protobuf/timestamp.pb.dart' as pb_timestamp;
import 'package:cel/src/gen/google/protobuf/duration.pb.dart' as pb_duration;
import 'package:cel/src/common/types/timestamp.dart';
import 'package:cel/src/common/types/duration.dart';
import 'package:cel/src/common/types/pb/message.dart';
import 'package:cel/src/common/types/pb/registry.dart';
import 'package:cel/src/common/containers/container.dart';
import 'package:cel/src/common/types/error.dart';

// cel-go description:
// NewRegistry accepts a list of proto message instances and returns a type
// provider which can create new instances of the provided message or any
// message that proto depends upon in its FileDescriptor.
/// Provides an adapter to the default types only.
TypeAdapter newRegistry() {
  return TypeRegistry()
    ..registerTypes([
      boolType,
      bytesType,
      doubleType,
      // DurationType,
      intType,
      // listType,
      // mapType,
      nullType,
      stringType,
      uintType
    ]);
  // TimestampType,
  // TypeType,
  // UintType);
}

class TypeRegistry implements TypeAdapter {
  // Add ProtoTypeRegistry for message handling
  late final ProtoTypeRegistry? protoRegistry;
  // Container for namespace resolution
  Container? container;

  TypeRegistry({this.protoRegistry, this.container});

  void registerTypes(List<Type_> types) {}

  @override
  Value nativeToValue(value) {
    return _nativeToValue(this, value);
  }

  /// Convert snake_case to camelCase
  String _snakeToCamelCase(String snakeCase) {
    final parts = snakeCase.split('_');
    if (parts.isEmpty) return snakeCase;

    final result = StringBuffer(parts[0]);
    for (int i = 1; i < parts.length; i++) {
      if (parts[i].isNotEmpty) {
        result.write(parts[i][0].toUpperCase());
        if (parts[i].length > 1) {
          result.write(parts[i].substring(1));
        }
      }
    }
    return result.toString();
  }

  /// Wrap a value in a protobuf wrapper type if needed
  dynamic _wrapValueIfNeeded(dynamic fieldInfo, dynamic value) {
    // Check if field type is a wrapper type based on the field name
    // This is a heuristic - ideally we'd check the actual field type
    final fieldName = fieldInfo.name as String;

    if (fieldName.contains('Int32Wrapper')) {
      // Handle both int and Int64 types for int32
      int intValue;
      if (value is int) {
        intValue = value;
      } else if (value is Int64) {
        intValue = value.toInt();
      } else {
        return value; // Not a numeric type we can validate
      }

      // Validate int32 range: -2147483648 to 2147483647 (2^31)
      if (intValue < -2147483648 || intValue > 2147483647) {
        return ErrorValue('range error');
      }
      return pb_wrappers.Int32Value()..value = intValue;
    } else if (fieldName.contains('Int64Wrapper') && value is int) {
      // Note: Dart int is already limited to int64 range, so no additional validation needed
      return pb_wrappers.Int64Value()..value = Int64(value);
    } else if (fieldName.contains('Uint32Wrapper')) {
      // Handle both int and Int64 types for uint32
      int intValue;
      if (value is int) {
        intValue = value;
      } else if (value is Int64) {
        intValue = value.toInt();
      } else {
        return value; // Not a numeric type we can validate
      }

      // Validate uint32 range: 0 to 4294967295 (2^32-1)
      if (intValue < 0 || intValue > 4294967295) {
        return ErrorValue('range error');
      }
      return pb_wrappers.UInt32Value()..value = intValue;
    } else if (fieldName.contains('Uint64Wrapper') && value is int) {
      // Validate uint64 range: 0 to max uint64
      if (value < 0) {
        return ErrorValue('range error');
      }
      // For large values, need to check if they exceed uint64 max
      final int64Val = Int64(value);
      if (int64Val.isNegative && value > 0) {
        // This indicates overflow beyond uint64 range
        return ErrorValue('range error');
      }
      return pb_wrappers.UInt64Value()..value = int64Val;
    } else if (fieldName.contains('FloatWrapper') && value is double) {
      return pb_wrappers.FloatValue()..value = value;
    } else if (fieldName.contains('DoubleWrapper') && value is double) {
      return pb_wrappers.DoubleValue()..value = value;
    } else if (fieldName.contains('BoolWrapper') && value is bool) {
      return pb_wrappers.BoolValue()..value = value;
    } else if (fieldName.contains('StringWrapper') && value is String) {
      return pb_wrappers.StringValue()..value = value;
    } else if (fieldName.contains('BytesWrapper') && value is List<int>) {
      return pb_wrappers.BytesValue()..value = value;
    }

    return value;
  }

  // Create a message from a type name and field values
  // Returns GeneratedMessage on success, null if type not found, or ErrorValue on validation error
  dynamic createMessage(String typeName, Map<String, dynamic> fields) {
    if (protoRegistry == null) return null;

    // Try resolving the type name with the container if available
    MessageValue? messageVal;

    if (container != null) {
      // Try each candidate name from the container
      final candidates = container!.resolveCandidateNames(typeName);
      for (final candidate in candidates) {
        messageVal = protoRegistry!.createMessage(candidate);
        if (messageVal != null) break;
      }
    } else {
      // No container, try the name directly
      messageVal = protoRegistry!.createMessage(typeName);
    }

    if (messageVal == null) return null;

    final message = messageVal.message;

    // Set field values
    for (final entry in fields.entries) {
      try {
        final fieldName = entry.key;
        final value = entry.value;

        // Convert snake_case to camelCase for Dart field names
        final camelCaseFieldName = _snakeToCamelCase(fieldName);

        // Find the field in the message
        final fieldInfo = message.info_.fieldInfo.values.firstWhere(
          (f) => f.name == camelCaseFieldName || f.name == fieldName,
          orElse: () => throw Exception('Field $fieldName not found'),
        );

        // Set the field value
        if (value != null) {
          // Handle different field types appropriately
          if (fieldInfo.isRepeated) {
            // For repeated fields, we need to add elements to the list
            if (value is List) {
              final list = message.getField(fieldInfo.tagNumber) as List;
              for (final element in value) {
                final fieldValue = _wrapValueIfNeeded(fieldInfo, element);
                if (fieldValue is ErrorValue) {
                  return fieldValue;
                }
                list.add(fieldValue);
              }
            }
          } else if (fieldInfo.isMapField) {
            // For map fields, we need to populate the map entries
            if (value is Map) {
              final map = message.getField(fieldInfo.tagNumber) as Map;
              for (final entry in value.entries) {
                final keyValue = _wrapValueIfNeeded(fieldInfo, entry.key);
                final valueValue = _wrapValueIfNeeded(fieldInfo, entry.value);
                if (keyValue is ErrorValue) return keyValue;
                if (valueValue is ErrorValue) return valueValue;
                map[keyValue] = valueValue;
              }
            }
          } else {
            // For singular fields, use the existing logic
            final fieldValue = _wrapValueIfNeeded(fieldInfo, value);
            // Check if range validation failed
            if (fieldValue is ErrorValue) {
              // Return the error value directly
              return fieldValue;
            }
            message.setField(fieldInfo.tagNumber, fieldValue);
          }
        }
      } catch (e) {
        // Skip fields that can't be set
        continue;
      }
    }

    return message;
  }
}

// https://github.com/google/cel-go/blob/051835c9903525b656a438f778510d9b619b3702/common/types/provider.go#L262
Value _nativeToValue(TypeAdapter adapter, dynamic value) {
  if (value == null) {
    return nullValue;
  }
  // Pass-through all Value types.
  // https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/common/types/provider.go#L266-L289
  if (value is NullValue) {
    return value;
  }
  if (value is BooleanValue) {
    return value;
  }
  if (value is IntValue) {
    return value;
  }
  if (value is UintValue) {
    return value;
  }
  if (value is DoubleValue) {
    return value;
  }
  if (value is StringValue) {
    return value;
  }
  if (value is BytesValue) {
    return value;
  }
  if (value is MapValue) {
    return value;
  }
  if (value is ListValue) {
    return value;
  }
  if (value is TypeValue) {
    return value;
  }
  // Wrap primitives.
  if (value is bool) {
    return BooleanValue(value);
  }
  if (value is int) {
    return IntValue(value);
  }
  // Handle Int64 from fixnum as uint values (since they represent uint literals)
  if (value is Int64) {
    return UintValue.fromInt64(value);
  }
  if (value is double) {
    return DoubleValue(value);
  }
  if (value is String) {
    return StringValue(value);
  }
  // https://github.com/google/cel-go/blob/051835c9903525b656a438f778510d9b619b3702/common/types/provider.go#L370
  if (value is Map<Value, Value>) {
    return MapValue(value, adapter);
  }
  // https://github.com/google/cel-go/blob/051835c9903525b656a438f778510d9b619b3702/common/types/provider.go#L366-L369
  if (value is Map) {
    return MapValue.fromNativeKeyValues(value, adapter);
  }
  // Handle all List types - convert each element to CEL Value
  if (value is List) {
    // Special case: List<int> should be treated as bytes (CodeUnits from parser)
    if (value is List<int> && value.every((e) => e >= 0 && e <= 255)) {
      return BytesValue.fromCodeUnits(value);
    }
    
    final elements = <Value>[];
    for (final element in value) {
      elements.add(_nativeToValue(adapter, element));
    }
    return ListValue(elements, adapter);
  }

  // Handle protobuf wrapper types - unwrap them to their primitive values
  if (value is pb_wrappers.DoubleValue) {
    return DoubleValue(value.value);
  }
  if (value is pb_wrappers.FloatValue) {
    return DoubleValue(value.value.toDouble());
  }
  if (value is pb_wrappers.Int64Value) {
    return IntValue(value.value.toInt());
  }
  if (value is pb_wrappers.UInt64Value) {
    return UintValue(value.value.toInt());
  }
  if (value is pb_wrappers.Int32Value) {
    return IntValue(value.value);
  }
  if (value is pb_wrappers.UInt32Value) {
    return UintValue(value.value);
  }
  if (value is pb_wrappers.BoolValue) {
    return BooleanValue(value.value);
  }
  if (value is pb_wrappers.StringValue) {
    return StringValue(value.value);
  }
  if (value is pb_wrappers.BytesValue) {
    return BytesValue.fromCodeUnits(value.value);
  }

  // Handle timestamp and duration
  if (value is pb_timestamp.Timestamp) {
    final seconds = value.seconds.toInt();
    final nanos = value.nanos;
    final microseconds = seconds * 1000000 + (nanos ~/ 1000);
    return TimestampValue(
        DateTime.fromMicrosecondsSinceEpoch(microseconds, isUtc: true));
  }
  if (value is pb_duration.Duration) {
    final seconds = value.seconds.toInt();
    final nanos = value.nanos;
    final microseconds = seconds * 1000000 + (nanos ~/ 1000);
    return DurationValue(Duration(microseconds: microseconds));
  }

  // Handle protobuf enums - convert to IntValue
  if (value is ProtobufEnum) {
    return IntValue(value.value);
  }

  // Handle other protobuf messages
  if (value is GeneratedMessage) {
    return MessageValue(value, adapter);
  }

  // Handle ErrorValue
  if (value is ErrorValue) {
    return value;
  }

  throw UnimplementedError('Unsupported type for $value: ${value.runtimeType}');
}
