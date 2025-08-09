// This is a generated file - do not edit.
//
// Generated from cel/expr/explain.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use explainDescriptor instead')
const Explain$json = {
  '1': 'Explain',
  '2': [
    {
      '1': 'values',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.Value',
      '10': 'values'
    },
    {
      '1': 'expr_steps',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.Explain.ExprStep',
      '10': 'exprSteps'
    },
  ],
  '3': [Explain_ExprStep$json],
  '7': {'3': true},
};

@$core.Deprecated('Use explainDescriptor instead')
const Explain_ExprStep$json = {
  '1': 'ExprStep',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'value_index', '3': 2, '4': 1, '5': 5, '10': 'valueIndex'},
  ],
};

/// Descriptor for `Explain`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List explainDescriptor = $convert.base64Decode(
    'CgdFeHBsYWluEicKBnZhbHVlcxgBIAMoCzIPLmNlbC5leHByLlZhbHVlUgZ2YWx1ZXMSOQoKZX'
    'hwcl9zdGVwcxgCIAMoCzIaLmNlbC5leHByLkV4cGxhaW4uRXhwclN0ZXBSCWV4cHJTdGVwcxo7'
    'CghFeHByU3RlcBIOCgJpZBgBIAEoA1ICaWQSHwoLdmFsdWVfaW5kZXgYAiABKAVSCnZhbHVlSW'
    '5kZXg6AhgB');
