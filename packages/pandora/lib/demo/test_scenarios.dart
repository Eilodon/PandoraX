
class TestScenariosManager {
  static final TestScenariosManager _instance = TestScenariosManager._internal();
  factory TestScenariosManager() => _instance;
  TestScenariosManager._internal();

  bool _isInitialized = false;
  List<TestScenario> _scenarios = [];

  Future<void> initialize() async {
    if (_isInitialized) return;
    
    _scenarios = _createTestScenarios();
    _isInitialized = true;
  }

  void dispose() {
    _scenarios.clear();
    _isInitialized = false;
  }

  List<TestScenario> get scenarios => _scenarios;

  List<TestScenario> _createTestScenarios() {
    return [
      TestScenario(
        id: 'create_note',
        name: 'Create Note',
        description: 'Test creating a new note',
        steps: [
          'Open the app',
          'Tap the + button',
          'Enter note content',
          'Save the note',
        ],
      ),
      TestScenario(
        id: 'search_notes',
        name: 'Search Notes',
        description: 'Test searching for notes',
        steps: [
          'Open the app',
          'Tap the search icon',
          'Enter search query',
          'View results',
        ],
      ),
      TestScenario(
        id: 'ai_chat',
        name: 'AI Chat',
        description: 'Test AI chat functionality',
        steps: [
          'Navigate to AI chat',
          'Send a message',
          'Wait for AI response',
          'Verify response quality',
        ],
      ),
      TestScenario(
        id: 'voice_commands',
        name: 'Voice Commands',
        description: 'Test voice command recognition',
        steps: [
          'Enable voice input',
          'Speak a command',
          'Verify command recognition',
          'Check action execution',
        ],
      ),
    ];
  }

  TestScenario? getScenario(String id) {
    try {
      return _scenarios.firstWhere((scenario) => scenario.id == id);
    } catch (e) {
      return null;
    }
  }

  List<TestScenario> getScenariosByCategory(String category) {
    return _scenarios.where((scenario) => scenario.category == category).toList();
  }
}

class TestScenario {
  final String id;
  final String name;
  final String description;
  final List<String> steps;
  final String category;
  final TestStatus status;
  final DateTime? lastRun;
  final String? error;

  const TestScenario({
    required this.id,
    required this.name,
    required this.description,
    required this.steps,
    this.category = 'general',
    this.status = TestStatus.notRun,
    this.lastRun,
    this.error,
  });

  TestScenario copyWith({
    String? id,
    String? name,
    String? description,
    List<String>? steps,
    String? category,
    TestStatus? status,
    DateTime? lastRun,
    String? error,
  }) {
    return TestScenario(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      steps: steps ?? this.steps,
      category: category ?? this.category,
      status: status ?? this.status,
      lastRun: lastRun ?? this.lastRun,
      error: error ?? this.error,
    );
  }
}

enum TestStatus {
  notRun,
  running,
  passed,
  failed,
  skipped,
}

class TestRunner {
  static final TestRunner _instance = TestRunner._internal();
  factory TestRunner() => _instance;
  TestRunner._internal();

  final TestScenariosManager _scenariosManager = TestScenariosManager();
  final List<TestResult> _results = [];

  Future<void> initialize() async {
    await _scenariosManager.initialize();
  }

  Future<List<TestResult>> runAllTests() async {
    _results.clear();
    
    for (final scenario in _scenariosManager.scenarios) {
      final result = await runTest(scenario);
      _results.add(result);
    }
    
    return _results;
  }

  Future<TestResult> runTest(TestScenario scenario) async {
    final startTime = DateTime.now();
    
    try {
      // Simulate test execution
      await Future.delayed(const Duration(seconds: 1));
      
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);
      
      return TestResult(
        scenarioId: scenario.id,
        status: TestStatus.passed,
        duration: duration,
        timestamp: endTime,
      );
    } catch (e) {
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);
      
      return TestResult(
        scenarioId: scenario.id,
        status: TestStatus.failed,
        duration: duration,
        timestamp: endTime,
        error: e.toString(),
      );
    }
  }

  List<TestResult> get results => _results;
  
  TestResult? getResult(String scenarioId) {
    try {
      return _results.firstWhere((result) => result.scenarioId == scenarioId);
    } catch (e) {
      return null;
    }
  }
}

class TestResult {
  final String scenarioId;
  final TestStatus status;
  final Duration duration;
  final DateTime timestamp;
  final String? error;

  const TestResult({
    required this.scenarioId,
    required this.status,
    required this.duration,
    required this.timestamp,
    this.error,
  });
}
