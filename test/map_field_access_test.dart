import 'package:test/test.dart';
import 'package:cel/cel.dart';

/// This test file validates that dot notation (e.g., `e.a`) works correctly
/// in comprehension macros.
///
/// Ensures that expressions like `variable.field` are treated as field
/// access rather than qualified identifiers when the base is a simple identifier.
void main() {
  group('Map Field Access Tests', () {
    late Environment env;

    setUp(() {
      env = Environment.standard();
    });

    group('Core functionality', () {
      test('all() macro with dot notation', () {
        // Test basic dot notation functionality
        final testList = [
          {'a': 1},
          {'a': 1}
        ];
        final ast = env.compile('this.all(e, e.a == 1)');
        final program = env.makeProgram(ast);
        final result = program.evaluate({'this': testList});

        expect(result, true,
            reason: 'all() macro with dot notation should work');
      });

      test('all() macro with bracket notation - should still work', () {
        // Test bracket notation for comparison
        final testList = [
          {'a': 1},
          {'a': 1}
        ];
        final ast = env.compile('this.all(e, e["a"] == 1)');
        final program = env.makeProgram(ast);
        final result = program.evaluate({'this': testList});

        expect(result, true,
            reason: 'all() macro with bracket notation should work');
      });

      test('exists() macro with dot notation', () {
        final testList = [
          {'a': 0},
          {'a': 1}
        ];
        final ast = env.compile('this.exists(e, e.a == 1)');
        final program = env.makeProgram(ast);
        final result = program.evaluate({'this': testList});

        expect(result, true);
      });

      test('filter() macro with dot notation', () {
        final testList = [
          {'a': 1},
          {'a': 2},
          {'a': 3}
        ];
        final ast = env.compile('this.filter(e, e.a > 1)');
        final program = env.makeProgram(ast);
        final result = program.evaluate({'this': testList});

        expect(result, hasLength(2),
            reason: 'Should filter elements where a > 1');
      });

      test('map() macro with dot notation', () {
        final testList = [
          {'a': 1},
          {'a': 2},
          {'a': 3}
        ];
        final ast = env.compile('this.map(e, e.a)');
        final program = env.makeProgram(ast);
        final result = program.evaluate({'this': testList});

        expect(result, equals([1, 2, 3]),
            reason: 'Should extract field values');
      });

      test('exists_one() macro with dot notation', () {
        final testList = [
          {'a': 1},
          {'a': 2},
          {'a': 3}
        ];
        final ast = env.compile('this.exists_one(e, e.a == 2)');
        final program = env.makeProgram(ast);
        final result = program.evaluate({'this': testList});

        expect(result, true);
      });
    });

    group('Variable naming edge cases', () {
      test('single letter variable names', () {
        final testList = [
          {'x': 1},
          {'x': 2}
        ];
        final ast = env.compile('this.all(e, e.x > 0)');
        final program = env.makeProgram(ast);
        final result = program.evaluate({'this': testList});

        expect(result, true);
      });

      test('underscore variable names', () {
        final testList = [
          {'prop': 'test'}
        ];
        final ast = env.compile('this.all(_item, _item.prop == "test")');
        final program = env.makeProgram(ast);
        final result = program.evaluate({'this': testList});

        expect(result, true);
      });

      test('numeric suffixed variable names', () {
        final testList = [
          {'value': 42}
        ];
        final ast = env.compile('this.all(item2, item2.value == 42)');
        final program = env.makeProgram(ast);
        final result = program.evaluate({'this': testList});

        expect(result, true);
      });
    });

    group('Equivalence tests', () {
      test('dot notation and bracket notation should be equivalent', () {
        final testList = [
          {'key': 'value1'},
          {'key': 'value2'}
        ];

        final dotAst = env.compile('this.map(e, e.key)');
        final dotProgram = env.makeProgram(dotAst);
        final dotResult = dotProgram.evaluate({'this': testList});

        final bracketAst = env.compile('this.map(e, e["key"])');
        final bracketProgram = env.makeProgram(bracketAst);
        final bracketResult = bracketProgram.evaluate({'this': testList});

        expect(dotResult, equals(bracketResult),
            reason:
                'Dot and bracket notation should produce identical results');
      });

      test('different field names should work consistently', () {
        final testCases = [
          {'name': 'test'},
          {'id': 123},
          {'active': true},
          {'count': 0}
        ];

        for (final testData in testCases) {
          final fieldName = testData.keys.first;
          final testList = [testData];

          final ast = env.compile('this.map(e, e.$fieldName)');
          final program = env.makeProgram(ast);
          final result = program.evaluate({'this': testList});

          expect(result, equals([testData[fieldName]]),
              reason: 'Field $fieldName should be accessible via dot notation');
        }
      });
    });

    group('Complex expressions', () {
      test('multiple field access in same expression', () {
        final testList = [
          {'x': 1, 'y': 2},
          {'x': 3, 'y': 4}
        ];
        final ast = env.compile('this.all(e, e.x + e.y > 0)');
        final program = env.makeProgram(ast);
        final result = program.evaluate({'this': testList});

        expect(result, true);
      });

      test('boolean expressions with field access', () {
        final testList = [
          {'active': true},
          {'active': false}
        ];
        final ast = env.compile('this.exists(e, e.active)');
        final program = env.makeProgram(ast);
        final result = program.evaluate({'this': testList});

        expect(result, true);
      });
    });
  });
}
