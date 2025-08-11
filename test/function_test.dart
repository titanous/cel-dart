import 'package:cel/cel.dart';
import 'package:test/test.dart';

void main() {
  group('New Functions Tests', () {
    test('unique() function', () {
      final env = Environment.standard();

      // Test unique list
      var ast = env.compile('[1, 2, 3].unique()');
      var prog = env.makeProgram(ast);
      var result = prog.evaluate({});
      expect(result, true);

      // Test non-unique list
      ast = env.compile('[1, 2, 2, 3].unique()');
      prog = env.makeProgram(ast);
      result = prog.evaluate({});
      expect(result, false);

      // Test empty list
      ast = env.compile('[].unique()');
      prog = env.makeProgram(ast);
      result = prog.evaluate({});
      expect(result, true);
    });

    test('dyn() function', () {
      final env = Environment.standard();

      // Test dyn with int
      var ast = env.compile('dyn(5)');
      var prog = env.makeProgram(ast);
      var result = prog.evaluate({});
      expect(result, 5);

      // Test dyn with string
      ast = env.compile('dyn("hello")');
      prog = env.makeProgram(ast);
      result = prog.evaluate({});
      expect(result, "hello");
    });

    test('size() function', () {
      final env = Environment.standard();

      // Test size with list
      var ast = env.compile('[1, 2, 3].size()');
      var prog = env.makeProgram(ast);
      var result = prog.evaluate({});
      expect(result, 3);

      // Test size with string
      ast = env.compile('"hello".size()');
      prog = env.makeProgram(ast);
      result = prog.evaluate({});
      expect(result, 5);
    });
  });
}
