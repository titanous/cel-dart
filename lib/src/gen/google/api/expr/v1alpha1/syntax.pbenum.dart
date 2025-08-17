// This is a generated file - do not edit.
//
// Generated from google/api/expr/v1alpha1/syntax.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// CEL component specifier.
enum SourceInfo_Extension_Component implements $pb.ProtobufEnum {
  /// Unspecified, default.
  COMPONENT_UNSPECIFIED(0, _omitEnumNames ? '' : 'COMPONENT_UNSPECIFIED'),

  /// Parser. Converts a CEL string to an AST.
  COMPONENT_PARSER(1, _omitEnumNames ? '' : 'COMPONENT_PARSER'),

  /// Type checker. Checks that references in an AST are defined and types
  /// agree.
  COMPONENT_TYPE_CHECKER(2, _omitEnumNames ? '' : 'COMPONENT_TYPE_CHECKER'),

  /// Runtime. Evaluates a parsed and optionally checked CEL AST against a
  /// context.
  COMPONENT_RUNTIME(3, _omitEnumNames ? '' : 'COMPONENT_RUNTIME'),
  ;

  static final $core.Map<$core.int, SourceInfo_Extension_Component> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static SourceInfo_Extension_Component? valueOf($core.int value) =>
      _byValue[value];

  @$core.override
  final $core.int value;

  @$core.override
  final $core.String name;

  const SourceInfo_Extension_Component(this.value, this.name);

  /// Returns this enum's [name] or the [value] if names are not represented.
  @$core.override
  $core.String toString() => name == '' ? value.toString() : name;
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
