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
  
  String get celTypeValue => message.info_.qualifiedMessageName;
  
  @override
  Type_ get type => Type_(celTypeValue);
  
  @override
  dynamic get value => message;
  
  @override
  Value convertToNative() => this;
  
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
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MessageValue && message == other.message;
  }
  
  /// Get a field value by name
  @override
  Value get(Value field) {
    if (field is! StringValue) {
      return NullValue();
    }
    
    final fieldName = field.value;
    return _adapter.getField(message, fieldName);
  }
  
  /// Check if a field is set.
  /// 
  /// Delegates to the underlying protobuf library's hasField() method,
  /// which now handles proto2 vs proto3 semantics automatically based
  /// on the field's presence information.
  bool has(String fieldName) {
    final info = message.info_;
    
    // Find the field by name and get its tag number
    for (final field in info.fieldInfo.values) {
      if (_matchesFieldName(field, fieldName)) {
        return message.hasField(field.tagNumber);
      }
    }
    
    return false;
  }
  
  /// Check if a field matches the given name (either proto name or Dart property name)
  bool _matchesFieldName(FieldInfo field, String name) {
    // Check Dart property name (camelCase)
    if (field.name == name) {
      return true;
    }
    
    // Check proto field name (snake_case)
    // Convert between naming conventions
    if (_toCamelCase(name) == field.name) {
      return true;
    }
    
    if (_toSnakeCase(field.name) == name) {
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
  
  /// Test if a field is set (implements FieldTester)
  @override
  Value isSet(Value field) {
    if (field is! StringValue) {
      return BooleanValue(false);
    }
    
    return BooleanValue(has(field.value));
  }
}