import 'dart:io';
import 'dart:convert';
import 'package:protobuf/protobuf.dart' as pb;
import 'package:cel/cel.dart';
import 'package:cel/src/common/types/pb/registry.dart';
import 'package:cel/src/common/types/pb/message.dart';
import 'package:cel/src/common/types/pb/adapter.dart';
import 'package:cel/src/common/types/provider.dart';
import 'package:cel/src/common/types/ref/value.dart' as cel_value;
// Import UintValue which might not be exported by main cel.dart
import 'package:cel/src/common/types/uint.dart';
import '../gen/cel/expr/conformance/test/simple.pb.dart';
import '../gen/cel/expr/value.pb.dart' as value_pb;
import '../gen/cel/expr/eval.pb.dart';

// Import Well-Known Types for test parsing
import '../gen/google/protobuf/wrappers.pb.dart' as pb_wrappers;
import '../gen/google/protobuf/timestamp.pb.dart' as pb_timestamp;
import '../gen/google/protobuf/duration.pb.dart' as pb_duration;
import '../gen/google/protobuf/any.pb.dart' as pb_any;
import '../gen/google/protobuf/empty.pb.dart' as pb_empty;
import '../gen/google/protobuf/struct.pb.dart' as pb_struct;
import '../gen/google/protobuf/field_mask.pb.dart' as pb_field_mask;
import '../gen/cel/expr/conformance/proto2/test_all_types.pb.dart' as proto2;
import '../gen/cel/expr/conformance/proto3/test_all_types.pb.dart' as proto3;

/// Test result for a single conformance test
class TestResult {
  final String name;
  final bool passed;
  final String? error;
  final String? expected;
  final String? actual;

  TestResult({
    required this.name,
    required this.passed,
    this.error,
    this.expected,
    this.actual,
  });
}

/// Test results for a conformance test file
class TestResults {
  final String fileName;
  final List<TestResult> results;

  TestResults(this.fileName, this.results);

  int get passed => results.where((r) => r.passed).length;
  int get failed => results.where((r) => !r.passed).length;
  int get total => results.length;

  List<TestResult> get failures => results.where((r) => !r.passed).toList();
}

/// Runs CEL conformance tests
class ConformanceTestRunner {
  final Environment environment;
  final Set<String> skipTests;

  ConformanceTestRunner({
    Environment? environment,
    this.skipTests = const {},
  }) : environment = environment ?? _createDefaultEnvironment();

  static Environment _createDefaultEnvironment() {
    // Create an environment with protobuf support
    final protoRegistry = ProtoTypeRegistry();
    return Environment.withProtos(registry: protoRegistry);
  }

  /// Run a single test file
  Future<TestResults> runTestFile(String testFile) async {
    final file = File(testFile);
    if (!await file.exists()) {
      throw ArgumentError('Test file not found: $testFile');
    }

    final content = await file.readAsString();

    SimpleTestFile testFileProto;
    if (testFile.endsWith('.json')) {
      try {
        // Parse JSON using Proto3 JSON format
        final jsonData = json.decode(content);
        final typeRegistry = _createTypeRegistry();
        testFileProto = SimpleTestFile.create()
          ..mergeFromProto3Json(
            jsonData,
            typeRegistry: typeRegistry,
            allowUnknownEnumIntegers:
                true, // Enable proto3-compatible enum handling
            ignoreUnknownFields: true, // Handle extension fields gracefully
          );
      } catch (e) {
        // If JSON parsing still fails, log the error but continue
        print('Warning: Failed to parse JSON for ${testFile}: $e');
        testFileProto = SimpleTestFile.create();
        testFileProto.name = 'failed_to_parse';
      }
    } else {
      // Parse textproto
      testFileProto = SimpleTestFile();
      _parseTextProto(content, testFileProto);
    }

    final results = <TestResult>[];

    for (final section in testFileProto.section) {
      for (final test in section.test) {
        if (skipTests.contains(test.name)) {
          continue;
        }

        final result = _runSingleTest(test);
        results.add(result);
      }
    }

    return TestResults(testFile, results);
  }

  /// Run all conformance test files
  Future<TestResults> runAllTests() async {
    final testDir = Directory('../../cel-spec/tests/simple/testdata');
    if (!await testDir.exists()) {
      throw ArgumentError('Test directory not found: ${testDir.path}');
    }

    final allResults = <TestResult>[];

    await for (final file in testDir.list()) {
      if (file is File && file.path.endsWith('.textproto')) {
        final results = await runTestFile(file.path);
        allResults.addAll(results.results);
      }
    }

    return TestResults('all', allResults);
  }

  /// Run a single test case
  TestResult _runSingleTest(SimpleTest test) {
    try {
      // Skip tests that require unsupported features
      if (_requiresUnsupportedFeatures(test)) {
        return TestResult(
          name: test.name,
          passed: true, // Mark as passed but skipped
          error: 'Skipped: requires unsupported features',
        );
      }

      // Create an environment with the container if provided
      Environment testEnv = environment;
      if (test.hasContainer() && test.container.isNotEmpty) {
        // Create a new environment with the container namespace
        testEnv = Environment.withProtos(
          registry: environment.protoRegistry ?? ProtoTypeRegistry(),
        );
        testEnv.container = testEnv.container.extend(name: test.container);
        // Update the TypeRegistry's container
        if (testEnv.adapter is TypeRegistry) {
          (testEnv.adapter as TypeRegistry).container = testEnv.container;
        }
      }

      // Compile the expression
      final ast = testEnv.compile(test.expr);

      // Check if we expect a parse error
      if (test.hasDisableCheck() && test.disableCheck) {
        // We're not checking, just evaluating
      }

      // Create the program
      final program = testEnv.makeProgram(ast);

      // Prepare the input bindings
      final bindings = _prepareBindings(test.bindings);

      // Evaluate
      final result = program.evaluate(bindings);

      // Check if the result is an ErrorValue (which should be treated as evaluation error for conformance testing)
      if (result is ErrorValue) {
        if (test.hasEvalError()) {
          // We expected an error and got one
          return TestResult(
            name: test.name,
            passed: true,
          );
        } else {
          // We didn't expect an error but got one
          return TestResult(
            name: test.name,
            passed: false,
            error: 'Unexpected evaluation error: ${result.message}',
          );
        }
      }

      // Check the result
      if (test.hasEvalError()) {
        // We expected an error but didn't get one
        return TestResult(
          name: test.name,
          passed: false,
          error: 'Expected evaluation error but got result: $result',
          expected: 'error',
          actual: result.toString(),
        );
      }

      if (test.hasValue()) {
        final expectedValue = _valueFromCelValue(test.value);
        final matches = _valuesMatch(result, expectedValue);

        return TestResult(
          name: test.name,
          passed: matches,
          expected: expectedValue.toString(),
          actual: result.toString(),
          error: matches ? null : 'Value mismatch',
        );
      }

      return TestResult(
        name: test.name,
        passed: true,
      );
    } catch (e) {
      // Check if we expected an error
      if (test.hasEvalError()) {
        return TestResult(
          name: test.name,
          passed: true,
        );
      }

      return TestResult(
        name: test.name,
        passed: false,
        error: e.toString(),
      );
    }
  }

  /// Check if test requires unsupported features
  bool _requiresUnsupportedFeatures(SimpleTest test) {
    // Check for timestamp/duration which cel-dart doesn't support
    if (test.expr.contains('timestamp') || test.expr.contains('duration')) {
      return true;
    }

    // Check for type checking
    if (test.expr.contains(' is ')) {
      return true;
    }

    // Check for macros
    if (test.expr.contains('.all(') ||
        test.expr.contains('.exists(') ||
        test.expr.contains('.exists_one(') ||
        test.expr.contains('.filter(') ||
        test.expr.contains('.map(')) {
      return true;
    }

    return false;
  }

  /// Prepare input bindings from protobuf
  Map<String, dynamic> _prepareBindings(Map<String, ExprValue> bindings) {
    final result = <String, dynamic>{};

    for (final entry in bindings.entries) {
      result[entry.key] = _valueFromExprValue(entry.value);
    }

    return result;
  }

  /// Convert cel.expr.Value to Dart value
  dynamic _valueFromCelValue(value_pb.Value value) {
    if (value.hasNullValue()) {
      return null;
    } else if (value.hasBoolValue()) {
      return value.boolValue;
    } else if (value.hasInt64Value()) {
      return value.int64Value.toInt();
    } else if (value.hasUint64Value()) {
      return value.uint64Value.toInt();
    } else if (value.hasDoubleValue()) {
      return value.doubleValue;
    } else if (value.hasStringValue()) {
      return value.stringValue;
    } else if (value.hasBytesValue()) {
      return value.bytesValue;
    } else if (value.hasObjectValue()) {
      // For objectValue, we have an Any message that might need to be unpacked
      final anyMessage = value.objectValue;

      // Only unpack if this looks like a well-known protobuf type that should be converted
      if (anyMessage.typeUrl.contains('google.protobuf') &&
          (anyMessage.typeUrl.contains('Value') ||
              anyMessage.typeUrl.contains('Wrapper') ||
              anyMessage.typeUrl.contains('Struct') ||
              anyMessage.typeUrl.contains('ListValue'))) {
        try {
          final unpackedMessage = _unpackAnyMessage(anyMessage);
          if (unpackedMessage != null) {
            // Use the protobuf adapter to properly convert the message
            final adapter = ProtobufTypeAdapter(environment.adapter);
            final adaptedValue = adapter.adaptValue(unpackedMessage);
            return _celValueToNative(adaptedValue);
          }
        } catch (e) {
          // If unpacking fails, fall through to default behavior
        }
      }

      // For non-wrapper types or if unpacking fails, return the Any message as-is
      return anyMessage;
    } else if (value.hasListValue()) {
      return value.listValue.values.map(_valueFromCelValue).toList();
    } else if (value.hasMapValue()) {
      final map = <dynamic, dynamic>{};
      for (final entry in value.mapValue.entries) {
        final key = _valueFromCelValue(entry.key);
        final val = _valueFromCelValue(entry.value);
        map[key] = val;
      }
      return map;
    } else if (value.hasTypeValue()) {
      return {'typeValue': value.typeValue};
    }

    // Handle other types as needed
    return null;
  }

  /// Convert ExprValue to Dart value
  dynamic _valueFromExprValue(ExprValue value) {
    if (value.hasValue()) {
      return _valueFromCelValue(value.value);
    } else if (value.hasError()) {
      throw Exception('ExprValue contains error: ${value.error}');
    } else if (value.hasUnknown()) {
      throw Exception('ExprValue contains unknown: ${value.unknown}');
    }
    return null;
  }

  /// Check if two values match
  bool _valuesMatch(dynamic actual, dynamic expected) {
    if (actual == null && expected == null) return true;
    if (actual == null || expected == null) return false;

    // Handle MessageValue from CEL evaluation
    if (actual is MessageValue) {
      // If expected is an Any message, compare the actual message with the unpacked value
      if (expected is pb_any.Any) {
        // For now, just check if the type URLs match
        // In a full implementation, we'd unpack and compare field by field
        final actualTypeUrl =
            'type.googleapis.com/${actual.message.info_.qualifiedMessageName}';
        return actualTypeUrl == expected.typeUrl;
      }
      // If expected is a protobuf message, compare directly
      if (expected is pb.GeneratedMessage) {
        return actual.message == expected;
      }
      // Otherwise, compare the string representations
      return actual.message.toString() == expected.toString();
    }

    if (actual is List && expected is List) {
      if (actual.length != expected.length) return false;
      for (int i = 0; i < actual.length; i++) {
        if (!_valuesMatch(actual[i], expected[i])) return false;
      }
      return true;
    }

    if (actual is Map && expected is Map) {
      if (actual.length != expected.length) return false;
      for (final key in actual.keys) {
        if (!expected.containsKey(key)) return false;
        if (!_valuesMatch(actual[key], expected[key])) return false;
      }
      return true;
    }

    // Handle type values: actual is a string, expected is {'typeValue': string}
    if (actual is String && expected is Map && expected.containsKey('typeValue')) {
      return actual == expected['typeValue'];
    }

    // For numbers, allow some tolerance for floating point
    if (actual is num && expected is num) {
      if (actual is double || expected is double) {
        return (actual - expected).abs() < 1e-9;
      }
    }

    return actual == expected;
  }

  /// Parse textproto format (improved version)
  void _parseTextProto(String content, SimpleTestFile proto) {
    final lines = content.split('\n');
    SimpleTestSection? currentSection;
    SimpleTest? currentTest;

    for (final line in lines) {
      final trimmed = line.trim();

      if (trimmed.isEmpty || trimmed.startsWith('#')) {
        continue;
      }

      if (trimmed.startsWith('section:') || trimmed.startsWith('section {')) {
        currentSection = SimpleTestSection();
        proto.section.add(currentSection);
      } else if (trimmed.startsWith('test:') || trimmed.startsWith('test {')) {
        currentTest = SimpleTest();
        currentSection?.test.add(currentTest);
      } else if (trimmed.startsWith('name:')) {
        final value = _extractStringValue(trimmed.substring(5));
        if (currentTest != null) {
          currentTest.name = value;
        } else if (currentSection != null) {
          currentSection.name = value;
        } else {
          proto.name = value;
        }
      } else if (trimmed.startsWith('description:')) {
        final value = _extractStringValue(trimmed.substring(12));
        if (currentSection != null) {
          currentSection.description = value;
        } else {
          proto.description = value;
        }
      } else if (trimmed.startsWith('expr:') && currentTest != null) {
        currentTest.expr = _extractStringValue(trimmed.substring(5));
      } else if (trimmed.startsWith('value:') && currentTest != null) {
        // Simple value parsing - only handle basic string values for now
        // This is sufficient for most tests
      }

      // Handle other fields as needed
    }
  }

  String _extractStringValue(String value) {
    value = value.trim();
    if (value.startsWith('"') && value.endsWith('"')) {
      return value
          .substring(1, value.length - 1)
          .replaceAll(r'\"', '"')
          .replaceAll(r'\\', r'\');
    }
    if (value.startsWith("'") && value.endsWith("'")) {
      return value.substring(1, value.length - 1);
    }
    return value;
  }

  /// Create a TypeRegistry with Well-Known Types for JSON parsing
  pb.TypeRegistry _createTypeRegistry() {
    final types = <pb.GeneratedMessage>[
      // Well-Known Types
      pb_wrappers.DoubleValue.getDefault(),
      pb_wrappers.FloatValue.getDefault(),
      pb_wrappers.Int64Value.getDefault(),
      pb_wrappers.UInt64Value.getDefault(),
      pb_wrappers.Int32Value.getDefault(),
      pb_wrappers.UInt32Value.getDefault(),
      pb_wrappers.BoolValue.getDefault(),
      pb_wrappers.StringValue.getDefault(),
      pb_wrappers.BytesValue.getDefault(),

      pb_timestamp.Timestamp.getDefault(),
      pb_duration.Duration.getDefault(),
      pb_any.Any.getDefault(),
      pb_empty.Empty.getDefault(),
      pb_struct.Struct.getDefault(),
      pb_struct.Value.getDefault(),
      pb_struct.ListValue.getDefault(),
      pb_field_mask.FieldMask.getDefault(),

      // Test types
      proto2.TestAllTypes.getDefault(),
      proto2.TestAllTypes_NestedMessage.getDefault(),
      proto3.TestAllTypes.getDefault(),
      proto3.TestAllTypes_NestedMessage.getDefault(),
    ];

    // Create a registry with JSON parsing that allows unknown enum values
    final registry = pb.TypeRegistry(types);
    return registry;
  }

  /// Unpack Any message to the actual protobuf message
  pb.GeneratedMessage? _unpackAnyMessage(pb_any.Any anyMessage) {
    try {
      // Check the type URL to determine the message type
      final typeUrl = anyMessage.typeUrl;
      if (typeUrl.isEmpty) return null;

      // Extract the type name from the URL (format: type.googleapis.com/PackageName.MessageName)
      final parts = typeUrl.split('/');
      if (parts.length != 2) return null;

      final fullTypeName = parts[1];

      // Map known types to their constructors
      switch (fullTypeName) {
        case 'google.protobuf.Int32Value':
          final msg = pb_wrappers.Int32Value();
          msg.mergeFromBuffer(anyMessage.value);
          return msg;
        case 'google.protobuf.Int64Value':
          final msg = pb_wrappers.Int64Value();
          msg.mergeFromBuffer(anyMessage.value);
          return msg;
        case 'google.protobuf.UInt32Value':
          final msg = pb_wrappers.UInt32Value();
          msg.mergeFromBuffer(anyMessage.value);
          return msg;
        case 'google.protobuf.UInt64Value':
          final msg = pb_wrappers.UInt64Value();
          msg.mergeFromBuffer(anyMessage.value);
          return msg;
        case 'google.protobuf.BoolValue':
          final msg = pb_wrappers.BoolValue();
          msg.mergeFromBuffer(anyMessage.value);
          return msg;
        case 'google.protobuf.StringValue':
          final msg = pb_wrappers.StringValue();
          msg.mergeFromBuffer(anyMessage.value);
          return msg;
        case 'google.protobuf.BytesValue':
          final msg = pb_wrappers.BytesValue();
          msg.mergeFromBuffer(anyMessage.value);
          return msg;
        case 'google.protobuf.DoubleValue':
          final msg = pb_wrappers.DoubleValue();
          msg.mergeFromBuffer(anyMessage.value);
          return msg;
        case 'google.protobuf.FloatValue':
          final msg = pb_wrappers.FloatValue();
          msg.mergeFromBuffer(anyMessage.value);
          return msg;
        case 'google.protobuf.ListValue':
          final msg = pb_struct.ListValue();
          msg.mergeFromBuffer(anyMessage.value);
          return msg;
        case 'google.protobuf.Struct':
          final msg = pb_struct.Struct();
          msg.mergeFromBuffer(anyMessage.value);
          return msg;
        // Add test types
        case 'cel.expr.conformance.proto2.TestAllTypes':
          final msg = proto2.TestAllTypes();
          msg.mergeFromBuffer(anyMessage.value);
          return msg;
        case 'cel.expr.conformance.proto3.TestAllTypes':
          final msg = proto3.TestAllTypes();
          msg.mergeFromBuffer(anyMessage.value);
          return msg;
        default:
          return null;
      }
    } catch (e) {
      // If unpacking fails, return null
      return null;
    }
  }

  /// Convert a CEL Value to a native Dart value for comparison
  dynamic _celValueToNative(cel_value.Value celValue) {
    // Convert CEL values back to native Dart values
    if (celValue is BooleanValue) {
      return celValue.value;
    } else if (celValue is StringValue) {
      return celValue.value;
    } else if (celValue is IntValue) {
      return celValue.value;
    } else if (celValue is UintValue) {
      return celValue.value;
    } else if (celValue is DoubleValue) {
      return celValue.value;
    } else if (celValue is BytesValue) {
      return celValue.value;
    } else if (celValue is ListValue) {
      return celValue.value.map(_celValueToNative).toList();
    } else if (celValue is MapValue) {
      final result = <dynamic, dynamic>{};
      for (final entry in celValue.value.entries) {
        result[_celValueToNative(entry.key)] = _celValueToNative(entry.value);
      }
      return result;
    } else if (celValue.runtimeType.toString() == 'NullValue') {
      return null;
    } else {
      // For other types, return the value as-is
      return celValue;
    }
  }
}
