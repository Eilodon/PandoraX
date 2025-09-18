import 'package:flutter/material.dart';
import 'package:performance_monitoring/performance_monitoring.dart';
import 'package:mobile_optimization/mobile_optimization.dart';
import 'package:realtime_processing/realtime_processing.dart';

void main() {
  runApp(Phase1DemoApp());
}

class Phase1DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phase 1 Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: Phase1DemoHome(),
    );
  }
}

class Phase1DemoHome extends StatefulWidget {
  @override
  _Phase1DemoHomeState createState() => _Phase1DemoHomeState();
}

class _Phase1DemoHomeState extends State<Phase1DemoHome> {
  late PerformanceMonitor _performanceMonitor;
  late MobileOptimizer _mobileOptimizer;
  late RealtimeProcessor _realtimeProcessor;
  
  bool _isInitialized = false;
  String _status = 'Initializing...';
  List<String> _logs = [];

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    try {
      setState(() {
        _status = 'Initializing Performance Monitor...';
      });
      
      // Initialize Performance Monitor
      _performanceMonitor = PerformanceMonitor();
      await _performanceMonitor.initialize();
      
      setState(() {
        _status = 'Initializing Mobile Optimizer...';
      });
      
      // Initialize Mobile Optimizer
      _mobileOptimizer = MobileOptimizer();
      await _mobileOptimizer.initialize();
      
      setState(() {
        _status = 'Initializing Realtime Processor...';
      });
      
      // Initialize Realtime Processor
      _realtimeProcessor = RealtimeProcessor();
      await _realtimeProcessor.initialize();
      
      setState(() {
        _status = 'All services initialized successfully!';
        _isInitialized = true;
      });
      
      _addLog('✅ All Phase 1 services initialized successfully');
      
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

  Future<void> _testPerformanceMonitoring() async {
    _addLog('🧪 Testing Performance Monitoring...');
    
    // Test app startup tracking
    await _performanceMonitor.trackAppStartup(Duration(milliseconds: 2500));
    _addLog('📊 Tracked app startup: 2500ms');
    
    // Test AI response tracking
    await _performanceMonitor.trackAIResponse(Duration(milliseconds: 1500), 'test-model');
    _addLog('🤖 Tracked AI response: 1500ms');
    
    // Test memory usage tracking
    await _performanceMonitor.trackMemoryUsage(100 * 1024 * 1024); // 100MB
    _addLog('💾 Tracked memory usage: 100MB');
    
    _addLog('✅ Performance monitoring test completed');
  }

  Future<void> _testMobileOptimization() async {
    _addLog('📱 Testing Mobile Optimization...');
    
    // Test mobile optimization
    await _mobileOptimizer.optimize();
    _addLog('⚡ Applied mobile optimizations');
    
    // Test offline mode
    await _mobileOptimizer.enableOfflineMode();
    _addLog('🔌 Enabled offline mode');
    
    // Test adaptive UI
    await _mobileOptimizer.applyAdaptiveUI();
    _addLog('🎨 Applied adaptive UI');
    
    _addLog('✅ Mobile optimization test completed');
  }

  Future<void> _testRealtimeProcessing() async {
    _addLog('⚡ Testing Realtime Processing...');
    
    // Test realtime connection
    await _realtimeProcessor.connect();
    _addLog('🔗 Connected to realtime services');
    
    // Test event sending
    final event = RealtimeEvent(
      type: 'test_event',
      data: {'message': 'Hello from Phase 1!'},
      timestamp: DateTime.now(),
    );
    
    await _realtimeProcessor.sendEvent(event);
    _addLog('📤 Sent test event');
    
    _addLog('✅ Realtime processing test completed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phase 1 Demo'),
        backgroundColor: Colors.blue,
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
            
            // Test Buttons
            if (_isInitialized) ...[
              Text(
                'Phase 1 Tests',
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
                      onPressed: _testPerformanceMonitoring,
                      child: Text('Test Performance'),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _testMobileOptimization,
                      child: Text('Test Mobile'),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 8),
              
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _testRealtimeProcessing,
                      child: Text('Test Realtime'),
                    ),
                  ),
                  SizedBox(width: 8),
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

  @override
  void dispose() {
    _performanceMonitor.dispose();
    _mobileOptimizer.dispose();
    _realtimeProcessor.dispose();
    super.dispose();
  }
}
