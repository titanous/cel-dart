import 'package:protobuf/protobuf.dart';
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
      // Convert the value to the appropriate protobuf type and set it
      message.setField(matchingField.tagNumber, value);
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
}
