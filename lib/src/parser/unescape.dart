// Copyright 2018 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:convert';

/// Unescape takes a quoted string, unquotes, and unescapes it.
/// 
/// This function performs escaping compatible with GoogleSQL.
String unescape(String value, bool isBytes) {
  // All strings normalize newlines to the \n representation.
  value = value.replaceAll('\r\n', '\n').replaceAll('\r', '\n');
  final n = value.length;

  // Nothing to unescape / decode.
  if (n < 2) {
    throw FormatException('unable to unescape string');
  }

  // Raw string preceded by the 'r|R' prefix.
  bool isRawLiteral = false;
  if (value.startsWith('r') || value.startsWith('R')) {
    value = value.substring(1);
    isRawLiteral = true;
  }

  // Quoted string of some form, must have same first and last char.
  if (value.isEmpty || value[0] != value[value.length - 1] || (value[0] != '"' && value[0] != '\'')) {
    throw FormatException('unable to unescape string');
  }

  // Normalize the multi-line CEL string representation to a standard
  // Go quoted string.
  if (value.length >= 6) {
    if (value.startsWith("'''")) {
      if (!value.endsWith("'''")) {
        throw FormatException('unable to unescape string');
      }
      value = '"${value.substring(3, value.length - 3)}"';
    } else if (value.startsWith('"""')) {
      if (!value.endsWith('"""')) {
        throw FormatException('unable to unescape string');
      }
      value = '"${value.substring(3, value.length - 3)}"';
    }
  }
  
  value = value.substring(1, value.length - 1);
  
  // If there is nothing to escape, then return.
  if (isRawLiteral || !value.contains('\\')) {
    // For bytes, we need to convert characters to UTF-8 bytes
    if (isBytes) {
      return String.fromCharCodes(utf8.encode(value));
    }
    return value;
  }

  // Otherwise the string contains escape characters.
  if (isBytes) {
    // For bytes, we handle escape sequences as raw bytes
    final bytes = <int>[];
    var i = 0;
    while (i < value.length) {
      if (value[i] != '\\') {
        // Regular character - UTF-8 encode it
        final char = value[i];
        bytes.addAll(utf8.encode(char));
        i++;
      } else {
        // Escape sequence - handle as raw bytes
        final result = _unescapeChar(value, i, isBytes);
        bytes.add(result.value);
        i = result.nextIndex;
      }
    }
    return String.fromCharCodes(bytes);
  } else {
    // For strings, handle normally
    final buf = StringBuffer();
    var i = 0;
    while (i < value.length) {
      final result = _unescapeChar(value, i, isBytes);
      buf.writeCharCode(result.value);
      i = result.nextIndex;
    }
    return buf.toString();
  }
}

class _UnescapeResult {
  final int value;
  final int nextIndex;
  
  _UnescapeResult(this.value, this.nextIndex);
}

/// unescapeChar takes a string input and returns the following info:
///
/// value - the escaped unicode rune at the front of the string.
/// nextIndex - the next index to process in the input string.
///
/// If isBytes is set, unescape as a bytes literal so octal and hex escapes
/// represent byte values, not unicode code points.
_UnescapeResult _unescapeChar(String s, int index, bool isBytes) {
  // 1. Character is not an escape sequence.
  final c = s.codeUnitAt(index);
  if (c != 92) { // '\'
    return _UnescapeResult(c, index + 1);
  }

  // 2. Last character is the start of an escape sequence.
  if (index >= s.length - 1) {
    throw FormatException('unable to unescape string, found \'\\\' as last character');
  }

  final next = s.codeUnitAt(index + 1);
  var nextIndex = index + 2;
  
  // 3. Common escape sequences shared with Google SQL
  switch (next) {
    case 97: // 'a'
      return _UnescapeResult(7, nextIndex); // '\a'
    case 98: // 'b'
      return _UnescapeResult(8, nextIndex); // '\b'
    case 102: // 'f'
      return _UnescapeResult(12, nextIndex); // '\f'
    case 110: // 'n'
      return _UnescapeResult(10, nextIndex); // '\n'
    case 114: // 'r'
      return _UnescapeResult(13, nextIndex); // '\r'
    case 116: // 't'
      return _UnescapeResult(9, nextIndex); // '\t'
    case 118: // 'v'
      return _UnescapeResult(11, nextIndex); // '\v'
    case 92: // '\'
      return _UnescapeResult(92, nextIndex); // '\\'
    case 39: // '\''
      return _UnescapeResult(39, nextIndex); // '\''
    case 34: // '"'
      return _UnescapeResult(34, nextIndex); // '"'
    case 96: // '`'
      return _UnescapeResult(96, nextIndex); // '`'
    case 63: // '?'
      return _UnescapeResult(63, nextIndex); // '?'

    // 4. Unicode escape sequences
    case 120: // 'x'
    case 88: // 'X'
      return _parseHexEscape(s, index + 2, 2, isBytes);
    case 117: // 'u'
      if (isBytes) {
        throw FormatException('unable to unescape string');
      }
      return _parseHexEscape(s, index + 2, 4, false);
    case 85: // 'U'
      if (isBytes) {
        throw FormatException('unable to unescape string');
      }
      return _parseHexEscape(s, index + 2, 8, false);

    // 5. Octal escape sequences, must be three digits \[0-3][0-7][0-7]
    case 48: // '0'
    case 49: // '1'
    case 50: // '2'  
    case 51: // '3'
      return _parseOctalEscape(s, index + 1, isBytes);

    // Unknown escape sequence.
    default:
      throw FormatException('unable to unescape string');
  }
}

_UnescapeResult _parseHexEscape(String s, int startIndex, int digits, bool isBytes) {
  if (startIndex + digits > s.length) {
    throw FormatException('unable to unescape string');
  }
  
  var v = 0;
  for (var j = 0; j < digits; j++) {
    final hex = _unhex(s.codeUnitAt(startIndex + j));
    if (hex == -1) {
      throw FormatException('unable to unescape string');
    }
    v = (v << 4) | hex;
  }
  
  if (!isBytes && !_isValidRune(v)) {
    throw FormatException('invalid unicode code point');
  }
  
  return _UnescapeResult(v, startIndex + digits);
}

_UnescapeResult _parseOctalEscape(String s, int startIndex, bool isBytes) {
  if (startIndex + 2 >= s.length) {
    throw FormatException('unable to unescape octal sequence in string');
  }
  
  var v = s.codeUnitAt(startIndex) - 48; // '0'
  for (var j = 1; j < 3; j++) {
    final x = s.codeUnitAt(startIndex + j);
    if (x < 48 || x > 55) { // '0' to '7'
      throw FormatException('unable to unescape octal sequence in string');
    }
    v = v * 8 + (x - 48);
  }
  
  if (!isBytes && !_isValidRune(v)) {
    throw FormatException('invalid unicode code point');
  }
  
  return _UnescapeResult(v, startIndex + 3);
}

int _unhex(int b) {
  if (b >= 48 && b <= 57) { // '0' to '9'
    return b - 48;
  }
  if (b >= 97 && b <= 102) { // 'a' to 'f'
    return b - 97 + 10;
  }
  if (b >= 65 && b <= 70) { // 'A' to 'F'
    return b - 65 + 10;
  }
  return -1;
}

bool _isValidRune(int r) {
  // Basic validation for unicode code points
  return r >= 0 && r <= 0x10FFFF && !(r >= 0xD800 && r <= 0xDFFF);
}