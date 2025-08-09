// This is a generated file - do not edit.
//
// Generated from cel/expr/conformance/test/suite.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../../../google/protobuf/any.pb.dart' as $2;
import '../../checked.pb.dart' as $1;
import '../../eval.pb.dart' as $4;
import '../../value.pb.dart' as $3;
import '../env_config.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// A test suite is a collection of tests designed to evaluate the correctness of
/// a CEL policy, a CEL expression or the conformance of a CEL implementation to
/// the standard specification.
class TestSuite extends $pb.GeneratedMessage {
  factory TestSuite({
    $core.String? name,
    $core.String? description,
    $core.Iterable<TestSection>? sections,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (sections != null) result.sections.addAll(sections);
    return result;
  }

  TestSuite._();

  factory TestSuite.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TestSuite.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TestSuite',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'cel.expr.conformance.test'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..pc<TestSection>(3, _omitFieldNames ? '' : 'sections', $pb.PbFieldType.PM,
        subBuilder: TestSection.create);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TestSuite clone() => TestSuite()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TestSuite copyWith(void Function(TestSuite) updates) =>
      super.copyWith((message) => updates(message as TestSuite)) as TestSuite;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestSuite create() => TestSuite._();
  @$core.override
  TestSuite createEmptyInstance() => create();
  static $pb.PbList<TestSuite> createRepeated() => $pb.PbList<TestSuite>();
  @$core.pragma('dart2js:noInline')
  static TestSuite getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TestSuite>(create);
  static TestSuite? _defaultInstance;

  /// The name of the test suite.
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  /// Description of the test suite.
  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);

  /// Test sections of the test suite.
  /// Each section represents a behavior to be tested.
  @$pb.TagNumber(3)
  $pb.PbList<TestSection> get sections => $_getList(2);
}

/// A collection of related test cases.
class TestSection extends $pb.GeneratedMessage {
  factory TestSection({
    $core.String? name,
    $core.String? description,
    $core.Iterable<TestCase>? tests,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (tests != null) result.tests.addAll(tests);
    return result;
  }

  TestSection._();

  factory TestSection.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TestSection.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TestSection',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'cel.expr.conformance.test'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..pc<TestCase>(3, _omitFieldNames ? '' : 'tests', $pb.PbFieldType.PM,
        subBuilder: TestCase.create);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TestSection clone() => TestSection()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TestSection copyWith(void Function(TestSection) updates) =>
      super.copyWith((message) => updates(message as TestSection))
          as TestSection;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestSection create() => TestSection._();
  @$core.override
  TestSection createEmptyInstance() => create();
  static $pb.PbList<TestSection> createRepeated() => $pb.PbList<TestSection>();
  @$core.pragma('dart2js:noInline')
  static TestSection getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TestSection>(create);
  static TestSection? _defaultInstance;

  /// Name of the test section.
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  /// Description of the test section.
  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);

  /// Test cases of the test section.
  /// Each test case represents a test scenario.
  @$pb.TagNumber(3)
  $pb.PbList<TestCase> get tests => $_getList(2);
}

/// A test to validate a CEL policy or expression. The test case encompasses
/// evaluation of the compiled expression using the provided input bindings and
/// asserting the result against the expected result.
/// It can also validate a raw CEL expression string through parse, check and
/// eval stages, making use of the augmenting CEL environment if provided.
class TestCase extends $pb.GeneratedMessage {
  factory TestCase({
    $core.String? name,
    $core.String? description,
    $core.String? expr,
    $0.Environment? env,
    $core.Iterable<$core.MapEntry<$core.String, InputValue>>? input,
    InputContext? inputContext,
    TestOutput? output,
    $1.Type? deducedType,
    $core.bool? disableCheck,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (expr != null) result.expr = expr;
    if (env != null) result.env = env;
    if (input != null) result.input.addEntries(input);
    if (inputContext != null) result.inputContext = inputContext;
    if (output != null) result.output = output;
    if (deducedType != null) result.deducedType = deducedType;
    if (disableCheck != null) result.disableCheck = disableCheck;
    return result;
  }

  TestCase._();

  factory TestCase.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TestCase.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TestCase',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'cel.expr.conformance.test'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..aOS(3, _omitFieldNames ? '' : 'expr')
    ..aOM<$0.Environment>(4, _omitFieldNames ? '' : 'env',
        subBuilder: $0.Environment.create)
    ..m<$core.String, InputValue>(5, _omitFieldNames ? '' : 'input',
        entryClassName: 'TestCase.InputEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: InputValue.create,
        valueDefaultOrMaker: InputValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.test'))
    ..aOM<InputContext>(6, _omitFieldNames ? '' : 'inputContext',
        subBuilder: InputContext.create)
    ..aOM<TestOutput>(7, _omitFieldNames ? '' : 'output',
        subBuilder: TestOutput.create)
    ..aOM<$1.Type>(8, _omitFieldNames ? '' : 'deducedType',
        subBuilder: $1.Type.create)
    ..aOB(9, _omitFieldNames ? '' : 'disableCheck');

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TestCase clone() => TestCase()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TestCase copyWith(void Function(TestCase) updates) =>
      super.copyWith((message) => updates(message as TestCase)) as TestCase;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestCase create() => TestCase._();
  @$core.override
  TestCase createEmptyInstance() => create();
  static $pb.PbList<TestCase> createRepeated() => $pb.PbList<TestCase>();
  @$core.pragma('dart2js:noInline')
  static TestCase getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TestCase>(create);
  static TestCase? _defaultInstance;

  /// Name of the test case.
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  /// A description of the test.
  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);

  /// The text of the CEL expression.
  @$pb.TagNumber(3)
  $core.String get expr => $_getSZ(2);
  @$pb.TagNumber(3)
  set expr($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasExpr() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpr() => $_clearField(3);

  /// Serialized environment to be used for compilation and evaluation of the
  /// CEL expression for the current test case.
  /// This option allows validating the same expression against multiple
  /// environments.
  @$pb.TagNumber(4)
  $0.Environment get env => $_getN(3);
  @$pb.TagNumber(4)
  set env($0.Environment value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasEnv() => $_has(3);
  @$pb.TagNumber(4)
  void clearEnv() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.Environment ensureEnv() => $_ensure(3);

  /// A map representing a variable binding where the key is the name of the
  /// input variable.
  @$pb.TagNumber(5)
  $pb.PbMap<$core.String, InputValue> get input => $_getMap(4);

  /// Input in the form of a context proto for the test case.
  /// Note: Only one of `input_bindings` and `input_context` can be provided. Providing
  /// both should result in an error.
  @$pb.TagNumber(6)
  InputContext get inputContext => $_getN(5);
  @$pb.TagNumber(6)
  set inputContext(InputContext value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasInputContext() => $_has(5);
  @$pb.TagNumber(6)
  void clearInputContext() => $_clearField(6);
  @$pb.TagNumber(6)
  InputContext ensureInputContext() => $_ensure(5);

  /// Expected result of the test case.
  @$pb.TagNumber(7)
  TestOutput get output => $_getN(6);
  @$pb.TagNumber(7)
  set output(TestOutput value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasOutput() => $_has(6);
  @$pb.TagNumber(7)
  void clearOutput() => $_clearField(7);
  @$pb.TagNumber(7)
  TestOutput ensureOutput() => $_ensure(6);

  /// If specified validates that the deduced type at check time matches
  /// If the result kind is not set and this field is set, the test is considered
  /// "check-only".
  @$pb.TagNumber(8)
  $1.Type get deducedType => $_getN(7);
  @$pb.TagNumber(8)
  set deducedType($1.Type value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasDeducedType() => $_has(7);
  @$pb.TagNumber(8)
  void clearDeducedType() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Type ensureDeducedType() => $_ensure(7);

  /// Bypass the type-checking and only attempt to evaluate the parsed
  /// expression.
  @$pb.TagNumber(9)
  $core.bool get disableCheck => $_getBF(8);
  @$pb.TagNumber(9)
  set disableCheck($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasDisableCheck() => $_has(8);
  @$pb.TagNumber(9)
  void clearDisableCheck() => $_clearField(9);
}

enum InputContext_InputContextKind { contextMessage, contextExpr, notSet }

/// Input context proto for the test case
class InputContext extends $pb.GeneratedMessage {
  factory InputContext({
    $2.Any? contextMessage,
    $core.String? contextExpr,
  }) {
    final result = create();
    if (contextMessage != null) result.contextMessage = contextMessage;
    if (contextExpr != null) result.contextExpr = contextExpr;
    return result;
  }

  InputContext._();

  factory InputContext.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InputContext.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, InputContext_InputContextKind>
      _InputContext_InputContextKindByTag = {
    1: InputContext_InputContextKind.contextMessage,
    2: InputContext_InputContextKind.contextExpr,
    0: InputContext_InputContextKind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InputContext',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'cel.expr.conformance.test'),
      createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<$2.Any>(1, _omitFieldNames ? '' : 'contextMessage',
        subBuilder: $2.Any.create)
    ..aOS(2, _omitFieldNames ? '' : 'contextExpr')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InputContext clone() => InputContext()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InputContext copyWith(void Function(InputContext) updates) =>
      super.copyWith((message) => updates(message as InputContext))
          as InputContext;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InputContext create() => InputContext._();
  @$core.override
  InputContext createEmptyInstance() => create();
  static $pb.PbList<InputContext> createRepeated() =>
      $pb.PbList<InputContext>();
  @$core.pragma('dart2js:noInline')
  static InputContext getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InputContext>(create);
  static InputContext? _defaultInstance;

  InputContext_InputContextKind whichInputContextKind() =>
      _InputContext_InputContextKindByTag[$_whichOneof(0)]!;
  void clearInputContextKind() => $_clearField($_whichOneof(0));

  /// A context message represents an input kind in the form of a proto
  /// message whose type is defined at runtime.
  @$pb.TagNumber(1)
  $2.Any get contextMessage => $_getN(0);
  @$pb.TagNumber(1)
  set contextMessage($2.Any value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasContextMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearContextMessage() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.Any ensureContextMessage() => $_ensure(0);

  /// A context expression representing a context proto variable. The
  /// fields of the input proto.Messages are used as top-level variables within
  /// an Activation. The expression is evaluated using the cel environment
  /// configured for the test suite.
  @$pb.TagNumber(2)
  $core.String get contextExpr => $_getSZ(1);
  @$pb.TagNumber(2)
  set contextExpr($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasContextExpr() => $_has(1);
  @$pb.TagNumber(2)
  void clearContextExpr() => $_clearField(2);
}

enum InputValue_Kind { value, expr, notSet }

/// The input value for a variable binding
class InputValue extends $pb.GeneratedMessage {
  factory InputValue({
    $3.Value? value,
    $core.String? expr,
  }) {
    final result = create();
    if (value != null) result.value = value;
    if (expr != null) result.expr = expr;
    return result;
  }

  InputValue._();

  factory InputValue.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InputValue.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, InputValue_Kind> _InputValue_KindByTag = {
    1: InputValue_Kind.value,
    2: InputValue_Kind.expr,
    0: InputValue_Kind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InputValue',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'cel.expr.conformance.test'),
      createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<$3.Value>(1, _omitFieldNames ? '' : 'value',
        subBuilder: $3.Value.create)
    ..aOS(2, _omitFieldNames ? '' : 'expr')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InputValue clone() => InputValue()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InputValue copyWith(void Function(InputValue) updates) =>
      super.copyWith((message) => updates(message as InputValue)) as InputValue;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InputValue create() => InputValue._();
  @$core.override
  InputValue createEmptyInstance() => create();
  static $pb.PbList<InputValue> createRepeated() => $pb.PbList<InputValue>();
  @$core.pragma('dart2js:noInline')
  static InputValue getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InputValue>(create);
  static InputValue? _defaultInstance;

  InputValue_Kind whichKind() => _InputValue_KindByTag[$_whichOneof(0)]!;
  void clearKind() => $_clearField($_whichOneof(0));

  /// A simple literal value for a variable binding
  @$pb.TagNumber(1)
  $3.Value get value => $_getN(0);
  @$pb.TagNumber(1)
  set value($3.Value value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => $_clearField(1);
  @$pb.TagNumber(1)
  $3.Value ensureValue() => $_ensure(0);

  /// An expression which evaluates to the value of the variable binding.
  /// The expression is evaluated using the same runtime environment as the
  /// one used for evaluating the expression under test.
  @$pb.TagNumber(2)
  $core.String get expr => $_getSZ(1);
  @$pb.TagNumber(2)
  set expr($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasExpr() => $_has(1);
  @$pb.TagNumber(2)
  void clearExpr() => $_clearField(2);
}

enum TestOutput_ResultKind {
  resultValue,
  resultExpr,
  evalError,
  unknown,
  notSet
}

/// Expected result of the test case.
class TestOutput extends $pb.GeneratedMessage {
  factory TestOutput({
    $3.Value? resultValue,
    $core.String? resultExpr,
    $4.ErrorSet? evalError,
    $4.UnknownSet? unknown,
  }) {
    final result = create();
    if (resultValue != null) result.resultValue = resultValue;
    if (resultExpr != null) result.resultExpr = resultExpr;
    if (evalError != null) result.evalError = evalError;
    if (unknown != null) result.unknown = unknown;
    return result;
  }

  TestOutput._();

  factory TestOutput.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TestOutput.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, TestOutput_ResultKind>
      _TestOutput_ResultKindByTag = {
    8: TestOutput_ResultKind.resultValue,
    9: TestOutput_ResultKind.resultExpr,
    10: TestOutput_ResultKind.evalError,
    11: TestOutput_ResultKind.unknown,
    0: TestOutput_ResultKind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TestOutput',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'cel.expr.conformance.test'),
      createEmptyInstance: create)
    ..oo(0, [8, 9, 10, 11])
    ..aOM<$3.Value>(8, _omitFieldNames ? '' : 'resultValue',
        subBuilder: $3.Value.create)
    ..aOS(9, _omitFieldNames ? '' : 'resultExpr')
    ..aOM<$4.ErrorSet>(10, _omitFieldNames ? '' : 'evalError',
        subBuilder: $4.ErrorSet.create)
    ..aOM<$4.UnknownSet>(11, _omitFieldNames ? '' : 'unknown',
        subBuilder: $4.UnknownSet.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TestOutput clone() => TestOutput()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TestOutput copyWith(void Function(TestOutput) updates) =>
      super.copyWith((message) => updates(message as TestOutput)) as TestOutput;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestOutput create() => TestOutput._();
  @$core.override
  TestOutput createEmptyInstance() => create();
  static $pb.PbList<TestOutput> createRepeated() => $pb.PbList<TestOutput>();
  @$core.pragma('dart2js:noInline')
  static TestOutput getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TestOutput>(create);
  static TestOutput? _defaultInstance;

  TestOutput_ResultKind whichResultKind() =>
      _TestOutput_ResultKindByTag[$_whichOneof(0)]!;
  void clearResultKind() => $_clearField($_whichOneof(0));

  /// A normal value, which must match the evaluation result exactly via value
  /// equality semantics. This coincides with proto equality, except for:
  /// *   maps are order-agnostic
  /// *   a floating point NaN should match any NaN
  @$pb.TagNumber(8)
  $3.Value get resultValue => $_getN(0);
  @$pb.TagNumber(8)
  set resultValue($3.Value value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasResultValue() => $_has(0);
  @$pb.TagNumber(8)
  void clearResultValue() => $_clearField(8);
  @$pb.TagNumber(8)
  $3.Value ensureResultValue() => $_ensure(0);

  /// An expression to be evaluated using the cel environment configured for
  /// the test suite. The result of this expression must match the result of
  /// the test case.
  @$pb.TagNumber(9)
  $core.String get resultExpr => $_getSZ(1);
  @$pb.TagNumber(9)
  set resultExpr($core.String value) => $_setString(1, value);
  @$pb.TagNumber(9)
  $core.bool hasResultExpr() => $_has(1);
  @$pb.TagNumber(9)
  void clearResultExpr() => $_clearField(9);

  /// An error evaluation result set. Success if we match all of the errors in
  /// the set.
  @$pb.TagNumber(10)
  $4.ErrorSet get evalError => $_getN(2);
  @$pb.TagNumber(10)
  set evalError($4.ErrorSet value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasEvalError() => $_has(2);
  @$pb.TagNumber(10)
  void clearEvalError() => $_clearField(10);
  @$pb.TagNumber(10)
  $4.ErrorSet ensureEvalError() => $_ensure(2);

  /// An unknown evaluation result.
  @$pb.TagNumber(11)
  $4.UnknownSet get unknown => $_getN(3);
  @$pb.TagNumber(11)
  set unknown($4.UnknownSet value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasUnknown() => $_has(3);
  @$pb.TagNumber(11)
  void clearUnknown() => $_clearField(11);
  @$pb.TagNumber(11)
  $4.UnknownSet ensureUnknown() => $_ensure(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
