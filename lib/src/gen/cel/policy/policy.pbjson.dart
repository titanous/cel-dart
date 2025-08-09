// This is a generated file - do not edit.
//
// Generated from cel/policy/policy.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use policySpecDescriptor instead')
const PolicySpec$json = {
  '1': 'PolicySpec',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'imports',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.cel.policy.PolicySpec.Import',
      '10': 'imports'
    },
    {
      '1': 'variables',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.cel.policy.PolicySpec.Variable',
      '10': 'variables'
    },
    {'1': 'output', '3': 4, '4': 1, '5': 9, '9': 0, '10': 'output', '17': true},
    {
      '1': 'description',
      '3': 5,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'description',
      '17': true
    },
    {
      '1': 'explanation',
      '3': 6,
      '4': 1,
      '5': 9,
      '9': 2,
      '10': 'explanation',
      '17': true
    },
    {
      '1': 'match',
      '3': 7,
      '4': 3,
      '5': 11,
      '6': '.cel.policy.PolicySpec.Match',
      '10': 'match'
    },
    {
      '1': 'rule',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.cel.policy.PolicySpec.Rule',
      '10': 'rule'
    },
  ],
  '3': [
    PolicySpec_Import$json,
    PolicySpec_Variable$json,
    PolicySpec_Rule$json,
    PolicySpec_Match$json
  ],
  '8': [
    {'1': '_output'},
    {'1': '_description'},
    {'1': '_explanation'},
  ],
};

@$core.Deprecated('Use policySpecDescriptor instead')
const PolicySpec_Import$json = {
  '1': 'Import',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

@$core.Deprecated('Use policySpecDescriptor instead')
const PolicySpec_Variable$json = {
  '1': 'Variable',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {'1': 'expression', '3': 3, '4': 1, '5': 9, '10': 'expression'},
  ],
};

@$core.Deprecated('Use policySpecDescriptor instead')
const PolicySpec_Rule$json = {
  '1': 'Rule',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'variables',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.cel.policy.PolicySpec.Variable',
      '10': 'variables'
    },
    {
      '1': 'match',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.cel.policy.PolicySpec.Match',
      '10': 'match'
    },
  ],
};

@$core.Deprecated('Use policySpecDescriptor instead')
const PolicySpec_Match$json = {
  '1': 'Match',
  '2': [
    {
      '1': 'condition',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'condition',
      '17': true
    },
    {'1': 'output', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'output'},
    {
      '1': 'rule',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.cel.policy.PolicySpec.Rule',
      '9': 0,
      '10': 'rule'
    },
    {'1': 'explanation', '3': 4, '4': 1, '5': 9, '10': 'explanation'},
  ],
  '8': [
    {'1': 'action'},
    {'1': '_condition'},
  ],
};

/// Descriptor for `PolicySpec`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List policySpecDescriptor = $convert.base64Decode(
    'CgpQb2xpY3lTcGVjEhIKBG5hbWUYASABKAlSBG5hbWUSNwoHaW1wb3J0cxgCIAMoCzIdLmNlbC'
    '5wb2xpY3kuUG9saWN5U3BlYy5JbXBvcnRSB2ltcG9ydHMSPQoJdmFyaWFibGVzGAMgAygLMh8u'
    'Y2VsLnBvbGljeS5Qb2xpY3lTcGVjLlZhcmlhYmxlUgl2YXJpYWJsZXMSGwoGb3V0cHV0GAQgAS'
    'gJSABSBm91dHB1dIgBARIlCgtkZXNjcmlwdGlvbhgFIAEoCUgBUgtkZXNjcmlwdGlvbogBARIl'
    'CgtleHBsYW5hdGlvbhgGIAEoCUgCUgtleHBsYW5hdGlvbogBARIyCgVtYXRjaBgHIAMoCzIcLm'
    'NlbC5wb2xpY3kuUG9saWN5U3BlYy5NYXRjaFIFbWF0Y2gSLwoEcnVsZRgIIAEoCzIbLmNlbC5w'
    'b2xpY3kuUG9saWN5U3BlYy5SdWxlUgRydWxlGhwKBkltcG9ydBISCgRuYW1lGAEgASgJUgRuYW'
    '1lGmAKCFZhcmlhYmxlEhIKBG5hbWUYASABKAlSBG5hbWUSIAoLZGVzY3JpcHRpb24YAiABKAlS'
    'C2Rlc2NyaXB0aW9uEh4KCmV4cHJlc3Npb24YAyABKAlSCmV4cHJlc3Npb24aqwEKBFJ1bGUSDg'
    'oCaWQYASABKAlSAmlkEiAKC2Rlc2NyaXB0aW9uGAIgASgJUgtkZXNjcmlwdGlvbhI9Cgl2YXJp'
    'YWJsZXMYAyADKAsyHy5jZWwucG9saWN5LlBvbGljeVNwZWMuVmFyaWFibGVSCXZhcmlhYmxlcx'
    'IyCgVtYXRjaBgEIAMoCzIcLmNlbC5wb2xpY3kuUG9saWN5U3BlYy5NYXRjaFIFbWF0Y2gasQEK'
    'BU1hdGNoEiEKCWNvbmRpdGlvbhgBIAEoCUgBUgljb25kaXRpb26IAQESGAoGb3V0cHV0GAIgAS'
    'gJSABSBm91dHB1dBIxCgRydWxlGAMgASgLMhsuY2VsLnBvbGljeS5Qb2xpY3lTcGVjLlJ1bGVI'
    'AFIEcnVsZRIgCgtleHBsYW5hdGlvbhgEIAEoCVILZXhwbGFuYXRpb25CCAoGYWN0aW9uQgwKCl'
    '9jb25kaXRpb25CCQoHX291dHB1dEIOCgxfZGVzY3JpcHRpb25CDgoMX2V4cGxhbmF0aW9u');
