import 'package:protobuf/protobuf.dart';
import '../ref/value.dart';
import '../traits/indexer.dart';
import '../traits/field_tester.dart';
import '../string.dart';
import '../null_.dart';
import '../bool.dart';
import '../ref/provider.dart';
import '../provider.dart' as cel_provider;
import 'adapter.dart';

/// CEL wrapper for protobuf messages
class MessageValue extends Value implements Indexer, FieldTester {
  final GeneratedMessage message;
  final TypeAdapter typeAdapter;
  late final ProtobufTypeAdapter _adapter;
  
  MessageValue(this.message, [TypeAdapter? typeAdapter]) 
      : typeAdapter = typeAdapter ?? cel_provider.TypeRegistry() {
    _adapter = ProtobufTypeAdapter(this.typeAdapter);
  }
  
  @override
  String get celTypeValue => message.info_.qualifiedMessageName;
  
  @override
  Type_ get type => Type_(celTypeValue);
  
  @override
  dynamic get value => message;
  
  @override
  Value convertToNative() => this;
  
  @override
  bool equal(Value other) {
    if (other is MessageValue) {
      return message == other.message;
    }
    return false;
  }
  
  @override
  String toString() => message.toString();
  
  @override
  int get hashCode => message.hashCode;
  
  /// Get a field value by name
  @override
  Value get(Value field) {
    if (field is! StringValue) {
      return NullValue();
    }
    
    final fieldName = field.value;
    return _adapter.getField(message, fieldName);
  }
  
  /// Check if a field is set
  bool has(String fieldName) {
    final info = message.info_;
    
    // Find the field info
    for (final field in info.fieldInfo.values) {
      if (field.name == fieldName) {
        // For repeated fields, check if not empty
        if (field.isRepeated) {
          final list = message.getField(field.tagNumber) as List;
          return list.isNotEmpty;
        }
        // For singular fields, check if set
        return message.hasField(field.tagNumber);
      }
    }
    
    return false;
  }
  
  /// Test if a field is set (implements FieldTester)
  @override
  Value isSet(Value field) {
    if (field is! StringValue) {
      return BooleanValue(false);
    }
    
    return BooleanValue(has(field.value));
  }
}