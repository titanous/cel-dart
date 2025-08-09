// This is a generated file - do not edit.
//
// Generated from cel/expr/checked.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use checkedExprDescriptor instead')
const CheckedExpr$json = {
  '1': 'CheckedExpr',
  '2': [
    {
      '1': 'reference_map',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.CheckedExpr.ReferenceMapEntry',
      '10': 'referenceMap'
    },
    {
      '1': 'type_map',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.CheckedExpr.TypeMapEntry',
      '10': 'typeMap'
    },
    {
      '1': 'source_info',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.SourceInfo',
      '10': 'sourceInfo'
    },
    {'1': 'expr_version', '3': 6, '4': 1, '5': 9, '10': 'exprVersion'},
    {'1': 'expr', '3': 4, '4': 1, '5': 11, '6': '.cel.expr.Expr', '10': 'expr'},
  ],
  '3': [CheckedExpr_ReferenceMapEntry$json, CheckedExpr_TypeMapEntry$json],
};

@$core.Deprecated('Use checkedExprDescriptor instead')
const CheckedExpr_ReferenceMapEntry$json = {
  '1': 'ReferenceMapEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 3, '10': 'key'},
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Reference',
      '10': 'value'
    },
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use checkedExprDescriptor instead')
const CheckedExpr_TypeMapEntry$json = {
  '1': 'TypeMapEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 3, '10': 'key'},
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Type',
      '10': 'value'
    },
  ],
  '7': {'7': true},
};

/// Descriptor for `CheckedExpr`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkedExprDescriptor = $convert.base64Decode(
    'CgtDaGVja2VkRXhwchJMCg1yZWZlcmVuY2VfbWFwGAIgAygLMicuY2VsLmV4cHIuQ2hlY2tlZE'
    'V4cHIuUmVmZXJlbmNlTWFwRW50cnlSDHJlZmVyZW5jZU1hcBI9Cgh0eXBlX21hcBgDIAMoCzIi'
    'LmNlbC5leHByLkNoZWNrZWRFeHByLlR5cGVNYXBFbnRyeVIHdHlwZU1hcBI1Cgtzb3VyY2VfaW'
    '5mbxgFIAEoCzIULmNlbC5leHByLlNvdXJjZUluZm9SCnNvdXJjZUluZm8SIQoMZXhwcl92ZXJz'
    'aW9uGAYgASgJUgtleHByVmVyc2lvbhIiCgRleHByGAQgASgLMg4uY2VsLmV4cHIuRXhwclIEZX'
    'hwchpUChFSZWZlcmVuY2VNYXBFbnRyeRIQCgNrZXkYASABKANSA2tleRIpCgV2YWx1ZRgCIAEo'
    'CzITLmNlbC5leHByLlJlZmVyZW5jZVIFdmFsdWU6AjgBGkoKDFR5cGVNYXBFbnRyeRIQCgNrZX'
    'kYASABKANSA2tleRIkCgV2YWx1ZRgCIAEoCzIOLmNlbC5leHByLlR5cGVSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use typeDescriptor instead')
const Type$json = {
  '1': 'Type',
  '2': [
    {
      '1': 'dyn',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Empty',
      '9': 0,
      '10': 'dyn'
    },
    {
      '1': 'null',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.google.protobuf.NullValue',
      '9': 0,
      '10': 'null'
    },
    {
      '1': 'primitive',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.cel.expr.Type.PrimitiveType',
      '9': 0,
      '10': 'primitive'
    },
    {
      '1': 'wrapper',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.cel.expr.Type.PrimitiveType',
      '9': 0,
      '10': 'wrapper'
    },
    {
      '1': 'well_known',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.cel.expr.Type.WellKnownType',
      '9': 0,
      '10': 'wellKnown'
    },
    {
      '1': 'list_type',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Type.ListType',
      '9': 0,
      '10': 'listType'
    },
    {
      '1': 'map_type',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Type.MapType',
      '9': 0,
      '10': 'mapType'
    },
    {
      '1': 'function',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Type.FunctionType',
      '9': 0,
      '10': 'function'
    },
    {'1': 'message_type', '3': 9, '4': 1, '5': 9, '9': 0, '10': 'messageType'},
    {'1': 'type_param', '3': 10, '4': 1, '5': 9, '9': 0, '10': 'typeParam'},
    {
      '1': 'type',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Type',
      '9': 0,
      '10': 'type'
    },
    {
      '1': 'error',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Empty',
      '9': 0,
      '10': 'error'
    },
    {
      '1': 'abstract_type',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Type.AbstractType',
      '9': 0,
      '10': 'abstractType'
    },
  ],
  '3': [
    Type_ListType$json,
    Type_MapType$json,
    Type_FunctionType$json,
    Type_AbstractType$json
  ],
  '4': [Type_PrimitiveType$json, Type_WellKnownType$json],
  '8': [
    {'1': 'type_kind'},
  ],
};

@$core.Deprecated('Use typeDescriptor instead')
const Type_ListType$json = {
  '1': 'ListType',
  '2': [
    {
      '1': 'elem_type',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Type',
      '10': 'elemType'
    },
  ],
};

@$core.Deprecated('Use typeDescriptor instead')
const Type_MapType$json = {
  '1': 'MapType',
  '2': [
    {
      '1': 'key_type',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Type',
      '10': 'keyType'
    },
    {
      '1': 'value_type',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Type',
      '10': 'valueType'
    },
  ],
};

@$core.Deprecated('Use typeDescriptor instead')
const Type_FunctionType$json = {
  '1': 'FunctionType',
  '2': [
    {
      '1': 'result_type',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Type',
      '10': 'resultType'
    },
    {
      '1': 'arg_types',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.Type',
      '10': 'argTypes'
    },
  ],
};

@$core.Deprecated('Use typeDescriptor instead')
const Type_AbstractType$json = {
  '1': 'AbstractType',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'parameter_types',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.Type',
      '10': 'parameterTypes'
    },
  ],
};

@$core.Deprecated('Use typeDescriptor instead')
const Type_PrimitiveType$json = {
  '1': 'PrimitiveType',
  '2': [
    {'1': 'PRIMITIVE_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'BOOL', '2': 1},
    {'1': 'INT64', '2': 2},
    {'1': 'UINT64', '2': 3},
    {'1': 'DOUBLE', '2': 4},
    {'1': 'STRING', '2': 5},
    {'1': 'BYTES', '2': 6},
  ],
};

@$core.Deprecated('Use typeDescriptor instead')
const Type_WellKnownType$json = {
  '1': 'WellKnownType',
  '2': [
    {'1': 'WELL_KNOWN_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'ANY', '2': 1},
    {'1': 'TIMESTAMP', '2': 2},
    {'1': 'DURATION', '2': 3},
  ],
};

/// Descriptor for `Type`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List typeDescriptor = $convert.base64Decode(
    'CgRUeXBlEioKA2R5bhgBIAEoCzIWLmdvb2dsZS5wcm90b2J1Zi5FbXB0eUgAUgNkeW4SMAoEbn'
    'VsbBgCIAEoDjIaLmdvb2dsZS5wcm90b2J1Zi5OdWxsVmFsdWVIAFIEbnVsbBI8CglwcmltaXRp'
    'dmUYAyABKA4yHC5jZWwuZXhwci5UeXBlLlByaW1pdGl2ZVR5cGVIAFIJcHJpbWl0aXZlEjgKB3'
    'dyYXBwZXIYBCABKA4yHC5jZWwuZXhwci5UeXBlLlByaW1pdGl2ZVR5cGVIAFIHd3JhcHBlchI9'
    'Cgp3ZWxsX2tub3duGAUgASgOMhwuY2VsLmV4cHIuVHlwZS5XZWxsS25vd25UeXBlSABSCXdlbG'
    'xLbm93bhI2CglsaXN0X3R5cGUYBiABKAsyFy5jZWwuZXhwci5UeXBlLkxpc3RUeXBlSABSCGxp'
    'c3RUeXBlEjMKCG1hcF90eXBlGAcgASgLMhYuY2VsLmV4cHIuVHlwZS5NYXBUeXBlSABSB21hcF'
    'R5cGUSOQoIZnVuY3Rpb24YCCABKAsyGy5jZWwuZXhwci5UeXBlLkZ1bmN0aW9uVHlwZUgAUghm'
    'dW5jdGlvbhIjCgxtZXNzYWdlX3R5cGUYCSABKAlIAFILbWVzc2FnZVR5cGUSHwoKdHlwZV9wYX'
    'JhbRgKIAEoCUgAUgl0eXBlUGFyYW0SJAoEdHlwZRgLIAEoCzIOLmNlbC5leHByLlR5cGVIAFIE'
    'dHlwZRIuCgVlcnJvchgMIAEoCzIWLmdvb2dsZS5wcm90b2J1Zi5FbXB0eUgAUgVlcnJvchJCCg'
    '1hYnN0cmFjdF90eXBlGA4gASgLMhsuY2VsLmV4cHIuVHlwZS5BYnN0cmFjdFR5cGVIAFIMYWJz'
    'dHJhY3RUeXBlGjcKCExpc3RUeXBlEisKCWVsZW1fdHlwZRgBIAEoCzIOLmNlbC5leHByLlR5cG'
    'VSCGVsZW1UeXBlGmMKB01hcFR5cGUSKQoIa2V5X3R5cGUYASABKAsyDi5jZWwuZXhwci5UeXBl'
    'UgdrZXlUeXBlEi0KCnZhbHVlX3R5cGUYAiABKAsyDi5jZWwuZXhwci5UeXBlUgl2YWx1ZVR5cG'
    'UabAoMRnVuY3Rpb25UeXBlEi8KC3Jlc3VsdF90eXBlGAEgASgLMg4uY2VsLmV4cHIuVHlwZVIK'
    'cmVzdWx0VHlwZRIrCglhcmdfdHlwZXMYAiADKAsyDi5jZWwuZXhwci5UeXBlUghhcmdUeXBlcx'
    'pbCgxBYnN0cmFjdFR5cGUSEgoEbmFtZRgBIAEoCVIEbmFtZRI3Cg9wYXJhbWV0ZXJfdHlwZXMY'
    'AiADKAsyDi5jZWwuZXhwci5UeXBlUg5wYXJhbWV0ZXJUeXBlcyJzCg1QcmltaXRpdmVUeXBlEh'
    '4KGlBSSU1JVElWRV9UWVBFX1VOU1BFQ0lGSUVEEAASCAoEQk9PTBABEgkKBUlOVDY0EAISCgoG'
    'VUlOVDY0EAMSCgoGRE9VQkxFEAQSCgoGU1RSSU5HEAUSCQoFQllURVMQBiJWCg1XZWxsS25vd2'
    '5UeXBlEh8KG1dFTExfS05PV05fVFlQRV9VTlNQRUNJRklFRBAAEgcKA0FOWRABEg0KCVRJTUVT'
    'VEFNUBACEgwKCERVUkFUSU9OEANCCwoJdHlwZV9raW5k');

@$core.Deprecated('Use declDescriptor instead')
const Decl$json = {
  '1': 'Decl',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'ident',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Decl.IdentDecl',
      '9': 0,
      '10': 'ident'
    },
    {
      '1': 'function',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Decl.FunctionDecl',
      '9': 0,
      '10': 'function'
    },
  ],
  '3': [Decl_IdentDecl$json, Decl_FunctionDecl$json],
  '8': [
    {'1': 'decl_kind'},
  ],
};

@$core.Deprecated('Use declDescriptor instead')
const Decl_IdentDecl$json = {
  '1': 'IdentDecl',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 11, '6': '.cel.expr.Type', '10': 'type'},
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Constant',
      '10': 'value'
    },
    {'1': 'doc', '3': 3, '4': 1, '5': 9, '10': 'doc'},
  ],
};

@$core.Deprecated('Use declDescriptor instead')
const Decl_FunctionDecl$json = {
  '1': 'FunctionDecl',
  '2': [
    {
      '1': 'overloads',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.Decl.FunctionDecl.Overload',
      '10': 'overloads'
    },
    {'1': 'doc', '3': 2, '4': 1, '5': 9, '10': 'doc'},
  ],
  '3': [Decl_FunctionDecl_Overload$json],
};

@$core.Deprecated('Use declDescriptor instead')
const Decl_FunctionDecl_Overload$json = {
  '1': 'Overload',
  '2': [
    {'1': 'overload_id', '3': 1, '4': 1, '5': 9, '10': 'overloadId'},
    {
      '1': 'params',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.Type',
      '10': 'params'
    },
    {'1': 'type_params', '3': 3, '4': 3, '5': 9, '10': 'typeParams'},
    {
      '1': 'result_type',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Type',
      '10': 'resultType'
    },
    {
      '1': 'is_instance_function',
      '3': 5,
      '4': 1,
      '5': 8,
      '10': 'isInstanceFunction'
    },
    {'1': 'doc', '3': 6, '4': 1, '5': 9, '10': 'doc'},
  ],
};

/// Descriptor for `Decl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List declDescriptor = $convert.base64Decode(
    'CgREZWNsEhIKBG5hbWUYASABKAlSBG5hbWUSMAoFaWRlbnQYAiABKAsyGC5jZWwuZXhwci5EZW'
    'NsLklkZW50RGVjbEgAUgVpZGVudBI5CghmdW5jdGlvbhgDIAEoCzIbLmNlbC5leHByLkRlY2wu'
    'RnVuY3Rpb25EZWNsSABSCGZ1bmN0aW9uGmsKCUlkZW50RGVjbBIiCgR0eXBlGAEgASgLMg4uY2'
    'VsLmV4cHIuVHlwZVIEdHlwZRIoCgV2YWx1ZRgCIAEoCzISLmNlbC5leHByLkNvbnN0YW50UgV2'
    'YWx1ZRIQCgNkb2MYAyABKAlSA2RvYxrQAgoMRnVuY3Rpb25EZWNsEkIKCW92ZXJsb2FkcxgBIA'
    'MoCzIkLmNlbC5leHByLkRlY2wuRnVuY3Rpb25EZWNsLk92ZXJsb2FkUglvdmVybG9hZHMSEAoD'
    'ZG9jGAIgASgJUgNkb2Ma6QEKCE92ZXJsb2FkEh8KC292ZXJsb2FkX2lkGAEgASgJUgpvdmVybG'
    '9hZElkEiYKBnBhcmFtcxgCIAMoCzIOLmNlbC5leHByLlR5cGVSBnBhcmFtcxIfCgt0eXBlX3Bh'
    'cmFtcxgDIAMoCVIKdHlwZVBhcmFtcxIvCgtyZXN1bHRfdHlwZRgEIAEoCzIOLmNlbC5leHByLl'
    'R5cGVSCnJlc3VsdFR5cGUSMAoUaXNfaW5zdGFuY2VfZnVuY3Rpb24YBSABKAhSEmlzSW5zdGFu'
    'Y2VGdW5jdGlvbhIQCgNkb2MYBiABKAlSA2RvY0ILCglkZWNsX2tpbmQ=');

@$core.Deprecated('Use referenceDescriptor instead')
const Reference$json = {
  '1': 'Reference',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'overload_id', '3': 3, '4': 3, '5': 9, '10': 'overloadId'},
    {
      '1': 'value',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Constant',
      '10': 'value'
    },
  ],
};

/// Descriptor for `Reference`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List referenceDescriptor = $convert.base64Decode(
    'CglSZWZlcmVuY2USEgoEbmFtZRgBIAEoCVIEbmFtZRIfCgtvdmVybG9hZF9pZBgDIAMoCVIKb3'
    'ZlcmxvYWRJZBIoCgV2YWx1ZRgEIAEoCzISLmNlbC5leHByLkNvbnN0YW50UgV2YWx1ZQ==');
