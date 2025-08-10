// ProgramOption is a functional interface for configuring evaluation bindings and behaviors.
import '../../cel.dart';
import '../interpreter/functions/functions.dart';

/// Applies an option to an [Environment].
/// https://github.com/google/cel-go/blob/35783e995ccefef460a18a034af7d4ad044f57b4/cel/options.go#L72
typedef EnvironmentOption = void Function(Environment e);

/// Container sets the container for resolving variable and type names.
EnvironmentOption withContainer(String name) {
  return (Environment env) {
    env.container = env.container.extend(name: name);
  };
}

/// Applies an option to a [Program].
typedef ProgramOption = void Function(Program p);

// https://github.com/google/cel-go/blob/35783e995ccefef460a18a034af7d4ad044f57b4/cel/options.go#L348
ProgramOption functions(List<Overload> functions) {
  return (Program p) {
    p.dispatcher.add(functions);
  };
}
