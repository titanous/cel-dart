#!/usr/bin/env dart

import 'dart:io';
import 'dart:convert';

/// Tool to capture and diff conformance test results
/// 
/// Usage:
///   dart tool/conformance_diff.dart snapshot [name]  - Save current test results
///   dart tool/conformance_diff.dart diff <from> <to> - Compare two snapshots
///   dart tool/conformance_diff.dart list             - List saved snapshots
///   dart tool/conformance_diff.dart show <name>      - Show snapshot details

void main(List<String> args) async {
  if (args.isEmpty) {
    printUsage();
    exit(1);
  }

  final command = args[0];
  final snapshotsDir = Directory('.conformance_snapshots');
  
  switch (command) {
    case 'snapshot':
      final name = args.length > 1 ? args[1] : DateTime.now().toIso8601String().replaceAll(':', '-');
      await captureSnapshot(snapshotsDir, name);
      break;
      
    case 'diff':
      if (args.length < 3) {
        print('Error: diff requires two snapshot names');
        printUsage();
        exit(1);
      }
      await diffSnapshots(snapshotsDir, args[1], args[2]);
      break;
      
    case 'list':
      await listSnapshots(snapshotsDir);
      break;
      
    case 'show':
      if (args.length < 2) {
        print('Error: show requires a snapshot name');
        printUsage();
        exit(1);
      }
      await showSnapshot(snapshotsDir, args[1]);
      break;
      
    default:
      print('Unknown command: $command');
      printUsage();
      exit(1);
  }
}

void printUsage() {
  print('''
Conformance Test Diff Tool

Usage:
  dart tool/conformance_diff.dart snapshot [name]  - Save current test results
  dart tool/conformance_diff.dart diff <from> <to> - Compare two snapshots  
  dart tool/conformance_diff.dart list             - List saved snapshots
  dart tool/conformance_diff.dart show <name>      - Show snapshot details
  
Examples:
  dart tool/conformance_diff.dart snapshot baseline
  dart tool/conformance_diff.dart snapshot after-field-selection
  dart tool/conformance_diff.dart diff baseline after-field-selection
''');
}

Future<void> captureSnapshot(Directory snapshotsDir, String name) async {
  print('Capturing conformance test snapshot: $name');
  
  // Create snapshots directory if it doesn't exist
  if (!await snapshotsDir.exists()) {
    await snapshotsDir.create();
  }
  
  // Run conformance tests with JSON reporter
  final result = await Process.run(
    'dart',
    ['test', 'test/conformance_test.dart', '--reporter', 'json'],
    runInShell: true,
  );
  
  // Parse the JSON output to extract test results
  final lines = result.stdout.toString().split('\n');
  final snapshot = ConformanceSnapshot(name: name, timestamp: DateTime.now());
  
  String? currentSuite;
  final testResults = <String, TestResult>{};
  final passedTests = <String>{};
  
  for (final line in lines) {
    if (line.trim().isEmpty) continue;
    
    try {
      final json = jsonDecode(line);
      
      if (json['type'] == 'print' && json['message'] != null) {
        final message = json['message'] as String;
        
        // Parse suite results
        if (message.startsWith('Results for test/testdata/')) {
          currentSuite = message.split('/').last.replaceAll(':', '');
        } else if (message.startsWith('  Passed:') && currentSuite != null) {
          // Track that this suite has some passed tests
          // We'll calculate which tests passed based on failed tests
        } else if (message.contains(' - ') && currentSuite != null && message.trim().startsWith('-')) {
          // Parse individual test failures
          final parts = message.trim().substring(2).split(':');
          if (parts.isNotEmpty) {
            final testName = parts[0].trim();
            final reason = parts.length > 1 ? parts.sublist(1).join(':').trim() : 'Failed';
            final key = '$currentSuite/$testName';
            testResults[key] = TestResult(
              suite: currentSuite,
              test: testName,
              passed: false,
              error: reason,
            );
          }
        } else if (message.contains('.json:')) {
          // Parse summary line like "basic.json: 40/43 (93.0%)"
          final match = RegExp(r'(\w+\.json): (\d+)/(\d+)').firstMatch(message);
          if (match != null) {
            final suite = match.group(1)!;
            final passed = int.parse(match.group(2)!);
            final total = int.parse(match.group(3)!);
            snapshot.suiteSummaries[suite] = SuiteSummary(
              suite: suite,
              passed: passed,
              total: total,
            );
          }
        } else if (message.startsWith('Total:')) {
          // Parse overall total
          final match = RegExp(r'Total: (\d+)/(\d+)').firstMatch(message);
          if (match != null) {
            snapshot.totalPassed = int.parse(match.group(1)!);
            snapshot.totalTests = int.parse(match.group(2)!);
          }
        }
      }
    } catch (e) {
      // Skip non-JSON lines
    }
  }
  
  snapshot.failedTests = testResults;
  
  // Save snapshot to file
  final file = File('${snapshotsDir.path}/$name.json');
  await file.writeAsString(jsonEncode(snapshot.toJson()));
  
  print('Snapshot saved: ${file.path}');
  print('Total: ${snapshot.totalPassed}/${snapshot.totalTests} tests passing');
  print('Failed tests: ${snapshot.failedTests.length}');
}

Future<void> diffSnapshots(Directory snapshotsDir, String from, String to) async {
  final fromFile = File('${snapshotsDir.path}/$from.json');
  final toFile = File('${snapshotsDir.path}/$to.json');
  
  if (!await fromFile.exists()) {
    print('Error: Snapshot "$from" not found');
    exit(1);
  }
  if (!await toFile.exists()) {
    print('Error: Snapshot "$to" not found');
    exit(1);
  }
  
  final fromSnapshot = ConformanceSnapshot.fromJson(jsonDecode(await fromFile.readAsString()));
  final toSnapshot = ConformanceSnapshot.fromJson(jsonDecode(await toFile.readAsString()));
  
  print('\n${'='*60}');
  print('Conformance Diff: $from → $to');
  print('='*60);
  
  // Overall summary
  final passedDiff = toSnapshot.totalPassed - fromSnapshot.totalPassed;
  final sign = passedDiff >= 0 ? '+' : '';
  print('\nOverall: ${fromSnapshot.totalPassed}/${fromSnapshot.totalTests} → ${toSnapshot.totalPassed}/${toSnapshot.totalTests} ($sign$passedDiff)');
  
  // Suite-by-suite comparison
  print('\nSuite Changes:');
  print('-'*40);
  
  final allSuites = {...fromSnapshot.suiteSummaries.keys, ...toSnapshot.suiteSummaries.keys}.toList()..sort();
  final suiteChanges = <String>[];
  
  for (final suite in allSuites) {
    final fromSuite = fromSnapshot.suiteSummaries[suite];
    final toSuite = toSnapshot.suiteSummaries[suite];
    
    if (fromSuite == null && toSuite != null) {
      suiteChanges.add('  [NEW] $suite: ${toSuite.passed}/${toSuite.total}');
    } else if (fromSuite != null && toSuite == null) {
      suiteChanges.add('  [REMOVED] $suite');
    } else if (fromSuite != null && toSuite != null && fromSuite.passed != toSuite.passed) {
      final diff = toSuite.passed - fromSuite.passed;
      final sign = diff >= 0 ? '+' : '';
      final symbol = diff > 0 ? '✅' : '❌';
      suiteChanges.add('  $symbol $suite: ${fromSuite.passed}/${fromSuite.total} → ${toSuite.passed}/${toSuite.total} ($sign$diff)');
    }
  }
  
  if (suiteChanges.isEmpty) {
    print('  No suite-level changes');
  } else {
    for (final change in suiteChanges) {
      print(change);
    }
  }
  
  // Newly passing tests
  final nowPassing = <String>[];
  for (final test in fromSnapshot.failedTests.keys) {
    if (!toSnapshot.failedTests.containsKey(test)) {
      nowPassing.add(test);
    }
  }
  
  if (nowPassing.isNotEmpty) {
    print('\n✅ Newly Passing Tests (${nowPassing.length}):');
    print('-'*40);
    for (final test in nowPassing..sort()) {
      final oldError = fromSnapshot.failedTests[test]!.error;
      print('  + $test');
      if (oldError.length < 100) {
        print('    (was: $oldError)');
      }
    }
  }
  
  // Newly failing tests
  final nowFailing = <String>[];
  for (final test in toSnapshot.failedTests.keys) {
    if (!fromSnapshot.failedTests.containsKey(test)) {
      nowFailing.add(test);
    }
  }
  
  if (nowFailing.isNotEmpty) {
    print('\n❌ Newly Failing Tests (${nowFailing.length}):');
    print('-'*40);
    for (final test in nowFailing..sort()) {
      final error = toSnapshot.failedTests[test]!.error;
      print('  - $test');
      if (error.length < 100) {
        print('    Error: $error');
      }
    }
  }
  
  // Changed errors
  final changedErrors = <String>[];
  for (final test in fromSnapshot.failedTests.keys) {
    if (toSnapshot.failedTests.containsKey(test)) {
      final fromError = fromSnapshot.failedTests[test]!.error;
      final toError = toSnapshot.failedTests[test]!.error;
      if (fromError != toError) {
        changedErrors.add(test);
      }
    }
  }
  
  if (changedErrors.isNotEmpty) {
    print('\n⚠️  Changed Error Messages (${changedErrors.length}):');
    print('-'*40);
    for (final test in changedErrors..sort()) {
      print('  ~ $test');
      final fromError = fromSnapshot.failedTests[test]!.error;
      final toError = toSnapshot.failedTests[test]!.error;
      if (fromError.length < 100 && toError.length < 100) {
        print('    Was: $fromError');
        print('    Now: $toError');
      }
    }
  }
  
  print('\n${'='*60}');
  print('Summary: $sign$passedDiff tests (${nowPassing.length} fixed, ${nowFailing.length} broken)');
  print('='*60);
}

Future<void> listSnapshots(Directory snapshotsDir) async {
  if (!await snapshotsDir.exists()) {
    print('No snapshots found');
    return;
  }
  
  final files = await snapshotsDir.list().where((e) => e.path.endsWith('.json')).toList();
  if (files.isEmpty) {
    print('No snapshots found');
    return;
  }
  
  print('Available snapshots:');
  print('-'*40);
  
  for (final file in files..sort((a, b) => a.path.compareTo(b.path))) {
    final name = file.path.split('/').last.replaceAll('.json', '');
    final content = jsonDecode(await File(file.path).readAsString());
    final snapshot = ConformanceSnapshot.fromJson(content);
    final percentage = (snapshot.totalPassed / snapshot.totalTests * 100).toStringAsFixed(1);
    print('  $name: ${snapshot.totalPassed}/${snapshot.totalTests} ($percentage%) - ${snapshot.timestamp}');
  }
}

Future<void> showSnapshot(Directory snapshotsDir, String name) async {
  final file = File('${snapshotsDir.path}/$name.json');
  if (!await file.exists()) {
    print('Error: Snapshot "$name" not found');
    exit(1);
  }
  
  final snapshot = ConformanceSnapshot.fromJson(jsonDecode(await file.readAsString()));
  
  print('\nSnapshot: $name');
  print('Timestamp: ${snapshot.timestamp}');
  print('Total: ${snapshot.totalPassed}/${snapshot.totalTests} tests passing');
  print('\nSuite breakdown:');
  
  final suites = snapshot.suiteSummaries.values.toList()..sort((a, b) => a.suite.compareTo(b.suite));
  for (final suite in suites) {
    final percentage = (suite.passed / suite.total * 100).toStringAsFixed(1);
    print('  ${suite.suite}: ${suite.passed}/${suite.total} ($percentage%)');
  }
  
  if (snapshot.failedTests.isNotEmpty) {
    print('\nFailed tests (${snapshot.failedTests.length}):');
    final tests = snapshot.failedTests.values.toList()..sort((a, b) => '${a.suite}/${a.test}'.compareTo('${b.suite}/${b.test}'));
    for (final test in tests) {
      print('  - ${test.suite}/${test.test}: ${test.error}');
    }
  }
}

class ConformanceSnapshot {
  final String name;
  final DateTime timestamp;
  int totalPassed = 0;
  int totalTests = 0;
  Map<String, SuiteSummary> suiteSummaries = {};
  Map<String, TestResult> failedTests = {};
  
  ConformanceSnapshot({required this.name, required this.timestamp});
  
  Map<String, dynamic> toJson() => {
    'name': name,
    'timestamp': timestamp.toIso8601String(),
    'totalPassed': totalPassed,
    'totalTests': totalTests,
    'suiteSummaries': suiteSummaries.map((k, v) => MapEntry(k, v.toJson())),
    'failedTests': failedTests.map((k, v) => MapEntry(k, v.toJson())),
  };
  
  factory ConformanceSnapshot.fromJson(Map<String, dynamic> json) {
    final snapshot = ConformanceSnapshot(
      name: json['name'],
      timestamp: DateTime.parse(json['timestamp']),
    );
    snapshot.totalPassed = json['totalPassed'];
    snapshot.totalTests = json['totalTests'];
    snapshot.suiteSummaries = (json['suiteSummaries'] as Map<String, dynamic>)
        .map((k, v) => MapEntry(k, SuiteSummary.fromJson(v)));
    snapshot.failedTests = (json['failedTests'] as Map<String, dynamic>)
        .map((k, v) => MapEntry(k, TestResult.fromJson(v)));
    return snapshot;
  }
}

class SuiteSummary {
  final String suite;
  final int passed;
  final int total;
  
  SuiteSummary({required this.suite, required this.passed, required this.total});
  
  Map<String, dynamic> toJson() => {
    'suite': suite,
    'passed': passed,
    'total': total,
  };
  
  factory SuiteSummary.fromJson(Map<String, dynamic> json) => SuiteSummary(
    suite: json['suite'],
    passed: json['passed'],
    total: json['total'],
  );
}

class TestResult {
  final String suite;
  final String test;
  final bool passed;
  final String error;
  
  TestResult({required this.suite, required this.test, required this.passed, required this.error});
  
  Map<String, dynamic> toJson() => {
    'suite': suite,
    'test': test,
    'passed': passed,
    'error': error,
  };
  
  factory TestResult.fromJson(Map<String, dynamic> json) => TestResult(
    suite: json['suite'],
    test: json['test'],
    passed: json['passed'],
    error: json['error'],
  );
}