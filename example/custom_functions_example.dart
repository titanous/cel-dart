// Example: Custom Function Registration with CEL-Dart
// This example demonstrates how to use the exported CEL APIs to create custom functions.

import 'package:cel/cel.dart';

/// Example custom library implementing protovalidate-style validation functions
class ValidationLibrary extends Library {
  @override
  List<ProgramOption> get programOptions => [
    functions(_createValidationOverloads()),
  ];

  @override
  List<EnvironmentOption> get compileEnvironmentOptions => [];

  List<Overload> _createValidationOverloads() {
    return [
      // String validation functions
      Overload('isEmail', unaryOperator: (value) {
        if (value is StringValue) {
          return BooleanValue(_isValidEmail(value.value));
        }
        return BooleanValue(false);
      }),
      
      Overload('isIpv4', unaryOperator: (value) {
        if (value is StringValue) {
          return BooleanValue(_isValidIpv4(value.value));
        }
        return BooleanValue(false);
      }),
      
      // Math functions
      Overload('isNan', unaryOperator: (value) {
        if (value is DoubleValue) {
          return BooleanValue(value.value.isNaN);
        }
        return BooleanValue(false);
      }),
      
      // List functions
      Overload('unique', unaryOperator: (value) {
        if (value is ListValue) {
          return BooleanValue(_isUnique(value.value));
        }
        return BooleanValue(false);
      }),
      
      // Function with multiple arguments
      Overload('inRange', functionOperator: (args) {
        if (args.length != 3) return BooleanValue(false);
        
        final value = args[0];
        final min = args[1];
        final max = args[2];
        
        if (value is IntValue && min is IntValue && max is IntValue) {
          return BooleanValue(value.value >= min.value && value.value <= max.value);
        }
        return BooleanValue(false);
      }),
    ];
  }

  bool _isValidEmail(String value) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(value);
  }

  bool _isValidIpv4(String value) {
    final parts = value.split('.');
    if (parts.length != 4) return false;
    
    for (final part in parts) {
      final num = int.tryParse(part);
      if (num == null || num < 0 || num > 255) return false;
      if (part.length > 1 && part.startsWith('0')) return false;
    }
    return true;
  }

  bool _isUnique(List<dynamic> list) {
    final seen = <dynamic>{};
    for (final item in list) {
      if (seen.contains(item)) return false;
      seen.add(item);
    }
    return true;
  }
}

void main() async {
  print('=== Custom Function Registration Example ===\n');

  // 1. Create environment with standard functions
  final env = Environment.standard();

  // 2. Register custom validation library
  final validationLibrary = ValidationLibrary();
  validationLibrary.toEnvironmentOption()(env);

  // 3. Test various custom functions
  await _testFunction(env, 'isEmail("user@example.com")', 'Valid email test');
  await _testFunction(env, 'isEmail("invalid-email")', 'Invalid email test');
  await _testFunction(env, 'isIpv4("192.168.1.1")', 'Valid IPv4 test');
  await _testFunction(env, 'isIpv4("300.1.1.1")', 'Invalid IPv4 test');
  await _testFunction(env, 'unique([1, 2, 3])', 'Unique list test');
  await _testFunction(env, 'unique([1, 2, 2])', 'Non-unique list test');
  await _testFunction(env, 'inRange(5, 1, 10)', 'In range test');
  await _testFunction(env, 'inRange(15, 1, 10)', 'Out of range test');

  // 4. Test complex expressions combining custom and standard functions
  await _testFunction(env, 'isEmail("user@example.com") && size("test") == 4', 'Complex expression');
  await _testFunction(env, 'unique([1, 2, 3]) || false', 'Logical combination');

  print('\n=== Custom Value Type Creation ===\n');

  // 5. Demonstrate creating simple CEL value types directly
  final stringVal = StringValue('hello');
  final intVal = IntValue(42);
  final boolVal = BooleanValue(true);
  final doubleVal = DoubleValue(3.14);
  final bytesVal = BytesValue.fromCodeUnits([65, 66, 67]); // "ABC" in bytes

  print('StringValue: ${stringVal.value}');
  print('IntValue: ${intVal.value}');
  print('BooleanValue: ${boolVal.value}');
  print('DoubleValue: ${doubleVal.value}');
  print('BytesValue: ${String.fromCharCodes(bytesVal.value)}');

  print('\n=== All examples completed successfully! ===');
}

Future<void> _testFunction(Environment env, String expression, String description) async {
  try {
    final ast = env.compile(expression);
    final program = env.makeProgram(ast);
    final result = await program.evaluate({});
    
    print('✓ $description: $expression => $result');
  } catch (e) {
    print('✗ $description: $expression => ERROR: $e');
  }
}