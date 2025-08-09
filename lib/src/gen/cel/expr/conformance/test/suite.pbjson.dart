// This is a generated file - do not edit.
//
// Generated from cel/expr/conformance/test/suite.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use testSuiteDescriptor instead')
const TestSuite$json = {
  '1': 'TestSuite',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'sections',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.conformance.test.TestSection',
      '10': 'sections'
    },
  ],
};

/// Descriptor for `TestSuite`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List testSuiteDescriptor = $convert.base64Decode(
    'CglUZXN0U3VpdGUSEgoEbmFtZRgBIAEoCVIEbmFtZRIgCgtkZXNjcmlwdGlvbhgCIAEoCVILZG'
    'VzY3JpcHRpb24SQgoIc2VjdGlvbnMYAyADKAsyJi5jZWwuZXhwci5jb25mb3JtYW5jZS50ZXN0'
    'LlRlc3RTZWN0aW9uUghzZWN0aW9ucw==');

@$core.Deprecated('Use testSectionDescriptor instead')
const TestSection$json = {
  '1': 'TestSection',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'tests',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.conformance.test.TestCase',
      '10': 'tests'
    },
  ],
};

/// Descriptor for `TestSection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List testSectionDescriptor = $convert.base64Decode(
    'CgtUZXN0U2VjdGlvbhISCgRuYW1lGAEgASgJUgRuYW1lEiAKC2Rlc2NyaXB0aW9uGAIgASgJUg'
    'tkZXNjcmlwdGlvbhI5CgV0ZXN0cxgDIAMoCzIjLmNlbC5leHByLmNvbmZvcm1hbmNlLnRlc3Qu'
    'VGVzdENhc2VSBXRlc3Rz');

@$core.Deprecated('Use testCaseDescriptor instead')
const TestCase$json = {
  '1': 'TestCase',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {'1': 'expr', '3': 3, '4': 1, '5': 9, '10': 'expr'},
    {
      '1': 'env',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.conformance.Environment',
      '10': 'env'
    },
    {
      '1': 'input',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.conformance.test.TestCase.InputEntry',
      '10': 'input'
    },
    {
      '1': 'input_context',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.conformance.test.InputContext',
      '10': 'inputContext'
    },
    {
      '1': 'output',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.conformance.test.TestOutput',
      '10': 'output'
    },
    {
      '1': 'deduced_type',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Type',
      '10': 'deducedType'
    },
    {'1': 'disable_check', '3': 9, '4': 1, '5': 8, '10': 'disableCheck'},
  ],
  '3': [TestCase_InputEntry$json],
};

@$core.Deprecated('Use testCaseDescriptor instead')
const TestCase_InputEntry$json = {
  '1': 'InputEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.conformance.test.InputValue',
      '10': 'value'
    },
  ],
  '7': {'7': true},
};

/// Descriptor for `TestCase`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List testCaseDescriptor = $convert.base64Decode(
    'CghUZXN0Q2FzZRISCgRuYW1lGAEgASgJUgRuYW1lEiAKC2Rlc2NyaXB0aW9uGAIgASgJUgtkZX'
    'NjcmlwdGlvbhISCgRleHByGAMgASgJUgRleHByEjMKA2VudhgEIAEoCzIhLmNlbC5leHByLmNv'
    'bmZvcm1hbmNlLkVudmlyb25tZW50UgNlbnYSRAoFaW5wdXQYBSADKAsyLi5jZWwuZXhwci5jb2'
    '5mb3JtYW5jZS50ZXN0LlRlc3RDYXNlLklucHV0RW50cnlSBWlucHV0EkwKDWlucHV0X2NvbnRl'
    'eHQYBiABKAsyJy5jZWwuZXhwci5jb25mb3JtYW5jZS50ZXN0LklucHV0Q29udGV4dFIMaW5wdX'
    'RDb250ZXh0Ej0KBm91dHB1dBgHIAEoCzIlLmNlbC5leHByLmNvbmZvcm1hbmNlLnRlc3QuVGVz'
    'dE91dHB1dFIGb3V0cHV0EjEKDGRlZHVjZWRfdHlwZRgIIAEoCzIOLmNlbC5leHByLlR5cGVSC2'
    'RlZHVjZWRUeXBlEiMKDWRpc2FibGVfY2hlY2sYCSABKAhSDGRpc2FibGVDaGVjaxpfCgpJbnB1'
    'dEVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EjsKBXZhbHVlGAIgASgLMiUuY2VsLmV4cHIuY29uZm'
    '9ybWFuY2UudGVzdC5JbnB1dFZhbHVlUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use inputContextDescriptor instead')
const InputContext$json = {
  '1': 'InputContext',
  '2': [
    {
      '1': 'context_message',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Any',
      '9': 0,
      '10': 'contextMessage'
    },
    {'1': 'context_expr', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'contextExpr'},
  ],
  '8': [
    {'1': 'input_context_kind'},
  ],
};

/// Descriptor for `InputContext`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inputContextDescriptor = $convert.base64Decode(
    'CgxJbnB1dENvbnRleHQSPwoPY29udGV4dF9tZXNzYWdlGAEgASgLMhQuZ29vZ2xlLnByb3RvYn'
    'VmLkFueUgAUg5jb250ZXh0TWVzc2FnZRIjCgxjb250ZXh0X2V4cHIYAiABKAlIAFILY29udGV4'
    'dEV4cHJCFAoSaW5wdXRfY29udGV4dF9raW5k');

@$core.Deprecated('Use inputValueDescriptor instead')
const InputValue$json = {
  '1': 'InputValue',
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
    {'1': 'expr', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'expr'},
  ],
  '8': [
    {'1': 'kind'},
  ],
};

/// Descriptor for `InputValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inputValueDescriptor = $convert.base64Decode(
    'CgpJbnB1dFZhbHVlEicKBXZhbHVlGAEgASgLMg8uY2VsLmV4cHIuVmFsdWVIAFIFdmFsdWUSFA'
    'oEZXhwchgCIAEoCUgAUgRleHByQgYKBGtpbmQ=');

@$core.Deprecated('Use testOutputDescriptor instead')
const TestOutput$json = {
  '1': 'TestOutput',
  '2': [
    {
      '1': 'result_value',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Value',
      '9': 0,
      '10': 'resultValue'
    },
    {'1': 'result_expr', '3': 9, '4': 1, '5': 9, '9': 0, '10': 'resultExpr'},
    {
      '1': 'eval_error',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.ErrorSet',
      '9': 0,
      '10': 'evalError'
    },
    {
      '1': 'unknown',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.UnknownSet',
      '9': 0,
      '10': 'unknown'
    },
  ],
  '8': [
    {'1': 'result_kind'},
  ],
};

/// Descriptor for `TestOutput`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List testOutputDescriptor = $convert.base64Decode(
    'CgpUZXN0T3V0cHV0EjQKDHJlc3VsdF92YWx1ZRgIIAEoCzIPLmNlbC5leHByLlZhbHVlSABSC3'
    'Jlc3VsdFZhbHVlEiEKC3Jlc3VsdF9leHByGAkgASgJSABSCnJlc3VsdEV4cHISMwoKZXZhbF9l'
    'cnJvchgKIAEoCzISLmNlbC5leHByLkVycm9yU2V0SABSCWV2YWxFcnJvchIwCgd1bmtub3duGA'
    'sgASgLMhQuY2VsLmV4cHIuVW5rbm93blNldEgAUgd1bmtub3duQg0KC3Jlc3VsdF9raW5k');
