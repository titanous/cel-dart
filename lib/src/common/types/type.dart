import 'package:cel/src/common/types/ref/value.dart';

/// Represents a CEL type value (result of type() function)
class TypeValue extends Value {
  final String typeName;
  
  TypeValue(this.typeName);
  
  @override
  dynamic get value => typeName;
  
  @override
  Type_ get type => Type_('type', {});
  
  @override
  dynamic convertToNative() => typeName;
  
  @override
  List<Object?> get props => [typeName];
  
  @override
  String toString() => 'type($typeName)';
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypeValue && typeName == other.typeName;
  
  @override
  int get hashCode => typeName.hashCode;
}