import '../function_registry.dart';
import '../functions/functions.dart';

/// Base class for CEL extensions that provide modular functionality
abstract class CelExtension {
  /// The name of this extension
  String get name;
  
  /// The functions provided by this extension
  List<Overload> get functions;
  
  /// Register this extension's functions into a registry
  void registerFunctions(FunctionRegistry registry) {
    for (final function in functions) {
      final dispatch = SimpleFunctionDispatch(
        function.functionOperator != null 
          ? function.functionOperator!
          : (args) => _convertLegacyOverload(function, args),
        FunctionSignature(function.name, [], CelType.any), // TODO: Extract proper types
      );
      registry.registerFunction(function.name, dispatch);
    }
  }
  
  /// Convert legacy overload to new function format
  Value _convertLegacyOverload(Overload overload, List<Value> args) {
    if (overload.unaryOperator != null && args.length == 1) {
      return overload.unaryOperator!(args[0]);
    }
    if (overload.binaryOperator != null && args.length == 2) {
      return overload.binaryOperator!(args[0], args[1]);
    }
    if (overload.functionOperator != null) {
      return overload.functionOperator!(args);
    }
    
    return ErrorValue('No matching overload for ${overload.name}');
  }
}

/// Extension registry for managing multiple CEL extensions
class ExtensionRegistry {
  final Map<String, CelExtension> _extensions = {};
  final FunctionRegistry _registry = FunctionRegistry();
  
  /// Add an extension to the registry
  void addExtension(CelExtension extension) {
    _extensions[extension.name] = extension;
    extension.registerFunctions(_registry);
  }
  
  /// Remove an extension from the registry
  void removeExtension(String name) {
    final extension = _extensions.remove(name);
    if (extension != null) {
      // Remove the extension's functions from the registry
      for (final function in extension.functions) {
        _registry.removeFunction(function.name);
      }
    }
  }
  
  /// Get all registered extensions
  Map<String, CelExtension> get extensions => Map.unmodifiable(_extensions);
  
  /// Get the underlying function registry
  FunctionRegistry get functionRegistry => _registry;
  
  /// Check if an extension is registered
  bool hasExtension(String name) => _extensions.containsKey(name);
  
  /// Clear all extensions
  void clear() {
    _extensions.clear();
    _registry.clear();
  }
}