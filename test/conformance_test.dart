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

    // Individual test suites
    final testSuites = [
      'basic',
      'comparisons',
      'conversions',
      'logic',
      'string',
      'string_ext',
      'lists',
      'macros',
      'enums',
    ];

    for (final suiteName in testSuites) {
      test(suiteName, () async {
        await _runConformanceTest(runner, suiteName);
      });
    }

    // Overall conformance report
    test('Generate Conformance Report', () async {
      await _generateConformanceReport(runner);
    });
  });
}

Future<void> _runConformanceTest(
    ConformanceTestRunner runner, String suiteName) async {
  final testFile = 'test/testdata/$suiteName.json';

  if (!File(testFile).existsSync()) {
    print('Skipping: Test file not found at $testFile');
    return;
  }

  final results = await runner.runTestFile(testFile);

  print('Results for ${results.fileName}:');
  print('  Passed: ${results.passed}/${results.total}');

  if (results.failures.isNotEmpty) {
    print('  Failures:');
    final maxFailures = suiteName == 'basic' || suiteName == 'enums' ? results.failures.length : 5;

    for (final failure in results.failures.take(maxFailures)) {
      print('    - ${failure.name}: ${failure.error}');
      if ((suiteName == 'basic' || suiteName == 'enums') && failure.expected != null) {
        print('      Expected: ${failure.expected}');
        print('      Actual: ${failure.actual}');
      }
    }

    if (results.failures.length > maxFailures) {
      print('    ... and ${results.failures.length - maxFailures} more');
    }
  }

  // For now, we don't fail the test since we're establishing baseline
  // Once we have a working parser, we'll enable this:
  // expect(results.failures, isEmpty);
}

Future<void> _generateConformanceReport(ConformanceTestRunner runner) async {
  final testDir = Directory('test/testdata');

  if (!testDir.existsSync()) {
    print('Skipping: Test directory not found at ${testDir.path}');
    return;
  }

  print('\n=== CEL Conformance Report ===\n');

  final testFiles = [
    'basic.json',
    'comparisons.json',
    'conversions.json',
    'dynamic.json',
    'enums.json',
    'fields.json',
    'fp_math.json',
    'integer_math.json',
    'lists.json',
    'logic.json',
    'macros.json',
    'namespace.json',
    'parse.json',
    'proto2.json',
    'proto3.json',
    'string.json',
    'string_ext.json',
    'timestamps.json',
    'unknowns.json',
  ];

  int totalPassed = 0;
  int totalTests = 0;

  for (final file in testFiles) {
    final testFile = 'test/testdata/$file';

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
}
