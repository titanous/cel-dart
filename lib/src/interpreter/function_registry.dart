import 'functions/functions.dart';
import 'dispatcher.dart';
import '../common/types/ref/value.dart';
import '../common/types/error.dart';

/// Registry for CEL functions with runtime registration capability
/// Inspired by cel-es FuncRegistry pattern
class FunctionRegistry {
  final Map<String, FunctionDispatch> _functions = {};

  /// Register a function with its dispatch logic
  void registerFunction(String name, FunctionDispatch dispatch) {
    _functions[name] = dispatch;
  }

  /// Register multiple functions at once
  void registerFunctions(Map<String, FunctionDispatch> functions) {
    _functions.addAll(functions);
  }

  /// Find a function by name
  FunctionDispatch? findFunction(String name) {
    return _functions[name];
  }

  /// Get all registered function names
  Set<String> get functionNames => _functions.keys.toSet();

  /// Check if a function is registered
  bool hasFunction(String name) {
    return _functions.containsKey(name);
  }

  /// Remove a function from the registry
  void removeFunction(String name) {
    _functions.remove(name);
  }

  /// Clear all registered functions
  void clear() {
    _functions.clear();
  }

  /// Convert this registry to a Dispatcher for backward compatibility
  Dispatcher toDispatcher() {
    final overloads = <Overload>[];
    
    for (final entry in _functions.entries) {
      final name = entry.key;
      final dispatch = entry.value;
      
      // Create overload from function dispatch
      final overload = Overload(
        name,
        functionOperator: (args) => dispatch.call(args.cast<Value>()),
      );
      overloads.add(overload);
    }
    
    return Dispatcher(overloads);
  }
}

/// Function dispatch interface for runtime function calls
abstract class FunctionDispatch {
  /// Call the function with the given arguments
  Value call(List<Value> args);
  
  /// Get function signature information
  FunctionSignature get signature;
}

/// Implementation of FunctionDispatch for simple functions
class SimpleFunctionDispatch implements FunctionDispatch {
  SimpleFunctionDispatch(this._function, this.signature);
  
  final Value Function(List<Value>) _function;
  final FunctionSignature signature;

  @override
  Value call(List<Value> args) {
    return _function(args);
  }
}

/// Implementation of FunctionDispatch with overloaded functions
class OverloadedFunctionDispatch implements FunctionDispatch {
  OverloadedFunctionDispatch(this._overloads, this._defaultSignature);
  
  final List<FunctionOverload> _overloads;
  final FunctionSignature _defaultSignature;

  @override
  Value call(List<Value> args) {
    // Try to find matching overload based on argument types and count
    for (final overload in _overloads) {
      if (overload.matches(args)) {
        return overload.call(args);
      }
    }
    
    // If no overload matches, return an error
    return ErrorValue('No matching overload found for function with ${args.length} arguments');
  }

  @override
  FunctionSignature get signature => _defaultSignature;
}

/// Function signature information
class FunctionSignature {
  FunctionSignature(this.name, this.parameterTypes, this.returnType);
  
  final String name;
  final List<CelType> parameterTypes;
  final CelType returnType;
  
  @override
  String toString() {
    final params = parameterTypes.map((t) => t.name).join(', ');
    return '$name($params) -> ${returnType.name}';
  }
}

/// Function overload for type-based dispatch
class FunctionOverload {
  FunctionOverload(this.signature, this._function);
  
  final FunctionSignature signature;
  final Value Function(List<Value>) _function;

  /// Check if this overload matches the given arguments
  bool matches(List<Value> args) {
    if (args.length != signature.parameterTypes.length) {
      return false;
    }
    
    for (int i = 0; i < args.length; i++) {
      if (!_matchesType(args[i], signature.parameterTypes[i])) {
        return false;
      }
    }
    
    return true;
  }

  /// Call this overload with the given arguments
  Value call(List<Value> args) {
    return _function(args);
  }

  bool _matchesType(Value value, CelType expectedType) {
    final actualType = value.runtimeType.toString();

    switch (expectedType) {
      case CelType.any:
        return true;
      case CelType.bool:
        return actualType == 'BooleanValue';
      case CelType.int:
        return actualType == 'IntValue';
      case CelType.uint:
        return actualType == 'UintValue';
      case CelType.double:
        return actualType == 'DoubleValue';
      case CelType.string:
        return actualType == 'StringValue';
      case CelType.bytes:
        return actualType == 'BytesValue';
      case CelType.list:
        return actualType == 'ListValue';
      case CelType.map:
        return actualType == 'MapValue';
      case CelType.timestamp:
        return actualType == 'TimestampValue';
      case CelType.duration:
        return actualType == 'DurationValue';
    }
  }
}

/// Ordered dispatcher for composing multiple function registries
class OrderedFunctionDispatcher implements FunctionDispatch {
  OrderedFunctionDispatcher(this._dispatchers);
  
  final List<FunctionDispatch> _dispatchers;

  @override
  Value call(List<Value> args) {
    for (final dispatcher in _dispatchers) {
      try {
        final result = dispatcher.call(args);
        // If not an error, return the result
        if (result is! ErrorValue) {
          return result;
        }
      } catch (e) {
        // Continue to next dispatcher
        continue;
      }
    }
    
    // No dispatcher could handle the call
    return ErrorValue('No dispatcher could handle function call');
  }

  @override
  FunctionSignature get signature {
    // Return the first dispatcher's signature as default
    return _dispatchers.isNotEmpty 
        ? _dispatchers.first.signature 
        : FunctionSignature('unknown', [], CelType.any);
  }
}

/// Builder for creating function registries with standard CEL functions
class FunctionRegistryBuilder {
  final FunctionRegistry _registry = FunctionRegistry();

  /// Add standard CEL functions (arithmetic, logical, comparison, etc.)
  FunctionRegistryBuilder withStandardFunctions() {
    // TODO: Register standard CEL functions
    // This would include operators like +, -, *, /, ==, !=, <, >, etc.
    return this;
  }

  /// Add string functions (contains, startsWith, endsWith, etc.)
  FunctionRegistryBuilder withStringFunctions() {
    // TODO: Register string manipulation functions
    return this;
  }

  /// Add math functions (abs, max, min, etc.)
  FunctionRegistryBuilder withMathFunctions() {
    // TODO: Register mathematical functions
    return this;
  }

  /// Add custom function
  FunctionRegistryBuilder withFunction(String name, FunctionDispatch dispatch) {
    _registry.registerFunction(name, dispatch);
    return this;
  }

  /// Build the final registry
  FunctionRegistry build() {
    return _registry;
  }
}