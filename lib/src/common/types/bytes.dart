import 'dart:typed_data';
import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/traits/comparer.dart';
import 'package:cel/src/common/types/traits/receiver.dart';
import 'package:cel/src/common/types/traits/sizer.dart';
import 'package:cel/src/common/types/int.dart';
import 'package:cel/src/common/types/bool.dart';
import 'package:cel/src/common/overloads/overloads.dart';

// BytesType singleton.
final Type_ bytesType = Type_('bytes');

// BytesValue holds a byte array value.
class BytesValue extends Value implements Comparer, Sizer, Receiver {
  @override
  final Uint8List value;

  BytesValue(this.value);

  // Constructor from List<int> (CodeUnits)
  BytesValue.fromCodeUnits(List<int> codeUnits)
      : value = Uint8List.fromList(codeUnits);

  @override
  receive(String function, String overload, List<Value> arguments) {
    return bytesOneArgOverloads[function]!(value, arguments.first);
  }

  @override
  Value compare(Value other) {
    if (other is! BytesValue) {
      throw Exception('Cannot compare bytes with ${other.type.name}');
    }
    
    // Compare byte arrays lexicographically
    final otherBytes = other.value;
    final minLength = value.length < otherBytes.length 
        ? value.length 
        : otherBytes.length;
    
    for (int i = 0; i < minLength; i++) {
      if (value[i] < otherBytes[i]) {
        return IntValue(-1);
      }
      if (value[i] > otherBytes[i]) {
        return IntValue(1);
      }
    }
    
    // If all compared bytes are equal, compare lengths
    if (value.length < otherBytes.length) {
      return IntValue(-1);
    }
    if (value.length > otherBytes.length) {
      return IntValue(1);
    }
    return IntValue(0);
  }

  @override
  Value equal(Value other) {
    if (other is! BytesValue) {
      return BooleanValue(false);
    }
    
    final otherBytes = other.value;
    if (value.length != otherBytes.length) {
      return BooleanValue(false);
    }
    
    for (int i = 0; i < value.length; i++) {
      if (value[i] != otherBytes[i]) {
        return BooleanValue(false);
      }
    }
    return BooleanValue(true);
  }

  @override
  Type_ get type => bytesType;

  @override
  Object? convertToNative() {
    return value;
  }

  @override
  int size() {
    return value.length;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! BytesValue) return false;
    
    if (value.length != other.value.length) return false;
    for (int i = 0; i < value.length; i++) {
      if (value[i] != other.value[i]) return false;
    }
    return true;
  }

  @override
  int get hashCode {
    int hash = 0;
    for (final byte in value) {
      hash = (hash * 31 + byte) & 0x7FFFFFFF;
    }
    return hash;
  }

  @override
  String toString() {
    // Format as CEL bytes literal: b"\x00\x01\x02..."
    final buffer = StringBuffer('b"');
    for (final byte in value) {
      buffer.write('\\x${byte.toRadixString(16).padLeft(2, '0')}');
    }
    buffer.write('"');
    return buffer.toString();
  }
}

// Bytes function overloads
final bytesOneArgOverloads = <String, Value Function(Uint8List, Value)>{
  Overloads.contains.name: bytesContains,
  Overloads.endsWith.name: bytesEndsWith,
  Overloads.startsWith.name: bytesStartsWith,
};

Value bytesStartsWith(Uint8List bytes, Value value) {
  if (value is! BytesValue) {
    throw Exception('startsWith requires bytes argument');
  }
  final prefix = value.value;
  if (prefix.length > bytes.length) {
    return BooleanValue(false);
  }
  for (int i = 0; i < prefix.length; i++) {
    if (bytes[i] != prefix[i]) {
      return BooleanValue(false);
    }
  }
  return BooleanValue(true);
}

Value bytesEndsWith(Uint8List bytes, Value value) {
  if (value is! BytesValue) {
    throw Exception('endsWith requires bytes argument');
  }
  final suffix = value.value;
  if (suffix.length > bytes.length) {
    return BooleanValue(false);
  }
  final offset = bytes.length - suffix.length;
  for (int i = 0; i < suffix.length; i++) {
    if (bytes[offset + i] != suffix[i]) {
      return BooleanValue(false);
    }
  }
  return BooleanValue(true);
}

Value bytesContains(Uint8List bytes, Value value) {
  if (value is! BytesValue) {
    throw Exception('contains requires bytes argument');
  }
  final pattern = value.value;
  if (pattern.isEmpty) {
    return BooleanValue(true);
  }
  if (pattern.length > bytes.length) {
    return BooleanValue(false);
  }
  
  // Simple byte sequence search
  for (int i = 0; i <= bytes.length - pattern.length; i++) {
    bool found = true;
    for (int j = 0; j < pattern.length; j++) {
      if (bytes[i + j] != pattern[j]) {
        found = false;
        break;
      }
    }
    if (found) {
      return BooleanValue(true);
    }
  }
  return BooleanValue(false);
}