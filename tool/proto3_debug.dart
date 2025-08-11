#!/usr/bin/env dart

import 'dart:io';
import '../lib/src/conformance/runner.dart';

Future<void> main() async {
  final runner = ConformanceTestRunner();
  
  // Run proto3 tests specifically
  final testFile = 'test/testdata/proto3.json';
  
  if (!File(testFile).existsSync()) {
    print('Test file not found: $testFile');
    exit(1);
  }
  
  print('Running proto3 conformance tests with detailed failure information...\n');
  
  final results = await runner.runTestFile(testFile);
  
  print('Proto3 Test Results: ${results.passed}/${results.total} (${(results.passed * 100 / results.total).toStringAsFixed(1)}%)');
  print('');
  
  // Show which tests are passing now
  final passingTests = results.results.where((r) => r.passed).map((r) => r.name).toList();
  if (passingTests.isNotEmpty) {
    print('PASSING TESTS (${passingTests.length}):');
    for (final name in passingTests) {
      print('  ✅ $name');
    }
    print('');
  }
  
  if (results.failures.isNotEmpty) {
    print('FAILURES (${results.failures.length}):');
    print('=' * 50);
    
    for (int i = 0; i < results.failures.length; i++) {
      final failure = results.failures[i];
      print('${i + 1}. ${failure.name}');
      if (failure.error != null) {
        print('   Error: ${failure.error}');
      }
      if (failure.expected != null) {
        print('   Expected: ${failure.expected}');
      }
      if (failure.actual != null) {
        print('   Actual: ${failure.actual}');
      }
      print('');
    }
  } else {
    print('All tests passed! 🎉');
  }
}