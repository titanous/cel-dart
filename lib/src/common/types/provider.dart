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
    
    if (fieldName.contains('Int32Wrapper') && value is int) {
      return pb_wrappers.Int32Value()..value = value;
    } else if (fieldName.contains('Int64Wrapper') && value is int) {
      return pb_wrappers.Int64Value()..value = Int64(value);
    } else if (fieldName.contains('Uint32Wrapper') && value is int) {
      return pb_wrappers.UInt32Value()..value = value;
    } else if (fieldName.contains('Uint64Wrapper') && value is int) {
      return pb_wrappers.UInt64Value()..value = Int64(value);
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
  GeneratedMessage? createMessage(String typeName, Map<String, dynamic> fields) {
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
          // Check if this field expects a wrapper type
          final fieldValue = _wrapValueIfNeeded(fieldInfo, value);
          message.setField(fieldInfo.tagNumber, fieldValue);
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
  // Wrap primitives.
  if (value is bool) {
    return BooleanValue(value);
  }
  if (value is int) {
    return IntValue(value);
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
  if (value is List<Value>) {
    return ListValue(value, adapter);
  }
  // Handle List<int> as bytes (CodeUnits type from parser)
  if (value is List<int>) {
    return BytesValue.fromCodeUnits(value);
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
    return TimestampValue(DateTime.fromMicrosecondsSinceEpoch(microseconds, isUtc: true));
  }
  if (value is pb_duration.Duration) {
    final seconds = value.seconds.toInt();
    final nanos = value.nanos;
    final microseconds = seconds * 1000000 + (nanos ~/ 1000);
    return DurationValue(Duration(microseconds: microseconds));
  }
  
  // Handle other protobuf messages
  if (value is GeneratedMessage) {
    return MessageValue(value, adapter);
  }
  
  throw UnimplementedError('Unsupported type for $value: ${value.runtimeType}');
}
