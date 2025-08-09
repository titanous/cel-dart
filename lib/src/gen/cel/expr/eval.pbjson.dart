// This is a generated file - do not edit.
//
// Generated from cel/expr/eval.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use evalStateDescriptor instead')
const EvalState$json = {
  '1': 'EvalState',
  '2': [
    {
      '1': 'values',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.ExprValue',
      '10': 'values'
    },
    {
      '1': 'results',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.EvalState.Result',
      '10': 'results'
    },
  ],
  '3': [EvalState_Result$json],
};

@$core.Deprecated('Use evalStateDescriptor instead')
const EvalState_Result$json = {
  '1': 'Result',
  '2': [
    {'1': 'expr', '3': 1, '4': 1, '5': 3, '10': 'expr'},
    {'1': 'value', '3': 2, '4': 1, '5': 3, '10': 'value'},
  ],
};

/// Descriptor for `EvalState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List evalStateDescriptor = $convert.base64Decode(
    'CglFdmFsU3RhdGUSKwoGdmFsdWVzGAEgAygLMhMuY2VsLmV4cHIuRXhwclZhbHVlUgZ2YWx1ZX'
    'MSNAoHcmVzdWx0cxgDIAMoCzIaLmNlbC5leHByLkV2YWxTdGF0ZS5SZXN1bHRSB3Jlc3VsdHMa'
    'MgoGUmVzdWx0EhIKBGV4cHIYASABKANSBGV4cHISFAoFdmFsdWUYAiABKANSBXZhbHVl');

@$core.Deprecated('Use exprValueDescriptor instead')
const ExprValue$json = {
  '1': 'ExprValue',
  '2': [
    {
      '1': 'value',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Value',
      '9': 0,
      '10': 'value'
    },
    {
      '1': 'error',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.ErrorSet',
      '9': 0,
      '10': 'error'
    },
    {
      '1': 'unknown',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.UnknownSet',
      '9': 0,
      '10': 'unknown'
    },
  ],
  '8': [
    {'1': 'kind'},
  ],
};

/// Descriptor for `ExprValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exprValueDescriptor = $convert.base64Decode(
    'CglFeHByVmFsdWUSJwoFdmFsdWUYASABKAsyDy5jZWwuZXhwci5WYWx1ZUgAUgV2YWx1ZRIqCg'
    'VlcnJvchgCIAEoCzISLmNlbC5leHByLkVycm9yU2V0SABSBWVycm9yEjAKB3Vua25vd24YAyAB'
    'KAsyFC5jZWwuZXhwci5Vbmtub3duU2V0SABSB3Vua25vd25CBgoEa2luZA==');

@$core.Deprecated('Use errorSetDescriptor instead')
const ErrorSet$json = {
  '1': 'ErrorSet',
  '2': [
    {
      '1': 'errors',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.Status',
      '10': 'errors'
    },
  ],
};

/// Descriptor for `ErrorSet`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List errorSetDescriptor = $convert.base64Decode(
    'CghFcnJvclNldBIoCgZlcnJvcnMYASADKAsyEC5jZWwuZXhwci5TdGF0dXNSBmVycm9ycw==');

@$core.Deprecated('Use statusDescriptor instead')
const Status$json = {
  '1': 'Status',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 5, '10': 'code'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {
      '1': 'details',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.Any',
      '10': 'details'
    },
  ],
};

/// Descriptor for `Status`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List statusDescriptor = $convert.base64Decode(
    'CgZTdGF0dXMSEgoEY29kZRgBIAEoBVIEY29kZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEi'
    '4KB2RldGFpbHMYAyADKAsyFC5nb29nbGUucHJvdG9idWYuQW55UgdkZXRhaWxz');

@$core.Deprecated('Use unknownSetDescriptor instead')
const UnknownSet$json = {
  '1': 'UnknownSet',
  '2': [
    {'1': 'exprs', '3': 1, '4': 3, '5': 3, '10': 'exprs'},
  ],
};

/// Descriptor for `UnknownSet`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unknownSetDescriptor =
    $convert.base64Decode('CgpVbmtub3duU2V0EhQKBWV4cHJzGAEgAygDUgVleHBycw==');
