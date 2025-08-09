import 'dart:typed_data';
import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/traits/comparer.dart';
import 'package:cel/src/common/types/traits/sizer.dart';
import 'package:cel/src/common/types/int.dart';
import 'package:cel/src/common/types/bool.dart';

// BytesType singleton.
final Type_ bytesType = Type_('bytes');

// BytesValue holds a byte array value.
class BytesValue extends Value implements Comparer, Sizer {
  @override
  final Uint8List value;

  BytesValue(this.value);

  // Constructor from List<int> (CodeUnits)
  BytesValue.fromCodeUnits(List<int> codeUnits)
      : value = Uint8List.fromList(codeUnits);

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