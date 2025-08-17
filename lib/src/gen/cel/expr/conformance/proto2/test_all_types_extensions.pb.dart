// This is a generated file - do not edit.
//
// Generated from cel/expr/conformance/proto2/test_all_types_extensions.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'test_all_types.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Message scoped extensions
class Proto2ExtensionScopedMessage extends $pb.GeneratedMessage {
  factory Proto2ExtensionScopedMessage() => create();

  Proto2ExtensionScopedMessage._();

  factory Proto2ExtensionScopedMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Proto2ExtensionScopedMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Proto2ExtensionScopedMessage',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'cel.expr.conformance.proto2'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;
  static final int64Ext = $pb.Extension<$fixnum.Int64>(
      _omitMessageNames ? '' : 'cel.expr.conformance.proto2.TestAllTypes',
      _omitFieldNames ? '' : 'int64Ext',
      1005,
      $pb.PbFieldType.O6,
      defaultOrMaker: $fixnum.Int64.ZERO);
  static final messageScopedNestedExt = $pb.Extension<$0.TestAllTypes>(
      _omitMessageNames ? '' : 'cel.expr.conformance.proto2.TestAllTypes',
      _omitFieldNames ? '' : 'messageScopedNestedExt',
      1006,
      $pb.PbFieldType.OM,
      defaultOrMaker: $0.TestAllTypes.getDefault,
      subBuilder: $0.TestAllTypes.create);
  static final nestedEnumExt = $pb.Extension<$0.TestAllTypes_NestedEnum>(
      _omitMessageNames ? '' : 'cel.expr.conformance.proto2.TestAllTypes',
      _omitFieldNames ? '' : 'nestedEnumExt',
      1007,
      $pb.PbFieldType.OE,
      defaultOrMaker: $0.TestAllTypes_NestedEnum.FOO,
      valueOf: $0.TestAllTypes_NestedEnum.valueOf,
      enumValues: $0.TestAllTypes_NestedEnum.values);
  static final messageScopedRepeatedTestAllTypes =
      $pb.Extension<$0.TestAllTypes>.repeated(
          _omitMessageNames ? '' : 'cel.expr.conformance.proto2.TestAllTypes',
          _omitFieldNames ? '' : 'messageScopedRepeatedTestAllTypes',
          1008,
          $pb.PbFieldType.PM,
          check: $pb.getCheckFunction($pb.PbFieldType.PM),
          subBuilder: $0.TestAllTypes.create);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Proto2ExtensionScopedMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Proto2ExtensionScopedMessage copyWith(
          void Function(Proto2ExtensionScopedMessage) updates) =>
      super.copyWith(
              (message) => updates(message as Proto2ExtensionScopedMessage))
          as Proto2ExtensionScopedMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Proto2ExtensionScopedMessage create() =>
      Proto2ExtensionScopedMessage._();
  @$core.override
  Proto2ExtensionScopedMessage createEmptyInstance() => create();
  static $pb.PbList<Proto2ExtensionScopedMessage> createRepeated() =>
      $pb.PbList<Proto2ExtensionScopedMessage>();
  @$core.pragma('dart2js:noInline')
  static Proto2ExtensionScopedMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Proto2ExtensionScopedMessage>(create);
  static Proto2ExtensionScopedMessage? _defaultInstance;
}

class Test_all_types_extensions {
  static final int32Ext = $pb.Extension<$core.int>(
      _omitMessageNames ? '' : 'cel.expr.conformance.proto2.TestAllTypes',
      _omitFieldNames ? '' : 'int32Ext',
      1000,
      $pb.PbFieldType.O3);
  static final nestedExt = $pb.Extension<$0.TestAllTypes>(
      _omitMessageNames ? '' : 'cel.expr.conformance.proto2.TestAllTypes',
      _omitFieldNames ? '' : 'nestedExt',
      1001,
      $pb.PbFieldType.OM,
      defaultOrMaker: $0.TestAllTypes.getDefault,
      subBuilder: $0.TestAllTypes.create);
  static final testAllTypesExt = $pb.Extension<$0.TestAllTypes>(
      _omitMessageNames ? '' : 'cel.expr.conformance.proto2.TestAllTypes',
      _omitFieldNames ? '' : 'testAllTypesExt',
      1002,
      $pb.PbFieldType.OM,
      defaultOrMaker: $0.TestAllTypes.getDefault,
      subBuilder: $0.TestAllTypes.create);
  static final nestedEnumExt = $pb.Extension<$0.TestAllTypes_NestedEnum>(
      _omitMessageNames ? '' : 'cel.expr.conformance.proto2.TestAllTypes',
      _omitFieldNames ? '' : 'nestedEnumExt',
      1003,
      $pb.PbFieldType.OE,
      defaultOrMaker: $0.TestAllTypes_NestedEnum.FOO,
      valueOf: $0.TestAllTypes_NestedEnum.valueOf,
      enumValues: $0.TestAllTypes_NestedEnum.values);
  static final repeatedTestAllTypes = $pb.Extension<$0.TestAllTypes>.repeated(
      _omitMessageNames ? '' : 'cel.expr.conformance.proto2.TestAllTypes',
      _omitFieldNames ? '' : 'repeatedTestAllTypes',
      1004,
      $pb.PbFieldType.PM,
      check: $pb.getCheckFunction($pb.PbFieldType.PM),
      subBuilder: $0.TestAllTypes.create);
  static void registerAllExtensions($pb.ExtensionRegistry registry) {
    registry.add(int32Ext);
    registry.add(nestedExt);
    registry.add(testAllTypesExt);
    registry.add(nestedEnumExt);
    registry.add(repeatedTestAllTypes);
  }
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
