import 'extension.dart';
import '../functions/functions.dart';
import '../functions/timestamps.dart';
import '../functions/conversions.dart';

/// Timestamp and Duration extension providing time-related functionality
class TimestampsExtension extends CelExtension {
  @override
  String get name => 'timestamps';
  
  @override
  List<Overload> get functions => [
    ...timestampOverloads(),
    // Add conversion functions related to timestamps
    ...conversionOverloads().where((o) => 
      o.name == 'timestamp' || o.name == 'duration').toList(),
  ];
}

/// Math extension providing mathematical functions
class MathExtension extends CelExtension {
  @override
  String get name => 'math';
  
  @override
  List<Overload> get functions => [
    // Basic math functions can be added here
    // For now, include isNan, isInf, isFinite from standard overloads
  ];
}

/// Strings extension providing string manipulation functions
class StringsExtension extends CelExtension {
  @override
  String get name => 'strings';
  
  @override
  List<Overload> get functions => [
    // String functions from standard overloads
    // startsWith, endsWith, contains, etc.
  ];
}

/// Lists extension providing list manipulation functions
class ListsExtension extends CelExtension {
  @override
  String get name => 'lists';
  
  @override
  List<Overload> get functions => [
    // List manipulation functions
    // size, unique, etc.
  ];
}