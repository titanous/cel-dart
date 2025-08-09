import 'package:cel/src/interpreter/activation.dart';
import 'package:cel/src/interpreter/interpretable.dart';
import 'package:equatable/equatable.dart';
import 'package:protobuf/protobuf.dart';
import '../common/types/ref/value.dart';
import '../common/types/pb/adapter.dart';
import '../common/types/provider.dart' as cel_provider;
import '../common/types/map.dart';
import '../common/types/list.dart';
import '../common/types/string.dart';
import '../common/types/int.dart';

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
    for (final attribute in namespaceAttributes) {
      try {
        return attribute.resolve(activation);
      } catch (_) {
        continue;
      }
    }
    throw Exception('Could not find ${toString()} in environment $activation.');
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
      throw Exception("Unbound variable: $namespaceName");
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

  Interpretable operand;

  // https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/attributes.go#L570
  @override
  resolve(Activation activation) {
    final value = operand.evaluate(activation);
    // TODO: support qualifiers.
    throw UnimplementedError();
  }

  @override
  void addQualifier(Qualifier qualifier) {
    // TODO: implement addQualifier
    throw UnimplementedError();
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
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
      throw StateError('Trying to read value of key $value on $object');
    }
    return object[value];
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
      throw StateError('Trying to read field $fieldName on null');
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
