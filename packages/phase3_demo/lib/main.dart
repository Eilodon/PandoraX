import 'package:flutter/material.dart';
import 'package:multi_cloud_support/multi_cloud_support.dart';
import 'package:advanced_cloud_services/advanced_cloud_services.dart';
import 'package:cost_optimization/cost_optimization.dart';

void main() {
  runApp(Phase3DemoApp());
}

class Phase3DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phase 3 Demo - Cloud Integration',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: Phase3DemoHome(),
    );
  }
}

class Phase3DemoHome extends StatefulWidget {
  @override
  _Phase3DemoHomeState createState() => _Phase3DemoHomeState();
}

class _Phase3DemoHomeState extends State<Phase3DemoHome> {
  late CloudRouter _cloudRouter;
  late CloudServiceManager _cloudServiceManager;
  late CostOptimizer _costOptimizer;
  
  bool _isInitialized = false;
  String _status = 'Initializing...';
  List<String> _logs = [];
  
  // Multi-Cloud Support state
  bool _multiCloudEnabled = false;
  int _cloudRequestsProcessed = 0;
  Map<String, int> _providerUsage = {};
  
  // Advanced Cloud Services state
  bool _cloudServicesEnabled = false;
  int _mlModelsTrained = 0;
  int _databaseQueriesExecuted = 0;
  int _filesStored = 0;
  
  // Cost Optimization state
  bool _costOptimizationEnabled = false;
  double _totalCost = 0.0;
  int _recommendationsGenerated = 0;

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    try {
      setState(() {
        _status = 'Initializing Multi-Cloud Support...';
      });
      
      // Initialize Cloud Router
      _cloudRouter = CloudRouter();
      await _cloudRouter.initialize();
      
      setState(() {
        _status = 'Initializing Advanced Cloud Services...';
      });
      
      // Initialize Cloud Service Manager
      _cloudServiceManager = CloudServiceManager();
      await _cloudServiceManager.initialize();
      
      setState(() {
        _status = 'Initializing Cost Optimization...';
      });
      
      // Initialize Cost Optimizer
      _costOptimizer = CostOptimizer();
      await _costOptimizer.initialize();
      
      setState(() {
        _status = 'All Phase 3 services initialized successfully!';
        _isInitialized = true;
      });
      
      _addLog('✅ All Phase 3 services initialized successfully');
      
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

  Future<void> _testMultiCloudSupport() async {
    _addLog('☁️ Testing Multi-Cloud Support...');
    
    try {
      // Test cloud routing
      final request = CloudRequest(
        id: 'test-request-${DateTime.now().millisecondsSinceEpoch}',
        type: CloudRequestType.compute,
        data: {'instance_type': 't3.micro'},
        timestamp: DateTime.now(),
      );
      
      final response = await _cloudRouter.routeRequest(request);
      _addLog('🔄 Cloud request routed: ${response.provider}');
      
      // Update usage stats
      final provider = response.provider?.toString() ?? 'unknown';
      _providerUsage[provider] = (_providerUsage[provider] ?? 0) + 1;
      
      setState(() {
        _cloudRequestsProcessed++;
      });
      
      _addLog('✅ Multi-Cloud Support test completed');
      
    } catch (e) {
      _addLog('❌ Multi-Cloud Support test failed: $e');
    }
  }

  Future<void> _testAdvancedCloudServices() async {
    _addLog('🔧 Testing Advanced Cloud Services...');
    
    try {
      // Test ML model training
      final modelConfig = MLModelConfig(
        name: 'test-model-${DateTime.now().millisecondsSinceEpoch}',
        type: MLModelType.textClassification,
        parameters: {'epochs': 10, 'learning_rate': 0.001},
      );
      
      final model = await _cloudServiceManager.trainModel(modelConfig);
      _addLog('🤖 ML model trained: ${model.name}');
      
      // Test database query
      final query = DatabaseQuery(
        id: 'test-query-${DateTime.now().millisecondsSinceEpoch}',
        sql: 'SELECT * FROM users LIMIT 10',
        parameters: {},
        timestamp: DateTime.now(),
      );
      
      final queryResult = await _cloudServiceManager.executeQuery(query);
      _addLog('🗄️ Database query executed: ${queryResult.recordCount} records');
      
      // Test file storage
      final fileRequest = FileUploadRequest(
        fileName: 'test-file-${DateTime.now().millisecondsSinceEpoch}.txt',
        content: 'Test file content',
        contentType: 'text/plain',
        metadata: {'description': 'Test file'},
      );
      
      final fileObject = await _cloudServiceManager.storeFile(fileRequest);
      _addLog('📁 File stored: ${fileObject.fileName}');
      
      setState(() {
        _mlModelsTrained++;
        _databaseQueriesExecuted++;
        _filesStored++;
      });
      
      _addLog('✅ Advanced Cloud Services test completed');
      
    } catch (e) {
      _addLog('❌ Advanced Cloud Services test failed: $e');
    }
  }

  Future<void> _testCostOptimization() async {
    _addLog('💰 Testing Cost Optimization...');
    
    try {
      // Get current costs
      final currentCosts = _costOptimizer.currentCosts;
      if (currentCosts != null) {
        _addLog('💵 Current total cost: \$${currentCosts.totalCost.toStringAsFixed(2)}');
        setState(() {
          _totalCost = currentCosts.totalCost;
        });
      }
      
      // Get cost prediction
      final prediction = await _costOptimizer.getCostPrediction(30);
      _addLog('📊 30-day cost prediction: \$${prediction.predictedCost.toStringAsFixed(2)}');
      
      // Get recommendations
      final recommendations = await _costOptimizer.getRecommendations();
      _addLog('💡 Generated ${recommendations.length} optimization recommendations');
      
      setState(() {
        _recommendationsGenerated = recommendations.length;
      });
      
      _addLog('✅ Cost Optimization test completed');
      
    } catch (e) {
      _addLog('❌ Cost Optimization test failed: $e');
    }
  }

  Future<void> _testAllServices() async {
    _addLog('🚀 Testing all Phase 3 services...');
    
    await _testMultiCloudSupport();
    await Future.delayed(Duration(seconds: 1));
    
    await _testAdvancedCloudServices();
    await Future.delayed(Duration(seconds: 1));
    
    await _testCostOptimization();
    
    _addLog('🎉 All Phase 3 tests completed!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phase 3 Demo - Cloud Integration'),
        backgroundColor: Colors.teal,
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
                      'Multi-Cloud',
                      _cloudRequestsProcessed,
                      'requests',
                      Colors.blue,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _buildServiceCard(
                      'Cloud Services',
                      _mlModelsTrained + _databaseQueriesExecuted + _filesStored,
                      'operations',
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
                      'Cost Optimization',
                      _recommendationsGenerated,
                      'recommendations',
                      Colors.orange,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _buildServiceCard(
                      'Total Cost',
                      _totalCost,
                      'USD',
                      Colors.red,
                    ),
                  ),
                ],
              ),
            ],
            
            SizedBox(height: 16),
            
            // Test Buttons
            if (_isInitialized) ...[
              Text(
                'Phase 3 Tests',
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
                      onPressed: _testMultiCloudSupport,
                      child: Text('Test Multi-Cloud'),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _testAdvancedCloudServices,
                      child: Text('Test Cloud Services'),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 8),
              
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _testCostOptimization,
                      child: Text('Test Cost Optimization'),
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
    _cloudRouter.dispose();
    _cloudServiceManager.dispose();
    _costOptimizer.dispose();
    super.dispose();
  }
}
