// https://github.com/google/cel-go/blob/master/interpreter/functions/functions.go

class Overload {
  Overload(this.name, {this.unaryOperator, this.binaryOperator, this.functionOperator});

  final String name;
  UnaryOperator? unaryOperator;
  BinaryOperator? binaryOperator;
  FunctionOperator? functionOperator;
}

typedef UnaryOperator = dynamic Function(dynamic value);

typedef BinaryOperator = dynamic Function(
    dynamic leftHandSide, dynamic rightHandSide);

typedef FunctionOperator = dynamic Function(List<dynamic> args);
