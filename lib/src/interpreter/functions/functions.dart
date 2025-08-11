// https://github.com/google/cel-go/blob/master/interpreter/functions/functions.go

import '../../common/types/ref/value.dart';

/// Represents a CEL type for overload signatures
enum CelType {
  any,
  bool, 
  int,
  uint,
  double,
  string,
  bytes,
  list,
  map,
  timestamp,
  duration,
}

class Overload {
  Overload(this.name, {
    this.unaryOperator, 
    this.binaryOperator, 
    this.functionOperator,
    this.parameterTypes,
    this.returnType,
  });

  final String name;
  UnaryOperator? unaryOperator;
  BinaryOperator? binaryOperator;
  FunctionOperator? functionOperator;
  
  /// Parameter types for this overload (used for type-based dispatch)
  final List<CelType>? parameterTypes;
  
  /// Return type for this overload
  final CelType? returnType;
  
  /// Check if this overload matches the given argument types
  bool matchesArgumentTypes(List<Value> args) {
    if (parameterTypes == null) return true; // No type constraints
    if (args.length != parameterTypes!.length) return false;
    
    for (int i = 0; i < args.length; i++) {
      if (!_matchesType(args[i], parameterTypes![i])) return false;
    }
    return true;
  }
  
  bool _matchesType(Value value, CelType expectedType) {
    final actualType = value.runtimeType.toString();
    
    switch (expectedType) {
      case CelType.any:
        return true;
      case CelType.bool:
        return actualType == 'BooleanValue';
      case CelType.int:
        return actualType == 'IntValue';
      case CelType.uint:
        return actualType == 'UintValue';
      case CelType.double:
        return actualType == 'DoubleValue';
      case CelType.string:
        return actualType == 'StringValue';
      case CelType.bytes:
        return actualType == 'BytesValue';
      case CelType.list:
        return actualType == 'ListValue';
      case CelType.map:
        return actualType == 'MapValue';
      case CelType.timestamp:
        return actualType == 'TimestampValue';
      case CelType.duration:
        return actualType == 'DurationValue';
    }
  }
}

typedef UnaryOperator = dynamic Function(dynamic value);

typedef BinaryOperator = dynamic Function(
    dynamic leftHandSide, dynamic rightHandSide);

typedef FunctionOperator = dynamic Function(List<dynamic> args);
