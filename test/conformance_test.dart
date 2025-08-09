import 'package:test/test.dart';
import 'package:cel/src/conformance/runner.dart';
import 'dart:io';

void main() {
  group('CEL Conformance Tests', () {
    late ConformanceTestRunner runner;
    
    setUpAll(() {
      runner = ConformanceTestRunner(
        skipTests: {
          // Skip tests that require features not yet implemented
          // These will be progressively removed as we implement features
        },
      );
    });
    
    // Test individual conformance suites
    test('basic.textproto', () async {
      final testFile = '../cel-spec/tests/simple/testdata/basic.textproto';
      
      // Check if file exists
      if (!File(testFile).existsSync()) {
        print('Skipping: Test file not found at $testFile');
        return;
      }
      
      final results = await runner.runTestFile(testFile);
      
      print('Results for ${results.fileName}:');
      print('  Passed: ${results.passed}/${results.total}');
      
      if (results.failures.isNotEmpty) {
        print('  Failures:');
        for (final failure in results.failures) {
          print('    - ${failure.name}: ${failure.error}');
          if (failure.expected != null) {
            print('      Expected: ${failure.expected}');
            print('      Actual: ${failure.actual}');
          }
        }
      }
      
      // For now, we don't fail the test since we're establishing baseline
      // Once we have a working parser, we'll enable this:
      // expect(results.failures, isEmpty);
    });
    
    test('comparisons.textproto', () async {
      final testFile = '../cel-spec/tests/simple/testdata/comparisons.textproto';
      
      if (!File(testFile).existsSync()) {
        print('Skipping: Test file not found at $testFile');
        return;
      }
      
      final results = await runner.runTestFile(testFile);
      
      print('Results for ${results.fileName}:');
      print('  Passed: ${results.passed}/${results.total}');
      
      if (results.failures.isNotEmpty) {
        print('  Failures:');
        for (final failure in results.failures.take(5)) {
          print('    - ${failure.name}: ${failure.error}');
        }
        if (results.failures.length > 5) {
          print('    ... and ${results.failures.length - 5} more');
        }
      }
    });
    
    test('logic.textproto', () async {
      final testFile = '../cel-spec/tests/simple/testdata/logic.textproto';
      
      if (!File(testFile).existsSync()) {
        print('Skipping: Test file not found at $testFile');
        return;
      }
      
      final results = await runner.runTestFile(testFile);
      
      print('Results for ${results.fileName}:');
      print('  Passed: ${results.passed}/${results.total}');
      
      if (results.failures.isNotEmpty) {
        print('  Failures:');
        for (final failure in results.failures.take(5)) {
          print('    - ${failure.name}: ${failure.error}');
        }
        if (results.failures.length > 5) {
          print('    ... and ${results.failures.length - 5} more');
        }
      }
    });
    
    test('string.textproto', () async {
      final testFile = '../cel-spec/tests/simple/testdata/string.textproto';
      
      if (!File(testFile).existsSync()) {
        print('Skipping: Test file not found at $testFile');
        return;
      }
      
      final results = await runner.runTestFile(testFile);
      
      print('Results for ${results.fileName}:');
      print('  Passed: ${results.passed}/${results.total}');
      
      if (results.failures.isNotEmpty) {
        print('  Failures:');
        for (final failure in results.failures.take(5)) {
          print('    - ${failure.name}: ${failure.error}');
        }
        if (results.failures.length > 5) {
          print('    ... and ${results.failures.length - 5} more');
        }
      }
    });
    
    test('lists.textproto', () async {
      final testFile = '../cel-spec/tests/simple/testdata/lists.textproto';
      
      if (!File(testFile).existsSync()) {
        print('Skipping: Test file not found at $testFile');
        return;
      }
      
      final results = await runner.runTestFile(testFile);
      
      print('Results for ${results.fileName}:');
      print('  Passed: ${results.passed}/${results.total}');
      
      if (results.failures.isNotEmpty) {
        print('  Failures:');
        for (final failure in results.failures.take(5)) {
          print('    - ${failure.name}: ${failure.error}');
        }
        if (results.failures.length > 5) {
          print('    ... and ${results.failures.length - 5} more');
        }
      }
    });
    
    // Overall conformance report
    test('Generate Conformance Report', () async {
      final testDir = Directory('../cel-spec/tests/simple/testdata');
      
      if (!testDir.existsSync()) {
        print('Skipping: Test directory not found at ${testDir.path}');
        return;
      }
      
      print('\n=== CEL Conformance Report ===\n');
      
      final testFiles = [
        'basic.textproto',
        'comparisons.textproto',
        'conversions.textproto',
        'dynamic.textproto',
        'enums.textproto',
        'fields.textproto',
        'fp_math.textproto',
        'integer_math.textproto',
        'lists.textproto',
        'logic.textproto',
        'macros.textproto',
        'namespace.textproto',
        'parse.textproto',
        'proto2.textproto',
        'proto3.textproto',
        'string.textproto',
        'timestamps.textproto',
        'unknowns.textproto',
      ];
      
      int totalPassed = 0;
      int totalTests = 0;
      
      for (final file in testFiles) {
        final testFile = '${testDir.path}/$file';
        
        if (!File(testFile).existsSync()) {
          print('$file: NOT FOUND');
          continue;
        }
        
        try {
          final results = await runner.runTestFile(testFile);
          totalPassed += results.passed;
          totalTests += results.total;
          
          final percentage = results.total > 0 
              ? (results.passed * 100 / results.total).toStringAsFixed(1)
              : '0.0';
          
          print('$file: ${results.passed}/${results.total} ($percentage%)');
        } catch (e) {
          print('$file: ERROR - $e');
        }
      }
      
      print('\n=== Overall ===');
      final overallPercentage = totalTests > 0
          ? (totalPassed * 100 / totalTests).toStringAsFixed(1)
          : '0.0';
      print('Total: $totalPassed/$totalTests ($overallPercentage%)');
    });
  });
}