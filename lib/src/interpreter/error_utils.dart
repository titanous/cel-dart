import '../common/types/error.dart';
import '../common/types/ref/value.dart';

/// Utility class for common error handling patterns in CEL operations
class ErrorUtils {
  /// Check if a value is an error and return it if so
  static Value? checkError(dynamic value) {
    if (isError(value)) {
      return value as Value;
    }
    return null;
  }

  /// Check for errors in binary operation operands
  static Value? checkBinaryErrors(dynamic left, dynamic right) {
    if (isError(left)) return left as Value;
    if (isError(right)) return right as Value;
    return null;
  }

  /// Check for errors in unary operation operand
  static Value? checkUnaryError(dynamic value) {
    return checkError(value);
  }

  /// Check for errors in multiple values
  static Value? checkMultipleErrors(List<dynamic> values) {
    for (final value in values) {
      if (isError(value)) {
        return value as Value;
      }
    }
    return null;
  }

  /// Execute a binary operation with automatic error checking
  static Value safeBinaryOp(
    dynamic left,
    dynamic right,
    Value Function(dynamic, dynamic) operation,
  ) {
    // Check for errors in operands first
    final error = checkBinaryErrors(left, right);
    if (error != null) return error;

    // Execute the operation and check for errors in result
    final result = operation(left, right);
    final resultError = checkError(result);
    if (resultError != null) return resultError;

    return result;
  }

  /// Execute a unary operation with automatic error checking
  static Value safeUnaryOp(
    dynamic operand,
    Value Function(dynamic) operation,
  ) {
    // Check for error in operand first
    final error = checkUnaryError(operand);
    if (error != null) return error;

    // Execute the operation and check for errors in result
    final result = operation(operand);
    final resultError = checkError(result);
    if (resultError != null) return resultError;

    return result;
  }

  /// Execute a function with multiple arguments with automatic error checking
  static Value safeMultiArgOp(
    List<dynamic> args,
    Value Function(List<dynamic>) operation,
  ) {
    // Check for errors in all arguments first
    final error = checkMultipleErrors(args);
    if (error != null) return error;

    // Execute the operation and check for errors in result
    final result = operation(args);
    final resultError = checkError(result);
    if (resultError != null) return resultError;

    return result;
  }

  /// Create an error value with a message
  static ErrorValue createError(String message) {
    return ErrorValue(message);
  }

  /// Create a type mismatch error
  static ErrorValue createTypeError(String expected, String actual) {
    return ErrorValue('Type mismatch: expected $expected, got $actual');
  }

  /// Create an argument count error
  static ErrorValue createArgCountError(int expected, int actual) {
    return ErrorValue('Argument count mismatch: expected $expected, got $actual');
  }

  /// Propagate an error or create a new one if the value is not an error
  static ErrorValue propagateOrCreateError(dynamic value, String fallbackMessage) {
    if (value is ErrorValue) {
      return value;
    }
    return ErrorValue(fallbackMessage);
  }
}

/// Extension methods for easier error checking
extension ValueErrorChecking on Value {
  /// Check if this value is an error
  bool get isError => this is ErrorValue;

  /// Return this value if it's an error, null otherwise
  ErrorValue? get asError => this is ErrorValue ? this as ErrorValue : null;
}

/// Extension methods for working with dynamic values
extension DynamicErrorChecking on dynamic {
  /// Check if this dynamic value is an error
  bool get isError => this is ErrorValue;

  /// Return this value as ErrorValue if it's an error, null otherwise
  ErrorValue? get asError => this is ErrorValue ? this as ErrorValue : null;
}