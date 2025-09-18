import 'package:flutter/material.dart';
import 'package:advanced_ai_models/advanced_ai_models.dart';
import 'package:federated_learning/federated_learning.dart';
import 'package:edge_computing/edge_computing.dart';

void main() {
  runApp(Phase2DemoApp());
}

class Phase2DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phase 2 Demo - AI Enhancement',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: true,
      ),
      home: Phase2DemoHome(),
    );
  }
}

class Phase2DemoHome extends StatefulWidget {
  @override
  _Phase2DemoHomeState createState() => _Phase2DemoHomeState();
}

class _Phase2DemoHomeState extends State<Phase2DemoHome> {
  late AIModelRouter _aiModelRouter;
  late FederatedLearner _federatedLearner;
  late EdgeProcessor _edgeProcessor;
  
  bool _isInitialized = false;
  String _status = 'Initializing...';
  List<String> _logs = [];
  
  // AI Model Router state
  bool _aiRouterEnabled = false;
  int _aiRequestsProcessed = 0;
  
  // Federated Learning state
  bool _federatedLearningEnabled = false;
  int _localTrainingRounds = 0;
  
  // Edge Computing state
  bool _edgeComputingEnabled = false;
  int _edgeTasksProcessed = 0;

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    try {
      setState(() {
        _status = 'Initializing AI Model Router...';
      });
      
      // Initialize AI Model Router
      _aiModelRouter = AIModelRouter();
      await _aiModelRouter.initialize();
      
      setState(() {
        _status = 'Initializing Federated Learning...';
      });
      
      // Initialize Federated Learning
      _federatedLearner = FederatedLearner();
      await _federatedLearner.initialize();
      
      setState(() {
        _status = 'Initializing Edge Computing...';
      });
      
      // Initialize Edge Computing
      _edgeProcessor = EdgeProcessor();
      await _edgeProcessor.initialize();
      
      setState(() {
        _status = 'All Phase 2 services initialized successfully!';
        _isInitialized = true;
      });
      
      _addLog('✅ All Phase 2 services initialized successfully');
      
    } catch (e) {
      setState(() {
        _status = 'Error: $e';
      });
      _addLog('❌ Error initializing services: $e');
    }
  }

  void _addLog(String message) {
    setState(() {
      _logs.add('${DateTime.now().toString().substring(11, 19)}: $message');
    });
  }

  Future<void> _testAIModelRouter() async {
    _addLog('🤖 Testing AI Model Router...');
    
    try {
      // Test text generation
      final textRequest = AIRequest(
        id: 'test-text-${DateTime.now().millisecondsSinceEpoch}',
        type: AIRequestType.textGeneration,
        prompt: 'Hello, how are you?',
        timestamp: DateTime.now(),
      );
      
      final textResponse = await _aiModelRouter.processRequest(textRequest);
      _addLog('📝 Text generation: ${textResponse.content.substring(0, 50)}...');
      
      // Test code generation
      final codeRequest = AIRequest(
        id: 'test-code-${DateTime.now().millisecondsSinceEpoch}',
        type: AIRequestType.codeGeneration,
        prompt: 'Write a simple function in Dart',
        timestamp: DateTime.now(),
      );
      
      final codeResponse = await _aiModelRouter.processRequest(codeRequest);
      _addLog('💻 Code generation: ${codeResponse.content.substring(0, 50)}...');
      
      setState(() {
        _aiRequestsProcessed += 2;
      });
      
      _addLog('✅ AI Model Router test completed');
      
    } catch (e) {
      _addLog('❌ AI Model Router test failed: $e');
    }
  }

  Future<void> _testFederatedLearning() async {
    _addLog('🤝 Testing Federated Learning...');
    
    try {
      // Add some training data
      final trainingData = TrainingData(
        id: 'test-data-${DateTime.now().millisecondsSinceEpoch}',
        input: {'text': 'Hello world'},
        output: {'label': 'positive'},
        timestamp: DateTime.now(),
      );
      
      _federatedLearner.addTrainingData(trainingData);
      _addLog('📊 Added training data');
      
      // Start local training
      await _federatedLearner.startLocalTraining();
      _addLog('🏋️ Local training completed');
      
      // Participate in aggregation
      await _federatedLearner.participateInAggregation();
      _addLog('🔄 Participated in aggregation');
      
      setState(() {
        _localTrainingRounds++;
      });
      
      _addLog('✅ Federated Learning test completed');
      
    } catch (e) {
      _addLog('❌ Federated Learning test failed: $e');
    }
  }

  Future<void> _testEdgeComputing() async {
    _addLog('🔧 Testing Edge Computing...');
    
    try {
      // Enable edge computing
      await _edgeProcessor.enable();
      _addLog('⚡ Edge computing enabled');
      
      // Create edge task
      final task = EdgeTask(
        id: 'test-task-${DateTime.now().millisecondsSinceEpoch}',
        type: EdgeTaskType.aiInference,
        data: {'input': 'Test data for edge processing'},
        priority: EdgeTaskPriority.medium,
        timestamp: DateTime.now(),
      );
      
      // Process task
      final result = await _edgeProcessor.processTask(task);
      _addLog('📋 Edge task processed: ${result.success ? 'Success' : 'Failed'}');
      
      setState(() {
        _edgeTasksProcessed++;
      });
      
      _addLog('✅ Edge Computing test completed');
      
    } catch (e) {
      _addLog('❌ Edge Computing test failed: $e');
    }
  }

  Future<void> _testAllServices() async {
    _addLog('🚀 Testing all Phase 2 services...');
    
    await _testAIModelRouter();
    await Future.delayed(Duration(seconds: 1));
    
    await _testFederatedLearning();
    await Future.delayed(Duration(seconds: 1));
    
    await _testEdgeComputing();
    
    _addLog('🎉 All Phase 2 tests completed!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phase 2 Demo - AI Enhancement'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Card
            Card(
              color: _isInitialized ? Colors.green[50] : Colors.orange[50],
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Status',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(_status),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Service Status Cards
            if (_isInitialized) ...[
              Row(
                children: [
                  Expanded(
                    child: _buildServiceCard(
                      'AI Model Router',
                      _aiRequestsProcessed,
                      'requests',
                      Colors.blue,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _buildServiceCard(
                      'Federated Learning',
                      _localTrainingRounds,
                      'rounds',
                      Colors.green,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 8),
              
              Row(
                children: [
                  Expanded(
                    child: _buildServiceCard(
                      'Edge Computing',
                      _edgeTasksProcessed,
                      'tasks',
                      Colors.orange,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Container(), // Empty space
                  ),
                ],
              ),
            ],
            
            SizedBox(height: 16),
            
            // Test Buttons
            if (_isInitialized) ...[
              Text(
                'Phase 2 Tests',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _testAIModelRouter,
                      child: Text('Test AI Router'),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _testFederatedLearning,
                      child: Text('Test Federated'),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 8),
              
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _testEdgeComputing,
                      child: Text('Test Edge'),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _testAllServices,
                      child: Text('Test All'),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 8),
              
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _logs.clear();
                        });
                      },
                      child: Text('Clear Logs'),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Container(), // Empty space
                  ),
                ],
              ),
            ],
            
            SizedBox(height: 16),
            
            // Logs
            Text(
              'Logs',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  itemCount: _logs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: Text(
                        _logs[index],
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(String title, int count, String unit, Color color) {
    return Card(
      color: color[50],
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color[800],
              ),
            ),
            SizedBox(height: 4),
            Text(
              '$count $unit',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _aiModelRouter.dispose();
    _federatedLearner.dispose();
    _edgeProcessor.dispose();
    super.dispose();
  }
}
