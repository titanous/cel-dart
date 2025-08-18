import 'package:equatable/equatable.dart';
import 'package:cel/src/gen/google/protobuf/wrappers.pb.dart' as pb_wrappers;
import 'package:protobuf/protobuf.dart';
import '../common/types/ref/provider.dart';
import '../common/types/type.dart';
import '../common/types/enum.dart';
import '../common/containers/container.dart';

abstract class Activation extends Equatable {
  dynamic resolveName(dynamic namespaceName);

  // Create a new activation with an additional variable binding
  Activation extend(String name, dynamic value) {
    return VarActivation(name, value, this);
  }

  @override
  bool? get stringify => true;
}

class EvalActivation extends Activation {
  EvalActivation(this.input, {this.typeAdapter, this.container});

  final Map<String, dynamic> input;
  final TypeAdapter? typeAdapter;
  final Container? container;

  @override
  dynamic resolveName(dynamic namespaceName) {
    // Check for built-in type denotations first
    if (namespaceName is String) {
      switch (namespaceName) {
        case 'bool':
          return TypeValue('bool');
        case 'int':
          return TypeValue('int');
        case 'uint':
          return TypeValue('uint');
        case 'double':
          return TypeValue('double');
        case 'string':
          return TypeValue('string');
        case 'bytes':
          return TypeValue('bytes');
        case 'list':
          return TypeValue('list');
        case 'map':
          return TypeValue('map');
        case 'type':
          return TypeValue('type');
        case 'null_type':
          return TypeValue('null_type');
      }
      
      // Check for enum type namespaces
      final enumNamespace = _resolveEnumNamespace(namespaceName);
      if (enumNamespace != null) {
        return enumNamespace;
      }

      // Use container namespace resolution if container is provided
      if (container != null) {
        final candidates = container!.resolveCandidateNames(namespaceName);
        for (final candidate in candidates) {
          if (input.containsKey(candidate)) {
            final value = input[candidate];
            return _processValue(value);
          }
        }
        // If no candidates found in input, return null
        return null;
      }
    }
    
    // Get the value from input (fallback for when no container is set)
    final value = input[namespaceName];
    return _processValue(value);
  }

  /// Process a value from the input, handling wrapper types and enums
  dynamic _processValue(dynamic value) {
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

    // Handle protobuf enums - convert to integer values
    if (value is ProtobufEnum) {
      return value.value;
    }

    // Return the value as-is for non-wrapper types
    // Return null for unbound variables instead of throwing
    // This allows the attribute resolution to handle it properly
    return value;
  }

  /// Resolve enum namespace by name using the global enum registry
  /// This handles enum types like GlobalEnum, TestAllTypes.NestedEnum
  EnumNamespace? _resolveEnumNamespace(String namespaceName) {
    // Ensure the global enum registry is initialized
    if (globalEnumRegistry.registeredTypes.isEmpty) {
      globalEnumRegistry.discoverAndRegisterProtobufEnums();
    }
    
    // Use the enum registry to resolve the namespace
    return globalEnumRegistry.resolveEnumNamespace(namespaceName, container?.name);
  }

  @override
  List<Object?> get props => [input, typeAdapter, container];
}

// VarActivation extends the parent activation with a single variable binding
class VarActivation extends Activation {
  VarActivation(this.name, this.value, this.parent);

  final String name;
  final dynamic value;
  final Activation parent;

  @override
  dynamic resolveName(dynamic namespaceName) {
    if (namespaceName == name) {
      return value;
    }
    return parent.resolveName(namespaceName);
  }

  @override
  List<Object?> get props => [name, value, parent];
}
