import 'package:test/test.dart';
import 'package:cel/cel.dart';

void main() {
  group('Multiple Overloads', () {
    test('Function with only unary operator', () {
      final env = Environment.standard();
      env.programOptions.add(
        functions([
          Overload('funcA', unaryOperator: (value) {
            if (value is StringValue) {
              return StringValue('unary: ${value.value}');
            }
            return ErrorValue('Expected string');
          })
        ])
      );
      
      final ast = env.compile('"test".funcA()');
      final program = env.makeProgram(ast);
      
      final result = program.evaluate({});
      expect(result, equals('unary: test'));
    });

    test('Function with both unary and binary operators', () {
      final env = Environment.standard();
      env.programOptions.add(
        functions([
          Overload('funcB', unaryOperator: (value) {
            if (value is StringValue) {
              return StringValue('unary: ${value.value}');
            }
            return ErrorValue('Expected string');
          }),
          Overload('funcB', binaryOperator: (left, right) {
            if (left is StringValue && right is IntValue) {
              return StringValue('binary: ${left.value} ${right.value}');
            }
            return ErrorValue('Expected string and int');
          })
        ])
      );
      
      // Test unary call
      var ast = env.compile('"test".funcB()');
      var program = env.makeProgram(ast);
      var result = program.evaluate({});
      expect(result, equals('unary: test'));

      // Test binary call
      ast = env.compile('"test".funcB(42)');
      program = env.makeProgram(ast);
      result = program.evaluate({});
      expect(result, equals('binary: test 42'));
    });

    test('Function with multiple overload types', () {
      final env = Environment.standard();
      
      final overloads = [
        // Unary version
        Overload('isIpPrefix', unaryOperator: (value) {
          if (value is StringValue) {
            return BooleanValue(value.value == '0.0.0.0/0');
          }
          return BooleanValue(false);
        }),
        // For binary and ternary, use functionOperator to handle all cases
        Overload('isIpPrefix', functionOperator: (args) {
          // Binary with int version
          if (args.length == 2 && args[0] is StringValue && args[1] is IntValue) {
            final str = args[0] as StringValue;
            final version = args[1] as IntValue;
            return BooleanValue(
                str.value == '0.0.0.0/0' && version.value == 4);
          }
          // Binary with bool version
          if (args.length == 2 && args[0] is StringValue && args[1] is BooleanValue) {
            final str = args[0] as StringValue;
            final strict = args[1] as BooleanValue;
            return BooleanValue(str.value == '0.0.0.0/0' && strict.value);
          }
          // Ternary version
          if (args.length == 3 && 
              args[0] is StringValue && 
              args[1] is IntValue && 
              args[2] is BooleanValue) {
            final str = args[0] as StringValue;
            final version = args[1] as IntValue;
            final strict = args[2] as BooleanValue;
            return BooleanValue(
                str.value == '0.0.0.0/0' && version.value == 4 && strict.value);
          }
          return ErrorValue('Invalid arguments for isIpPrefix');
        })
      ];
      
      env.programOptions.add(functions(overloads));

      // Test unary version
      var ast = env.compile('"0.0.0.0/0".isIpPrefix()');
      var program = env.makeProgram(ast);
      var result = program.evaluate({});
      expect(result, isTrue);

      // Test binary with int
      ast = env.compile('"0.0.0.0/0".isIpPrefix(4)');
      program = env.makeProgram(ast);
      result = program.evaluate({});
      expect(result, isTrue);

      // Test binary with bool
      ast = env.compile('"0.0.0.0/0".isIpPrefix(true)');
      program = env.makeProgram(ast);
      result = program.evaluate({});
      expect(result, isTrue);

      // Test ternary version
      ast = env.compile('"0.0.0.0/0".isIpPrefix(4, true)');
      program = env.makeProgram(ast);
      result = program.evaluate({});
      expect(result, isTrue);
    });

    test('Overload priority: specific operators over functionOperator', () {
      final env = Environment.standard();
      env.programOptions.add(
        functions([
          Overload('testFunc', 
            unaryOperator: (value) => StringValue('unary'),
            functionOperator: (args) => StringValue('function'))
        ])
      );
      
      final ast = env.compile('"test".testFunc()');
      final program = env.makeProgram(ast);
      final result = program.evaluate({});
      // Should use unaryOperator, not functionOperator
      expect(result, equals('unary'));
    });

    test('FunctionOperator fallback when no specific operator', () {
      final env = Environment.standard();
      
      final overload = Overload('testFunc', 
        functionOperator: (args) {
          if (args.length == 1) {
            return StringValue('function-1');
          } else if (args.length == 2) {
            return StringValue('function-2');
          }
          return StringValue('function-many');
        });
      
      env.programOptions.add(functions([overload]));

      // Test with 1 argument
      var ast = env.compile('"test".testFunc()');
      var program = env.makeProgram(ast);
      var result = program.evaluate({});
      expect(result, equals('function-1'));

      // Test with 2 arguments
      ast = env.compile('"test".testFunc(42)');
      program = env.makeProgram(ast);
      result = program.evaluate({});
      expect(result, equals('function-2'));

      // Test with 3 arguments
      ast = env.compile('"test".testFunc(1, 2)');
      program = env.makeProgram(ast);
      result = program.evaluate({});
      expect(result, equals('function-many'));
    });

    test('CEL-ES style type-based overload resolution', () {
      final env = Environment.standard();
      
      // Define multiple binary overloads with explicit type signatures (CEL-ES style)
      env.programOptions.add(functions([
        Overload('isIpPrefix',
          parameterTypes: [CelType.string, CelType.int],
          returnType: CelType.bool,
          binaryOperator: (prefix, version) {
            if (prefix is StringValue && version is IntValue) {
              // Simplified logic for testing
              return BooleanValue(prefix.value == '0.0.0.0/0' && version.value == 4);
            }
            return ErrorValue('Expected string and int');
          }
        ),
        Overload('isIpPrefix',
          parameterTypes: [CelType.string, CelType.bool],
          returnType: CelType.bool,
          binaryOperator: (prefix, strict) {
            if (prefix is StringValue && strict is BooleanValue) {
              // Simplified logic for testing
              return BooleanValue(prefix.value == '0.0.0.0/0' && strict.value);
            }
            return ErrorValue('Expected string and bool');
          }
        ),
      ]));

      // Test int version
      var ast = env.compile('"0.0.0.0/0".isIpPrefix(4)');
      var program = env.makeProgram(ast);
      var result = program.evaluate({});
      expect(result, isTrue);

      // Test bool version
      ast = env.compile('"0.0.0.0/0".isIpPrefix(true)');
      program = env.makeProgram(ast);
      result = program.evaluate({});
      expect(result, isTrue);
      
      // Test with wrong type (should fail gracefully)
      ast = env.compile('"0.0.0.0/0".isIpPrefix("invalid")');
      program = env.makeProgram(ast);
      result = program.evaluate({});
      // Should now return an ErrorValue with overload information
      expect(result, isA<ErrorValue>());
      expect(result.toString().toLowerCase(), contains('overload'));
    });
  });
}