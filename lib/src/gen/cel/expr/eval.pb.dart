// This is a generated file - do not edit.
//
// Generated from cel/expr/eval.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../google/protobuf/any.pb.dart' as $1;
import 'value.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// A single evaluation result.
class EvalState_Result extends $pb.GeneratedMessage {
  factory EvalState_Result({
    $fixnum.Int64? expr,
    $fixnum.Int64? value,
  }) {
    final result = create();
    if (expr != null) result.expr = expr;
    if (value != null) result.value = value;
    return result;
  }

  EvalState_Result._();

  factory EvalState_Result.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EvalState_Result.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EvalState.Result',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'cel.expr'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'expr')
    ..aInt64(2, _omitFieldNames ? '' : 'value')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EvalState_Result clone() => EvalState_Result()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EvalState_Result copyWith(void Function(EvalState_Result) updates) =>
      super.copyWith((message) => updates(message as EvalState_Result))
          as EvalState_Result;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EvalState_Result create() => EvalState_Result._();
  @$core.override
  EvalState_Result createEmptyInstance() => create();
  static $pb.PbList<EvalState_Result> createRepeated() =>
      $pb.PbList<EvalState_Result>();
  @$core.pragma('dart2js:noInline')
  static EvalState_Result getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EvalState_Result>(create);
  static EvalState_Result? _defaultInstance;

  /// The id of the expression this result if for.
  @$pb.TagNumber(1)
  $fixnum.Int64 get expr => $_getI64(0);
  @$pb.TagNumber(1)
  set expr($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasExpr() => $_has(0);
  @$pb.TagNumber(1)
  void clearExpr() => $_clearField(1);

  /// The index in `values` of the resulting value.
  @$pb.TagNumber(2)
  $fixnum.Int64 get value => $_getI64(1);
  @$pb.TagNumber(2)
  set value($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => $_clearField(2);
}

/// The state of an evaluation.
///
/// Can represent an initial, partial, or completed state of evaluation.
class EvalState extends $pb.GeneratedMessage {
  factory EvalState({
    $core.Iterable<ExprValue>? values,
    $core.Iterable<EvalState_Result>? results,
  }) {
    final result = create();
    if (values != null) result.values.addAll(values);
    if (results != null) result.results.addAll(results);
    return result;
  }

  EvalState._();

  factory EvalState.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EvalState.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EvalState',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'cel.expr'),
      createEmptyInstance: create)
    ..pc<ExprValue>(1, _omitFieldNames ? '' : 'values', $pb.PbFieldType.PM,
        subBuilder: ExprValue.create)
    ..pc<EvalState_Result>(
        3, _omitFieldNames ? '' : 'results', $pb.PbFieldType.PM,
        subBuilder: EvalState_Result.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EvalState clone() => EvalState()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EvalState copyWith(void Function(EvalState) updates) =>
      super.copyWith((message) => updates(message as EvalState)) as EvalState;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EvalState create() => EvalState._();
  @$core.override
  EvalState createEmptyInstance() => create();
  static $pb.PbList<EvalState> createRepeated() => $pb.PbList<EvalState>();
  @$core.pragma('dart2js:noInline')
  static EvalState getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EvalState>(create);
  static EvalState? _defaultInstance;

  /// The unique values referenced in this message.
  @$pb.TagNumber(1)
  $pb.PbList<ExprValue> get values => $_getList(0);

  /// An ordered list of results.
  ///
  /// Tracks the flow of evaluation through the expression.
  /// May be sparse.
  @$pb.TagNumber(3)
  $pb.PbList<EvalState_Result> get results => $_getList(1);
}

enum ExprValue_Kind { value, error, unknown, notSet }

/// The value of an evaluated expression.
class ExprValue extends $pb.GeneratedMessage {
  factory ExprValue({
    $0.Value? value,
    ErrorSet? error,
    UnknownSet? unknown,
  }) {
    final result = create();
    if (value != null) result.value = value;
    if (error != null) result.error = error;
    if (unknown != null) result.unknown = unknown;
    return result;
  }

  ExprValue._();

  factory ExprValue.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ExprValue.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, ExprValue_Kind> _ExprValue_KindByTag = {
    1: ExprValue_Kind.value,
    2: ExprValue_Kind.error,
    3: ExprValue_Kind.unknown,
    0: ExprValue_Kind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExprValue',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'cel.expr'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOM<$0.Value>(1, _omitFieldNames ? '' : 'value',
        subBuilder: $0.Value.create)
    ..aOM<ErrorSet>(2, _omitFieldNames ? '' : 'error',
        subBuilder: ErrorSet.create)
    ..aOM<UnknownSet>(3, _omitFieldNames ? '' : 'unknown',
        subBuilder: UnknownSet.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExprValue clone() => ExprValue()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExprValue copyWith(void Function(ExprValue) updates) =>
      super.copyWith((message) => updates(message as ExprValue)) as ExprValue;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExprValue create() => ExprValue._();
  @$core.override
  ExprValue createEmptyInstance() => create();
  static $pb.PbList<ExprValue> createRepeated() => $pb.PbList<ExprValue>();
  @$core.pragma('dart2js:noInline')
  static ExprValue getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExprValue>(create);
  static ExprValue? _defaultInstance;

  ExprValue_Kind whichKind() => _ExprValue_KindByTag[$_whichOneof(0)]!;
  void clearKind() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $0.Value get value => $_getN(0);
  @$pb.TagNumber(1)
  set value($0.Value value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.Value ensureValue() => $_ensure(0);

  /// The set of errors in the critical path of evaluation.
  ///
  /// Only errors in the critical path are included. For example,
  /// `(<error1> || true) && <error2>` will only result in `<error2>`,
  /// while `<error1> || <error2>` will result in both `<error1>` and
  /// `<error2>`.
  ///
  /// Errors cause by the presence of other errors are not included in the
  /// set. For example `<error1>.foo`, `foo(<error1>)`, and `<error1> + 1` will
  /// only result in `<error1>`.
  ///
  /// Multiple errors *might* be included when evaluation could result
  /// in different errors. For example `<error1> + <error2>` and
  /// `foo(<error1>, <error2>)` may result in `<error1>`, `<error2>` or both.
  /// The exact subset of errors included for this case is unspecified and
  /// depends on the implementation details of the evaluator.
  @$pb.TagNumber(2)
  ErrorSet get error => $_getN(1);
  @$pb.TagNumber(2)
  set error(ErrorSet value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);
  @$pb.TagNumber(2)
  ErrorSet ensureError() => $_ensure(1);

  /// The set of unknowns in the critical path of evaluation.
  ///
  /// Unknown behaves identically to Error with regards to propagation.
  /// Specifically, only unknowns in the critical path are included, unknowns
  /// caused by the presence of other unknowns are not included, and multiple
  /// unknowns *might* be included when evaluation could result in
  /// different unknowns. For example:
  ///
  ///     (<unknown[1]> || true) && <unknown[2]> -> <unknown[2]>
  ///     <unknown[1]> || <unknown[2]> -> <unknown[1,2]>
  ///     <unknown[1]>.foo -> <unknown[1]>
  ///     foo(<unknown[1]>) -> <unknown[1]>
  ///     <unknown[1]> + <unknown[2]> -> <unknown[1]> or <unknown[2[>
  ///
  /// Unknown takes precedence over Error in cases where a `Value` can short
  /// circuit the result:
  ///
  ///     <error> || <unknown> -> <unknown>
  ///     <error> && <unknown> -> <unknown>
  ///
  /// Errors take precedence in all other cases:
  ///
  ///     <unknown> + <error> -> <error>
  ///     foo(<unknown>, <error>) -> <error>
  @$pb.TagNumber(3)
  UnknownSet get unknown => $_getN(2);
  @$pb.TagNumber(3)
  set unknown(UnknownSet value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasUnknown() => $_has(2);
  @$pb.TagNumber(3)
  void clearUnknown() => $_clearField(3);
  @$pb.TagNumber(3)
  UnknownSet ensureUnknown() => $_ensure(2);
}

/// A set of errors.
///
/// The errors included depend on the context. See `ExprValue.error`.
class ErrorSet extends $pb.GeneratedMessage {
  factory ErrorSet({
    $core.Iterable<Status>? errors,
  }) {
    final result = create();
    if (errors != null) result.errors.addAll(errors);
    return result;
  }

  ErrorSet._();

  factory ErrorSet.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ErrorSet.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ErrorSet',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'cel.expr'),
      createEmptyInstance: create)
    ..pc<Status>(1, _omitFieldNames ? '' : 'errors', $pb.PbFieldType.PM,
        subBuilder: Status.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ErrorSet clone() => ErrorSet()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ErrorSet copyWith(void Function(ErrorSet) updates) =>
      super.copyWith((message) => updates(message as ErrorSet)) as ErrorSet;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ErrorSet create() => ErrorSet._();
  @$core.override
  ErrorSet createEmptyInstance() => create();
  static $pb.PbList<ErrorSet> createRepeated() => $pb.PbList<ErrorSet>();
  @$core.pragma('dart2js:noInline')
  static ErrorSet getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ErrorSet>(create);
  static ErrorSet? _defaultInstance;

  /// Errors that could come up during evaluation phase.
  @$pb.TagNumber(1)
  $pb.PbList<Status> get errors => $_getList(0);
}

/// Each `Status` message contains three pieces of data: error code, error message,
/// and error details.
///
/// You can find out more about this error model and how to work with it in the
/// [API Design Guide](https://cloud.google.com/apis/design/errors).
///
/// Status value is intended to be wire and field compatible with `google.rpc.Status`.
class Status extends $pb.GeneratedMessage {
  factory Status({
    $core.int? code,
    $core.String? message,
    $core.Iterable<$1.Any>? details,
  }) {
    final result = create();
    if (code != null) result.code = code;
    if (message != null) result.message = message;
    if (details != null) result.details.addAll(details);
    return result;
  }

  Status._();

  factory Status.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Status.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Status',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'cel.expr'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'code', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..pc<$1.Any>(3, _omitFieldNames ? '' : 'details', $pb.PbFieldType.PM,
        subBuilder: $1.Any.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Status clone() => Status()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Status copyWith(void Function(Status) updates) =>
      super.copyWith((message) => updates(message as Status)) as Status;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Status create() => Status._();
  @$core.override
  Status createEmptyInstance() => create();
  static $pb.PbList<Status> createRepeated() => $pb.PbList<Status>();
  @$core.pragma('dart2js:noInline')
  static Status getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Status>(create);
  static Status? _defaultInstance;

  /// The status code, which should be an enum value of [google.rpc.Code][].
  @$pb.TagNumber(1)
  $core.int get code => $_getIZ(0);
  @$pb.TagNumber(1)
  set code($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => $_clearField(1);

  /// A developer-facing error message, which should be in English. Any
  /// user-facing error message should be localized and sent in the
  /// [Status.details][] field, or localized by the client.
  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  /// A list of messages that carry the error details.  There is a common set of
  /// message types for APIs to use.
  @$pb.TagNumber(3)
  $pb.PbList<$1.Any> get details => $_getList(2);
}

/// A set of expressions for which the value is unknown.
///
/// The unknowns included depend on the context. See `ExprValue.unknown`.
class UnknownSet extends $pb.GeneratedMessage {
  factory UnknownSet({
    $core.Iterable<$fixnum.Int64>? exprs,
  }) {
    final result = create();
    if (exprs != null) result.exprs.addAll(exprs);
    return result;
  }

  UnknownSet._();

  factory UnknownSet.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UnknownSet.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UnknownSet',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'cel.expr'),
      createEmptyInstance: create)
    ..p<$fixnum.Int64>(1, _omitFieldNames ? '' : 'exprs', $pb.PbFieldType.K6)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnknownSet clone() => UnknownSet()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnknownSet copyWith(void Function(UnknownSet) updates) =>
      super.copyWith((message) => updates(message as UnknownSet)) as UnknownSet;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnknownSet create() => UnknownSet._();
  @$core.override
  UnknownSet createEmptyInstance() => create();
  static $pb.PbList<UnknownSet> createRepeated() => $pb.PbList<UnknownSet>();
  @$core.pragma('dart2js:noInline')
  static UnknownSet getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UnknownSet>(create);
  static UnknownSet? _defaultInstance;

  /// The ids of the expressions with unknown values.
  @$pb.TagNumber(1)
  $pb.PbList<$fixnum.Int64> get exprs => $_getList(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
