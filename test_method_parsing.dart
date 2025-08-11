import 'package:cel/src/parser/parser.dart';
import 'package:cel/src/cel/expr.dart';

void main() {
  final parser = Parser();
  
  print('=== Testing method calls parsing ===\n');
  
  // Test 1: String literal with method call (should work)
  print('Test 1: String literal method call');
  print('Expression: "hello".format(["world"])');
  try {
    final expr1 = parser.parse('"hello".format(["world"])');
    if (expr1 is CallExpr) {
      print('✓ Parsed as CallExpr');
      print('  Function: ${expr1.function}');
      print('  Target: ${expr1.target.runtimeType} - ${expr1.target}');
      print('  Args count: ${expr1.args.length}');
    } else {
      print('✗ Not parsed as CallExpr, got: ${expr1.runtimeType}');
    }
  } catch (e) {
    print('✗ Error parsing: $e');
  }
  
  print('\n---\n');
  
  // Test 2: Variable with method call (the problem case)
  print('Test 2: Variable method call');
  print('Expression: str_var.format(["world"])');
  try {
    final expr2 = parser.parse('str_var.format(["world"])');
    if (expr2 is CallExpr) {
      print('✓ Parsed as CallExpr');
      print('  Function: ${expr2.function}');
      print('  Target: ${expr2.target?.runtimeType} - ${expr2.target}');
      print('  Args count: ${expr2.args.length}');
    } else {
      print('✗ Not parsed as CallExpr, got: ${expr2.runtimeType}');
    }
  } catch (e) {
    print('✗ Error parsing: $e');
  }
  
  print('\n---\n');
  
  // Test 3: Namespace function call (should work as expected)
  print('Test 3: Namespace function call');
  print('Expression: strings.quote("hello")');
  try {
    final expr3 = parser.parse('strings.quote("hello")');
    if (expr3 is CallExpr) {
      print('✓ Parsed as CallExpr');
      print('  Function: ${expr3.function}');
      print('  Target: ${expr3.target?.runtimeType} - ${expr3.target}');
      print('  Args count: ${expr3.args.length}');
    } else {
      print('✗ Not parsed as CallExpr, got: ${expr3.runtimeType}');
    }
  } catch (e) {
    print('✗ Error parsing: $e');
  }
}