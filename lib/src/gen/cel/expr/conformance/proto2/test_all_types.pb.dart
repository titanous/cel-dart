// This is a generated file - do not edit.
//
// Generated from cel/expr/conformance/proto2/test_all_types.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../../../google/protobuf/any.pb.dart' as $0;
import '../../../../google/protobuf/duration.pb.dart' as $1;
import '../../../../google/protobuf/empty.pb.dart' as $6;
import '../../../../google/protobuf/field_mask.pb.dart' as $5;
import '../../../../google/protobuf/struct.pb.dart' as $3;
import '../../../../google/protobuf/timestamp.pb.dart' as $2;
import '../../../../google/protobuf/wrappers.pb.dart' as $4;
import 'test_all_types.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'test_all_types.pbenum.dart';

class TestAllTypes_NestedMessage extends $pb.GeneratedMessage {
  factory TestAllTypes_NestedMessage({
    $core.int? bb,
  }) {
    final result = create();
    if (bb != null) result.bb = bb;
    return result;
  }

  TestAllTypes_NestedMessage._();

  factory TestAllTypes_NestedMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TestAllTypes_NestedMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TestAllTypes.NestedMessage',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'cel.expr.conformance.proto2'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'bb', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TestAllTypes_NestedMessage clone() =>
      TestAllTypes_NestedMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TestAllTypes_NestedMessage copyWith(
          void Function(TestAllTypes_NestedMessage) updates) =>
      super.copyWith(
              (message) => updates(message as TestAllTypes_NestedMessage))
          as TestAllTypes_NestedMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestAllTypes_NestedMessage create() => TestAllTypes_NestedMessage._();
  @$core.override
  TestAllTypes_NestedMessage createEmptyInstance() => create();
  static $pb.PbList<TestAllTypes_NestedMessage> createRepeated() =>
      $pb.PbList<TestAllTypes_NestedMessage>();
  @$core.pragma('dart2js:noInline')
  static TestAllTypes_NestedMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TestAllTypes_NestedMessage>(create);
  static TestAllTypes_NestedMessage? _defaultInstance;

  /// The field name "b" fails to compile in proto1 because it conflicts with
  /// a local variable named "b" in one of the generated methods.
  /// This file needs to compile in proto1 to test backwards-compatibility.
  @$pb.TagNumber(1)
  $core.int get bb => $_getIZ(0);
  @$pb.TagNumber(1)
  set bb($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBb() => $_has(0);
  @$pb.TagNumber(1)
  void clearBb() => $_clearField(1);
}

class TestAllTypes_NestedGroup extends $pb.GeneratedMessage {
  factory TestAllTypes_NestedGroup({
    $core.int? singleId,
    $core.String? singleName,
  }) {
    final result = create();
    if (singleId != null) result.singleId = singleId;
    if (singleName != null) result.singleName = singleName;
    return result;
  }

  TestAllTypes_NestedGroup._();

  factory TestAllTypes_NestedGroup.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TestAllTypes_NestedGroup.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TestAllTypes.NestedGroup',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'cel.expr.conformance.proto2'),
      createEmptyInstance: create)
    ..a<$core.int>(404, _omitFieldNames ? '' : 'singleId', $pb.PbFieldType.O3)
    ..aOS(405, _omitFieldNames ? '' : 'singleName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TestAllTypes_NestedGroup clone() =>
      TestAllTypes_NestedGroup()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TestAllTypes_NestedGroup copyWith(
          void Function(TestAllTypes_NestedGroup) updates) =>
      super.copyWith((message) => updates(message as TestAllTypes_NestedGroup))
          as TestAllTypes_NestedGroup;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestAllTypes_NestedGroup create() => TestAllTypes_NestedGroup._();
  @$core.override
  TestAllTypes_NestedGroup createEmptyInstance() => create();
  static $pb.PbList<TestAllTypes_NestedGroup> createRepeated() =>
      $pb.PbList<TestAllTypes_NestedGroup>();
  @$core.pragma('dart2js:noInline')
  static TestAllTypes_NestedGroup getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TestAllTypes_NestedGroup>(create);
  static TestAllTypes_NestedGroup? _defaultInstance;

  @$pb.TagNumber(404)
  $core.int get singleId => $_getIZ(0);
  @$pb.TagNumber(404)
  set singleId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(404)
  $core.bool hasSingleId() => $_has(0);
  @$pb.TagNumber(404)
  void clearSingleId() => $_clearField(404);

  @$pb.TagNumber(405)
  $core.String get singleName => $_getSZ(1);
  @$pb.TagNumber(405)
  set singleName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(405)
  $core.bool hasSingleName() => $_has(1);
  @$pb.TagNumber(405)
  void clearSingleName() => $_clearField(405);
}

enum TestAllTypes_NestedType { singleNestedMessage, singleNestedEnum, notSet }

enum TestAllTypes_Kind { oneofType, oneofMsg, oneofBool, notSet }

/// This proto includes every type of field in both singular and repeated
/// forms.
class TestAllTypes extends $pb.GeneratedMessage {
  factory TestAllTypes({
    $core.int? singleInt32,
    $fixnum.Int64? singleInt64,
    $core.int? singleUint32,
    $fixnum.Int64? singleUint64,
    $core.int? singleSint32,
    $fixnum.Int64? singleSint64,
    $core.int? singleFixed32,
    $fixnum.Int64? singleFixed64,
    $core.int? singleSfixed32,
    $fixnum.Int64? singleSfixed64,
    $core.double? singleFloat,
    $core.double? singleDouble,
    $core.bool? singleBool,
    $core.String? singleString,
    $core.List<$core.int>? singleBytes,
    $core.bool? in_18,
    TestAllTypes_NestedMessage? singleNestedMessage,
    TestAllTypes_NestedEnum? singleNestedEnum,
    TestAllTypes_NestedMessage? standaloneMessage,
    TestAllTypes_NestedEnum? standaloneEnum,
    $core.Iterable<$core.int>? repeatedInt32,
    $core.Iterable<$fixnum.Int64>? repeatedInt64,
    $core.Iterable<$core.int>? repeatedUint32,
    $core.Iterable<$fixnum.Int64>? repeatedUint64,
    $core.Iterable<$core.int>? repeatedSint32,
    $core.Iterable<$fixnum.Int64>? repeatedSint64,
    $core.Iterable<$core.int>? repeatedFixed32,
    $core.Iterable<$fixnum.Int64>? repeatedFixed64,
    $core.Iterable<$core.int>? repeatedSfixed32,
    $core.Iterable<$fixnum.Int64>? repeatedSfixed64,
    $core.Iterable<$core.double>? repeatedFloat,
    $core.Iterable<$core.double>? repeatedDouble,
    $core.Iterable<$core.bool>? repeatedBool,
    $core.Iterable<$core.String>? repeatedString,
    $core.Iterable<$core.List<$core.int>>? repeatedBytes,
    $core.Iterable<TestAllTypes_NestedMessage>? repeatedNestedMessage,
    $core.Iterable<TestAllTypes_NestedEnum>? repeatedNestedEnum,
    $core.Iterable<$core.String>? repeatedStringPiece,
    $core.Iterable<$core.String>? repeatedCord,
    $core.Iterable<TestAllTypes_NestedMessage>? repeatedLazyMessage,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? mapStringString,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, NestedTestAllTypes>>?
        mapInt64NestedType,
    $core.Iterable<$core.MapEntry<$core.bool, $core.bool>>? mapBoolBool,
    $core.Iterable<$core.MapEntry<$core.bool, $core.String>>? mapBoolString,
    $core.Iterable<$core.MapEntry<$core.bool, $core.List<$core.int>>>?
        mapBoolBytes,
    $core.Iterable<$core.MapEntry<$core.bool, $core.int>>? mapBoolInt32,
    $core.Iterable<$core.MapEntry<$core.bool, $fixnum.Int64>>? mapBoolInt64,
    $core.Iterable<$core.MapEntry<$core.bool, $core.int>>? mapBoolUint32,
    $core.Iterable<$core.MapEntry<$core.bool, $fixnum.Int64>>? mapBoolUint64,
    $core.Iterable<$core.MapEntry<$core.bool, $core.double>>? mapBoolFloat,
    $core.Iterable<$core.MapEntry<$core.bool, $core.double>>? mapBoolDouble,
    $core.Iterable<$core.MapEntry<$core.bool, TestAllTypes_NestedEnum>>?
        mapBoolEnum,
    $core.Iterable<$core.MapEntry<$core.bool, TestAllTypes_NestedMessage>>?
        mapBoolMessage,
    $core.Iterable<$core.MapEntry<$core.int, $core.bool>>? mapInt32Bool,
    $core.Iterable<$core.MapEntry<$core.int, $core.String>>? mapInt32String,
    $core.Iterable<$core.MapEntry<$core.int, $core.List<$core.int>>>?
        mapInt32Bytes,
    $core.Iterable<$core.MapEntry<$core.int, $core.int>>? mapInt32Int32,
    $core.Iterable<$core.MapEntry<$core.int, $fixnum.Int64>>? mapInt32Int64,
    $core.Iterable<$core.MapEntry<$core.int, $core.int>>? mapInt32Uint32,
    $core.Iterable<$core.MapEntry<$core.int, $fixnum.Int64>>? mapInt32Uint64,
    $core.Iterable<$core.MapEntry<$core.int, $core.double>>? mapInt32Float,
    $core.Iterable<$core.MapEntry<$core.int, $core.double>>? mapInt32Double,
    $core.Iterable<$core.MapEntry<$core.int, TestAllTypes_NestedEnum>>?
        mapInt32Enum,
    $core.Iterable<$core.MapEntry<$core.int, TestAllTypes_NestedMessage>>?
        mapInt32Message,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $core.bool>>? mapInt64Bool,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $core.String>>? mapInt64String,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $core.List<$core.int>>>?
        mapInt64Bytes,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $core.int>>? mapInt64Int32,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $fixnum.Int64>>? mapInt64Int64,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $core.int>>? mapInt64Uint32,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $fixnum.Int64>>?
        mapInt64Uint64,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $core.double>>? mapInt64Float,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $core.double>>? mapInt64Double,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, TestAllTypes_NestedEnum>>?
        mapInt64Enum,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, TestAllTypes_NestedMessage>>?
        mapInt64Message,
    $core.Iterable<$core.MapEntry<$core.int, $core.bool>>? mapUint32Bool,
    $core.Iterable<$core.MapEntry<$core.int, $core.String>>? mapUint32String,
    $core.Iterable<$core.MapEntry<$core.int, $core.List<$core.int>>>?
        mapUint32Bytes,
    $core.Iterable<$core.MapEntry<$core.int, $core.int>>? mapUint32Int32,
    $0.Any? singleAny,
    $1.Duration? singleDuration,
    $2.Timestamp? singleTimestamp,
    $3.Struct? singleStruct,
    $3.Value? singleValue,
    $4.Int64Value? singleInt64Wrapper,
    $4.Int32Value? singleInt32Wrapper,
    $4.DoubleValue? singleDoubleWrapper,
    $4.FloatValue? singleFloatWrapper,
    $4.UInt64Value? singleUint64Wrapper,
    $4.UInt32Value? singleUint32Wrapper,
    $4.StringValue? singleStringWrapper,
    $4.BoolValue? singleBoolWrapper,
    $4.BytesValue? singleBytesWrapper,
    $3.ListValue? listValue,
    $3.NullValue? nullValue,
    $3.NullValue? optionalNullValue,
    $5.FieldMask? fieldMask,
    $6.Empty? empty,
    $core.Iterable<$0.Any>? repeatedAny,
    $core.Iterable<$1.Duration>? repeatedDuration,
    $core.Iterable<$2.Timestamp>? repeatedTimestamp,
    $core.Iterable<$3.Struct>? repeatedStruct,
    $core.Iterable<$3.Value>? repeatedValue,
    $core.Iterable<$4.Int64Value>? repeatedInt64Wrapper,
    $core.Iterable<$4.Int32Value>? repeatedInt32Wrapper,
    $core.Iterable<$4.DoubleValue>? repeatedDoubleWrapper,
    $core.Iterable<$4.FloatValue>? repeatedFloatWrapper,
    $core.Iterable<$4.UInt64Value>? repeatedUint64Wrapper,
    $core.Iterable<$4.UInt32Value>? repeatedUint32Wrapper,
    $core.Iterable<$4.StringValue>? repeatedStringWrapper,
    $core.Iterable<$4.BoolValue>? repeatedBoolWrapper,
    $core.Iterable<$4.BytesValue>? repeatedBytesWrapper,
    $core.Iterable<$3.ListValue>? repeatedListValue,
    $core.Iterable<$3.NullValue>? repeatedNullValue,
    $core.Iterable<$core.MapEntry<$core.int, $fixnum.Int64>>? mapUint32Int64,
    $core.Iterable<$core.MapEntry<$core.int, $core.int>>? mapUint32Uint32,
    $core.Iterable<$core.MapEntry<$core.int, $fixnum.Int64>>? mapUint32Uint64,
    $core.Iterable<$core.MapEntry<$core.int, $core.double>>? mapUint32Float,
    $core.Iterable<$core.MapEntry<$core.int, $core.double>>? mapUint32Double,
    $core.Iterable<$core.MapEntry<$core.int, TestAllTypes_NestedEnum>>?
        mapUint32Enum,
    $core.Iterable<$core.MapEntry<$core.int, TestAllTypes_NestedMessage>>?
        mapUint32Message,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $core.bool>>? mapUint64Bool,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $core.String>>?
        mapUint64String,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $core.List<$core.int>>>?
        mapUint64Bytes,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $core.int>>? mapUint64Int32,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $fixnum.Int64>>?
        mapUint64Int64,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $core.int>>? mapUint64Uint32,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $fixnum.Int64>>?
        mapUint64Uint64,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $core.double>>? mapUint64Float,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $core.double>>?
        mapUint64Double,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, TestAllTypes_NestedEnum>>?
        mapUint64Enum,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, TestAllTypes_NestedMessage>>?
        mapUint64Message,
    $core.Iterable<$core.MapEntry<$core.String, $core.bool>>? mapStringBool,
    $core.Iterable<$core.MapEntry<$core.String, $core.List<$core.int>>>?
        mapStringBytes,
    $core.Iterable<$core.MapEntry<$core.String, $core.int>>? mapStringInt32,
    $core.Iterable<$core.MapEntry<$core.String, $fixnum.Int64>>? mapStringInt64,
    $core.Iterable<$core.MapEntry<$core.String, $core.int>>? mapStringUint32,
    $core.Iterable<$core.MapEntry<$core.String, $fixnum.Int64>>?
        mapStringUint64,
    $core.Iterable<$core.MapEntry<$core.String, $core.double>>? mapStringFloat,
    $core.Iterable<$core.MapEntry<$core.String, $core.double>>? mapStringDouble,
    $core.Iterable<$core.MapEntry<$core.String, TestAllTypes_NestedEnum>>?
        mapStringEnum,
    $core.Iterable<$core.MapEntry<$core.String, TestAllTypes_NestedMessage>>?
        mapStringMessage,
    $core.Iterable<$core.MapEntry<$core.bool, $1.Duration>>? mapBoolDuration,
    $core.Iterable<$core.MapEntry<$core.bool, $2.Timestamp>>? mapBoolTimestamp,
    $core.Iterable<$core.MapEntry<$core.bool, $3.NullValue>>? mapBoolNullValue,
    $core.Iterable<$core.MapEntry<$core.int, $1.Duration>>? mapInt32Duration,
    $core.Iterable<$core.MapEntry<$core.int, $2.Timestamp>>? mapInt32Timestamp,
    $core.Iterable<$core.MapEntry<$core.int, $3.NullValue>>? mapInt32NullValue,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $1.Duration>>?
        mapInt64Duration,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $2.Timestamp>>?
        mapInt64Timestamp,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $3.NullValue>>?
        mapInt64NullValue,
    $core.Iterable<$core.MapEntry<$core.int, $1.Duration>>? mapUint32Duration,
    $core.Iterable<$core.MapEntry<$core.int, $2.Timestamp>>? mapUint32Timestamp,
    $core.Iterable<$core.MapEntry<$core.int, $3.NullValue>>? mapUint32NullValue,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $1.Duration>>?
        mapUint64Duration,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $2.Timestamp>>?
        mapUint64Timestamp,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $3.NullValue>>?
        mapUint64NullValue,
    $core.Iterable<$core.MapEntry<$core.String, $1.Duration>>?
        mapStringDuration,
    $core.Iterable<$core.MapEntry<$core.String, $2.Timestamp>>?
        mapStringTimestamp,
    $core.Iterable<$core.MapEntry<$core.String, $3.NullValue>>?
        mapStringNullValue,
    $core.Iterable<$core.MapEntry<$core.bool, $0.Any>>? mapBoolAny,
    $core.Iterable<$core.MapEntry<$core.bool, $3.Struct>>? mapBoolStruct,
    $core.Iterable<$core.MapEntry<$core.bool, $3.Value>>? mapBoolValue,
    $core.Iterable<$core.MapEntry<$core.bool, $3.ListValue>>? mapBoolListValue,
    $core.Iterable<$core.MapEntry<$core.bool, $4.Int64Value>>?
        mapBoolInt64Wrapper,
    $core.Iterable<$core.MapEntry<$core.bool, $4.Int32Value>>?
        mapBoolInt32Wrapper,
    $core.Iterable<$core.MapEntry<$core.bool, $4.DoubleValue>>?
        mapBoolDoubleWrapper,
    $core.Iterable<$core.MapEntry<$core.bool, $4.FloatValue>>?
        mapBoolFloatWrapper,
    $core.Iterable<$core.MapEntry<$core.bool, $4.UInt64Value>>?
        mapBoolUint64Wrapper,
    $core.Iterable<$core.MapEntry<$core.bool, $4.UInt32Value>>?
        mapBoolUint32Wrapper,
    $core.Iterable<$core.MapEntry<$core.bool, $4.StringValue>>?
        mapBoolStringWrapper,
    $core.Iterable<$core.MapEntry<$core.bool, $4.BoolValue>>?
        mapBoolBoolWrapper,
    $core.Iterable<$core.MapEntry<$core.bool, $4.BytesValue>>?
        mapBoolBytesWrapper,
    $core.Iterable<$core.MapEntry<$core.int, $0.Any>>? mapInt32Any,
    $core.Iterable<$core.MapEntry<$core.int, $3.Struct>>? mapInt32Struct,
    $core.Iterable<$core.MapEntry<$core.int, $3.Value>>? mapInt32Value,
    $core.Iterable<$core.MapEntry<$core.int, $3.ListValue>>? mapInt32ListValue,
    $core.Iterable<$core.MapEntry<$core.int, $4.Int64Value>>?
        mapInt32Int64Wrapper,
    $core.Iterable<$core.MapEntry<$core.int, $4.Int32Value>>?
        mapInt32Int32Wrapper,
    $core.Iterable<$core.MapEntry<$core.int, $4.DoubleValue>>?
        mapInt32DoubleWrapper,
    $core.Iterable<$core.MapEntry<$core.int, $4.FloatValue>>?
        mapInt32FloatWrapper,
    $core.Iterable<$core.MapEntry<$core.int, $4.UInt64Value>>?
        mapInt32Uint64Wrapper,
    $core.Iterable<$core.MapEntry<$core.int, $4.UInt32Value>>?
        mapInt32Uint32Wrapper,
    $core.Iterable<$core.MapEntry<$core.int, $4.StringValue>>?
        mapInt32StringWrapper,
    $core.Iterable<$core.MapEntry<$core.int, $4.BoolValue>>?
        mapInt32BoolWrapper,
    $core.Iterable<$core.MapEntry<$core.int, $4.BytesValue>>?
        mapInt32BytesWrapper,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $0.Any>>? mapInt64Any,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $3.Struct>>? mapInt64Struct,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $3.Value>>? mapInt64Value,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $3.ListValue>>?
        mapInt64ListValue,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $4.Int64Value>>?
        mapInt64Int64Wrapper,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $4.Int32Value>>?
        mapInt64Int32Wrapper,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $4.DoubleValue>>?
        mapInt64DoubleWrapper,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $4.FloatValue>>?
        mapInt64FloatWrapper,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $4.UInt64Value>>?
        mapInt64Uint64Wrapper,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $4.UInt32Value>>?
        mapInt64Uint32Wrapper,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $4.StringValue>>?
        mapInt64StringWrapper,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $4.BoolValue>>?
        mapInt64BoolWrapper,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $4.BytesValue>>?
        mapInt64BytesWrapper,
    $core.Iterable<$core.MapEntry<$core.int, $0.Any>>? mapUint32Any,
    $core.Iterable<$core.MapEntry<$core.int, $3.Struct>>? mapUint32Struct,
    $core.Iterable<$core.MapEntry<$core.int, $3.Value>>? mapUint32Value,
    $core.Iterable<$core.MapEntry<$core.int, $3.ListValue>>? mapUint32ListValue,
    $core.Iterable<$core.MapEntry<$core.int, $4.Int64Value>>?
        mapUint32Int64Wrapper,
    $core.Iterable<$core.MapEntry<$core.int, $4.Int32Value>>?
        mapUint32Int32Wrapper,
    $core.Iterable<$core.MapEntry<$core.int, $4.DoubleValue>>?
        mapUint32DoubleWrapper,
    $core.Iterable<$core.MapEntry<$core.int, $4.FloatValue>>?
        mapUint32FloatWrapper,
    $core.Iterable<$core.MapEntry<$core.int, $4.UInt64Value>>?
        mapUint32Uint64Wrapper,
    $core.Iterable<$core.MapEntry<$core.int, $4.UInt32Value>>?
        mapUint32Uint32Wrapper,
    $core.Iterable<$core.MapEntry<$core.int, $4.StringValue>>?
        mapUint32StringWrapper,
    $core.Iterable<$core.MapEntry<$core.int, $4.BoolValue>>?
        mapUint32BoolWrapper,
    $core.Iterable<$core.MapEntry<$core.int, $4.BytesValue>>?
        mapUint32BytesWrapper,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $0.Any>>? mapUint64Any,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $3.Struct>>? mapUint64Struct,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $3.Value>>? mapUint64Value,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $3.ListValue>>?
        mapUint64ListValue,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $4.Int64Value>>?
        mapUint64Int64Wrapper,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $4.Int32Value>>?
        mapUint64Int32Wrapper,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $4.DoubleValue>>?
        mapUint64DoubleWrapper,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $4.FloatValue>>?
        mapUint64FloatWrapper,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $4.UInt64Value>>?
        mapUint64Uint64Wrapper,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $4.UInt32Value>>?
        mapUint64Uint32Wrapper,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $4.StringValue>>?
        mapUint64StringWrapper,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $4.BoolValue>>?
        mapUint64BoolWrapper,
    $core.Iterable<$core.MapEntry<$fixnum.Int64, $4.BytesValue>>?
        mapUint64BytesWrapper,
    $core.Iterable<$core.MapEntry<$core.String, $0.Any>>? mapStringAny,
    $core.Iterable<$core.MapEntry<$core.String, $3.Struct>>? mapStringStruct,
    $core.Iterable<$core.MapEntry<$core.String, $3.Value>>? mapStringValue,
    $core.Iterable<$core.MapEntry<$core.String, $3.ListValue>>?
        mapStringListValue,
    $core.Iterable<$core.MapEntry<$core.String, $4.Int64Value>>?
        mapStringInt64Wrapper,
    $core.Iterable<$core.MapEntry<$core.String, $4.Int32Value>>?
        mapStringInt32Wrapper,
    $core.Iterable<$core.MapEntry<$core.String, $4.DoubleValue>>?
        mapStringDoubleWrapper,
    $core.Iterable<$core.MapEntry<$core.String, $4.FloatValue>>?
        mapStringFloatWrapper,
    $core.Iterable<$core.MapEntry<$core.String, $4.UInt64Value>>?
        mapStringUint64Wrapper,
    $core.Iterable<$core.MapEntry<$core.String, $4.UInt32Value>>?
        mapStringUint32Wrapper,
    $core.Iterable<$core.MapEntry<$core.String, $4.StringValue>>?
        mapStringStringWrapper,
    $core.Iterable<$core.MapEntry<$core.String, $4.BoolValue>>?
        mapStringBoolWrapper,
    $core.Iterable<$core.MapEntry<$core.String, $4.BytesValue>>?
        mapStringBytesWrapper,
    NestedTestAllTypes? oneofType,
    TestAllTypes_NestedMessage? oneofMsg,
    $core.bool? oneofBool,
    TestAllTypes_NestedGroup? nestedGroup,
  }) {
    final result = create();
    if (singleInt32 != null) result.singleInt32 = singleInt32;
    if (singleInt64 != null) result.singleInt64 = singleInt64;
    if (singleUint32 != null) result.singleUint32 = singleUint32;
    if (singleUint64 != null) result.singleUint64 = singleUint64;
    if (singleSint32 != null) result.singleSint32 = singleSint32;
    if (singleSint64 != null) result.singleSint64 = singleSint64;
    if (singleFixed32 != null) result.singleFixed32 = singleFixed32;
    if (singleFixed64 != null) result.singleFixed64 = singleFixed64;
    if (singleSfixed32 != null) result.singleSfixed32 = singleSfixed32;
    if (singleSfixed64 != null) result.singleSfixed64 = singleSfixed64;
    if (singleFloat != null) result.singleFloat = singleFloat;
    if (singleDouble != null) result.singleDouble = singleDouble;
    if (singleBool != null) result.singleBool = singleBool;
    if (singleString != null) result.singleString = singleString;
    if (singleBytes != null) result.singleBytes = singleBytes;
    if (in_18 != null) result.in_18 = in_18;
    if (singleNestedMessage != null)
      result.singleNestedMessage = singleNestedMessage;
    if (singleNestedEnum != null) result.singleNestedEnum = singleNestedEnum;
    if (standaloneMessage != null) result.standaloneMessage = standaloneMessage;
    if (standaloneEnum != null) result.standaloneEnum = standaloneEnum;
    if (repeatedInt32 != null) result.repeatedInt32.addAll(repeatedInt32);
    if (repeatedInt64 != null) result.repeatedInt64.addAll(repeatedInt64);
    if (repeatedUint32 != null) result.repeatedUint32.addAll(repeatedUint32);
    if (repeatedUint64 != null) result.repeatedUint64.addAll(repeatedUint64);
    if (repeatedSint32 != null) result.repeatedSint32.addAll(repeatedSint32);
    if (repeatedSint64 != null) result.repeatedSint64.addAll(repeatedSint64);
    if (repeatedFixed32 != null) result.repeatedFixed32.addAll(repeatedFixed32);
    if (repeatedFixed64 != null) result.repeatedFixed64.addAll(repeatedFixed64);
    if (repeatedSfixed32 != null)
      result.repeatedSfixed32.addAll(repeatedSfixed32);
    if (repeatedSfixed64 != null)
      result.repeatedSfixed64.addAll(repeatedSfixed64);
    if (repeatedFloat != null) result.repeatedFloat.addAll(repeatedFloat);
    if (repeatedDouble != null) result.repeatedDouble.addAll(repeatedDouble);
    if (repeatedBool != null) result.repeatedBool.addAll(repeatedBool);
    if (repeatedString != null) result.repeatedString.addAll(repeatedString);
    if (repeatedBytes != null) result.repeatedBytes.addAll(repeatedBytes);
    if (repeatedNestedMessage != null)
      result.repeatedNestedMessage.addAll(repeatedNestedMessage);
    if (repeatedNestedEnum != null)
      result.repeatedNestedEnum.addAll(repeatedNestedEnum);
    if (repeatedStringPiece != null)
      result.repeatedStringPiece.addAll(repeatedStringPiece);
    if (repeatedCord != null) result.repeatedCord.addAll(repeatedCord);
    if (repeatedLazyMessage != null)
      result.repeatedLazyMessage.addAll(repeatedLazyMessage);
    if (mapStringString != null)
      result.mapStringString.addEntries(mapStringString);
    if (mapInt64NestedType != null)
      result.mapInt64NestedType.addEntries(mapInt64NestedType);
    if (mapBoolBool != null) result.mapBoolBool.addEntries(mapBoolBool);
    if (mapBoolString != null) result.mapBoolString.addEntries(mapBoolString);
    if (mapBoolBytes != null) result.mapBoolBytes.addEntries(mapBoolBytes);
    if (mapBoolInt32 != null) result.mapBoolInt32.addEntries(mapBoolInt32);
    if (mapBoolInt64 != null) result.mapBoolInt64.addEntries(mapBoolInt64);
    if (mapBoolUint32 != null) result.mapBoolUint32.addEntries(mapBoolUint32);
    if (mapBoolUint64 != null) result.mapBoolUint64.addEntries(mapBoolUint64);
    if (mapBoolFloat != null) result.mapBoolFloat.addEntries(mapBoolFloat);
    if (mapBoolDouble != null) result.mapBoolDouble.addEntries(mapBoolDouble);
    if (mapBoolEnum != null) result.mapBoolEnum.addEntries(mapBoolEnum);
    if (mapBoolMessage != null)
      result.mapBoolMessage.addEntries(mapBoolMessage);
    if (mapInt32Bool != null) result.mapInt32Bool.addEntries(mapInt32Bool);
    if (mapInt32String != null)
      result.mapInt32String.addEntries(mapInt32String);
    if (mapInt32Bytes != null) result.mapInt32Bytes.addEntries(mapInt32Bytes);
    if (mapInt32Int32 != null) result.mapInt32Int32.addEntries(mapInt32Int32);
    if (mapInt32Int64 != null) result.mapInt32Int64.addEntries(mapInt32Int64);
    if (mapInt32Uint32 != null)
      result.mapInt32Uint32.addEntries(mapInt32Uint32);
    if (mapInt32Uint64 != null)
      result.mapInt32Uint64.addEntries(mapInt32Uint64);
    if (mapInt32Float != null) result.mapInt32Float.addEntries(mapInt32Float);
    if (mapInt32Double != null)
      result.mapInt32Double.addEntries(mapInt32Double);
    if (mapInt32Enum != null) result.mapInt32Enum.addEntries(mapInt32Enum);
    if (mapInt32Message != null)
      result.mapInt32Message.addEntries(mapInt32Message);
    if (mapInt64Bool != null) result.mapInt64Bool.addEntries(mapInt64Bool);
    if (mapInt64String != null)
      result.mapInt64String.addEntries(mapInt64String);
    if (mapInt64Bytes != null) result.mapInt64Bytes.addEntries(mapInt64Bytes);
    if (mapInt64Int32 != null) result.mapInt64Int32.addEntries(mapInt64Int32);
    if (mapInt64Int64 != null) result.mapInt64Int64.addEntries(mapInt64Int64);
    if (mapInt64Uint32 != null)
      result.mapInt64Uint32.addEntries(mapInt64Uint32);
    if (mapInt64Uint64 != null)
      result.mapInt64Uint64.addEntries(mapInt64Uint64);
    if (mapInt64Float != null) result.mapInt64Float.addEntries(mapInt64Float);
    if (mapInt64Double != null)
      result.mapInt64Double.addEntries(mapInt64Double);
    if (mapInt64Enum != null) result.mapInt64Enum.addEntries(mapInt64Enum);
    if (mapInt64Message != null)
      result.mapInt64Message.addEntries(mapInt64Message);
    if (mapUint32Bool != null) result.mapUint32Bool.addEntries(mapUint32Bool);
    if (mapUint32String != null)
      result.mapUint32String.addEntries(mapUint32String);
    if (mapUint32Bytes != null)
      result.mapUint32Bytes.addEntries(mapUint32Bytes);
    if (mapUint32Int32 != null)
      result.mapUint32Int32.addEntries(mapUint32Int32);
    if (singleAny != null) result.singleAny = singleAny;
    if (singleDuration != null) result.singleDuration = singleDuration;
    if (singleTimestamp != null) result.singleTimestamp = singleTimestamp;
    if (singleStruct != null) result.singleStruct = singleStruct;
    if (singleValue != null) result.singleValue = singleValue;
    if (singleInt64Wrapper != null)
      result.singleInt64Wrapper = singleInt64Wrapper;
    if (singleInt32Wrapper != null)
      result.singleInt32Wrapper = singleInt32Wrapper;
    if (singleDoubleWrapper != null)
      result.singleDoubleWrapper = singleDoubleWrapper;
    if (singleFloatWrapper != null)
      result.singleFloatWrapper = singleFloatWrapper;
    if (singleUint64Wrapper != null)
      result.singleUint64Wrapper = singleUint64Wrapper;
    if (singleUint32Wrapper != null)
      result.singleUint32Wrapper = singleUint32Wrapper;
    if (singleStringWrapper != null)
      result.singleStringWrapper = singleStringWrapper;
    if (singleBoolWrapper != null) result.singleBoolWrapper = singleBoolWrapper;
    if (singleBytesWrapper != null)
      result.singleBytesWrapper = singleBytesWrapper;
    if (listValue != null) result.listValue = listValue;
    if (nullValue != null) result.nullValue = nullValue;
    if (optionalNullValue != null) result.optionalNullValue = optionalNullValue;
    if (fieldMask != null) result.fieldMask = fieldMask;
    if (empty != null) result.empty = empty;
    if (repeatedAny != null) result.repeatedAny.addAll(repeatedAny);
    if (repeatedDuration != null)
      result.repeatedDuration.addAll(repeatedDuration);
    if (repeatedTimestamp != null)
      result.repeatedTimestamp.addAll(repeatedTimestamp);
    if (repeatedStruct != null) result.repeatedStruct.addAll(repeatedStruct);
    if (repeatedValue != null) result.repeatedValue.addAll(repeatedValue);
    if (repeatedInt64Wrapper != null)
      result.repeatedInt64Wrapper.addAll(repeatedInt64Wrapper);
    if (repeatedInt32Wrapper != null)
      result.repeatedInt32Wrapper.addAll(repeatedInt32Wrapper);
    if (repeatedDoubleWrapper != null)
      result.repeatedDoubleWrapper.addAll(repeatedDoubleWrapper);
    if (repeatedFloatWrapper != null)
      result.repeatedFloatWrapper.addAll(repeatedFloatWrapper);
    if (repeatedUint64Wrapper != null)
      result.repeatedUint64Wrapper.addAll(repeatedUint64Wrapper);
    if (repeatedUint32Wrapper != null)
      result.repeatedUint32Wrapper.addAll(repeatedUint32Wrapper);
    if (repeatedStringWrapper != null)
      result.repeatedStringWrapper.addAll(repeatedStringWrapper);
    if (repeatedBoolWrapper != null)
      result.repeatedBoolWrapper.addAll(repeatedBoolWrapper);
    if (repeatedBytesWrapper != null)
      result.repeatedBytesWrapper.addAll(repeatedBytesWrapper);
    if (repeatedListValue != null)
      result.repeatedListValue.addAll(repeatedListValue);
    if (repeatedNullValue != null)
      result.repeatedNullValue.addAll(repeatedNullValue);
    if (mapUint32Int64 != null)
      result.mapUint32Int64.addEntries(mapUint32Int64);
    if (mapUint32Uint32 != null)
      result.mapUint32Uint32.addEntries(mapUint32Uint32);
    if (mapUint32Uint64 != null)
      result.mapUint32Uint64.addEntries(mapUint32Uint64);
    if (mapUint32Float != null)
      result.mapUint32Float.addEntries(mapUint32Float);
    if (mapUint32Double != null)
      result.mapUint32Double.addEntries(mapUint32Double);
    if (mapUint32Enum != null) result.mapUint32Enum.addEntries(mapUint32Enum);
    if (mapUint32Message != null)
      result.mapUint32Message.addEntries(mapUint32Message);
    if (mapUint64Bool != null) result.mapUint64Bool.addEntries(mapUint64Bool);
    if (mapUint64String != null)
      result.mapUint64String.addEntries(mapUint64String);
    if (mapUint64Bytes != null)
      result.mapUint64Bytes.addEntries(mapUint64Bytes);
    if (mapUint64Int32 != null)
      result.mapUint64Int32.addEntries(mapUint64Int32);
    if (mapUint64Int64 != null)
      result.mapUint64Int64.addEntries(mapUint64Int64);
    if (mapUint64Uint32 != null)
      result.mapUint64Uint32.addEntries(mapUint64Uint32);
    if (mapUint64Uint64 != null)
      result.mapUint64Uint64.addEntries(mapUint64Uint64);
    if (mapUint64Float != null)
      result.mapUint64Float.addEntries(mapUint64Float);
    if (mapUint64Double != null)
      result.mapUint64Double.addEntries(mapUint64Double);
    if (mapUint64Enum != null) result.mapUint64Enum.addEntries(mapUint64Enum);
    if (mapUint64Message != null)
      result.mapUint64Message.addEntries(mapUint64Message);
    if (mapStringBool != null) result.mapStringBool.addEntries(mapStringBool);
    if (mapStringBytes != null)
      result.mapStringBytes.addEntries(mapStringBytes);
    if (mapStringInt32 != null)
      result.mapStringInt32.addEntries(mapStringInt32);
    if (mapStringInt64 != null)
      result.mapStringInt64.addEntries(mapStringInt64);
    if (mapStringUint32 != null)
      result.mapStringUint32.addEntries(mapStringUint32);
    if (mapStringUint64 != null)
      result.mapStringUint64.addEntries(mapStringUint64);
    if (mapStringFloat != null)
      result.mapStringFloat.addEntries(mapStringFloat);
    if (mapStringDouble != null)
      result.mapStringDouble.addEntries(mapStringDouble);
    if (mapStringEnum != null) result.mapStringEnum.addEntries(mapStringEnum);
    if (mapStringMessage != null)
      result.mapStringMessage.addEntries(mapStringMessage);
    if (mapBoolDuration != null)
      result.mapBoolDuration.addEntries(mapBoolDuration);
    if (mapBoolTimestamp != null)
      result.mapBoolTimestamp.addEntries(mapBoolTimestamp);
    if (mapBoolNullValue != null)
      result.mapBoolNullValue.addEntries(mapBoolNullValue);
    if (mapInt32Duration != null)
      result.mapInt32Duration.addEntries(mapInt32Duration);
    if (mapInt32Timestamp != null)
      result.mapInt32Timestamp.addEntries(mapInt32Timestamp);
    if (mapInt32NullValue != null)
      result.mapInt32NullValue.addEntries(mapInt32NullValue);
    if (mapInt64Duration != null)
      result.mapInt64Duration.addEntries(mapInt64Duration);
    if (mapInt64Timestamp != null)
      result.mapInt64Timestamp.addEntries(mapInt64Timestamp);
    if (mapInt64NullValue != null)
      result.mapInt64NullValue.addEntries(mapInt64NullValue);
    if (mapUint32Duration != null)
      result.mapUint32Duration.addEntries(mapUint32Duration);
    if (mapUint32Timestamp != null)
      result.mapUint32Timestamp.addEntries(mapUint32Timestamp);
    if (mapUint32NullValue != null)
      result.mapUint32NullValue.addEntries(mapUint32NullValue);
    if (mapUint64Duration != null)
      result.mapUint64Duration.addEntries(mapUint64Duration);
    if (mapUint64Timestamp != null)
      result.mapUint64Timestamp.addEntries(mapUint64Timestamp);
    if (mapUint64NullValue != null)
      result.mapUint64NullValue.addEntries(mapUint64NullValue);
    if (mapStringDuration != null)
      result.mapStringDuration.addEntries(mapStringDuration);
    if (mapStringTimestamp != null)
      result.mapStringTimestamp.addEntries(mapStringTimestamp);
    if (mapStringNullValue != null)
      result.mapStringNullValue.addEntries(mapStringNullValue);
    if (mapBoolAny != null) result.mapBoolAny.addEntries(mapBoolAny);
    if (mapBoolStruct != null) result.mapBoolStruct.addEntries(mapBoolStruct);
    if (mapBoolValue != null) result.mapBoolValue.addEntries(mapBoolValue);
    if (mapBoolListValue != null)
      result.mapBoolListValue.addEntries(mapBoolListValue);
    if (mapBoolInt64Wrapper != null)
      result.mapBoolInt64Wrapper.addEntries(mapBoolInt64Wrapper);
    if (mapBoolInt32Wrapper != null)
      result.mapBoolInt32Wrapper.addEntries(mapBoolInt32Wrapper);
    if (mapBoolDoubleWrapper != null)
      result.mapBoolDoubleWrapper.addEntries(mapBoolDoubleWrapper);
    if (mapBoolFloatWrapper != null)
      result.mapBoolFloatWrapper.addEntries(mapBoolFloatWrapper);
    if (mapBoolUint64Wrapper != null)
      result.mapBoolUint64Wrapper.addEntries(mapBoolUint64Wrapper);
    if (mapBoolUint32Wrapper != null)
      result.mapBoolUint32Wrapper.addEntries(mapBoolUint32Wrapper);
    if (mapBoolStringWrapper != null)
      result.mapBoolStringWrapper.addEntries(mapBoolStringWrapper);
    if (mapBoolBoolWrapper != null)
      result.mapBoolBoolWrapper.addEntries(mapBoolBoolWrapper);
    if (mapBoolBytesWrapper != null)
      result.mapBoolBytesWrapper.addEntries(mapBoolBytesWrapper);
    if (mapInt32Any != null) result.mapInt32Any.addEntries(mapInt32Any);
    if (mapInt32Struct != null)
      result.mapInt32Struct.addEntries(mapInt32Struct);
    if (mapInt32Value != null) result.mapInt32Value.addEntries(mapInt32Value);
    if (mapInt32ListValue != null)
      result.mapInt32ListValue.addEntries(mapInt32ListValue);
    if (mapInt32Int64Wrapper != null)
      result.mapInt32Int64Wrapper.addEntries(mapInt32Int64Wrapper);
    if (mapInt32Int32Wrapper != null)
      result.mapInt32Int32Wrapper.addEntries(mapInt32Int32Wrapper);
    if (mapInt32DoubleWrapper != null)
      result.mapInt32DoubleWrapper.addEntries(mapInt32DoubleWrapper);
    if (mapInt32FloatWrapper != null)
      result.mapInt32FloatWrapper.addEntries(mapInt32FloatWrapper);
    if (mapInt32Uint64Wrapper != null)
      result.mapInt32Uint64Wrapper.addEntries(mapInt32Uint64Wrapper);
    if (mapInt32Uint32Wrapper != null)
      result.mapInt32Uint32Wrapper.addEntries(mapInt32Uint32Wrapper);
    if (mapInt32StringWrapper != null)
      result.mapInt32StringWrapper.addEntries(mapInt32StringWrapper);
    if (mapInt32BoolWrapper != null)
      result.mapInt32BoolWrapper.addEntries(mapInt32BoolWrapper);
    if (mapInt32BytesWrapper != null)
      result.mapInt32BytesWrapper.addEntries(mapInt32BytesWrapper);
    if (mapInt64Any != null) result.mapInt64Any.addEntries(mapInt64Any);
    if (mapInt64Struct != null)
      result.mapInt64Struct.addEntries(mapInt64Struct);
    if (mapInt64Value != null) result.mapInt64Value.addEntries(mapInt64Value);
    if (mapInt64ListValue != null)
      result.mapInt64ListValue.addEntries(mapInt64ListValue);
    if (mapInt64Int64Wrapper != null)
      result.mapInt64Int64Wrapper.addEntries(mapInt64Int64Wrapper);
    if (mapInt64Int32Wrapper != null)
      result.mapInt64Int32Wrapper.addEntries(mapInt64Int32Wrapper);
    if (mapInt64DoubleWrapper != null)
      result.mapInt64DoubleWrapper.addEntries(mapInt64DoubleWrapper);
    if (mapInt64FloatWrapper != null)
      result.mapInt64FloatWrapper.addEntries(mapInt64FloatWrapper);
    if (mapInt64Uint64Wrapper != null)
      result.mapInt64Uint64Wrapper.addEntries(mapInt64Uint64Wrapper);
    if (mapInt64Uint32Wrapper != null)
      result.mapInt64Uint32Wrapper.addEntries(mapInt64Uint32Wrapper);
    if (mapInt64StringWrapper != null)
      result.mapInt64StringWrapper.addEntries(mapInt64StringWrapper);
    if (mapInt64BoolWrapper != null)
      result.mapInt64BoolWrapper.addEntries(mapInt64BoolWrapper);
    if (mapInt64BytesWrapper != null)
      result.mapInt64BytesWrapper.addEntries(mapInt64BytesWrapper);
    if (mapUint32Any != null) result.mapUint32Any.addEntries(mapUint32Any);
    if (mapUint32Struct != null)
      result.mapUint32Struct.addEntries(mapUint32Struct);
    if (mapUint32Value != null)
      result.mapUint32Value.addEntries(mapUint32Value);
    if (mapUint32ListValue != null)
      result.mapUint32ListValue.addEntries(mapUint32ListValue);
    if (mapUint32Int64Wrapper != null)
      result.mapUint32Int64Wrapper.addEntries(mapUint32Int64Wrapper);
    if (mapUint32Int32Wrapper != null)
      result.mapUint32Int32Wrapper.addEntries(mapUint32Int32Wrapper);
    if (mapUint32DoubleWrapper != null)
      result.mapUint32DoubleWrapper.addEntries(mapUint32DoubleWrapper);
    if (mapUint32FloatWrapper != null)
      result.mapUint32FloatWrapper.addEntries(mapUint32FloatWrapper);
    if (mapUint32Uint64Wrapper != null)
      result.mapUint32Uint64Wrapper.addEntries(mapUint32Uint64Wrapper);
    if (mapUint32Uint32Wrapper != null)
      result.mapUint32Uint32Wrapper.addEntries(mapUint32Uint32Wrapper);
    if (mapUint32StringWrapper != null)
      result.mapUint32StringWrapper.addEntries(mapUint32StringWrapper);
    if (mapUint32BoolWrapper != null)
      result.mapUint32BoolWrapper.addEntries(mapUint32BoolWrapper);
    if (mapUint32BytesWrapper != null)
      result.mapUint32BytesWrapper.addEntries(mapUint32BytesWrapper);
    if (mapUint64Any != null) result.mapUint64Any.addEntries(mapUint64Any);
    if (mapUint64Struct != null)
      result.mapUint64Struct.addEntries(mapUint64Struct);
    if (mapUint64Value != null)
      result.mapUint64Value.addEntries(mapUint64Value);
    if (mapUint64ListValue != null)
      result.mapUint64ListValue.addEntries(mapUint64ListValue);
    if (mapUint64Int64Wrapper != null)
      result.mapUint64Int64Wrapper.addEntries(mapUint64Int64Wrapper);
    if (mapUint64Int32Wrapper != null)
      result.mapUint64Int32Wrapper.addEntries(mapUint64Int32Wrapper);
    if (mapUint64DoubleWrapper != null)
      result.mapUint64DoubleWrapper.addEntries(mapUint64DoubleWrapper);
    if (mapUint64FloatWrapper != null)
      result.mapUint64FloatWrapper.addEntries(mapUint64FloatWrapper);
    if (mapUint64Uint64Wrapper != null)
      result.mapUint64Uint64Wrapper.addEntries(mapUint64Uint64Wrapper);
    if (mapUint64Uint32Wrapper != null)
      result.mapUint64Uint32Wrapper.addEntries(mapUint64Uint32Wrapper);
    if (mapUint64StringWrapper != null)
      result.mapUint64StringWrapper.addEntries(mapUint64StringWrapper);
    if (mapUint64BoolWrapper != null)
      result.mapUint64BoolWrapper.addEntries(mapUint64BoolWrapper);
    if (mapUint64BytesWrapper != null)
      result.mapUint64BytesWrapper.addEntries(mapUint64BytesWrapper);
    if (mapStringAny != null) result.mapStringAny.addEntries(mapStringAny);
    if (mapStringStruct != null)
      result.mapStringStruct.addEntries(mapStringStruct);
    if (mapStringValue != null)
      result.mapStringValue.addEntries(mapStringValue);
    if (mapStringListValue != null)
      result.mapStringListValue.addEntries(mapStringListValue);
    if (mapStringInt64Wrapper != null)
      result.mapStringInt64Wrapper.addEntries(mapStringInt64Wrapper);
    if (mapStringInt32Wrapper != null)
      result.mapStringInt32Wrapper.addEntries(mapStringInt32Wrapper);
    if (mapStringDoubleWrapper != null)
      result.mapStringDoubleWrapper.addEntries(mapStringDoubleWrapper);
    if (mapStringFloatWrapper != null)
      result.mapStringFloatWrapper.addEntries(mapStringFloatWrapper);
    if (mapStringUint64Wrapper != null)
      result.mapStringUint64Wrapper.addEntries(mapStringUint64Wrapper);
    if (mapStringUint32Wrapper != null)
      result.mapStringUint32Wrapper.addEntries(mapStringUint32Wrapper);
    if (mapStringStringWrapper != null)
      result.mapStringStringWrapper.addEntries(mapStringStringWrapper);
    if (mapStringBoolWrapper != null)
      result.mapStringBoolWrapper.addEntries(mapStringBoolWrapper);
    if (mapStringBytesWrapper != null)
      result.mapStringBytesWrapper.addEntries(mapStringBytesWrapper);
    if (oneofType != null) result.oneofType = oneofType;
    if (oneofMsg != null) result.oneofMsg = oneofMsg;
    if (oneofBool != null) result.oneofBool = oneofBool;
    if (nestedGroup != null) result.nestedGroup = nestedGroup;
    return result;
  }

  TestAllTypes._();

  factory TestAllTypes.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TestAllTypes.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, TestAllTypes_NestedType>
      _TestAllTypes_NestedTypeByTag = {
    21: TestAllTypes_NestedType.singleNestedMessage,
    22: TestAllTypes_NestedType.singleNestedEnum,
    0: TestAllTypes_NestedType.notSet
  };
  static const $core.Map<$core.int, TestAllTypes_Kind> _TestAllTypes_KindByTag =
      {
    400: TestAllTypes_Kind.oneofType,
    401: TestAllTypes_Kind.oneofMsg,
    402: TestAllTypes_Kind.oneofBool,
    0: TestAllTypes_Kind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TestAllTypes',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'cel.expr.conformance.proto2'),
      createEmptyInstance: create)
    ..oo(0, [21, 22])
    ..oo(1, [400, 401, 402])
    ..a<$core.int>(1, _omitFieldNames ? '' : 'singleInt32', $pb.PbFieldType.O3,
        defaultOrMaker: -32)
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'singleInt64', $pb.PbFieldType.O6,
        defaultOrMaker: $pb.parseLongInt('-64'))
    ..a<$core.int>(
        3, _omitFieldNames ? '' : 'singleUint32', $pb.PbFieldType.OU3,
        defaultOrMaker: 32)
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'singleUint64', $pb.PbFieldType.OU6,
        defaultOrMaker: $pb.parseLongInt('64'))
    ..a<$core.int>(
        5, _omitFieldNames ? '' : 'singleSint32', $pb.PbFieldType.OS3)
    ..a<$fixnum.Int64>(
        6, _omitFieldNames ? '' : 'singleSint64', $pb.PbFieldType.OS6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(
        7, _omitFieldNames ? '' : 'singleFixed32', $pb.PbFieldType.OF3)
    ..a<$fixnum.Int64>(
        8, _omitFieldNames ? '' : 'singleFixed64', $pb.PbFieldType.OF6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(
        9, _omitFieldNames ? '' : 'singleSfixed32', $pb.PbFieldType.OSF3)
    ..a<$fixnum.Int64>(
        10, _omitFieldNames ? '' : 'singleSfixed64', $pb.PbFieldType.OSF6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.double>(
        11, _omitFieldNames ? '' : 'singleFloat', $pb.PbFieldType.OF,
        defaultOrMaker: 3.0)
    ..a<$core.double>(
        12, _omitFieldNames ? '' : 'singleDouble', $pb.PbFieldType.OD,
        defaultOrMaker: 6.4)
    ..a<$core.bool>(13, _omitFieldNames ? '' : 'singleBool', $pb.PbFieldType.OB,
        defaultOrMaker: true)
    ..a<$core.String>(
        14, _omitFieldNames ? '' : 'singleString', $pb.PbFieldType.OS,
        defaultOrMaker: 'empty')
    ..a<$core.List<$core.int>>(
        15, _omitFieldNames ? '' : 'singleBytes', $pb.PbFieldType.OY,
        defaultOrMaker: () => <$core.int>[0x6e, 0x6f, 0x6e, 0x65])
    ..aOB(18, _omitFieldNames ? '' : 'in')
    ..aOM<TestAllTypes_NestedMessage>(
        21, _omitFieldNames ? '' : 'singleNestedMessage',
        subBuilder: TestAllTypes_NestedMessage.create)
    ..e<TestAllTypes_NestedEnum>(
        22, _omitFieldNames ? '' : 'singleNestedEnum', $pb.PbFieldType.OE,
        defaultOrMaker: TestAllTypes_NestedEnum.BAR,
        valueOf: TestAllTypes_NestedEnum.valueOf,
        enumValues: TestAllTypes_NestedEnum.values)
    ..aOM<TestAllTypes_NestedMessage>(
        23, _omitFieldNames ? '' : 'standaloneMessage',
        subBuilder: TestAllTypes_NestedMessage.create)
    ..e<TestAllTypes_NestedEnum>(
        24, _omitFieldNames ? '' : 'standaloneEnum', $pb.PbFieldType.OE,
        defaultOrMaker: TestAllTypes_NestedEnum.FOO,
        valueOf: TestAllTypes_NestedEnum.valueOf,
        enumValues: TestAllTypes_NestedEnum.values)
    ..p<$core.int>(
        31, _omitFieldNames ? '' : 'repeatedInt32', $pb.PbFieldType.P3)
    ..p<$fixnum.Int64>(
        32, _omitFieldNames ? '' : 'repeatedInt64', $pb.PbFieldType.P6)
    ..p<$core.int>(
        33, _omitFieldNames ? '' : 'repeatedUint32', $pb.PbFieldType.PU3)
    ..p<$fixnum.Int64>(
        34, _omitFieldNames ? '' : 'repeatedUint64', $pb.PbFieldType.PU6)
    ..p<$core.int>(
        35, _omitFieldNames ? '' : 'repeatedSint32', $pb.PbFieldType.PS3)
    ..p<$fixnum.Int64>(
        36, _omitFieldNames ? '' : 'repeatedSint64', $pb.PbFieldType.PS6)
    ..p<$core.int>(
        37, _omitFieldNames ? '' : 'repeatedFixed32', $pb.PbFieldType.PF3)
    ..p<$fixnum.Int64>(
        38, _omitFieldNames ? '' : 'repeatedFixed64', $pb.PbFieldType.PF6)
    ..p<$core.int>(
        39, _omitFieldNames ? '' : 'repeatedSfixed32', $pb.PbFieldType.PSF3)
    ..p<$fixnum.Int64>(
        40, _omitFieldNames ? '' : 'repeatedSfixed64', $pb.PbFieldType.PSF6)
    ..p<$core.double>(
        41, _omitFieldNames ? '' : 'repeatedFloat', $pb.PbFieldType.PF)
    ..p<$core.double>(
        42, _omitFieldNames ? '' : 'repeatedDouble', $pb.PbFieldType.PD)
    ..p<$core.bool>(
        43, _omitFieldNames ? '' : 'repeatedBool', $pb.PbFieldType.PB)
    ..pPS(44, _omitFieldNames ? '' : 'repeatedString')
    ..p<$core.List<$core.int>>(
        45, _omitFieldNames ? '' : 'repeatedBytes', $pb.PbFieldType.PY)
    ..pc<TestAllTypes_NestedMessage>(
        51, _omitFieldNames ? '' : 'repeatedNestedMessage', $pb.PbFieldType.PM,
        subBuilder: TestAllTypes_NestedMessage.create)
    ..pc<TestAllTypes_NestedEnum>(
        52, _omitFieldNames ? '' : 'repeatedNestedEnum', $pb.PbFieldType.PE,
        valueOf: TestAllTypes_NestedEnum.valueOf,
        enumValues: TestAllTypes_NestedEnum.values,
        defaultEnumValue: TestAllTypes_NestedEnum.FOO)
    ..pPS(53, _omitFieldNames ? '' : 'repeatedStringPiece')
    ..pPS(54, _omitFieldNames ? '' : 'repeatedCord')
    ..pc<TestAllTypes_NestedMessage>(
        55, _omitFieldNames ? '' : 'repeatedLazyMessage', $pb.PbFieldType.PM,
        subBuilder: TestAllTypes_NestedMessage.create)
    ..m<$core.String, $core.String>(
        61, _omitFieldNames ? '' : 'mapStringString',
        entryClassName: 'TestAllTypes.MapStringStringEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, NestedTestAllTypes>(
        62, _omitFieldNames ? '' : 'mapInt64NestedType',
        entryClassName: 'TestAllTypes.MapInt64NestedTypeEntry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: NestedTestAllTypes.create,
        valueDefaultOrMaker: NestedTestAllTypes.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.bool, $core.bool>(63, _omitFieldNames ? '' : 'mapBoolBool',
        entryClassName: 'TestAllTypes.MapBoolBoolEntry',
        keyFieldType: $pb.PbFieldType.OB,
        valueFieldType: $pb.PbFieldType.OB,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.bool, $core.String>(64, _omitFieldNames ? '' : 'mapBoolString',
        entryClassName: 'TestAllTypes.MapBoolStringEntry',
        keyFieldType: $pb.PbFieldType.OB,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.bool, $core.List<$core.int>>(
        65, _omitFieldNames ? '' : 'mapBoolBytes',
        entryClassName: 'TestAllTypes.MapBoolBytesEntry',
        keyFieldType: $pb.PbFieldType.OB,
        valueFieldType: $pb.PbFieldType.OY,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.bool, $core.int>(66, _omitFieldNames ? '' : 'mapBoolInt32',
        entryClassName: 'TestAllTypes.MapBoolInt32Entry',
        keyFieldType: $pb.PbFieldType.OB,
        valueFieldType: $pb.PbFieldType.O3,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.bool, $fixnum.Int64>(67, _omitFieldNames ? '' : 'mapBoolInt64',
        entryClassName: 'TestAllTypes.MapBoolInt64Entry',
        keyFieldType: $pb.PbFieldType.OB,
        valueFieldType: $pb.PbFieldType.O6,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.bool, $core.int>(68, _omitFieldNames ? '' : 'mapBoolUint32',
        entryClassName: 'TestAllTypes.MapBoolUint32Entry',
        keyFieldType: $pb.PbFieldType.OB,
        valueFieldType: $pb.PbFieldType.OU3,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.bool, $fixnum.Int64>(69, _omitFieldNames ? '' : 'mapBoolUint64',
        entryClassName: 'TestAllTypes.MapBoolUint64Entry',
        keyFieldType: $pb.PbFieldType.OB,
        valueFieldType: $pb.PbFieldType.OU6,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.bool, $core.double>(70, _omitFieldNames ? '' : 'mapBoolFloat',
        entryClassName: 'TestAllTypes.MapBoolFloatEntry',
        keyFieldType: $pb.PbFieldType.OB,
        valueFieldType: $pb.PbFieldType.OF,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.bool, $core.double>(71, _omitFieldNames ? '' : 'mapBoolDouble',
        entryClassName: 'TestAllTypes.MapBoolDoubleEntry',
        keyFieldType: $pb.PbFieldType.OB,
        valueFieldType: $pb.PbFieldType.OD,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.bool, TestAllTypes_NestedEnum>(
        72, _omitFieldNames ? '' : 'mapBoolEnum',
        entryClassName: 'TestAllTypes.MapBoolEnumEntry',
        keyFieldType: $pb.PbFieldType.OB,
        valueFieldType: $pb.PbFieldType.OE,
        valueOf: TestAllTypes_NestedEnum.valueOf,
        enumValues: TestAllTypes_NestedEnum.values,
        valueDefaultOrMaker: TestAllTypes_NestedEnum.FOO,
        defaultEnumValue: TestAllTypes_NestedEnum.FOO,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.bool, TestAllTypes_NestedMessage>(
        73, _omitFieldNames ? '' : 'mapBoolMessage',
        entryClassName: 'TestAllTypes.MapBoolMessageEntry',
        keyFieldType: $pb.PbFieldType.OB,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: TestAllTypes_NestedMessage.create,
        valueDefaultOrMaker: TestAllTypes_NestedMessage.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $core.bool>(74, _omitFieldNames ? '' : 'mapInt32Bool',
        entryClassName: 'TestAllTypes.MapInt32BoolEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OB,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $core.String>(75, _omitFieldNames ? '' : 'mapInt32String',
        entryClassName: 'TestAllTypes.MapInt32StringEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $core.List<$core.int>>(
        76, _omitFieldNames ? '' : 'mapInt32Bytes',
        entryClassName: 'TestAllTypes.MapInt32BytesEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OY,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $core.int>(77, _omitFieldNames ? '' : 'mapInt32Int32',
        entryClassName: 'TestAllTypes.MapInt32Int32Entry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.O3,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $fixnum.Int64>(78, _omitFieldNames ? '' : 'mapInt32Int64',
        entryClassName: 'TestAllTypes.MapInt32Int64Entry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.O6,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $core.int>(79, _omitFieldNames ? '' : 'mapInt32Uint32',
        entryClassName: 'TestAllTypes.MapInt32Uint32Entry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OU3,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $fixnum.Int64>(80, _omitFieldNames ? '' : 'mapInt32Uint64',
        entryClassName: 'TestAllTypes.MapInt32Uint64Entry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OU6,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $core.double>(81, _omitFieldNames ? '' : 'mapInt32Float',
        entryClassName: 'TestAllTypes.MapInt32FloatEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OF,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $core.double>(82, _omitFieldNames ? '' : 'mapInt32Double',
        entryClassName: 'TestAllTypes.MapInt32DoubleEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OD,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, TestAllTypes_NestedEnum>(
        83, _omitFieldNames ? '' : 'mapInt32Enum',
        entryClassName: 'TestAllTypes.MapInt32EnumEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OE,
        valueOf: TestAllTypes_NestedEnum.valueOf,
        enumValues: TestAllTypes_NestedEnum.values,
        valueDefaultOrMaker: TestAllTypes_NestedEnum.FOO,
        defaultEnumValue: TestAllTypes_NestedEnum.FOO,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, TestAllTypes_NestedMessage>(
        84, _omitFieldNames ? '' : 'mapInt32Message',
        entryClassName: 'TestAllTypes.MapInt32MessageEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: TestAllTypes_NestedMessage.create,
        valueDefaultOrMaker: TestAllTypes_NestedMessage.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $core.bool>(85, _omitFieldNames ? '' : 'mapInt64Bool',
        entryClassName: 'TestAllTypes.MapInt64BoolEntry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.OB,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $core.String>(
        86, _omitFieldNames ? '' : 'mapInt64String',
        entryClassName: 'TestAllTypes.MapInt64StringEntry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $core.List<$core.int>>(
        87, _omitFieldNames ? '' : 'mapInt64Bytes',
        entryClassName: 'TestAllTypes.MapInt64BytesEntry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.OY,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $core.int>(88, _omitFieldNames ? '' : 'mapInt64Int32',
        entryClassName: 'TestAllTypes.MapInt64Int32Entry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.O3,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $fixnum.Int64>(
        89, _omitFieldNames ? '' : 'mapInt64Int64',
        entryClassName: 'TestAllTypes.MapInt64Int64Entry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.O6,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $core.int>(90, _omitFieldNames ? '' : 'mapInt64Uint32',
        entryClassName: 'TestAllTypes.MapInt64Uint32Entry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.OU3,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $fixnum.Int64>(
        91, _omitFieldNames ? '' : 'mapInt64Uint64',
        entryClassName: 'TestAllTypes.MapInt64Uint64Entry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.OU6,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $core.double>(92, _omitFieldNames ? '' : 'mapInt64Float',
        entryClassName: 'TestAllTypes.MapInt64FloatEntry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.OF,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $core.double>(
        93, _omitFieldNames ? '' : 'mapInt64Double',
        entryClassName: 'TestAllTypes.MapInt64DoubleEntry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.OD,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, TestAllTypes_NestedEnum>(
        94, _omitFieldNames ? '' : 'mapInt64Enum',
        entryClassName: 'TestAllTypes.MapInt64EnumEntry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.OE,
        valueOf: TestAllTypes_NestedEnum.valueOf,
        enumValues: TestAllTypes_NestedEnum.values,
        valueDefaultOrMaker: TestAllTypes_NestedEnum.FOO,
        defaultEnumValue: TestAllTypes_NestedEnum.FOO,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, TestAllTypes_NestedMessage>(
        95, _omitFieldNames ? '' : 'mapInt64Message',
        entryClassName: 'TestAllTypes.MapInt64MessageEntry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: TestAllTypes_NestedMessage.create,
        valueDefaultOrMaker: TestAllTypes_NestedMessage.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $core.bool>(96, _omitFieldNames ? '' : 'mapUint32Bool',
        entryClassName: 'TestAllTypes.MapUint32BoolEntry',
        keyFieldType: $pb.PbFieldType.OU3,
        valueFieldType: $pb.PbFieldType.OB,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $core.String>(97, _omitFieldNames ? '' : 'mapUint32String',
        entryClassName: 'TestAllTypes.MapUint32StringEntry',
        keyFieldType: $pb.PbFieldType.OU3,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $core.List<$core.int>>(
        98, _omitFieldNames ? '' : 'mapUint32Bytes',
        entryClassName: 'TestAllTypes.MapUint32BytesEntry',
        keyFieldType: $pb.PbFieldType.OU3,
        valueFieldType: $pb.PbFieldType.OY,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $core.int>(99, _omitFieldNames ? '' : 'mapUint32Int32',
        entryClassName: 'TestAllTypes.MapUint32Int32Entry',
        keyFieldType: $pb.PbFieldType.OU3,
        valueFieldType: $pb.PbFieldType.O3,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..aOM<$0.Any>(100, _omitFieldNames ? '' : 'singleAny',
        subBuilder: $0.Any.create)
    ..aOM<$1.Duration>(101, _omitFieldNames ? '' : 'singleDuration',
        subBuilder: $1.Duration.create)
    ..aOM<$2.Timestamp>(102, _omitFieldNames ? '' : 'singleTimestamp',
        subBuilder: $2.Timestamp.create)
    ..aOM<$3.Struct>(103, _omitFieldNames ? '' : 'singleStruct',
        subBuilder: $3.Struct.create)
    ..aOM<$3.Value>(104, _omitFieldNames ? '' : 'singleValue',
        subBuilder: $3.Value.create)
    ..aOM<$4.Int64Value>(105, _omitFieldNames ? '' : 'singleInt64Wrapper',
        subBuilder: $4.Int64Value.create)
    ..aOM<$4.Int32Value>(106, _omitFieldNames ? '' : 'singleInt32Wrapper',
        subBuilder: $4.Int32Value.create)
    ..aOM<$4.DoubleValue>(107, _omitFieldNames ? '' : 'singleDoubleWrapper',
        subBuilder: $4.DoubleValue.create)
    ..aOM<$4.FloatValue>(108, _omitFieldNames ? '' : 'singleFloatWrapper',
        subBuilder: $4.FloatValue.create)
    ..aOM<$4.UInt64Value>(109, _omitFieldNames ? '' : 'singleUint64Wrapper',
        subBuilder: $4.UInt64Value.create)
    ..aOM<$4.UInt32Value>(110, _omitFieldNames ? '' : 'singleUint32Wrapper',
        subBuilder: $4.UInt32Value.create)
    ..aOM<$4.StringValue>(111, _omitFieldNames ? '' : 'singleStringWrapper',
        subBuilder: $4.StringValue.create)
    ..aOM<$4.BoolValue>(112, _omitFieldNames ? '' : 'singleBoolWrapper',
        subBuilder: $4.BoolValue.create)
    ..aOM<$4.BytesValue>(113, _omitFieldNames ? '' : 'singleBytesWrapper',
        subBuilder: $4.BytesValue.create)
    ..aOM<$3.ListValue>(114, _omitFieldNames ? '' : 'listValue',
        subBuilder: $3.ListValue.create)
    ..e<$3.NullValue>(
        115, _omitFieldNames ? '' : 'nullValue', $pb.PbFieldType.OE,
        defaultOrMaker: $3.NullValue.NULL_VALUE,
        valueOf: $3.NullValue.valueOf,
        enumValues: $3.NullValue.values)
    ..e<$3.NullValue>(
        116, _omitFieldNames ? '' : 'optionalNullValue', $pb.PbFieldType.OE,
        defaultOrMaker: $3.NullValue.NULL_VALUE,
        valueOf: $3.NullValue.valueOf,
        enumValues: $3.NullValue.values)
    ..aOM<$5.FieldMask>(117, _omitFieldNames ? '' : 'fieldMask',
        subBuilder: $5.FieldMask.create)
    ..aOM<$6.Empty>(118, _omitFieldNames ? '' : 'empty',
        subBuilder: $6.Empty.create)
    ..pc<$0.Any>(120, _omitFieldNames ? '' : 'repeatedAny', $pb.PbFieldType.PM,
        subBuilder: $0.Any.create)
    ..pc<$1.Duration>(
        121, _omitFieldNames ? '' : 'repeatedDuration', $pb.PbFieldType.PM,
        subBuilder: $1.Duration.create)
    ..pc<$2.Timestamp>(
        122, _omitFieldNames ? '' : 'repeatedTimestamp', $pb.PbFieldType.PM,
        subBuilder: $2.Timestamp.create)
    ..pc<$3.Struct>(
        123, _omitFieldNames ? '' : 'repeatedStruct', $pb.PbFieldType.PM,
        subBuilder: $3.Struct.create)
    ..pc<$3.Value>(
        124, _omitFieldNames ? '' : 'repeatedValue', $pb.PbFieldType.PM,
        subBuilder: $3.Value.create)
    ..pc<$4.Int64Value>(
        125, _omitFieldNames ? '' : 'repeatedInt64Wrapper', $pb.PbFieldType.PM,
        subBuilder: $4.Int64Value.create)
    ..pc<$4.Int32Value>(
        126, _omitFieldNames ? '' : 'repeatedInt32Wrapper', $pb.PbFieldType.PM,
        subBuilder: $4.Int32Value.create)
    ..pc<$4.DoubleValue>(
        127, _omitFieldNames ? '' : 'repeatedDoubleWrapper', $pb.PbFieldType.PM,
        subBuilder: $4.DoubleValue.create)
    ..pc<$4.FloatValue>(
        128, _omitFieldNames ? '' : 'repeatedFloatWrapper', $pb.PbFieldType.PM,
        subBuilder: $4.FloatValue.create)
    ..pc<$4.UInt64Value>(
        129, _omitFieldNames ? '' : 'repeatedUint64Wrapper', $pb.PbFieldType.PM,
        subBuilder: $4.UInt64Value.create)
    ..pc<$4.UInt32Value>(
        130, _omitFieldNames ? '' : 'repeatedUint32Wrapper', $pb.PbFieldType.PM,
        subBuilder: $4.UInt32Value.create)
    ..pc<$4.StringValue>(
        131, _omitFieldNames ? '' : 'repeatedStringWrapper', $pb.PbFieldType.PM,
        subBuilder: $4.StringValue.create)
    ..pc<$4.BoolValue>(
        132, _omitFieldNames ? '' : 'repeatedBoolWrapper', $pb.PbFieldType.PM,
        subBuilder: $4.BoolValue.create)
    ..pc<$4.BytesValue>(
        133, _omitFieldNames ? '' : 'repeatedBytesWrapper', $pb.PbFieldType.PM,
        subBuilder: $4.BytesValue.create)
    ..pc<$3.ListValue>(
        134, _omitFieldNames ? '' : 'repeatedListValue', $pb.PbFieldType.PM,
        subBuilder: $3.ListValue.create)
    ..pc<$3.NullValue>(
        135, _omitFieldNames ? '' : 'repeatedNullValue', $pb.PbFieldType.PE,
        valueOf: $3.NullValue.valueOf,
        enumValues: $3.NullValue.values,
        defaultEnumValue: $3.NullValue.NULL_VALUE)
    ..m<$core.int, $fixnum.Int64>(200, _omitFieldNames ? '' : 'mapUint32Int64',
        entryClassName: 'TestAllTypes.MapUint32Int64Entry',
        keyFieldType: $pb.PbFieldType.OU3,
        valueFieldType: $pb.PbFieldType.O6,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $core.int>(201, _omitFieldNames ? '' : 'mapUint32Uint32',
        entryClassName: 'TestAllTypes.MapUint32Uint32Entry',
        keyFieldType: $pb.PbFieldType.OU3,
        valueFieldType: $pb.PbFieldType.OU3,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $fixnum.Int64>(202, _omitFieldNames ? '' : 'mapUint32Uint64',
        entryClassName: 'TestAllTypes.MapUint32Uint64Entry',
        keyFieldType: $pb.PbFieldType.OU3,
        valueFieldType: $pb.PbFieldType.OU6,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $core.double>(203, _omitFieldNames ? '' : 'mapUint32Float',
        entryClassName: 'TestAllTypes.MapUint32FloatEntry',
        keyFieldType: $pb.PbFieldType.OU3,
        valueFieldType: $pb.PbFieldType.OF,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $core.double>(204, _omitFieldNames ? '' : 'mapUint32Double',
        entryClassName: 'TestAllTypes.MapUint32DoubleEntry',
        keyFieldType: $pb.PbFieldType.OU3,
        valueFieldType: $pb.PbFieldType.OD,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, TestAllTypes_NestedEnum>(
        205, _omitFieldNames ? '' : 'mapUint32Enum',
        entryClassName: 'TestAllTypes.MapUint32EnumEntry',
        keyFieldType: $pb.PbFieldType.OU3,
        valueFieldType: $pb.PbFieldType.OE,
        valueOf: TestAllTypes_NestedEnum.valueOf,
        enumValues: TestAllTypes_NestedEnum.values,
        valueDefaultOrMaker: TestAllTypes_NestedEnum.FOO,
        defaultEnumValue: TestAllTypes_NestedEnum.FOO,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, TestAllTypes_NestedMessage>(
        206, _omitFieldNames ? '' : 'mapUint32Message',
        entryClassName: 'TestAllTypes.MapUint32MessageEntry',
        keyFieldType: $pb.PbFieldType.OU3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: TestAllTypes_NestedMessage.create,
        valueDefaultOrMaker: TestAllTypes_NestedMessage.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $core.bool>(207, _omitFieldNames ? '' : 'mapUint64Bool',
        entryClassName: 'TestAllTypes.MapUint64BoolEntry',
        keyFieldType: $pb.PbFieldType.OU6,
        valueFieldType: $pb.PbFieldType.OB,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $core.String>(
        208, _omitFieldNames ? '' : 'mapUint64String',
        entryClassName: 'TestAllTypes.MapUint64StringEntry',
        keyFieldType: $pb.PbFieldType.OU6,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $core.List<$core.int>>(
        209, _omitFieldNames ? '' : 'mapUint64Bytes',
        entryClassName: 'TestAllTypes.MapUint64BytesEntry',
        keyFieldType: $pb.PbFieldType.OU6,
        valueFieldType: $pb.PbFieldType.OY,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $core.int>(210, _omitFieldNames ? '' : 'mapUint64Int32',
        entryClassName: 'TestAllTypes.MapUint64Int32Entry',
        keyFieldType: $pb.PbFieldType.OU6,
        valueFieldType: $pb.PbFieldType.O3,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $fixnum.Int64>(
        211, _omitFieldNames ? '' : 'mapUint64Int64',
        entryClassName: 'TestAllTypes.MapUint64Int64Entry',
        keyFieldType: $pb.PbFieldType.OU6,
        valueFieldType: $pb.PbFieldType.O6,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $core.int>(212, _omitFieldNames ? '' : 'mapUint64Uint32',
        entryClassName: 'TestAllTypes.MapUint64Uint32Entry',
        keyFieldType: $pb.PbFieldType.OU6,
        valueFieldType: $pb.PbFieldType.OU3,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $fixnum.Int64>(
        213, _omitFieldNames ? '' : 'mapUint64Uint64',
        entryClassName: 'TestAllTypes.MapUint64Uint64Entry',
        keyFieldType: $pb.PbFieldType.OU6,
        valueFieldType: $pb.PbFieldType.OU6,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $core.double>(
        214, _omitFieldNames ? '' : 'mapUint64Float',
        entryClassName: 'TestAllTypes.MapUint64FloatEntry',
        keyFieldType: $pb.PbFieldType.OU6,
        valueFieldType: $pb.PbFieldType.OF,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $core.double>(
        215, _omitFieldNames ? '' : 'mapUint64Double',
        entryClassName: 'TestAllTypes.MapUint64DoubleEntry',
        keyFieldType: $pb.PbFieldType.OU6,
        valueFieldType: $pb.PbFieldType.OD,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, TestAllTypes_NestedEnum>(
        216, _omitFieldNames ? '' : 'mapUint64Enum',
        entryClassName: 'TestAllTypes.MapUint64EnumEntry',
        keyFieldType: $pb.PbFieldType.OU6,
        valueFieldType: $pb.PbFieldType.OE,
        valueOf: TestAllTypes_NestedEnum.valueOf,
        enumValues: TestAllTypes_NestedEnum.values,
        valueDefaultOrMaker: TestAllTypes_NestedEnum.FOO,
        defaultEnumValue: TestAllTypes_NestedEnum.FOO,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, TestAllTypes_NestedMessage>(
        217, _omitFieldNames ? '' : 'mapUint64Message',
        entryClassName: 'TestAllTypes.MapUint64MessageEntry',
        keyFieldType: $pb.PbFieldType.OU6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: TestAllTypes_NestedMessage.create,
        valueDefaultOrMaker: TestAllTypes_NestedMessage.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.String, $core.bool>(218, _omitFieldNames ? '' : 'mapStringBool',
        entryClassName: 'TestAllTypes.MapStringBoolEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OB,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.String, $core.List<$core.int>>(
        219, _omitFieldNames ? '' : 'mapStringBytes',
        entryClassName: 'TestAllTypes.MapStringBytesEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OY,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.String, $core.int>(220, _omitFieldNames ? '' : 'mapStringInt32',
        entryClassName: 'TestAllTypes.MapStringInt32Entry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.O3,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.String, $fixnum.Int64>(
        221, _omitFieldNames ? '' : 'mapStringInt64',
        entryClassName: 'TestAllTypes.MapStringInt64Entry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.O6,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.String, $core.int>(222, _omitFieldNames ? '' : 'mapStringUint32',
        entryClassName: 'TestAllTypes.MapStringUint32Entry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OU3,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.String, $fixnum.Int64>(
        223, _omitFieldNames ? '' : 'mapStringUint64',
        entryClassName: 'TestAllTypes.MapStringUint64Entry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OU6,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.String, $core.double>(
        224, _omitFieldNames ? '' : 'mapStringFloat',
        entryClassName: 'TestAllTypes.MapStringFloatEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OF,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.String, $core.double>(
        225, _omitFieldNames ? '' : 'mapStringDouble',
        entryClassName: 'TestAllTypes.MapStringDoubleEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OD,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.String, TestAllTypes_NestedEnum>(
        226, _omitFieldNames ? '' : 'mapStringEnum',
        entryClassName: 'TestAllTypes.MapStringEnumEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OE,
        valueOf: TestAllTypes_NestedEnum.valueOf,
        enumValues: TestAllTypes_NestedEnum.values,
        valueDefaultOrMaker: TestAllTypes_NestedEnum.FOO,
        defaultEnumValue: TestAllTypes_NestedEnum.FOO,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.String, TestAllTypes_NestedMessage>(
        227, _omitFieldNames ? '' : 'mapStringMessage',
        entryClassName: 'TestAllTypes.MapStringMessageEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: TestAllTypes_NestedMessage.create,
        valueDefaultOrMaker: TestAllTypes_NestedMessage.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.bool, $1.Duration>(228, _omitFieldNames ? '' : 'mapBoolDuration',
        entryClassName: 'TestAllTypes.MapBoolDurationEntry',
        keyFieldType: $pb.PbFieldType.OB,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $1.Duration.create,
        valueDefaultOrMaker: $1.Duration.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.bool, $2.Timestamp>(
        229, _omitFieldNames ? '' : 'mapBoolTimestamp',
        entryClassName: 'TestAllTypes.MapBoolTimestampEntry',
        keyFieldType: $pb.PbFieldType.OB,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $2.Timestamp.create,
        valueDefaultOrMaker: $2.Timestamp.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.bool, $3.NullValue>(
        230, _omitFieldNames ? '' : 'mapBoolNullValue',
        entryClassName: 'TestAllTypes.MapBoolNullValueEntry',
        keyFieldType: $pb.PbFieldType.OB,
        valueFieldType: $pb.PbFieldType.OE,
        valueOf: $3.NullValue.valueOf,
        enumValues: $3.NullValue.values,
        valueDefaultOrMaker: $3.NullValue.NULL_VALUE,
        defaultEnumValue: $3.NullValue.NULL_VALUE,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $1.Duration>(231, _omitFieldNames ? '' : 'mapInt32Duration',
        entryClassName: 'TestAllTypes.MapInt32DurationEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $1.Duration.create,
        valueDefaultOrMaker: $1.Duration.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $2.Timestamp>(
        232, _omitFieldNames ? '' : 'mapInt32Timestamp',
        entryClassName: 'TestAllTypes.MapInt32TimestampEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $2.Timestamp.create,
        valueDefaultOrMaker: $2.Timestamp.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $3.NullValue>(
        233, _omitFieldNames ? '' : 'mapInt32NullValue',
        entryClassName: 'TestAllTypes.MapInt32NullValueEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OE,
        valueOf: $3.NullValue.valueOf,
        enumValues: $3.NullValue.values,
        valueDefaultOrMaker: $3.NullValue.NULL_VALUE,
        defaultEnumValue: $3.NullValue.NULL_VALUE,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $1.Duration>(
        234, _omitFieldNames ? '' : 'mapInt64Duration',
        entryClassName: 'TestAllTypes.MapInt64DurationEntry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $1.Duration.create,
        valueDefaultOrMaker: $1.Duration.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $2.Timestamp>(
        235, _omitFieldNames ? '' : 'mapInt64Timestamp',
        entryClassName: 'TestAllTypes.MapInt64TimestampEntry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $2.Timestamp.create,
        valueDefaultOrMaker: $2.Timestamp.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $3.NullValue>(
        236, _omitFieldNames ? '' : 'mapInt64NullValue',
        entryClassName: 'TestAllTypes.MapInt64NullValueEntry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.OE,
        valueOf: $3.NullValue.valueOf,
        enumValues: $3.NullValue.values,
        valueDefaultOrMaker: $3.NullValue.NULL_VALUE,
        defaultEnumValue: $3.NullValue.NULL_VALUE,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $1.Duration>(237, _omitFieldNames ? '' : 'mapUint32Duration',
        entryClassName: 'TestAllTypes.MapUint32DurationEntry',
        keyFieldType: $pb.PbFieldType.OU3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $1.Duration.create,
        valueDefaultOrMaker: $1.Duration.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $2.Timestamp>(
        238, _omitFieldNames ? '' : 'mapUint32Timestamp',
        entryClassName: 'TestAllTypes.MapUint32TimestampEntry',
        keyFieldType: $pb.PbFieldType.OU3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $2.Timestamp.create,
        valueDefaultOrMaker: $2.Timestamp.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $3.NullValue>(
        239, _omitFieldNames ? '' : 'mapUint32NullValue',
        entryClassName: 'TestAllTypes.MapUint32NullValueEntry',
        keyFieldType: $pb.PbFieldType.OU3,
        valueFieldType: $pb.PbFieldType.OE,
        valueOf: $3.NullValue.valueOf,
        enumValues: $3.NullValue.values,
        valueDefaultOrMaker: $3.NullValue.NULL_VALUE,
        defaultEnumValue: $3.NullValue.NULL_VALUE,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $1.Duration>(
        240, _omitFieldNames ? '' : 'mapUint64Duration',
        entryClassName: 'TestAllTypes.MapUint64DurationEntry',
        keyFieldType: $pb.PbFieldType.OU6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $1.Duration.create,
        valueDefaultOrMaker: $1.Duration.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $2.Timestamp>(
        241, _omitFieldNames ? '' : 'mapUint64Timestamp',
        entryClassName: 'TestAllTypes.MapUint64TimestampEntry',
        keyFieldType: $pb.PbFieldType.OU6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $2.Timestamp.create,
        valueDefaultOrMaker: $2.Timestamp.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $3.NullValue>(
        242, _omitFieldNames ? '' : 'mapUint64NullValue',
        entryClassName: 'TestAllTypes.MapUint64NullValueEntry',
        keyFieldType: $pb.PbFieldType.OU6,
        valueFieldType: $pb.PbFieldType.OE,
        valueOf: $3.NullValue.valueOf,
        enumValues: $3.NullValue.values,
        valueDefaultOrMaker: $3.NullValue.NULL_VALUE,
        defaultEnumValue: $3.NullValue.NULL_VALUE,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.String, $1.Duration>(
        243, _omitFieldNames ? '' : 'mapStringDuration',
        entryClassName: 'TestAllTypes.MapStringDurationEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $1.Duration.create,
        valueDefaultOrMaker: $1.Duration.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.String, $2.Timestamp>(
        244, _omitFieldNames ? '' : 'mapStringTimestamp',
        entryClassName: 'TestAllTypes.MapStringTimestampEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $2.Timestamp.create,
        valueDefaultOrMaker: $2.Timestamp.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.String, $3.NullValue>(
        245, _omitFieldNames ? '' : 'mapStringNullValue',
        entryClassName: 'TestAllTypes.MapStringNullValueEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OE,
        valueOf: $3.NullValue.valueOf,
        enumValues: $3.NullValue.values,
        valueDefaultOrMaker: $3.NullValue.NULL_VALUE,
        defaultEnumValue: $3.NullValue.NULL_VALUE,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.bool, $0.Any>(246, _omitFieldNames ? '' : 'mapBoolAny',
        entryClassName: 'TestAllTypes.MapBoolAnyEntry',
        keyFieldType: $pb.PbFieldType.OB,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $0.Any.create,
        valueDefaultOrMaker: $0.Any.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.bool, $3.Struct>(247, _omitFieldNames ? '' : 'mapBoolStruct',
        entryClassName: 'TestAllTypes.MapBoolStructEntry',
        keyFieldType: $pb.PbFieldType.OB,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $3.Struct.create,
        valueDefaultOrMaker: $3.Struct.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.bool, $3.Value>(248, _omitFieldNames ? '' : 'mapBoolValue',
        entryClassName: 'TestAllTypes.MapBoolValueEntry',
        keyFieldType: $pb.PbFieldType.OB,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $3.Value.create,
        valueDefaultOrMaker: $3.Value.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.bool, $3.ListValue>(
        249, _omitFieldNames ? '' : 'mapBoolListValue',
        entryClassName: 'TestAllTypes.MapBoolListValueEntry',
        keyFieldType: $pb.PbFieldType.OB,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $3.ListValue.create,
        valueDefaultOrMaker: $3.ListValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.bool, $4.Int64Value>(
        250, _omitFieldNames ? '' : 'mapBoolInt64Wrapper',
        entryClassName: 'TestAllTypes.MapBoolInt64WrapperEntry',
        keyFieldType: $pb.PbFieldType.OB,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.Int64Value.create,
        valueDefaultOrMaker: $4.Int64Value.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.bool, $4.Int32Value>(
        251, _omitFieldNames ? '' : 'mapBoolInt32Wrapper',
        entryClassName: 'TestAllTypes.MapBoolInt32WrapperEntry',
        keyFieldType: $pb.PbFieldType.OB,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.Int32Value.create,
        valueDefaultOrMaker: $4.Int32Value.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.bool, $4.DoubleValue>(
        252, _omitFieldNames ? '' : 'mapBoolDoubleWrapper',
        entryClassName: 'TestAllTypes.MapBoolDoubleWrapperEntry',
        keyFieldType: $pb.PbFieldType.OB,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.DoubleValue.create,
        valueDefaultOrMaker: $4.DoubleValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.bool, $4.FloatValue>(
        253, _omitFieldNames ? '' : 'mapBoolFloatWrapper',
        entryClassName: 'TestAllTypes.MapBoolFloatWrapperEntry',
        keyFieldType: $pb.PbFieldType.OB,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.FloatValue.create,
        valueDefaultOrMaker: $4.FloatValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.bool, $4.UInt64Value>(
        254, _omitFieldNames ? '' : 'mapBoolUint64Wrapper',
        entryClassName: 'TestAllTypes.MapBoolUint64WrapperEntry',
        keyFieldType: $pb.PbFieldType.OB,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.UInt64Value.create,
        valueDefaultOrMaker: $4.UInt64Value.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.bool, $4.UInt32Value>(
        255, _omitFieldNames ? '' : 'mapBoolUint32Wrapper',
        entryClassName: 'TestAllTypes.MapBoolUint32WrapperEntry',
        keyFieldType: $pb.PbFieldType.OB,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.UInt32Value.create,
        valueDefaultOrMaker: $4.UInt32Value.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.bool, $4.StringValue>(
        256, _omitFieldNames ? '' : 'mapBoolStringWrapper',
        entryClassName: 'TestAllTypes.MapBoolStringWrapperEntry',
        keyFieldType: $pb.PbFieldType.OB,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.StringValue.create,
        valueDefaultOrMaker: $4.StringValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.bool, $4.BoolValue>(
        257, _omitFieldNames ? '' : 'mapBoolBoolWrapper',
        entryClassName: 'TestAllTypes.MapBoolBoolWrapperEntry',
        keyFieldType: $pb.PbFieldType.OB,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.BoolValue.create,
        valueDefaultOrMaker: $4.BoolValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.bool, $4.BytesValue>(
        258, _omitFieldNames ? '' : 'mapBoolBytesWrapper',
        entryClassName: 'TestAllTypes.MapBoolBytesWrapperEntry',
        keyFieldType: $pb.PbFieldType.OB,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.BytesValue.create,
        valueDefaultOrMaker: $4.BytesValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $0.Any>(259, _omitFieldNames ? '' : 'mapInt32Any',
        entryClassName: 'TestAllTypes.MapInt32AnyEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $0.Any.create,
        valueDefaultOrMaker: $0.Any.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $3.Struct>(260, _omitFieldNames ? '' : 'mapInt32Struct',
        entryClassName: 'TestAllTypes.MapInt32StructEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $3.Struct.create,
        valueDefaultOrMaker: $3.Struct.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $3.Value>(261, _omitFieldNames ? '' : 'mapInt32Value',
        entryClassName: 'TestAllTypes.MapInt32ValueEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $3.Value.create,
        valueDefaultOrMaker: $3.Value.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $3.ListValue>(
        262, _omitFieldNames ? '' : 'mapInt32ListValue',
        entryClassName: 'TestAllTypes.MapInt32ListValueEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $3.ListValue.create,
        valueDefaultOrMaker: $3.ListValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $4.Int64Value>(
        263, _omitFieldNames ? '' : 'mapInt32Int64Wrapper',
        entryClassName: 'TestAllTypes.MapInt32Int64WrapperEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.Int64Value.create,
        valueDefaultOrMaker: $4.Int64Value.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $4.Int32Value>(
        264, _omitFieldNames ? '' : 'mapInt32Int32Wrapper',
        entryClassName: 'TestAllTypes.MapInt32Int32WrapperEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.Int32Value.create,
        valueDefaultOrMaker: $4.Int32Value.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $4.DoubleValue>(
        265, _omitFieldNames ? '' : 'mapInt32DoubleWrapper',
        entryClassName: 'TestAllTypes.MapInt32DoubleWrapperEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.DoubleValue.create,
        valueDefaultOrMaker: $4.DoubleValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $4.FloatValue>(
        266, _omitFieldNames ? '' : 'mapInt32FloatWrapper',
        entryClassName: 'TestAllTypes.MapInt32FloatWrapperEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.FloatValue.create,
        valueDefaultOrMaker: $4.FloatValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $4.UInt64Value>(
        267, _omitFieldNames ? '' : 'mapInt32Uint64Wrapper',
        entryClassName: 'TestAllTypes.MapInt32Uint64WrapperEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.UInt64Value.create,
        valueDefaultOrMaker: $4.UInt64Value.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $4.UInt32Value>(
        268, _omitFieldNames ? '' : 'mapInt32Uint32Wrapper',
        entryClassName: 'TestAllTypes.MapInt32Uint32WrapperEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.UInt32Value.create,
        valueDefaultOrMaker: $4.UInt32Value.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $4.StringValue>(
        269, _omitFieldNames ? '' : 'mapInt32StringWrapper',
        entryClassName: 'TestAllTypes.MapInt32StringWrapperEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.StringValue.create,
        valueDefaultOrMaker: $4.StringValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $4.BoolValue>(
        270, _omitFieldNames ? '' : 'mapInt32BoolWrapper',
        entryClassName: 'TestAllTypes.MapInt32BoolWrapperEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.BoolValue.create,
        valueDefaultOrMaker: $4.BoolValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $4.BytesValue>(
        271, _omitFieldNames ? '' : 'mapInt32BytesWrapper',
        entryClassName: 'TestAllTypes.MapInt32BytesWrapperEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.BytesValue.create,
        valueDefaultOrMaker: $4.BytesValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $0.Any>(272, _omitFieldNames ? '' : 'mapInt64Any',
        entryClassName: 'TestAllTypes.MapInt64AnyEntry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $0.Any.create,
        valueDefaultOrMaker: $0.Any.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $3.Struct>(273, _omitFieldNames ? '' : 'mapInt64Struct',
        entryClassName: 'TestAllTypes.MapInt64StructEntry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $3.Struct.create,
        valueDefaultOrMaker: $3.Struct.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $3.Value>(274, _omitFieldNames ? '' : 'mapInt64Value',
        entryClassName: 'TestAllTypes.MapInt64ValueEntry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $3.Value.create,
        valueDefaultOrMaker: $3.Value.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $3.ListValue>(
        275, _omitFieldNames ? '' : 'mapInt64ListValue',
        entryClassName: 'TestAllTypes.MapInt64ListValueEntry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $3.ListValue.create,
        valueDefaultOrMaker: $3.ListValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $4.Int64Value>(
        276, _omitFieldNames ? '' : 'mapInt64Int64Wrapper',
        entryClassName: 'TestAllTypes.MapInt64Int64WrapperEntry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.Int64Value.create,
        valueDefaultOrMaker: $4.Int64Value.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $4.Int32Value>(
        277, _omitFieldNames ? '' : 'mapInt64Int32Wrapper',
        entryClassName: 'TestAllTypes.MapInt64Int32WrapperEntry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.Int32Value.create,
        valueDefaultOrMaker: $4.Int32Value.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $4.DoubleValue>(
        278, _omitFieldNames ? '' : 'mapInt64DoubleWrapper',
        entryClassName: 'TestAllTypes.MapInt64DoubleWrapperEntry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.DoubleValue.create,
        valueDefaultOrMaker: $4.DoubleValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $4.FloatValue>(
        279, _omitFieldNames ? '' : 'mapInt64FloatWrapper',
        entryClassName: 'TestAllTypes.MapInt64FloatWrapperEntry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.FloatValue.create,
        valueDefaultOrMaker: $4.FloatValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $4.UInt64Value>(
        280, _omitFieldNames ? '' : 'mapInt64Uint64Wrapper',
        entryClassName: 'TestAllTypes.MapInt64Uint64WrapperEntry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.UInt64Value.create,
        valueDefaultOrMaker: $4.UInt64Value.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $4.UInt32Value>(
        281, _omitFieldNames ? '' : 'mapInt64Uint32Wrapper',
        entryClassName: 'TestAllTypes.MapInt64Uint32WrapperEntry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.UInt32Value.create,
        valueDefaultOrMaker: $4.UInt32Value.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $4.StringValue>(
        282, _omitFieldNames ? '' : 'mapInt64StringWrapper',
        entryClassName: 'TestAllTypes.MapInt64StringWrapperEntry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.StringValue.create,
        valueDefaultOrMaker: $4.StringValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $4.BoolValue>(
        283, _omitFieldNames ? '' : 'mapInt64BoolWrapper',
        entryClassName: 'TestAllTypes.MapInt64BoolWrapperEntry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.BoolValue.create,
        valueDefaultOrMaker: $4.BoolValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $4.BytesValue>(
        284, _omitFieldNames ? '' : 'mapInt64BytesWrapper',
        entryClassName: 'TestAllTypes.MapInt64BytesWrapperEntry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.BytesValue.create,
        valueDefaultOrMaker: $4.BytesValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $0.Any>(285, _omitFieldNames ? '' : 'mapUint32Any',
        entryClassName: 'TestAllTypes.MapUint32AnyEntry',
        keyFieldType: $pb.PbFieldType.OU3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $0.Any.create,
        valueDefaultOrMaker: $0.Any.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $3.Struct>(286, _omitFieldNames ? '' : 'mapUint32Struct',
        entryClassName: 'TestAllTypes.MapUint32StructEntry',
        keyFieldType: $pb.PbFieldType.OU3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $3.Struct.create,
        valueDefaultOrMaker: $3.Struct.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $3.Value>(287, _omitFieldNames ? '' : 'mapUint32Value',
        entryClassName: 'TestAllTypes.MapUint32ValueEntry',
        keyFieldType: $pb.PbFieldType.OU3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $3.Value.create,
        valueDefaultOrMaker: $3.Value.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $3.ListValue>(
        288, _omitFieldNames ? '' : 'mapUint32ListValue',
        entryClassName: 'TestAllTypes.MapUint32ListValueEntry',
        keyFieldType: $pb.PbFieldType.OU3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $3.ListValue.create,
        valueDefaultOrMaker: $3.ListValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $4.Int64Value>(
        289, _omitFieldNames ? '' : 'mapUint32Int64Wrapper',
        entryClassName: 'TestAllTypes.MapUint32Int64WrapperEntry',
        keyFieldType: $pb.PbFieldType.OU3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.Int64Value.create,
        valueDefaultOrMaker: $4.Int64Value.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $4.Int32Value>(
        290, _omitFieldNames ? '' : 'mapUint32Int32Wrapper',
        entryClassName: 'TestAllTypes.MapUint32Int32WrapperEntry',
        keyFieldType: $pb.PbFieldType.OU3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.Int32Value.create,
        valueDefaultOrMaker: $4.Int32Value.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $4.DoubleValue>(
        291, _omitFieldNames ? '' : 'mapUint32DoubleWrapper',
        entryClassName: 'TestAllTypes.MapUint32DoubleWrapperEntry',
        keyFieldType: $pb.PbFieldType.OU3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.DoubleValue.create,
        valueDefaultOrMaker: $4.DoubleValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $4.FloatValue>(
        292, _omitFieldNames ? '' : 'mapUint32FloatWrapper',
        entryClassName: 'TestAllTypes.MapUint32FloatWrapperEntry',
        keyFieldType: $pb.PbFieldType.OU3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.FloatValue.create,
        valueDefaultOrMaker: $4.FloatValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $4.UInt64Value>(
        293, _omitFieldNames ? '' : 'mapUint32Uint64Wrapper',
        entryClassName: 'TestAllTypes.MapUint32Uint64WrapperEntry',
        keyFieldType: $pb.PbFieldType.OU3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.UInt64Value.create,
        valueDefaultOrMaker: $4.UInt64Value.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $4.UInt32Value>(
        294, _omitFieldNames ? '' : 'mapUint32Uint32Wrapper',
        entryClassName: 'TestAllTypes.MapUint32Uint32WrapperEntry',
        keyFieldType: $pb.PbFieldType.OU3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.UInt32Value.create,
        valueDefaultOrMaker: $4.UInt32Value.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $4.StringValue>(
        295, _omitFieldNames ? '' : 'mapUint32StringWrapper',
        entryClassName: 'TestAllTypes.MapUint32StringWrapperEntry',
        keyFieldType: $pb.PbFieldType.OU3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.StringValue.create,
        valueDefaultOrMaker: $4.StringValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $4.BoolValue>(
        296, _omitFieldNames ? '' : 'mapUint32BoolWrapper',
        entryClassName: 'TestAllTypes.MapUint32BoolWrapperEntry',
        keyFieldType: $pb.PbFieldType.OU3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.BoolValue.create,
        valueDefaultOrMaker: $4.BoolValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.int, $4.BytesValue>(
        297, _omitFieldNames ? '' : 'mapUint32BytesWrapper',
        entryClassName: 'TestAllTypes.MapUint32BytesWrapperEntry',
        keyFieldType: $pb.PbFieldType.OU3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.BytesValue.create,
        valueDefaultOrMaker: $4.BytesValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $0.Any>(298, _omitFieldNames ? '' : 'mapUint64Any',
        entryClassName: 'TestAllTypes.MapUint64AnyEntry',
        keyFieldType: $pb.PbFieldType.OU6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $0.Any.create,
        valueDefaultOrMaker: $0.Any.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $3.Struct>(299, _omitFieldNames ? '' : 'mapUint64Struct',
        entryClassName: 'TestAllTypes.MapUint64StructEntry',
        keyFieldType: $pb.PbFieldType.OU6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $3.Struct.create,
        valueDefaultOrMaker: $3.Struct.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $3.Value>(300, _omitFieldNames ? '' : 'mapUint64Value',
        entryClassName: 'TestAllTypes.MapUint64ValueEntry',
        keyFieldType: $pb.PbFieldType.OU6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $3.Value.create,
        valueDefaultOrMaker: $3.Value.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $3.ListValue>(
        301, _omitFieldNames ? '' : 'mapUint64ListValue',
        entryClassName: 'TestAllTypes.MapUint64ListValueEntry',
        keyFieldType: $pb.PbFieldType.OU6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $3.ListValue.create,
        valueDefaultOrMaker: $3.ListValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $4.Int64Value>(
        302, _omitFieldNames ? '' : 'mapUint64Int64Wrapper',
        entryClassName: 'TestAllTypes.MapUint64Int64WrapperEntry',
        keyFieldType: $pb.PbFieldType.OU6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.Int64Value.create,
        valueDefaultOrMaker: $4.Int64Value.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $4.Int32Value>(
        303, _omitFieldNames ? '' : 'mapUint64Int32Wrapper',
        entryClassName: 'TestAllTypes.MapUint64Int32WrapperEntry',
        keyFieldType: $pb.PbFieldType.OU6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.Int32Value.create,
        valueDefaultOrMaker: $4.Int32Value.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $4.DoubleValue>(
        304, _omitFieldNames ? '' : 'mapUint64DoubleWrapper',
        entryClassName: 'TestAllTypes.MapUint64DoubleWrapperEntry',
        keyFieldType: $pb.PbFieldType.OU6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.DoubleValue.create,
        valueDefaultOrMaker: $4.DoubleValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $4.FloatValue>(
        305, _omitFieldNames ? '' : 'mapUint64FloatWrapper',
        entryClassName: 'TestAllTypes.MapUint64FloatWrapperEntry',
        keyFieldType: $pb.PbFieldType.OU6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.FloatValue.create,
        valueDefaultOrMaker: $4.FloatValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $4.UInt64Value>(
        306, _omitFieldNames ? '' : 'mapUint64Uint64Wrapper',
        entryClassName: 'TestAllTypes.MapUint64Uint64WrapperEntry',
        keyFieldType: $pb.PbFieldType.OU6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.UInt64Value.create,
        valueDefaultOrMaker: $4.UInt64Value.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $4.UInt32Value>(
        307, _omitFieldNames ? '' : 'mapUint64Uint32Wrapper',
        entryClassName: 'TestAllTypes.MapUint64Uint32WrapperEntry',
        keyFieldType: $pb.PbFieldType.OU6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.UInt32Value.create,
        valueDefaultOrMaker: $4.UInt32Value.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $4.StringValue>(
        308, _omitFieldNames ? '' : 'mapUint64StringWrapper',
        entryClassName: 'TestAllTypes.MapUint64StringWrapperEntry',
        keyFieldType: $pb.PbFieldType.OU6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.StringValue.create,
        valueDefaultOrMaker: $4.StringValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $4.BoolValue>(
        309, _omitFieldNames ? '' : 'mapUint64BoolWrapper',
        entryClassName: 'TestAllTypes.MapUint64BoolWrapperEntry',
        keyFieldType: $pb.PbFieldType.OU6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.BoolValue.create,
        valueDefaultOrMaker: $4.BoolValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$fixnum.Int64, $4.BytesValue>(
        310, _omitFieldNames ? '' : 'mapUint64BytesWrapper',
        entryClassName: 'TestAllTypes.MapUint64BytesWrapperEntry',
        keyFieldType: $pb.PbFieldType.OU6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.BytesValue.create,
        valueDefaultOrMaker: $4.BytesValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.String, $0.Any>(311, _omitFieldNames ? '' : 'mapStringAny',
        entryClassName: 'TestAllTypes.MapStringAnyEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $0.Any.create,
        valueDefaultOrMaker: $0.Any.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.String, $3.Struct>(312, _omitFieldNames ? '' : 'mapStringStruct',
        entryClassName: 'TestAllTypes.MapStringStructEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $3.Struct.create,
        valueDefaultOrMaker: $3.Struct.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.String, $3.Value>(313, _omitFieldNames ? '' : 'mapStringValue',
        entryClassName: 'TestAllTypes.MapStringValueEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $3.Value.create,
        valueDefaultOrMaker: $3.Value.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.String, $3.ListValue>(
        314, _omitFieldNames ? '' : 'mapStringListValue',
        entryClassName: 'TestAllTypes.MapStringListValueEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $3.ListValue.create,
        valueDefaultOrMaker: $3.ListValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.String, $4.Int64Value>(
        315, _omitFieldNames ? '' : 'mapStringInt64Wrapper',
        entryClassName: 'TestAllTypes.MapStringInt64WrapperEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.Int64Value.create,
        valueDefaultOrMaker: $4.Int64Value.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.String, $4.Int32Value>(
        316, _omitFieldNames ? '' : 'mapStringInt32Wrapper',
        entryClassName: 'TestAllTypes.MapStringInt32WrapperEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.Int32Value.create,
        valueDefaultOrMaker: $4.Int32Value.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.String, $4.DoubleValue>(
        317, _omitFieldNames ? '' : 'mapStringDoubleWrapper',
        entryClassName: 'TestAllTypes.MapStringDoubleWrapperEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.DoubleValue.create,
        valueDefaultOrMaker: $4.DoubleValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.String, $4.FloatValue>(
        318, _omitFieldNames ? '' : 'mapStringFloatWrapper',
        entryClassName: 'TestAllTypes.MapStringFloatWrapperEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.FloatValue.create,
        valueDefaultOrMaker: $4.FloatValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.String, $4.UInt64Value>(
        319, _omitFieldNames ? '' : 'mapStringUint64Wrapper',
        entryClassName: 'TestAllTypes.MapStringUint64WrapperEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.UInt64Value.create,
        valueDefaultOrMaker: $4.UInt64Value.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.String, $4.UInt32Value>(
        320, _omitFieldNames ? '' : 'mapStringUint32Wrapper',
        entryClassName: 'TestAllTypes.MapStringUint32WrapperEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.UInt32Value.create,
        valueDefaultOrMaker: $4.UInt32Value.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.String, $4.StringValue>(
        321, _omitFieldNames ? '' : 'mapStringStringWrapper',
        entryClassName: 'TestAllTypes.MapStringStringWrapperEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.StringValue.create,
        valueDefaultOrMaker: $4.StringValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.String, $4.BoolValue>(
        322, _omitFieldNames ? '' : 'mapStringBoolWrapper',
        entryClassName: 'TestAllTypes.MapStringBoolWrapperEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.BoolValue.create,
        valueDefaultOrMaker: $4.BoolValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..m<$core.String, $4.BytesValue>(
        323, _omitFieldNames ? '' : 'mapStringBytesWrapper',
        entryClassName: 'TestAllTypes.MapStringBytesWrapperEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.BytesValue.create,
        valueDefaultOrMaker: $4.BytesValue.getDefault,
        packageName: const $pb.PackageName('cel.expr.conformance.proto2'))
    ..aOM<NestedTestAllTypes>(400, _omitFieldNames ? '' : 'oneofType',
        subBuilder: NestedTestAllTypes.create)
    ..aOM<TestAllTypes_NestedMessage>(401, _omitFieldNames ? '' : 'oneofMsg',
        subBuilder: TestAllTypes_NestedMessage.create)
    ..aOB(402, _omitFieldNames ? '' : 'oneofBool')
    ..a<TestAllTypes_NestedGroup>(
        403, _omitFieldNames ? '' : 'nestedgroup', $pb.PbFieldType.OG,
        subBuilder: TestAllTypes_NestedGroup.create,
        defaultOrMaker: TestAllTypes_NestedGroup.getDefault)
    ..hasExtensions = true;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TestAllTypes clone() => TestAllTypes()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TestAllTypes copyWith(void Function(TestAllTypes) updates) =>
      super.copyWith((message) => updates(message as TestAllTypes))
          as TestAllTypes;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestAllTypes create() => TestAllTypes._();
  @$core.override
  TestAllTypes createEmptyInstance() => create();
  static $pb.PbList<TestAllTypes> createRepeated() =>
      $pb.PbList<TestAllTypes>();
  @$core.pragma('dart2js:noInline')
  static TestAllTypes getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TestAllTypes>(create);
  static TestAllTypes? _defaultInstance;

  TestAllTypes_NestedType whichNestedType() =>
      _TestAllTypes_NestedTypeByTag[$_whichOneof(0)]!;
  void clearNestedType() => $_clearField($_whichOneof(0));

  TestAllTypes_Kind whichKind() => _TestAllTypes_KindByTag[$_whichOneof(1)]!;
  void clearKind() => $_clearField($_whichOneof(1));

  /// Singular
  @$pb.TagNumber(1)
  $core.int get singleInt32 => $_getI(0, -32);
  @$pb.TagNumber(1)
  set singleInt32($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSingleInt32() => $_has(0);
  @$pb.TagNumber(1)
  void clearSingleInt32() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get singleInt64 => $_getI64(1);
  @$pb.TagNumber(2)
  set singleInt64($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSingleInt64() => $_has(1);
  @$pb.TagNumber(2)
  void clearSingleInt64() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get singleUint32 => $_getI(2, 32);
  @$pb.TagNumber(3)
  set singleUint32($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSingleUint32() => $_has(2);
  @$pb.TagNumber(3)
  void clearSingleUint32() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get singleUint64 => $_getI64(3);
  @$pb.TagNumber(4)
  set singleUint64($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSingleUint64() => $_has(3);
  @$pb.TagNumber(4)
  void clearSingleUint64() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get singleSint32 => $_getIZ(4);
  @$pb.TagNumber(5)
  set singleSint32($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSingleSint32() => $_has(4);
  @$pb.TagNumber(5)
  void clearSingleSint32() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get singleSint64 => $_getI64(5);
  @$pb.TagNumber(6)
  set singleSint64($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSingleSint64() => $_has(5);
  @$pb.TagNumber(6)
  void clearSingleSint64() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get singleFixed32 => $_getIZ(6);
  @$pb.TagNumber(7)
  set singleFixed32($core.int value) => $_setUnsignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasSingleFixed32() => $_has(6);
  @$pb.TagNumber(7)
  void clearSingleFixed32() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get singleFixed64 => $_getI64(7);
  @$pb.TagNumber(8)
  set singleFixed64($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasSingleFixed64() => $_has(7);
  @$pb.TagNumber(8)
  void clearSingleFixed64() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get singleSfixed32 => $_getIZ(8);
  @$pb.TagNumber(9)
  set singleSfixed32($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasSingleSfixed32() => $_has(8);
  @$pb.TagNumber(9)
  void clearSingleSfixed32() => $_clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get singleSfixed64 => $_getI64(9);
  @$pb.TagNumber(10)
  set singleSfixed64($fixnum.Int64 value) => $_setInt64(9, value);
  @$pb.TagNumber(10)
  $core.bool hasSingleSfixed64() => $_has(9);
  @$pb.TagNumber(10)
  void clearSingleSfixed64() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.double get singleFloat => $_getN(10);
  @$pb.TagNumber(11)
  set singleFloat($core.double value) => $_setFloat(10, value);
  @$pb.TagNumber(11)
  $core.bool hasSingleFloat() => $_has(10);
  @$pb.TagNumber(11)
  void clearSingleFloat() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.double get singleDouble => $_getN(11);
  @$pb.TagNumber(12)
  set singleDouble($core.double value) => $_setDouble(11, value);
  @$pb.TagNumber(12)
  $core.bool hasSingleDouble() => $_has(11);
  @$pb.TagNumber(12)
  void clearSingleDouble() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.bool get singleBool => $_getB(12, true);
  @$pb.TagNumber(13)
  set singleBool($core.bool value) => $_setBool(12, value);
  @$pb.TagNumber(13)
  $core.bool hasSingleBool() => $_has(12);
  @$pb.TagNumber(13)
  void clearSingleBool() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get singleString => $_getS(13, 'empty');
  @$pb.TagNumber(14)
  set singleString($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasSingleString() => $_has(13);
  @$pb.TagNumber(14)
  void clearSingleString() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.List<$core.int> get singleBytes => $_getN(14);
  @$pb.TagNumber(15)
  set singleBytes($core.List<$core.int> value) => $_setBytes(14, value);
  @$pb.TagNumber(15)
  $core.bool hasSingleBytes() => $_has(14);
  @$pb.TagNumber(15)
  void clearSingleBytes() => $_clearField(15);

  /// Collides with 'in' operator.
  @$pb.TagNumber(18)
  $core.bool get in_18 => $_getBF(15);
  @$pb.TagNumber(18)
  set in_18($core.bool value) => $_setBool(15, value);
  @$pb.TagNumber(18)
  $core.bool hasIn_18() => $_has(15);
  @$pb.TagNumber(18)
  void clearIn_18() => $_clearField(18);

  @$pb.TagNumber(21)
  TestAllTypes_NestedMessage get singleNestedMessage => $_getN(16);
  @$pb.TagNumber(21)
  set singleNestedMessage(TestAllTypes_NestedMessage value) =>
      $_setField(21, value);
  @$pb.TagNumber(21)
  $core.bool hasSingleNestedMessage() => $_has(16);
  @$pb.TagNumber(21)
  void clearSingleNestedMessage() => $_clearField(21);
  @$pb.TagNumber(21)
  TestAllTypes_NestedMessage ensureSingleNestedMessage() => $_ensure(16);

  @$pb.TagNumber(22)
  TestAllTypes_NestedEnum get singleNestedEnum => $_getN(17);
  @$pb.TagNumber(22)
  set singleNestedEnum(TestAllTypes_NestedEnum value) => $_setField(22, value);
  @$pb.TagNumber(22)
  $core.bool hasSingleNestedEnum() => $_has(17);
  @$pb.TagNumber(22)
  void clearSingleNestedEnum() => $_clearField(22);

  @$pb.TagNumber(23)
  TestAllTypes_NestedMessage get standaloneMessage => $_getN(18);
  @$pb.TagNumber(23)
  set standaloneMessage(TestAllTypes_NestedMessage value) =>
      $_setField(23, value);
  @$pb.TagNumber(23)
  $core.bool hasStandaloneMessage() => $_has(18);
  @$pb.TagNumber(23)
  void clearStandaloneMessage() => $_clearField(23);
  @$pb.TagNumber(23)
  TestAllTypes_NestedMessage ensureStandaloneMessage() => $_ensure(18);

  @$pb.TagNumber(24)
  TestAllTypes_NestedEnum get standaloneEnum => $_getN(19);
  @$pb.TagNumber(24)
  set standaloneEnum(TestAllTypes_NestedEnum value) => $_setField(24, value);
  @$pb.TagNumber(24)
  $core.bool hasStandaloneEnum() => $_has(19);
  @$pb.TagNumber(24)
  void clearStandaloneEnum() => $_clearField(24);

  /// Repeated
  @$pb.TagNumber(31)
  $pb.PbList<$core.int> get repeatedInt32 => $_getList(20);

  @$pb.TagNumber(32)
  $pb.PbList<$fixnum.Int64> get repeatedInt64 => $_getList(21);

  @$pb.TagNumber(33)
  $pb.PbList<$core.int> get repeatedUint32 => $_getList(22);

  @$pb.TagNumber(34)
  $pb.PbList<$fixnum.Int64> get repeatedUint64 => $_getList(23);

  @$pb.TagNumber(35)
  $pb.PbList<$core.int> get repeatedSint32 => $_getList(24);

  @$pb.TagNumber(36)
  $pb.PbList<$fixnum.Int64> get repeatedSint64 => $_getList(25);

  @$pb.TagNumber(37)
  $pb.PbList<$core.int> get repeatedFixed32 => $_getList(26);

  @$pb.TagNumber(38)
  $pb.PbList<$fixnum.Int64> get repeatedFixed64 => $_getList(27);

  @$pb.TagNumber(39)
  $pb.PbList<$core.int> get repeatedSfixed32 => $_getList(28);

  @$pb.TagNumber(40)
  $pb.PbList<$fixnum.Int64> get repeatedSfixed64 => $_getList(29);

  @$pb.TagNumber(41)
  $pb.PbList<$core.double> get repeatedFloat => $_getList(30);

  @$pb.TagNumber(42)
  $pb.PbList<$core.double> get repeatedDouble => $_getList(31);

  @$pb.TagNumber(43)
  $pb.PbList<$core.bool> get repeatedBool => $_getList(32);

  @$pb.TagNumber(44)
  $pb.PbList<$core.String> get repeatedString => $_getList(33);

  @$pb.TagNumber(45)
  $pb.PbList<$core.List<$core.int>> get repeatedBytes => $_getList(34);

  /// Repeated and nested
  @$pb.TagNumber(51)
  $pb.PbList<TestAllTypes_NestedMessage> get repeatedNestedMessage =>
      $_getList(35);

  @$pb.TagNumber(52)
  $pb.PbList<TestAllTypes_NestedEnum> get repeatedNestedEnum => $_getList(36);

  @$pb.TagNumber(53)
  $pb.PbList<$core.String> get repeatedStringPiece => $_getList(37);

  @$pb.TagNumber(54)
  $pb.PbList<$core.String> get repeatedCord => $_getList(38);

  @$pb.TagNumber(55)
  $pb.PbList<TestAllTypes_NestedMessage> get repeatedLazyMessage =>
      $_getList(39);

  @$pb.TagNumber(61)
  $pb.PbMap<$core.String, $core.String> get mapStringString => $_getMap(40);

  /// Map
  @$pb.TagNumber(62)
  $pb.PbMap<$fixnum.Int64, NestedTestAllTypes> get mapInt64NestedType =>
      $_getMap(41);

  @$pb.TagNumber(63)
  $pb.PbMap<$core.bool, $core.bool> get mapBoolBool => $_getMap(42);

  @$pb.TagNumber(64)
  $pb.PbMap<$core.bool, $core.String> get mapBoolString => $_getMap(43);

  @$pb.TagNumber(65)
  $pb.PbMap<$core.bool, $core.List<$core.int>> get mapBoolBytes => $_getMap(44);

  @$pb.TagNumber(66)
  $pb.PbMap<$core.bool, $core.int> get mapBoolInt32 => $_getMap(45);

  @$pb.TagNumber(67)
  $pb.PbMap<$core.bool, $fixnum.Int64> get mapBoolInt64 => $_getMap(46);

  @$pb.TagNumber(68)
  $pb.PbMap<$core.bool, $core.int> get mapBoolUint32 => $_getMap(47);

  @$pb.TagNumber(69)
  $pb.PbMap<$core.bool, $fixnum.Int64> get mapBoolUint64 => $_getMap(48);

  @$pb.TagNumber(70)
  $pb.PbMap<$core.bool, $core.double> get mapBoolFloat => $_getMap(49);

  @$pb.TagNumber(71)
  $pb.PbMap<$core.bool, $core.double> get mapBoolDouble => $_getMap(50);

  @$pb.TagNumber(72)
  $pb.PbMap<$core.bool, TestAllTypes_NestedEnum> get mapBoolEnum =>
      $_getMap(51);

  @$pb.TagNumber(73)
  $pb.PbMap<$core.bool, TestAllTypes_NestedMessage> get mapBoolMessage =>
      $_getMap(52);

  @$pb.TagNumber(74)
  $pb.PbMap<$core.int, $core.bool> get mapInt32Bool => $_getMap(53);

  @$pb.TagNumber(75)
  $pb.PbMap<$core.int, $core.String> get mapInt32String => $_getMap(54);

  @$pb.TagNumber(76)
  $pb.PbMap<$core.int, $core.List<$core.int>> get mapInt32Bytes => $_getMap(55);

  @$pb.TagNumber(77)
  $pb.PbMap<$core.int, $core.int> get mapInt32Int32 => $_getMap(56);

  @$pb.TagNumber(78)
  $pb.PbMap<$core.int, $fixnum.Int64> get mapInt32Int64 => $_getMap(57);

  @$pb.TagNumber(79)
  $pb.PbMap<$core.int, $core.int> get mapInt32Uint32 => $_getMap(58);

  @$pb.TagNumber(80)
  $pb.PbMap<$core.int, $fixnum.Int64> get mapInt32Uint64 => $_getMap(59);

  @$pb.TagNumber(81)
  $pb.PbMap<$core.int, $core.double> get mapInt32Float => $_getMap(60);

  @$pb.TagNumber(82)
  $pb.PbMap<$core.int, $core.double> get mapInt32Double => $_getMap(61);

  @$pb.TagNumber(83)
  $pb.PbMap<$core.int, TestAllTypes_NestedEnum> get mapInt32Enum =>
      $_getMap(62);

  @$pb.TagNumber(84)
  $pb.PbMap<$core.int, TestAllTypes_NestedMessage> get mapInt32Message =>
      $_getMap(63);

  @$pb.TagNumber(85)
  $pb.PbMap<$fixnum.Int64, $core.bool> get mapInt64Bool => $_getMap(64);

  @$pb.TagNumber(86)
  $pb.PbMap<$fixnum.Int64, $core.String> get mapInt64String => $_getMap(65);

  @$pb.TagNumber(87)
  $pb.PbMap<$fixnum.Int64, $core.List<$core.int>> get mapInt64Bytes =>
      $_getMap(66);

  @$pb.TagNumber(88)
  $pb.PbMap<$fixnum.Int64, $core.int> get mapInt64Int32 => $_getMap(67);

  @$pb.TagNumber(89)
  $pb.PbMap<$fixnum.Int64, $fixnum.Int64> get mapInt64Int64 => $_getMap(68);

  @$pb.TagNumber(90)
  $pb.PbMap<$fixnum.Int64, $core.int> get mapInt64Uint32 => $_getMap(69);

  @$pb.TagNumber(91)
  $pb.PbMap<$fixnum.Int64, $fixnum.Int64> get mapInt64Uint64 => $_getMap(70);

  @$pb.TagNumber(92)
  $pb.PbMap<$fixnum.Int64, $core.double> get mapInt64Float => $_getMap(71);

  @$pb.TagNumber(93)
  $pb.PbMap<$fixnum.Int64, $core.double> get mapInt64Double => $_getMap(72);

  @$pb.TagNumber(94)
  $pb.PbMap<$fixnum.Int64, TestAllTypes_NestedEnum> get mapInt64Enum =>
      $_getMap(73);

  @$pb.TagNumber(95)
  $pb.PbMap<$fixnum.Int64, TestAllTypes_NestedMessage> get mapInt64Message =>
      $_getMap(74);

  @$pb.TagNumber(96)
  $pb.PbMap<$core.int, $core.bool> get mapUint32Bool => $_getMap(75);

  @$pb.TagNumber(97)
  $pb.PbMap<$core.int, $core.String> get mapUint32String => $_getMap(76);

  @$pb.TagNumber(98)
  $pb.PbMap<$core.int, $core.List<$core.int>> get mapUint32Bytes =>
      $_getMap(77);

  @$pb.TagNumber(99)
  $pb.PbMap<$core.int, $core.int> get mapUint32Int32 => $_getMap(78);

  /// Wellknown.
  @$pb.TagNumber(100)
  $0.Any get singleAny => $_getN(79);
  @$pb.TagNumber(100)
  set singleAny($0.Any value) => $_setField(100, value);
  @$pb.TagNumber(100)
  $core.bool hasSingleAny() => $_has(79);
  @$pb.TagNumber(100)
  void clearSingleAny() => $_clearField(100);
  @$pb.TagNumber(100)
  $0.Any ensureSingleAny() => $_ensure(79);

  @$pb.TagNumber(101)
  $1.Duration get singleDuration => $_getN(80);
  @$pb.TagNumber(101)
  set singleDuration($1.Duration value) => $_setField(101, value);
  @$pb.TagNumber(101)
  $core.bool hasSingleDuration() => $_has(80);
  @$pb.TagNumber(101)
  void clearSingleDuration() => $_clearField(101);
  @$pb.TagNumber(101)
  $1.Duration ensureSingleDuration() => $_ensure(80);

  @$pb.TagNumber(102)
  $2.Timestamp get singleTimestamp => $_getN(81);
  @$pb.TagNumber(102)
  set singleTimestamp($2.Timestamp value) => $_setField(102, value);
  @$pb.TagNumber(102)
  $core.bool hasSingleTimestamp() => $_has(81);
  @$pb.TagNumber(102)
  void clearSingleTimestamp() => $_clearField(102);
  @$pb.TagNumber(102)
  $2.Timestamp ensureSingleTimestamp() => $_ensure(81);

  @$pb.TagNumber(103)
  $3.Struct get singleStruct => $_getN(82);
  @$pb.TagNumber(103)
  set singleStruct($3.Struct value) => $_setField(103, value);
  @$pb.TagNumber(103)
  $core.bool hasSingleStruct() => $_has(82);
  @$pb.TagNumber(103)
  void clearSingleStruct() => $_clearField(103);
  @$pb.TagNumber(103)
  $3.Struct ensureSingleStruct() => $_ensure(82);

  @$pb.TagNumber(104)
  $3.Value get singleValue => $_getN(83);
  @$pb.TagNumber(104)
  set singleValue($3.Value value) => $_setField(104, value);
  @$pb.TagNumber(104)
  $core.bool hasSingleValue() => $_has(83);
  @$pb.TagNumber(104)
  void clearSingleValue() => $_clearField(104);
  @$pb.TagNumber(104)
  $3.Value ensureSingleValue() => $_ensure(83);

  @$pb.TagNumber(105)
  $4.Int64Value get singleInt64Wrapper => $_getN(84);
  @$pb.TagNumber(105)
  set singleInt64Wrapper($4.Int64Value value) => $_setField(105, value);
  @$pb.TagNumber(105)
  $core.bool hasSingleInt64Wrapper() => $_has(84);
  @$pb.TagNumber(105)
  void clearSingleInt64Wrapper() => $_clearField(105);
  @$pb.TagNumber(105)
  $4.Int64Value ensureSingleInt64Wrapper() => $_ensure(84);

  @$pb.TagNumber(106)
  $4.Int32Value get singleInt32Wrapper => $_getN(85);
  @$pb.TagNumber(106)
  set singleInt32Wrapper($4.Int32Value value) => $_setField(106, value);
  @$pb.TagNumber(106)
  $core.bool hasSingleInt32Wrapper() => $_has(85);
  @$pb.TagNumber(106)
  void clearSingleInt32Wrapper() => $_clearField(106);
  @$pb.TagNumber(106)
  $4.Int32Value ensureSingleInt32Wrapper() => $_ensure(85);

  @$pb.TagNumber(107)
  $4.DoubleValue get singleDoubleWrapper => $_getN(86);
  @$pb.TagNumber(107)
  set singleDoubleWrapper($4.DoubleValue value) => $_setField(107, value);
  @$pb.TagNumber(107)
  $core.bool hasSingleDoubleWrapper() => $_has(86);
  @$pb.TagNumber(107)
  void clearSingleDoubleWrapper() => $_clearField(107);
  @$pb.TagNumber(107)
  $4.DoubleValue ensureSingleDoubleWrapper() => $_ensure(86);

  @$pb.TagNumber(108)
  $4.FloatValue get singleFloatWrapper => $_getN(87);
  @$pb.TagNumber(108)
  set singleFloatWrapper($4.FloatValue value) => $_setField(108, value);
  @$pb.TagNumber(108)
  $core.bool hasSingleFloatWrapper() => $_has(87);
  @$pb.TagNumber(108)
  void clearSingleFloatWrapper() => $_clearField(108);
  @$pb.TagNumber(108)
  $4.FloatValue ensureSingleFloatWrapper() => $_ensure(87);

  @$pb.TagNumber(109)
  $4.UInt64Value get singleUint64Wrapper => $_getN(88);
  @$pb.TagNumber(109)
  set singleUint64Wrapper($4.UInt64Value value) => $_setField(109, value);
  @$pb.TagNumber(109)
  $core.bool hasSingleUint64Wrapper() => $_has(88);
  @$pb.TagNumber(109)
  void clearSingleUint64Wrapper() => $_clearField(109);
  @$pb.TagNumber(109)
  $4.UInt64Value ensureSingleUint64Wrapper() => $_ensure(88);

  @$pb.TagNumber(110)
  $4.UInt32Value get singleUint32Wrapper => $_getN(89);
  @$pb.TagNumber(110)
  set singleUint32Wrapper($4.UInt32Value value) => $_setField(110, value);
  @$pb.TagNumber(110)
  $core.bool hasSingleUint32Wrapper() => $_has(89);
  @$pb.TagNumber(110)
  void clearSingleUint32Wrapper() => $_clearField(110);
  @$pb.TagNumber(110)
  $4.UInt32Value ensureSingleUint32Wrapper() => $_ensure(89);

  @$pb.TagNumber(111)
  $4.StringValue get singleStringWrapper => $_getN(90);
  @$pb.TagNumber(111)
  set singleStringWrapper($4.StringValue value) => $_setField(111, value);
  @$pb.TagNumber(111)
  $core.bool hasSingleStringWrapper() => $_has(90);
  @$pb.TagNumber(111)
  void clearSingleStringWrapper() => $_clearField(111);
  @$pb.TagNumber(111)
  $4.StringValue ensureSingleStringWrapper() => $_ensure(90);

  @$pb.TagNumber(112)
  $4.BoolValue get singleBoolWrapper => $_getN(91);
  @$pb.TagNumber(112)
  set singleBoolWrapper($4.BoolValue value) => $_setField(112, value);
  @$pb.TagNumber(112)
  $core.bool hasSingleBoolWrapper() => $_has(91);
  @$pb.TagNumber(112)
  void clearSingleBoolWrapper() => $_clearField(112);
  @$pb.TagNumber(112)
  $4.BoolValue ensureSingleBoolWrapper() => $_ensure(91);

  @$pb.TagNumber(113)
  $4.BytesValue get singleBytesWrapper => $_getN(92);
  @$pb.TagNumber(113)
  set singleBytesWrapper($4.BytesValue value) => $_setField(113, value);
  @$pb.TagNumber(113)
  $core.bool hasSingleBytesWrapper() => $_has(92);
  @$pb.TagNumber(113)
  void clearSingleBytesWrapper() => $_clearField(113);
  @$pb.TagNumber(113)
  $4.BytesValue ensureSingleBytesWrapper() => $_ensure(92);

  @$pb.TagNumber(114)
  $3.ListValue get listValue => $_getN(93);
  @$pb.TagNumber(114)
  set listValue($3.ListValue value) => $_setField(114, value);
  @$pb.TagNumber(114)
  $core.bool hasListValue() => $_has(93);
  @$pb.TagNumber(114)
  void clearListValue() => $_clearField(114);
  @$pb.TagNumber(114)
  $3.ListValue ensureListValue() => $_ensure(93);

  @$pb.TagNumber(115)
  $3.NullValue get nullValue => $_getN(94);
  @$pb.TagNumber(115)
  set nullValue($3.NullValue value) => $_setField(115, value);
  @$pb.TagNumber(115)
  $core.bool hasNullValue() => $_has(94);
  @$pb.TagNumber(115)
  void clearNullValue() => $_clearField(115);

  @$pb.TagNumber(116)
  $3.NullValue get optionalNullValue => $_getN(95);
  @$pb.TagNumber(116)
  set optionalNullValue($3.NullValue value) => $_setField(116, value);
  @$pb.TagNumber(116)
  $core.bool hasOptionalNullValue() => $_has(95);
  @$pb.TagNumber(116)
  void clearOptionalNullValue() => $_clearField(116);

  @$pb.TagNumber(117)
  $5.FieldMask get fieldMask => $_getN(96);
  @$pb.TagNumber(117)
  set fieldMask($5.FieldMask value) => $_setField(117, value);
  @$pb.TagNumber(117)
  $core.bool hasFieldMask() => $_has(96);
  @$pb.TagNumber(117)
  void clearFieldMask() => $_clearField(117);
  @$pb.TagNumber(117)
  $5.FieldMask ensureFieldMask() => $_ensure(96);

  @$pb.TagNumber(118)
  $6.Empty get empty => $_getN(97);
  @$pb.TagNumber(118)
  set empty($6.Empty value) => $_setField(118, value);
  @$pb.TagNumber(118)
  $core.bool hasEmpty() => $_has(97);
  @$pb.TagNumber(118)
  void clearEmpty() => $_clearField(118);
  @$pb.TagNumber(118)
  $6.Empty ensureEmpty() => $_ensure(97);

  /// Repeated wellknown.
  @$pb.TagNumber(120)
  $pb.PbList<$0.Any> get repeatedAny => $_getList(98);

  @$pb.TagNumber(121)
  $pb.PbList<$1.Duration> get repeatedDuration => $_getList(99);

  @$pb.TagNumber(122)
  $pb.PbList<$2.Timestamp> get repeatedTimestamp => $_getList(100);

  @$pb.TagNumber(123)
  $pb.PbList<$3.Struct> get repeatedStruct => $_getList(101);

  @$pb.TagNumber(124)
  $pb.PbList<$3.Value> get repeatedValue => $_getList(102);

  @$pb.TagNumber(125)
  $pb.PbList<$4.Int64Value> get repeatedInt64Wrapper => $_getList(103);

  @$pb.TagNumber(126)
  $pb.PbList<$4.Int32Value> get repeatedInt32Wrapper => $_getList(104);

  @$pb.TagNumber(127)
  $pb.PbList<$4.DoubleValue> get repeatedDoubleWrapper => $_getList(105);

  @$pb.TagNumber(128)
  $pb.PbList<$4.FloatValue> get repeatedFloatWrapper => $_getList(106);

  @$pb.TagNumber(129)
  $pb.PbList<$4.UInt64Value> get repeatedUint64Wrapper => $_getList(107);

  @$pb.TagNumber(130)
  $pb.PbList<$4.UInt32Value> get repeatedUint32Wrapper => $_getList(108);

  @$pb.TagNumber(131)
  $pb.PbList<$4.StringValue> get repeatedStringWrapper => $_getList(109);

  @$pb.TagNumber(132)
  $pb.PbList<$4.BoolValue> get repeatedBoolWrapper => $_getList(110);

  @$pb.TagNumber(133)
  $pb.PbList<$4.BytesValue> get repeatedBytesWrapper => $_getList(111);

  @$pb.TagNumber(134)
  $pb.PbList<$3.ListValue> get repeatedListValue => $_getList(112);

  @$pb.TagNumber(135)
  $pb.PbList<$3.NullValue> get repeatedNullValue => $_getList(113);

  @$pb.TagNumber(200)
  $pb.PbMap<$core.int, $fixnum.Int64> get mapUint32Int64 => $_getMap(114);

  @$pb.TagNumber(201)
  $pb.PbMap<$core.int, $core.int> get mapUint32Uint32 => $_getMap(115);

  @$pb.TagNumber(202)
  $pb.PbMap<$core.int, $fixnum.Int64> get mapUint32Uint64 => $_getMap(116);

  @$pb.TagNumber(203)
  $pb.PbMap<$core.int, $core.double> get mapUint32Float => $_getMap(117);

  @$pb.TagNumber(204)
  $pb.PbMap<$core.int, $core.double> get mapUint32Double => $_getMap(118);

  @$pb.TagNumber(205)
  $pb.PbMap<$core.int, TestAllTypes_NestedEnum> get mapUint32Enum =>
      $_getMap(119);

  @$pb.TagNumber(206)
  $pb.PbMap<$core.int, TestAllTypes_NestedMessage> get mapUint32Message =>
      $_getMap(120);

  @$pb.TagNumber(207)
  $pb.PbMap<$fixnum.Int64, $core.bool> get mapUint64Bool => $_getMap(121);

  @$pb.TagNumber(208)
  $pb.PbMap<$fixnum.Int64, $core.String> get mapUint64String => $_getMap(122);

  @$pb.TagNumber(209)
  $pb.PbMap<$fixnum.Int64, $core.List<$core.int>> get mapUint64Bytes =>
      $_getMap(123);

  @$pb.TagNumber(210)
  $pb.PbMap<$fixnum.Int64, $core.int> get mapUint64Int32 => $_getMap(124);

  @$pb.TagNumber(211)
  $pb.PbMap<$fixnum.Int64, $fixnum.Int64> get mapUint64Int64 => $_getMap(125);

  @$pb.TagNumber(212)
  $pb.PbMap<$fixnum.Int64, $core.int> get mapUint64Uint32 => $_getMap(126);

  @$pb.TagNumber(213)
  $pb.PbMap<$fixnum.Int64, $fixnum.Int64> get mapUint64Uint64 => $_getMap(127);

  @$pb.TagNumber(214)
  $pb.PbMap<$fixnum.Int64, $core.double> get mapUint64Float => $_getMap(128);

  @$pb.TagNumber(215)
  $pb.PbMap<$fixnum.Int64, $core.double> get mapUint64Double => $_getMap(129);

  @$pb.TagNumber(216)
  $pb.PbMap<$fixnum.Int64, TestAllTypes_NestedEnum> get mapUint64Enum =>
      $_getMap(130);

  @$pb.TagNumber(217)
  $pb.PbMap<$fixnum.Int64, TestAllTypes_NestedMessage> get mapUint64Message =>
      $_getMap(131);

  @$pb.TagNumber(218)
  $pb.PbMap<$core.String, $core.bool> get mapStringBool => $_getMap(132);

  @$pb.TagNumber(219)
  $pb.PbMap<$core.String, $core.List<$core.int>> get mapStringBytes =>
      $_getMap(133);

  @$pb.TagNumber(220)
  $pb.PbMap<$core.String, $core.int> get mapStringInt32 => $_getMap(134);

  @$pb.TagNumber(221)
  $pb.PbMap<$core.String, $fixnum.Int64> get mapStringInt64 => $_getMap(135);

  @$pb.TagNumber(222)
  $pb.PbMap<$core.String, $core.int> get mapStringUint32 => $_getMap(136);

  @$pb.TagNumber(223)
  $pb.PbMap<$core.String, $fixnum.Int64> get mapStringUint64 => $_getMap(137);

  @$pb.TagNumber(224)
  $pb.PbMap<$core.String, $core.double> get mapStringFloat => $_getMap(138);

  @$pb.TagNumber(225)
  $pb.PbMap<$core.String, $core.double> get mapStringDouble => $_getMap(139);

  @$pb.TagNumber(226)
  $pb.PbMap<$core.String, TestAllTypes_NestedEnum> get mapStringEnum =>
      $_getMap(140);

  @$pb.TagNumber(227)
  $pb.PbMap<$core.String, TestAllTypes_NestedMessage> get mapStringMessage =>
      $_getMap(141);

  @$pb.TagNumber(228)
  $pb.PbMap<$core.bool, $1.Duration> get mapBoolDuration => $_getMap(142);

  @$pb.TagNumber(229)
  $pb.PbMap<$core.bool, $2.Timestamp> get mapBoolTimestamp => $_getMap(143);

  @$pb.TagNumber(230)
  $pb.PbMap<$core.bool, $3.NullValue> get mapBoolNullValue => $_getMap(144);

  @$pb.TagNumber(231)
  $pb.PbMap<$core.int, $1.Duration> get mapInt32Duration => $_getMap(145);

  @$pb.TagNumber(232)
  $pb.PbMap<$core.int, $2.Timestamp> get mapInt32Timestamp => $_getMap(146);

  @$pb.TagNumber(233)
  $pb.PbMap<$core.int, $3.NullValue> get mapInt32NullValue => $_getMap(147);

  @$pb.TagNumber(234)
  $pb.PbMap<$fixnum.Int64, $1.Duration> get mapInt64Duration => $_getMap(148);

  @$pb.TagNumber(235)
  $pb.PbMap<$fixnum.Int64, $2.Timestamp> get mapInt64Timestamp => $_getMap(149);

  @$pb.TagNumber(236)
  $pb.PbMap<$fixnum.Int64, $3.NullValue> get mapInt64NullValue => $_getMap(150);

  @$pb.TagNumber(237)
  $pb.PbMap<$core.int, $1.Duration> get mapUint32Duration => $_getMap(151);

  @$pb.TagNumber(238)
  $pb.PbMap<$core.int, $2.Timestamp> get mapUint32Timestamp => $_getMap(152);

  @$pb.TagNumber(239)
  $pb.PbMap<$core.int, $3.NullValue> get mapUint32NullValue => $_getMap(153);

  @$pb.TagNumber(240)
  $pb.PbMap<$fixnum.Int64, $1.Duration> get mapUint64Duration => $_getMap(154);

  @$pb.TagNumber(241)
  $pb.PbMap<$fixnum.Int64, $2.Timestamp> get mapUint64Timestamp =>
      $_getMap(155);

  @$pb.TagNumber(242)
  $pb.PbMap<$fixnum.Int64, $3.NullValue> get mapUint64NullValue =>
      $_getMap(156);

  @$pb.TagNumber(243)
  $pb.PbMap<$core.String, $1.Duration> get mapStringDuration => $_getMap(157);

  @$pb.TagNumber(244)
  $pb.PbMap<$core.String, $2.Timestamp> get mapStringTimestamp => $_getMap(158);

  @$pb.TagNumber(245)
  $pb.PbMap<$core.String, $3.NullValue> get mapStringNullValue => $_getMap(159);

  @$pb.TagNumber(246)
  $pb.PbMap<$core.bool, $0.Any> get mapBoolAny => $_getMap(160);

  @$pb.TagNumber(247)
  $pb.PbMap<$core.bool, $3.Struct> get mapBoolStruct => $_getMap(161);

  @$pb.TagNumber(248)
  $pb.PbMap<$core.bool, $3.Value> get mapBoolValue => $_getMap(162);

  @$pb.TagNumber(249)
  $pb.PbMap<$core.bool, $3.ListValue> get mapBoolListValue => $_getMap(163);

  @$pb.TagNumber(250)
  $pb.PbMap<$core.bool, $4.Int64Value> get mapBoolInt64Wrapper => $_getMap(164);

  @$pb.TagNumber(251)
  $pb.PbMap<$core.bool, $4.Int32Value> get mapBoolInt32Wrapper => $_getMap(165);

  @$pb.TagNumber(252)
  $pb.PbMap<$core.bool, $4.DoubleValue> get mapBoolDoubleWrapper =>
      $_getMap(166);

  @$pb.TagNumber(253)
  $pb.PbMap<$core.bool, $4.FloatValue> get mapBoolFloatWrapper => $_getMap(167);

  @$pb.TagNumber(254)
  $pb.PbMap<$core.bool, $4.UInt64Value> get mapBoolUint64Wrapper =>
      $_getMap(168);

  @$pb.TagNumber(255)
  $pb.PbMap<$core.bool, $4.UInt32Value> get mapBoolUint32Wrapper =>
      $_getMap(169);

  @$pb.TagNumber(256)
  $pb.PbMap<$core.bool, $4.StringValue> get mapBoolStringWrapper =>
      $_getMap(170);

  @$pb.TagNumber(257)
  $pb.PbMap<$core.bool, $4.BoolValue> get mapBoolBoolWrapper => $_getMap(171);

  @$pb.TagNumber(258)
  $pb.PbMap<$core.bool, $4.BytesValue> get mapBoolBytesWrapper => $_getMap(172);

  @$pb.TagNumber(259)
  $pb.PbMap<$core.int, $0.Any> get mapInt32Any => $_getMap(173);

  @$pb.TagNumber(260)
  $pb.PbMap<$core.int, $3.Struct> get mapInt32Struct => $_getMap(174);

  @$pb.TagNumber(261)
  $pb.PbMap<$core.int, $3.Value> get mapInt32Value => $_getMap(175);

  @$pb.TagNumber(262)
  $pb.PbMap<$core.int, $3.ListValue> get mapInt32ListValue => $_getMap(176);

  @$pb.TagNumber(263)
  $pb.PbMap<$core.int, $4.Int64Value> get mapInt32Int64Wrapper => $_getMap(177);

  @$pb.TagNumber(264)
  $pb.PbMap<$core.int, $4.Int32Value> get mapInt32Int32Wrapper => $_getMap(178);

  @$pb.TagNumber(265)
  $pb.PbMap<$core.int, $4.DoubleValue> get mapInt32DoubleWrapper =>
      $_getMap(179);

  @$pb.TagNumber(266)
  $pb.PbMap<$core.int, $4.FloatValue> get mapInt32FloatWrapper => $_getMap(180);

  @$pb.TagNumber(267)
  $pb.PbMap<$core.int, $4.UInt64Value> get mapInt32Uint64Wrapper =>
      $_getMap(181);

  @$pb.TagNumber(268)
  $pb.PbMap<$core.int, $4.UInt32Value> get mapInt32Uint32Wrapper =>
      $_getMap(182);

  @$pb.TagNumber(269)
  $pb.PbMap<$core.int, $4.StringValue> get mapInt32StringWrapper =>
      $_getMap(183);

  @$pb.TagNumber(270)
  $pb.PbMap<$core.int, $4.BoolValue> get mapInt32BoolWrapper => $_getMap(184);

  @$pb.TagNumber(271)
  $pb.PbMap<$core.int, $4.BytesValue> get mapInt32BytesWrapper => $_getMap(185);

  @$pb.TagNumber(272)
  $pb.PbMap<$fixnum.Int64, $0.Any> get mapInt64Any => $_getMap(186);

  @$pb.TagNumber(273)
  $pb.PbMap<$fixnum.Int64, $3.Struct> get mapInt64Struct => $_getMap(187);

  @$pb.TagNumber(274)
  $pb.PbMap<$fixnum.Int64, $3.Value> get mapInt64Value => $_getMap(188);

  @$pb.TagNumber(275)
  $pb.PbMap<$fixnum.Int64, $3.ListValue> get mapInt64ListValue => $_getMap(189);

  @$pb.TagNumber(276)
  $pb.PbMap<$fixnum.Int64, $4.Int64Value> get mapInt64Int64Wrapper =>
      $_getMap(190);

  @$pb.TagNumber(277)
  $pb.PbMap<$fixnum.Int64, $4.Int32Value> get mapInt64Int32Wrapper =>
      $_getMap(191);

  @$pb.TagNumber(278)
  $pb.PbMap<$fixnum.Int64, $4.DoubleValue> get mapInt64DoubleWrapper =>
      $_getMap(192);

  @$pb.TagNumber(279)
  $pb.PbMap<$fixnum.Int64, $4.FloatValue> get mapInt64FloatWrapper =>
      $_getMap(193);

  @$pb.TagNumber(280)
  $pb.PbMap<$fixnum.Int64, $4.UInt64Value> get mapInt64Uint64Wrapper =>
      $_getMap(194);

  @$pb.TagNumber(281)
  $pb.PbMap<$fixnum.Int64, $4.UInt32Value> get mapInt64Uint32Wrapper =>
      $_getMap(195);

  @$pb.TagNumber(282)
  $pb.PbMap<$fixnum.Int64, $4.StringValue> get mapInt64StringWrapper =>
      $_getMap(196);

  @$pb.TagNumber(283)
  $pb.PbMap<$fixnum.Int64, $4.BoolValue> get mapInt64BoolWrapper =>
      $_getMap(197);

  @$pb.TagNumber(284)
  $pb.PbMap<$fixnum.Int64, $4.BytesValue> get mapInt64BytesWrapper =>
      $_getMap(198);

  @$pb.TagNumber(285)
  $pb.PbMap<$core.int, $0.Any> get mapUint32Any => $_getMap(199);

  @$pb.TagNumber(286)
  $pb.PbMap<$core.int, $3.Struct> get mapUint32Struct => $_getMap(200);

  @$pb.TagNumber(287)
  $pb.PbMap<$core.int, $3.Value> get mapUint32Value => $_getMap(201);

  @$pb.TagNumber(288)
  $pb.PbMap<$core.int, $3.ListValue> get mapUint32ListValue => $_getMap(202);

  @$pb.TagNumber(289)
  $pb.PbMap<$core.int, $4.Int64Value> get mapUint32Int64Wrapper =>
      $_getMap(203);

  @$pb.TagNumber(290)
  $pb.PbMap<$core.int, $4.Int32Value> get mapUint32Int32Wrapper =>
      $_getMap(204);

  @$pb.TagNumber(291)
  $pb.PbMap<$core.int, $4.DoubleValue> get mapUint32DoubleWrapper =>
      $_getMap(205);

  @$pb.TagNumber(292)
  $pb.PbMap<$core.int, $4.FloatValue> get mapUint32FloatWrapper =>
      $_getMap(206);

  @$pb.TagNumber(293)
  $pb.PbMap<$core.int, $4.UInt64Value> get mapUint32Uint64Wrapper =>
      $_getMap(207);

  @$pb.TagNumber(294)
  $pb.PbMap<$core.int, $4.UInt32Value> get mapUint32Uint32Wrapper =>
      $_getMap(208);

  @$pb.TagNumber(295)
  $pb.PbMap<$core.int, $4.StringValue> get mapUint32StringWrapper =>
      $_getMap(209);

  @$pb.TagNumber(296)
  $pb.PbMap<$core.int, $4.BoolValue> get mapUint32BoolWrapper => $_getMap(210);

  @$pb.TagNumber(297)
  $pb.PbMap<$core.int, $4.BytesValue> get mapUint32BytesWrapper =>
      $_getMap(211);

  @$pb.TagNumber(298)
  $pb.PbMap<$fixnum.Int64, $0.Any> get mapUint64Any => $_getMap(212);

  @$pb.TagNumber(299)
  $pb.PbMap<$fixnum.Int64, $3.Struct> get mapUint64Struct => $_getMap(213);

  @$pb.TagNumber(300)
  $pb.PbMap<$fixnum.Int64, $3.Value> get mapUint64Value => $_getMap(214);

  @$pb.TagNumber(301)
  $pb.PbMap<$fixnum.Int64, $3.ListValue> get mapUint64ListValue =>
      $_getMap(215);

  @$pb.TagNumber(302)
  $pb.PbMap<$fixnum.Int64, $4.Int64Value> get mapUint64Int64Wrapper =>
      $_getMap(216);

  @$pb.TagNumber(303)
  $pb.PbMap<$fixnum.Int64, $4.Int32Value> get mapUint64Int32Wrapper =>
      $_getMap(217);

  @$pb.TagNumber(304)
  $pb.PbMap<$fixnum.Int64, $4.DoubleValue> get mapUint64DoubleWrapper =>
      $_getMap(218);

  @$pb.TagNumber(305)
  $pb.PbMap<$fixnum.Int64, $4.FloatValue> get mapUint64FloatWrapper =>
      $_getMap(219);

  @$pb.TagNumber(306)
  $pb.PbMap<$fixnum.Int64, $4.UInt64Value> get mapUint64Uint64Wrapper =>
      $_getMap(220);

  @$pb.TagNumber(307)
  $pb.PbMap<$fixnum.Int64, $4.UInt32Value> get mapUint64Uint32Wrapper =>
      $_getMap(221);

  @$pb.TagNumber(308)
  $pb.PbMap<$fixnum.Int64, $4.StringValue> get mapUint64StringWrapper =>
      $_getMap(222);

  @$pb.TagNumber(309)
  $pb.PbMap<$fixnum.Int64, $4.BoolValue> get mapUint64BoolWrapper =>
      $_getMap(223);

  @$pb.TagNumber(310)
  $pb.PbMap<$fixnum.Int64, $4.BytesValue> get mapUint64BytesWrapper =>
      $_getMap(224);

  @$pb.TagNumber(311)
  $pb.PbMap<$core.String, $0.Any> get mapStringAny => $_getMap(225);

  @$pb.TagNumber(312)
  $pb.PbMap<$core.String, $3.Struct> get mapStringStruct => $_getMap(226);

  @$pb.TagNumber(313)
  $pb.PbMap<$core.String, $3.Value> get mapStringValue => $_getMap(227);

  @$pb.TagNumber(314)
  $pb.PbMap<$core.String, $3.ListValue> get mapStringListValue => $_getMap(228);

  @$pb.TagNumber(315)
  $pb.PbMap<$core.String, $4.Int64Value> get mapStringInt64Wrapper =>
      $_getMap(229);

  @$pb.TagNumber(316)
  $pb.PbMap<$core.String, $4.Int32Value> get mapStringInt32Wrapper =>
      $_getMap(230);

  @$pb.TagNumber(317)
  $pb.PbMap<$core.String, $4.DoubleValue> get mapStringDoubleWrapper =>
      $_getMap(231);

  @$pb.TagNumber(318)
  $pb.PbMap<$core.String, $4.FloatValue> get mapStringFloatWrapper =>
      $_getMap(232);

  @$pb.TagNumber(319)
  $pb.PbMap<$core.String, $4.UInt64Value> get mapStringUint64Wrapper =>
      $_getMap(233);

  @$pb.TagNumber(320)
  $pb.PbMap<$core.String, $4.UInt32Value> get mapStringUint32Wrapper =>
      $_getMap(234);

  @$pb.TagNumber(321)
  $pb.PbMap<$core.String, $4.StringValue> get mapStringStringWrapper =>
      $_getMap(235);

  @$pb.TagNumber(322)
  $pb.PbMap<$core.String, $4.BoolValue> get mapStringBoolWrapper =>
      $_getMap(236);

  @$pb.TagNumber(323)
  $pb.PbMap<$core.String, $4.BytesValue> get mapStringBytesWrapper =>
      $_getMap(237);

  @$pb.TagNumber(400)
  NestedTestAllTypes get oneofType => $_getN(238);
  @$pb.TagNumber(400)
  set oneofType(NestedTestAllTypes value) => $_setField(400, value);
  @$pb.TagNumber(400)
  $core.bool hasOneofType() => $_has(238);
  @$pb.TagNumber(400)
  void clearOneofType() => $_clearField(400);
  @$pb.TagNumber(400)
  NestedTestAllTypes ensureOneofType() => $_ensure(238);

  @$pb.TagNumber(401)
  TestAllTypes_NestedMessage get oneofMsg => $_getN(239);
  @$pb.TagNumber(401)
  set oneofMsg(TestAllTypes_NestedMessage value) => $_setField(401, value);
  @$pb.TagNumber(401)
  $core.bool hasOneofMsg() => $_has(239);
  @$pb.TagNumber(401)
  void clearOneofMsg() => $_clearField(401);
  @$pb.TagNumber(401)
  TestAllTypes_NestedMessage ensureOneofMsg() => $_ensure(239);

  @$pb.TagNumber(402)
  $core.bool get oneofBool => $_getBF(240);
  @$pb.TagNumber(402)
  set oneofBool($core.bool value) => $_setBool(240, value);
  @$pb.TagNumber(402)
  $core.bool hasOneofBool() => $_has(240);
  @$pb.TagNumber(402)
  void clearOneofBool() => $_clearField(402);

  @$pb.TagNumber(403)
  TestAllTypes_NestedGroup get nestedGroup => $_getN(241);
  @$pb.TagNumber(403)
  set nestedGroup(TestAllTypes_NestedGroup value) => $_setField(403, value);
  @$pb.TagNumber(403)
  $core.bool hasNestedGroup() => $_has(241);
  @$pb.TagNumber(403)
  void clearNestedGroup() => $_clearField(403);
}

/// This proto includes a recursively nested message.
class NestedTestAllTypes extends $pb.GeneratedMessage {
  factory NestedTestAllTypes({
    NestedTestAllTypes? child,
    TestAllTypes? payload,
  }) {
    final result = create();
    if (child != null) result.child = child;
    if (payload != null) result.payload = payload;
    return result;
  }

  NestedTestAllTypes._();

  factory NestedTestAllTypes.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NestedTestAllTypes.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NestedTestAllTypes',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'cel.expr.conformance.proto2'),
      createEmptyInstance: create)
    ..aOM<NestedTestAllTypes>(1, _omitFieldNames ? '' : 'child',
        subBuilder: NestedTestAllTypes.create)
    ..aOM<TestAllTypes>(2, _omitFieldNames ? '' : 'payload',
        subBuilder: TestAllTypes.create);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NestedTestAllTypes clone() => NestedTestAllTypes()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NestedTestAllTypes copyWith(void Function(NestedTestAllTypes) updates) =>
      super.copyWith((message) => updates(message as NestedTestAllTypes))
          as NestedTestAllTypes;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NestedTestAllTypes create() => NestedTestAllTypes._();
  @$core.override
  NestedTestAllTypes createEmptyInstance() => create();
  static $pb.PbList<NestedTestAllTypes> createRepeated() =>
      $pb.PbList<NestedTestAllTypes>();
  @$core.pragma('dart2js:noInline')
  static NestedTestAllTypes getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NestedTestAllTypes>(create);
  static NestedTestAllTypes? _defaultInstance;

  @$pb.TagNumber(1)
  NestedTestAllTypes get child => $_getN(0);
  @$pb.TagNumber(1)
  set child(NestedTestAllTypes value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasChild() => $_has(0);
  @$pb.TagNumber(1)
  void clearChild() => $_clearField(1);
  @$pb.TagNumber(1)
  NestedTestAllTypes ensureChild() => $_ensure(0);

  @$pb.TagNumber(2)
  TestAllTypes get payload => $_getN(1);
  @$pb.TagNumber(2)
  set payload(TestAllTypes value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPayload() => $_has(1);
  @$pb.TagNumber(2)
  void clearPayload() => $_clearField(2);
  @$pb.TagNumber(2)
  TestAllTypes ensurePayload() => $_ensure(1);
}

/// This proto has a required field.
class TestRequired extends $pb.GeneratedMessage {
  factory TestRequired({
    $core.int? requiredInt32,
  }) {
    final result = create();
    if (requiredInt32 != null) result.requiredInt32 = requiredInt32;
    return result;
  }

  TestRequired._();

  factory TestRequired.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TestRequired.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TestRequired',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'cel.expr.conformance.proto2'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1, _omitFieldNames ? '' : 'requiredInt32', $pb.PbFieldType.Q3,
        presence: $pb.FieldPresence.legacyRequired);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TestRequired clone() => TestRequired()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TestRequired copyWith(void Function(TestRequired) updates) =>
      super.copyWith((message) => updates(message as TestRequired))
          as TestRequired;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestRequired create() => TestRequired._();
  @$core.override
  TestRequired createEmptyInstance() => create();
  static $pb.PbList<TestRequired> createRepeated() =>
      $pb.PbList<TestRequired>();
  @$core.pragma('dart2js:noInline')
  static TestRequired getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TestRequired>(create);
  static TestRequired? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get requiredInt32 => $_getIZ(0);
  @$pb.TagNumber(1)
  set requiredInt32($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRequiredInt32() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequiredInt32() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
