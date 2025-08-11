// This is a generated file - do not edit.
//
// Generated from cel/expr/conformance/env_config.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../../google/protobuf/descriptor.pb.dart' as $1;
import '../../../google/protobuf/struct.pb.dart' as $2;
import '../checked.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Import represents a type name that will be abbreviated by its simple name
/// making it easier to reference simple type names from packages other than
/// the expression container.
/// For ex:
///   Import{name: 'google.rpc.Status'}
/// The above import will ensure that `google.rpc.Status` is available by the
/// simple name `Status` within CEL expressions.
class Environment_Import extends $pb.GeneratedMessage {
  factory Environment_Import({
    $core.String? name,
  }) {
    final result = create();
    if (name != null) result.name = name;
    return result;
  }

  Environment_Import._();

  factory Environment_Import.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Environment_Import.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Environment.Import',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'cel.expr.conformance'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name',
        presence: $pb.FieldPresence.implicit)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Environment_Import clone() => Environment_Import()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Environment_Import copyWith(void Function(Environment_Import) updates) =>
      super.copyWith((message) => updates(message as Environment_Import))
          as Environment_Import;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Environment_Import create() => Environment_Import._();
  @$core.override
  Environment_Import createEmptyInstance() => create();
  static $pb.PbList<Environment_Import> createRepeated() =>
      $pb.PbList<Environment_Import>();
  @$core.pragma('dart2js:noInline')
  static Environment_Import getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Environment_Import>(create);
  static Environment_Import? _defaultInstance;

  /// Qualified type name which will be abbreviated
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);
}

/// ContextVariable represents a message type to be made available as a
/// context variable to the CEL environment.
class Environment_ContextVariable extends $pb.GeneratedMessage {
  factory Environment_ContextVariable({
    $core.String? typeName,
  }) {
    final result = create();
    if (typeName != null) result.typeName = typeName;
    return result;
  }

  Environment_ContextVariable._();

  factory Environment_ContextVariable.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Environment_ContextVariable.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Environment.ContextVariable',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'cel.expr.conformance'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'typeName',
        presence: $pb.FieldPresence.implicit)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Environment_ContextVariable clone() =>
      Environment_ContextVariable()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Environment_ContextVariable copyWith(
          void Function(Environment_ContextVariable) updates) =>
      super.copyWith(
              (message) => updates(message as Environment_ContextVariable))
          as Environment_ContextVariable;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Environment_ContextVariable create() =>
      Environment_ContextVariable._();
  @$core.override
  Environment_ContextVariable createEmptyInstance() => create();
  static $pb.PbList<Environment_ContextVariable> createRepeated() =>
      $pb.PbList<Environment_ContextVariable>();
  @$core.pragma('dart2js:noInline')
  static Environment_ContextVariable getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Environment_ContextVariable>(create);
  static Environment_ContextVariable? _defaultInstance;

  /// Fully qualified type name of the context proto.
  @$pb.TagNumber(1)
  $core.String get typeName => $_getSZ(0);
  @$pb.TagNumber(1)
  set typeName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTypeName() => $_has(0);
  @$pb.TagNumber(1)
  void clearTypeName() => $_clearField(1);
}

/// Representation of a CEL Environment, defining what features and extensions
/// are available for conformance testing.
class Environment extends $pb.GeneratedMessage {
  factory Environment({
    $core.String? name,
    $core.String? description,
    $core.String? container,
    $core.Iterable<Environment_Import>? imports,
    LibrarySubset? stdlib,
    $core.Iterable<Extension>? extensions,
    Environment_ContextVariable? contextVariable,
    $core.Iterable<$0.Decl>? declarations,
    $core.Iterable<Validator>? validators,
    $core.Iterable<Feature>? features,
    $core.bool? disableStandardCelDeclarations,
    $1.FileDescriptorSet? messageTypeExtension,
    $core.bool? enableMacroCallTracking,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (container != null) result.container = container;
    if (imports != null) result.imports.addAll(imports);
    if (stdlib != null) result.stdlib = stdlib;
    if (extensions != null) result.extensions.addAll(extensions);
    if (contextVariable != null) result.contextVariable = contextVariable;
    if (declarations != null) result.declarations.addAll(declarations);
    if (validators != null) result.validators.addAll(validators);
    if (features != null) result.features.addAll(features);
    if (disableStandardCelDeclarations != null)
      result.disableStandardCelDeclarations = disableStandardCelDeclarations;
    if (messageTypeExtension != null)
      result.messageTypeExtension = messageTypeExtension;
    if (enableMacroCallTracking != null)
      result.enableMacroCallTracking = enableMacroCallTracking;
    return result;
  }

  Environment._();

  factory Environment.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Environment.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Environment',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'cel.expr.conformance'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name',
        presence: $pb.FieldPresence.implicit)
    ..aOS(2, _omitFieldNames ? '' : 'description',
        presence: $pb.FieldPresence.implicit)
    ..aOS(3, _omitFieldNames ? '' : 'container',
        presence: $pb.FieldPresence.implicit)
    ..pc<Environment_Import>(
        4, _omitFieldNames ? '' : 'imports', $pb.PbFieldType.PM,
        subBuilder: Environment_Import.create)
    ..aOM<LibrarySubset>(5, _omitFieldNames ? '' : 'stdlib',
        subBuilder: LibrarySubset.create)
    ..pc<Extension>(6, _omitFieldNames ? '' : 'extensions', $pb.PbFieldType.PM,
        subBuilder: Extension.create)
    ..aOM<Environment_ContextVariable>(
        7, _omitFieldNames ? '' : 'contextVariable',
        subBuilder: Environment_ContextVariable.create)
    ..pc<$0.Decl>(8, _omitFieldNames ? '' : 'declarations', $pb.PbFieldType.PM,
        subBuilder: $0.Decl.create)
    ..pc<Validator>(9, _omitFieldNames ? '' : 'validators', $pb.PbFieldType.PM,
        subBuilder: Validator.create)
    ..pc<Feature>(10, _omitFieldNames ? '' : 'features', $pb.PbFieldType.PM,
        subBuilder: Feature.create)
    ..aOB(11, _omitFieldNames ? '' : 'disableStandardCelDeclarations',
        presence: $pb.FieldPresence.implicit)
    ..aOM<$1.FileDescriptorSet>(
        12, _omitFieldNames ? '' : 'messageTypeExtension',
        subBuilder: $1.FileDescriptorSet.create)
    ..aOB(13, _omitFieldNames ? '' : 'enableMacroCallTracking',
        presence: $pb.FieldPresence.implicit);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Environment clone() => Environment()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Environment copyWith(void Function(Environment) updates) =>
      super.copyWith((message) => updates(message as Environment))
          as Environment;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Environment create() => Environment._();
  @$core.override
  Environment createEmptyInstance() => create();
  static $pb.PbList<Environment> createRepeated() => $pb.PbList<Environment>();
  @$core.pragma('dart2js:noInline')
  static Environment getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Environment>(create);
  static Environment? _defaultInstance;

  /// Name of the environment
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  /// Description for the current environment
  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);

  /// Sets the namespace (container) for the expression.
  /// This is used to simplify resolution.
  /// For example with container
  ///   `google.rpc.context`
  ///  an identifier of `google.rpc.context.AttributeContext` could be referred
  ///  to simply as `AttributeContext` in the CEL expression.
  @$pb.TagNumber(3)
  $core.String get container => $_getSZ(2);
  @$pb.TagNumber(3)
  set container($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasContainer() => $_has(2);
  @$pb.TagNumber(3)
  void clearContainer() => $_clearField(3);

  /// List of abbreviations to be added to the CEL environment
  @$pb.TagNumber(4)
  $pb.PbList<Environment_Import> get imports => $_getList(3);

  /// Set of options to subset a subsettable library
  @$pb.TagNumber(5)
  LibrarySubset get stdlib => $_getN(4);
  @$pb.TagNumber(5)
  set stdlib(LibrarySubset value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasStdlib() => $_has(4);
  @$pb.TagNumber(5)
  void clearStdlib() => $_clearField(5);
  @$pb.TagNumber(5)
  LibrarySubset ensureStdlib() => $_ensure(4);

  /// List of extensions to enable in the CEL environment.
  @$pb.TagNumber(6)
  $pb.PbList<Extension> get extensions => $_getList(5);

  /// If set, adds a context declaration from a proto message.
  ///
  /// Context messages have all of their top-level fields available as variables
  /// in the type checker.
  @$pb.TagNumber(7)
  Environment_ContextVariable get contextVariable => $_getN(6);
  @$pb.TagNumber(7)
  set contextVariable(Environment_ContextVariable value) =>
      $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasContextVariable() => $_has(6);
  @$pb.TagNumber(7)
  void clearContextVariable() => $_clearField(7);
  @$pb.TagNumber(7)
  Environment_ContextVariable ensureContextVariable() => $_ensure(6);

  /// List of declarations to be configured in the CEL environment.
  ///
  /// Note: The CEL environment can be configured with either the
  /// context_variable or a set of ident_decls provided as part of declarations.
  /// Providing both will result in an error.
  @$pb.TagNumber(8)
  $pb.PbList<$0.Decl> get declarations => $_getList(7);

  /// List of validators for validating the parsed ast.
  @$pb.TagNumber(9)
  $pb.PbList<Validator> get validators => $_getList(8);

  /// List of feature flags to be enabled or disabled.
  @$pb.TagNumber(10)
  $pb.PbList<Feature> get features => $_getList(9);

  /// Disables including the declarations from the standard CEL environment.
  ///
  /// NOTE: Do not disable the standard CEL declarations unless you are aware of
  /// the implications and have discussed your use case on cel-discuss@
  /// or with the members of the cel-governance-team@
  ///
  /// Deprecated: Use LibrarySubset to disable standard cel declarations instead:
  ///   stdlib = LibrarySubset{ disable: true }
  @$pb.TagNumber(11)
  $core.bool get disableStandardCelDeclarations => $_getBF(10);
  @$pb.TagNumber(11)
  set disableStandardCelDeclarations($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasDisableStandardCelDeclarations() => $_has(10);
  @$pb.TagNumber(11)
  void clearDisableStandardCelDeclarations() => $_clearField(11);

  /// If provided, uses the provided FileDescriptorSet to extend types available
  /// the CEL expression. All "well-known" protobuf messages (google.protobuf.*)
  /// are known to the CEL compiler, but all others must be provided for type
  /// checking.
  @$pb.TagNumber(12)
  $1.FileDescriptorSet get messageTypeExtension => $_getN(11);
  @$pb.TagNumber(12)
  set messageTypeExtension($1.FileDescriptorSet value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasMessageTypeExtension() => $_has(11);
  @$pb.TagNumber(12)
  void clearMessageTypeExtension() => $_clearField(12);
  @$pb.TagNumber(12)
  $1.FileDescriptorSet ensureMessageTypeExtension() => $_ensure(11);

  /// When macro call tracking is enabled, the resulting SourceInfo in the
  /// CheckedExpr will contain a collection of expressions representing the
  /// function calls which were replaced by macros.
  ///
  /// Deprecated: Use Feature to enable macro call tracking
  ///  Feature{ name: "cel.feature.macro_call_tracking", enabled: true }
  @$pb.TagNumber(13)
  $core.bool get enableMacroCallTracking => $_getBF(12);
  @$pb.TagNumber(13)
  set enableMacroCallTracking($core.bool value) => $_setBool(12, value);
  @$pb.TagNumber(13)
  $core.bool hasEnableMacroCallTracking() => $_has(12);
  @$pb.TagNumber(13)
  void clearEnableMacroCallTracking() => $_clearField(13);
}

/// Represents a named validator with an optional map-based configuration object.
/// Naming convention followed by validators:
///   <domain>.validator.<validator_name>
/// For ex:
///   `cel.validator.timestamp`
///
/// Note: the map-keys must directly correspond to the internal representation of
/// the original validator, and should only use primitive scalar types as values
/// at this time.
class Validator extends $pb.GeneratedMessage {
  factory Validator({
    $core.String? name,
    $core.Iterable<$core.MapEntry<$core.String, $2.Value>>? config,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (config != null) result.config.addEntries(config);
    return result;
  }

  Validator._();

  factory Validator.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Validator.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Validator',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'cel.expr.conformance'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name',
        presence: $pb.FieldPresence.implicit)
    ..m<$core.String, $2.Value>(2, _omitFieldNames ? '' : 'config',
        entryClassName: 'Validator.ConfigEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $2.Value.create,
        valueDefaultOrMaker: $2.Value.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Validator clone() => Validator()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Validator copyWith(void Function(Validator) updates) =>
      super.copyWith((message) => updates(message as Validator)) as Validator;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Validator create() => Validator._();
  @$core.override
  Validator createEmptyInstance() => create();
  static $pb.PbList<Validator> createRepeated() => $pb.PbList<Validator>();
  @$core.pragma('dart2js:noInline')
  static Validator getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Validator>(create);
  static Validator? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  /// Additional configurations to be included as part of the validation
  @$pb.TagNumber(2)
  $pb.PbMap<$core.String, $2.Value> get config => $_getMap(1);
}

/// Represents a named boolean feature flag supported by CEL.
/// Naming convention followed by features:
///   <domain>.feature.<feature_name>
/// For ex:
///   `cel.feature.cross_type_numeric_comparisons`
class Feature extends $pb.GeneratedMessage {
  factory Feature({
    $core.String? name,
    $core.bool? enabled,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (enabled != null) result.enabled = enabled;
    return result;
  }

  Feature._();

  factory Feature.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Feature.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Feature',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'cel.expr.conformance'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name',
        presence: $pb.FieldPresence.implicit)
    ..aOB(2, _omitFieldNames ? '' : 'enabled',
        presence: $pb.FieldPresence.implicit)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Feature clone() => Feature()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Feature copyWith(void Function(Feature) updates) =>
      super.copyWith((message) => updates(message as Feature)) as Feature;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Feature create() => Feature._();
  @$core.override
  Feature createEmptyInstance() => create();
  static $pb.PbList<Feature> createRepeated() => $pb.PbList<Feature>();
  @$core.pragma('dart2js:noInline')
  static Feature getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Feature>(create);
  static Feature? _defaultInstance;

  /// Name of the feature flag.
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  /// State of the feature flab.
  @$pb.TagNumber(2)
  $core.bool get enabled => $_getBF(1);
  @$pb.TagNumber(2)
  set enabled($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEnabled() => $_has(1);
  @$pb.TagNumber(2)
  void clearEnabled() => $_clearField(2);
}

/// Extension represents a versioned extension library reference to enable in the
/// CEL environment.
class Extension extends $pb.GeneratedMessage {
  factory Extension({
    $core.String? name,
    $core.String? version,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (version != null) result.version = version;
    return result;
  }

  Extension._();

  factory Extension.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Extension.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Extension',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'cel.expr.conformance'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name',
        presence: $pb.FieldPresence.implicit)
    ..aOS(2, _omitFieldNames ? '' : 'version',
        presence: $pb.FieldPresence.implicit)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Extension clone() => Extension()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Extension copyWith(void Function(Extension) updates) =>
      super.copyWith((message) => updates(message as Extension)) as Extension;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Extension create() => Extension._();
  @$core.override
  Extension createEmptyInstance() => create();
  static $pb.PbList<Extension> createRepeated() => $pb.PbList<Extension>();
  @$core.pragma('dart2js:noInline')
  static Extension getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Extension>(create);
  static Extension? _defaultInstance;

  /// Name of the extension library.
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  /// Version of the extension library.
  @$pb.TagNumber(2)
  $core.String get version => $_getSZ(1);
  @$pb.TagNumber(2)
  set version($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersion() => $_clearField(2);
}

/// LibrarySubset indicates a subset of the macros and functions supported by a
/// subsettable library.
class LibrarySubset extends $pb.GeneratedMessage {
  factory LibrarySubset({
    $core.bool? disabled,
    $core.bool? disableMacros,
    $core.Iterable<$core.String>? includeMacros,
    $core.Iterable<$core.String>? excludeMacros,
    $core.Iterable<$0.Decl>? includeFunctions,
    $core.Iterable<$0.Decl>? excludeFunctions,
  }) {
    final result = create();
    if (disabled != null) result.disabled = disabled;
    if (disableMacros != null) result.disableMacros = disableMacros;
    if (includeMacros != null) result.includeMacros.addAll(includeMacros);
    if (excludeMacros != null) result.excludeMacros.addAll(excludeMacros);
    if (includeFunctions != null)
      result.includeFunctions.addAll(includeFunctions);
    if (excludeFunctions != null)
      result.excludeFunctions.addAll(excludeFunctions);
    return result;
  }

  LibrarySubset._();

  factory LibrarySubset.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LibrarySubset.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LibrarySubset',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'cel.expr.conformance'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'disabled',
        presence: $pb.FieldPresence.implicit)
    ..aOB(2, _omitFieldNames ? '' : 'disableMacros',
        presence: $pb.FieldPresence.implicit)
    ..pPS(3, _omitFieldNames ? '' : 'includeMacros')
    ..pPS(4, _omitFieldNames ? '' : 'excludeMacros')
    ..pc<$0.Decl>(
        5, _omitFieldNames ? '' : 'includeFunctions', $pb.PbFieldType.PM,
        subBuilder: $0.Decl.create)
    ..pc<$0.Decl>(
        6, _omitFieldNames ? '' : 'excludeFunctions', $pb.PbFieldType.PM,
        subBuilder: $0.Decl.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LibrarySubset clone() => LibrarySubset()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LibrarySubset copyWith(void Function(LibrarySubset) updates) =>
      super.copyWith((message) => updates(message as LibrarySubset))
          as LibrarySubset;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LibrarySubset create() => LibrarySubset._();
  @$core.override
  LibrarySubset createEmptyInstance() => create();
  static $pb.PbList<LibrarySubset> createRepeated() =>
      $pb.PbList<LibrarySubset>();
  @$core.pragma('dart2js:noInline')
  static LibrarySubset getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LibrarySubset>(create);
  static LibrarySubset? _defaultInstance;

  /// Indicates whether the library has been disabled, typically only
  /// used for default-enabled libraries like stdlib.
  @$pb.TagNumber(1)
  $core.bool get disabled => $_getBF(0);
  @$pb.TagNumber(1)
  set disabled($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDisabled() => $_has(0);
  @$pb.TagNumber(1)
  void clearDisabled() => $_clearField(1);

  /// Disables macros for the given library.
  @$pb.TagNumber(2)
  $core.bool get disableMacros => $_getBF(1);
  @$pb.TagNumber(2)
  set disableMacros($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDisableMacros() => $_has(1);
  @$pb.TagNumber(2)
  void clearDisableMacros() => $_clearField(2);

  /// Specifies a set of macro function names to include in the subset.
  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get includeMacros => $_getList(2);

  /// Specifies a set of macro function names to exclude from the subset.
  /// Note: if IncludeMacros is non-empty, then ExcludeFunctions is ignored.
  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get excludeMacros => $_getList(3);

  /// Specifies a set of functions to include in the subset.
  ///
  /// Note: the overloads specified in the subset need only specify their ID.
  /// Note: if IncludeFunctions is non-empty, then ExcludeFunctions is ignored.
  @$pb.TagNumber(5)
  $pb.PbList<$0.Decl> get includeFunctions => $_getList(4);

  /// Specifies the set of functions to exclude from the subset.
  ///
  /// Note: the overloads specified in the subset need only specify their ID.
  @$pb.TagNumber(6)
  $pb.PbList<$0.Decl> get excludeFunctions => $_getList(5);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
