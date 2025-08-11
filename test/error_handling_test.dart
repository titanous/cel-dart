import 'package:test/test.dart';
import 'package:cel/cel.dart';

void main() {
  group('CEL Error Handling', () {
    late Environment env;
    
    setUp(() {
      env = Environment.standard();
    });

    group('Type Mismatch Handling', () {
      test('should handle null comparison gracefully', () {
        bool threwStateError = false;
        dynamic result;
        
        try {
          final program = env.makeProgram(env.compile('null < 5'));
          result = program.evaluate({});
        } catch (e) {
          if (e is StateError) {
            threwStateError = true;
          }
        }
        
        expect(threwStateError, isFalse, reason: 'Should not throw StateError for type mismatches');
        expect(result, isNotNull, reason: 'Should return a result instead of throwing');
      });

      test('should handle invalid method calls gracefully', () {
        bool threwStateError = false;
        dynamic result;
        
        try {
          final program = env.makeProgram(env.compile('5.startsWith("test")'));
          result = program.evaluate({});
        } catch (e) {
          if (e is StateError) {
            threwStateError = true;
          }
        }
        
        expect(threwStateError, isFalse, reason: 'Should not throw StateError for invalid methods');
        expect(result, isNotNull);
      });

      test('should handle mixed type arithmetic gracefully', () {
        bool threwStateError = false;
        dynamic result;
        
        try {
          final program = env.makeProgram(env.compile('"hello" + 5'));
          result = program.evaluate({});
        } catch (e) {
          if (e is StateError) {
            threwStateError = true;
          }
        }
        
        expect(threwStateError, isFalse, reason: 'Should not throw StateError for mixed types');
        expect(result, isNotNull);
      });

      test('should handle invalid indexing gracefully', () {
        bool threwStateError = false;
        dynamic result;
        
        try {
          final program = env.makeProgram(env.compile('5[0]'));
          result = program.evaluate({});
        } catch (e) {
          if (e is StateError) {
            threwStateError = true;
          }
        }
        
        expect(threwStateError, isFalse, reason: 'Should not throw StateError for invalid indexing');
        expect(result, isNotNull);
      });

      test('should handle invalid size operations gracefully', () {
        bool threwStateError = false;
        dynamic result;
        
        try {
          final program = env.makeProgram(env.compile('size(5)'));
          result = program.evaluate({});
        } catch (e) {
          if (e is StateError) {
            threwStateError = true;
          }
        }
        
        expect(threwStateError, isFalse, reason: 'Should not throw StateError for invalid size');
        expect(result, isNotNull);
      });

      test('should handle invalid unary operations gracefully', () {
        bool threwStateError = false;
        dynamic result;
        
        try {
          final program = env.makeProgram(env.compile('-"hello"'));
          result = program.evaluate({});
        } catch (e) {
          if (e is StateError) {
            threwStateError = true;
          }
        }
        
        expect(threwStateError, isFalse, reason: 'Should not throw StateError for invalid unary minus');
        expect(result, isNotNull);
      });

      test('should handle null equality comparisons correctly', () {
        final program = env.makeProgram(env.compile('null == null'));
        final result = program.evaluate({});
        
        expect(result, equals(true));
      });

      test('should handle division by zero gracefully', () {
        bool threwStateError = false;
        dynamic result1, result2;
        
        try {
          final program1 = env.makeProgram(env.compile('10 / 0'));
          result1 = program1.evaluate({});
        } catch (e) {
          if (e is StateError) {
            threwStateError = true;
          }
        }
        
        try {
          final program2 = env.makeProgram(env.compile('10 % 0'));
          result2 = program2.evaluate({});
        } catch (e) {
          if (e is StateError) {
            threwStateError = true;
          }
        }
        
        expect(threwStateError, isFalse, reason: 'Should not throw StateError for division/modulo operations');
        expect(result1, isNotNull);
        expect(result2, isNotNull);
      });
    });

    group('Dynamic Type Functions', () {
      test('should support dyn() function for dynamic typing', () {
        final program = env.makeProgram(env.compile('dyn(42)'));
        final result = program.evaluate({});
        
        expect(result, equals(42));
      });

      test('should handle dyn() function with complex types', () {
        final program = env.makeProgram(env.compile('dyn([1, 2, 3]).size()'));
        final result = program.evaluate({});
        
        expect(result, equals(3));
      });
    });

    group('Complex Expression Evaluation', () {
      test('should evaluate expressions with type errors gracefully', () {
        final program = env.makeProgram(env.compile('null < 5'));
        final result = program.evaluate({});
        
        // Should not crash, should return a result
        expect(result, isNotNull);
      });

      test('should handle complex expressions with multiple operations', () {
        bool threwStateError = false;
        dynamic result;
        
        try {
          final program = env.makeProgram(env.compile('(null < 5) && (5.startsWith("test")) || ("hello" + 5)'));
          result = program.evaluate({});
        } catch (e) {
          if (e is StateError) {
            threwStateError = true;
          }
        }
        
        expect(threwStateError, isFalse, reason: 'Should not throw StateError for complex expressions');
        expect(result, isNotNull);
      });
    });

    group('Valid Operations', () {
      test('should evaluate basic operations correctly', () {
        final validOperations = [
          '1 + 2',
          '"hello" + " world"', 
          '[1, 2, 3].size()',
          '{"key": "value"}["key"]',
          '5 < 10',
          'true && false',
          '-42',
          '10 / 2',
          '10 % 3'
        ];

        for (final expr in validOperations) {
          bool threwUnexpectedError = false;
          dynamic result;
          
          try {
            final program = env.makeProgram(env.compile(expr));
            result = program.evaluate({});
          } catch (e) {
            threwUnexpectedError = true;
            fail('Valid expression "$expr" threw unexpected error: $e');
          }
          
          expect(threwUnexpectedError, isFalse, reason: 'Valid expression should not throw');
          expect(result, isNotNull, reason: 'Valid expression should return result');
        }
      });

      test('should handle list operations correctly', () {
        final program = env.makeProgram(env.compile('[1, 2, 3, 4, 5].all(x, x > 0)'));
        final result = program.evaluate({});
        
        expect(result, equals(true));
      });

      test('should handle map operations correctly', () {
        final program = env.makeProgram(env.compile('{"a": 1, "b": 2}["a"] == 1'));
        final result = program.evaluate({});
        
        expect(result, equals(true));
      });

      test('should handle comprehensions correctly', () {
        final program = env.makeProgram(env.compile('[1, 2, 3].filter(x, x > 1).size() == 2'));
        final result = program.evaluate({});
        
        expect(result, equals(true));
      });
    });
  });
}