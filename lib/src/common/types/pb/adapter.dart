import 'dart:typed_data';
import 'package:protobuf/protobuf.dart';
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

/// Adapter for converting protobuf messages to CEL values
class ProtobufTypeAdapter {
  final TypeAdapter typeAdapter;
  
  ProtobufTypeAdapter(this.typeAdapter);
  
  /// Convert a GeneratedMessage to a CEL Value
  Value adaptMessage(GeneratedMessage msg) {
    return MessageValue(msg);
  }

  /// Get a field value from a message
  Value getField(GeneratedMessage msg, String fieldName) {
    final info = msg.info_;
    
    // Find the field info
    for (final field in info.fieldInfo.values) {
      if (field.name == fieldName) {
        return _adaptFieldValue(msg, field);
      }
    }
    
    // Field not found
    return NullValue();
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
      if (!msg.hasField(field.tagNumber)) {
        // Return default value for unset fields
        return _getDefaultValueForType(field.type);
      }
      final value = msg.getField(field.tagNumber);
      return _adaptSingleValue(value);
    }
  }
  
  /// Adapt a single value to CEL value based on its runtime type
  Value _adaptSingleValue(dynamic value) {
    if (value == null) {
      return NullValue();
    }
    
    // Determine type based on runtime type
    if (value is bool) {
      return BooleanValue(value);
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
    } else if (value is GeneratedMessage) {
      // Nested message
      return adaptMessage(value);
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
    } else if ((baseType & (INT32_BIT | INT64_BIT | SINT32_BIT | SINT64_BIT | 
                            SFIXED32_BIT | SFIXED64_BIT | ENUM_BIT)) != 0) {
      return IntValue(0);
    } else if ((baseType & (UINT32_BIT | UINT64_BIT | FIXED32_BIT | FIXED64_BIT)) != 0) {
      return UintValue(0);
    } else if ((baseType & MESSAGE_BIT) != 0) {
      return NullValue();
    } else {
      return NullValue();
    }
  }
}