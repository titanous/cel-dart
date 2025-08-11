import 'package:equatable/equatable.dart';
import 'package:cel/src/gen/google/protobuf/wrappers.pb.dart' as pb_wrappers;
import '../common/types/ref/provider.dart';

abstract class Activation extends Equatable {
  dynamic resolveName(dynamic namespaceName);

  @override
  bool? get stringify => true;
}

class EvalActivation extends Activation {
  EvalActivation(this.input, {this.typeAdapter});

  final Map<String, dynamic> input;
  final TypeAdapter? typeAdapter;

  @override
  dynamic resolveName(dynamic namespaceName) {
    // Get the value from input
    final value = input[namespaceName];
    
    // If it's a wrapper type, unwrap it to the primitive value
    if (value is pb_wrappers.DoubleValue) {
      return value.value;
    } else if (value is pb_wrappers.FloatValue) {
      return value.value.toDouble();
    } else if (value is pb_wrappers.Int64Value) {
      return value.value.toInt();
    } else if (value is pb_wrappers.UInt64Value) {
      return value.value.toInt();
    } else if (value is pb_wrappers.Int32Value) {
      return value.value;
    } else if (value is pb_wrappers.UInt32Value) {
      return value.value;
    } else if (value is pb_wrappers.BoolValue) {
      return value.value;
    } else if (value is pb_wrappers.StringValue) {
      return value.value;
    } else if (value is pb_wrappers.BytesValue) {
      return value.value;
    }
    
    // Return the value as-is for non-wrapper types
    // Return null for unbound variables instead of throwing
    // This allows the attribute resolution to handle it properly
    return value;
  }

  @override
  List<Object?> get props => [input, typeAdapter];
}
