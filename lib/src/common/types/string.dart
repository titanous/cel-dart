import 'package:cel/src/common/types/bool.dart';
import 'package:cel/src/common/types/int.dart';
import 'package:cel/src/common/types/list.dart';
import 'package:cel/src/common/types/traits/comparer.dart';
import 'package:cel/src/common/types/traits/matcher.dart';
import 'package:cel/src/common/types/traits/math.dart';
import 'package:cel/src/common/types/traits/sizer.dart';
import 'package:cel/src/common/types/traits/traits.dart';

import '../overloads/overloads.dart';
import 'ref/value.dart';
import 'traits/receiver.dart';
import '../../interpreter/functions/strings.dart' as string_funcs;

// https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/string.go

final stringType = Type_('string', {
  Traits.AdderType,
  Traits.ComparerType,
  Traits.MatcherType,
  Traits.ReceiverType,
  Traits.SizerType
});

class StringValue extends Value
    implements Receiver, Matcher, Adder, Comparer, Sizer {
  StringValue(this.value);

  @override
  receive(String function, String overload, List<Value> arguments) {
    // Handle format function separately as it takes a list
    if (function == 'format') {
      // The format function expects the format string as first arg and the arguments list as second
      if (arguments.isNotEmpty && arguments.first is ListValue) {
        return string_funcs.stringFormat([this, arguments.first]);
      }
      throw Exception('format requires a list argument');
    }

    // Handle single-argument string functions
    if (stringOneArgOverloads.containsKey(function)) {
      return stringOneArgOverloads[function]!(value, arguments.first);
    }

    throw Exception('No overload found for function: $function on StringValue');
  }

  @override
  final String value;

  @override
  Type_ get type => stringType;

  @override
  BooleanValue match(Value pattern) {
    return BooleanValue(RegExp(pattern.value).hasMatch(value));
  }

  @override
  add(Value other) {
    return StringValue(value + other.value);
  }

  @override
  Value compare(Value other) {
    return IntValue(value.compareTo(other.value));
  }

  @override
  int size() {
    // Return the number of Unicode code points (runes) in the string
    return value.runes.length;
  }
}

// class String_ extends String implements Receiver {
// https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/string.go#L47
final stringOneArgOverloads = <String, Value Function(String, Value)>{
  Overloads.contains.name: stringContains,
  Overloads.endsWith.name: stringEndsWith,
  Overloads.startsWith.name: stringStartsWith,
};

// https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/string.go#L217
Value stringStartsWith(String s, Value value) {
  return BooleanValue(s.startsWith(value.value));
}

Value stringEndsWith(String s, Value value) {
  return BooleanValue(s.endsWith(value.value));
}

Value stringContains(String s, Value value) {
  return BooleanValue(s.contains(value.value));
}
