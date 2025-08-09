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
      final elements = list.map((e) => _adaptValue(e, field)).toList();
      return ListValue(elements, typeAdapter);
    } else if (field.isMapField) {
      // Handle map fields
      final map = msg.getField(field.tagNumber) as Map;
      final entries = <Value, Value>{};
      for (final entry in map.entries) {
        entries[_adaptValue(entry.key, field)] = _adaptValue(entry.value, field);
      }
      return MapValue(entries, typeAdapter);
    } else {
      // Handle singular fields
      if (!msg.hasField(field.tagNumber)) {
        // Return default value for unset fields
        return _getDefaultValue(field);
      }
      final value = msg.getField(field.tagNumber);
      return _adaptValue(value, field);
    }
  }
  
  /// Adapt a single value to CEL value based on field type
  Value _adaptValue(dynamic value, FieldInfo field) {
    if (value == null) {
      return NullValue();
    }
    
    // Handle different field types
    switch (field.type) {
      case PbFieldType.OB:  // bool
        return BooleanValue(value as bool);
      case PbFieldType.O3:  // int32
      case PbFieldType.O6:  // int64
      case PbFieldType.OS3: // sint32
      case PbFieldType.OS6: // sint64
      case PbFieldType.OSF3: // sfixed32
      case PbFieldType.OSF6: // sfixed64
        if (value is int) {
          return IntValue(value);
        }
        return IntValue(value as int);
      case PbFieldType.OU3: // uint32
      case PbFieldType.OU6: // uint64
      case PbFieldType.OF3: // fixed32
      case PbFieldType.OF6: // fixed64
        if (value is int) {
          return UintValue(value);
        }
        return UintValue(value as int);
      case PbFieldType.OF:  // float
      case PbFieldType.OD:  // double
        if (value is double) {
          return DoubleValue(value);
        } else if (value is int) {
          return DoubleValue(value.toDouble());
        }
        return DoubleValue(value as double);
      case PbFieldType.OS:  // string
        return StringValue(value as String);
      case PbFieldType.OY:  // bytes
        if (value is List<int>) {
          return BytesValue(Uint8List.fromList(value));
        }
        return BytesValue(Uint8List.fromList(value as List<int>));
      case PbFieldType.OE:  // enum
        // Enums are represented as integers
        if (value is ProtobufEnum) {
          return IntValue(value.value);
        }
        return IntValue(value as int);
      case PbFieldType.OM:  // message
        if (value is GeneratedMessage) {
          return adaptMessage(value);
        }
        return NullValue();
      default:
        // For repeated/map field types, this should not happen
        // as they're handled separately
        return NullValue();
    }
  }
  
  /// Get default value for a field
  Value _getDefaultValue(FieldInfo field) {
    switch (field.type) {
      case PbFieldType.OB:  // bool
        return BooleanValue(false);
      case PbFieldType.O3:  // int32
      case PbFieldType.O6:  // int64
      case PbFieldType.OS3: // sint32
      case PbFieldType.OS6: // sint64
      case PbFieldType.OSF3: // sfixed32
      case PbFieldType.OSF6: // sfixed64
        return IntValue(0);
      case PbFieldType.OU3: // uint32
      case PbFieldType.OU6: // uint64
      case PbFieldType.OF3: // fixed32
      case PbFieldType.OF6: // fixed64
        return UintValue(0);
      case PbFieldType.OF:  // float
      case PbFieldType.OD:  // double
        return DoubleValue(0.0);
      case PbFieldType.OS:  // string
        return StringValue('');
      case PbFieldType.OY:  // bytes
        return BytesValue(Uint8List(0));
      case PbFieldType.OE:  // enum
        return IntValue(0);
      case PbFieldType.OM:  // message
        return NullValue();
      default:
        return NullValue();
    }
  }
}