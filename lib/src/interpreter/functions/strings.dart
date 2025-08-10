import 'package:cel/src/common/types/bool.dart';
import 'package:cel/src/common/types/bytes.dart';
import 'package:cel/src/common/types/double.dart';
import 'package:cel/src/common/types/error.dart';
import 'package:cel/src/common/types/int.dart';
import 'package:cel/src/common/types/list.dart';
import 'package:cel/src/common/types/null_.dart';
import 'package:cel/src/common/types/string.dart';
import 'package:cel/src/common/types/uint.dart';
import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/provider.dart';

import 'functions.dart';

// String extension functions following cel-go/ext/strings.go
List<Overload> stringOverloads() {
  return [
    // charAt function
    Overload('charAt', binaryOperator: (str, index) {
      if (str is! StringValue || index is! IntValue) {
        return ErrorValue('charAt requires string and int arguments');
      }
      
      final s = str.value;
      final i = index.value.toInt();
      
      if (i < 0) {
        return ErrorValue('charAt index must be non-negative');
      }
      
      final runes = s.runes.toList();
      if (i >= runes.length) {
        if (i == runes.length) {
          return StringValue('');
        }
        return ErrorValue('charAt index out of bounds');
      }
      
      return StringValue(String.fromCharCode(runes[i]));
    }),
    
    // indexOf function (2 and 3 arguments)
    Overload('indexOf', functionOperator: (args) {
      if (args.length == 2) {
        final str = args[0];
        final substr = args[1];
        
        if (str is! StringValue || substr is! StringValue) {
          return ErrorValue('indexOf requires string arguments');
        }
        
        final strValue = str.value;
        final substrValue = substr.value;
        
        if (substrValue.isEmpty) {
          return IntValue(0);
        }
        
        final result = strValue.indexOf(substrValue);
        
        if (result == -1) {
          return IntValue(-1);
        }
        
        // Convert string position to rune position
        final runeIndex = strValue.substring(0, result).runes.length;
        return IntValue(runeIndex);
      } else if (args.length == 3) {
        final str = args[0];
        final substr = args[1];
        final startArg = args[2];
        
        if (str is! StringValue || substr is! StringValue || startArg is! IntValue) {
          return ErrorValue('indexOf requires string, string, int arguments');
        }
        
        final strValue = str.value;
        final substrValue = substr.value;
        final start = startArg.value.toInt();
        
        if (start < 0) {
          return ErrorValue('indexOf start must be non-negative');
        }
        
        if (substrValue.isEmpty) {
          return IntValue(start);
        }
        
        final runes = strValue.runes.toList();
        if (start >= runes.length) {
          return IntValue(-1);
        }
        
        // Convert rune position to string position
        final strPrefix = String.fromCharCodes(runes.take(start));
        final result = strValue.indexOf(substrValue, strPrefix.length);
        
        if (result == -1) {
          return IntValue(-1);
        }
        
        // Convert string position back to rune position
        final runeIndex = strValue.substring(0, result).runes.length;
        return IntValue(runeIndex);
      }
      return ErrorValue('indexOf requires 2 or 3 arguments');
    }),
    
    // lastIndexOf function (2 and 3 arguments)
    Overload('lastIndexOf', functionOperator: (args) {
      if (args.length == 2) {
        final str = args[0];
        final substr = args[1];
        
        if (str is! StringValue || substr is! StringValue) {
          return ErrorValue('lastIndexOf requires string arguments');
        }
        
        final strValue = str.value;
        final substrValue = substr.value;
        final runes = strValue.runes.toList();
        
        if (substrValue.isEmpty) {
          return IntValue(runes.length);
        }
        
        final result = strValue.lastIndexOf(substrValue);
        
        if (result == -1) {
          return IntValue(-1);
        }
        
        // Convert string position to rune position
        final runeIndex = strValue.substring(0, result).runes.length;
        return IntValue(runeIndex);
      } else if (args.length == 3) {
        final str = args[0];
        final substr = args[1];
        final endArg = args[2];
        
        if (str is! StringValue || substr is! StringValue || endArg is! IntValue) {
          return ErrorValue('lastIndexOf requires string, string, int arguments');
        }
        
        final strValue = str.value;
        final substrValue = substr.value;
        final runes = strValue.runes.toList();
        final end = endArg.value.toInt();
        
        if (end < 0) {
          return ErrorValue('lastIndexOf end must be non-negative');
        }
        
        if (substrValue.isEmpty) {
          if (end < runes.length) {
            return IntValue(end);
          }
          return IntValue(runes.length);
        }
        
        String searchStr = strValue;
        if (end < runes.length) {
          searchStr = String.fromCharCodes(runes.take(end + substrValue.runes.length));
        }
        
        final result = searchStr.lastIndexOf(substrValue);
        
        if (result == -1) {
          return IntValue(-1);
        }
        
        // Convert string position back to rune position
        final runeIndex = strValue.substring(0, result).runes.length;
        return IntValue(runeIndex);
      }
      return ErrorValue('lastIndexOf requires 2 or 3 arguments');
    }),
    
    // lowerAscii function
    Overload('lowerAscii', unaryOperator: (str) {
      if (str is! StringValue) {
        return ErrorValue('lowerAscii requires string argument');
      }
      
      final result = StringBuffer();
      for (final rune in str.value.runes) {
        if (rune >= 65 && rune <= 90) { // A-Z
          result.writeCharCode(rune + 32);
        } else {
          result.writeCharCode(rune);
        }
      }
      
      return StringValue(result.toString());
    }),
    
    // upperAscii function
    Overload('upperAscii', unaryOperator: (str) {
      if (str is! StringValue) {
        return ErrorValue('upperAscii requires string argument');
      }
      
      final result = StringBuffer();
      for (final rune in str.value.runes) {
        if (rune >= 97 && rune <= 122) { // a-z
          result.writeCharCode(rune - 32);
        } else {
          result.writeCharCode(rune);
        }
      }
      
      return StringValue(result.toString());
    }),
    
    // trim function
    Overload('trim', unaryOperator: (str) {
      if (str is! StringValue) {
        return ErrorValue('trim requires string argument');
      }
      
      return StringValue(str.value.trim());
    }),
    
    // reverse function
    Overload('reverse', unaryOperator: (str) {
      if (str is! StringValue) {
        return ErrorValue('reverse requires string argument');
      }
      
      final runes = str.value.runes.toList();
      return StringValue(String.fromCharCodes(runes.reversed));
    }),
    
    // replace function (3 and 4 arguments)
    Overload('replace', functionOperator: (args) {
      final valueArgs = args.cast<Value>();
      if (args.length == 3) {
        return stringReplace(valueArgs);
      } else if (args.length == 4) {
        return stringReplaceN(valueArgs);
      }
      return ErrorValue('replace requires 3 or 4 arguments');
    }),
    
    // split function (2 and 3 arguments)
    Overload('split', functionOperator: (args) {
      final valueArgs = args.cast<Value>();
      if (args.length == 2) {
        return stringSplit(valueArgs);
      } else if (args.length == 3) {
        return stringSplitN(valueArgs);
      }
      return ErrorValue('split requires 2 or 3 arguments');
    }),
    
    // substring function (2 and 3 arguments)
    Overload('substring', functionOperator: (args) {
      final valueArgs = args.cast<Value>();
      if (args.length == 2) {
        return stringSubstring(valueArgs);
      } else if (args.length == 3) {
        return stringSubstringRange(valueArgs);
      }
      return ErrorValue('substring requires 2 or 3 arguments');
    }),
    
    // join function (1 and 2 arguments)
    Overload('join', functionOperator: (args) {
      final valueArgs = args.cast<Value>();
      return stringJoin(valueArgs);
    }),
    
    // format function
    Overload('format', functionOperator: (args) {
      final valueArgs = args.cast<Value>();
      return stringFormat(valueArgs);
    }),
    
    // quote function (strings.quote) - register both versions
    Overload('strings.quote', unaryOperator: _quoteFunction),
    Overload('quote', unaryOperator: _quoteFunction),
  ];
}

// Complex string functions that need special handling
// These will be added to the planner separately

// replace function with 3 arguments
Value stringReplace(List<Value> args) {
  if (args.length != 3) {
    return ErrorValue('replace requires 3 arguments');
  }
  
  final str = args[0];
  final oldStr = args[1];
  final newStr = args[2];
  
  if (str is! StringValue || oldStr is! StringValue || newStr is! StringValue) {
    return ErrorValue('replace requires string arguments');
  }
  
  final result = str.value.replaceAll(oldStr.value, newStr.value);
  return StringValue(result);
}

// replace function with 4 arguments (with limit)
Value stringReplaceN(List<Value> args) {
  if (args.length != 4) {
    return ErrorValue('replace requires 4 arguments');
  }
  
  final str = args[0];
  final oldStr = args[1];
  final newStr = args[2];
  final count = args[3];
  
  if (str is! StringValue || oldStr is! StringValue || newStr is! StringValue) {
    return ErrorValue('replace requires string arguments');
  }
  
  if (count is! IntValue) {
    return ErrorValue('replace count must be int');
  }
  
  final n = count.value.toInt();
  
  if (n == 0) {
    return str;
  }
  
  if (n < 0) {
    return StringValue(str.value.replaceAll(oldStr.value, newStr.value));
  }
  
  String result = str.value;
  int replaced = 0;
  int startIndex = 0;
  final buffer = StringBuffer();
  
  while (replaced < n) {
    final index = result.indexOf(oldStr.value, startIndex);
    if (index == -1) {
      break;
    }
    
    buffer.write(result.substring(startIndex, index));
    buffer.write(newStr.value);
    startIndex = index + oldStr.value.length;
    replaced++;
  }
  
  buffer.write(result.substring(startIndex));
  return StringValue(buffer.toString());
}

// split function with 2 arguments
Value stringSplit(List<Value> args) {
  if (args.length != 2) {
    return ErrorValue('split requires 2 arguments');
  }
  
  final str = args[0];
  final separator = args[1];
  
  if (str is! StringValue || separator is! StringValue) {
    return ErrorValue('split requires string arguments');
  }
  
  final parts = str.value.split(separator.value);
  final adapter = newRegistry();
  return ListValue(parts.map((p) => StringValue(p)).toList(), adapter);
}

// split function with 3 arguments (with limit)
Value stringSplitN(List<Value> args) {
  if (args.length != 3) {
    return ErrorValue('split requires 3 arguments');
  }
  
  final str = args[0];
  final separator = args[1];
  final limitArg = args[2];
  
  if (str is! StringValue || separator is! StringValue) {
    return ErrorValue('split requires string arguments');
  }
  
  if (limitArg is! IntValue) {
    return ErrorValue('split limit must be int');
  }
  
  final limit = limitArg.value.toInt();
  final adapter = newRegistry();
  
  if (limit == 0) {
    return ListValue([], adapter);
  }
  
  if (limit == 1) {
    return ListValue([str], adapter);
  }
  
  final strValue = str.value;
  final sepValue = separator.value;
  
  if (sepValue.isEmpty) {
    // Split into individual characters
    final runes = strValue.runes.toList();
    final chars = runes
        .map((r) => StringValue(String.fromCharCode(r)))
        .toList();
    
    if (limit > 0 && chars.length > limit) {
      final result = chars.take(limit - 1).toList();
      final remaining = String.fromCharCodes(runes.skip(limit - 1));
      result.add(StringValue(remaining));
      return ListValue(result, adapter);
    }
    
    return ListValue(chars, adapter);
  }
  
  List<String> parts;
  if (limit < 0) {
    parts = strValue.split(sepValue);
  } else {
    parts = [];
    String remaining = strValue;
    int count = 0;
    
    while (count < limit - 1) {
      final index = remaining.indexOf(sepValue);
      if (index == -1) {
        break;
      }
      
      parts.add(remaining.substring(0, index));
      remaining = remaining.substring(index + sepValue.length);
      count++;
    }
    
    parts.add(remaining);
  }
  
  return ListValue(parts.map((p) => StringValue(p)).toList(), adapter);
}

// substring function with 2 arguments
Value stringSubstring(List<Value> args) {
  if (args.length != 2) {
    return ErrorValue('substring requires 2 arguments');
  }
  
  final str = args[0];
  final startArg = args[1];
  
  if (str is! StringValue || startArg is! IntValue) {
    return ErrorValue('substring requires string and int arguments');
  }
  
  final strValue = str.value;
  final runes = strValue.runes.toList();
  final start = startArg.value.toInt();
  
  if (start < 0) {
    return ErrorValue('substring start must be non-negative');
  }
  
  if (start > runes.length) {
    return ErrorValue('substring start out of bounds');
  }
  
  final result = String.fromCharCodes(runes.skip(start));
  return StringValue(result);
}

// substring function with 3 arguments
Value stringSubstringRange(List<Value> args) {
  if (args.length != 3) {
    return ErrorValue('substring requires 3 arguments');
  }
  
  final str = args[0];
  final startArg = args[1];
  final endArg = args[2];
  
  if (str is! StringValue || startArg is! IntValue || endArg is! IntValue) {
    return ErrorValue('substring requires string and int arguments');
  }
  
  final strValue = str.value;
  final runes = strValue.runes.toList();
  final start = startArg.value.toInt();
  final end = endArg.value.toInt();
  
  if (start < 0) {
    return ErrorValue('substring start must be non-negative');
  }
  
  if (start > runes.length) {
    return ErrorValue('substring start out of bounds');
  }
  
  if (end < 0) {
    return ErrorValue('substring end must be non-negative');
  }
  
  if (end > runes.length) {
    return ErrorValue('substring end out of bounds');
  }
  
  if (start > end) {
    return ErrorValue('substring start must be less than or equal to end');
  }
  
  final result = String.fromCharCodes(runes.sublist(start, end));
  return StringValue(result);
}

// join function
Value stringJoin(List<Value> args) {
  if (args.isEmpty || args.length > 2) {
    return ErrorValue('join requires 1 or 2 arguments');
  }
  
  final list = args[0];
  if (list is! ListValue) {
    return ErrorValue('join requires list argument');
  }
  
  String separator = '';
  if (args.length == 2) {
    final sepArg = args[1];
    if (sepArg is! StringValue) {
      return ErrorValue('join separator must be string');
    }
    separator = sepArg.value;
  }
  
  final strings = <String>[];
  for (final item in list.value) {
    if (item is! StringValue) {
      return ErrorValue('join list must contain only strings');
    }
    strings.add(item.value);
  }
  
  return StringValue(strings.join(separator));
}

// format function
Value stringFormat(List<Value> args) {
  if (args.length != 2) {
    return ErrorValue('format requires 2 arguments');
  }
  
  final formatStr = args[0];
  final formatArgs = args[1];
  
  if (formatStr is! StringValue || formatArgs is! ListValue) {
    return ErrorValue('format requires string and list arguments');
  }
  
  try {
    return StringValue(_doFormat(formatStr.value, formatArgs.value));
  } catch (e) {
    return ErrorValue('format error: $e');
  }
}

String _doFormat(String format, List<Value> args) {
  final result = StringBuffer();
  int argIndex = 0;
  int i = 0;
  
  while (i < format.length) {
    if (format[i] == '%') {
      if (i + 1 < format.length) {
        if (format[i + 1] == '%') {
          result.write('%');
          i += 2;
          continue;
        }
        
        // Parse format clause
        final clause = _parseFormatClause(format, i);
        if (clause == null) {
          throw FormatException('Invalid format clause at position $i');
        }
        
        if (argIndex >= args.length) {
          throw FormatException('Not enough arguments for format string');
        }
        
        final formatted = _formatValue(args[argIndex], clause);
        result.write(formatted);
        argIndex++;
        i = clause.end;
      } else {
        throw FormatException('Incomplete format clause at end of string');
      }
    } else {
      result.write(format[i]);
      i++;
    }
  }
  
  if (argIndex < args.length) {
    throw FormatException('Too many arguments for format string');
  }
  
  return result.toString();
}

_FormatClause? _parseFormatClause(String format, int start) {
  int i = start + 1; // Skip %
  if (i >= format.length) return null;
  
  // Parse optional precision
  int? precision;
  if (format[i] == '.') {
    i++;
    final digitStart = i;
    while (i < format.length && _isDigit(format[i])) {
      i++;
    }
    if (i > digitStart) {
      precision = int.parse(format.substring(digitStart, i));
    }
  }
  
  // Parse verb
  if (i >= format.length) return null;
  final verb = format[i];
  i++;
  
  return _FormatClause(verb: verb, precision: precision, end: i);
}

bool _isDigit(String char) {
  final code = char.codeUnitAt(0);
  return code >= 48 && code <= 57;
}

String _formatValue(Value value, _FormatClause clause) {
  switch (clause.verb) {
    case 's':
      return _formatString(value);
    case 'd':
      return _formatInt(value);
    case 'f':
      return _formatFloat(value, clause.precision ?? 6);
    case 'e':
      return _formatScientific(value, clause.precision ?? 6);
    case 'b':
      return _formatBinary(value);
    case 'x':
      return _formatHex(value, false);
    case 'X':
      return _formatHex(value, true);
    case 'o':
      return _formatOctal(value);
    default:
      throw FormatException('Unknown format verb: ${clause.verb}');
  }
}

String _formatString(Value value) {
  if (value is StringValue) return value.value;
  if (value is BytesValue) return String.fromCharCodes(value.value);
  if (value is BooleanValue) return value.value ? 'true' : 'false';
  if (value is NullValue) return 'null';
  return value.toString();
}

String _formatInt(Value value) {
  if (value is IntValue) return value.value.toString();
  if (value is UintValue) return value.value.toString();
  if (value is DoubleValue) return value.value.toInt().toString();
  if (value is BooleanValue) return value.value ? '1' : '0';
  throw FormatException('Cannot format $value as integer');
}

String _formatFloat(Value value, int precision) {
  double d;
  if (value is DoubleValue) {
    d = value.value;
  } else if (value is IntValue) {
    d = value.value.toDouble();
  } else if (value is UintValue) {
    d = value.value.toDouble();
  } else {
    throw FormatException('Cannot format $value as float');
  }
  return d.toStringAsFixed(precision);
}

String _formatScientific(Value value, int precision) {
  double d;
  if (value is DoubleValue) {
    d = value.value;
  } else if (value is IntValue) {
    d = value.value.toDouble();
  } else if (value is UintValue) {
    d = value.value.toDouble();
  } else {
    throw FormatException('Cannot format $value as scientific');
  }
  return d.toStringAsExponential(precision);
}

String _formatBinary(Value value) {
  BigInt n;
  if (value is IntValue) {
    n = BigInt.from(value.value);
  } else if (value is UintValue) {
    n = BigInt.from(value.value);
  } else {
    throw FormatException('Cannot format $value as binary');
  }
  return n.toRadixString(2);
}

String _formatHex(Value value, bool uppercase) {
  BigInt n;
  if (value is IntValue) {
    n = BigInt.from(value.value);
  } else if (value is UintValue) {
    n = BigInt.from(value.value);
  } else if (value is BytesValue) {
    final hex = value.value
        .map((b) => b.toRadixString(16).padLeft(2, '0'))
        .join();
    return uppercase ? hex.toUpperCase() : hex;
  } else {
    throw FormatException('Cannot format $value as hex');
  }
  final hex = n.toRadixString(16);
  return uppercase ? hex.toUpperCase() : hex;
}

String _formatOctal(Value value) {
  BigInt n;
  if (value is IntValue) {
    n = BigInt.from(value.value);
  } else if (value is UintValue) {
    n = BigInt.from(value.value);
  } else {
    throw FormatException('Cannot format $value as octal');
  }
  return n.toRadixString(8);
}

class _FormatClause {
  final String verb;
  final int? precision;
  final int end;
  
  _FormatClause({
    required this.verb,
    this.precision,
    required this.end,
  });
}

// Helper function for string quoting
dynamic _quoteFunction(dynamic str) {
  if (str is! StringValue) {
    return ErrorValue('quote requires string argument');
  }
  
  final result = StringBuffer('"');
  
  for (final rune in str.value.runes) {
    switch (rune) {
      case 0x07: // \a
        result.write(r'\a');
        break;
      case 0x08: // \b
        result.write(r'\b');
        break;
      case 0x0C: // \f
        result.write(r'\f');
        break;
      case 0x0A: // \n
        result.write(r'\n');
        break;
      case 0x0D: // \r
        result.write(r'\r');
        break;
      case 0x09: // \t
        result.write(r'\t');
        break;
      case 0x0B: // \v
        result.write(r'\v');
        break;
      case 0x5C: // \\
        result.write(r'\\');
        break;
      case 0x22: // \"
        result.write(r'\"');
        break;
      default:
        if (rune >= 0x20 && rune <= 0x7E) {
          result.writeCharCode(rune);
        } else if (rune <= 0xFF) {
          result.write(r'\x');
          result.write(rune.toRadixString(16).padLeft(2, '0'));
        } else if (rune <= 0xFFFF) {
          result.write(r'\u');
          result.write(rune.toRadixString(16).padLeft(4, '0'));
        } else {
          result.write(r'\U');
          result.write(rune.toRadixString(16).padLeft(8, '0'));
        }
    }
  }
  
  result.write('"');
  return StringValue(result.toString());
}