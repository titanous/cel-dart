// This is a generated file - do not edit.
//
// Generated from google/api/expr/v1alpha1/checked.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// CEL primitive types.
enum Type_PrimitiveType implements $pb.ProtobufEnum {
  /// Unspecified type.
  PRIMITIVE_TYPE_UNSPECIFIED(
      0, _omitEnumNames ? '' : 'PRIMITIVE_TYPE_UNSPECIFIED'),

  /// Boolean type.
  BOOL(1, _omitEnumNames ? '' : 'BOOL'),

  /// Int64 type.
  ///
  /// Proto-based integer values are widened to int64.
  INT64(2, _omitEnumNames ? '' : 'INT64'),

  /// Uint64 type.
  ///
  /// Proto-based unsigned integer values are widened to uint64.
  UINT64(3, _omitEnumNames ? '' : 'UINT64'),

  /// Double type.
  ///
  /// Proto-based float values are widened to double values.
  DOUBLE(4, _omitEnumNames ? '' : 'DOUBLE'),

  /// String type.
  STRING(5, _omitEnumNames ? '' : 'STRING'),

  /// Bytes type.
  BYTES(6, _omitEnumNames ? '' : 'BYTES'),
  ;

  static final $core.Map<$core.int, Type_PrimitiveType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static Type_PrimitiveType? valueOf($core.int value) => _byValue[value];

  @$core.override
  final $core.int value;

  @$core.override
  final $core.String name;

  const Type_PrimitiveType(this.value, this.name);

  /// Returns this enum's [name] or the [value] if names are not represented.
  @$core.override
  $core.String toString() => name == '' ? value.toString() : name;
}

/// Well-known protobuf types treated with first-class support in CEL.
enum Type_WellKnownType implements $pb.ProtobufEnum {
  /// Unspecified type.
  WELL_KNOWN_TYPE_UNSPECIFIED(
      0, _omitEnumNames ? '' : 'WELL_KNOWN_TYPE_UNSPECIFIED'),

  /// Well-known protobuf.Any type.
  ///
  /// Any types are a polymorphic message type. During type-checking they are
  /// treated like `DYN` types, but at runtime they are resolved to a specific
  /// message type specified at evaluation time.
  ANY(1, _omitEnumNames ? '' : 'ANY'),

  /// Well-known protobuf.Timestamp type, internally referenced as `timestamp`.
  TIMESTAMP(2, _omitEnumNames ? '' : 'TIMESTAMP'),

  /// Well-known protobuf.Duration type, internally referenced as `duration`.
  DURATION(3, _omitEnumNames ? '' : 'DURATION'),
  ;

  static final $core.Map<$core.int, Type_WellKnownType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static Type_WellKnownType? valueOf($core.int value) => _byValue[value];

  @$core.override
  final $core.int value;

  @$core.override
  final $core.String name;

  const Type_WellKnownType(this.value, this.name);

  /// Returns this enum's [name] or the [value] if names are not represented.
  @$core.override
  $core.String toString() => name == '' ? value.toString() : name;
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
