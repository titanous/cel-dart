import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/traits/traits.dart';
import 'package:cel/src/common/types/traits/comparer.dart';
import 'package:cel/src/common/types/traits/indexer.dart';
import 'package:cel/src/common/types/int.dart';
import 'package:cel/src/common/types/error.dart';
import 'package:cel/src/common/types/duration.dart';
import 'package:cel/src/common/types/string.dart';
import 'package:cel/src/common/types/null_.dart';

/// Represents a CEL timestamp value (google.protobuf.Timestamp)
class TimestampValue extends Value implements Comparer, Indexer {
  TimestampValue(this.dateTime);

  final DateTime dateTime;

  @override
  dynamic get value => dateTime;

  @override
  Type_ get type => Type_('google.protobuf.Timestamp', {Traits.ComparerType, Traits.IndexerType});

  @override
  dynamic convertToNative() => dateTime;

  @override
  List<Object?> get props => [dateTime];

  @override
  String toString() => dateTime.toIso8601String();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimestampValue && dateTime.isAtSameMomentAs(other.dateTime);

  @override
  int get hashCode => dateTime.hashCode;

  @override
  IntValue compare(Value other) {
    if (other is! TimestampValue) {
      return IntValue(1); // Non-timestamps are considered greater
    }

    if (dateTime.isBefore(other.dateTime)) {
      return IntValue(-1);
    } else if (dateTime.isAfter(other.dateTime)) {
      return IntValue(1);
    } else {
      return IntValue(0);
    }
  }

  /// Add a duration to this timestamp
  Value add(Value other) {
    if (other is DurationValue) {
      try {
        final result = dateTime.add(other.value);
        if (!_isValidTimestamp(result)) {
          return ErrorValue('range');
        }
        return TimestampValue(result);
      } catch (e) {
        return ErrorValue('range');
      }
    }
    return ErrorValue('cannot add ${other.runtimeType} to timestamp');
  }

  /// Subtract a duration or another timestamp
  Value subtract(Value other) {
    if (other is DurationValue) {
      try {
        final result = dateTime.subtract(other.value);
        if (!_isValidTimestamp(result)) {
          return ErrorValue('range');
        }
        return TimestampValue(result);
      } catch (e) {
        return ErrorValue('range');
      }
    }
    if (other is TimestampValue) {
      // Returns a duration - check for overflow
      try {
        final difference = dateTime.difference(other.dateTime);
        if (!_isValidDuration(difference)) {
          return ErrorValue('range');
        }
        return DurationValue(difference);
      } catch (e) {
        return ErrorValue('range');
      }
    }
    return ErrorValue('cannot subtract ${other.runtimeType} from timestamp');
  }

  /// Check if a timestamp is within valid CEL range (year 1 to 9999)
  static bool _isValidTimestamp(DateTime dt) {
    return dt.year >= 1 && dt.year <= 9999;
  }

  /// Check if a duration is within valid CEL range
  static bool _isValidDuration(Duration duration) {
    // CEL duration range: -315,576,000,000 to +315,576,000,000 seconds
    // This corresponds to approximately +/- 10,000 years
    const maxSeconds = 315576000000;
    return duration.inSeconds.abs() <= maxSeconds;
  }

  /// Get field value by name for protobuf compatibility
  @override
  Value get(Value field) {
    if (field is! StringValue) {
      return NullValue();
    }

    final fieldName = field.value;
    switch (fieldName) {
      case 'seconds':
        // Return seconds since Unix epoch (1970-01-01 00:00:00 UTC)
        return IntValue(dateTime.millisecondsSinceEpoch ~/ 1000);
      case 'nanos':
        // Return the nanosecond portion (microseconds * 1000)
        return IntValue((dateTime.microsecondsSinceEpoch % 1000000) * 1000);
      default:
        return NullValue();
    }
  }
}
