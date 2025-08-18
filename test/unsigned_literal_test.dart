import 'package:test/test.dart';
import 'package:cel/cel.dart';

void main() {
  group('Unsigned Literal Tests', () {
    test('unsigned literals in modulo operations should work', () {
      final env = Environment.standard();
      final ast = env.compile('this % 2u == 0u');
      final program = env.makeProgram(ast);
      
      // Test with even number
      final result1 = program.evaluate({'this': 2});
      expect(result1, equals(true));
      
      // Test with odd number
      final result2 = program.evaluate({'this': 3});
      expect(result2, equals(false));
    });

    test('unsigned literals in other arithmetic operations should work', () {
      final env = Environment.standard();
      
      // Test addition
      final addProgram = env.makeProgram(env.compile('this + 5u'));
      expect(addProgram.evaluate({'this': 10}), equals(15));
      
      // Test subtraction
      final subProgram = env.makeProgram(env.compile('this - 3u'));
      expect(subProgram.evaluate({'this': 10}), equals(7));
      
      // Test multiplication
      final mulProgram = env.makeProgram(env.compile('this * 4u'));
      expect(mulProgram.evaluate({'this': 5}), equals(20));
      
      // Test division
      final divProgram = env.makeProgram(env.compile('this / 2u'));
      expect(divProgram.evaluate({'this': 10}), equals(5));
    });

    test('mixed int and uint operations should work', () {
      final env = Environment.standard();
      
      // Mix of signed and unsigned literals
      final program = env.makeProgram(env.compile('(this + 5u) % 3 == 2u'));
      expect(program.evaluate({'this': 3}), equals(true)); // (3 + 5) % 3 = 8 % 3 = 2
    });

    test('comparison with regular literals should still work', () {
      final env = Environment.standard();
      final ast = env.compile('this % 2 == 0');
      final program = env.makeProgram(ast);
      
      // Test with even number
      final result1 = program.evaluate({'this': 2});
      expect(result1, equals(true));
      
      // Test with odd number
      final result2 = program.evaluate({'this': 3});
      expect(result2, equals(false));
    });
  });
}