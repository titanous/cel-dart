// This is a generated file - do not edit.
//
// Generated from google/protobuf/struct.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// `NullValue` is a singleton enumeration to represent the null value for the
/// `Value` type union.
///
/// The JSON representation for `NullValue` is JSON `null`.
enum NullValue implements $pb.ProtobufEnum {
  /// Null value.
  NULL_VALUE(0, _omitEnumNames ? '' : 'NULL_VALUE'),
  ;

  static final $core.Map<$core.int, NullValue> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static NullValue? valueOf($core.int value) => _byValue[value];

  @$core.override
  final $core.int value;

  @$core.override
  final $core.String name;

  const NullValue(this.value, this.name);

  /// Returns this enum's [name] or the [value] if names are not represented.
  @$core.override
  $core.String toString() => name == '' ? value.toString() : name;
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
