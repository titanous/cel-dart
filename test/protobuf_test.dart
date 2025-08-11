import 'package:test/test.dart';
import 'package:cel/cel.dart';
import 'package:cel/src/common/types/pb/registry.dart';
import 'package:cel/src/common/types/pb/message.dart';
import 'package:cel/src/common/types/string.dart';
import 'package:cel/src/common/types/int.dart';
import 'package:cel/src/common/types/bool.dart';
import 'package:cel/src/common/types/list.dart';
import 'package:cel/src/common/types/map.dart';
import 'package:cel/src/common/types/provider.dart' as cel_provider;
import 'package:protobuf/protobuf.dart';
import 'package:cel/src/gen/cel/expr/conformance/proto3/test_all_types.pb.dart';

void main() {
  group('Protobuf Integration', () {
    late ProtoTypeRegistry registry;
    late Environment env;

    setUp(() {
      registry = ProtoTypeRegistry();
      // Register the TestAllTypes type
      registry.registerMessageType(
        'cel.expr.conformance.proto3.TestAllTypes',
        TestAllTypes().info_,
        () => TestAllTypes(),
      );

      env = Environment.withProtos(registry: registry);
    });

    test('can access message fields', () {
      final msg = TestAllTypes()
        ..singleInt32 = 42
        ..singleString = 'hello';

      final msgValue = MessageValue(msg);

      // Test field access with Dart property name (camelCase)
      final intField = msgValue.get(StringValue('singleInt32'));
      expect(intField, isA<IntValue>());
      expect((intField as IntValue).value, equals(42));

      final stringField = msgValue.get(StringValue('singleString'));
      expect(stringField, isA<StringValue>());
      expect((stringField as StringValue).value, equals('hello'));
    });

    test('can access message fields with proto names', () {
      final msg = TestAllTypes()
        ..singleInt32 = 42
        ..singleString = 'hello';

      final msgValue = MessageValue(msg);

      // Test field access with proto field name (snake_case)
      final intField = msgValue.get(StringValue('single_int32'));
      expect(intField, isA<IntValue>());
      expect((intField as IntValue).value, equals(42));

      final stringField = msgValue.get(StringValue('single_string'));
      expect(stringField, isA<StringValue>());
      expect((stringField as StringValue).value, equals('hello'));
    });

    test('can test field presence', () {
      final msg = TestAllTypes()..singleInt32 = 42;

      final msgValue = MessageValue(msg);

      // Test has() for set field
      expect(msgValue.has('singleInt32'), isTrue);

      // Test has() for unset field
      expect(msgValue.has('singleString'), isFalse);
    });

    test('can evaluate CEL expressions with messages', () {
      final msg = TestAllTypes()
        ..singleInt32 = 42
        ..singleString = 'hello';

      // Test field access in CEL with proto field names
      final ast =
          env.compile('msg.single_int32 == 42 && msg.single_string == "hello"');
      final program = env.makeProgram(ast);
      final result = program.evaluate({'msg': MessageValue(msg)});

      expect(result, isA<bool>());
      expect(result, isTrue);
    });

    test('can handle repeated fields', () {
      final msg = TestAllTypes()..repeatedInt32.addAll([1, 2, 3]);

      final msgValue = MessageValue(msg);

      // Test with both proto name and Dart name
      final repeatedField = msgValue.get(StringValue('repeated_int32'));
      expect(repeatedField, isA<ListValue>());
      final list = repeatedField as ListValue;
      expect(list.value.length, equals(3));
      expect((list.value[0] as IntValue).value, equals(1));
      expect((list.value[1] as IntValue).value, equals(2));
      expect((list.value[2] as IntValue).value, equals(3));
    });

    test('can evaluate CEL expressions with repeated fields', () {
      final msg = TestAllTypes()..repeatedInt32.addAll([1, 2, 3]);

      // Test repeated field access in CEL
      final ast1 = env.compile('msg.repeated_int32[0] == 1');
      final program1 = env.makeProgram(ast1);
      final result1 = program1.evaluate({'msg': MessageValue(msg)});
      expect(result1, isTrue);

      // Test size operation on repeated field
      final ast2 = env.compile('size(msg.repeated_int32) == 3');
      final program2 = env.makeProgram(ast2);
      final result2 = program2.evaluate({'msg': MessageValue(msg)});
      expect(result2, isTrue);
    });

    test('can handle map fields', () {
      final msg = TestAllTypes();
      msg.mapStringString['key1'] = 'value1';
      msg.mapStringString['key2'] = 'value2';

      final msgValue = MessageValue(msg);

      // Test with proto field name
      final mapField = msgValue.get(StringValue('map_string_string'));
      expect(mapField, isA<MapValue>());

      final map = mapField as MapValue;
      expect(map.value.length, equals(2));
      expect((map.value[StringValue('key1')] as StringValue).value,
          equals('value1'));
      expect((map.value[StringValue('key2')] as StringValue).value,
          equals('value2'));
    });

    test('can evaluate CEL expressions with map fields', () {
      final msg = TestAllTypes();
      msg.mapStringString['key1'] = 'value1';
      msg.mapStringString['key2'] = 'value2';

      // Test map field access in CEL
      final ast1 = env.compile('msg.map_string_string["key1"] == "value1"');
      final program1 = env.makeProgram(ast1);
      final result1 = program1.evaluate({'msg': MessageValue(msg)});
      expect(result1, isTrue);

      // Test size operation on map field
      final ast2 = env.compile('size(msg.map_string_string) == 2');
      final program2 = env.makeProgram(ast2);
      final result2 = program2.evaluate({'msg': MessageValue(msg)});
      expect(result2, isTrue);
    });

    test('can access nested message fields', () {
      final msg = TestAllTypes()
        ..singleNestedMessage = (TestAllTypes_NestedMessage()..bb = 99);

      final msgValue = MessageValue(msg);

      // Test accessing nested message with proto field names
      final nestedField = msgValue.get(StringValue('single_nested_message'));
      expect(nestedField, isA<MessageValue>());

      // Test accessing field within nested message
      final nestedMsg = nestedField as MessageValue;
      final bbField = nestedMsg.get(StringValue('bb'));
      expect(bbField, isA<IntValue>());
      expect((bbField as IntValue).value, equals(99));
    });

    test('can evaluate CEL expressions with nested messages', () {
      final msg = TestAllTypes()
        ..singleNestedMessage = (TestAllTypes_NestedMessage()..bb = 99);

      // Test nested field access in CEL
      final ast = env.compile('msg.single_nested_message.bb == 99');
      final program = env.makeProgram(ast);
      final result = program.evaluate({'msg': MessageValue(msg)});

      expect(result, isA<bool>());
      expect(result, isTrue);
    });

    test('can use "this" variable binding', () {
      final msg = TestAllTypes()
        ..singleInt32 = 42
        ..singleString = 'hello';

      // Test using "this" as the current value being validated
      final ast = env
          .compile('this.single_int32 == 42 && this.single_string == "hello"');
      final program = env.makeProgram(ast);
      final result = program.evaluate({'this': MessageValue(msg)});

      expect(result, isA<bool>());
      expect(result, isTrue);
    });

    test('can use custom variable bindings', () {
      final msg = TestAllTypes()..singleInt32 = 42;

      // Test custom variables like "rules" and "rule"
      final ast = env.compile(
          'this.single_int32 > rules.min && this.single_int32 < rules.max');
      final program = env.makeProgram(ast);

      final rulesMap = MapValue({
        StringValue('min'): IntValue(10),
        StringValue('max'): IntValue(100),
      }, cel_provider.TypeRegistry());

      final result = program.evaluate({
        'this': MessageValue(msg),
        'rules': rulesMap,
      });

      expect(result, isA<bool>());
      expect(result, isTrue);
    });

    test('handles undefined variables properly', () {
      final msg = TestAllTypes()..singleInt32 = 42;

      // Test accessing undefined variable
      final ast = env.compile('undefined_var == 42');
      final program = env.makeProgram(ast);

      final result = program.evaluate({'this': MessageValue(msg)});
      expect(result, isA<ErrorValue>());
      expect(result.toString(), contains('no such attribute'));
    });

    test('can handle enum fields', () {
      final msg = TestAllTypes()..standaloneEnum = TestAllTypes_NestedEnum.BAR;

      final msgValue = MessageValue(msg);

      // Test accessing enum field with proto name
      final enumField = msgValue.get(StringValue('standalone_enum'));
      expect(enumField, isA<IntValue>());
      expect((enumField as IntValue).value,
          equals(TestAllTypes_NestedEnum.BAR.value));
    });

    test('can evaluate CEL expressions with enum fields', () {
      final msg = TestAllTypes()..standaloneEnum = TestAllTypes_NestedEnum.BAR;

      // Test enum comparison in CEL
      final ast1 = env.compile('this.standalone_enum == 1'); // BAR has value 1
      final program1 = env.makeProgram(ast1);
      final result1 = program1.evaluate({'this': MessageValue(msg)});
      expect(result1, isTrue);

      // Test enum comparison with another enum value
      final ast2 = env.compile('this.standalone_enum != 0'); // FOO has value 0
      final program2 = env.makeProgram(ast2);
      final result2 = program2.evaluate({'this': MessageValue(msg)});
      expect(result2, isTrue);
    });
  });
}
