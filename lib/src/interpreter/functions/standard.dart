import 'package:cel/src/common/types/bool.dart';
import 'package:cel/src/common/types/double.dart';
import 'package:cel/src/common/types/int.dart';
import 'package:cel/src/common/types/list.dart';
import 'package:cel/src/common/types/map.dart';
import 'package:cel/src/common/types/string.dart';
import 'package:cel/src/common/types/error.dart';
import 'package:cel/src/common/types/traits/comparer.dart';
import '../error_utils.dart';
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
import 'timestamps.dart';

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
      return ErrorUtils.safeBinaryOp(leftHandSide, rightHandSide, (lhs, rhs) {
        if (lhs is! Comparer) {
          return ErrorValue('no matching overload for \'<\' with operand types ${lhs.type.name} and ${rhs.type.name}');
        }
        final result = lhs.compare(rhs);
        if (isError(result)) return result;
        return BooleanValue(result.value < 0);
      });
    }),

    // Less than or equal operator
    Overload(Operators.lessEquals.name,
        binaryOperator: (leftHandSide, rightHandSide) {
      return ErrorUtils.safeBinaryOp(leftHandSide, rightHandSide, (lhs, rhs) {
        if (lhs is! Comparer) {
          return ErrorValue('no matching overload for \'<=\' with operand types ${lhs.type.name} and ${rhs.type.name}');
        }
        final result = lhs.compare(rhs);
        if (isError(result)) return result;
        return BooleanValue(result.value <= 0);
      });
    }),

    // Greater than operator
    Overload(Operators.greater.name,
        binaryOperator: (leftHandSide, rightHandSide) {
      return ErrorUtils.safeBinaryOp(leftHandSide, rightHandSide, (lhs, rhs) {
        if (lhs is! Comparer) {
          return ErrorValue('no matching overload for \'>\' with operand types ${lhs.type.name} and ${rhs.type.name}');
        }
        final result = lhs.compare(rhs);
        if (isError(result)) return result;
        return BooleanValue(result.value > 0);
      });
    }),

    // Greater than equal operators
    Overload(Operators.greaterEquals.name,
        binaryOperator: (leftHandSide, rightHandSide) {
      return ErrorUtils.safeBinaryOp(leftHandSide, rightHandSide, (lhs, rhs) {
        if (lhs is! Comparer) {
          return ErrorValue('no matching overload for \'>=\' with operand types ${lhs.type.name} and ${rhs.type.name}');
        }
        final result = lhs.compare(rhs);
        if (isError(result)) return result;
        return BooleanValue(result.value >= 0);
      });
    }),

    // Add operator
    Overload(Operators.add.name, binaryOperator: (leftHandSide, rightHandSide) {
      return ErrorUtils.safeBinaryOp(leftHandSide, rightHandSide, (lhs, rhs) {
        if (lhs is! Adder) {
          return ErrorValue('no matching overload for \'+\' with operand types ${lhs.type.name} and ${rhs.type.name}');
        }
        return lhs.add(rhs);
      });
    }),

    // Subtract operators
    Overload(Operators.subtract.name,
        binaryOperator: (leftHandSide, rightHandSide) {
      return ErrorUtils.safeBinaryOp(leftHandSide, rightHandSide, (lhs, rhs) {
        if (lhs is! Subtractor) {
          return ErrorValue('no matching overload for \'-\' with operand types ${lhs.type.name} and ${rhs.type.name}');
        }
        return lhs.subtract(rhs);
      });
    }),

    // Multiply operator
    Overload(Operators.multiply.name,
        binaryOperator: (leftHandSide, rightHandSide) {
      return ErrorUtils.safeBinaryOp(leftHandSide, rightHandSide, (lhs, rhs) {
        if (lhs is! Multiplier) {
          return ErrorValue('no matching overload for \'*\' with operand types ${lhs.type.name} and ${rhs.type.name}');
        }
        return lhs.multiply(rhs);
      });
    }),

    // Divide operator
    Overload(Operators.divide.name,
        binaryOperator: (leftHandSide, rightHandSide) {
      return ErrorUtils.safeBinaryOp(leftHandSide, rightHandSide, (lhs, rhs) {
        if (lhs is! Divider) {
          return ErrorValue('no matching overload for \'/\' with operand types ${lhs.type.name} and ${rhs.type.name}');
        }
        return lhs.divide(rhs);
      });
    }),

    // Modulo operator
    Overload(Operators.modulo.name,
        binaryOperator: (leftHandSide, rightHandSide) {
      return ErrorUtils.safeBinaryOp(leftHandSide, rightHandSide, (lhs, rhs) {
        if (lhs is! Modder) {
          return ErrorValue('no matching overload for \'%\' with operand types ${lhs.type.name} and ${rhs.type.name}');
        }
        return lhs.modulo(rhs);
      });
    }),

    // Negate operator (unary minus)
    Overload(
      Operators.negate.name,
      unaryOperator: (value) {
        return ErrorUtils.safeUnaryOp(value, (val) {
          if (val is! Negater) {
            return ErrorValue('no matching overload for unary \'-\' with operand type ${val.type.name}');
          }
          return val.negate();
        });
      },
    ),

    // Index operator
    // https://github.com/google/cel-go/blob/92fda7d38a37f42d4154147896cfd4ebbf8f846e/interpreter/functions/standard.go#L149
    Overload(Operators.index_.name, binaryOperator: (target, index) {
      return ErrorUtils.safeBinaryOp(target, index, (tgt, idx) {
        if (tgt is! Indexer) {
          return ErrorValue('no matching overload for operator \'[_]\' with operand types ${tgt.type.name} and ${idx.type.name}');
        }
        return tgt.get(idx);
      });
    }),

    // Size function
    Overload('size', unaryOperator: (value) {
      return ErrorUtils.safeUnaryOp(value, (val) {
        if (val is! Sizer) {
          return ErrorValue('no matching overload for function \'size\' with operand type ${val.type.name}');
        }
        return IntValue(val.size());
      });
    }),

    // Unique function - checks if all elements in a list are unique
    Overload('unique', unaryOperator: (value) {
      return ErrorUtils.safeUnaryOp(value, (val) {
        if (val is! ListValue) {
          return ErrorValue('no matching overload for function \'unique\' with operand type ${val.type.name}');
        }
        final seen = <dynamic>{};
        for (final item in val.value) {
          // Use the actual value for comparison to handle Value wrapper objects
          final key = item.value;
          if (seen.contains(key)) {
            return BooleanValue(false);
          }
          seen.add(key);
        }
        return BooleanValue(true);
      });
    }),

    // GetField function - dynamic field access for messages/maps
    Overload('getField', binaryOperator: (target, fieldName) {
      // Handle map types
      if (target is MapValue) {
        // Convert field name to a string if needed
        if (fieldName is StringValue) {
          return target.get(fieldName);
        }
        return ErrorValue('Field name must be a string, got ${fieldName.type.name}');
      }
      // For protobuf messages (when implemented), we'd handle them here
      // For now, we support map-based field access
      return ErrorValue('getField requires a map or message type, got ${target.type.name}');
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
      if (isError(element)) return element;
      if (isError(object)) return object;
      if (object is! Container) {
        return ErrorValue('no matching overload for operator \'\'in \'\'\' with operand types ${element.type.name} and ${object.type.name}');
      }
      return object.contains(element);
    }),

    // Matches function
    Overload(Overloads.matches.name, binaryOperator: (string, regExp) {
      if (isError(string)) return string;
      if (isError(regExp)) return regExp;
      if (string is! Matcher) {
        return ErrorValue('no matching overload for function \'\'matches\'\'\' with operand types ${string.type.name} and ${regExp.type.name}');
      }
      return string.match(regExp);
    }),

    // String functions - these use the Receiver trait
    // startsWith function for strings
    Overload('startsWith', binaryOperator: (target, arg) {
      if (isError(target)) return target;
      if (isError(arg)) return arg;
      if (target is! Receiver) {
        return ErrorValue('no matching overload for function \'\'startsWith\'\'\' with operand types ${target.type.name} and ${arg.type.name}');
      }
      return target.receive('startsWith', 'startsWith', [arg]);
    }),

    // endsWith function for strings
    Overload('endsWith', binaryOperator: (target, arg) {
      if (isError(target)) return target;
      if (isError(arg)) return arg;
      if (target is! Receiver) {
        return ErrorValue('no matching overload for function \'\'endsWith\'\'\' with operand types ${target.type.name} and ${arg.type.name}');
      }
      return target.receive('endsWith', 'endsWith', [arg]);
    }),

    // contains function for strings
    Overload('contains', binaryOperator: (target, arg) {
      if (isError(target)) return target;
      if (isError(arg)) return arg;
      if (target is! Receiver) {
        return ErrorValue('no matching overload for function \'\'contains\'\'\' with operand types ${target.type.name} and ${arg.type.name}');
      }
      return target.receive('contains', 'contains', [arg]);
    }),

    // Math functions
    Overload('isNan', unaryOperator: (value) {
      if (isError(value)) return value;
      if (value is! DoubleValue) {
        return ErrorValue('no matching overload for function \'\'isNan\'\'\' with operand type ${value.type.name}');
      }
      return MathFunctions.isNan(value);
    }),

    Overload(
      'isInf',
      unaryOperator: (value) {
        if (isError(value)) return value;
        if (value is! DoubleValue) {
          return ErrorValue('no matching overload for function \'\'isInf\'\'\' with operand type ${value.type.name}');
        }
        return MathFunctions.isInf(value);
      },
      binaryOperator: (value, sign) {
        if (isError(value)) return value;
        if (isError(sign)) return sign;
        if (value is! DoubleValue) {
          return ErrorValue('no matching overload for function \'\'isInf\'\'\' with operand types ${value.type.name} and ${sign.type.name}');
        }
        if (sign is! IntValue) {
          return ErrorValue('no matching overload for function \'\'isInf\'\'\' with operand types ${value.type.name} and ${sign.type.name}');
        }
        return MathFunctions.isInf(value, sign);
      },
    ),

    Overload('isFinite', unaryOperator: (value) {
      if (isError(value)) return value;
      if (value is! DoubleValue) {
        return ErrorValue('no matching overload for function \'\'isFinite\'\'\' with operand type ${value.type.name}');
      }
      return MathFunctions.isFinite(value);
    }),

    // String extension functions
    ...stringOverloads(),

    // Timestamp selector functions
    ...timestampOverloads(),

    // Type conversion functions
    ...conversionOverloads(),
  ];
}
