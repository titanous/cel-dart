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
// import '../timestamp.dart'; // TODO: Implement when available
// import '../duration.dart'; // TODO: Implement when available
import '../null_.dart';
import 'message.dart';
import '../../../gen/google/protobuf/wrappers.pb.dart' as pb_wrappers;
import '../../../gen/google/protobuf/struct.pb.dart' as pb_struct;

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
      final list = msg.getField(field.tagNumber) as List;
      // For repeated fields, adapt each element
      final elements = <Value>[];
      for (final element in list) {
        elements.add(_adaptSingleValue(element));
      }
      return ListValue(elements, typeAdapter);
    } else if (field.isMapField) {
      // Handle map fields
      final map = msg.getField(field.tagNumber) as Map;
      final entries = <Value, Value>{};
      for (final entry in map.entries) {
        // For now, assume string keys and adapt values
        entries[_adaptSingleValue(entry.key)] = _adaptSingleValue(entry.value);
      }
      return MapValue(entries, typeAdapter);
    } else {
      // Handle singular fields
      final hasField = msg.hasField(field.tagNumber);
      final value = msg.getField(field.tagNumber);

      if (!hasField) {
        // For wrapper types, check if they have been explicitly set with a value
        if (_isWrapperType(value)) {
          // For wrapper types, check if they contain a non-default value
          if (_hasWrapperValue(value)) {
            // Wrapper has a value, process it normally
            return _adaptSingleValue(value);
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
          return _adaptSingleValue(value);
        }
        
        // Return default value for unset non-wrapper, non-message fields
        return _getDefaultValueForType(field.type);
      }
      return _adaptSingleValue(value);
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
        value is pb_struct.Struct;  // google.protobuf.Struct should also auto-convert
  }

  /// Check if a field is a message field (not a wrapper type)
  bool _isMessageField(FieldInfo field) {
    // Message fields have the MESSAGE_BIT set in their type
    const MESSAGE_BIT = 0x200000;
    const MODIFIER_MASK = 0x400007;
    final baseType = field.type & ~MODIFIER_MASK;
    return (baseType & MESSAGE_BIT) != 0;
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
      return value.hasValue();
    } else if (value is pb_wrappers.BytesValue) {
      return value.hasValue();
    } else if (value is pb_wrappers.StringValue) {
      return value.hasValue();
    } else if (value is pb_wrappers.DoubleValue) {
      return value.hasValue();
    } else if (value is pb_wrappers.FloatValue) {
      return value.hasValue();
    } else if (value is pb_wrappers.Int32Value) {
      return value.hasValue();
    } else if (value is pb_wrappers.Int64Value) {
      return value.hasValue();
    } else if (value is pb_wrappers.UInt32Value) {
      return value.hasValue();
    } else if (value is pb_wrappers.UInt64Value) {
      return value.hasValue();
    }

    return false;
  }

  /// Adapt a single value to CEL value based on its runtime type
  Value _adaptSingleValue(dynamic value) {
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
      } else if (value is pb_wrappers.DoubleValue) {
        return DoubleValue(value.value);
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
      // Enums are represented as integers
      return IntValue(value.value);
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

  /// Convert a double to float32 precision (IEEE 754 single precision)
  double _toFloat32(double value) {
    // Use typed_data to convert to 32-bit float precision
    final buffer = ByteData(4);
    buffer.setFloat32(0, value, Endian.host);
    return buffer.getFloat32(0, Endian.host);
  }
}
