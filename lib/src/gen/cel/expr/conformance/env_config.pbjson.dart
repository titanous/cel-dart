// This is a generated file - do not edit.
//
// Generated from cel/expr/conformance/env_config.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use environmentDescriptor instead')
const Environment$json = {
  '1': 'Environment',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {'1': 'container', '3': 3, '4': 1, '5': 9, '10': 'container'},
    {
      '1': 'imports',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.conformance.Environment.Import',
      '10': 'imports'
    },
    {
      '1': 'stdlib',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.conformance.LibrarySubset',
      '10': 'stdlib'
    },
    {
      '1': 'extensions',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.conformance.Extension',
      '10': 'extensions'
    },
    {
      '1': 'context_variable',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.conformance.Environment.ContextVariable',
      '10': 'contextVariable'
    },
    {
      '1': 'declarations',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.Decl',
      '10': 'declarations'
    },
    {
      '1': 'validators',
      '3': 9,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.conformance.Validator',
      '10': 'validators'
    },
    {
      '1': 'features',
      '3': 10,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.conformance.Feature',
      '10': 'features'
    },
    {
      '1': 'disable_standard_cel_declarations',
      '3': 11,
      '4': 1,
      '5': 8,
      '10': 'disableStandardCelDeclarations'
    },
    {
      '1': 'message_type_extension',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.FileDescriptorSet',
      '10': 'messageTypeExtension'
    },
    {
      '1': 'enable_macro_call_tracking',
      '3': 13,
      '4': 1,
      '5': 8,
      '10': 'enableMacroCallTracking'
    },
  ],
  '3': [Environment_Import$json, Environment_ContextVariable$json],
};

@$core.Deprecated('Use environmentDescriptor instead')
const Environment_Import$json = {
  '1': 'Import',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

@$core.Deprecated('Use environmentDescriptor instead')
const Environment_ContextVariable$json = {
  '1': 'ContextVariable',
  '2': [
    {'1': 'type_name', '3': 1, '4': 1, '5': 9, '10': 'typeName'},
  ],
};

/// Descriptor for `Environment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List environmentDescriptor = $convert.base64Decode(
    'CgtFbnZpcm9ubWVudBISCgRuYW1lGAEgASgJUgRuYW1lEiAKC2Rlc2NyaXB0aW9uGAIgASgJUg'
    'tkZXNjcmlwdGlvbhIcCgljb250YWluZXIYAyABKAlSCWNvbnRhaW5lchJCCgdpbXBvcnRzGAQg'
    'AygLMiguY2VsLmV4cHIuY29uZm9ybWFuY2UuRW52aXJvbm1lbnQuSW1wb3J0UgdpbXBvcnRzEj'
    'sKBnN0ZGxpYhgFIAEoCzIjLmNlbC5leHByLmNvbmZvcm1hbmNlLkxpYnJhcnlTdWJzZXRSBnN0'
    'ZGxpYhI/CgpleHRlbnNpb25zGAYgAygLMh8uY2VsLmV4cHIuY29uZm9ybWFuY2UuRXh0ZW5zaW'
    '9uUgpleHRlbnNpb25zElwKEGNvbnRleHRfdmFyaWFibGUYByABKAsyMS5jZWwuZXhwci5jb25m'
    'b3JtYW5jZS5FbnZpcm9ubWVudC5Db250ZXh0VmFyaWFibGVSD2NvbnRleHRWYXJpYWJsZRIyCg'
    'xkZWNsYXJhdGlvbnMYCCADKAsyDi5jZWwuZXhwci5EZWNsUgxkZWNsYXJhdGlvbnMSPwoKdmFs'
    'aWRhdG9ycxgJIAMoCzIfLmNlbC5leHByLmNvbmZvcm1hbmNlLlZhbGlkYXRvclIKdmFsaWRhdG'
    '9ycxI5CghmZWF0dXJlcxgKIAMoCzIdLmNlbC5leHByLmNvbmZvcm1hbmNlLkZlYXR1cmVSCGZl'
    'YXR1cmVzEkkKIWRpc2FibGVfc3RhbmRhcmRfY2VsX2RlY2xhcmF0aW9ucxgLIAEoCFIeZGlzYW'
    'JsZVN0YW5kYXJkQ2VsRGVjbGFyYXRpb25zElgKFm1lc3NhZ2VfdHlwZV9leHRlbnNpb24YDCAB'
    'KAsyIi5nb29nbGUucHJvdG9idWYuRmlsZURlc2NyaXB0b3JTZXRSFG1lc3NhZ2VUeXBlRXh0ZW'
    '5zaW9uEjsKGmVuYWJsZV9tYWNyb19jYWxsX3RyYWNraW5nGA0gASgIUhdlbmFibGVNYWNyb0Nh'
    'bGxUcmFja2luZxocCgZJbXBvcnQSEgoEbmFtZRgBIAEoCVIEbmFtZRouCg9Db250ZXh0VmFyaW'
    'FibGUSGwoJdHlwZV9uYW1lGAEgASgJUgh0eXBlTmFtZQ==');

@$core.Deprecated('Use validatorDescriptor instead')
const Validator$json = {
  '1': 'Validator',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'config',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.conformance.Validator.ConfigEntry',
      '10': 'config'
    },
  ],
  '3': [Validator_ConfigEntry$json],
};

@$core.Deprecated('Use validatorDescriptor instead')
const Validator_ConfigEntry$json = {
  '1': 'ConfigEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Value',
      '10': 'value'
    },
  ],
  '7': {'7': true},
};

/// Descriptor for `Validator`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validatorDescriptor = $convert.base64Decode(
    'CglWYWxpZGF0b3ISEgoEbmFtZRgBIAEoCVIEbmFtZRJDCgZjb25maWcYAiADKAsyKy5jZWwuZX'
    'hwci5jb25mb3JtYW5jZS5WYWxpZGF0b3IuQ29uZmlnRW50cnlSBmNvbmZpZxpRCgtDb25maWdF'
    'bnRyeRIQCgNrZXkYASABKAlSA2tleRIsCgV2YWx1ZRgCIAEoCzIWLmdvb2dsZS5wcm90b2J1Zi'
    '5WYWx1ZVIFdmFsdWU6AjgB');

@$core.Deprecated('Use featureDescriptor instead')
const Feature$json = {
  '1': 'Feature',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'enabled', '3': 2, '4': 1, '5': 8, '10': 'enabled'},
  ],
};

/// Descriptor for `Feature`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List featureDescriptor = $convert.base64Decode(
    'CgdGZWF0dXJlEhIKBG5hbWUYASABKAlSBG5hbWUSGAoHZW5hYmxlZBgCIAEoCFIHZW5hYmxlZA'
    '==');

@$core.Deprecated('Use extensionDescriptor instead')
const Extension$json = {
  '1': 'Extension',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'version', '3': 2, '4': 1, '5': 9, '10': 'version'},
  ],
};

/// Descriptor for `Extension`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List extensionDescriptor = $convert.base64Decode(
    'CglFeHRlbnNpb24SEgoEbmFtZRgBIAEoCVIEbmFtZRIYCgd2ZXJzaW9uGAIgASgJUgd2ZXJzaW'
    '9u');

@$core.Deprecated('Use librarySubsetDescriptor instead')
const LibrarySubset$json = {
  '1': 'LibrarySubset',
  '2': [
    {'1': 'disabled', '3': 1, '4': 1, '5': 8, '10': 'disabled'},
    {'1': 'disable_macros', '3': 2, '4': 1, '5': 8, '10': 'disableMacros'},
    {'1': 'include_macros', '3': 3, '4': 3, '5': 9, '10': 'includeMacros'},
    {'1': 'exclude_macros', '3': 4, '4': 3, '5': 9, '10': 'excludeMacros'},
    {
      '1': 'include_functions',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.Decl',
      '10': 'includeFunctions'
    },
    {
      '1': 'exclude_functions',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.Decl',
      '10': 'excludeFunctions'
    },
  ],
};

/// Descriptor for `LibrarySubset`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List librarySubsetDescriptor = $convert.base64Decode(
    'Cg1MaWJyYXJ5U3Vic2V0EhoKCGRpc2FibGVkGAEgASgIUghkaXNhYmxlZBIlCg5kaXNhYmxlX2'
    '1hY3JvcxgCIAEoCFINZGlzYWJsZU1hY3JvcxIlCg5pbmNsdWRlX21hY3JvcxgDIAMoCVINaW5j'
    'bHVkZU1hY3JvcxIlCg5leGNsdWRlX21hY3JvcxgEIAMoCVINZXhjbHVkZU1hY3JvcxI7ChFpbm'
    'NsdWRlX2Z1bmN0aW9ucxgFIAMoCzIOLmNlbC5leHByLkRlY2xSEGluY2x1ZGVGdW5jdGlvbnMS'
    'OwoRZXhjbHVkZV9mdW5jdGlvbnMYBiADKAsyDi5jZWwuZXhwci5EZWNsUhBleGNsdWRlRnVuY3'
    'Rpb25z');
