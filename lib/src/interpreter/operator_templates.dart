import 'functions/functions.dart';
import 'error_utils.dart';
import '../common/types/error.dart';
import '../common/types/bool.dart';
import '../common/types/traits/comparer.dart';
import '../common/types/traits/math.dart';
import '../common/types/traits/indexer.dart';

/// Templates for creating operators with common patterns
class OperatorTemplates {
  /// Create a comparison operator template
  static Overload comparisonOperator(
    String operatorName,
    String operatorSymbol,
    bool Function(int) comparisonFunction,
  ) {
    return Overload(operatorName,
        binaryOperator: (leftHandSide, rightHandSide) {
      return ErrorUtils.safeBinaryOp(leftHandSide, rightHandSide, (lhs, rhs) {
        if (lhs is! Comparer) {
          return ErrorValue(
              'no matching overload for \'$operatorSymbol\' with operand types ${lhs.type.name} and ${rhs.type.name}');
        }
        final result = lhs.compare(rhs);
        if (isError(result)) return result;
        return BooleanValue(comparisonFunction(result.value));
      });
    });
  }

  /// Create an arithmetic operator template
  static Overload arithmeticOperator<T>(
    String operatorName,
    String operatorSymbol,
    dynamic Function(T, dynamic) operationFunction,
  ) {
    return Overload(operatorName,
        binaryOperator: (leftHandSide, rightHandSide) {
      return ErrorUtils.safeBinaryOp(leftHandSide, rightHandSide, (lhs, rhs) {
        if (lhs is! T) {
          return ErrorValue(
              'no matching overload for \'$operatorSymbol\' with operand types ${lhs.type.name} and ${rhs.type.name}');
        }
        return operationFunction(lhs, rhs);
      });
    });
  }

  /// Create a unary operator template
  static Overload unaryOperator<T>(
    String operatorName,
    String operatorSymbol,
    dynamic Function(T) operationFunction,
  ) {
    return Overload(operatorName, unaryOperator: (value) {
      return ErrorUtils.safeUnaryOp(value, (val) {
        if (val is! T) {
          return ErrorValue(
              'no matching overload for unary \'$operatorSymbol\' with operand type ${val.type.name}');
        }
        return operationFunction(val);
      });
    });
  }

  /// Create all standard comparison operators using the template
  static List<Overload> createComparisonOperators() {
    return [
      comparisonOperator('_<_', '<', (result) => result < 0),
      comparisonOperator('_<=_', '<=', (result) => result <= 0),
      comparisonOperator('_>_', '>', (result) => result > 0),
      comparisonOperator('_>=_', '>=', (result) => result >= 0),
    ];
  }

  /// Create all standard arithmetic operators using the template
  static List<Overload> createArithmeticOperators() {
    return [
      arithmeticOperator<Adder>('_+_', '+', (lhs, rhs) => lhs.add(rhs)),
      arithmeticOperator<Subtractor>('_-_', '-', (lhs, rhs) => lhs.subtract(rhs)),
      arithmeticOperator<Multiplier>('_*_', '*', (lhs, rhs) => lhs.multiply(rhs)),
      arithmeticOperator<Divider>('_/_', '/', (lhs, rhs) => lhs.divide(rhs)),
      arithmeticOperator<Modder>('_%_', '%', (lhs, rhs) => lhs.modulo(rhs)),
    ];
  }
}

/// Factory for creating standard operators with consistent patterns
class StandardOperatorFactory {
  /// Create a complete set of binary operators with consistent error handling
  static List<Overload> createBinaryOperators() {
    return [
      ...OperatorTemplates.createComparisonOperators(),
      ...OperatorTemplates.createArithmeticOperators(),
    ];
  }

  /// Create index operator with error handling template
  static Overload createIndexOperator() {
    return OperatorTemplates.arithmeticOperator<Indexer>(
      '_[_]',
      '[_]',
      (lhs, rhs) => lhs?.get(rhs),
    );
  }
}

/// Utility functions for operator creation
class OperatorUtils {
  /// Standard error message for no matching overload
  static String noMatchingOverloadError(
    String operatorSymbol,
    String leftType,
    String rightType,
  ) {
    return 'no matching overload for \'$operatorSymbol\' with operand types $leftType and $rightType';
  }

  /// Standard error message for unary operator
  static String noMatchingUnaryOverloadError(
    String operatorSymbol,
    String operandType,
  ) {
    return 'no matching overload for unary \'$operatorSymbol\' with operand type $operandType';
  }

  /// Standard error message for function
  static String noMatchingFunctionError(
    String functionName,
    String operandType,
  ) {
    return 'no matching overload for function \'$functionName\' with operand type $operandType';
  }
}