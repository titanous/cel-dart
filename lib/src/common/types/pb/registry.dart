import 'package:protobuf/protobuf.dart';
import '../ref/value.dart';
import '../ref/provider.dart';
import '../provider.dart' as cel_provider;
import 'message.dart';
import 'adapter.dart';

/// Registry for protobuf types in CEL
class ProtoTypeRegistry {
  final Map<String, BuilderInfo> _types = {};
  final Map<String, GeneratedMessage Function()> _constructors = {};
  final TypeAdapter typeAdapter = cel_provider.TypeRegistry();
  late final ProtobufTypeAdapter _adapter;
  
  ProtoTypeRegistry() {
    _adapter = ProtobufTypeAdapter(typeAdapter);
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
}