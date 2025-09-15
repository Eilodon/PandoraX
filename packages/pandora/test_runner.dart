#!/usr/bin/env dart

import 'dart:io';
import 'dart:async';
import 'lib/demo/mock_services.dart';
import 'lib/demo/demo_data.dart';
import 'lib/demo/test_scenarios.dart';

/// Script chạy test scenarios tự động cho ứng dụng Notes
/// 
/// Usage:
/// ```bash
/// dart test_runner.dart [options]
/// 
/// Options:
///   --help, -h          Show help
///   --scenario, -s      Run specific scenario (by name)
///   --verbose, -v       Verbose output
///   --report, -r        Generate detailed report
///   --loops, -l         Number of test loops (default: 1)
/// ```
void main(List<String> args) async {
  // Parse command line arguments
  final config = parseArguments(args);
  
  if (config.showHelp) {
    printHelp();
    return;
  }
  
  print('🚀 Starting Notes App Test Runner');
  print('=' * 50);
  
  // Initialize test manager
  final testManager = await initializeTestManager();
  if (testManager == null) {
    print('❌ Failed to initialize test manager');
    exit(1);
  }
  
  try {
    if (config.specificScenario != null) {
      await runSpecificScenario(testManager, config);
    } else {
      await runAllScenariosLoop(testManager, config);
    }
  } finally {
    testManager.dispose();
  }
}

/// Configuration for test runner
class TestRunnerConfig {
  final bool showHelp;
  final String? specificScenario;
  final bool verbose;
  final bool generateReport;
  final int loops;
  
  const TestRunnerConfig({
    this.showHelp = false,
    this.specificScenario,
    this.verbose = false,
    this.generateReport = false,
    this.loops = 1,
  });
}

/// Parse command line arguments
TestRunnerConfig parseArguments(List<String> args) {
  bool showHelp = false;
  String? specificScenario;
  bool verbose = false;
  bool generateReport = false;
  int loops = 1;
  
  for (int i = 0; i < args.length; i++) {
    switch (args[i]) {
      case '--help':
      case '-h':
        showHelp = true;
        break;
      case '--scenario':
      case '-s':
        if (i + 1 < args.length) {
          specificScenario = args[++i];
        }
        break;
      case '--verbose':
      case '-v':
        verbose = true;
        break;
      case '--report':
      case '-r':
        generateReport = true;
        break;
      case '--loops':
      case '-l':
        if (i + 1 < args.length) {
          loops = int.tryParse(args[++i]) ?? 1;
        }
        break;
    }
  }
  
  return TestRunnerConfig(
    showHelp: showHelp,
    specificScenario: specificScenario,
    verbose: verbose,
    generateReport: generateReport,
    loops: loops,
  );
}

/// Print help information
void printHelp() {
  print('''
Notes App Test Runner

USAGE:
    dart test_runner.dart [OPTIONS]

OPTIONS:
    --help, -h              Show this help message
    --scenario, -s <name>   Run specific scenario by name
    --verbose, -v           Enable verbose output
    --report, -r            Generate detailed HTML report
    --loops, -l <count>     Number of test loops (default: 1)

AVAILABLE SCENARIOS:
    • Note Management       - Test note CRUD operations
    • AI Chat              - Test AI service interactions
    • Speech Recognition   - Test voice-to-text features
    • Cloud Sync          - Test data synchronization
    • Notifications       - Test notification system
    • Error Handling      - Test error scenarios
    • Performance         - Test app performance

EXAMPLES:
    dart test_runner.dart
    dart test_runner.dart --scenario "AI Chat" --verbose
    dart test_runner.dart --loops 5 --report
    dart test_runner.dart -s "Performance" -v -r

REPORT FILES:
    test_report.txt        - Text report
    test_report.html       - HTML report (with --report flag)
''');
}

/// Initialize test manager with mock services
Future<TestScenariosManager?> initializeTestManager() async {
  try {
    print('🔧 Initializing mock services...');
    
    final mockAiService = MockAiService();
    final mockSpeechService = MockSpeechRecognitionService();
    final mockSyncService = MockSyncService();
    final mockNotificationService = MockNotificationService();
    
    // Initialize services
    await mockSpeechService.initialize();
    await mockSyncService.initialize();
    await mockNotificationService.initialize();
    
    print('✅ Mock services initialized');
    
    return TestScenariosManager(
      mockAiService: mockAiService,
      mockSpeechService: mockSpeechService,
      mockSyncService: mockSyncService,
      mockNotificationService: mockNotificationService,
    );
  } catch (e) {
    print('❌ Failed to initialize: $e');
    return null;
  }
}

/// Run specific scenario
Future<void> runSpecificScenario(TestScenariosManager testManager, TestRunnerConfig config) async {
  print('🎯 Running specific scenario: ${config.specificScenario}');
  print('-' * 30);
  
  // This is a simplified version - in real implementation, 
  // you'd need to map scenario names to specific methods
  final result = await testManager.runAllScenarios();
  
  // Filter result to show only the requested scenario
  final specificResult = result.scenarios.where(
    (s) => s.name.toLowerCase().contains(config.specificScenario!.toLowerCase())
  ).toList();
  
  if (specificResult.isEmpty) {
    print('❌ Scenario "${config.specificScenario}" not found');
    print('Available scenarios:');
    for (final scenario in result.scenarios) {
      print('   • ${scenario.name}');
    }
    return;
  }
  
  for (final scenario in specificResult) {
    printScenarioResult(scenario, config.verbose);
  }
  
  if (config.generateReport) {
    await generateReport(result, 'specific_test_report');
  }
}

/// Run all scenarios in a loop
Future<void> runAllScenariosLoop(TestScenariosManager testManager, TestRunnerConfig config) async {
  final allResults = <TestScenariosResult>[];
  
  for (int loop = 1; loop <= config.loops; loop++) {
    if (config.loops > 1) {
      print('\n🔄 Test Loop $loop/${config.loops}');
      print('-' * 30);
    }
    
    final result = await testManager.runAllScenarios();
    allResults.add(result);
    
    if (config.verbose) {
      print('\nDetailed Results:');
      for (final scenario in result.scenarios) {
        printScenarioResult(scenario, true);
      }
    }
    
    // Small delay between loops
    if (loop < config.loops) {
      await Future.delayed(Duration(seconds: 2));
    }
  }
  
  // Print summary
  printLoopSummary(allResults);
  
  if (config.generateReport) {
    await generateReport(allResults.last, 'test_report');
  }
}

/// Print scenario result
void printScenarioResult(ScenarioResult scenario, bool verbose) {
  final status = scenario.success ? '✅' : '❌';
  final duration = '${scenario.duration.inMilliseconds}ms';
  
  print('$status ${scenario.name.padRight(20)} $duration');
  
  if (verbose) {
    if (scenario.details != null) {
      print('   📝 ${scenario.details}');
    }
    if (scenario.error != null) {
      print('   ⚠️  ${scenario.error}');
    }
  }
}

/// Print summary of multiple test loops
void printLoopSummary(List<TestScenariosResult> results) {
  if (results.isEmpty) return;
  
  print('\n📊 SUMMARY STATISTICS');
  print('=' * 50);
  
  final totalTests = results.length;
  final successfulTests = results.where((r) => r.overallSuccess).length;
  final averageSuccessRate = results
      .map((r) => r.successfulScenarios / r.totalScenarios)
      .reduce((a, b) => a + b) / results.length * 100;
  
  print('Total test runs: $totalTests');
  print('Successful runs: $successfulTests');
  print('Success rate: ${(successfulTests / totalTests * 100).round()}%');
  print('Average scenario success rate: ${averageSuccessRate.round()}%');
  
  // Scenario stability analysis
  final scenarioNames = results.first.scenarios.map((s) => s.name).toList();
  
  print('\nScenario Stability:');
  for (final scenarioName in scenarioNames) {
    final scenarioResults = results
        .map((r) => r.scenarios.firstWhere((s) => s.name == scenarioName))
        .toList();
    
    final successCount = scenarioResults.where((s) => s.success).length;
    final stability = (successCount / totalTests * 100).round();
    final avgDuration = scenarioResults
        .map((s) => s.duration.inMilliseconds)
        .reduce((a, b) => a + b) / totalTests;
    
    final statusIcon = stability >= 90 ? '🟢' : stability >= 70 ? '🟡' : '🔴';
    print('$statusIcon ${scenarioName.padRight(20)} ${stability}% (${avgDuration.round()}ms avg)');
  }
}

/// Generate detailed report files
Future<void> generateReport(TestScenariosResult result, String filename) async {
  try {
    // Generate text report
    final textReport = result.generateReport();
    await File('$filename.txt').writeAsString(textReport);
    print('📄 Text report saved: $filename.txt');
    
    // Generate HTML report
    final htmlReport = generateHtmlReport(result);
    await File('$filename.html').writeAsString(htmlReport);
    print('🌐 HTML report saved: $filename.html');
    
  } catch (e) {
    print('⚠️  Failed to generate report: $e');
  }
}

/// Generate HTML report
String generateHtmlReport(TestScenariosResult result) {
  final timestamp = DateTime.now().toIso8601String();
  final successRate = (result.successfulScenarios / result.totalScenarios * 100).round();
  
  return '''
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notes App Test Report</title>
    <style>
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; margin: 0; padding: 20px; background: #f5f5f5; }
        .container { max-width: 1200px; margin: 0 auto; background: white; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 30px; border-radius: 8px 8px 0 0; }
        .content { padding: 30px; }
        .stats { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin: 20px 0; }
        .stat-card { background: #f8f9fa; padding: 20px; border-radius: 8px; text-align: center; }
        .stat-number { font-size: 2em; font-weight: bold; margin-bottom: 5px; }
        .success { color: #28a745; }
        .warning { color: #ffc107; }
        .danger { color: #dc3545; }
        .scenario { border: 1px solid #e9ecef; border-radius: 8px; margin: 10px 0; padding: 20px; }
        .scenario-header { display: flex; align-items: center; margin-bottom: 10px; }
        .scenario-icon { font-size: 1.5em; margin-right: 10px; }
        .scenario-details { background: #f8f9fa; padding: 15px; border-radius: 5px; margin-top: 10px; }
        .footer { text-align: center; padding: 20px; color: #6c757d; border-top: 1px solid #e9ecef; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🎯 Notes App Test Report</h1>
            <p>Generated on: $timestamp</p>
        </div>
        
        <div class="content">
            <div class="stats">
                <div class="stat-card">
                    <div class="stat-number ${result.overallSuccess ? 'success' : 'danger'}">${result.successfulScenarios}</div>
                    <div>Successful Scenarios</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">${result.totalScenarios}</div>
                    <div>Total Scenarios</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number ${successRate >= 90 ? 'success' : successRate >= 70 ? 'warning' : 'danger'}">${successRate}%</div>
                    <div>Success Rate</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">${result.scenarios.map((s) => s.duration.inMilliseconds).reduce((a, b) => a + b)}ms</div>
                    <div>Total Duration</div>
                </div>
            </div>
            
            <h2>📋 Scenario Details</h2>
            ${result.scenarios.map((scenario) => '''
            <div class="scenario">
                <div class="scenario-header">
                    <span class="scenario-icon">${scenario.success ? '✅' : '❌'}</span>
                    <h3>${scenario.name}</h3>
                    <span style="margin-left: auto; color: #6c757d;">${scenario.duration.inMilliseconds}ms</span>
                </div>
                ${scenario.details != null ? '<div class="scenario-details">📝 ${scenario.details}</div>' : ''}
                ${scenario.error != null ? '<div class="scenario-details" style="background: #f8d7da; color: #721c24;">⚠️ ${scenario.error}</div>' : ''}
            </div>
            ''').join('\n')}
        </div>
        
        <div class="footer">
            <p>🎭 Generated by Notes App Test Runner</p>
            <p>Overall Result: ${result.overallSuccess ? '🎉 All Tests Passed!' : '⚠️ Some Tests Failed'}</p>
        </div>
    </div>
</body>
</html>
''';
}
