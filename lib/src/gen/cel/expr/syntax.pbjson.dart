// This is a generated file - do not edit.
//
// Generated from cel/expr/syntax.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use parsedExprDescriptor instead')
const ParsedExpr$json = {
  '1': 'ParsedExpr',
  '2': [
    {'1': 'expr', '3': 2, '4': 1, '5': 11, '6': '.cel.expr.Expr', '10': 'expr'},
    {
      '1': 'source_info',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.SourceInfo',
      '10': 'sourceInfo'
    },
  ],
};

/// Descriptor for `ParsedExpr`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List parsedExprDescriptor = $convert.base64Decode(
    'CgpQYXJzZWRFeHByEiIKBGV4cHIYAiABKAsyDi5jZWwuZXhwci5FeHByUgRleHByEjUKC3NvdX'
    'JjZV9pbmZvGAMgASgLMhQuY2VsLmV4cHIuU291cmNlSW5mb1IKc291cmNlSW5mbw==');

@$core.Deprecated('Use exprDescriptor instead')
const Expr$json = {
  '1': 'Expr',
  '2': [
    {'1': 'id', '3': 2, '4': 1, '5': 3, '10': 'id'},
    {
      '1': 'const_expr',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Constant',
      '9': 0,
      '10': 'constExpr'
    },
    {
      '1': 'ident_expr',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Expr.Ident',
      '9': 0,
      '10': 'identExpr'
    },
    {
      '1': 'select_expr',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Expr.Select',
      '9': 0,
      '10': 'selectExpr'
    },
    {
      '1': 'call_expr',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Expr.Call',
      '9': 0,
      '10': 'callExpr'
    },
    {
      '1': 'list_expr',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Expr.CreateList',
      '9': 0,
      '10': 'listExpr'
    },
    {
      '1': 'struct_expr',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Expr.CreateStruct',
      '9': 0,
      '10': 'structExpr'
    },
    {
      '1': 'comprehension_expr',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Expr.Comprehension',
      '9': 0,
      '10': 'comprehensionExpr'
    },
  ],
  '3': [
    Expr_Ident$json,
    Expr_Select$json,
    Expr_Call$json,
    Expr_CreateList$json,
    Expr_CreateStruct$json,
    Expr_Comprehension$json
  ],
  '8': [
    {'1': 'expr_kind'},
  ],
};

@$core.Deprecated('Use exprDescriptor instead')
const Expr_Ident$json = {
  '1': 'Ident',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

@$core.Deprecated('Use exprDescriptor instead')
const Expr_Select$json = {
  '1': 'Select',
  '2': [
    {
      '1': 'operand',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Expr',
      '10': 'operand'
    },
    {'1': 'field', '3': 2, '4': 1, '5': 9, '10': 'field'},
    {'1': 'test_only', '3': 3, '4': 1, '5': 8, '10': 'testOnly'},
  ],
};

@$core.Deprecated('Use exprDescriptor instead')
const Expr_Call$json = {
  '1': 'Call',
  '2': [
    {
      '1': 'target',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Expr',
      '10': 'target'
    },
    {'1': 'function', '3': 2, '4': 1, '5': 9, '10': 'function'},
    {'1': 'args', '3': 3, '4': 3, '5': 11, '6': '.cel.expr.Expr', '10': 'args'},
  ],
};

@$core.Deprecated('Use exprDescriptor instead')
const Expr_CreateList$json = {
  '1': 'CreateList',
  '2': [
    {
      '1': 'elements',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.Expr',
      '10': 'elements'
    },
    {'1': 'optional_indices', '3': 2, '4': 3, '5': 5, '10': 'optionalIndices'},
  ],
};

@$core.Deprecated('Use exprDescriptor instead')
const Expr_CreateStruct$json = {
  '1': 'CreateStruct',
  '2': [
    {'1': 'message_name', '3': 1, '4': 1, '5': 9, '10': 'messageName'},
    {
      '1': 'entries',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.Expr.CreateStruct.Entry',
      '10': 'entries'
    },
  ],
  '3': [Expr_CreateStruct_Entry$json],
};

@$core.Deprecated('Use exprDescriptor instead')
const Expr_CreateStruct_Entry$json = {
  '1': 'Entry',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'field_key', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'fieldKey'},
    {
      '1': 'map_key',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Expr',
      '9': 0,
      '10': 'mapKey'
    },
    {
      '1': 'value',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Expr',
      '10': 'value'
    },
    {'1': 'optional_entry', '3': 5, '4': 1, '5': 8, '10': 'optionalEntry'},
  ],
  '8': [
    {'1': 'key_kind'},
  ],
};

@$core.Deprecated('Use exprDescriptor instead')
const Expr_Comprehension$json = {
  '1': 'Comprehension',
  '2': [
    {'1': 'iter_var', '3': 1, '4': 1, '5': 9, '10': 'iterVar'},
    {'1': 'iter_var2', '3': 8, '4': 1, '5': 9, '10': 'iterVar2'},
    {
      '1': 'iter_range',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Expr',
      '10': 'iterRange'
    },
    {'1': 'accu_var', '3': 3, '4': 1, '5': 9, '10': 'accuVar'},
    {
      '1': 'accu_init',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Expr',
      '10': 'accuInit'
    },
    {
      '1': 'loop_condition',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Expr',
      '10': 'loopCondition'
    },
    {
      '1': 'loop_step',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Expr',
      '10': 'loopStep'
    },
    {
      '1': 'result',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Expr',
      '10': 'result'
    },
  ],
};

/// Descriptor for `Expr`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exprDescriptor = $convert.base64Decode(
    'CgRFeHByEg4KAmlkGAIgASgDUgJpZBIzCgpjb25zdF9leHByGAMgASgLMhIuY2VsLmV4cHIuQ2'
    '9uc3RhbnRIAFIJY29uc3RFeHByEjUKCmlkZW50X2V4cHIYBCABKAsyFC5jZWwuZXhwci5FeHBy'
    'LklkZW50SABSCWlkZW50RXhwchI4CgtzZWxlY3RfZXhwchgFIAEoCzIVLmNlbC5leHByLkV4cH'
    'IuU2VsZWN0SABSCnNlbGVjdEV4cHISMgoJY2FsbF9leHByGAYgASgLMhMuY2VsLmV4cHIuRXhw'
    'ci5DYWxsSABSCGNhbGxFeHByEjgKCWxpc3RfZXhwchgHIAEoCzIZLmNlbC5leHByLkV4cHIuQ3'
    'JlYXRlTGlzdEgAUghsaXN0RXhwchI+CgtzdHJ1Y3RfZXhwchgIIAEoCzIbLmNlbC5leHByLkV4'
    'cHIuQ3JlYXRlU3RydWN0SABSCnN0cnVjdEV4cHISTQoSY29tcHJlaGVuc2lvbl9leHByGAkgAS'
    'gLMhwuY2VsLmV4cHIuRXhwci5Db21wcmVoZW5zaW9uSABSEWNvbXByZWhlbnNpb25FeHByGhsK'
    'BUlkZW50EhIKBG5hbWUYASABKAlSBG5hbWUaZQoGU2VsZWN0EigKB29wZXJhbmQYASABKAsyDi'
    '5jZWwuZXhwci5FeHByUgdvcGVyYW5kEhQKBWZpZWxkGAIgASgJUgVmaWVsZBIbCgl0ZXN0X29u'
    'bHkYAyABKAhSCHRlc3RPbmx5Gm4KBENhbGwSJgoGdGFyZ2V0GAEgASgLMg4uY2VsLmV4cHIuRX'
    'hwclIGdGFyZ2V0EhoKCGZ1bmN0aW9uGAIgASgJUghmdW5jdGlvbhIiCgRhcmdzGAMgAygLMg4u'
    'Y2VsLmV4cHIuRXhwclIEYXJncxpjCgpDcmVhdGVMaXN0EioKCGVsZW1lbnRzGAEgAygLMg4uY2'
    'VsLmV4cHIuRXhwclIIZWxlbWVudHMSKQoQb3B0aW9uYWxfaW5kaWNlcxgCIAMoBVIPb3B0aW9u'
    'YWxJbmRpY2VzGqsCCgxDcmVhdGVTdHJ1Y3QSIQoMbWVzc2FnZV9uYW1lGAEgASgJUgttZXNzYW'
    'dlTmFtZRI7CgdlbnRyaWVzGAIgAygLMiEuY2VsLmV4cHIuRXhwci5DcmVhdGVTdHJ1Y3QuRW50'
    'cnlSB2VudHJpZXMaugEKBUVudHJ5Eg4KAmlkGAEgASgDUgJpZBIdCglmaWVsZF9rZXkYAiABKA'
    'lIAFIIZmllbGRLZXkSKQoHbWFwX2tleRgDIAEoCzIOLmNlbC5leHByLkV4cHJIAFIGbWFwS2V5'
    'EiQKBXZhbHVlGAQgASgLMg4uY2VsLmV4cHIuRXhwclIFdmFsdWUSJQoOb3B0aW9uYWxfZW50cn'
    'kYBSABKAhSDW9wdGlvbmFsRW50cnlCCgoIa2V5X2tpbmQaygIKDUNvbXByZWhlbnNpb24SGQoI'
    'aXRlcl92YXIYASABKAlSB2l0ZXJWYXISGwoJaXRlcl92YXIyGAggASgJUghpdGVyVmFyMhItCg'
    'ppdGVyX3JhbmdlGAIgASgLMg4uY2VsLmV4cHIuRXhwclIJaXRlclJhbmdlEhkKCGFjY3VfdmFy'
    'GAMgASgJUgdhY2N1VmFyEisKCWFjY3VfaW5pdBgEIAEoCzIOLmNlbC5leHByLkV4cHJSCGFjY3'
    'VJbml0EjUKDmxvb3BfY29uZGl0aW9uGAUgASgLMg4uY2VsLmV4cHIuRXhwclINbG9vcENvbmRp'
    'dGlvbhIrCglsb29wX3N0ZXAYBiABKAsyDi5jZWwuZXhwci5FeHByUghsb29wU3RlcBImCgZyZX'
    'N1bHQYByABKAsyDi5jZWwuZXhwci5FeHByUgZyZXN1bHRCCwoJZXhwcl9raW5k');

@$core.Deprecated('Use constantDescriptor instead')
const Constant$json = {
  '1': 'Constant',
  '2': [
    {
      '1': 'null_value',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.google.protobuf.NullValue',
      '9': 0,
      '10': 'nullValue'
    },
    {'1': 'bool_value', '3': 2, '4': 1, '5': 8, '9': 0, '10': 'boolValue'},
    {'1': 'int64_value', '3': 3, '4': 1, '5': 3, '9': 0, '10': 'int64Value'},
    {'1': 'uint64_value', '3': 4, '4': 1, '5': 4, '9': 0, '10': 'uint64Value'},
    {'1': 'double_value', '3': 5, '4': 1, '5': 1, '9': 0, '10': 'doubleValue'},
    {'1': 'string_value', '3': 6, '4': 1, '5': 9, '9': 0, '10': 'stringValue'},
    {'1': 'bytes_value', '3': 7, '4': 1, '5': 12, '9': 0, '10': 'bytesValue'},
    {
      '1': 'duration_value',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '8': {'3': true},
      '9': 0,
      '10': 'durationValue',
    },
    {
      '1': 'timestamp_value',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {'3': true},
      '9': 0,
      '10': 'timestampValue',
    },
  ],
  '8': [
    {'1': 'constant_kind'},
  ],
};

/// Descriptor for `Constant`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List constantDescriptor = $convert.base64Decode(
    'CghDb25zdGFudBI7CgpudWxsX3ZhbHVlGAEgASgOMhouZ29vZ2xlLnByb3RvYnVmLk51bGxWYW'
    'x1ZUgAUgludWxsVmFsdWUSHwoKYm9vbF92YWx1ZRgCIAEoCEgAUglib29sVmFsdWUSIQoLaW50'
    'NjRfdmFsdWUYAyABKANIAFIKaW50NjRWYWx1ZRIjCgx1aW50NjRfdmFsdWUYBCABKARIAFILdW'
    'ludDY0VmFsdWUSIwoMZG91YmxlX3ZhbHVlGAUgASgBSABSC2RvdWJsZVZhbHVlEiMKDHN0cmlu'
    'Z192YWx1ZRgGIAEoCUgAUgtzdHJpbmdWYWx1ZRIhCgtieXRlc192YWx1ZRgHIAEoDEgAUgpieX'
    'Rlc1ZhbHVlEkYKDmR1cmF0aW9uX3ZhbHVlGAggASgLMhkuZ29vZ2xlLnByb3RvYnVmLkR1cmF0'
    'aW9uQgIYAUgAUg1kdXJhdGlvblZhbHVlEkkKD3RpbWVzdGFtcF92YWx1ZRgJIAEoCzIaLmdvb2'
    'dsZS5wcm90b2J1Zi5UaW1lc3RhbXBCAhgBSABSDnRpbWVzdGFtcFZhbHVlQg8KDWNvbnN0YW50'
    'X2tpbmQ=');

@$core.Deprecated('Use sourceInfoDescriptor instead')
const SourceInfo$json = {
  '1': 'SourceInfo',
  '2': [
    {'1': 'syntax_version', '3': 1, '4': 1, '5': 9, '10': 'syntaxVersion'},
    {'1': 'location', '3': 2, '4': 1, '5': 9, '10': 'location'},
    {'1': 'line_offsets', '3': 3, '4': 3, '5': 5, '10': 'lineOffsets'},
    {
      '1': 'positions',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.SourceInfo.PositionsEntry',
      '10': 'positions'
    },
    {
      '1': 'macro_calls',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.SourceInfo.MacroCallsEntry',
      '10': 'macroCalls'
    },
    {
      '1': 'extensions',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.SourceInfo.Extension',
      '10': 'extensions'
    },
  ],
  '3': [
    SourceInfo_PositionsEntry$json,
    SourceInfo_MacroCallsEntry$json,
    SourceInfo_Extension$json
  ],
};

@$core.Deprecated('Use sourceInfoDescriptor instead')
const SourceInfo_PositionsEntry$json = {
  '1': 'PositionsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 3, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 5, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use sourceInfoDescriptor instead')
const SourceInfo_MacroCallsEntry$json = {
  '1': 'MacroCallsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 3, '10': 'key'},
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.Expr',
      '10': 'value'
    },
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use sourceInfoDescriptor instead')
const SourceInfo_Extension$json = {
  '1': 'Extension',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'affected_components',
      '3': 2,
      '4': 3,
      '5': 14,
      '6': '.cel.expr.SourceInfo.Extension.Component',
      '10': 'affectedComponents'
    },
    {
      '1': 'version',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.SourceInfo.Extension.Version',
      '10': 'version'
    },
  ],
  '3': [SourceInfo_Extension_Version$json],
  '4': [SourceInfo_Extension_Component$json],
};

@$core.Deprecated('Use sourceInfoDescriptor instead')
const SourceInfo_Extension_Version$json = {
  '1': 'Version',
  '2': [
    {'1': 'major', '3': 1, '4': 1, '5': 3, '10': 'major'},
    {'1': 'minor', '3': 2, '4': 1, '5': 3, '10': 'minor'},
  ],
};

@$core.Deprecated('Use sourceInfoDescriptor instead')
const SourceInfo_Extension_Component$json = {
  '1': 'Component',
  '2': [
    {'1': 'COMPONENT_UNSPECIFIED', '2': 0},
    {'1': 'COMPONENT_PARSER', '2': 1},
    {'1': 'COMPONENT_TYPE_CHECKER', '2': 2},
    {'1': 'COMPONENT_RUNTIME', '2': 3},
  ],
};

/// Descriptor for `SourceInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sourceInfoDescriptor = $convert.base64Decode(
    'CgpTb3VyY2VJbmZvEiUKDnN5bnRheF92ZXJzaW9uGAEgASgJUg1zeW50YXhWZXJzaW9uEhoKCG'
    'xvY2F0aW9uGAIgASgJUghsb2NhdGlvbhIhCgxsaW5lX29mZnNldHMYAyADKAVSC2xpbmVPZmZz'
    'ZXRzEkEKCXBvc2l0aW9ucxgEIAMoCzIjLmNlbC5leHByLlNvdXJjZUluZm8uUG9zaXRpb25zRW'
    '50cnlSCXBvc2l0aW9ucxJFCgttYWNyb19jYWxscxgFIAMoCzIkLmNlbC5leHByLlNvdXJjZUlu'
    'Zm8uTWFjcm9DYWxsc0VudHJ5UgptYWNyb0NhbGxzEj4KCmV4dGVuc2lvbnMYBiADKAsyHi5jZW'
    'wuZXhwci5Tb3VyY2VJbmZvLkV4dGVuc2lvblIKZXh0ZW5zaW9ucxo8Cg5Qb3NpdGlvbnNFbnRy'
    'eRIQCgNrZXkYASABKANSA2tleRIUCgV2YWx1ZRgCIAEoBVIFdmFsdWU6AjgBGk0KD01hY3JvQ2'
    'FsbHNFbnRyeRIQCgNrZXkYASABKANSA2tleRIkCgV2YWx1ZRgCIAEoCzIOLmNlbC5leHByLkV4'
    'cHJSBXZhbHVlOgI4ARrgAgoJRXh0ZW5zaW9uEg4KAmlkGAEgASgJUgJpZBJZChNhZmZlY3RlZF'
    '9jb21wb25lbnRzGAIgAygOMiguY2VsLmV4cHIuU291cmNlSW5mby5FeHRlbnNpb24uQ29tcG9u'
    'ZW50UhJhZmZlY3RlZENvbXBvbmVudHMSQAoHdmVyc2lvbhgDIAEoCzImLmNlbC5leHByLlNvdX'
    'JjZUluZm8uRXh0ZW5zaW9uLlZlcnNpb25SB3ZlcnNpb24aNQoHVmVyc2lvbhIUCgVtYWpvchgB'
    'IAEoA1IFbWFqb3ISFAoFbWlub3IYAiABKANSBW1pbm9yIm8KCUNvbXBvbmVudBIZChVDT01QT0'
    '5FTlRfVU5TUEVDSUZJRUQQABIUChBDT01QT05FTlRfUEFSU0VSEAESGgoWQ09NUE9ORU5UX1RZ'
    'UEVfQ0hFQ0tFUhACEhUKEUNPTVBPTkVOVF9SVU5USU1FEAM=');
