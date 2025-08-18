import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/traits/comparer.dart';
import 'package:cel/src/common/types/traits/traits.dart';
import 'package:cel/src/common/types/traits/math.dart';
import 'package:cel/src/common/types/int.dart';
import 'package:cel/src/common/types/string.dart';
import 'package:cel/src/common/types/error.dart';
import 'package:protobuf/protobuf.dart';

// Import the generated protobuf enums for dynamic registration
import '../../gen/cel/expr/conformance/proto2/test_all_types.pbenum.dart' as proto2_enums;
import '../../gen/cel/expr/conformance/proto3/test_all_types.pbenum.dart' as proto3_enums;

// Import for function registration
import '../../interpreter/functions/functions.dart';

/// Represents a CEL enum value with both type and numeric value
/// Supports both legacy (int) and strong (enum type) semantics
class EnumValue extends Value implements Comparer, Adder, Subtractor {
  EnumValue(this.enumType, this.numericValue, {this.isLegacyMode = false});

  /// The fully qualified enum type name (e.g., "cel.expr.conformance.proto2.GlobalEnum")
  final String enumType;
  
  /// The numeric value of the enum constant
  final int numericValue;
  
  /// Whether this enum uses legacy (int) semantics or strong (enum type) semantics
  final bool isLegacyMode;

  @override
  Type_ get type {
    if (isLegacyMode) {
      // Legacy mode: enums behave as integers
      return Type_('int', {Traits.ComparerType, Traits.AdderType, Traits.SubtractorType});
    } else {
      // Strong mode: enums have their specific type
      return Type_(enumType, {Traits.ComparerType});
    }
  }

  @override
  dynamic get value => numericValue;

  @override
  dynamic convertToNative() {
    if (isLegacyMode) {
      // Legacy mode: convert to int
      return numericValue;
    } else {
      // Strong mode: return the EnumValue object itself  
      return this;
    }
  }

  @override
  Value compare(Value other) {
    if (other is EnumValue) {
      // Enums can only be compared if they're the same type
      if (enumType == other.enumType) {
        final leftInt = IntValue(numericValue);
        final rightInt = IntValue(other.numericValue);
        return leftInt.compare(rightInt);
      }
      // Different enum types are not comparable
      return noSuchOverloadError;
    }
    
    // Legacy mode: enums can be compared with ints
    if (other.type.name == 'int') {
      final leftInt = IntValue(numericValue);
      return leftInt.compare(other);
    }
    
    return noSuchOverloadError;
  }

  @override
  add(Value other) {
    if (isLegacyMode) {
      // Legacy mode: enum arithmetic behaves like int arithmetic
      final enumAsInt = IntValue(numericValue);
      return enumAsInt.add(other);
    }
    // Strong mode: no arithmetic operations
    return noSuchOverloadError;
  }

  @override
  subtract(Value subtrahend) {
    if (isLegacyMode) {
      // Legacy mode: enum arithmetic behaves like int arithmetic
      final enumAsInt = IntValue(numericValue);
      return enumAsInt.subtract(subtrahend);
    }
    // Strong mode: no arithmetic operations
    return noSuchOverloadError;
  }

  @override
  List<Object?> get props => [enumType, numericValue, isLegacyMode];

  @override
  String toString() => '$enumType($numericValue)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnumValue &&
          enumType == other.enumType &&
          numericValue == other.numericValue &&
          isLegacyMode == other.isLegacyMode;

  @override
  int get hashCode => Object.hash(enumType, numericValue, isLegacyMode);

  /// Create an EnumValue for legacy mode (behaves as int)
  static EnumValue createLegacy(String enumType, int value) {
    return EnumValue(enumType, value, isLegacyMode: true);
  }

  /// Create an EnumValue for strong mode (distinct enum type)
  static EnumValue createStrong(String enumType, int value) {
    return EnumValue(enumType, value, isLegacyMode: false);
  }

  /// Convert this enum to an IntValue (for int() conversion)
  IntValue toInt() {
    return IntValue(numericValue);
  }
}

/// Helper function to create enum types
Type_ createEnumType(String enumTypeName) {
  return Type_(enumTypeName, {Traits.ComparerType});
}

/// Legacy enum values behave as integers
final enumLegacyType = Type_('int', {
  Traits.ComparerType, 
  Traits.AdderType, 
  Traits.SubtractorType
});

/// Represents an enum type namespace that can resolve enum constants
/// This allows expressions like GlobalEnum.GAZ to work
class EnumNamespace extends Value {
  EnumNamespace(this.enumTypeName, this.constants, {this.isLegacyMode = false});

  /// The fully qualified enum type name (e.g., "cel.expr.conformance.proto2.GlobalEnum")
  final String enumTypeName;
  
  /// Map of constant names to their numeric values (e.g., {"GAZ": 2, "GAR": 1, "GOO": 0})
  final Map<String, int> constants;
  
  /// Whether this enum namespace uses legacy (int) or strong (enum type) semantics
  final bool isLegacyMode;

  @override
  Type_ get type => Type_('namespace', {});

  @override
  dynamic get value => this;

  @override
  dynamic convertToNative() => this;

  /// Resolve an enum constant by name
  Value? resolveConstant(String constantName) {
    final constantValue = constants[constantName];
    if (constantValue == null) {
      return null; // Constant not found
    }
    
    if (isLegacyMode) {
      // Legacy mode: return as int
      return IntValue(constantValue);
    } else {
      // Strong mode: return as enum value
      return EnumValue.createStrong(enumTypeName, constantValue);
    }
  }
  
  /// Resolve an enum constant by its numeric value (for constructor calls)
  Value? resolveConstantByValue(int value) {
    // Check if this value corresponds to a known constant
    for (final entry in constants.entries) {
      if (entry.value == value) {
        if (isLegacyMode) {
          return IntValue(value);
        } else {
          return EnumValue.createStrong(enumTypeName, value);
        }
      }
    }
    
    // Value not found in known constants, but still create enum value
    if (isLegacyMode) {
      return IntValue(value);
    } else {
      return EnumValue.createStrong(enumTypeName, value);
    }
  }

  @override
  List<Object?> get props => [enumTypeName, constants, isLegacyMode];

  @override
  String toString() => 'EnumNamespace($enumTypeName)';
}

/// Registry for enum types that can be used in CEL expressions
class EnumRegistry {
  final Map<String, EnumNamespace> _enumNamespaces = {};
  
  /// Current global enum mode setting  
  bool _globalLegacyMode = true;
  
  /// Set the global enum mode for all newly resolved enums
  void setGlobalMode({required bool isLegacyMode}) {
    _globalLegacyMode = isLegacyMode;
  }
  
  /// Get the current global enum mode
  bool get isGlobalLegacyMode => _globalLegacyMode;
  
  /// Register an enum type with its constants
  void registerEnum(String enumTypeName, Map<String, int> constants, {bool isLegacyMode = true}) {
    _enumNamespaces[enumTypeName] = EnumNamespace(enumTypeName, constants, isLegacyMode: isLegacyMode);
  }
  
  /// Register an enum from a protobuf enum class
  void registerProtobufEnum(String enumTypeName, List<ProtobufEnum> enumValues, {bool isLegacyMode = true}) {
    final constants = <String, int>{};
    for (final enumValue in enumValues) {
      constants[enumValue.name] = enumValue.value;
    }
    registerEnum(enumTypeName, constants, isLegacyMode: isLegacyMode);
  }
  
  /// Get an enum namespace by type name (supports container resolution)
  EnumNamespace? getEnumNamespace(String enumTypeName) {
    return _enumNamespaces[enumTypeName];
  }
  
  /// Get an enum namespace by short name (e.g., "GlobalEnum") with container context
  /// Returns a new EnumNamespace with the current global mode setting
  EnumNamespace? resolveEnumNamespace(String shortName, String? container) {
    // Try exact match first
    if (_enumNamespaces.containsKey(shortName)) {
      final baseNamespace = _enumNamespaces[shortName]!;
      return EnumNamespace(baseNamespace.enumTypeName, baseNamespace.constants, 
                          isLegacyMode: _globalLegacyMode);
    }
    
    // Try with container prefix
    if (container != null && container.isNotEmpty) {
      final fullName = '$container.$shortName';
      if (_enumNamespaces.containsKey(fullName)) {
        final baseNamespace = _enumNamespaces[fullName]!;
        return EnumNamespace(baseNamespace.enumTypeName, baseNamespace.constants,
                            isLegacyMode: _globalLegacyMode);
      }
    }
    
    // Try all registered enums to find one that ends with the short name
    for (final entry in _enumNamespaces.entries) {
      if (entry.key.endsWith('.$shortName') || entry.key == shortName) {
        // Additional check: if container is specified, prefer matching container
        if (container != null && entry.key.startsWith(container)) {
          return EnumNamespace(entry.value.enumTypeName, entry.value.constants,
                              isLegacyMode: _globalLegacyMode);
        }
      }
    }
    
    // Final fallback: return any enum that ends with the short name
    for (final entry in _enumNamespaces.entries) {
      if (entry.key.endsWith('.$shortName') || entry.key == shortName) {
        return EnumNamespace(entry.value.enumTypeName, entry.value.constants,
                            isLegacyMode: _globalLegacyMode);
      }
    }
    
    return null;
  }
  
  /// Get all registered enum type names
  Set<String> get registeredTypes => _enumNamespaces.keys.toSet();
  
  /// Auto-discover and register enum types from protobuf enum classes
  /// This dynamically reads the enum constants from the actual generated classes
  void discoverAndRegisterProtobufEnums() {
    // Register proto2 enums by reading from the generated classes
    registerFromProtobufClass(
      'cel.expr.conformance.proto2.GlobalEnum',
      proto2_enums.GlobalEnum.values,
      isLegacyMode: true,
    );
    
    registerFromProtobufClass(
      'cel.expr.conformance.proto2.TestAllTypes.NestedEnum',
      proto2_enums.TestAllTypes_NestedEnum.values,
      isLegacyMode: true,
    );
    
    // Register proto3 enums by reading from the generated classes  
    registerFromProtobufClass(
      'cel.expr.conformance.proto3.GlobalEnum',
      proto3_enums.GlobalEnum.values,
      isLegacyMode: true,
    );
    
    registerFromProtobufClass(
      'cel.expr.conformance.proto3.TestAllTypes.NestedEnum', 
      proto3_enums.TestAllTypes_NestedEnum.values,
      isLegacyMode: true,
    );
  }
  
  /// Register an enum from an actual protobuf enum class instance
  /// This method takes a protobuf enum class and extracts its values
  void registerFromProtobufClass<T extends ProtobufEnum>(
    String fullEnumName,
    List<T> enumValues, {
    bool isLegacyMode = true,
  }) {
    final constants = <String, int>{};
    for (final enumValue in enumValues) {
      constants[enumValue.name] = enumValue.value;
    }
    registerEnum(fullEnumName, constants, isLegacyMode: isLegacyMode);
  }
}

/// Global enum registry instance
final globalEnumRegistry = EnumRegistry();

/// Generate enum constructor function overloads for registered enum types
List<Overload> generateEnumConstructorOverloads() {
  final overloads = <Overload>[];
  
  for (final enumTypeName in globalEnumRegistry.registeredTypes) {
    // Extract the simple name (e.g., "GlobalEnum" from "cel.expr.conformance.proto2.GlobalEnum")
    final simpleName = enumTypeName.split('.').last;
    
    // For nested enums, create qualified name (e.g., "TestAllTypes.NestedEnum")
    String functionName = simpleName;
    final parts = enumTypeName.split('.');
    if (parts.length >= 2 && parts[parts.length - 2] != 'proto2' && parts[parts.length - 2] != 'proto3') {
      // Check if this is a nested enum (parent class name + enum name)
      functionName = '${parts[parts.length - 2]}.$simpleName';
    }
    
    // Create constructor overload for int argument: GlobalEnum(1) or TestAllTypes.NestedEnum(1)
    overloads.add(
      Overload(functionName, functionOperator: (args) {
        if (args.isEmpty || args.length > 1) {
          return ErrorValue('$functionName constructor requires exactly 1 argument');
        }
        
        final arg = args[0];
        
        // Handle int argument
        if (arg is IntValue) {
          final namespace = globalEnumRegistry.getEnumNamespace(enumTypeName);
          if (namespace != null) {
            // Always use the current global mode, not the stored namespace mode
            final currentMode = globalEnumRegistry.isGlobalLegacyMode;
            return EnumNamespace(namespace.enumTypeName, namespace.constants,
                                isLegacyMode: currentMode)
                .resolveConstantByValue(arg.value) ?? 
                EnumValue.createStrong(enumTypeName, arg.value);
          }
        }
        
        // Handle string argument: TestAllTypes.NestedEnum('BAZ')
        if (arg is StringValue) {
          final namespace = globalEnumRegistry.getEnumNamespace(enumTypeName);
          if (namespace != null) {
            return namespace.resolveConstant(arg.value) ?? 
                   ErrorValue('invalid enum constant: ${arg.value} for $functionName');
          }
        }
        
        return ErrorValue('$functionName constructor requires int or string argument, got ${arg.runtimeType}');
      }),
    );
    
    // Only register simple names for top-level enums (not nested ones) to avoid conflicts
    // Nested enums like TestAllTypes.NestedEnum should only be accessible via qualified names
    if (functionName != simpleName && !functionName.contains('.')) {
      overloads.add(
        Overload(simpleName, functionOperator: (args) {
          if (args.isEmpty || args.length > 1) {
            return ErrorValue('$simpleName constructor requires exactly 1 argument');
          }
          
          final arg = args[0];
          
          // Handle int argument
          if (arg is IntValue) {
            final namespace = globalEnumRegistry.getEnumNamespace(enumTypeName);
            if (namespace != null) {
              final currentMode = globalEnumRegistry.isGlobalLegacyMode;
              return EnumNamespace(namespace.enumTypeName, namespace.constants,
                                  isLegacyMode: currentMode)
                  .resolveConstantByValue(arg.value) ?? 
                  EnumValue.createStrong(enumTypeName, arg.value);
            }
          }
          
          // Handle string argument
          if (arg is StringValue) {
            final namespace = globalEnumRegistry.getEnumNamespace(enumTypeName);
            if (namespace != null) {
              return namespace.resolveConstant(arg.value) ?? 
                     ErrorValue('invalid enum constant: ${arg.value} for $simpleName');
            }
          }
          
          return ErrorValue('$simpleName constructor requires int or string argument, got ${arg.runtimeType}');
        }),
      );
    }
  }
  
  return overloads;
}