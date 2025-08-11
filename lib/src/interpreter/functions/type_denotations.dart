import 'package:cel/src/common/types/type.dart';
import 'functions.dart';

/// Type denotations for CEL
/// These provide access to type values like bool, int, uint, etc.
/// Based on CEL specification type denotations
List<Overload> typeDenotationOverloads() {
  return [
    // bool type denotation - implemented as zero-argument function
    Overload('bool', functionOperator: (args) {
      if (args.isEmpty) {
        return TypeValue('bool');
      }
      // Fallback to conversion function if arguments provided
      return null; // Will be handled by the bool conversion function
    }),
    
    // int type denotation  
    Overload('int', functionOperator: (args) {
      if (args.isEmpty) {
        return TypeValue('int');
      }
      return null; // Will be handled by the int conversion function
    }),
    
    // uint type denotation
    Overload('uint', functionOperator: (args) {
      if (args.isEmpty) {
        return TypeValue('uint');
      }
      return null; // Will be handled by the uint conversion function
    }),
    
    // double type denotation
    Overload('double', functionOperator: (args) {
      if (args.isEmpty) {
        return TypeValue('double');
      }
      return null; // Will be handled by the double conversion function
    }),
    
    // string type denotation
    Overload('string', functionOperator: (args) {
      if (args.isEmpty) {
        return TypeValue('string');
      }
      return null; // Will be handled by the string conversion function
    }),
    
    // bytes type denotation
    Overload('bytes', functionOperator: (args) {
      if (args.isEmpty) {
        return TypeValue('bytes');
      }
      return null; // Will be handled by the bytes conversion function
    }),
    
    // list type denotation
    Overload('list', functionOperator: (args) {
      if (args.isEmpty) {
        return TypeValue('list');
      }
      return null;
    }),
    
    // map type denotation
    Overload('map', functionOperator: (args) {
      if (args.isEmpty) {
        return TypeValue('map');
      }
      return null;
    }),
    
    // type type denotation
    Overload('type', functionOperator: (args) {
      if (args.isEmpty) {
        return TypeValue('type');
      }
      return null; // Will be handled by the type() function
    }),
    
    // null_type denotation
    Overload('null_type', functionOperator: (args) {
      if (args.isEmpty) {
        return TypeValue('null_type');
      }
      return null;
    }),
    
    // dyn type denotation (dynamic type)
    Overload('dyn', functionOperator: (args) {
      if (args.isEmpty) {
        return TypeValue('dyn');
      }
      return null; // Will be handled by the dyn conversion function
    }),
  ];
}