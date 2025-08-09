// This is a generated file - do not edit.
//
// Generated from cel/expr/conformance/test/simple.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use simpleTestFileDescriptor instead')
const SimpleTestFile$json = {
  '1': 'SimpleTestFile',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'section',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.conformance.test.SimpleTestSection',
      '10': 'section'
    },
  ],
};

/// Descriptor for `SimpleTestFile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List simpleTestFileDescriptor = $convert.base64Decode(
    'Cg5TaW1wbGVUZXN0RmlsZRISCgRuYW1lGAEgASgJUgRuYW1lEiAKC2Rlc2NyaXB0aW9uGAIgAS'
    'gJUgtkZXNjcmlwdGlvbhJGCgdzZWN0aW9uGAMgAygLMiwuY2VsLmV4cHIuY29uZm9ybWFuY2Uu'
    'dGVzdC5TaW1wbGVUZXN0U2VjdGlvblIHc2VjdGlvbg==');

@$core.Deprecated('Use simpleTestSectionDescriptor instead')
const SimpleTestSection$json = {
  '1': 'SimpleTestSection',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'test',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.conformance.test.SimpleTest',
      '10': 'test'
    },
  ],
};

/// Descriptor for `SimpleTestSection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List simpleTestSectionDescriptor = $convert.base64Decode(
    'ChFTaW1wbGVUZXN0U2VjdGlvbhISCgRuYW1lGAEgASgJUgRuYW1lEiAKC2Rlc2NyaXB0aW9uGA'
    'IgASgJUgtkZXNjcmlwdGlvbhI5CgR0ZXN0GAMgAygLMiUuY2VsLmV4cHIuY29uZm9ybWFuY2Uu'
    'dGVzdC5TaW1wbGVUZXN0UgR0ZXN0');

@$core.Deprecated('Use simpleTestDescriptor instead')
const SimpleTest$json = {
  '1': 'SimpleTest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {'1': 'expr', '3': 3, '4': 1, '5': 9, '10': 'expr'},
    {'1': 'disable_macros', '3': 4, '4': 1, '5': 8, '10': 'disableMacros'},
    {'1': 'disable_check', '3': 5, '4': 1, '5': 8, '10': 'disableCheck'},
    {'1': 'check_only', '3': 15, '4': 1, '5': 8, '10': 'checkOnly'},
    {
      '1': 'type_env',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.Decl',
      '10': 'typeEnv'
    },
    {'1': 'container', '3': 13, '4': 1, '5': 9, '10': 'container'},
    {'1': 'locale', '3': 14, '4': 1, '5': 9, '10': 'locale'},
    {
      '1': 'bindings',
      '3': 7,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.conformance.test.SimpleTest.BindingsEntry',
      '10': 'bindings'
    },
    {
      '1': 'value',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Value',
      '9': 0,
      '10': 'value'
    },
    {
      '1': 'typed_result',
      '3': 16,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.conformance.test.TypedResult',
      '9': 0,
      '10': 'typedResult'
    },
    {
      '1': 'eval_error',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.ErrorSet',
      '9': 0,
      '10': 'evalError'
    },
    {
      '1': 'any_eval_errors',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.conformance.test.ErrorSetMatcher',
      '9': 0,
      '10': 'anyEvalErrors'
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
    {
      '1': 'any_unknowns',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.conformance.test.UnknownSetMatcher',
      '9': 0,
      '10': 'anyUnknowns'
    },
  ],
  '3': [SimpleTest_BindingsEntry$json],
  '8': [
    {'1': 'result_matcher'},
  ],
};

@$core.Deprecated('Use simpleTestDescriptor instead')
const SimpleTest_BindingsEntry$json = {
  '1': 'BindingsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.ExprValue',
      '10': 'value'
    },
  ],
  '7': {'7': true},
};

/// Descriptor for `SimpleTest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List simpleTestDescriptor = $convert.base64Decode(
    'CgpTaW1wbGVUZXN0EhIKBG5hbWUYASABKAlSBG5hbWUSIAoLZGVzY3JpcHRpb24YAiABKAlSC2'
    'Rlc2NyaXB0aW9uEhIKBGV4cHIYAyABKAlSBGV4cHISJQoOZGlzYWJsZV9tYWNyb3MYBCABKAhS'
    'DWRpc2FibGVNYWNyb3MSIwoNZGlzYWJsZV9jaGVjaxgFIAEoCFIMZGlzYWJsZUNoZWNrEh0KCm'
    'NoZWNrX29ubHkYDyABKAhSCWNoZWNrT25seRIpCgh0eXBlX2VudhgGIAMoCzIOLmNlbC5leHBy'
    'LkRlY2xSB3R5cGVFbnYSHAoJY29udGFpbmVyGA0gASgJUgljb250YWluZXISFgoGbG9jYWxlGA'
    '4gASgJUgZsb2NhbGUSTwoIYmluZGluZ3MYByADKAsyMy5jZWwuZXhwci5jb25mb3JtYW5jZS50'
    'ZXN0LlNpbXBsZVRlc3QuQmluZGluZ3NFbnRyeVIIYmluZGluZ3MSJwoFdmFsdWUYCCABKAsyDy'
    '5jZWwuZXhwci5WYWx1ZUgAUgV2YWx1ZRJLCgx0eXBlZF9yZXN1bHQYECABKAsyJi5jZWwuZXhw'
    'ci5jb25mb3JtYW5jZS50ZXN0LlR5cGVkUmVzdWx0SABSC3R5cGVkUmVzdWx0EjMKCmV2YWxfZX'
    'Jyb3IYCSABKAsyEi5jZWwuZXhwci5FcnJvclNldEgAUglldmFsRXJyb3ISVAoPYW55X2V2YWxf'
    'ZXJyb3JzGAogASgLMiouY2VsLmV4cHIuY29uZm9ybWFuY2UudGVzdC5FcnJvclNldE1hdGNoZX'
    'JIAFINYW55RXZhbEVycm9ycxIwCgd1bmtub3duGAsgASgLMhQuY2VsLmV4cHIuVW5rbm93blNl'
    'dEgAUgd1bmtub3duElEKDGFueV91bmtub3ducxgMIAEoCzIsLmNlbC5leHByLmNvbmZvcm1hbm'
    'NlLnRlc3QuVW5rbm93blNldE1hdGNoZXJIAFILYW55VW5rbm93bnMaUAoNQmluZGluZ3NFbnRy'
    'eRIQCgNrZXkYASABKAlSA2tleRIpCgV2YWx1ZRgCIAEoCzITLmNlbC5leHByLkV4cHJWYWx1ZV'
    'IFdmFsdWU6AjgBQhAKDnJlc3VsdF9tYXRjaGVy');

@$core.Deprecated('Use typedResultDescriptor instead')
const TypedResult$json = {
  '1': 'TypedResult',
  '2': [
    {
      '1': 'result',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Value',
      '10': 'result'
    },
    {
      '1': 'deduced_type',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Type',
      '10': 'deducedType'
    },
  ],
};

/// Descriptor for `TypedResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List typedResultDescriptor = $convert.base64Decode(
    'CgtUeXBlZFJlc3VsdBInCgZyZXN1bHQYASABKAsyDy5jZWwuZXhwci5WYWx1ZVIGcmVzdWx0Ej'
    'EKDGRlZHVjZWRfdHlwZRgCIAEoCzIOLmNlbC5leHByLlR5cGVSC2RlZHVjZWRUeXBl');

@$core.Deprecated('Use errorSetMatcherDescriptor instead')
const ErrorSetMatcher$json = {
  '1': 'ErrorSetMatcher',
  '2': [
    {
      '1': 'errors',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.ErrorSet',
      '10': 'errors'
    },
  ],
};

/// Descriptor for `ErrorSetMatcher`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List errorSetMatcherDescriptor = $convert.base64Decode(
    'Cg9FcnJvclNldE1hdGNoZXISKgoGZXJyb3JzGAEgAygLMhIuY2VsLmV4cHIuRXJyb3JTZXRSBm'
    'Vycm9ycw==');

@$core.Deprecated('Use unknownSetMatcherDescriptor instead')
const UnknownSetMatcher$json = {
  '1': 'UnknownSetMatcher',
  '2': [
    {
      '1': 'unknowns',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.UnknownSet',
      '10': 'unknowns'
    },
  ],
};

/// Descriptor for `UnknownSetMatcher`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unknownSetMatcherDescriptor = $convert.base64Decode(
    'ChFVbmtub3duU2V0TWF0Y2hlchIwCgh1bmtub3ducxgBIAMoCzIULmNlbC5leHByLlVua25vd2'
    '5TZXRSCHVua25vd25z');
