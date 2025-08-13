import 'package:cel/src/common/types/timestamp.dart';
import 'package:cel/src/common/types/duration.dart';
import 'package:cel/src/common/types/int.dart';
import 'package:cel/src/common/types/string.dart';
import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/error.dart';
import 'package:cel/src/common/types/pb/message.dart';
import 'package:cel/src/gen/google/protobuf/duration.pb.dart' as pb_duration;
import '../timestamp_templates.dart';
import 'functions.dart';

/// Timestamp selector functions for CEL
/// These provide access to timestamp components like year, month, day, etc.
List<Overload> timestampOverloads() {
  return [
    // getFullYear() - returns the year component of the timestamp
    Overload('getFullYear', functionOperator: TimestampTemplates.createTimestampSelector(
      'getFullYear',
      (dateTime) => dateTime.year,
    )),
    
    // getMonth() - returns the month component (0-based)
    Overload('getMonth', functionOperator: TimestampTemplates.createTimestampSelector(
      'getMonth',
      (dateTime) => dateTime.month - 1, // CEL uses 0-based months
    )),
    
    // getDate() - returns the day of month (1-31)
    Overload('getDate', functionOperator: TimestampTemplates.createTimestampSelector(
      'getDate',
      (dateTime) => dateTime.day,
    )),
    
    // getDayOfMonth() - returns the day of month (0-based)
    Overload('getDayOfMonth', functionOperator: TimestampTemplates.createTimestampSelector(
      'getDayOfMonth',
      (dateTime) => dateTime.day - 1, // CEL uses 0-based day of month
    )),
    
    // getDayOfWeek() - returns the day of week (0=Sunday, 6=Saturday)
    Overload('getDayOfWeek', functionOperator: TimestampTemplates.createTimestampSelector(
      'getDayOfWeek',
      (dateTime) {
        // Dart: 1=Monday, 7=Sunday
        // CEL: 0=Sunday, 1=Monday, ... 6=Saturday
        return dateTime.weekday == 7 ? 0 : dateTime.weekday;
      },
    )),
    
    // getDayOfYear() - returns the day of year (0-based)
    Overload('getDayOfYear', functionOperator: TimestampTemplates.createTimestampSelector(
      'getDayOfYear',
      (dateTime) {
        final jan1 = DateTime(dateTime.year, 1, 1);
        return dateTime.difference(jan1).inDays; // 0-based
      },
    )),
    
    
    // getMilliseconds() - returns the millisecond component
    // For Timestamps: returns millisecond component (0-999)  
    // For Durations: returns the millisecond part of the duration
    Overload('getMilliseconds', functionOperator: TimestampTemplates.createTimestampDurationFunction(
      'getMilliseconds',
      (dateTime) => dateTime.millisecond,
      (duration) {
        final totalMicros = duration.inMicroseconds;
        final totalMillis = totalMicros ~/ 1000;
        final seconds = totalMillis ~/ 1000;
        return totalMillis % 1000;
      },
    )),
    
    // Duration-specific functions
    
    // getHours() for Duration - converts duration to hours
    Overload('getHours', functionOperator: TimestampTemplates.createTimestampDurationFunction(
      'getHours',
      (dateTime) => dateTime.hour,
      (duration) => duration.inHours,
    )),
    
    // getMinutes() for Duration - converts duration to minutes
    Overload('getMinutes', functionOperator: TimestampTemplates.createTimestampDurationFunction(
      'getMinutes',
      (dateTime) => dateTime.minute,
      (duration) => duration.inMinutes,
    )),
    
    // getSeconds() for Duration - converts duration to seconds  
    Overload('getSeconds', functionOperator: TimestampTemplates.createTimestampDurationFunction(
      'getSeconds',
      (dateTime) => dateTime.second,
      (duration) => duration.inSeconds,
    )),
  ];
}

// Note: Timezone handling has been moved to TimestampTemplates class