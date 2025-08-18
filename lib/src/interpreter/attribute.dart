import 'package:cel/src/interpreter/activation.dart';
import 'package:cel/src/interpreter/interpretable.dart';
import 'package:cel/src/interpreter/errors.dart';
import 'package:equatable/equatable.dart';
import 'package:protobuf/protobuf.dart';
import '../common/types/ref/value.dart';
import '../common/types/ref/provider.dart';
import '../common/types/pb/adapter.dart';
import '../common/types/pb/message.dart';
import '../common/types/provider.dart' as cel_provider;
import '../common/types/map.dart';
import '../common/types/list.dart';
import '../common/types/string.dart';
import '../common/types/int.dart';
import '../common/types/double.dart';
import '../common/types/uint.dart';
import '../common/types/error.dart';
import '../common/types/bool.dart';
import '../common/types/enum.dart';

abstract class Attribute extends Equatable {
  dynamic resolve(Activation activation);
  void addQualifier(Qualifier qualifier);

  @override
  bool? get stringify => true;
}

class MaybeAttribute extends Attribute {
  MaybeAttribute(this.namespaceAttributes);

  final List<NamespaceAttribute> namespaceAttributes;

  // Very simplified compared to https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/attributes.go#L451.
  @override
  void addQualifier(Qualifier qualifier) {
    for (final attribute in namespaceAttributes) {
      attribute.addQualifier(qualifier);
    }
  }

  // https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/attributes.go#L490
  @override
  resolve(Activation activation) {
    dynamic lastResult;
    for (final attribute in namespaceAttributes) {
      final result = attribute.resolve(activation);
      // If we got a non-error value, return it
      if (result is! ErrorValue) {
        return result;
      }
      // Save the error and try the next namespace
      lastResult = result;
      // Check if it's a missing attribute error (try next namespace)
      if (result.message.startsWith('no such attribute:')) {
        continue;
      }
      // For other errors (missing key/index), return immediately
      return result;
    }
    // If we exhausted all candidates, return the last error or a generic one
    return lastResult ??
        ErrorValue('no such attribute: ${namespaceAttributes.first}');
  }

  @override
  List<Object?> get props => [namespaceAttributes];
}

class HybridAttribute extends Attribute {
  HybridAttribute(this.primaryAttribute, this.fallbackAttribute);

  final Attribute primaryAttribute;
  final Attribute fallbackAttribute;

  @override
  void addQualifier(Qualifier qualifier) {
    primaryAttribute.addQualifier(qualifier);
    fallbackAttribute.addQualifier(qualifier);
  }

  @override
  resolve(Activation activation) {
    final primaryResult = primaryAttribute.resolve(activation);
    // If primary resolution succeeded, return it
    if (primaryResult is! ErrorValue) {
      return primaryResult;
    }
    // If primary failed with "no such attribute", try fallback
    if (primaryResult.message.startsWith('no such attribute:')) {
      return fallbackAttribute.resolve(activation);
    }
    // For other errors, return the primary error
    return primaryResult;
  }

  @override
  List<Object?> get props => [primaryAttribute, fallbackAttribute];
}

abstract class NamespaceAttribute extends Attribute {}

class AbsoluteAttribute extends NamespaceAttribute {
  AbsoluteAttribute(this.namespaceName);

  final String namespaceName;
  final List<Qualifier> qualifiers = [];

  // See https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/attributes.go#L294.
  @override
  resolve(Activation activation) {
    // https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/attributes.go#L300
    final object = activation.resolveName(namespaceName);
    if (object == null &&
        activation is EvalActivation &&
        !activation.input.containsKey(namespaceName)) {
      // Variable is truly unbound, not just null
      return ErrorValue('no such attribute: $namespaceName');
    }
    return applyQualifiers(activation, object, qualifiers);
  }

  @override
  void addQualifier(Qualifier qualifier) {
    qualifiers.add(qualifier);
  }

  dynamic applyQualifiers(
      Activation activation, object, List<Qualifier> qualifiers) {
    var result = object;
    for (final qualifier in qualifiers) {
      result = qualifier.qualify(activation, result);
    }
    return result;
  }

  @override
  List<Object?> get props => [namespaceName, qualifiers];
}

class RelativeAttribute extends Attribute {
  RelativeAttribute(this.operand);

  final Interpretable operand;
  final List<Qualifier> qualifiers = [];

  // https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/attributes.go#L570
  @override
  resolve(Activation activation) {
    var value = operand.evaluate(activation);

    // Apply all qualifiers to the value
    for (final qualifier in qualifiers) {
      value = qualifier.qualify(activation, value);
    }

    return value;
  }

  @override
  void addQualifier(Qualifier qualifier) {
    qualifiers.add(qualifier);
  }

  @override
  List<Object?> get props => [operand, qualifiers];
}

abstract class Qualifier extends Equatable {
  qualify(Activation activation, object);

  @override
  bool? get stringify => true;
}

class StringQualifier extends Qualifier {
  StringQualifier(this.value);

  final String value;

  @override
  qualify(Activation activation, object) {
    // Return error for null object
    if (object == null) {
      return ErrorValue('no such key: ${StringValue(value)}');
    }

    // Handle errors passed through
    if (object is ErrorValue) {
      return object;
    }

    // Handle enum namespace resolution (e.g., GlobalEnum.GAZ)
    if (object is EnumNamespace) {
      final enumConstant = object.resolveConstant(value);
      if (enumConstant == null) {
        return ErrorValue('no such enum constant: $value in ${object.enumTypeName}');
      }
      return enumConstant;
    }

    // Handle raw protobuf messages - wrap them in MessageValue
    if (object is GeneratedMessage) {
      // Get the TypeRegistry from the activation if available
      TypeAdapter? typeAdapter;
      if (activation is EvalActivation) {
        // Try to get the TypeRegistry if it's stored in a special key
        // For now, we'll use the default TypeRegistry
        typeAdapter = cel_provider.TypeRegistry();
      }
      final messageValue = MessageValue(object, typeAdapter);
      final key = StringValue(value);
      try {
        return messageValue.get(key);
      } catch (e) {
        return ErrorValue('no such key: $key');
      }
    }

    // Handle CEL MapValue
    if (object is MapValue) {
      final key = StringValue(value);
      try {
        return object.get(key);
      } catch (e) {
        return ErrorValue('no such key: $key');
      }
    }

    // Handle CEL MessageValue
    if (object is MessageValue) {
      final key = StringValue(value);
      try {
        return object.get(key);
      } catch (e) {
        return ErrorValue('no such key: $key');
      }
    }

    // Handle plain Dart maps
    if (object is Map) {
      if (!object.containsKey(value)) {
        return ErrorValue('no such key: ${StringValue(value)}');
      }
      // Convert Dart value to CEL Value using TypeAdapter
      // Get a default TypeAdapter if one isn't available
      final adapter =
          (activation is EvalActivation && activation.typeAdapter != null)
              ? activation.typeAdapter!
              : cel_provider.TypeRegistry();
      final rawValue = object[value];
      final result = adapter.nativeToValue(rawValue);
      return result;
    }

    // Handle primitive types that don't support field selection
    if (object is int ||
        object is double ||
        object is String ||
        object is bool ||
        object is List) {
      final typeName = object.runtimeType.toString().toLowerCase();
      return ErrorValue("type '$typeName' does not support field selection");
    }

    // Handle CEL Value types that don't support field selection
    if (object is IntValue ||
        object is UintValue ||
        object is DoubleValue ||
        object is StringValue ||
        object is BooleanValue ||
        object is ListValue) {
      final typeName = object.type.name + '_type';
      return ErrorValue("type '$typeName' does not support field selection");
    }

    // Try indexed access for other types
    try {
      return object[value];
    } catch (_) {
      return ErrorValue('no such key: ${StringValue(value)}');
    }
  }

  @override
  List<Object?> get props => [value];
}

class IndexQualifier extends Qualifier {
  IndexQualifier(this.index);

  final Value index;

  @override
  qualify(Activation activation, object) {
    if (object == null) {
      return ErrorValue('index out of bounds: $index');
    }

    // Handle errors passed through
    if (object is ErrorValue) {
      return object;
    }

    // Get the numeric value from the index
    int? indexValue;
    if (index is IntValue) {
      indexValue = (index as IntValue).value;
    } else if (index is UintValue) {
      indexValue = (index as UintValue).value.toInt();
    } else {
      return ErrorValue('invalid index type: ${index.runtimeType}');
    }

    // Handle CEL ListValue
    if (object is ListValue) {
      final list = object.value;
      if (indexValue < 0 || indexValue >= list.length) {
        return ErrorValue('index out of bounds: $index');
      }
      return list[indexValue];
    }

    // Handle Dart lists
    if (object is List) {
      if (indexValue < 0 || indexValue >= object.length) {
        return ErrorValue('index out of bounds: $index');
      }
      return object[indexValue];
    }

    // Handle maps with integer keys
    if (object is MapValue) {
      if (!object.value.containsKey(index)) {
        return ErrorValue('no such key: $index');
      }
      return object.get(index);
    }

    if (object is Map) {
      if (!object.containsKey(indexValue)) {
        return ErrorValue('no such key: $index');
      }
      return object[indexValue];
    }

    return ErrorValue('Cannot index ${object.runtimeType} with integer');
  }

  @override
  List<Object?> get props => [index];
}

class DoubleQualifier extends Qualifier {
  DoubleQualifier(this.value);

  final DoubleValue value;

  @override
  qualify(Activation activation, object) {
    if (object == null) {
      return ErrorValue('no such key: $value');
    }

    // Handle errors passed through
    if (object is ErrorValue) {
      return object;
    }

    // Maps with double keys are valid in CEL for dynamic data
    if (object is MapValue) {
      if (!object.value.containsKey(value)) {
        return ErrorValue('no such key: $value');
      }
      return object.get(value);
    }

    // For regular Dart maps, convert to appropriate key type
    if (object is Map) {
      final doubleKey = value.value;
      if (!object.containsKey(doubleKey)) {
        return ErrorValue('no such key: $value');
      }
      return object[doubleKey];
    }

    return ErrorValue('type does not support indexing: ${object.runtimeType}');
  }

  @override
  List<Object?> get props => [value];
}

class ProtobufFieldQualifier extends Qualifier {
  ProtobufFieldQualifier(this.fieldName);

  final String fieldName;

  @override
  qualify(Activation activation, object) {
    if (object == null) {
      throw NoSuchFieldError(fieldName, Null);
    }

    // Handle CEL MessageValue (protobuf messages wrapped in CEL)
    if (object is MessageValue) {
      return object.get(StringValue(fieldName));
    }

    // Handle CEL MapValue
    if (object is MapValue) {
      return object.get(StringValue(fieldName));
    }

    // Handle CEL ListValue (for index access, fieldName would be a number string)
    if (object is ListValue) {
      final index = int.tryParse(fieldName);
      if (index != null) {
        return object.get(IntValue(index));
      }
    }

    if (object is Value) {
      // If it's already a CEL value, get the underlying protobuf message
      final value = object.value;
      if (value is GeneratedMessage) {
        return _getFieldFromMessage(value);
      }
    } else if (object is GeneratedMessage) {
      // Direct protobuf message
      return _getFieldFromMessage(object);
    }

    // Fall back to map-style access for non-protobuf objects
    try {
      return object[fieldName];
    } catch (_) {
      return ErrorValue(
          'Cannot access field $fieldName on ${object.runtimeType}');
    }
  }

  Value _getFieldFromMessage(GeneratedMessage msg) {
    // We need the ProtobufTypeAdapter to convert the field value
    // For now, use the default CEL type registry
    final adapter = ProtobufTypeAdapter(cel_provider.TypeRegistry());
    return adapter.getField(msg, fieldName);
  }

  @override
  List<Object?> get props => [fieldName];
}

// Qualifier for presence testing (has() macro)
class PresenceTestQualifier extends Qualifier {
  PresenceTestQualifier(this.fieldName);

  final String fieldName;

  @override
  qualify(Activation activation, object) {
    if (object == null) {
      return BooleanValue(false);
    }

    // Handle ErrorValue - field is not present if accessing it produces an error
    if (object is ErrorValue) {
      return BooleanValue(false);
    }

    // Handle CEL MessageValue (protobuf messages wrapped in CEL)
    if (object is MessageValue) {
      return BooleanValue(object.has(fieldName));
    }

    // Handle CEL MapValue
    if (object is MapValue) {
      return object.contains(StringValue(fieldName));
    }

    // Handle CEL ListValue (for index access, fieldName would be a number string)
    if (object is ListValue) {
      final index = int.tryParse(fieldName);
      if (index != null) {
        return BooleanValue(index >= 0 && index < object.value.length);
      }
      return BooleanValue(false);
    }

    // Handle direct protobuf messages (most common case)
    if (object is GeneratedMessage) {
      return BooleanValue(_hasField(object));
    }

    if (object is Value) {
      // If it's already a CEL value, get the underlying protobuf message
      final value = object.value;
      if (value is GeneratedMessage) {
        return BooleanValue(_hasField(value));
      }
    }

    // For other types, check if the field exists
    try {
      if (object is Map) {
        return BooleanValue(object.containsKey(fieldName));
      }
      // For other objects, field is present if it's not null
      final value = object[fieldName];
      return BooleanValue(value != null);
    } catch (_) {
      return BooleanValue(false);
    }
  }

  bool _hasField(GeneratedMessage msg) {
    final info = msg.info_;
    try {
      // Try both snake_case and camelCase field names
      var field = info.byName[fieldName];
      if (field == null) {
        // Convert snake_case to camelCase
        final camelCase = _snakeToCamel(fieldName);
        field = info.byName[camelCase];
      }

      if (field == null) {
        return false;
      }

      return msg.hasField(field.tagNumber);
    } catch (_) {
      return false;
    }
  }

  String _snakeToCamel(String snake) {
    final parts = snake.split('_');
    if (parts.isEmpty) return snake;
    return parts[0] +
        parts
            .skip(1)
            .map((p) => p.isEmpty ? '' : p[0].toUpperCase() + p.substring(1))
            .join();
  }

  @override
  List<Object?> get props => [fieldName];
}

class ConditionalAttribute extends Attribute {
  ConditionalAttribute(
      {required this.condition, required this.truthy, required this.falsy});

  final Interpretable condition;
  final Interpretable truthy;
  final Interpretable falsy;

  @override
  void addQualifier(Qualifier qualifier) {
    // TODO: implement addQualifier
    throw UnimplementedError();
  }

  // https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/attributes.go#L376
  @override
  resolve(Activation activation) {
    // Evaluate the condition
    final condValue = condition.evaluate(activation);

    // If condition is an error, return the error
    if (condValue is ErrorValue) {
      return condValue;
    }

    // If condition is not a boolean, return error
    if (condValue is! BooleanValue) {
      return ErrorValue('no matching overload');
    }

    // Use the boolean value to decide which branch to evaluate
    return condValue.value
        ? truthy.evaluate(activation)
        : falsy.evaluate(activation);
  }

  @override
  List<Object?> get props => [condition, truthy, falsy];
}
