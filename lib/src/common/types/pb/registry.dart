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
import '../../../gen/cel/expr/conformance/proto2/test_all_types.pb.dart' as proto2;
import '../../../gen/cel/expr/conformance/proto3/test_all_types.pb.dart' as proto3;

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
  void registerMessageType(String typeName, BuilderInfo info, GeneratedMessage Function() constructor) {
    _types[typeName] = info;
    _constructors[typeName] = constructor;
  }
  
  /// Register a file descriptor (for future use with descriptor.proto)
  void registerFileDescriptor(dynamic fd) {
    // TODO: Implement when we have FileDescriptorProto support
    // This will parse the descriptor and register all types
  }
  
  /// Create a new message instance by type name
  MessageValue? createMessage(String typeName) {
    final constructor = _constructors[typeName];
    if (constructor != null) {
      return MessageValue(constructor(), typeAdapter);
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
  
  /// Register all Well-Known Types
  void _registerWellKnownTypes() {
    // Wrapper types
    registerMessageType(
        'type.googleapis.com/google.protobuf.DoubleValue',
        pb_wrappers.DoubleValue().info_,
        () => pb_wrappers.DoubleValue());
    registerMessageType(
        'type.googleapis.com/google.protobuf.FloatValue',
        pb_wrappers.FloatValue().info_,
        () => pb_wrappers.FloatValue());
    registerMessageType(
        'type.googleapis.com/google.protobuf.Int64Value',
        pb_wrappers.Int64Value().info_,
        () => pb_wrappers.Int64Value());
    registerMessageType(
        'type.googleapis.com/google.protobuf.UInt64Value',
        pb_wrappers.UInt64Value().info_,
        () => pb_wrappers.UInt64Value());
    registerMessageType(
        'type.googleapis.com/google.protobuf.Int32Value',
        pb_wrappers.Int32Value().info_,
        () => pb_wrappers.Int32Value());
    registerMessageType(
        'type.googleapis.com/google.protobuf.UInt32Value',
        pb_wrappers.UInt32Value().info_,
        () => pb_wrappers.UInt32Value());
    registerMessageType(
        'type.googleapis.com/google.protobuf.BoolValue',
        pb_wrappers.BoolValue().info_,
        () => pb_wrappers.BoolValue());
    registerMessageType(
        'type.googleapis.com/google.protobuf.StringValue',
        pb_wrappers.StringValue().info_,
        () => pb_wrappers.StringValue());
    registerMessageType(
        'type.googleapis.com/google.protobuf.BytesValue',
        pb_wrappers.BytesValue().info_,
        () => pb_wrappers.BytesValue());
    
    // Timestamp and Duration
    registerMessageType(
        'type.googleapis.com/google.protobuf.Timestamp',
        pb_timestamp.Timestamp().info_,
        () => pb_timestamp.Timestamp());
    registerMessageType(
        'type.googleapis.com/google.protobuf.Duration',
        pb_duration.Duration().info_,
        () => pb_duration.Duration());
    
    // Any type
    registerMessageType(
        'type.googleapis.com/google.protobuf.Any',
        pb_any.Any().info_,
        () => pb_any.Any());
    
    // Other Well-Known Types
    registerMessageType(
        'type.googleapis.com/google.protobuf.Empty',
        pb_empty.Empty().info_,
        () => pb_empty.Empty());
    registerMessageType(
        'type.googleapis.com/google.protobuf.Struct',
        pb_struct.Struct().info_,
        () => pb_struct.Struct());
    registerMessageType(
        'type.googleapis.com/google.protobuf.Value',
        pb_struct.Value().info_,
        () => pb_struct.Value());
    registerMessageType(
        'type.googleapis.com/google.protobuf.ListValue',
        pb_struct.ListValue().info_,
        () => pb_struct.ListValue());
    registerMessageType(
        'type.googleapis.com/google.protobuf.FieldMask',
        pb_field_mask.FieldMask().info_,
        () => pb_field_mask.FieldMask());
    
    // Test types for conformance tests
    registerMessageType(
        'type.googleapis.com/cel.expr.conformance.proto2.TestAllTypes',
        proto2.TestAllTypes().info_,
        () => proto2.TestAllTypes());
    registerMessageType(
        'type.googleapis.com/cel.expr.conformance.proto3.TestAllTypes',
        proto3.TestAllTypes().info_,
        () => proto3.TestAllTypes());
  }
}