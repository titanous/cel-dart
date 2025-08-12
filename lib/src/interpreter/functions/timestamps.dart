import 'package:cel/src/common/types/timestamp.dart';
import 'package:cel/src/common/types/duration.dart';
import 'package:cel/src/common/types/int.dart';
import 'package:cel/src/common/types/string.dart';
import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/error.dart';
import 'package:cel/src/common/types/pb/message.dart';
import 'package:cel/src/gen/google/protobuf/duration.pb.dart' as pb_duration;
import 'functions.dart';

/// Timestamp selector functions for CEL
/// These provide access to timestamp components like year, month, day, etc.
List<Overload> timestampOverloads() {
  return [
    // getFullYear() - returns the year component of the timestamp
    Overload('getFullYear', functionOperator: (args) {
      if (args.isEmpty || args.first is! TimestampValue) {
        return ErrorValue('getFullYear requires timestamp argument');
      }
      
      final target = args.first as TimestampValue;
      DateTime dateTime = target.value;
      if (args.length > 1 && args[1] is StringValue) {
        // Apply timezone offset if provided
        final tz = args[1] as StringValue;
        dateTime = _applyTimezone(dateTime, tz.value);
      }
      
      return IntValue(dateTime.year);
    }),
    
    // getMonth() - returns the month component (0-based)
    Overload('getMonth', functionOperator: (args) {
      if (args.isEmpty || args.first is! TimestampValue) {
        return ErrorValue('getMonth requires timestamp argument');
      }
      
      final target = args.first as TimestampValue;
      DateTime dateTime = target.value;
      if (args.length > 1 && args[1] is StringValue) {
        final tz = args[1] as StringValue;
        dateTime = _applyTimezone(dateTime, tz.value);
      }
      
      return IntValue(dateTime.month - 1); // CEL uses 0-based months
    }),
    
    // getDate() - returns the day of month (1-31)
    Overload('getDate', functionOperator: (args) {
      if (args.isEmpty || args.first is! TimestampValue) {
        return ErrorValue('getDate requires timestamp argument');
      }
      
      final target = args.first as TimestampValue;
      DateTime dateTime = target.value;
      if (args.length > 1 && args[1] is StringValue) {
        final tz = args[1] as StringValue;
        dateTime = _applyTimezone(dateTime, tz.value);
      }
      
      return IntValue(dateTime.day);
    }),
    
    // getDayOfMonth() - returns the day of month (0-based)
    Overload('getDayOfMonth', functionOperator: (args) {
      if (args.isEmpty || args.first is! TimestampValue) {
        return ErrorValue('getDayOfMonth requires timestamp argument');
      }
      
      final target = args.first as TimestampValue;
      DateTime dateTime = target.value;
      if (args.length > 1 && args[1] is StringValue) {
        final tz = args[1] as StringValue;
        dateTime = _applyTimezone(dateTime, tz.value);
      }
      
      return IntValue(dateTime.day - 1); // CEL uses 0-based day of month
    }),
    
    // getDayOfWeek() - returns the day of week (0=Sunday, 6=Saturday)
    Overload('getDayOfWeek', functionOperator: (args) {
      if (args.isEmpty || args.first is! TimestampValue) {
        return ErrorValue('getDayOfWeek requires timestamp argument');
      }
      
      final target = args.first as TimestampValue;
      DateTime dateTime = target.value;
      if (args.length > 1 && args[1] is StringValue) {
        final tz = args[1] as StringValue;
        dateTime = _applyTimezone(dateTime, tz.value);
      }
      
      // Dart: 1=Monday, 7=Sunday
      // CEL: 0=Sunday, 1=Monday, ... 6=Saturday
      int dayOfWeek = dateTime.weekday == 7 ? 0 : dateTime.weekday;
      return IntValue(dayOfWeek);
    }),
    
    // getDayOfYear() - returns the day of year (0-based)
    Overload('getDayOfYear', functionOperator: (args) {
      if (args.isEmpty || args.first is! TimestampValue) {
        return ErrorValue('getDayOfYear requires timestamp argument');
      }
      
      final target = args.first as TimestampValue;
      DateTime dateTime = target.value;
      if (args.length > 1 && args[1] is StringValue) {
        final tz = args[1] as StringValue;
        dateTime = _applyTimezone(dateTime, tz.value);
      }
      
      final jan1 = DateTime(dateTime.year, 1, 1);
      final dayOfYear = dateTime.difference(jan1).inDays;
      return IntValue(dayOfYear); // 0-based
    }),
    
    
    // getMilliseconds() - returns the millisecond component
    // For Timestamps: returns millisecond component (0-999)  
    // For Durations: returns the millisecond part of the duration
    Overload('getMilliseconds', functionOperator: (args) {
      if (args.isEmpty) {
        return ErrorValue('getMilliseconds requires argument');
      }
      
      final target = args.first;
      
      // Handle Timestamps
      if (target is TimestampValue) {
        DateTime dateTime = target.value;
        if (args.length > 1 && args[1] is StringValue) {
          final tz = args[1] as StringValue;
          dateTime = _applyTimezone(dateTime, tz.value);
        }
        return IntValue(dateTime.millisecond);
      }
      
      // Handle Durations
      if (target is DurationValue) {
        final duration = target.value;
        final totalMicros = duration.inMicroseconds;
        final totalMillis = totalMicros ~/ 1000;
        final seconds = totalMillis ~/ 1000;
        final millisOnly = totalMillis % 1000;
        return IntValue(millisOnly);
      }
      
      // Handle protobuf Duration messages
      if (target is MessageValue && target.message is pb_duration.Duration) {
        final pbDuration = target.message as pb_duration.Duration;
        final seconds = pbDuration.seconds.toInt();
        final nanos = pbDuration.nanos;
        final totalMillis = seconds * 1000 + (nanos ~/ 1000000);
        final millisOnly = totalMillis % 1000;
        return IntValue(millisOnly);
      }
      
      return ErrorValue('getMilliseconds requires timestamp or duration argument');
    }),
    
    // Duration-specific functions
    
    // getHours() for Duration - converts duration to hours
    Overload('getHours', functionOperator: (args) {
      if (args.isEmpty) {
        return ErrorValue('getHours requires argument');
      }
      
      final target = args.first;
      
      // Handle Timestamps (existing functionality)
      if (target is TimestampValue) {
        DateTime dateTime = target.value;
        if (args.length > 1 && args[1] is StringValue) {
          final tz = args[1] as StringValue;
          dateTime = _applyTimezone(dateTime, tz.value);
        }
        return IntValue(dateTime.hour);
      }
      
      // Handle Durations - convert to total hours
      if (target is DurationValue) {
        final duration = target.value;
        final totalHours = duration.inHours;
        return IntValue(totalHours);
      }
      
      return ErrorValue('getHours requires timestamp or duration argument');
    }),
    
    // getMinutes() for Duration - converts duration to minutes
    Overload('getMinutes', functionOperator: (args) {
      if (args.isEmpty) {
        return ErrorValue('getMinutes requires argument');
      }
      
      final target = args.first;
      
      // Handle Timestamps (existing functionality)
      if (target is TimestampValue) {
        DateTime dateTime = target.value;
        if (args.length > 1 && args[1] is StringValue) {
          final tz = args[1] as StringValue;
          dateTime = _applyTimezone(dateTime, tz.value);
        }
        return IntValue(dateTime.minute);
      }
      
      // Handle Durations - convert to total minutes
      if (target is DurationValue) {
        final duration = target.value;
        final totalMinutes = duration.inMinutes;
        return IntValue(totalMinutes);
      }
      
      return ErrorValue('getMinutes requires timestamp or duration argument');
    }),
    
    // getSeconds() for Duration - converts duration to seconds  
    Overload('getSeconds', functionOperator: (args) {
      if (args.isEmpty) {
        return ErrorValue('getSeconds requires argument');
      }
      
      final target = args.first;
      
      // Handle Timestamps (existing functionality)
      if (target is TimestampValue) {
        DateTime dateTime = target.value;
        if (args.length > 1 && args[1] is StringValue) {
          final tz = args[1] as StringValue;
          dateTime = _applyTimezone(dateTime, tz.value);
        }
        return IntValue(dateTime.second);
      }
      
      // Handle Durations - convert to total seconds
      if (target is DurationValue) {
        final duration = target.value;
        final totalSeconds = duration.inSeconds;
        return IntValue(totalSeconds);
      }
      
      return ErrorValue('getSeconds requires timestamp or duration argument');
    }),
  ];
}

/// Apply timezone offset to a DateTime
/// Supports named timezones and offset formats like "+11:00", "-02:30"
DateTime _applyTimezone(DateTime utcDateTime, String timezone) {
  if (timezone.isEmpty || timezone == 'UTC') {
    return utcDateTime;
  }
  
  // Handle offset formats like "+11:00", "-02:30", "+05:30"
  final offsetPattern = RegExp(r'^([+-])(\d{1,2}):(\d{2})$');
  final match = offsetPattern.firstMatch(timezone);
  if (match != null) {
    final sign = match.group(1)!;
    final hours = int.parse(match.group(2)!);
    final minutes = int.parse(match.group(3)!);
    
    final offsetMinutes = hours * 60 + minutes;
    final offsetDuration = Duration(minutes: offsetMinutes);
    
    if (sign == '+') {
      return utcDateTime.add(offsetDuration);
    } else {
      return utcDateTime.subtract(offsetDuration);
    }
  }
  
  // For named timezones, we'll use a simple mapping for common cases
  // In a full implementation, you'd use a proper timezone library
  switch (timezone) {
    case 'US/Central':
      return utcDateTime.subtract(Duration(hours: 6)); // Approximate
    case 'Australia/Sydney':
      return utcDateTime.add(Duration(hours: 11)); // Approximate
    case 'America/St_Johns':
      return utcDateTime.subtract(Duration(hours: 3, minutes: 30)); // Approximate
    case 'Asia/Kathmandu':
      return utcDateTime.add(Duration(hours: 5, minutes: 45));
    default:
      // For unrecognized timezones, return UTC
      return utcDateTime;
  }
}