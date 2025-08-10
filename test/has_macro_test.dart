import 'package:test/test.dart';
import 'package:cel/cel.dart';
import 'package:cel/src/gen/google/api/expr/v1alpha1/checked.pb.dart' as checked_pb;
import 'package:cel/src/gen/cel/expr/conformance/proto3/test_all_types.pb.dart';
import 'package:cel/src/common/types/pb/registry.dart';

void main() {
  group('has() macro tests', () {
    late ProtoTypeRegistry registry;
    late Environment env;

    setUp(() {
      registry = ProtoTypeRegistry();
      registry.registerMessageType(
        'cel.expr.conformance.proto3.TestAllTypes',
        TestAllTypes().info_,
        () => TestAllTypes()
      );
      env = Environment.withProtos(registry: registry);
    });

    test('has() on message field - field present', () {
      final ast = env.compile('has(msg.single_int32)');
      final program = env.makeProgram(ast);
      
      final msg = TestAllTypes()..singleInt32 = 42;
      final result = program.evaluate({'msg': msg});
      
      expect(result, true);
    });

    test('has() on message field - field not present', () {
      final ast = env.compile('has(msg.single_int32)');
      final program = env.makeProgram(ast);
      
      final msg = TestAllTypes(); // field not set
      final result = program.evaluate({'msg': msg});
      
      expect(result, false);
    });

    test('has() on map key - key exists', () {
      final ast = env.compile('has(m.key1)');
      final program = env.makeProgram(ast);
      
      final result = program.evaluate({
        'm': {'key1': 'value1', 'key2': 'value2'}
      });
      
      expect(result, true);
    });

    test('has() on map key - key does not exist', () {
      final ast = env.compile('has(m.key3)');
      final program = env.makeProgram(ast);
      
      final result = program.evaluate({
        'm': {'key1': 'value1', 'key2': 'value2'}
      });
      
      expect(result, false);
    });

    test('has() on nested message field', () {
      final ast = env.compile('has(msg.single_nested_message.bb)');
      final program = env.makeProgram(ast);
      
      final nested = TestAllTypes_NestedMessage()..bb = 10;
      final msg = TestAllTypes()..singleNestedMessage = nested;
      final result = program.evaluate({'msg': msg});
      
      expect(result, true);
    });

    test('has() with && operator', () {
      final ast = env.compile('has(msg.single_int32) && msg.single_int32 > 10');
      final program = env.makeProgram(ast);
      
      final msg = TestAllTypes()..singleInt32 = 42;
      final result = program.evaluate({'msg': msg});
      
      expect(result, true);
    });

    test('has() with || operator', () {
      final ast = env.compile('has(msg.single_int32) || has(msg.single_string)');
      final program = env.makeProgram(ast);
      
      final msg = TestAllTypes()..singleString = 'hello';
      final result = program.evaluate({'msg': msg});
      
      expect(result, true);
    });
  });
}