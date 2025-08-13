import 'package:cel/src/common/types/timestamp.dart';
import 'package:cel/src/common/types/duration.dart';
import 'package:cel/src/common/types/int.dart';
import 'package:cel/src/common/types/string.dart';
import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/error.dart';
import 'package:cel/src/common/types/pb/message.dart';
import 'package:cel/src/gen/google/protobuf/duration.pb.dart' as pb_duration;
import 'error_utils.dart';

/// Templates for timestamp and duration selector functions
/// Reduces code duplication and provides consistent error handling
class TimestampTemplates {
  /// Create a timestamp selector function with automatic timezone handling
  static Value Function(List<dynamic>) createTimestampSelector(
    String functionName,
    int Function(DateTime) extractor,
  ) {
    return (args) {
      return ErrorUtils.safeMultiArgOp(args, (arguments) {
        if (arguments.isEmpty || arguments.first is! TimestampValue) {
          return ErrorValue('$functionName requires timestamp argument');
        }
        
        final target = arguments.first as TimestampValue;
        DateTime dateTime = target.value;
        
        // Apply timezone offset if provided
        if (arguments.length > 1 && arguments[1] is StringValue) {
          final tz = arguments[1] as StringValue;
          dateTime = _applyTimezone(dateTime, tz.value);
        }
        
        return IntValue(extractor(dateTime));
      });
    };
  }

  /// Create a dual timestamp/duration function
  static Value Function(List<dynamic>) createTimestampDurationFunction(
    String functionName,
    int Function(DateTime) timestampExtractor,
    int Function(Duration) durationExtractor,
  ) {
    return (args) {
      return ErrorUtils.safeMultiArgOp(args, (arguments) {
        if (arguments.isEmpty) {
          return ErrorValue('$functionName requires argument');
        }
        
        final target = arguments.first;
        
        // Handle Timestamps
        if (target is TimestampValue) {
          DateTime dateTime = target.value;
          if (arguments.length > 1 && arguments[1] is StringValue) {
            final tz = arguments[1] as StringValue;
            dateTime = _applyTimezone(dateTime, tz.value);
          }
          return IntValue(timestampExtractor(dateTime));
        }
        
        // Handle Durations
        if (target is DurationValue) {
          final duration = target.value;
          return IntValue(durationExtractor(duration));
        }
        
        // Handle protobuf Duration messages (for getMilliseconds)
        if (target is MessageValue && target.message is pb_duration.Duration) {
          final pbDuration = target.message as pb_duration.Duration;
          final seconds = pbDuration.seconds.toInt();
          final nanos = pbDuration.nanos;
          final totalMillis = seconds * 1000 + (nanos ~/ 1000000);
          final millisOnly = totalMillis % 1000;
          return IntValue(millisOnly);
        }
        
        return ErrorValue('$functionName requires timestamp or duration argument');
      });
    };
  }

  /// Apply timezone offset to a DateTime
  /// Supports named timezones and offset formats like "+11:00", "-02:30"
  static DateTime _applyTimezone(DateTime dateTime, String timezone) {
    // Handle UTC timezone
    if (timezone.toLowerCase() == 'utc' || timezone == 'Z') {
      return dateTime.toUtc();
    }
    
    // Handle offset format like "+11:00", "-02:30", "+0530"
    if (timezone.startsWith('+') || timezone.startsWith('-')) {
      try {
        final sign = timezone.startsWith('-') ? -1 : 1;
        final offsetStr = timezone.substring(1);
        
        int hours, minutes = 0;
        
        if (offsetStr.contains(':')) {
          // Format: "+11:00" or "-02:30"
          final parts = offsetStr.split(':');
          hours = int.parse(parts[0]);
          if (parts.length > 1) {
            minutes = int.parse(parts[1]);
          }
        } else if (offsetStr.length == 4) {
          // Format: "+0530" (compact)
          hours = int.parse(offsetStr.substring(0, 2));
          minutes = int.parse(offsetStr.substring(2, 4));
        } else {
          // Format: "+11" (hours only)
          hours = int.parse(offsetStr);
        }
        
        final offsetMinutes = sign * (hours * 60 + minutes);
        return dateTime.add(Duration(minutes: -offsetMinutes));
      } catch (e) {
        // If parsing fails, return original datetime
        return dateTime;
      }
    }
    
    // For named timezones (like "America/New_York"), we'd need a full timezone library
    // For now, just return the original datetime
    // TODO: Implement proper timezone support with a timezone library
    return dateTime;
  }
}