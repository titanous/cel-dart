import 'package:cel/src/common/types/bool.dart';
import 'package:cel/src/common/types/double.dart';
import 'package:cel/src/common/types/int.dart';
import 'package:cel/src/common/types/list.dart';
import 'package:cel/src/common/types/map.dart';
import 'package:cel/src/common/types/string.dart';
import 'package:cel/src/common/types/error.dart';
import 'package:cel/src/common/types/traits/comparer.dart';
import 'package:cel/src/common/types/traits/container.dart';
import 'package:cel/src/common/types/traits/indexer.dart';
import 'package:cel/src/common/types/traits/matcher.dart';
import 'package:cel/src/common/types/traits/math.dart';
import 'package:cel/src/common/types/traits/receiver.dart';
import 'package:cel/src/common/types/traits/sizer.dart';

import '../../common/overloads/overloads.dart';
import '../../operators/operators.dart';
import 'functions.dart';
import 'math.dart';
import 'strings.dart';
import 'conversions.dart';

// https://github.com/google/cel-go/blob/master/interpreter/functions/standard.go
List<Overload> standardOverloads() {
  return [
    // Logical not (!a)
    Overload(
      Operators.logicalNot.name,
      unaryOperator: (value) {
        // Handle errors
        if (value is ErrorValue) {
          return value;
        }
        // Only works with boolean values
        if (value is! BooleanValue) {
          return ErrorValue('no matching overload');
        }
        return BooleanValue(!value.value);
      },
    ),

    // Less than operator
    Overload(Operators.less.name,
        binaryOperator: (leftHandSide, rightHandSide) {
      if (isError(leftHandSide)) return leftHandSide;
      if (isError(rightHandSide)) return rightHandSide;
      if (leftHandSide is! Comparer) {
        throw StateError('$leftHandSide should be a Comparer');
      }
      final result = leftHandSide.compare(rightHandSide);
      if (isError(result)) return result;
      return BooleanValue(result.value < 0);
    }),

    // Less than or equal operator
    Overload(Operators.lessEquals.name,
        binaryOperator: (leftHandSide, rightHandSide) {
      if (isError(leftHandSide)) return leftHandSide;
      if (isError(rightHandSide)) return rightHandSide;
      if (leftHandSide is! Comparer) {
        throw StateError('$leftHandSide should be a Comparer');
      }
      final result = leftHandSide.compare(rightHandSide);
      if (isError(result)) return result;
      return BooleanValue(result.value <= 0);
    }),

    // Greater than operator
    Overload(Operators.greater.name,
        binaryOperator: (leftHandSide, rightHandSide) {
      if (isError(leftHandSide)) return leftHandSide;
      if (isError(rightHandSide)) return rightHandSide;
      if (leftHandSide is! Comparer) {
        throw StateError('$leftHandSide should be a Comparer');
      }
      final result = leftHandSide.compare(rightHandSide);
      if (isError(result)) return result;
      return BooleanValue(result.value > 0);
    }),

    // Greater than equal operators
    Overload(Operators.greaterEquals.name,
        binaryOperator: (leftHandSide, rightHandSide) {
      if (isError(leftHandSide)) return leftHandSide;
      if (isError(rightHandSide)) return rightHandSide;
      if (leftHandSide is! Comparer) {
        throw StateError('$leftHandSide should be a Comparer');
      }
      final result = leftHandSide.compare(rightHandSide);
      if (isError(result)) return result;
      return BooleanValue(result.value >= 0);
    }),

    // Add operator
    Overload(Operators.add.name, binaryOperator: (leftHandSide, rightHandSide) {
      if (leftHandSide is! Adder) {
        throw StateError('$leftHandSide should be an Adder');
      }
      return leftHandSide.add(rightHandSide);
    }),

    // Subtract operators
    Overload(Operators.subtract.name,
        binaryOperator: (leftHandSide, rightHandSide) {
      if (leftHandSide is! Subtractor) {
        throw StateError('$leftHandSide should be an Subtractor');
      }
      return leftHandSide.subtract(rightHandSide);
    }),

    // Multiply operator
    Overload(Operators.multiply.name,
        binaryOperator: (leftHandSide, rightHandSide) {
      if (leftHandSide is! Multiplier) {
        throw StateError('$leftHandSide should be an Multiplier');
      }
      return leftHandSide.multiply(rightHandSide);
    }),

    // Divide operator
    Overload(Operators.divide.name,
        binaryOperator: (leftHandSide, rightHandSide) {
      if (leftHandSide is! Divider) {
        throw StateError('$leftHandSide should be an Divider');
      }
      return leftHandSide.divide(rightHandSide);
    }),

    // Modulo operator
    Overload(Operators.modulo.name,
        binaryOperator: (leftHandSide, rightHandSide) {
      if (leftHandSide is! Modder) {
        throw StateError('$leftHandSide should be an Modder');
      }
      return leftHandSide.modulo(rightHandSide);
    }),

    // Negate operator (unary minus)
    Overload(
      Operators.negate.name,
      unaryOperator: (value) {
        if (isError(value)) return value;
        if (value is! Negater) {
          throw StateError('$value should be a Negater');
        }
        return value.negate();
      },
    ),

    // Index operator
    // https://github.com/google/cel-go/blob/92fda7d38a37f42d4154147896cfd4ebbf8f846e/interpreter/functions/standard.go#L149
    Overload(Operators.index_.name, binaryOperator: (target, index) {
      if (target is! Indexer) {
        throw StateError('$target should be an Indexer');
      }
      return target.get(index);
    }),

    // Size function
    Overload('size', unaryOperator: (value) {
      if (value is! Sizer) {
        throw StateError('$value should be a Sizer');
      }
      return IntValue(value.size());
    }),

    // Unique function - checks if all elements in a list are unique
    Overload('unique', unaryOperator: (value) {
      if (value is! ListValue) {
        throw StateError('$value should be a ListValue');
      }
      final seen = <dynamic>{};
      for (final item in value.value) {
        // Use the actual value for comparison to handle Value wrapper objects
        final key = item.value;
        if (seen.contains(key)) {
          return BooleanValue(false);
        }
        seen.add(key);
      }
      return BooleanValue(true);
    }),

    // GetField function - dynamic field access for messages/maps
    Overload('getField', binaryOperator: (target, fieldName) {
      // Handle map types
      if (target is MapValue) {
        // Convert field name to a string if needed
        if (fieldName is StringValue) {
          return target.get(fieldName);
        }
        throw StateError('Field name must be a string');
      }
      // For protobuf messages (when implemented), we'd handle them here
      // For now, we support map-based field access
      throw StateError('getField requires a map or message type');
    }),

    // Dyn function - converts a value to dynamic type for cross-type operations
    Overload('dyn', unaryOperator: (value) {
      // In CEL, dyn() essentially returns the value as-is but marks it as dynamic
      // This allows for operations between different types without explicit conversion
      // For now, we just return the value unchanged as Dart handles dynamic typing
      return value;
    }),

    // In operator
    // https://github.com/google/cel-go/blob/92fda7d38a37f42d4154147896cfd4ebbf8f846e/interpreter/functions/standard.go#L163
    Overload(Operators.in_.name, binaryOperator: (element, object) {
      if (object is! Container) {
        throw StateError('$object should be a Container');
      }
      return object.contains(element);
    }),

    // Matches function
    Overload(Overloads.matches.name, binaryOperator: (string, regExp) {
      if (string is! Matcher) {
        throw StateError('The first parameter should be a Matcher');
      }
      return string.match(regExp);
    }),

    // String functions - these use the Receiver trait
    // startsWith function for strings
    Overload('startsWith', binaryOperator: (target, arg) {
      if (target is! Receiver) {
        throw StateError('$target should be a Receiver');
      }
      return target.receive('startsWith', 'startsWith', [arg]);
    }),

    // endsWith function for strings
    Overload('endsWith', binaryOperator: (target, arg) {
      if (target is! Receiver) {
        throw StateError('$target should be a Receiver');
      }
      return target.receive('endsWith', 'endsWith', [arg]);
    }),

    // contains function for strings
    Overload('contains', binaryOperator: (target, arg) {
      if (target is! Receiver) {
        throw StateError('$target should be a Receiver');
      }
      return target.receive('contains', 'contains', [arg]);
    }),

    // Math functions
    Overload('isNan', unaryOperator: (value) {
      if (value is! DoubleValue) {
        throw StateError('$value should be a DoubleValue');
      }
      return MathFunctions.isNan(value);
    }),

    Overload(
      'isInf',
      unaryOperator: (value) {
        if (value is! DoubleValue) {
          throw StateError('$value should be a DoubleValue');
        }
        return MathFunctions.isInf(value);
      },
      binaryOperator: (value, sign) {
        if (value is! DoubleValue) {
          throw StateError('$value should be a DoubleValue');
        }
        if (sign is! IntValue) {
          throw StateError('$sign should be an IntValue');
        }
        return MathFunctions.isInf(value, sign);
      },
    ),

    Overload('isFinite', unaryOperator: (value) {
      if (value is! DoubleValue) {
        throw StateError('$value should be a DoubleValue');
      }
      return MathFunctions.isFinite(value);
    }),

    // String extension functions
    ...stringOverloads(),

    // Type conversion functions
    ...conversionOverloads(),
  ];
}
