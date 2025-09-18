import 'package:flutter/material.dart';
import 'package:realtime_collaboration/realtime_collaboration.dart';
import 'package:advanced_federated_learning/advanced_federated_learning.dart';
import 'package:complete_edge_computing/complete_edge_computing.dart';

void main() {
  runApp(Phase4DemoApp());
}

class Phase4DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phase 4 Demo - Advanced Features',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: true,
      ),
      home: Phase4DemoHome(),
    );
  }
}

class Phase4DemoHome extends StatefulWidget {
  @override
  _Phase4DemoHomeState createState() => _Phase4DemoHomeState();
}

class _Phase4DemoHomeState extends State<Phase4DemoHome> {
  late CollaborationManager _collaborationManager;
  late FederatedLearningEngine _federatedLearningEngine;
  late EdgeComputingEngine _edgeComputingEngine;
  
  bool _isInitialized = false;
  String _status = 'Initializing...';
  List<String> _logs = [];
  
  // Real-time Collaboration state
  bool _collaborationEnabled = false;
  int _collaborationSessions = 0;
  int _activeUsers = 0;
  int _operationsProcessed = 0;
  
  // Advanced Federated Learning state
  bool _federatedLearningEnabled = false;
  int _trainingRounds = 0;
  double _modelAccuracy = 0.0;
  double _privacyBudget = 1.0;
  
  // Complete Edge Computing state
  bool _edgeComputingEnabled = false;
  int _edgeTasks = 0;
  double _cpuUsage = 0.0;
  double _memoryUsage = 0.0;

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    try {
      setState(() {
        _status = 'Initializing Real-time Collaboration...';
      });
      
      // Initialize Collaboration Manager
      _collaborationManager = CollaborationManager();
      await _collaborationManager.initialize(
        serverUrl: 'ws://localhost:8080',
        userId: 'user_${DateTime.now().millisecondsSinceEpoch}',
        userName: 'Demo User',
      );
      
      setState(() {
        _status = 'Initializing Advanced Federated Learning...';
      });
      
      // Initialize Federated Learning Engine
      _federatedLearningEngine = FederatedLearningEngine();
      await _federatedLearningEngine.initialize();
      
      setState(() {
        _status = 'Initializing Complete Edge Computing...';
      });
      
      // Initialize Edge Computing Engine
      _edgeComputingEngine = EdgeComputingEngine();
      await _edgeComputingEngine.initialize();
      
      setState(() {
        _status = 'All Phase 4 services initialized successfully!';
        _isInitialized = true;
      });
      
      _addLog('✅ All Phase 4 services initialized successfully');
      
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

  Future<void> _testRealTimeCollaboration() async {
    _addLog('🤝 Testing Real-time Collaboration...');
    
    try {
      // Create collaboration session
      final session = await _collaborationManager.createSession(
        documentId: 'doc_${DateTime.now().millisecondsSinceEpoch}',
        documentName: 'Test Document',
        documentType: 'text',
      );
      
      _addLog('📝 Created collaboration session: ${session.documentName}');
      
      // Simulate operations
      for (int i = 0; i < 5; i++) {
        final operation = Operation(
          id: 'op_$i',
          type: OperationType.insert,
          position: i * 10,
          content: 'Test content $i',
          userId: 'user_123',
          timestamp: DateTime.now(),
        );
        
        _collaborationManager.sendOperation(operation);
        _addLog('📤 Sent operation: ${operation.type}');
      }
      
      setState(() {
        _collaborationSessions++;
        _operationsProcessed += 5;
      });
      
      _addLog('✅ Real-time Collaboration test completed');
      
    } catch (e) {
      _addLog('❌ Real-time Collaboration test failed: $e');
    }
  }

  Future<void> _testAdvancedFederatedLearning() async {
    _addLog('🔒 Testing Advanced Federated Learning...');
    
    try {
      // Create learning task
      final task = LearningTask(
        id: 'task_${DateTime.now().millisecondsSinceEpoch}',
        name: 'Test Learning Task',
        type: LearningTaskType.classification,
        parameters: {
          'epochs': 10,
          'learning_rate': 0.001,
          'batch_size': 32,
        },
        trainingData: [
          {'features': [1.0, 2.0], 'label': 'positive'},
          {'features': [3.0, 4.0], 'label': 'negative'},
        ],
        createdAt: DateTime.now(),
      );
      
      _addLog('📚 Created learning task: ${task.name}');
      
      // Start training
      await _federatedLearningEngine.startTraining(task);
      _addLog('🚀 Started federated learning training');
      
      // Simulate training progress
      for (int round = 1; round <= 5; round++) {
        await Future.delayed(Duration(seconds: 1));
        _addLog('🔄 Training round $round completed');
        
        setState(() {
          _trainingRounds = round;
          _modelAccuracy = 0.7 + (round * 0.05); // Simulate improving accuracy
          _privacyBudget = 1.0 - (round * 0.1); // Simulate privacy budget usage
        });
      }
      
      _addLog('✅ Advanced Federated Learning test completed');
      
    } catch (e) {
      _addLog('❌ Advanced Federated Learning test failed: $e');
    }
  }

  Future<void> _testCompleteEdgeComputing() async {
    _addLog('⚡ Testing Complete Edge Computing...');
    
    try {
      // Start edge computing engine
      await _edgeComputingEngine.start();
      _addLog('🚀 Started Edge Computing Engine');
      
      // Create edge task
      final task = EdgeTask(
        id: 'edge_task_${DateTime.now().millisecondsSinceEpoch}',
        name: 'Test Edge Task',
        type: EdgeTaskType.inference,
        priority: TaskPriority.medium,
        requiredCpu: 0.5,
        requiredMemory: 100,
        requiredStorage: 50,
        parameters: {
          'model_id': 'test_model',
          'input_data': {'text': 'Hello Edge Computing!'},
        },
        createdAt: DateTime.now(),
      );
      
      _addLog('📋 Created edge task: ${task.name}');
      
      // Submit task
      await _edgeComputingEngine.submitTask(task);
      _addLog('📤 Submitted edge task for execution');
      
      // Simulate task execution
      for (int i = 0; i < 3; i++) {
        await Future.delayed(Duration(seconds: 1));
        _addLog('⚙️ Edge task processing... ${i + 1}/3');
        
        setState(() {
          _edgeTasks = i + 1;
          _cpuUsage = 0.3 + (i * 0.1);
          _memoryUsage = 0.4 + (i * 0.05);
        });
      }
      
      _addLog('✅ Complete Edge Computing test completed');
      
    } catch (e) {
      _addLog('❌ Complete Edge Computing test failed: $e');
    }
  }

  Future<void> _testAllServices() async {
    _addLog('🚀 Testing all Phase 4 services...');
    
    await _testRealTimeCollaboration();
    await Future.delayed(Duration(seconds: 1));
    
    await _testAdvancedFederatedLearning();
    await Future.delayed(Duration(seconds: 1));
    
    await _testCompleteEdgeComputing();
    
    _addLog('🎉 All Phase 4 tests completed!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phase 4 Demo - Advanced Features'),
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
                      'Real-time Collaboration',
                      _collaborationSessions,
                      'sessions',
                      Colors.blue,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _buildServiceCard(
                      'Federated Learning',
                      _trainingRounds,
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
                      _edgeTasks,
                      'tasks',
                      Colors.orange,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _buildServiceCard(
                      'Model Accuracy',
                      _modelAccuracy,
                      '%',
                      Colors.purple,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 8),
              
              Row(
                children: [
                  Expanded(
                    child: _buildServiceCard(
                      'CPU Usage',
                      _cpuUsage,
                      '%',
                      Colors.red,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _buildServiceCard(
                      'Memory Usage',
                      _memoryUsage,
                      '%',
                      Colors.teal,
                    ),
                  ),
                ],
              ),
            ],
            
            SizedBox(height: 16),
            
            // Test Buttons
            if (_isInitialized) ...[
              Text(
                'Phase 4 Tests',
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
                      onPressed: _testRealTimeCollaboration,
                      child: Text('Test Collaboration'),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _testAdvancedFederatedLearning,
                      child: Text('Test Federated Learning'),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 8),
              
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _testCompleteEdgeComputing,
                      child: Text('Test Edge Computing'),
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

  Widget _buildServiceCard(String title, dynamic count, String unit, Color color) {
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
              '${count is double ? count.toStringAsFixed(2) : count} $unit',
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
    _collaborationManager.dispose();
    _federatedLearningEngine.dispose();
    _edgeComputingEngine.dispose();
    super.dispose();
  }
}
