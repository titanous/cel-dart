// This is a generated file - do not edit.
//
// Generated from cel/expr/conformance/proto2/test_all_types.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// This proto tests that global enums are resolved correctly.
enum GlobalEnum implements $pb.ProtobufEnum {
  GOO(0, _omitEnumNames ? '' : 'GOO'),

  GAR(1, _omitEnumNames ? '' : 'GAR'),

  GAZ(2, _omitEnumNames ? '' : 'GAZ'),
  ;

  static final $core.Map<$core.int, GlobalEnum> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static GlobalEnum? valueOf($core.int value) => _byValue[value];

  @$core.override
  final $core.int value;

  @$core.override
  final $core.String name;

  const GlobalEnum(this.value, this.name);

  /// Returns this enum's [name] or the [value] if names are not represented.
  @$core.override
  $core.String toString() => name == '' ? value.toString() : name;
}

enum TestAllTypes_NestedEnum implements $pb.ProtobufEnum {
  FOO(0, _omitEnumNames ? '' : 'FOO'),

  BAR(1, _omitEnumNames ? '' : 'BAR'),

  BAZ(2, _omitEnumNames ? '' : 'BAZ'),
  ;

  static final $core.Map<$core.int, TestAllTypes_NestedEnum> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static TestAllTypes_NestedEnum? valueOf($core.int value) => _byValue[value];

  @$core.override
  final $core.int value;

  @$core.override
  final $core.String name;

  const TestAllTypes_NestedEnum(this.value, this.name);

  /// Returns this enum's [name] or the [value] if names are not represented.
  @$core.override
  $core.String toString() => name == '' ? value.toString() : name;
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
