// Test file to verify that the exported APIs work correctly for custom function registration
import 'package:test/test.dart';
import 'package:cel/cel.dart';

// Example custom library implementation using the exported APIs
class TestValidationLibrary extends Library {
  @override
  List<ProgramOption> get programOptions => [
    functions(_createValidationOverloads()),
  ];

  @override
  List<EnvironmentOption> get compileEnvironmentOptions => [];

  List<Overload> _createValidationOverloads() {
    return [
      // Test unary function
      Overload('isEmail', unaryOperator: (value) {
        if (value is StringValue) {
          return BooleanValue(_isValidEmail(value.value));
        }
        return BooleanValue(false);
      }),
      
      // Test binary function  
      Overload('startsWith', binaryOperator: (left, right) {
        if (left is StringValue && right is StringValue) {
          return BooleanValue(left.value.startsWith(right.value));
        }
        return BooleanValue(false);
      }),
      
      // Test function with variable arguments
      Overload('concat', functionOperator: (args) {
        final buffer = StringBuffer();
        for (final arg in args) {
          if (arg is StringValue) {
            buffer.write(arg.value);
          }
        }
        return StringValue(buffer.toString());
      }),
      
      // Test math function
      Overload('isNaN', unaryOperator: (value) {
        if (value is DoubleValue) {
          return BooleanValue(value.value.isNaN);
        }
        return BooleanValue(false);
      }),
      
      // Test list function
      Overload('unique', unaryOperator: (value) {
        if (value is ListValue) {
          final seen = <dynamic>{};
          for (final item in value.value) {
            if (seen.contains(item)) {
              return BooleanValue(false);
            }
            seen.add(item);
          }
          return BooleanValue(true);
        }
        return BooleanValue(false);
      }),
    ];
  }

  bool _isValidEmail(String value) {
    // Simple email validation for testing
    return value.contains('@') && value.contains('.');
  }
}

void main() {
  group('Library Extension API', () {
    test('can create custom library with exported types', () {
      // Test that we can create a custom library using exported APIs
      final library = TestValidationLibrary();
      
      expect(library.programOptions, isNotEmpty);
      expect(library.compileEnvironmentOptions, isEmpty);
    });
    
    test('can register custom functions in environment', () {
      // Test that we can apply a custom library to an environment
      final env = Environment.standard();
      final library = TestValidationLibrary();
      
      // Apply the library to the environment
      library.toEnvironmentOption()(env);
      
      // Verify environment was modified (should have our custom program options)
      expect(env.programOptions, isNotEmpty);
    });
    
    test('exported value types work correctly', () {
      // Test that we can create and use the exported value types
      final boolVal = BooleanValue(true);
      final stringVal = StringValue('test');
      final intVal = IntValue(42);
      final doubleVal = DoubleValue(3.14);
      
      expect(boolVal.value, isTrue);
      expect(stringVal.value, equals('test'));
      expect(intVal.value, equals(42));
      expect(doubleVal.value, equals(3.14));
    });
    
    test('can create overloads with different operator types', () {
      // Test that we can create overloads using exported operator types
      final unaryOverload = Overload('test_unary', unaryOperator: (v) => BooleanValue(true));
      final binaryOverload = Overload('test_binary', binaryOperator: (l, r) => BooleanValue(false));
      final functionOverload = Overload('test_function', functionOperator: (args) => IntValue(args.length));
      
      expect(unaryOverload.name, equals('test_unary'));
      expect(unaryOverload.unaryOperator, isNotNull);
      expect(binaryOverload.binaryOperator, isNotNull);
      expect(functionOverload.functionOperator, isNotNull);
    });
  });
}