import 'package:equatable/equatable.dart';

abstract class Activation extends Equatable {
  resolveName(namespaceName);

  @override
  bool? get stringify => true;
}

class EvalActivation extends Activation {
  EvalActivation(this.input);

  final Map<String, dynamic> input;

  @override
  resolveName(namespaceName) {
    // Return null for unbound variables instead of throwing
    // This allows the attribute resolution to handle it properly
    return input[namespaceName];
  }

  @override
  List<Object?> get props => [input];
}
