import 'dart:typed_data';
import 'package:protobuf/protobuf.dart';
import 'package:fixnum/fixnum.dart';
import '../ref/value.dart';
import '../ref/provider.dart';
import '../string.dart';
import '../int.dart';
import '../uint.dart';
import '../double.dart';
import '../bool.dart';
import '../list.dart';
import '../map.dart';
import '../bytes.dart';
import '../timestamp.dart';
import '../duration.dart';
import '../null_.dart';
import 'message.dart';
import '../../../gen/google/protobuf/wrappers.pb.dart' as pb_wrappers;
import '../../../gen/google/protobuf/struct.pb.dart' as pb_struct;
import '../../../gen/google/protobuf/timestamp.pb.dart' as pb_timestamp;
import '../../../gen/google/protobuf/duration.pb.dart' as pb_duration;
import '../enum.dart';

/// Adapter for converting protobuf messages to CEL values
class ProtobufTypeAdapter {
  final TypeAdapter typeAdapter;

  ProtobufTypeAdapter(this.typeAdapter);

  /// Convert a GeneratedMessage to a CEL Value
  Value adaptMessage(GeneratedMessage msg) {
    return MessageValue(msg);
  }

  /// Convert any value to a CEL Value (public wrapper for _adaptSingleValue)
  Value adaptValue(dynamic value) {
    return _adaptSingleValue(value);
  }

  /// Convert protobuf Value to CEL Value
  Value _adaptProtoValue(pb_struct.Value protoValue) {
    if (protoValue.hasNullValue()) {
      return NullValue();
    } else if (protoValue.hasBoolValue()) {
      return BooleanValue(protoValue.boolValue);
    } else if (protoValue.hasNumberValue()) {
      final number = protoValue.numberValue;
      // Check if it's an integer (no fractional part)
      if (number == number.truncate()) {
        return IntValue(number.toInt());
      } else {
        return DoubleValue(number);
      }
    } else if (protoValue.hasStringValue()) {
      return StringValue(protoValue.stringValue);
    } else if (protoValue.hasListValue()) {
      final elements = <Value>[];
      for (final element in protoValue.listValue.values) {
        elements.add(_adaptProtoValue(element));
      }
      return ListValue(elements, typeAdapter);
    } else if (protoValue.hasStructValue()) {
      final entries = <Value, Value>{};
      for (final entry in protoValue.structValue.fields.entries) {
        entries[StringValue(entry.key)] = _adaptProtoValue(entry.value);
      }
      return MapValue(entries, typeAdapter);
    } else {
      // Default to null if no value is set
      return NullValue();
    }
  }

  /// Get a field value from a message
  Value getField(GeneratedMessage msg, String fieldName) {
    final info = msg.info_;

    // Find the field info - try both proto field name and Dart property name
    for (final field in info.fieldInfo.values) {
      // Check if the field matches by proto name (snake_case) or Dart name (camelCase)
      if (_matchesFieldName(field, fieldName)) {
        // Special handling for enum fields that might contain unknown values
        // But only for singular enum fields - repeated enum fields should use normal handling
        if (_isEnumField(field) && !field.isRepeated) {
          return _adaptEnumFieldSafely(msg, field);
        }
        return _adaptFieldValue(msg, field);
      }
    }

    // Field not found
    return NullValue();
  }

  /// Check if a field matches the given name (either proto name or Dart property name)
  bool _matchesFieldName(FieldInfo field, String name) {
    // Check Dart property name (camelCase)
    if (field.name == name) {
      return true;
    }

    // Check proto field name (snake_case)
    // The proto name is stored in the protoName property if available
    // Otherwise, try converting between naming conventions
    final protoName = _getProtoFieldName(field);
    if (protoName == name) {
      return true;
    }

    // Also try converting the given name to see if it matches
    final camelFromSnake = _toCamelCase(name);
    if (camelFromSnake == field.name) {
      return true;
    }

    // Additional check: try converting the Dart name to snake_case and compare
    final snakeCase = _toSnakeCase(field.name);
    if (snakeCase == name) {
      return true;
    }

    return false;
  }

  /// Get the proto field name for a field
  String _getProtoFieldName(FieldInfo field) {
    // For protobuf.dart, the FieldInfo.name is typically the Dart property name (camelCase)
    // The original proto field name (snake_case) can be derived by converting to snake_case
    // unless it was explicitly set differently in the .proto file

    // First try to get the proto name if it exists as a property
    try {
      // Some versions of protobuf.dart may have a protoName property
      final dynamic fieldDynamic = field;
      if (fieldDynamic.hasProperty('protoName') &&
          fieldDynamic.protoName != null) {
        return fieldDynamic.protoName as String;
      }
    } catch (_) {
      // Ignore if protoName doesn't exist
    }

    // Fallback: convert camelCase to snake_case
    // This should work for most standard protobuf field names
    return _toSnakeCase(field.name);
  }

  /// Convert snake_case to camelCase
  String _toCamelCase(String snakeCase) {
    if (!snakeCase.contains('_')) {
      return snakeCase;
    }

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

  /// Convert camelCase to snake_case
  String _toSnakeCase(String camelCase) {
    final result = StringBuffer();
    for (int i = 0; i < camelCase.length; i++) {
      final char = camelCase[i];
      if (char.toUpperCase() == char && char.toLowerCase() != char) {
        // It's an uppercase letter
        if (i > 0) {
          result.write('_');
        }
        result.write(char.toLowerCase());
      } else {
        result.write(char);
      }
    }
    return result.toString();
  }

  /// Adapt a field value to CEL value
  Value _adaptFieldValue(GeneratedMessage msg, FieldInfo field) {
    if (field.isRepeated) {
      // Handle repeated fields
      final fieldValue = msg.getField(field.tagNumber);
      if (fieldValue is List) {
        // For repeated fields, adapt each element
        final elements = <Value>[];
        for (final element in fieldValue) {
          elements.add(_adaptSingleValueWithContext(element, msg));
        }
        return ListValue(elements, typeAdapter);
      } else {
        // If not a list (e.g., uninitialized repeated field), return empty list
        return ListValue([], typeAdapter);
      }
    } else if (field.isMapField) {
      // Handle map fields
      final map = msg.getField(field.tagNumber) as Map;
      final entries = <Value, Value>{};
      for (final entry in map.entries) {
        // For now, assume string keys and adapt values
        entries[_adaptSingleValueWithContext(entry.key, msg)] = _adaptSingleValueWithContext(entry.value, msg);
      }
      return MapValue(entries, typeAdapter);
    } else {
      // Handle singular fields
      final hasField = msg.hasField(field.tagNumber);
      final value = msg.getField(field.tagNumber);

      // Special handling for enum fields: 
      // Even if hasField is false, we should check if we have a valid enum value
      if (_isEnumField(field)) {
        // For enum fields, always try to get the value first
        // Protobuf may return a valid enum even when hasField is false
        if (value != null) {
          return _adaptSingleValueWithContext(value, msg);
        }
        // Only fall back to default if we truly have no value
        return _getDefaultValueForType(field.type);
      }

      if (!hasField) {
        // For wrapper types, check if they have been explicitly set with a value
        if (_isWrapperType(value)) {
          // For wrapper types, check if they contain a non-default value
          if (_hasWrapperValue(value)) {
            // Wrapper has a value, process it normally
            return _adaptSingleValueWithContext(value, msg);
          } else {
            // Wrapper is unset/default, return null
            return NullValue();
          }
        }
        
        // For proto3 message fields that aren't set, we should return the default instance
        // Check if this is a message field by examining the field type
        if (_isMessageField(field)) {
          // Return the default message instance even though the field isn't set
          // This matches proto3 semantics where unset message fields return their default instances
          return _adaptSingleValueWithContext(value, msg);
        }
        
        // Return default value for unset non-wrapper, non-message fields
        return _getDefaultValueForType(field.type);
      }
      return _adaptSingleValueWithContext(value, msg);
    }
  }

  /// Check if a value is a wrapper type or should auto-convert
  bool _isWrapperType(dynamic value) {
    if (value == null) return false;
    return value is pb_wrappers.BoolValue ||
        value is pb_wrappers.BytesValue ||
        value is pb_wrappers.StringValue ||
        value is pb_wrappers.DoubleValue ||
        value is pb_wrappers.FloatValue ||
        value is pb_wrappers.Int32Value ||
        value is pb_wrappers.Int64Value ||
        value is pb_wrappers.UInt32Value ||
        value is pb_wrappers.UInt64Value ||
        value is pb_struct.Value ||  // google.protobuf.Value should also auto-convert
        value is pb_struct.ListValue ||  // google.protobuf.ListValue should also auto-convert  
        value is pb_struct.Struct ||  // google.protobuf.Struct should also auto-convert
        value is pb_timestamp.Timestamp ||  // google.protobuf.Timestamp should also auto-convert
        value is pb_duration.Duration;  // google.protobuf.Duration should also auto-convert
  }

  /// Check if a field is a message field (not a wrapper type)
  bool _isMessageField(FieldInfo field) {
    // Message fields have the MESSAGE_BIT set in their type
    const MESSAGE_BIT = 0x200000;
    const MODIFIER_MASK = 0x400007;
    final baseType = field.type & ~MODIFIER_MASK;
    return (baseType & MESSAGE_BIT) != 0;
  }

  /// Check if a field is an enum field
  bool _isEnumField(FieldInfo field) {
    // Enum fields have the ENUM_BIT set in their type
    const ENUM_BIT = 0x200;
    const MODIFIER_MASK = 0x400007;
    final baseType = field.type & ~MODIFIER_MASK;
    return (baseType & ENUM_BIT) != 0;
  }

  /// Check if a wrapper type has a non-default value
  bool _hasWrapperValue(dynamic value) {
    if (value == null) return false;
    
    // Handle google.protobuf.Value (should always be considered as having a value when constructed)
    if (value is pb_struct.Value) {
      return true;  // Any constructed Value should be considered as having a value
    }
    
    // Handle google.protobuf.ListValue (should always be considered as having a value when constructed)
    if (value is pb_struct.ListValue) {
      return true;  // Any constructed ListValue should be considered as having a value
    }
    
    // Handle google.protobuf.Struct (should always be considered as having a value when constructed)
    if (value is pb_struct.Struct) {
      return true;  // Any constructed Struct should be considered as having a value
    }

    // Check each wrapper type and see if it has a non-default value
    if (value is pb_wrappers.BoolValue) {
      return value.hasField(1);  // value field is at tag 1
    } else if (value is pb_wrappers.BytesValue) {
      return value.hasField(1);
    } else if (value is pb_wrappers.StringValue) {
      return value.hasField(1);
    } else if (value is pb_wrappers.DoubleValue) {
      return value.hasField(1);
    } else if (value is pb_wrappers.FloatValue) {
      return value.hasField(1);
    } else if (value is pb_wrappers.Int32Value) {
      return value.hasField(1);
    } else if (value is pb_wrappers.Int64Value) {
      return value.hasField(1);
    } else if (value is pb_wrappers.UInt32Value) {
      return value.hasField(1);
    } else if (value is pb_wrappers.UInt64Value) {
      return value.hasField(1);
    } else if (value is pb_timestamp.Timestamp) {
      // Timestamp is always considered as having a value when constructed
      return true;
    } else if (value is pb_duration.Duration) {
      // Duration is always considered as having a value when constructed
      return true;
    }

    return false;
  }

  /// Adapt a single value to CEL value based on its runtime type
  Value _adaptSingleValue(dynamic value) {
    return _adaptSingleValueWithContext(value, null);
  }

  /// Adapt a single value to CEL value with message context for enum types
  Value _adaptSingleValueWithContext(dynamic value, GeneratedMessage? contextMessage) {
    if (value == null) {
      return NullValue();
    }

    // Check for wrapper types first and auto-unwrap them
    if (value is GeneratedMessage) {
      // Check if this is a wrapper type
      if (value is pb_wrappers.BoolValue) {
        return BooleanValue(value.value);
      } else if (value is pb_wrappers.BytesValue) {
        return BytesValue(Uint8List.fromList(value.value));
      } else if (value is pb_wrappers.StringValue) {
        return StringValue(value.value);
      } else if (value is pb_wrappers.FloatValue) {
        // FloatValue should preserve float precision (32-bit) when auto-unwrapped
        // Convert to float32 precision to match IEEE 754 single precision
        final floatValue = value.value;
        final float32Value = _toFloat32(floatValue);
        return DoubleValue(float32Value);
      } else if (value is pb_wrappers.Int32Value) {
        return IntValue(value.value);
      } else if (value is pb_wrappers.Int64Value) {
        return IntValue(value.value.toInt());
      } else if (value is pb_wrappers.UInt32Value) {
        return UintValue(value.value);
      } else if (value is pb_wrappers.UInt64Value) {
        return UintValue(value.value.toInt());
      } else if (value is pb_struct.ListValue) {
        // Convert protobuf ListValue to CEL ListValue
        final elements = <Value>[];
        for (final protoValue in value.values) {
          elements.add(_adaptProtoValue(protoValue));
        }
        return ListValue(elements, typeAdapter);
      } else if (value is pb_struct.Struct) {
        // Convert protobuf Struct to CEL MapValue  
        final entries = <Value, Value>{};
        for (final entry in value.fields.entries) {
          entries[StringValue(entry.key)] = _adaptProtoValue(entry.value);
        }
        return MapValue(entries, typeAdapter);
      } else if (value is pb_struct.Value) {
        // Convert protobuf Value to appropriate CEL value
        return _adaptProtoValue(value);
      } else if (value is pb_timestamp.Timestamp) {
        // Convert protobuf Timestamp to CEL TimestampValue
        final dateTime = DateTime.fromMillisecondsSinceEpoch(
          value.seconds.toInt() * 1000 + value.nanos ~/ 1000000,
          isUtc: true,
        );
        return TimestampValue(dateTime);
      } else if (value is pb_duration.Duration) {
        // Convert protobuf Duration to CEL DurationValue
        final duration = Duration(
          seconds: value.seconds.toInt(),
          microseconds: value.nanos ~/ 1000,
        );
        return DurationValue(duration);
      } else {
        // Check for other well-known types that need special handling
        // Import struct types at top of file
        return adaptMessage(value);
      }
    }

    // Determine type based on runtime type
    if (value is bool) {
      return BooleanValue(value);
    } else if (value is Int64) {
      // Handle fixnum Int64 type
      return IntValue(value.toInt());
    } else if (value is int) {
      // Default to signed int, but could be uint based on field definition
      return IntValue(value);
    } else if (value is double) {
      return DoubleValue(value);
    } else if (value is String) {
      return StringValue(value);
    } else if (value is List<int>) {
      // Bytes
      return BytesValue(Uint8List.fromList(value));
    } else if (value is ProtobufEnum) {
      // Handle enums based on global mode with context
      return _adaptProtobufEnumWithContext(value, contextMessage);
    } else {
      // Unknown type, return as null
      return NullValue();
    }
  }

  /// Get default value for a field type
  Value _getDefaultValueForType(int fieldType) {
    // Use the PbFieldType constants directly
    // Check the lower bits to determine the base type
    // The type encoding uses bits to represent different types

    // These constants are from PbFieldType but not exposed, so we use the values directly
    const BOOL_BIT = 0x10;
    const BYTES_BIT = 0x20;
    const STRING_BIT = 0x40;
    const DOUBLE_BIT = 0x80;
    const FLOAT_BIT = 0x100;
    const ENUM_BIT = 0x200;
    const INT32_BIT = 0x800;
    const INT64_BIT = 0x1000;
    const SINT32_BIT = 0x2000;
    const SINT64_BIT = 0x4000;
    const UINT32_BIT = 0x8000;
    const UINT64_BIT = 0x10000;
    const FIXED32_BIT = 0x20000;
    const FIXED64_BIT = 0x40000;
    const SFIXED32_BIT = 0x80000;
    const SFIXED64_BIT = 0x100000;
    const MESSAGE_BIT = 0x200000;

    // Strip modifier bits (repeated, required, packed, map)
    // These are the lower 3 bits and bit 22 (map)
    const MODIFIER_MASK = 0x400007;
    final baseType = fieldType & ~MODIFIER_MASK;

    if ((baseType & BOOL_BIT) != 0) {
      return BooleanValue(false);
    } else if ((baseType & STRING_BIT) != 0) {
      return StringValue('');
    } else if ((baseType & BYTES_BIT) != 0) {
      return BytesValue(Uint8List(0));
    } else if ((baseType & (DOUBLE_BIT | FLOAT_BIT)) != 0) {
      return DoubleValue(0.0);
    } else if ((baseType &
            (INT32_BIT |
                INT64_BIT |
                SINT32_BIT |
                SINT64_BIT |
                SFIXED32_BIT |
                SFIXED64_BIT |
                ENUM_BIT)) !=
        0) {
      return IntValue(0);
    } else if ((baseType &
            (UINT32_BIT | UINT64_BIT | FIXED32_BIT | FIXED64_BIT)) !=
        0) {
      return UintValue(0);
    } else if ((baseType & MESSAGE_BIT) != 0) {
      return NullValue();
    } else {
      return NullValue();
    }
  }

  /// Adapt a protobuf enum value based on the current global enum mode with context
  Value _adaptProtobufEnumWithContext(ProtobufEnum enumValue, GeneratedMessage? contextMessage) {
    if (globalEnumRegistry.isGlobalLegacyMode) {
      // Legacy mode: enums are represented as integers
      return IntValue(enumValue.value);
    } else {
      // Strong mode: enums are distinct types
      final enumTypeName = _getEnumTypeNameWithContext(enumValue, contextMessage);
      return EnumValue.createStrong(enumTypeName, enumValue.value);
    }
  }
  
  /// Get the enum type name from field information using protobuf metadata
  String _getEnumTypeNameFromField(FieldInfo field, GeneratedMessage contextMessage) {
    // Get the container from the message type
    final messageTypeName = contextMessage.info_.qualifiedMessageName;
    final containerParts = messageTypeName.split('.');
    String container = '';
    if (containerParts.length >= 3) {
      // Remove the last part (message name) to get the container
      container = containerParts.take(containerParts.length - 1).join('.');
    }
    
    // Try to get enum type information from the field's metadata
    // This is a generic approach that doesn't rely on hardcoded test names
    try {
      final enumValues = field.enumValues;
      if (enumValues != null && enumValues.isNotEmpty) {
        // Get the enum type from the first enum value's runtime type
        final enumTypeName = enumValues.first.runtimeType.toString();
        
        // Handle nested enum types like TestAllTypes_NestedEnum
        if (enumTypeName.contains('_')) {
          // Convert TestAllTypes_NestedEnum to TestAllTypes.NestedEnum
          final parts = enumTypeName.split('_');
          if (parts.length >= 2) {
            final messageName = parts[0];
            final enumName = parts.sublist(1).join('_');
            
            if (container.isNotEmpty) {
              return '$container.$messageName.$enumName';
            } else {
              return '$messageName.$enumName';
            }
          }
        }
        
        // For non-nested enums, use the type name directly
        if (container.isNotEmpty) {
          return '$container.$enumTypeName';
        } else {
          return enumTypeName;
        }
      }
    } catch (_) {
      // If enum introspection fails, continue with fallback
    }
    
    // Fallback: use a generic enum name with the container
    if (container.isNotEmpty) {
      return '$container.UnknownEnum';
    } else {
      return 'UnknownEnum';
    }
  }

  /// Get the fully qualified enum type name from a ProtobufEnum instance with context
  String _getEnumTypeNameWithContext(ProtobufEnum enumValue, GeneratedMessage? contextMessage) {
    // Extract type name from the runtime type
    final typeName = enumValue.runtimeType.toString();
    
    // Use context message to determine the proper container
    String container = '';
    if (contextMessage != null) {
      final messageTypeName = contextMessage.info_.qualifiedMessageName;
      // Extract container from message type name
      final parts = messageTypeName.split('.');
      if (parts.length >= 3) {
        // Remove the last part (message name) to get the container
        container = parts.take(parts.length - 1).join('.');
      }
    }
    
    // Handle nested enum types like TestAllTypes_NestedEnum
    if (typeName.contains('_')) {
      // Convert TestAllTypes_NestedEnum to TestAllTypes.NestedEnum
      final parts = typeName.split('_');
      if (parts.length >= 2) {
        final messageName = parts[0];
        final enumName = parts.sublist(1).join('_');
        
        if (container.isNotEmpty) {
          return '$container.$messageName.$enumName';
        } else {
          return '$messageName.$enumName';
        }
      }
    }
    
    // For non-nested enums (like GlobalEnum)
    if (container.isNotEmpty) {
      return '$container.$typeName';
    }
    
    // Fallback: use the type name as-is
    return typeName;
  }

  /// Safely adapt an enum field value that might contain unknown enum values
  /// Uses getFieldOrNull to access raw values that might be _UnknownEnumValue objects
  Value _adaptEnumFieldSafely(GeneratedMessage msg, FieldInfo field) {
    // Use getFieldOrNull to access the raw stored value, which preserves _UnknownEnumValue objects
    final rawValue = msg.getFieldOrNull(field.tagNumber);
    
    if (rawValue != null) {
      // Check if this is an unknown enum value
      if (rawValue.toString().startsWith('UNKNOWN_ENUM_VALUE_')) {
        // Extract the integer value from the unknown enum
        final enumValue = (rawValue as dynamic).value as int;
        if (globalEnumRegistry.isGlobalLegacyMode) {
          // Legacy mode: return the integer value
          return IntValue(enumValue);
        } else {
          // Strong mode: return as a strong enum with the proper type name
          // For unknown enum values, we need to infer the type from the field info
          final enumTypeName = _getEnumTypeNameFromField(field, msg);
          return EnumValue.createStrong(enumTypeName, enumValue);
        }
      } else {
        // This is a known enum value, handle normally
        return _adaptSingleValueWithContext(rawValue, msg);
      }
    } else {
      // For enum fields, we need to check if there's a default value
      // Even when hasField is false, protobuf might return a valid enum
      try {
        final fieldValue = msg.getField(field.tagNumber);
        if (fieldValue != null) {
          return _adaptSingleValueWithContext(fieldValue, msg);
        }
      } catch (_) {
        // If getField fails, continue to default handling
      }
      
      // Field is not set, return default
      return _getDefaultValueForType(field.type);
    }
  }

  /// Convert a double to float32 precision (IEEE 754 single precision)
  double _toFloat32(double value) {
    // Use typed_data to convert to 32-bit float precision
    final buffer = ByteData(4);
    buffer.setFloat32(0, value, Endian.host);
    return buffer.getFloat32(0, Endian.host);
  }
}
