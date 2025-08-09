// This is a generated file - do not edit.
//
// Generated from cel/expr/conformance/conformance_service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

import '../../../google/protobuf/any.pbjson.dart' as $6;
import '../../../google/protobuf/duration.pbjson.dart' as $4;
import '../../../google/protobuf/empty.pbjson.dart' as $7;
import '../../../google/protobuf/timestamp.pbjson.dart' as $5;
import '../../../google/rpc/status.pbjson.dart' as $1;
import '../checked.pbjson.dart' as $2;
import '../eval.pbjson.dart' as $3;
import '../syntax.pbjson.dart' as $0;
import '../value.pbjson.dart' as $8;

@$core.Deprecated('Use parseRequestDescriptor instead')
const ParseRequest$json = {
  '1': 'ParseRequest',
  '2': [
    {'1': 'cel_source', '3': 1, '4': 1, '5': 9, '10': 'celSource'},
    {'1': 'syntax_version', '3': 2, '4': 1, '5': 9, '10': 'syntaxVersion'},
    {'1': 'source_location', '3': 3, '4': 1, '5': 9, '10': 'sourceLocation'},
    {'1': 'disable_macros', '3': 4, '4': 1, '5': 8, '10': 'disableMacros'},
  ],
};

/// Descriptor for `ParseRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List parseRequestDescriptor = $convert.base64Decode(
    'CgxQYXJzZVJlcXVlc3QSHQoKY2VsX3NvdXJjZRgBIAEoCVIJY2VsU291cmNlEiUKDnN5bnRheF'
    '92ZXJzaW9uGAIgASgJUg1zeW50YXhWZXJzaW9uEicKD3NvdXJjZV9sb2NhdGlvbhgDIAEoCVIO'
    'c291cmNlTG9jYXRpb24SJQoOZGlzYWJsZV9tYWNyb3MYBCABKAhSDWRpc2FibGVNYWNyb3M=');

@$core.Deprecated('Use parseResponseDescriptor instead')
const ParseResponse$json = {
  '1': 'ParseResponse',
  '2': [
    {
      '1': 'parsed_expr',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.ParsedExpr',
      '10': 'parsedExpr'
    },
    {
      '1': 'issues',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.rpc.Status',
      '10': 'issues'
    },
  ],
};

/// Descriptor for `ParseResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List parseResponseDescriptor = $convert.base64Decode(
    'Cg1QYXJzZVJlc3BvbnNlEjUKC3BhcnNlZF9leHByGAEgASgLMhQuY2VsLmV4cHIuUGFyc2VkRX'
    'hwclIKcGFyc2VkRXhwchIqCgZpc3N1ZXMYAiADKAsyEi5nb29nbGUucnBjLlN0YXR1c1IGaXNz'
    'dWVz');

@$core.Deprecated('Use checkRequestDescriptor instead')
const CheckRequest$json = {
  '1': 'CheckRequest',
  '2': [
    {
      '1': 'parsed_expr',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.ParsedExpr',
      '10': 'parsedExpr'
    },
    {
      '1': 'type_env',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.Decl',
      '10': 'typeEnv'
    },
    {'1': 'container', '3': 3, '4': 1, '5': 9, '10': 'container'},
    {'1': 'no_std_env', '3': 4, '4': 1, '5': 8, '10': 'noStdEnv'},
  ],
};

/// Descriptor for `CheckRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkRequestDescriptor = $convert.base64Decode(
    'CgxDaGVja1JlcXVlc3QSNQoLcGFyc2VkX2V4cHIYASABKAsyFC5jZWwuZXhwci5QYXJzZWRFeH'
    'ByUgpwYXJzZWRFeHByEikKCHR5cGVfZW52GAIgAygLMg4uY2VsLmV4cHIuRGVjbFIHdHlwZUVu'
    'dhIcCgljb250YWluZXIYAyABKAlSCWNvbnRhaW5lchIcCgpub19zdGRfZW52GAQgASgIUghub1'
    'N0ZEVudg==');

@$core.Deprecated('Use checkResponseDescriptor instead')
const CheckResponse$json = {
  '1': 'CheckResponse',
  '2': [
    {
      '1': 'checked_expr',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.CheckedExpr',
      '10': 'checkedExpr'
    },
    {
      '1': 'issues',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.rpc.Status',
      '10': 'issues'
    },
  ],
};

/// Descriptor for `CheckResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkResponseDescriptor = $convert.base64Decode(
    'Cg1DaGVja1Jlc3BvbnNlEjgKDGNoZWNrZWRfZXhwchgBIAEoCzIVLmNlbC5leHByLkNoZWNrZW'
    'RFeHByUgtjaGVja2VkRXhwchIqCgZpc3N1ZXMYAiADKAsyEi5nb29nbGUucnBjLlN0YXR1c1IG'
    'aXNzdWVz');

@$core.Deprecated('Use evalRequestDescriptor instead')
const EvalRequest$json = {
  '1': 'EvalRequest',
  '2': [
    {
      '1': 'parsed_expr',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.ParsedExpr',
      '9': 0,
      '10': 'parsedExpr'
    },
    {
      '1': 'checked_expr',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.CheckedExpr',
      '9': 0,
      '10': 'checkedExpr'
    },
    {
      '1': 'bindings',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.cel.expr.conformance.EvalRequest.BindingsEntry',
      '10': 'bindings'
    },
    {'1': 'container', '3': 4, '4': 1, '5': 9, '10': 'container'},
  ],
  '3': [EvalRequest_BindingsEntry$json],
  '8': [
    {'1': 'expr_kind'},
  ],
};

@$core.Deprecated('Use evalRequestDescriptor instead')
const EvalRequest_BindingsEntry$json = {
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

/// Descriptor for `EvalRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List evalRequestDescriptor = $convert.base64Decode(
    'CgtFdmFsUmVxdWVzdBI3CgtwYXJzZWRfZXhwchgBIAEoCzIULmNlbC5leHByLlBhcnNlZEV4cH'
    'JIAFIKcGFyc2VkRXhwchI6CgxjaGVja2VkX2V4cHIYAiABKAsyFS5jZWwuZXhwci5DaGVja2Vk'
    'RXhwckgAUgtjaGVja2VkRXhwchJLCghiaW5kaW5ncxgDIAMoCzIvLmNlbC5leHByLmNvbmZvcm'
    '1hbmNlLkV2YWxSZXF1ZXN0LkJpbmRpbmdzRW50cnlSCGJpbmRpbmdzEhwKCWNvbnRhaW5lchgE'
    'IAEoCVIJY29udGFpbmVyGlAKDUJpbmRpbmdzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSKQoFdm'
    'FsdWUYAiABKAsyEy5jZWwuZXhwci5FeHByVmFsdWVSBXZhbHVlOgI4AUILCglleHByX2tpbmQ=');

@$core.Deprecated('Use evalResponseDescriptor instead')
const EvalResponse$json = {
  '1': 'EvalResponse',
  '2': [
    {
      '1': 'result',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.ExprValue',
      '10': 'result'
    },
    {
      '1': 'issues',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.rpc.Status',
      '10': 'issues'
    },
  ],
};

/// Descriptor for `EvalResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List evalResponseDescriptor = $convert.base64Decode(
    'CgxFdmFsUmVzcG9uc2USKwoGcmVzdWx0GAEgASgLMhMuY2VsLmV4cHIuRXhwclZhbHVlUgZyZX'
    'N1bHQSKgoGaXNzdWVzGAIgAygLMhIuZ29vZ2xlLnJwYy5TdGF0dXNSBmlzc3Vlcw==');

@$core.Deprecated('Use sourcePositionDescriptor instead')
const SourcePosition$json = {
  '1': 'SourcePosition',
  '2': [
    {'1': 'location', '3': 1, '4': 1, '5': 9, '10': 'location'},
    {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
    {'1': 'line', '3': 3, '4': 1, '5': 5, '10': 'line'},
    {'1': 'column', '3': 4, '4': 1, '5': 5, '10': 'column'},
  ],
};

/// Descriptor for `SourcePosition`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sourcePositionDescriptor = $convert.base64Decode(
    'Cg5Tb3VyY2VQb3NpdGlvbhIaCghsb2NhdGlvbhgBIAEoCVIIbG9jYXRpb24SFgoGb2Zmc2V0GA'
    'IgASgFUgZvZmZzZXQSEgoEbGluZRgDIAEoBVIEbGluZRIWCgZjb2x1bW4YBCABKAVSBmNvbHVt'
    'bg==');

@$core.Deprecated('Use issueDetailsDescriptor instead')
const IssueDetails$json = {
  '1': 'IssueDetails',
  '2': [
    {
      '1': 'severity',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.cel.expr.conformance.IssueDetails.Severity',
      '10': 'severity'
    },
    {
      '1': 'position',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.cel.expr.conformance.SourcePosition',
      '10': 'position'
    },
    {'1': 'id', '3': 3, '4': 1, '5': 3, '10': 'id'},
  ],
  '4': [IssueDetails_Severity$json],
};

@$core.Deprecated('Use issueDetailsDescriptor instead')
const IssueDetails_Severity$json = {
  '1': 'Severity',
  '2': [
    {'1': 'SEVERITY_UNSPECIFIED', '2': 0},
    {'1': 'DEPRECATION', '2': 1},
    {'1': 'WARNING', '2': 2},
    {'1': 'ERROR', '2': 3},
  ],
};

/// Descriptor for `IssueDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List issueDetailsDescriptor = $convert.base64Decode(
    'CgxJc3N1ZURldGFpbHMSRwoIc2V2ZXJpdHkYASABKA4yKy5jZWwuZXhwci5jb25mb3JtYW5jZS'
    '5Jc3N1ZURldGFpbHMuU2V2ZXJpdHlSCHNldmVyaXR5EkAKCHBvc2l0aW9uGAIgASgLMiQuY2Vs'
    'LmV4cHIuY29uZm9ybWFuY2UuU291cmNlUG9zaXRpb25SCHBvc2l0aW9uEg4KAmlkGAMgASgDUg'
    'JpZCJNCghTZXZlcml0eRIYChRTRVZFUklUWV9VTlNQRUNJRklFRBAAEg8KC0RFUFJFQ0FUSU9O'
    'EAESCwoHV0FSTklORxACEgkKBUVSUk9SEAM=');

const $core.Map<$core.String, $core.dynamic> ConformanceServiceBase$json = {
  '1': 'ConformanceService',
  '2': [
    {
      '1': 'Parse',
      '2': '.cel.expr.conformance.ParseRequest',
      '3': '.cel.expr.conformance.ParseResponse',
      '4': {}
    },
    {
      '1': 'Check',
      '2': '.cel.expr.conformance.CheckRequest',
      '3': '.cel.expr.conformance.CheckResponse',
      '4': {}
    },
    {
      '1': 'Eval',
      '2': '.cel.expr.conformance.EvalRequest',
      '3': '.cel.expr.conformance.EvalResponse',
      '4': {}
    },
  ],
};

@$core.Deprecated('Use conformanceServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    ConformanceServiceBase$messageJson = {
  '.cel.expr.conformance.ParseRequest': ParseRequest$json,
  '.cel.expr.conformance.ParseResponse': ParseResponse$json,
  '.cel.expr.ParsedExpr': $0.ParsedExpr$json,
  '.cel.expr.Expr': $0.Expr$json,
  '.cel.expr.Constant': $0.Constant$json,
  '.google.protobuf.Duration': $4.Duration$json,
  '.google.protobuf.Timestamp': $5.Timestamp$json,
  '.cel.expr.Expr.Ident': $0.Expr_Ident$json,
  '.cel.expr.Expr.Select': $0.Expr_Select$json,
  '.cel.expr.Expr.Call': $0.Expr_Call$json,
  '.cel.expr.Expr.CreateList': $0.Expr_CreateList$json,
  '.cel.expr.Expr.CreateStruct': $0.Expr_CreateStruct$json,
  '.cel.expr.Expr.CreateStruct.Entry': $0.Expr_CreateStruct_Entry$json,
  '.cel.expr.Expr.Comprehension': $0.Expr_Comprehension$json,
  '.cel.expr.SourceInfo': $0.SourceInfo$json,
  '.cel.expr.SourceInfo.PositionsEntry': $0.SourceInfo_PositionsEntry$json,
  '.cel.expr.SourceInfo.MacroCallsEntry': $0.SourceInfo_MacroCallsEntry$json,
  '.cel.expr.SourceInfo.Extension': $0.SourceInfo_Extension$json,
  '.cel.expr.SourceInfo.Extension.Version':
      $0.SourceInfo_Extension_Version$json,
  '.google.rpc.Status': $1.Status$json,
  '.google.protobuf.Any': $6.Any$json,
  '.cel.expr.conformance.CheckRequest': CheckRequest$json,
  '.cel.expr.Decl': $2.Decl$json,
  '.cel.expr.Decl.IdentDecl': $2.Decl_IdentDecl$json,
  '.cel.expr.Type': $2.Type$json,
  '.google.protobuf.Empty': $7.Empty$json,
  '.cel.expr.Type.ListType': $2.Type_ListType$json,
  '.cel.expr.Type.MapType': $2.Type_MapType$json,
  '.cel.expr.Type.FunctionType': $2.Type_FunctionType$json,
  '.cel.expr.Type.AbstractType': $2.Type_AbstractType$json,
  '.cel.expr.Decl.FunctionDecl': $2.Decl_FunctionDecl$json,
  '.cel.expr.Decl.FunctionDecl.Overload': $2.Decl_FunctionDecl_Overload$json,
  '.cel.expr.conformance.CheckResponse': CheckResponse$json,
  '.cel.expr.CheckedExpr': $2.CheckedExpr$json,
  '.cel.expr.CheckedExpr.ReferenceMapEntry':
      $2.CheckedExpr_ReferenceMapEntry$json,
  '.cel.expr.Reference': $2.Reference$json,
  '.cel.expr.CheckedExpr.TypeMapEntry': $2.CheckedExpr_TypeMapEntry$json,
  '.cel.expr.conformance.EvalRequest': EvalRequest$json,
  '.cel.expr.conformance.EvalRequest.BindingsEntry':
      EvalRequest_BindingsEntry$json,
  '.cel.expr.ExprValue': $3.ExprValue$json,
  '.cel.expr.Value': $8.Value$json,
  '.cel.expr.EnumValue': $8.EnumValue$json,
  '.cel.expr.MapValue': $8.MapValue$json,
  '.cel.expr.MapValue.Entry': $8.MapValue_Entry$json,
  '.cel.expr.ListValue': $8.ListValue$json,
  '.cel.expr.ErrorSet': $3.ErrorSet$json,
  '.cel.expr.Status': $3.Status$json,
  '.cel.expr.UnknownSet': $3.UnknownSet$json,
  '.cel.expr.conformance.EvalResponse': EvalResponse$json,
};

/// Descriptor for `ConformanceService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List conformanceServiceDescriptor = $convert.base64Decode(
    'ChJDb25mb3JtYW5jZVNlcnZpY2USUgoFUGFyc2USIi5jZWwuZXhwci5jb25mb3JtYW5jZS5QYX'
    'JzZVJlcXVlc3QaIy5jZWwuZXhwci5jb25mb3JtYW5jZS5QYXJzZVJlc3BvbnNlIgASUgoFQ2hl'
    'Y2sSIi5jZWwuZXhwci5jb25mb3JtYW5jZS5DaGVja1JlcXVlc3QaIy5jZWwuZXhwci5jb25mb3'
    'JtYW5jZS5DaGVja1Jlc3BvbnNlIgASTwoERXZhbBIhLmNlbC5leHByLmNvbmZvcm1hbmNlLkV2'
    'YWxSZXF1ZXN0GiIuY2VsLmV4cHIuY29uZm9ybWFuY2UuRXZhbFJlc3BvbnNlIgA=');
