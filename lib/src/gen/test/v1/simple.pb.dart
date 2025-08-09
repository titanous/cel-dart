// This is a generated file - do not edit.
//
// Generated from test/v1/simple.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../google/api/expr/v1alpha1/checked.pb.dart' as $0;
import '../../google/api/expr/v1alpha1/eval.pb.dart' as $2;
import '../../google/api/expr/v1alpha1/value.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// The format of a simple test file, expected to be stored in text format.
/// A file is the unit of granularity for selecting conformance tests,
/// so tests of optional features should be segregated into separate files.
class SimpleTestFile extends $pb.GeneratedMessage {
  factory SimpleTestFile({
    $core.String? name,
    $core.String? description,
    $core.Iterable<SimpleTestSection>? section,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (section != null) result.section.addAll(section);
    return result;
  }

  SimpleTestFile._();

  factory SimpleTestFile.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SimpleTestFile.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SimpleTestFile',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.test.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..pc<SimpleTestSection>(
        3, _omitFieldNames ? '' : 'section', $pb.PbFieldType.PM,
        subBuilder: SimpleTestSection.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SimpleTestFile clone() => SimpleTestFile()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SimpleTestFile copyWith(void Function(SimpleTestFile) updates) =>
      super.copyWith((message) => updates(message as SimpleTestFile))
          as SimpleTestFile;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SimpleTestFile create() => SimpleTestFile._();
  @$core.override
  SimpleTestFile createEmptyInstance() => create();
  static $pb.PbList<SimpleTestFile> createRepeated() =>
      $pb.PbList<SimpleTestFile>();
  @$core.pragma('dart2js:noInline')
  static SimpleTestFile getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SimpleTestFile>(create);
  static SimpleTestFile? _defaultInstance;

  /// Required.  The name of the file.  Should match the filename.
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  /// A description of the file.
  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);

  /// The contained sections.
  @$pb.TagNumber(3)
  $pb.PbList<SimpleTestSection> get section => $_getList(2);
}

/// A collection of related SimpleTests.
///
/// The section is the unit of organization within a test file, and should
/// guide where new tests are added.
class SimpleTestSection extends $pb.GeneratedMessage {
  factory SimpleTestSection({
    $core.String? name,
    $core.String? description,
    $core.Iterable<SimpleTest>? test,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (test != null) result.test.addAll(test);
    return result;
  }

  SimpleTestSection._();

  factory SimpleTestSection.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SimpleTestSection.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SimpleTestSection',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.test.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..pc<SimpleTest>(3, _omitFieldNames ? '' : 'test', $pb.PbFieldType.PM,
        subBuilder: SimpleTest.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SimpleTestSection clone() => SimpleTestSection()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SimpleTestSection copyWith(void Function(SimpleTestSection) updates) =>
      super.copyWith((message) => updates(message as SimpleTestSection))
          as SimpleTestSection;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SimpleTestSection create() => SimpleTestSection._();
  @$core.override
  SimpleTestSection createEmptyInstance() => create();
  static $pb.PbList<SimpleTestSection> createRepeated() =>
      $pb.PbList<SimpleTestSection>();
  @$core.pragma('dart2js:noInline')
  static SimpleTestSection getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SimpleTestSection>(create);
  static SimpleTestSection? _defaultInstance;

  /// Required.  The name of the section.
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  /// A description of the section.
  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);

  /// The contained tests.
  @$pb.TagNumber(3)
  $pb.PbList<SimpleTest> get test => $_getList(2);
}

enum SimpleTest_ResultMatcher {
  value,
  evalError,
  anyEvalErrors,
  unknown,
  anyUnknowns,
  typedResult,
  notSet
}

/// A test which should run the given CEL program through parsing,
/// optionally through checking, then evaluation, with the results
/// of the pipeline validated by the given result matcher.
class SimpleTest extends $pb.GeneratedMessage {
  factory SimpleTest({
    $core.String? name,
    $core.String? description,
    $core.String? expr,
    $core.bool? disableMacros,
    $core.bool? disableCheck,
    $core.Iterable<$0.Decl>? typeEnv,
    $core.Iterable<$core.MapEntry<$core.String, $2.ExprValue>>? bindings,
    $1.Value? value,
    $2.ErrorSet? evalError,
    ErrorSetMatcher? anyEvalErrors,
    $2.UnknownSet? unknown,
    UnknownSetMatcher? anyUnknowns,
    $core.String? container,
    $core.bool? checkOnly,
    TypedResult? typedResult,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (expr != null) result.expr = expr;
    if (disableMacros != null) result.disableMacros = disableMacros;
    if (disableCheck != null) result.disableCheck = disableCheck;
    if (typeEnv != null) result.typeEnv.addAll(typeEnv);
    if (bindings != null) result.bindings.addEntries(bindings);
    if (value != null) result.value = value;
    if (evalError != null) result.evalError = evalError;
    if (anyEvalErrors != null) result.anyEvalErrors = anyEvalErrors;
    if (unknown != null) result.unknown = unknown;
    if (anyUnknowns != null) result.anyUnknowns = anyUnknowns;
    if (container != null) result.container = container;
    if (checkOnly != null) result.checkOnly = checkOnly;
    if (typedResult != null) result.typedResult = typedResult;
    return result;
  }

  SimpleTest._();

  factory SimpleTest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SimpleTest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, SimpleTest_ResultMatcher>
      _SimpleTest_ResultMatcherByTag = {
    8: SimpleTest_ResultMatcher.value,
    9: SimpleTest_ResultMatcher.evalError,
    10: SimpleTest_ResultMatcher.anyEvalErrors,
    11: SimpleTest_ResultMatcher.unknown,
    12: SimpleTest_ResultMatcher.anyUnknowns,
    16: SimpleTest_ResultMatcher.typedResult,
    0: SimpleTest_ResultMatcher.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SimpleTest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.test.v1'),
      createEmptyInstance: create)
    ..oo(0, [8, 9, 10, 11, 12, 16])
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..aOS(3, _omitFieldNames ? '' : 'expr')
    ..aOB(4, _omitFieldNames ? '' : 'disableMacros')
    ..aOB(5, _omitFieldNames ? '' : 'disableCheck')
    ..pc<$0.Decl>(6, _omitFieldNames ? '' : 'typeEnv', $pb.PbFieldType.PM,
        subBuilder: $0.Decl.create)
    ..m<$core.String, $2.ExprValue>(7, _omitFieldNames ? '' : 'bindings',
        entryClassName: 'SimpleTest.BindingsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $2.ExprValue.create,
        valueDefaultOrMaker: $2.ExprValue.getDefault,
        packageName: const $pb.PackageName('google.api.expr.test.v1'))
    ..aOM<$1.Value>(8, _omitFieldNames ? '' : 'value',
        subBuilder: $1.Value.create)
    ..aOM<$2.ErrorSet>(9, _omitFieldNames ? '' : 'evalError',
        subBuilder: $2.ErrorSet.create)
    ..aOM<ErrorSetMatcher>(10, _omitFieldNames ? '' : 'anyEvalErrors',
        subBuilder: ErrorSetMatcher.create)
    ..aOM<$2.UnknownSet>(11, _omitFieldNames ? '' : 'unknown',
        subBuilder: $2.UnknownSet.create)
    ..aOM<UnknownSetMatcher>(12, _omitFieldNames ? '' : 'anyUnknowns',
        subBuilder: UnknownSetMatcher.create)
    ..aOS(13, _omitFieldNames ? '' : 'container')
    ..aOB(15, _omitFieldNames ? '' : 'checkOnly')
    ..aOM<TypedResult>(16, _omitFieldNames ? '' : 'typedResult',
        subBuilder: TypedResult.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SimpleTest clone() => SimpleTest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SimpleTest copyWith(void Function(SimpleTest) updates) =>
      super.copyWith((message) => updates(message as SimpleTest)) as SimpleTest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SimpleTest create() => SimpleTest._();
  @$core.override
  SimpleTest createEmptyInstance() => create();
  static $pb.PbList<SimpleTest> createRepeated() => $pb.PbList<SimpleTest>();
  @$core.pragma('dart2js:noInline')
  static SimpleTest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SimpleTest>(create);
  static SimpleTest? _defaultInstance;

  SimpleTest_ResultMatcher whichResultMatcher() =>
      _SimpleTest_ResultMatcherByTag[$_whichOneof(0)]!;
  void clearResultMatcher() => $_clearField($_whichOneof(0));

  /// Required.  The name of the test, which should be unique in the test file.
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

  /// Required.  The text of the CEL expression.
  @$pb.TagNumber(3)
  $core.String get expr => $_getSZ(2);
  @$pb.TagNumber(3)
  set expr($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasExpr() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpr() => $_clearField(3);

  /// Disables all macro expansion in parsing.
  @$pb.TagNumber(4)
  $core.bool get disableMacros => $_getBF(3);
  @$pb.TagNumber(4)
  set disableMacros($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDisableMacros() => $_has(3);
  @$pb.TagNumber(4)
  void clearDisableMacros() => $_clearField(4);

  /// Disables the check phase.
  @$pb.TagNumber(5)
  $core.bool get disableCheck => $_getBF(4);
  @$pb.TagNumber(5)
  set disableCheck($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDisableCheck() => $_has(4);
  @$pb.TagNumber(5)
  void clearDisableCheck() => $_clearField(5);

  /// The type environment to use for the check phase.
  @$pb.TagNumber(6)
  $pb.PbList<$0.Decl> get typeEnv => $_getList(5);

  /// Variable bindings to use for the eval phase.
  @$pb.TagNumber(7)
  $pb.PbMap<$core.String, $2.ExprValue> get bindings => $_getMap(6);

  /// A normal value, which must match the evaluation result exactly
  /// via value equality semantics.  This coincides with proto equality,
  /// except for:
  /// *   maps are order-agnostic.
  /// *   a floating point NaN should match any NaN.
  @$pb.TagNumber(8)
  $1.Value get value => $_getN(7);
  @$pb.TagNumber(8)
  set value($1.Value value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasValue() => $_has(7);
  @$pb.TagNumber(8)
  void clearValue() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Value ensureValue() => $_ensure(7);

  /// Matches error evaluation results.
  @$pb.TagNumber(9)
  $2.ErrorSet get evalError => $_getN(8);
  @$pb.TagNumber(9)
  set evalError($2.ErrorSet value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasEvalError() => $_has(8);
  @$pb.TagNumber(9)
  void clearEvalError() => $_clearField(9);
  @$pb.TagNumber(9)
  $2.ErrorSet ensureEvalError() => $_ensure(8);

  /// Matches one of several error results.
  /// (Using explicit message since oneof can't handle repeated.)
  @$pb.TagNumber(10)
  ErrorSetMatcher get anyEvalErrors => $_getN(9);
  @$pb.TagNumber(10)
  set anyEvalErrors(ErrorSetMatcher value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasAnyEvalErrors() => $_has(9);
  @$pb.TagNumber(10)
  void clearAnyEvalErrors() => $_clearField(10);
  @$pb.TagNumber(10)
  ErrorSetMatcher ensureAnyEvalErrors() => $_ensure(9);

  /// Matches unknown evaluation results.
  @$pb.TagNumber(11)
  $2.UnknownSet get unknown => $_getN(10);
  @$pb.TagNumber(11)
  set unknown($2.UnknownSet value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasUnknown() => $_has(10);
  @$pb.TagNumber(11)
  void clearUnknown() => $_clearField(11);
  @$pb.TagNumber(11)
  $2.UnknownSet ensureUnknown() => $_ensure(10);

  /// Matches one of several unknown results.
  /// (Using explicit message since oneof can't handle repeated.)
  @$pb.TagNumber(12)
  UnknownSetMatcher get anyUnknowns => $_getN(11);
  @$pb.TagNumber(12)
  set anyUnknowns(UnknownSetMatcher value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasAnyUnknowns() => $_has(11);
  @$pb.TagNumber(12)
  void clearAnyUnknowns() => $_clearField(12);
  @$pb.TagNumber(12)
  UnknownSetMatcher ensureAnyUnknowns() => $_ensure(11);

  /// The container for name resolution.
  @$pb.TagNumber(13)
  $core.String get container => $_getSZ(12);
  @$pb.TagNumber(13)
  set container($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasContainer() => $_has(12);
  @$pb.TagNumber(13)
  void clearContainer() => $_clearField(13);

  /// Disables the evaluate phase.
  @$pb.TagNumber(15)
  $core.bool get checkOnly => $_getBF(13);
  @$pb.TagNumber(15)
  set checkOnly($core.bool value) => $_setBool(13, value);
  @$pb.TagNumber(15)
  $core.bool hasCheckOnly() => $_has(13);
  @$pb.TagNumber(15)
  void clearCheckOnly() => $_clearField(15);

  /// A result and deduced expression type.
  @$pb.TagNumber(16)
  TypedResult get typedResult => $_getN(14);
  @$pb.TagNumber(16)
  set typedResult(TypedResult value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasTypedResult() => $_has(14);
  @$pb.TagNumber(16)
  void clearTypedResult() => $_clearField(16);
  @$pb.TagNumber(16)
  TypedResult ensureTypedResult() => $_ensure(14);
}

/// Matches a result along with deduced expression type.
class TypedResult extends $pb.GeneratedMessage {
  factory TypedResult({
    $1.Value? result,
    $0.Type? deducedType,
  }) {
    final result$ = create();
    if (result != null) result$.result = result;
    if (deducedType != null) result$.deducedType = deducedType;
    return result$;
  }

  TypedResult._();

  factory TypedResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TypedResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TypedResult',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.test.v1'),
      createEmptyInstance: create)
    ..aOM<$1.Value>(1, _omitFieldNames ? '' : 'result',
        subBuilder: $1.Value.create)
    ..aOM<$0.Type>(2, _omitFieldNames ? '' : 'deducedType',
        subBuilder: $0.Type.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TypedResult clone() => TypedResult()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TypedResult copyWith(void Function(TypedResult) updates) =>
      super.copyWith((message) => updates(message as TypedResult))
          as TypedResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TypedResult create() => TypedResult._();
  @$core.override
  TypedResult createEmptyInstance() => create();
  static $pb.PbList<TypedResult> createRepeated() => $pb.PbList<TypedResult>();
  @$core.pragma('dart2js:noInline')
  static TypedResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TypedResult>(create);
  static TypedResult? _defaultInstance;

  /// A normal value, which must match the evaluation result exactly
  /// via value equality semantics. This is ignored if the test is `check_only`.
  @$pb.TagNumber(1)
  $1.Value get result => $_getN(0);
  @$pb.TagNumber(1)
  set result($1.Value value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Value ensureResult() => $_ensure(0);

  /// The deduced type of the expression as reported by the checker.
  @$pb.TagNumber(2)
  $0.Type get deducedType => $_getN(1);
  @$pb.TagNumber(2)
  set deducedType($0.Type value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasDeducedType() => $_has(1);
  @$pb.TagNumber(2)
  void clearDeducedType() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.Type ensureDeducedType() => $_ensure(1);
}

/// Matches error results from Eval.
class ErrorSetMatcher extends $pb.GeneratedMessage {
  factory ErrorSetMatcher({
    $core.Iterable<$2.ErrorSet>? errors,
  }) {
    final result = create();
    if (errors != null) result.errors.addAll(errors);
    return result;
  }

  ErrorSetMatcher._();

  factory ErrorSetMatcher.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ErrorSetMatcher.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ErrorSetMatcher',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.test.v1'),
      createEmptyInstance: create)
    ..pc<$2.ErrorSet>(1, _omitFieldNames ? '' : 'errors', $pb.PbFieldType.PM,
        subBuilder: $2.ErrorSet.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ErrorSetMatcher clone() => ErrorSetMatcher()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ErrorSetMatcher copyWith(void Function(ErrorSetMatcher) updates) =>
      super.copyWith((message) => updates(message as ErrorSetMatcher))
          as ErrorSetMatcher;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ErrorSetMatcher create() => ErrorSetMatcher._();
  @$core.override
  ErrorSetMatcher createEmptyInstance() => create();
  static $pb.PbList<ErrorSetMatcher> createRepeated() =>
      $pb.PbList<ErrorSetMatcher>();
  @$core.pragma('dart2js:noInline')
  static ErrorSetMatcher getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ErrorSetMatcher>(create);
  static ErrorSetMatcher? _defaultInstance;

  /// Success if we match any of these sets.
  @$pb.TagNumber(1)
  $pb.PbList<$2.ErrorSet> get errors => $_getList(0);
}

/// Matches unknown results from Eval.
class UnknownSetMatcher extends $pb.GeneratedMessage {
  factory UnknownSetMatcher({
    $core.Iterable<$2.UnknownSet>? unknowns,
  }) {
    final result = create();
    if (unknowns != null) result.unknowns.addAll(unknowns);
    return result;
  }

  UnknownSetMatcher._();

  factory UnknownSetMatcher.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UnknownSetMatcher.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UnknownSetMatcher',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.test.v1'),
      createEmptyInstance: create)
    ..pc<$2.UnknownSet>(
        1, _omitFieldNames ? '' : 'unknowns', $pb.PbFieldType.PM,
        subBuilder: $2.UnknownSet.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnknownSetMatcher clone() => UnknownSetMatcher()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnknownSetMatcher copyWith(void Function(UnknownSetMatcher) updates) =>
      super.copyWith((message) => updates(message as UnknownSetMatcher))
          as UnknownSetMatcher;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnknownSetMatcher create() => UnknownSetMatcher._();
  @$core.override
  UnknownSetMatcher createEmptyInstance() => create();
  static $pb.PbList<UnknownSetMatcher> createRepeated() =>
      $pb.PbList<UnknownSetMatcher>();
  @$core.pragma('dart2js:noInline')
  static UnknownSetMatcher getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UnknownSetMatcher>(create);
  static UnknownSetMatcher? _defaultInstance;

  /// Success if we match any of these sets.
  @$pb.TagNumber(1)
  $pb.PbList<$2.UnknownSet> get unknowns => $_getList(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
