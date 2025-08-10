import '../common/types/ref/value.dart';

/// Base class for resolution errors in CEL attribute resolution
abstract class ResolutionError implements Exception {
  /// Creates a missing key error
  static ResolutionError missingKey(Value key) => MissingKeyError(key);
  
  /// Creates a missing index error
  static ResolutionError missingIndex(Value index) => MissingIndexError(index);
  
  /// Creates a missing attribute error
  static ResolutionError missingAttribute(String name) => MissingAttributeError(name);
  
  /// Checks if this is a missing attribute error
  bool isMissingAttribute();
  
  /// Checks if this is a missing key error
  bool isMissingKey();
  
  /// Checks if this is a missing index error
  bool isMissingIndex();
}

/// Error thrown when a map key is not found
class MissingKeyError extends ResolutionError {
  final Value key;
  
  MissingKeyError(this.key);
  
  @override
  bool isMissingAttribute() => false;
  
  @override
  bool isMissingKey() => true;
  
  @override
  bool isMissingIndex() => false;
  
  @override
  String toString() => 'no such key: $key';
}

/// Error thrown when a list index is out of bounds
class MissingIndexError extends ResolutionError {
  final Value index;
  
  MissingIndexError(this.index);
  
  @override
  bool isMissingAttribute() => false;
  
  @override
  bool isMissingKey() => false;
  
  @override
  bool isMissingIndex() => true;
  
  @override
  String toString() => 'index out of bounds: $index';
}

/// Error thrown when an attribute is not found
class MissingAttributeError extends ResolutionError {
  final String name;
  
  MissingAttributeError(this.name);
  
  @override
  bool isMissingAttribute() => true;
  
  @override
  bool isMissingKey() => false;
  
  @override
  bool isMissingIndex() => false;
  
  @override
  String toString() => 'no such attribute: $name';
}

/// Error thrown when a field is not found
class NoSuchFieldError implements Exception {
  final String fieldName;
  final Type objectType;
  
  NoSuchFieldError(this.fieldName, this.objectType);
  
  @override
  String toString() => 'no such field: $fieldName on type $objectType';
}

/// Error thrown when trying to use an invalid type as a map key
class InvalidKeyTypeError implements Exception {
  final Type keyType;
  
  InvalidKeyTypeError(this.keyType);
  
  @override
  String toString() => 'invalid map key type: $keyType';
}