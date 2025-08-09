import 'package:protobuf/protobuf.dart';
import 'package:fixnum/fixnum.dart';
import '../gen/cel/expr/value.pb.dart';
import '../gen/google/protobuf/struct.pb.dart' as struct_pb;

/// A simple textproto parser for conformance tests
/// This is a basic implementation - a full parser would be more complex
class TextProtoParser {
  static T parse<T extends GeneratedMessage>(String content, T message) {
    final parser = _Parser(content);
    parser.parseMessage(message);
    return message;
  }
}

class _Parser {
  final List<String> lines;
  int currentLine = 0;
  
  _Parser(String content) : lines = content.split('\n');
  
  void parseMessage(GeneratedMessage message) {
    while (currentLine < lines.length) {
      final line = lines[currentLine].trim();
      
      // Skip empty lines and comments
      if (line.isEmpty || line.startsWith('#')) {
        currentLine++;
        continue;
      }
      
      // Check for end of message
      if (line == '}') {
        currentLine++;
        return;
      }
      
      // Parse field
      if (line.contains(':')) {
        final colonIndex = line.indexOf(':');
        final fieldName = line.substring(0, colonIndex).trim();
        final remainder = line.substring(colonIndex + 1).trim();
        
        if (remainder == '{') {
          // Nested message
          currentLine++;
          final nestedMessage = _createNestedMessage(message, fieldName);
          if (nestedMessage != null) {
            parseMessage(nestedMessage);
            _setField(message, fieldName, nestedMessage);
          }
        } else if (remainder.startsWith('"')) {
          // String value
          final value = _parseStringValue(remainder);
          _setField(message, fieldName, value);
          currentLine++;
        } else if (remainder == 'true' || remainder == 'false') {
          // Boolean value
          _setField(message, fieldName, remainder == 'true');
          currentLine++;
        } else if (_isNumber(remainder)) {
          // Numeric value
          final value = _parseNumber(remainder);
          _setField(message, fieldName, value);
          currentLine++;
        } else if (remainder.startsWith('[')) {
          // Repeated field
          final values = _parseRepeatedField(remainder);
          for (final value in values) {
            _addRepeatedValue(message, fieldName, value);
          }
          currentLine++;
        } else {
          // Enum or other value
          _setField(message, fieldName, remainder);
          currentLine++;
        }
      } else if (line.endsWith('{')) {
        // Repeated message field
        final fieldName = line.substring(0, line.length - 1).trim();
        currentLine++;
        final nestedMessage = _createNestedMessage(message, fieldName);
        if (nestedMessage != null) {
          parseMessage(nestedMessage);
          _addRepeatedValue(message, fieldName, nestedMessage);
        }
      } else {
        currentLine++;
      }
    }
  }
  
  GeneratedMessage? _createNestedMessage(GeneratedMessage parent, String fieldName) {
    // This would need to be implemented based on the actual message types
    // For now, return null to skip
    return null;
  }
  
  void _setField(GeneratedMessage message, String fieldName, dynamic value) {
    try {
      final info = message.info_;
      final fieldInfo = info.byName[fieldName];
      if (fieldInfo != null) {
        message.setField(fieldInfo.tagNumber, value);
      }
    } catch (e) {
      // Field not found or type mismatch - skip
    }
  }
  
  void _addRepeatedValue(GeneratedMessage message, String fieldName, dynamic value) {
    try {
      final info = message.info_;
      final fieldInfo = info.byName[fieldName];
      if (fieldInfo != null && fieldInfo.isRepeated) {
        final list = message.getField(fieldInfo.tagNumber) as List;
        list.add(value);
      }
    } catch (e) {
      // Field not found or not repeated - skip
    }
  }
  
  String _parseStringValue(String value) {
    if (value.startsWith('"') && value.endsWith('"')) {
      return value.substring(1, value.length - 1)
          .replaceAll(r'\"', '"')
          .replaceAll(r'\\', r'\')
          .replaceAll(r'\n', '\n')
          .replaceAll(r'\t', '\t');
    }
    return value;
  }
  
  bool _isNumber(String value) {
    return RegExp(r'^-?\d+(\.\d+)?([eE][+-]?\d+)?$').hasMatch(value);
  }
  
  dynamic _parseNumber(String value) {
    if (value.contains('.') || value.contains('e') || value.contains('E')) {
      return double.parse(value);
    } else {
      return int.parse(value);
    }
  }
  
  List<dynamic> _parseRepeatedField(String value) {
    // Simple repeated field parser for inline arrays like [1, 2, 3]
    if (value.startsWith('[') && value.endsWith(']')) {
      final content = value.substring(1, value.length - 1);
      final parts = content.split(',');
      return parts.map((p) {
        final trimmed = p.trim();
        if (trimmed.startsWith('"')) {
          return _parseStringValue(trimmed);
        } else if (_isNumber(trimmed)) {
          return _parseNumber(trimmed);
        } else if (trimmed == 'true' || trimmed == 'false') {
          return trimmed == 'true';
        }
        return trimmed;
      }).toList();
    }
    return [];
  }
}

/// Helper to create Value from various types
Value createValue(dynamic value) {
  final result = Value();
  
  if (value == null) {
    result.nullValue = struct_pb.NullValue.NULL_VALUE;
  } else if (value is bool) {
    result.boolValue = value;
  } else if (value is int) {
    result.int64Value = Int64(value);
  } else if (value is double) {
    result.doubleValue = value;
  } else if (value is String) {
    result.stringValue = value;
  } else if (value is List<int>) {
    result.bytesValue = value;
  } else if (value is List) {
    final listValue = ListValue();
    for (final item in value) {
      listValue.values.add(createValue(item));
    }
    result.listValue = listValue;
  } else if (value is Map) {
    final mapValue = MapValue();
    for (final entry in value.entries) {
      mapValue.entries.add(MapValue_Entry()
        ..key = createValue(entry.key)
        ..value = createValue(entry.value));
    }
    result.mapValue = mapValue;
  }
  
  return result;
}