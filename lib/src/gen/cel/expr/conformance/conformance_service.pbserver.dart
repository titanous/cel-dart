// This is a generated file - do not edit.
//
// Generated from cel/expr/conformance/conformance_service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'conformance_service.pb.dart' as $9;
import 'conformance_service.pbjson.dart';

export 'conformance_service.pb.dart';

abstract class ConformanceServiceBase extends $pb.GeneratedService {
  $async.Future<$9.ParseResponse> parse(
      $pb.ServerContext ctx, $9.ParseRequest request);
  $async.Future<$9.CheckResponse> check(
      $pb.ServerContext ctx, $9.CheckRequest request);
  $async.Future<$9.EvalResponse> eval(
      $pb.ServerContext ctx, $9.EvalRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'Parse':
        return $9.ParseRequest();
      case 'Check':
        return $9.CheckRequest();
      case 'Eval':
        return $9.EvalRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'Parse':
        return parse(ctx, request as $9.ParseRequest);
      case 'Check':
        return check(ctx, request as $9.CheckRequest);
      case 'Eval':
        return eval(ctx, request as $9.EvalRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      ConformanceServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => ConformanceServiceBase$messageJson;
}
