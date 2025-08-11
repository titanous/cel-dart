import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/traits/traits.dart';
import 'package:cel/src/common/types/traits/comparer.dart';
import 'package:cel/src/common/types/int.dart';
import 'package:cel/src/common/types/error.dart';
import 'package:cel/src/common/types/duration.dart';

/// Represents a CEL timestamp value (google.protobuf.Timestamp)
class TimestampValue extends Value implements Comparer {
  TimestampValue(this.dateTime);

  final DateTime dateTime;

  @override
  dynamic get value => dateTime;

  @override
  Type_ get type => Type_('google.protobuf.Timestamp', {Traits.ComparerType});

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
      return TimestampValue(dateTime.add(other.value));
    }
    return ErrorValue('cannot add ${other.runtimeType} to timestamp');
  }

  /// Subtract a duration or another timestamp
  Value subtract(Value other) {
    if (other is DurationValue) {
      return TimestampValue(dateTime.subtract(other.value));
    }
    if (other is TimestampValue) {
      // Returns a duration
      return DurationValue(dateTime.difference(other.dateTime));
    }
    return ErrorValue('cannot subtract ${other.runtimeType} from timestamp');
  }
}
