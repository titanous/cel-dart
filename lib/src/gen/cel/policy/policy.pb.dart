// This is a generated file - do not edit.
//
// Generated from cel/policy/policy.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class PolicySpec_Import extends $pb.GeneratedMessage {
  factory PolicySpec_Import({
    $core.String? name,
  }) {
    final result = create();
    if (name != null) result.name = name;
    return result;
  }

  PolicySpec_Import._();

  factory PolicySpec_Import.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PolicySpec_Import.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PolicySpec.Import',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'cel.policy'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name',
        presence: $pb.FieldPresence.implicit)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PolicySpec_Import clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PolicySpec_Import copyWith(void Function(PolicySpec_Import) updates) =>
      super.copyWith((message) => updates(message as PolicySpec_Import))
          as PolicySpec_Import;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PolicySpec_Import create() => PolicySpec_Import._();
  @$core.override
  PolicySpec_Import createEmptyInstance() => create();
  static $pb.PbList<PolicySpec_Import> createRepeated() =>
      $pb.PbList<PolicySpec_Import>();
  @$core.pragma('dart2js:noInline')
  static PolicySpec_Import getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PolicySpec_Import>(create);
  static PolicySpec_Import? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);
}

class PolicySpec_Variable extends $pb.GeneratedMessage {
  factory PolicySpec_Variable({
    $core.String? name,
    $core.String? description,
    $core.String? expression,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (expression != null) result.expression = expression;
    return result;
  }

  PolicySpec_Variable._();

  factory PolicySpec_Variable.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PolicySpec_Variable.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PolicySpec.Variable',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'cel.policy'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name',
        presence: $pb.FieldPresence.implicit)
    ..aOS(2, _omitFieldNames ? '' : 'description',
        presence: $pb.FieldPresence.implicit)
    ..aOS(3, _omitFieldNames ? '' : 'expression',
        presence: $pb.FieldPresence.implicit)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PolicySpec_Variable clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PolicySpec_Variable copyWith(void Function(PolicySpec_Variable) updates) =>
      super.copyWith((message) => updates(message as PolicySpec_Variable))
          as PolicySpec_Variable;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PolicySpec_Variable create() => PolicySpec_Variable._();
  @$core.override
  PolicySpec_Variable createEmptyInstance() => create();
  static $pb.PbList<PolicySpec_Variable> createRepeated() =>
      $pb.PbList<PolicySpec_Variable>();
  @$core.pragma('dart2js:noInline')
  static PolicySpec_Variable getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PolicySpec_Variable>(create);
  static PolicySpec_Variable? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get expression => $_getSZ(2);
  @$pb.TagNumber(3)
  set expression($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  void clearExpression() => $_clearField(3);
}

class PolicySpec_Rule extends $pb.GeneratedMessage {
  factory PolicySpec_Rule({
    $core.String? id,
    $core.String? description,
    $core.Iterable<PolicySpec_Variable>? variables,
    $core.Iterable<PolicySpec_Match>? match,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (description != null) result.description = description;
    if (variables != null) result.variables.addAll(variables);
    if (match != null) result.match.addAll(match);
    return result;
  }

  PolicySpec_Rule._();

  factory PolicySpec_Rule.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PolicySpec_Rule.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PolicySpec.Rule',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'cel.policy'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id', presence: $pb.FieldPresence.implicit)
    ..aOS(2, _omitFieldNames ? '' : 'description',
        presence: $pb.FieldPresence.implicit)
    ..pc<PolicySpec_Variable>(
        3, _omitFieldNames ? '' : 'variables', $pb.PbFieldType.PM,
        subBuilder: PolicySpec_Variable.create)
    ..pc<PolicySpec_Match>(
        4, _omitFieldNames ? '' : 'match', $pb.PbFieldType.PM,
        subBuilder: PolicySpec_Match.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PolicySpec_Rule clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PolicySpec_Rule copyWith(void Function(PolicySpec_Rule) updates) =>
      super.copyWith((message) => updates(message as PolicySpec_Rule))
          as PolicySpec_Rule;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PolicySpec_Rule create() => PolicySpec_Rule._();
  @$core.override
  PolicySpec_Rule createEmptyInstance() => create();
  static $pb.PbList<PolicySpec_Rule> createRepeated() =>
      $pb.PbList<PolicySpec_Rule>();
  @$core.pragma('dart2js:noInline')
  static PolicySpec_Rule getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PolicySpec_Rule>(create);
  static PolicySpec_Rule? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<PolicySpec_Variable> get variables => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<PolicySpec_Match> get match => $_getList(3);
}

enum PolicySpec_Match_Action { output, rule, notSet }

class PolicySpec_Match extends $pb.GeneratedMessage {
  factory PolicySpec_Match({
    $core.String? condition,
    $core.String? output,
    PolicySpec_Rule? rule,
    $core.String? explanation,
  }) {
    final result = create();
    if (condition != null) result.condition = condition;
    if (output != null) result.output = output;
    if (rule != null) result.rule = rule;
    if (explanation != null) result.explanation = explanation;
    return result;
  }

  PolicySpec_Match._();

  factory PolicySpec_Match.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PolicySpec_Match.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, PolicySpec_Match_Action>
      _PolicySpec_Match_ActionByTag = {
    2: PolicySpec_Match_Action.output,
    3: PolicySpec_Match_Action.rule,
    0: PolicySpec_Match_Action.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PolicySpec.Match',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'cel.policy'),
      createEmptyInstance: create)
    ..oo(0, [2, 3], 'action')
    ..aOS(1, _omitFieldNames ? '' : 'condition')
    ..aOS(2, _omitFieldNames ? '' : 'output')
    ..aOM<PolicySpec_Rule>(3, _omitFieldNames ? '' : 'rule',
        subBuilder: PolicySpec_Rule.create)
    ..aOS(4, _omitFieldNames ? '' : 'explanation',
        presence: $pb.FieldPresence.implicit)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PolicySpec_Match clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PolicySpec_Match copyWith(void Function(PolicySpec_Match) updates) =>
      super.copyWith((message) => updates(message as PolicySpec_Match))
          as PolicySpec_Match;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PolicySpec_Match create() => PolicySpec_Match._();
  @$core.override
  PolicySpec_Match createEmptyInstance() => create();
  static $pb.PbList<PolicySpec_Match> createRepeated() =>
      $pb.PbList<PolicySpec_Match>();
  @$core.pragma('dart2js:noInline')
  static PolicySpec_Match getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PolicySpec_Match>(create);
  static PolicySpec_Match? _defaultInstance;

  PolicySpec_Match_Action whichAction() =>
      _PolicySpec_Match_ActionByTag[$_whichOneof(0)]!;
  void clearAction() => $_clearField($_whichOneof(0));

  /// If unset, the default is "true".
  @$pb.TagNumber(1)
  $core.String? get condition => $_getSNullable(0);
  @$pb.TagNumber(1)
  set condition($core.String? value) => $_setStringNullable(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCondition() => $_has(0);
  @$pb.TagNumber(1)
  void clearCondition() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get output => $_getSZ(1);
  @$pb.TagNumber(2)
  set output($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOutput() => $_has(1);
  @$pb.TagNumber(2)
  void clearOutput() => $_clearField(2);

  @$pb.TagNumber(3)
  PolicySpec_Rule get rule => $_getN(2);
  @$pb.TagNumber(3)
  set rule(PolicySpec_Rule value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasRule() => $_has(2);
  @$pb.TagNumber(3)
  void clearRule() => $_clearField(3);
  @$pb.TagNumber(3)
  PolicySpec_Rule ensureRule() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get explanation => $_getSZ(3);
  @$pb.TagNumber(4)
  set explanation($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  void clearExplanation() => $_clearField(4);
}

class PolicySpec extends $pb.GeneratedMessage {
  factory PolicySpec({
    $core.String? name,
    $core.Iterable<PolicySpec_Import>? imports,
    $core.Iterable<PolicySpec_Variable>? variables,
    $core.String? output,
    $core.String? description,
    $core.String? explanation,
    $core.Iterable<PolicySpec_Match>? match,
    PolicySpec_Rule? rule,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (imports != null) result.imports.addAll(imports);
    if (variables != null) result.variables.addAll(variables);
    if (output != null) result.output = output;
    if (description != null) result.description = description;
    if (explanation != null) result.explanation = explanation;
    if (match != null) result.match.addAll(match);
    if (rule != null) result.rule = rule;
    return result;
  }

  PolicySpec._();

  factory PolicySpec.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PolicySpec.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PolicySpec',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'cel.policy'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name',
        presence: $pb.FieldPresence.implicit)
    ..pc<PolicySpec_Import>(
        2, _omitFieldNames ? '' : 'imports', $pb.PbFieldType.PM,
        subBuilder: PolicySpec_Import.create)
    ..pc<PolicySpec_Variable>(
        3, _omitFieldNames ? '' : 'variables', $pb.PbFieldType.PM,
        subBuilder: PolicySpec_Variable.create)
    ..aOS(4, _omitFieldNames ? '' : 'output')
    ..aOS(5, _omitFieldNames ? '' : 'description')
    ..aOS(6, _omitFieldNames ? '' : 'explanation')
    ..pc<PolicySpec_Match>(
        7, _omitFieldNames ? '' : 'match', $pb.PbFieldType.PM,
        subBuilder: PolicySpec_Match.create)
    ..aOM<PolicySpec_Rule>(8, _omitFieldNames ? '' : 'rule',
        subBuilder: PolicySpec_Rule.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PolicySpec clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PolicySpec copyWith(void Function(PolicySpec) updates) =>
      super.copyWith((message) => updates(message as PolicySpec)) as PolicySpec;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PolicySpec create() => PolicySpec._();
  @$core.override
  PolicySpec createEmptyInstance() => create();
  static $pb.PbList<PolicySpec> createRepeated() => $pb.PbList<PolicySpec>();
  @$core.pragma('dart2js:noInline')
  static PolicySpec getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PolicySpec>(create);
  static PolicySpec? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<PolicySpec_Import> get imports => $_getList(1);

  /// If set, [PolicySpec][match] and [PolicySpec][rule] must be unset.
  @$pb.TagNumber(3)
  $pb.PbList<PolicySpec_Variable> get variables => $_getList(2);

  /// If set, [PolicySpec][match] and [PolicySpec][rule] must be unset.
  @$pb.TagNumber(4)
  $core.String? get output => $_getSNullable(3);
  @$pb.TagNumber(4)
  set output($core.String? value) => $_setStringNullable(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOutput() => $_has(3);
  @$pb.TagNumber(4)
  void clearOutput() => $_clearField(4);

  /// If set, [PolicySpec][match] and [PolicySpec][rule] must be unset.
  @$pb.TagNumber(5)
  $core.String? get description => $_getSNullable(4);
  @$pb.TagNumber(5)
  set description($core.String? value) => $_setStringNullable(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearDescription() => $_clearField(5);

  /// If set, [PolicySpec][match] and [PolicySpec][rule] must be unset.
  @$pb.TagNumber(6)
  $core.String? get explanation => $_getSNullable(5);
  @$pb.TagNumber(6)
  set explanation($core.String? value) => $_setStringNullable(5, value);
  @$pb.TagNumber(6)
  $core.bool hasExplanation() => $_has(5);
  @$pb.TagNumber(6)
  void clearExplanation() => $_clearField(6);

  /// If set, [PolicySpec][variables], [PolicySpec][output], [PolicySpec][description],
  /// [PolicySpec][explanation], and [PolicySpec][rule] must be unset.
  @$pb.TagNumber(7)
  $pb.PbList<PolicySpec_Match> get match => $_getList(6);

  /// If set, [PolicySpec][variables], [PolicySpec][output], [PolicySpec][description],
  /// [PolicySpec][explanation], and [PolicySpec][match] must be unset.
  @$pb.TagNumber(8)
  PolicySpec_Rule get rule => $_getN(7);
  @$pb.TagNumber(8)
  set rule(PolicySpec_Rule value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasRule() => $_has(7);
  @$pb.TagNumber(8)
  void clearRule() => $_clearField(8);
  @$pb.TagNumber(8)
  PolicySpec_Rule ensureRule() => $_ensure(7);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
