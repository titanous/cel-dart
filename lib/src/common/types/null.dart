import 'package:cel/src/common/types/ref/value.dart';

/// CEL Null type implementation
final nullType = Type_("null_type", {});

/// CEL NullValue representation
class NullValue extends Value {
  /// Singleton instance of NullValue
  static final NullValue instance = NullValue._();
  
  NullValue._();
  
  @override
  Type_ get type => nullType;
  
  @override
  get value => null;
  
  @override
  convertToNative() => null;
  
  @override
  String toString() => 'null';
  
  @override
  bool operator ==(Object other) => other is NullValue;
  
  @override
  int get hashCode => 0;
}