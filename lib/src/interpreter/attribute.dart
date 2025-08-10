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
    ResolutionError? lastError;
    for (final attribute in namespaceAttributes) {
      try {
        return attribute.resolve(activation);
      } on ResolutionError catch (e) {
        lastError = e;
        // If it's a missing attribute error, try the next candidate
        if (e.isMissingAttribute()) {
          continue;
        }
        // For missing key/index errors, propagate them immediately
        rethrow;
      }
    }
    // If we exhausted all candidates, throw the last error or a generic one
    throw lastError ?? ResolutionError.missingAttribute(namespaceAttributes.first.toString());
  }

  @override
  List<Object?> get props => [namespaceAttributes];
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
    if (object == null && activation is EvalActivation && 
        !activation.input.containsKey(namespaceName)) {
      // Variable is truly unbound, not just null
      throw ResolutionError.missingAttribute(namespaceName);
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
    if (object == null) {
      throw ResolutionError.missingKey(StringValue(value));
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
        throw ResolutionError.missingKey(key);
      }
    }
    
    // Handle CEL MapValue
    if (object is MapValue) {
      final key = StringValue(value);
      if (!object.value.containsKey(key)) {
        throw ResolutionError.missingKey(key);
      }
      return object.get(key);
    }
    
    // Handle CEL MessageValue
    if (object is MessageValue) {
      final key = StringValue(value);
      try {
        return object.get(key);
      } catch (e) {
        throw ResolutionError.missingKey(key);
      }
    }
    
    // Handle plain Dart maps
    if (object is Map) {
      if (!object.containsKey(value)) {
        throw ResolutionError.missingKey(StringValue(value));
      }
      return object[value];
    }
    
    // Try indexed access for other types
    try {
      return object[value];
    } catch (_) {
      throw ResolutionError.missingKey(StringValue(value));
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
      throw ResolutionError.missingIndex(index);
    }
    
    // Get the numeric value from the index
    int? indexValue;
    if (index is IntValue) {
      indexValue = (index as IntValue).value;
    } else if (index is UintValue) {
      indexValue = (index as UintValue).value.toInt();
    } else {
      throw InvalidKeyTypeError(index.runtimeType);
    }
    
    // Handle CEL ListValue
    if (object is ListValue) {
      final list = object.value;
      if (indexValue < 0 || indexValue >= list.length) {
        throw ResolutionError.missingIndex(index);
      }
      return list[indexValue];
    }
    
    // Handle Dart lists
    if (object is List) {
      if (indexValue < 0 || indexValue >= object.length) {
        throw ResolutionError.missingIndex(index);
      }
      return object[indexValue];
    }
    
    // Handle maps with integer keys
    if (object is MapValue) {
      if (!object.value.containsKey(index)) {
        throw ResolutionError.missingKey(index);
      }
      return object.get(index);
    }
    
    if (object is Map) {
      if (!object.containsKey(indexValue)) {
        throw ResolutionError.missingKey(index);
      }
      return object[indexValue];
    }
    
    throw StateError('Cannot index ${object.runtimeType} with integer');
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
      throw ResolutionError.missingKey(value);
    }
    
    // Maps with double keys are valid in CEL for dynamic data
    if (object is MapValue) {
      if (!object.value.containsKey(value)) {
        throw ResolutionError.missingKey(value);
      }
      return object.get(value);
    }
    
    // For regular Dart maps, convert to appropriate key type
    if (object is Map) {
      final doubleKey = value.value;
      if (!object.containsKey(doubleKey)) {
        throw ResolutionError.missingKey(value);
      }
      return object[doubleKey];
    }
    
    throw InvalidKeyTypeError(value.runtimeType);
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
      throw StateError('Cannot access field $fieldName on ${object.runtimeType}');
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
    // Note: used a shortcut. Used the raw value instead of BooleanValue.
    // Note: cel-go uses expression.resolve. Perhaps some optimization to not
    // evaluate everything?
    return condition.evaluate(activation).value
        ? truthy.evaluate(activation)
        : falsy.evaluate(activation);
  }

  @override
  List<Object?> get props => [condition, truthy, falsy];
}
