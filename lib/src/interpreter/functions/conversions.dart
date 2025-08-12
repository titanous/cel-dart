import 'dart:convert';
import 'dart:typed_data';
import 'package:fixnum/fixnum.dart';

import 'package:cel/src/common/types/bool.dart';
import 'package:cel/src/common/types/bytes.dart';
import 'package:cel/src/common/types/double.dart';
import 'package:cel/src/common/types/error.dart';
import 'package:cel/src/common/types/int.dart';
import 'package:cel/src/common/types/string.dart';
import 'package:cel/src/common/types/uint.dart';
import 'package:cel/src/common/types/timestamp.dart';
import 'package:cel/src/common/types/duration.dart';
import 'package:cel/src/common/types/type.dart';
import 'package:cel/src/common/types/null_.dart';
import 'package:cel/src/common/types/list.dart';
import 'package:cel/src/common/types/map.dart';

import 'functions.dart';

/// Type conversion functions for CEL
/// Based on cel-go's type conversion implementations
List<Overload> conversionOverloads() {
  return [
    // int() conversions
    Overload('int', unaryOperator: (value) {
      if (isError(value)) return value;

      if (value is IntValue) {
        return value;
      }
      if (value is UintValue) {
        // Convert uint to int with overflow checking
        final uintVal = value.value;
        // If the Int64 is negative, it means the original uint64 value
        // was larger than Int64.MAX_VALUE (i.e., >= 2^63), so it can't fit in int64
        if (uintVal.isNegative) {
          return ErrorValue('range error');
        }
        return IntValue(uintVal.toInt());
      }
      if (value is DoubleValue) {
        final doubleVal = value.value;
        if (doubleVal.isNaN || doubleVal.isInfinite) {
          return ErrorValue('cannot convert NaN or Inf to int');
        }
        // Check for exact range of int64: -9223372036854775808 to 9223372036854775807
        // But CEL requires range errors for values at the boundary when cast from double
        // because the exact double representation may be outside the exact int64 range
        const maxInt64AsDouble =
            9223372036854775808.0; // 2^63, just above max int64
        const minInt64AsDouble =
            -9223372036854775809.0; // -2^63-1, just below min int64
        if (doubleVal >= maxInt64AsDouble || doubleVal <= minInt64AsDouble) {
          return ErrorValue('range');
        }
        return IntValue(doubleVal.toInt());
      }
      if (value is StringValue) {
        try {
          final parsed = int.parse(value.value);
          return IntValue(parsed);
        } catch (e) {
          return ErrorValue('cannot convert string to int: "${value.value}"');
        }
      }
      if (value is BooleanValue) {
        return IntValue(value.value ? 1 : 0);
      }
      if (value is TimestampValue) {
        // Convert timestamp to Unix seconds
        return IntValue(value.dateTime.millisecondsSinceEpoch ~/ 1000);
      }

      return ErrorValue(
          'type conversion error from ${value.runtimeType} to int');
    }),

    // uint() conversions
    Overload('uint', unaryOperator: (value) {
      if (isError(value)) return value;

      if (value is UintValue) {
        return value;
      }
      if (value is IntValue) {
        final intVal = value.value;
        if (intVal < 0) {
          return ErrorValue('range error');
        }
        return UintValue(intVal);
      }
      if (value is DoubleValue) {
        final doubleVal = value.value;
        if (doubleVal.isNaN || doubleVal.isInfinite) {
          return ErrorValue('cannot convert NaN or Inf to uint');
        }
        if (doubleVal < 0) {
          return ErrorValue('range error');
        }
        // Check for uint64 max (18446744073709551615)
        const maxUint64AsDouble =
            18446744073709551616.0; // 2^64, slightly above max uint64
        if (doubleVal >= maxUint64AsDouble) {
          return ErrorValue('range error');
        }
        return UintValue(doubleVal.toInt());
      }
      if (value is StringValue) {
        try {
          // Use BigInt to handle values that might exceed int range
          final bigInt = BigInt.tryParse(value.value);
          if (bigInt == null) {
            return ErrorValue(
                'cannot convert string to uint: "${value.value}"');
          }
          if (bigInt < BigInt.zero) {
            return ErrorValue('range error');
          }
          // Check for uint64 max (18446744073709551615)
          final maxUint64 = (BigInt.from(1) << 64) - BigInt.one; // 2^64 - 1
          if (bigInt > maxUint64) {
            return ErrorValue(
                'Positive input exceeds the limit of integer\n$bigInt');
          }
          // Convert BigInt to Int64 to support full uint64 range
          return UintValue.fromInt64(Int64.parseInt(value.value));
        } catch (e) {
          return ErrorValue('cannot convert string to uint: "${value.value}"');
        }
      }

      return ErrorValue(
          'type conversion error from ${value.runtimeType} to uint');
    }),

    // double() conversions
    Overload('double', unaryOperator: (value) {
      if (isError(value)) return value;

      if (value is DoubleValue) {
        return value;
      }
      if (value is IntValue) {
        return DoubleValue(value.value.toDouble());
      }
      if (value is UintValue) {
        // Convert uint64 stored as Int64 to double as unsigned value
        final int64Val = value.value;
        double doubleVal;
        if (int64Val.isNegative) {
          // For large uint64 values stored as negative Int64,
          // we need to add 2^64 to get the correct unsigned value
          // Using BigInt to avoid precision loss
          final bigInt = BigInt.from(int64Val.toInt()) + (BigInt.one << 64);
          doubleVal = bigInt.toDouble();
        } else {
          doubleVal = int64Val.toDouble();
        }
        return DoubleValue(doubleVal);
      }
      if (value is StringValue) {
        final str = value.value;
        // Handle special string values
        if (str == 'NaN') {
          return DoubleValue(double.nan);
        }
        if (str == 'Infinity' || str == 'Inf') {
          return DoubleValue(double.infinity);
        }
        if (str == '-Infinity' || str == '-Inf') {
          return DoubleValue(double.negativeInfinity);
        }
        try {
          final parsed = double.parse(str);
          return DoubleValue(parsed);
        } catch (e) {
          return ErrorValue(
              'cannot convert string to double: "${value.value}"');
        }
      }

      return ErrorValue(
          'type conversion error from ${value.runtimeType} to double');
    }),

    // string() conversions
    Overload('string', unaryOperator: (value) {
      if (isError(value)) return value;

      if (value is StringValue) {
        return value;
      }
      if (value is IntValue) {
        return StringValue(value.value.toString());
      }
      if (value is UintValue) {
        return StringValue(value.value.toString());
      }
      if (value is DoubleValue) {
        final d = value.value;
        if (d.isNaN) {
          return StringValue('NaN');
        }
        if (d.isInfinite) {
          return StringValue(d.isNegative ? '-Infinity' : 'Infinity');
        }

        // Handle special formatting for small scientific notation numbers
        final str = d.toString();
        // Convert scientific notation like -4.5e-3 to decimal form -0.0045
        if (str.contains('e')) {
          // Let Dart handle the conversion but ensure proper formatting
          if (d == d.truncateToDouble() && d.abs() < 1e15) {
            // For whole numbers that aren't too large, show without decimal
            return StringValue(d.toInt().toString());
          }
          // For scientific notation, convert to decimal if reasonable
          if (d.abs() >= 1e-6 && d.abs() < 1e6) {
            final decimal = d
                .toStringAsFixed(10)
                .replaceAll(RegExp(r'0+$'), '')
                .replaceAll(RegExp(r'\.$'), '');
            return StringValue(decimal);
          }
        }

        // Format double to avoid unnecessary decimals for whole numbers
        if (d == d.truncateToDouble()) {
          return StringValue(d.toInt().toString());
        }
        return StringValue(d.toString());
      }
      if (value is BooleanValue) {
        return StringValue(value.value ? 'true' : 'false');
      }
      if (value is BytesValue) {
        // Convert bytes to string (UTF-8 decode)
        try {
          final str = utf8.decode(value.value);
          return StringValue(str);
        } catch (e) {
          return ErrorValue('invalid UTF-8');
        }
      }
      if (value is TimestampValue) {
        // Format timestamp in RFC3339 format
        return StringValue(value.dateTime.toIso8601String());
      }
      if (value is DurationValue) {
        // Format duration in CEL format (e.g., "1h30m")
        final totalSeconds = value.duration.inSeconds;
        if (totalSeconds == 0) {
          return StringValue('0s');
        }

        final parts = <String>[];
        var seconds = totalSeconds.abs();

        // Hours
        if (seconds >= 3600) {
          final hours = seconds ~/ 3600;
          parts.add('${hours}h');
          seconds %= 3600;
        }

        // Minutes
        if (seconds >= 60) {
          final minutes = seconds ~/ 60;
          parts.add('${minutes}m');
          seconds %= 60;
        }

        // Seconds
        if (seconds > 0 || parts.isEmpty) {
          parts.add('${seconds}s');
        }

        final result = parts.join();
        return StringValue(totalSeconds < 0 ? '-$result' : result);
      }

      return ErrorValue(
          'type conversion error from ${value.runtimeType} to string');
    }),

    // bool() conversions
    Overload('bool', unaryOperator: (value) {
      if (isError(value)) return value;

      if (value is BooleanValue) {
        return value;
      }
      if (value is StringValue) {
        final str = value.value;
        // Support all variants that Go's strconv.ParseBool supports
        switch (str) {
          case '1':
          case 't':
          case 'T':
          case 'true':
          case 'TRUE':
          case 'True':
            return BooleanValue(true);
          case '0':
          case 'f':
          case 'F':
          case 'false':
          case 'FALSE':
          case 'False':
            return BooleanValue(false);
          default:
            return ErrorValue('Type conversion error');
        }
      }

      return ErrorValue(
          'type conversion error from ${value.runtimeType} to bool');
    }),

    // bytes() conversions
    Overload('bytes', unaryOperator: (value) {
      if (isError(value)) return value;

      if (value is BytesValue) {
        return value;
      }
      if (value is StringValue) {
        // Convert string to bytes (UTF-8 encode)
        final bytes = utf8.encode(value.value);
        return BytesValue(Uint8List.fromList(bytes));
      }

      return ErrorValue(
          'type conversion error from ${value.runtimeType} to bytes');
    }),

    // type() function - returns the type of a value
    Overload('type', unaryOperator: (value) {
      if (isError(value)) return value;

      if (value is IntValue) {
        return TypeValue('int');
      }
      if (value is UintValue) {
        return TypeValue('uint');
      }
      if (value is DoubleValue) {
        return TypeValue('double');
      }
      if (value is StringValue) {
        return TypeValue('string');
      }
      if (value is BooleanValue) {
        return TypeValue('bool');
      }
      if (value is BytesValue) {
        return TypeValue('bytes');
      }
      if (value is NullValue) {
        return TypeValue('null_type');
      }
      if (value is TimestampValue) {
        return TypeValue('google.protobuf.Timestamp');
      }
      if (value is DurationValue) {
        return TypeValue('google.protobuf.Duration');
      }
      if (value is ListValue) {
        return TypeValue('list');
      }
      if (value is MapValue) {
        return TypeValue('map');
      }
      if (value is TypeValue) {
        // The type of a type is "type"
        return TypeValue('type');
      }

      // For unknown types, return the runtime type name
      return TypeValue(value.runtimeType.toString());
    }),

    // dyn() function - marks a value as dynamic type
    // This is already in standard.dart but adding here for completeness
    Overload('dyn', unaryOperator: (value) {
      // In CEL, dyn() essentially returns the value as-is but marks it as dynamic
      // This allows for operations between different types without explicit conversion
      return value;
    }),

    // duration conversions
    Overload('duration', unaryOperator: (value) {
      if (isError(value)) return value;

      if (value is DurationValue) {
        return value;
      }
      if (value is StringValue) {
        // Parse duration string (e.g., "1h30m", "45s", "100ms")
        try {
          return _parseDuration(value.value);
        } catch (e) {
          return ErrorValue('cannot parse duration: "${value.value}"');
        }
      }

      return ErrorValue(
          'type conversion error from ${value.runtimeType} to duration');
    }),

    // timestamp conversions
    Overload('timestamp', unaryOperator: (value) {
      if (isError(value)) return value;

      if (value is TimestampValue) {
        return value;
      }
      if (value is IntValue) {
        // Convert Unix seconds to timestamp
        return TimestampValue(DateTime.fromMillisecondsSinceEpoch(
            value.value * 1000,
            isUtc: true));
      }
      if (value is StringValue) {
        // Parse RFC3339 timestamp
        try {
          return TimestampValue(DateTime.parse(value.value));
        } catch (e) {
          return ErrorValue('cannot parse timestamp: "${value.value}"');
        }
      }

      return ErrorValue(
          'type conversion error from ${value.runtimeType} to timestamp');
    }),
  ];
}

/// Parse a duration string like "1h30m45s" into a DurationValue
DurationValue _parseDuration(String str) {
  if (str.isEmpty) {
    throw FormatException('empty duration string');
  }

  var totalMilliseconds = 0;
  var currentNumber = '';
  var isNegative = false;

  if (str[0] == '-') {
    isNegative = true;
    str = str.substring(1);
  }

  for (var i = 0; i < str.length; i++) {
    final char = str[i];

    if (_isDigit(char) || char == '.') {
      currentNumber += char;
    } else {
      if (currentNumber.isEmpty) {
        throw FormatException('invalid duration format');
      }

      final value = double.parse(currentNumber);
      currentNumber = '';

      switch (char) {
        case 'h':
          totalMilliseconds += (value * 3600000).round();
          break;
        case 'm':
          // Check if followed by 's' for milliseconds
          if (i + 1 < str.length && str[i + 1] == 's') {
            totalMilliseconds += value.round();
            i++; // Skip the 's'
          } else {
            // Minutes
            totalMilliseconds += (value * 60000).round();
          }
          break;
        case 's':
          totalMilliseconds += (value * 1000).round();
          break;
        case 'u':
          // Microseconds - check for 's' suffix
          if (i + 1 < str.length && str[i + 1] == 's') {
            totalMilliseconds += (value / 1000).round();
            i++; // Skip the 's'
          } else {
            throw FormatException('invalid duration unit: $char');
          }
          break;
        case 'n':
          // Nanoseconds - check for 's' suffix
          if (i + 1 < str.length && str[i + 1] == 's') {
            totalMilliseconds += (value / 1000000).round();
            i++; // Skip the 's'
          } else {
            throw FormatException('invalid duration unit: $char');
          }
          break;
        default:
          throw FormatException('invalid duration unit: $char');
      }
    }
  }

  if (currentNumber.isNotEmpty) {
    throw FormatException('duration string missing unit');
  }

  if (isNegative) {
    totalMilliseconds = -totalMilliseconds;
  }

  return DurationValue(Duration(milliseconds: totalMilliseconds));
}

bool _isDigit(String char) {
  final code = char.codeUnitAt(0);
  return code >= 48 && code <= 57; // '0' to '9'
}
