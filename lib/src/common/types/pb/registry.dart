import 'dart:convert';
import 'package:protobuf/protobuf.dart';
import 'package:fixnum/fixnum.dart';
import '../ref/value.dart';
import '../ref/provider.dart';
import '../provider.dart' as cel_provider;
import 'message.dart';
import 'adapter.dart';

// Import Well-Known Types with prefixes to avoid conflicts
import '../../../gen/google/protobuf/wrappers.pb.dart' as pb_wrappers;
import '../../../gen/google/protobuf/timestamp.pb.dart' as pb_timestamp;
import '../../../gen/google/protobuf/duration.pb.dart' as pb_duration;
import '../../../gen/google/protobuf/any.pb.dart' as pb_any;
import '../../../gen/google/protobuf/empty.pb.dart' as pb_empty;
import '../../../gen/google/protobuf/struct.pb.dart' as pb_struct;
import '../../../gen/google/protobuf/field_mask.pb.dart' as pb_field_mask;

// Import test types for conformance tests
import '../../../gen/cel/expr/conformance/proto2/test_all_types.pb.dart'
    as proto2;
import '../../../gen/cel/expr/conformance/proto3/test_all_types.pb.dart'
    as proto3;

/// Registry for protobuf types in CEL
class ProtoTypeRegistry {
  final Map<String, BuilderInfo> _types = {};
  final Map<String, GeneratedMessage Function()> _constructors = {};
  final TypeAdapter typeAdapter = cel_provider.TypeRegistry();
  late final ProtobufTypeAdapter _adapter;

  ProtoTypeRegistry() {
    _adapter = ProtobufTypeAdapter(typeAdapter);
    _registerWellKnownTypes();
  }

  /// Register a message type with its constructor
  void registerMessageType(String typeName, BuilderInfo info,
      GeneratedMessage Function() constructor) {
    _types[typeName] = info;
    _constructors[typeName] = constructor;
  }

  /// Register a file descriptor (for future use with descriptor.proto)
  void registerFileDescriptor(dynamic fd) {
    // TODO: Implement when we have FileDescriptorProto support
    // This will parse the descriptor and register all types
  }

  /// Create a new message instance by type name
  MessageValue? createMessage(String typeName, [Map<String, dynamic>? fields]) {
    final constructor = _constructors[typeName];
    if (constructor != null) {
      final message = constructor();
      
      // If fields are provided, set them on the message
      if (fields != null) {
        for (final entry in fields.entries) {
          _setFieldValue(message, entry.key, entry.value);
        }
      }
      
      return MessageValue(message, typeAdapter);
    }
    return null;
  }

  /// Check if a type is registered
  bool hasType(String typeName) {
    return _constructors.containsKey(typeName);
  }

  /// Get the BuilderInfo for a type
  BuilderInfo? getBuilderInfo(String typeName) {
    return _types[typeName];
  }

  /// Convert a protobuf message to CEL value
  Value adaptMessage(GeneratedMessage msg) {
    return _adapter.adaptMessage(msg);
  }

  /// Set a field value on a protobuf message
  void _setFieldValue(GeneratedMessage message, String fieldName, dynamic value) {
    final info = message.info_;
    
    // Find the field by name (try both snake_case and camelCase)
    FieldInfo? matchingField;
    for (final field in info.fieldInfo.values) {
      if (_matchesFieldName(field, fieldName)) {
        matchingField = field;
        break;
      }
    }
    
    if (matchingField != null) {
      final convertedValue = _convertValueForField(matchingField, value);
      message.setField(matchingField.tagNumber, convertedValue);
    }
  }

  /// Convert a value to the appropriate type for a protobuf field
  dynamic _convertValueForField(FieldInfo field, dynamic value) {
    // Check if this field expects a wrapper type
    final fieldTypeName = _getFieldTypeName(field);
    
    if (_isWrapperTypeName(fieldTypeName) && fieldTypeName != null) {
      // This field expects a wrapper type, so we need to create one
      return _createWrapperValue(fieldTypeName, value);
    }
    
    // Handle basic type conversions for non-wrapper fields
    return _convertBasicTypes(field, value);
  }
  
  /// Convert basic types to match protobuf field expectations
  dynamic _convertBasicTypes(FieldInfo field, dynamic value) {
    // Handle int64 fields (including sint64) - convert Dart int to Int64
    if (field.type == 4096 || field.type == 16384) { // int64 or sint64
      if (value is int) {
        return Int64(value);
      }
      if (value is num) {
        return Int64(value.toInt());
      }
    }
    
    // Handle uint64 fields - convert Dart int to Int64  
    if (field.type == 65536) { // uint64
      if (value is int) {
        return Int64(value);
      }
      if (value is num) {
        return Int64(value.toInt());
      }
    }
    
    // Handle message fields that need special conversion
    if (field.type == 2097152) { // message
      return _convertMessageField(field, value);
    }
    
    // For other fields, return the value as-is
    // The protobuf library will handle remaining basic type conversions
    return value;
  }
  
  /// Convert values for message fields (ListValue, Any, etc.)
  dynamic _convertMessageField(FieldInfo field, dynamic value) {
    // Get the message type name if available - we need to check field's qualifiedMessageName
    // For now, use heuristics based on field name until we have proper type introspection
    final fieldName = field.name.toLowerCase();
    
    // Handle google.protobuf.ListValue fields
    if (fieldName.contains('list_value') || fieldName.contains('listvalue')) {
      if (value is List) {
        return _createListValue(value);
      }
    }
    
    // Handle google.protobuf.Value fields  
    if (fieldName.contains('single_value') || (fieldName.contains('value') && !fieldName.contains('wrapper'))) {
      return _createValue(value);
    }
    
    // Handle google.protobuf.Any fields
    if (fieldName.contains('any')) {
      return _createAny(value);
    }
    
    // Handle google.protobuf.Struct fields
    if (fieldName.contains('struct')) {
      if (value is Map) {
        return _createStruct(value);
      }
    }
    
    // For other message fields, return as-is and let protobuf library handle it
    return value;
  }
  
  /// Create a google.protobuf.ListValue from a Dart List
  dynamic _createListValue(List<dynamic> list) {
    // Import the ListValue type
    final listValue = pb_struct.ListValue();
    
    for (final item in list) {
      listValue.values.add(_createValue(item));
    }
    
    return listValue;
  }
  
  /// Create a google.protobuf.Value from a Dart value
  pb_struct.Value _createValue(dynamic value) {
    final protoValue = pb_struct.Value();
    
    if (value == null) {
      protoValue.nullValue = pb_struct.NullValue.NULL_VALUE;
    } else if (value is bool) {
      protoValue.boolValue = value;
    } else if (value is int) {
      protoValue.numberValue = value.toDouble();
    } else if (value is double) {
      if (value.isNaN) {
        protoValue.stringValue = 'NaN';
      } else if (value.isInfinite) {
        protoValue.stringValue = value.isNegative ? '-Infinity' : 'Infinity';
      } else {
        protoValue.numberValue = value;
      }
    } else if (value is String) {
      protoValue.stringValue = value;
    } else if (value is List) {
      protoValue.listValue = _createListValue(value);
    } else if (value is Map<String, dynamic>) {
      protoValue.structValue = _createStruct(value);
    } else {
      // For other types, convert to string
      protoValue.stringValue = value.toString();
    }
    
    return protoValue;
  }
  
  /// Create a google.protobuf.Struct from a Dart Map
  pb_struct.Struct _createStruct(Map<dynamic, dynamic> map) {
    final struct = pb_struct.Struct();
    
    for (final entry in map.entries) {
      if (entry.key is String) {
        struct.fields[entry.key as String] = _createValue(entry.value);
      }
    }
    
    return struct;
  }
  
  /// Create a google.protobuf.Any from a Dart value  
  dynamic _createAny(dynamic value) {
    // For now, implement basic Any conversion
    // This is complex and would need full type information
    // Let protobuf library handle it for now
    return value;
  }

  /// Get the type name for a field (approximate)
  String? _getFieldTypeName(FieldInfo field) {
    // This is a simplified approach - in a real implementation,
    // we'd need to look up the actual field type from the proto definition
    // For now, we'll use heuristics based on field names
    
    final fieldName = field.name.toLowerCase();
    if (fieldName.endsWith('wrapper')) {
      // Order matters: check uint64 before int64 to avoid false matches
      if (fieldName.contains('uint64')) return 'google.protobuf.UInt64Value';
      if (fieldName.contains('uint32')) return 'google.protobuf.UInt32Value';
      if (fieldName.contains('int64')) return 'google.protobuf.Int64Value';
      if (fieldName.contains('int32')) return 'google.protobuf.Int32Value';
      if (fieldName.contains('float')) return 'google.protobuf.FloatValue';
      if (fieldName.contains('double')) return 'google.protobuf.DoubleValue';
      if (fieldName.contains('bool')) return 'google.protobuf.BoolValue';
      if (fieldName.contains('string')) return 'google.protobuf.StringValue';
      if (fieldName.contains('bytes')) return 'google.protobuf.BytesValue';
    }
    
    return null;
  }

  /// Check if a type name is a wrapper type
  bool _isWrapperTypeName(String? typeName) {
    if (typeName == null) return false;
    return typeName.startsWith('google.protobuf.') && 
           (typeName.endsWith('Value') && typeName != 'google.protobuf.Value');
  }

  /// Create a wrapper value of the specified type
  dynamic _createWrapperValue(String typeName, dynamic value) {
    switch (typeName) {
      case 'google.protobuf.Int32Value':
        final wrapper = pb_wrappers.Int32Value();
        wrapper.value = _convertToInt(value);
        return wrapper;
      case 'google.protobuf.Int64Value':
        final wrapper = pb_wrappers.Int64Value();
        wrapper.value = _convertToInt64(value);
        return wrapper;
      case 'google.protobuf.UInt32Value':
        final wrapper = pb_wrappers.UInt32Value();
        wrapper.value = _convertToInt(value);
        return wrapper;
      case 'google.protobuf.UInt64Value':
        final wrapper = pb_wrappers.UInt64Value();
        wrapper.value = _convertToInt64(value);
        return wrapper;
      case 'google.protobuf.FloatValue':
        final wrapper = pb_wrappers.FloatValue();
        wrapper.value = value is num ? value.toDouble() : 0.0;
        return wrapper;
      case 'google.protobuf.DoubleValue':
        final wrapper = pb_wrappers.DoubleValue();
        wrapper.value = value is num ? value.toDouble() : 0.0;
        return wrapper;
      case 'google.protobuf.BoolValue':
        final wrapper = pb_wrappers.BoolValue();
        wrapper.value = value is bool ? value : false;
        return wrapper;
      case 'google.protobuf.StringValue':
        final wrapper = pb_wrappers.StringValue();
        wrapper.value = value?.toString() ?? '';
        return wrapper;
      case 'google.protobuf.BytesValue':
        final wrapper = pb_wrappers.BytesValue();
        if (value is List<int>) {
          wrapper.value = value;
        } else if (value is String) {
          wrapper.value = utf8.encode(value);
        } else {
          wrapper.value = <int>[];
        }
        return wrapper;
      default:
        return value;
    }
  }

  /// Check if a field matches the given name (either proto name or Dart property name)
  bool _matchesFieldName(FieldInfo field, String name) {
    // Check Dart property name (camelCase)
    if (field.name == name) {
      return true;
    }

    // Check proto field name (snake_case)
    final snakeCase = _toSnakeCase(field.name);
    if (snakeCase == name) {
      return true;
    }

    // Also try converting the given name to camelCase
    final camelCase = _toCamelCase(name);
    if (camelCase == field.name) {
      return true;
    }

    return false;
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

  /// Register all Well-Known Types
  void _registerWellKnownTypes() {
    // Wrapper types
    registerMessageType('type.googleapis.com/google.protobuf.DoubleValue',
        pb_wrappers.DoubleValue().info_, () => pb_wrappers.DoubleValue());
    registerMessageType('type.googleapis.com/google.protobuf.FloatValue',
        pb_wrappers.FloatValue().info_, () => pb_wrappers.FloatValue());
    registerMessageType('type.googleapis.com/google.protobuf.Int64Value',
        pb_wrappers.Int64Value().info_, () => pb_wrappers.Int64Value());
    registerMessageType('type.googleapis.com/google.protobuf.UInt64Value',
        pb_wrappers.UInt64Value().info_, () => pb_wrappers.UInt64Value());
    registerMessageType('type.googleapis.com/google.protobuf.Int32Value',
        pb_wrappers.Int32Value().info_, () => pb_wrappers.Int32Value());
    registerMessageType('type.googleapis.com/google.protobuf.UInt32Value',
        pb_wrappers.UInt32Value().info_, () => pb_wrappers.UInt32Value());
    registerMessageType('type.googleapis.com/google.protobuf.BoolValue',
        pb_wrappers.BoolValue().info_, () => pb_wrappers.BoolValue());
    registerMessageType('type.googleapis.com/google.protobuf.StringValue',
        pb_wrappers.StringValue().info_, () => pb_wrappers.StringValue());
    registerMessageType('type.googleapis.com/google.protobuf.BytesValue',
        pb_wrappers.BytesValue().info_, () => pb_wrappers.BytesValue());

    // Timestamp and Duration
    registerMessageType('type.googleapis.com/google.protobuf.Timestamp',
        pb_timestamp.Timestamp().info_, () => pb_timestamp.Timestamp());
    registerMessageType('type.googleapis.com/google.protobuf.Duration',
        pb_duration.Duration().info_, () => pb_duration.Duration());

    // Any type
    registerMessageType('type.googleapis.com/google.protobuf.Any',
        pb_any.Any().info_, () => pb_any.Any());

    // Other Well-Known Types
    registerMessageType('type.googleapis.com/google.protobuf.Empty',
        pb_empty.Empty().info_, () => pb_empty.Empty());
    registerMessageType('type.googleapis.com/google.protobuf.Struct',
        pb_struct.Struct().info_, () => pb_struct.Struct());
    registerMessageType('type.googleapis.com/google.protobuf.Value',
        pb_struct.Value().info_, () => pb_struct.Value());
    registerMessageType('type.googleapis.com/google.protobuf.ListValue',
        pb_struct.ListValue().info_, () => pb_struct.ListValue());
    registerMessageType('type.googleapis.com/google.protobuf.FieldMask',
        pb_field_mask.FieldMask().info_, () => pb_field_mask.FieldMask());

    // Test types for conformance tests
    registerMessageType(
        'type.googleapis.com/cel.expr.conformance.proto2.TestAllTypes',
        proto2.TestAllTypes().info_,
        () => proto2.TestAllTypes());
    registerMessageType(
        'type.googleapis.com/cel.expr.conformance.proto3.TestAllTypes',
        proto3.TestAllTypes().info_,
        () => proto3.TestAllTypes());
    // Also register with fully qualified names for direct resolution
    registerMessageType('cel.expr.conformance.proto2.TestAllTypes',
        proto2.TestAllTypes().info_, () => proto2.TestAllTypes());
    registerMessageType('cel.expr.conformance.proto3.TestAllTypes',
        proto3.TestAllTypes().info_, () => proto3.TestAllTypes());
  }

  /// Convert a value to int, handling Int64 and other numeric types
  int _convertToInt(dynamic value) {
    if (value is int) return value;
    if (value is Int64) return value.toInt();
    if (value is num) return value.toInt();
    return 0;
  }

  /// Convert a value to Int64, handling int and other numeric types  
  Int64 _convertToInt64(dynamic value) {
    if (value is Int64) return value;
    if (value is int) return Int64(value);
    if (value is num) return Int64(value.toInt());
    return Int64.ZERO;
  }

  /// Check if a message should auto-unwrap to its CEL value equivalent
  bool _shouldAutoUnwrap(GeneratedMessage message) {
    // google.protobuf.Value should unwrap to its underlying CEL value
    if (message is pb_struct.Value) {
      return true;
    }
    
    // google.protobuf.ListValue should unwrap to a CEL List
    if (message is pb_struct.ListValue) {
      return true;
    }
    
    // google.protobuf.Struct should unwrap to a CEL Map  
    if (message is pb_struct.Struct) {
      return true;
    }
    
    // Wrapper types should also auto-unwrap (this is consistent with existing behavior)
    if (message is pb_wrappers.BoolValue ||
        message is pb_wrappers.BytesValue ||
        message is pb_wrappers.StringValue ||
        message is pb_wrappers.DoubleValue ||
        message is pb_wrappers.FloatValue ||
        message is pb_wrappers.Int32Value ||
        message is pb_wrappers.Int64Value ||
        message is pb_wrappers.UInt32Value ||
        message is pb_wrappers.UInt64Value) {
      return true;
    }
    
    return false;
  }
}
