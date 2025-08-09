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
class GlobalEnum extends $pb.ProtobufEnum {
  static const GlobalEnum GOO = GlobalEnum._(0, _omitEnumNames ? '' : 'GOO');
  static const GlobalEnum GAR = GlobalEnum._(1, _omitEnumNames ? '' : 'GAR');
  static const GlobalEnum GAZ = GlobalEnum._(2, _omitEnumNames ? '' : 'GAZ');

  static const $core.List<GlobalEnum> values = <GlobalEnum>[
    GOO,
    GAR,
    GAZ,
  ];

  static final $core.List<GlobalEnum?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static GlobalEnum? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const GlobalEnum._(super.value, super.name);
}

class TestAllTypes_NestedEnum extends $pb.ProtobufEnum {
  static const TestAllTypes_NestedEnum FOO =
      TestAllTypes_NestedEnum._(0, _omitEnumNames ? '' : 'FOO');
  static const TestAllTypes_NestedEnum BAR =
      TestAllTypes_NestedEnum._(1, _omitEnumNames ? '' : 'BAR');
  static const TestAllTypes_NestedEnum BAZ =
      TestAllTypes_NestedEnum._(2, _omitEnumNames ? '' : 'BAZ');

  static const $core.List<TestAllTypes_NestedEnum> values =
      <TestAllTypes_NestedEnum>[
    FOO,
    BAR,
    BAZ,
  ];

  static final $core.List<TestAllTypes_NestedEnum?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static TestAllTypes_NestedEnum? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const TestAllTypes_NestedEnum._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
