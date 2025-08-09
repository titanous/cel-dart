// This is a generated file - do not edit.
//
// Generated from test/v1/simple.proto.

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
      '6': '.google.api.expr.test.v1.SimpleTestSection',
      '10': 'section'
    },
  ],
};

/// Descriptor for `SimpleTestFile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List simpleTestFileDescriptor = $convert.base64Decode(
    'Cg5TaW1wbGVUZXN0RmlsZRISCgRuYW1lGAEgASgJUgRuYW1lEiAKC2Rlc2NyaXB0aW9uGAIgAS'
    'gJUgtkZXNjcmlwdGlvbhJECgdzZWN0aW9uGAMgAygLMiouZ29vZ2xlLmFwaS5leHByLnRlc3Qu'
    'djEuU2ltcGxlVGVzdFNlY3Rpb25SB3NlY3Rpb24=');

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
      '6': '.google.api.expr.test.v1.SimpleTest',
      '10': 'test'
    },
  ],
};

/// Descriptor for `SimpleTestSection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List simpleTestSectionDescriptor = $convert.base64Decode(
    'ChFTaW1wbGVUZXN0U2VjdGlvbhISCgRuYW1lGAEgASgJUgRuYW1lEiAKC2Rlc2NyaXB0aW9uGA'
    'IgASgJUgtkZXNjcmlwdGlvbhI3CgR0ZXN0GAMgAygLMiMuZ29vZ2xlLmFwaS5leHByLnRlc3Qu'
    'djEuU2ltcGxlVGVzdFIEdGVzdA==');

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
      '6': '.google.api.expr.v1alpha1.Decl',
      '10': 'typeEnv'
    },
    {'1': 'container', '3': 13, '4': 1, '5': 9, '10': 'container'},
    {
      '1': 'bindings',
      '3': 7,
      '4': 3,
      '5': 11,
      '6': '.google.api.expr.test.v1.SimpleTest.BindingsEntry',
      '10': 'bindings'
    },
    {
      '1': 'value',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1alpha1.Value',
      '9': 0,
      '10': 'value'
    },
    {
      '1': 'typed_result',
      '3': 16,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.test.v1.TypedResult',
      '9': 0,
      '10': 'typedResult'
    },
    {
      '1': 'eval_error',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1alpha1.ErrorSet',
      '9': 0,
      '10': 'evalError'
    },
    {
      '1': 'any_eval_errors',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.test.v1.ErrorSetMatcher',
      '9': 0,
      '10': 'anyEvalErrors'
    },
    {
      '1': 'unknown',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1alpha1.UnknownSet',
      '9': 0,
      '10': 'unknown'
    },
    {
      '1': 'any_unknowns',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.test.v1.UnknownSetMatcher',
      '9': 0,
      '10': 'anyUnknowns'
    },
  ],
  '3': [SimpleTest_BindingsEntry$json],
  '8': [
    {'1': 'result_matcher'},
  ],
  '9': [
    {'1': 14, '2': 15},
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
      '6': '.google.api.expr.v1alpha1.ExprValue',
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
    'NoZWNrX29ubHkYDyABKAhSCWNoZWNrT25seRI5Cgh0eXBlX2VudhgGIAMoCzIeLmdvb2dsZS5h'
    'cGkuZXhwci52MWFscGhhMS5EZWNsUgd0eXBlRW52EhwKCWNvbnRhaW5lchgNIAEoCVIJY29udG'
    'FpbmVyEk0KCGJpbmRpbmdzGAcgAygLMjEuZ29vZ2xlLmFwaS5leHByLnRlc3QudjEuU2ltcGxl'
    'VGVzdC5CaW5kaW5nc0VudHJ5UghiaW5kaW5ncxI3CgV2YWx1ZRgIIAEoCzIfLmdvb2dsZS5hcG'
    'kuZXhwci52MWFscGhhMS5WYWx1ZUgAUgV2YWx1ZRJJCgx0eXBlZF9yZXN1bHQYECABKAsyJC5n'
    'b29nbGUuYXBpLmV4cHIudGVzdC52MS5UeXBlZFJlc3VsdEgAUgt0eXBlZFJlc3VsdBJDCgpldm'
    'FsX2Vycm9yGAkgASgLMiIuZ29vZ2xlLmFwaS5leHByLnYxYWxwaGExLkVycm9yU2V0SABSCWV2'
    'YWxFcnJvchJSCg9hbnlfZXZhbF9lcnJvcnMYCiABKAsyKC5nb29nbGUuYXBpLmV4cHIudGVzdC'
    '52MS5FcnJvclNldE1hdGNoZXJIAFINYW55RXZhbEVycm9ycxJACgd1bmtub3duGAsgASgLMiQu'
    'Z29vZ2xlLmFwaS5leHByLnYxYWxwaGExLlVua25vd25TZXRIAFIHdW5rbm93bhJPCgxhbnlfdW'
    '5rbm93bnMYDCABKAsyKi5nb29nbGUuYXBpLmV4cHIudGVzdC52MS5Vbmtub3duU2V0TWF0Y2hl'
    'ckgAUgthbnlVbmtub3ducxpgCg1CaW5kaW5nc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EjkKBX'
    'ZhbHVlGAIgASgLMiMuZ29vZ2xlLmFwaS5leHByLnYxYWxwaGExLkV4cHJWYWx1ZVIFdmFsdWU6'
    'AjgBQhAKDnJlc3VsdF9tYXRjaGVySgQIDhAP');

@$core.Deprecated('Use typedResultDescriptor instead')
const TypedResult$json = {
  '1': 'TypedResult',
  '2': [
    {
      '1': 'result',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1alpha1.Value',
      '10': 'result'
    },
    {
      '1': 'deduced_type',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.api.expr.v1alpha1.Type',
      '10': 'deducedType'
    },
  ],
};

/// Descriptor for `TypedResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List typedResultDescriptor = $convert.base64Decode(
    'CgtUeXBlZFJlc3VsdBI3CgZyZXN1bHQYASABKAsyHy5nb29nbGUuYXBpLmV4cHIudjFhbHBoYT'
    'EuVmFsdWVSBnJlc3VsdBJBCgxkZWR1Y2VkX3R5cGUYAiABKAsyHi5nb29nbGUuYXBpLmV4cHIu'
    'djFhbHBoYTEuVHlwZVILZGVkdWNlZFR5cGU=');

@$core.Deprecated('Use errorSetMatcherDescriptor instead')
const ErrorSetMatcher$json = {
  '1': 'ErrorSetMatcher',
  '2': [
    {
      '1': 'errors',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.api.expr.v1alpha1.ErrorSet',
      '10': 'errors'
    },
  ],
};

/// Descriptor for `ErrorSetMatcher`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List errorSetMatcherDescriptor = $convert.base64Decode(
    'Cg9FcnJvclNldE1hdGNoZXISOgoGZXJyb3JzGAEgAygLMiIuZ29vZ2xlLmFwaS5leHByLnYxYW'
    'xwaGExLkVycm9yU2V0UgZlcnJvcnM=');

@$core.Deprecated('Use unknownSetMatcherDescriptor instead')
const UnknownSetMatcher$json = {
  '1': 'UnknownSetMatcher',
  '2': [
    {
      '1': 'unknowns',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.api.expr.v1alpha1.UnknownSet',
      '10': 'unknowns'
    },
  ],
};

/// Descriptor for `UnknownSetMatcher`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unknownSetMatcherDescriptor = $convert.base64Decode(
    'ChFVbmtub3duU2V0TWF0Y2hlchJACgh1bmtub3ducxgBIAMoCzIkLmdvb2dsZS5hcGkuZXhwci'
    '52MWFscGhhMS5Vbmtub3duU2V0Ugh1bmtub3ducw==');
