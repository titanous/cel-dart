import 'package:cel/src/common/types/ref/value.dart';

/// CEL error type for representing runtime errors
final errorType = Type_('error');

/// ErrorValue represents a runtime error in CEL evaluation
class ErrorValue extends Value {
  ErrorValue(this.message, [this.cause]);

  final String message;
  final Object? cause;

  @override
  Type_ get type => errorType;

  @override
  Object? get value => this;

  @override
  dynamic convertToNative() {
    throw Exception(message);
  }

  @override
  String toString() => 'error: $message';
  
  @override
  bool operator ==(Object other) {
    if (other is! ErrorValue) return false;
    return message == other.message;
  }
  
  @override
  int get hashCode => message.hashCode;
}

/// Helper function to check if a value is an error
bool isError(Value val) => val is ErrorValue;

/// Common error values
final divideByZeroError = ErrorValue('division by zero');
final moduloByZeroError = ErrorValue('modulo by zero');
final intOverflowError = ErrorValue('integer overflow');
final indexOutOfRangeError = ErrorValue('index out of range');
final noSuchOverloadError = ErrorValue('no such overload');