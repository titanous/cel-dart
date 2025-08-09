import 'package:test/test.dart';
import 'package:cel/cel.dart';
import 'package:cel/src/common/types/pb/registry.dart';
import 'package:cel/src/common/types/pb/message.dart';
import 'package:cel/src/common/types/string.dart';
import 'package:cel/src/common/types/int.dart';
import 'package:cel/src/common/types/bool.dart';
import 'package:cel/src/common/types/list.dart';
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
      
      // Test field access
      final intField = msgValue.get(StringValue('singleInt32'));
      expect(intField, isA<IntValue>());
      expect((intField as IntValue).value, equals(42));
      
      final stringField = msgValue.get(StringValue('singleString'));
      expect(stringField, isA<StringValue>());
      expect((stringField as StringValue).value, equals('hello'));
    });
    
    test('can test field presence', () {
      final msg = TestAllTypes()
        ..singleInt32 = 42;
      
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
      
      // Test field access in CEL
      final ast = env.compile('msg.singleInt32 == 42');
      final program = env.makeProgram(ast);
      final result = program.evaluate({'msg': MessageValue(msg)});
      
      expect(result, isA<BooleanValue>());
      expect((result as BooleanValue).value, isTrue);
    });
    
    test('can handle repeated fields', () {
      final msg = TestAllTypes()
        ..repeatedInt32.addAll([1, 2, 3]);
      
      final msgValue = MessageValue(msg);
      final repeatedField = msgValue.get(StringValue('repeatedInt32'));
      
      expect(repeatedField, isA<ListValue>());
      final list = repeatedField as ListValue;
      expect(list.value.length, equals(3));
      expect((list.value[0] as IntValue).value, equals(1));
    });
    
    test('can handle map fields', () {
      final msg = TestAllTypes();
      msg.mapStringString['key1'] = 'value1';
      msg.mapStringString['key2'] = 'value2';
      
      final msgValue = MessageValue(msg);
      final mapField = msgValue.get(StringValue('mapStringString'));
      
      // TODO: Verify map field handling once adapter is updated
    });
  });
}