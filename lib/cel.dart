/// parses and evaluates Common Expression Language (CEL) programs against some
/// inputs.
library cel;

export 'src/cel/ast.dart';
export 'src/cel/environment.dart';
export 'src/cel/program.dart';

// Library Extension API exports for custom function registration
export 'src/cel/library.dart' show Library;
export 'src/cel/options.dart' show EnvironmentOption, ProgramOption, functions;
export 'src/interpreter/functions/functions.dart'
    show Overload, UnaryOperator, BinaryOperator, FunctionOperator, CelType;

// CEL Value Types exports for function implementations
export 'src/common/types/bool.dart' show BooleanValue;
export 'src/common/types/string.dart' show StringValue;
export 'src/common/types/int.dart' show IntValue;
export 'src/common/types/double.dart' show DoubleValue;
export 'src/common/types/list.dart' show ListValue;
export 'src/common/types/map.dart' show MapValue;
export 'src/common/types/bytes.dart' show BytesValue;
export 'src/common/types/error.dart' show ErrorValue;
export 'src/common/types/timestamp.dart' show TimestampValue;
export 'src/common/types/duration.dart' show DurationValue;

// Enum registry for conformance testing
export 'src/common/types/enum.dart' show globalEnumRegistry;
