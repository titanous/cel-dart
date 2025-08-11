import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/traits/traits.dart';
import 'package:cel/src/common/types/traits/comparer.dart';
import 'package:cel/src/common/types/traits/math.dart';
import 'package:cel/src/common/types/int.dart';
import 'package:cel/src/common/types/error.dart';
import 'package:cel/src/common/types/timestamp.dart';

/// Represents a CEL duration value (google.protobuf.Duration)
class DurationValue extends Value
    implements Comparer, Adder, Subtractor, Multiplier, Divider {
  final Duration duration;

  DurationValue(this.duration);

  @override
  dynamic get value => duration;

  @override
  Type_ get type => Type_('google.protobuf.Duration', {
        Traits.ComparerType,
        Traits.AdderType,
        Traits.SubtractorType,
        Traits.MultiplierType,
        Traits.DividerType
      });

  @override
  dynamic convertToNative() => duration;

  @override
  List<Object?> get props => [duration];

  @override
  String toString() {
    final totalSeconds = duration.inSeconds;
    if (totalSeconds == 0) {
      return '0s';
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
    return totalSeconds < 0 ? '-$result' : result;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DurationValue && duration == other.duration;

  @override
  int get hashCode => duration.hashCode;

  @override
  IntValue compare(Value other) {
    if (other is! DurationValue) {
      return IntValue(1); // Non-durations are considered greater
    }

    return IntValue(duration.compareTo(other.duration));
  }

  @override
  Value add(Value other) {
    if (other is DurationValue) {
      return DurationValue(duration + other.duration);
    }
    if (other is TimestampValue) {
      // Adding duration to timestamp returns timestamp
      return TimestampValue(other.dateTime.add(duration));
    }
    return ErrorValue('cannot add ${other.runtimeType} to duration');
  }

  @override
  Value subtract(Value other) {
    if (other is DurationValue) {
      return DurationValue(duration - other.duration);
    }
    return ErrorValue('cannot subtract ${other.runtimeType} from duration');
  }

  @override
  Value multiply(Value other) {
    if (other is IntValue) {
      return DurationValue(duration * other.value);
    }
    return ErrorValue('cannot multiply duration by ${other.runtimeType}');
  }

  @override
  Value divide(Value other) {
    if (other is IntValue) {
      if (other.value == 0) {
        return ErrorValue('division by zero');
      }
      return DurationValue(duration ~/ other.value);
    }
    if (other is DurationValue) {
      // Dividing duration by duration returns an integer ratio
      if (other.duration.inMicroseconds == 0) {
        return ErrorValue('division by zero');
      }
      return IntValue(duration.inMicroseconds ~/ other.duration.inMicroseconds);
    }
    return ErrorValue('cannot divide duration by ${other.runtimeType}');
  }

  Value modulo(Value other) {
    if (other is DurationValue) {
      if (other.duration.inMicroseconds == 0) {
        return ErrorValue('modulo by zero');
      }
      final remainder = duration.inMicroseconds % other.duration.inMicroseconds;
      return DurationValue(Duration(microseconds: remainder));
    }
    return ErrorValue('cannot take modulo of duration by ${other.runtimeType}');
  }
}
