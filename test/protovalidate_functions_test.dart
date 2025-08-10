// Test file demonstrating implementation of protovalidate validation functions
// using the exported CEL APIs
import 'package:test/test.dart';
import 'package:cel/cel.dart';

/// Example implementation of protovalidate validation functions using the exported CEL APIs
class ProtovalidateLibrary extends Library {
  @override
  List<ProgramOption> get programOptions => [
    functions(_createValidationOverloads()),
  ];

  @override
  List<EnvironmentOption> get compileEnvironmentOptions => [];

  List<Overload> _createValidationOverloads() {
    return [
      // String validation functions
      Overload('isEmail', unaryOperator: (value) {
        if (value is StringValue) {
          return BooleanValue(_isValidEmail(value.value));
        }
        return BooleanValue(false);
      }),
      
      Overload('isHostname', unaryOperator: (value) {
        if (value is StringValue) {
          return BooleanValue(_isValidHostname(value.value));
        }
        return BooleanValue(false);
      }),
      
      Overload('isIp', unaryOperator: (value) {
        if (value is StringValue) {
          return BooleanValue(_isValidIp(value.value));
        }
        return BooleanValue(false);
      }),
      
      Overload('isIpv4', unaryOperator: (value) {
        if (value is StringValue) {
          return BooleanValue(_isValidIpv4(value.value));
        }
        return BooleanValue(false);
      }),
      
      Overload('isIpv6', unaryOperator: (value) {
        if (value is StringValue) {
          return BooleanValue(_isValidIpv6(value.value));
        }
        return BooleanValue(false);
      }),
      
      Overload('isUri', unaryOperator: (value) {
        if (value is StringValue) {
          return BooleanValue(_isValidUri(value.value));
        }
        return BooleanValue(false);
      }),
      
      Overload('isUuid', unaryOperator: (value) {
        if (value is StringValue) {
          return BooleanValue(_isValidUuid(value.value));
        }
        return BooleanValue(false);
      }),
      
      // List functions
      Overload('unique', unaryOperator: (value) {
        if (value is ListValue) {
          return BooleanValue(_isUnique(value.value));
        }
        return BooleanValue(false);
      }),
      
      // Numeric functions
      Overload('isNan', unaryOperator: (value) {
        if (value is DoubleValue) {
          return BooleanValue(value.value.isNaN);
        }
        return BooleanValue(false);
      }),
      
      Overload('isInf', unaryOperator: (value) {
        if (value is DoubleValue) {
          return BooleanValue(value.value.isInfinite);
        }
        return BooleanValue(false);
      }),
      
      // Binary version of isInf with sign parameter (different name to avoid overload conflict)
      Overload('isInfWithSign', binaryOperator: (value, sign) {
        if (value is DoubleValue && sign is IntValue) {
          final isInf = value.value.isInfinite;
          if (!isInf) return BooleanValue(false);
          
          final signValue = sign.value;
          if (signValue == 0) return BooleanValue(true); // Any infinity
          if (signValue > 0) return BooleanValue(value.value.isInfinite && value.value > 0);
          if (signValue < 0) return BooleanValue(value.value.isInfinite && value.value < 0);
        }
        return BooleanValue(false);
      }),
    ];
  }

  // String validation implementations (simplified for demonstration)
  bool _isValidEmail(String value) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(value);
  }

  bool _isValidHostname(String value) {
    if (value.isEmpty || value.length > 253) return false;
    final hostnameRegex = RegExp(r'^[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?(\.[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?)*$');
    return hostnameRegex.hasMatch(value);
  }

  bool _isValidIp(String value) {
    return _isValidIpv4(value) || _isValidIpv6(value);
  }

  bool _isValidIpv4(String value) {
    final parts = value.split('.');
    if (parts.length != 4) return false;
    
    for (final part in parts) {
      final num = int.tryParse(part);
      if (num == null || num < 0 || num > 255) return false;
      if (part.length > 1 && part.startsWith('0')) return false; // No leading zeros
    }
    return true;
  }

  bool _isValidIpv6(String value) {
    // Simplified IPv6 validation
    final ipv6Regex = RegExp(r'^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$|^::1$|^::$');
    return ipv6Regex.hasMatch(value);
  }

  bool _isValidUri(String value) {
    try {
      final uri = Uri.parse(value);
      return uri.hasScheme && uri.host.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  bool _isValidUuid(String value) {
    final uuidRegex = RegExp(r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$');
    return uuidRegex.hasMatch(value);
  }

  bool _isUnique(List<dynamic> list) {
    final seen = <dynamic>{};
    for (final item in list) {
      if (seen.contains(item)) {
        return false;
      }
      seen.add(item);
    }
    return true;
  }
}

void main() {
  group('Protovalidate Validation Functions', () {
    late Environment env;
    
    setUp(() {
      env = Environment.standard();
      final library = ProtovalidateLibrary();
      library.toEnvironmentOption()(env);
    });
    
    // Helper function to extract boolean value regardless of wrapping
    bool getBoolValue(dynamic result) {
      if (result is BooleanValue) {
        return result.value;
      }
      return result as bool;
    }
    
    test('isEmail function works correctly', () async {
      final ast = env.compile('isEmail("test@example.com")');
      final program = env.makeProgram(ast);
      final result = await program.evaluate({});
      
      expect(getBoolValue(result), isTrue);
    });
    
    test('isEmail rejects invalid emails', () async {
      final ast = env.compile('isEmail("invalid-email")');
      final program = env.makeProgram(ast);
      final result = await program.evaluate({});
      
      expect(getBoolValue(result), isFalse);
    });
    
    test('isIpv4 function works correctly', () async {
      final ast = env.compile('isIpv4("192.168.1.1")');
      final program = env.makeProgram(ast);
      final result = await program.evaluate({});
      
      expect(getBoolValue(result), isTrue);
    });
    
    test('isIpv4 rejects invalid IPs', () async {
      final ast = env.compile('isIpv4("256.1.1.1")');
      final program = env.makeProgram(ast);
      final result = await program.evaluate({});
      
      expect(getBoolValue(result), isFalse);
    });
    
    test('isUuid function works correctly', () async {
      final ast = env.compile('isUuid("550e8400-e29b-41d4-a716-446655440000")');
      final program = env.makeProgram(ast);
      final result = await program.evaluate({});
      
      expect(getBoolValue(result), isTrue);
    });
    
    test('unique function works with unique lists', () async {
      final ast = env.compile('unique([1, 2, 3, 4])');
      final program = env.makeProgram(ast);
      final result = await program.evaluate({});
      
      expect(getBoolValue(result), isTrue);
    });
    
    test('unique function works with non-unique lists', () async {
      final ast = env.compile('unique([1, 2, 2, 3])');
      final program = env.makeProgram(ast);
      final result = await program.evaluate({});
      
      expect(getBoolValue(result), isFalse);
    });
    
    test('isNan function works correctly', () async {
      // Note: NaN literal might not parse directly, so we test with a variable
      final ast = env.compile('isNan(nanValue)');
      final program = env.makeProgram(ast);
      final result = await program.evaluate({'nanValue': DoubleValue(double.nan)});
      
      expect(getBoolValue(result), isTrue);
    });
    
    test('isInf function works correctly', () async {
      final ast = env.compile('isInf(infValue)');
      final program = env.makeProgram(ast);
      final result = await program.evaluate({'infValue': DoubleValue(double.infinity)});
      
      expect(getBoolValue(result), isTrue);
    });
    
    test('isHostname function works correctly', () async {
      final ast = env.compile('isHostname("example.com")');
      final program = env.makeProgram(ast);
      final result = await program.evaluate({});
      
      expect(getBoolValue(result), isTrue);
    });
    
    test('can combine validation functions in complex expressions', () async {
      final ast = env.compile('isEmail("user@example.com") && isHostname("example.com")');
      final program = env.makeProgram(ast);
      final result = await program.evaluate({});
      
      expect(getBoolValue(result), isTrue);
    });
  });
}