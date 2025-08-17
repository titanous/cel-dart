// This is a generated file - do not edit.
//
// Generated from cel/expr/conformance/conformance_service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Severities of issues.
enum IssueDetails_Severity implements $pb.ProtobufEnum {
  /// An unspecified severity.
  SEVERITY_UNSPECIFIED(0, _omitEnumNames ? '' : 'SEVERITY_UNSPECIFIED'),

  /// Deprecation issue for statements and method that may no longer be
  /// supported or maintained.
  DEPRECATION(1, _omitEnumNames ? '' : 'DEPRECATION'),

  /// Warnings such as: unused variables.
  WARNING(2, _omitEnumNames ? '' : 'WARNING'),

  /// Errors such as: unmatched curly braces or variable redefinition.
  ERROR(3, _omitEnumNames ? '' : 'ERROR'),
  ;

  static final $core.Map<$core.int, IssueDetails_Severity> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static IssueDetails_Severity? valueOf($core.int value) => _byValue[value];

  @$core.override
  final $core.int value;

  @$core.override
  final $core.String name;

  const IssueDetails_Severity(this.value, this.name);

  /// Returns this enum's [name] or the [value] if names are not represented.
  @$core.override
  $core.String toString() => name == '' ? value.toString() : name;
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
