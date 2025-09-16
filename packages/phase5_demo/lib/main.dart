import 'package:flutter/material.dart';
import 'package:production_optimization/production_optimization.dart';
import 'package:security_hardening/security_hardening.dart';
import 'package:monitoring_alerting/monitoring_alerting.dart';
import 'package:documentation_deployment/documentation_deployment.dart';

void main() {
  runApp(Phase5DemoApp());
}

class Phase5DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phase 5 Demo - Production Deployment',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: Phase5DemoHome(),
    );
  }
}

class Phase5DemoHome extends StatefulWidget {
  @override
  _Phase5DemoHomeState createState() => _Phase5DemoHomeState();
}

class _Phase5DemoHomeState extends State<Phase5DemoHome> {
  late ProductionOptimizer _productionOptimizer;
  late SecurityHardener _securityHardener;
  late MonitoringManager _monitoringManager;
  late DocumentationManager _documentationManager;
  
  bool _isInitialized = false;
  String _status = 'Initializing...';
  List<String> _logs = [];
  
  // Production Optimization state
  bool _optimizationEnabled = false;
  double _cpuUsage = 0.0;
  double _memoryUsage = 0.0;
  int _optimizationRecommendations = 0;
  
  // Security Hardening state
  bool _securityEnabled = false;
  double _securityScore = 0.0;
  int _vulnerabilities = 0;
  int _securityIncidents = 0;
  
  // Monitoring & Alerting state
  bool _monitoringEnabled = false;
  int _activeAlerts = 0;
  int _healthChecks = 0;
  double _systemHealth = 0.0;
  
  // Documentation & Deployment state
  bool _documentationEnabled = false;
  int _apiEndpoints = 0;
  int _documentationPages = 0;
  String _deploymentStatus = 'Not Deployed';

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    try {
      setState(() {
        _status = 'Initializing Production Optimization...';
      });
      
      // Initialize Production Optimizer
      _productionOptimizer = ProductionOptimizer();
      await _productionOptimizer.initialize();
      
      setState(() {
        _status = 'Initializing Security Hardening...';
      });
      
      // Initialize Security Hardener
      _securityHardener = SecurityHardener();
      await _securityHardener.initialize();
      
      setState(() {
        _status = 'Initializing Monitoring & Alerting...';
      });
      
      // Initialize Monitoring Manager
      _monitoringManager = MonitoringManager();
      await _monitoringManager.initialize();
      
      setState(() {
        _status = 'Initializing Documentation & Deployment...';
      });
      
      // Initialize Documentation Manager
      _documentationManager = DocumentationManager();
      await _documentationManager.initialize();
      
      setState(() {
        _status = 'All Phase 5 services initialized successfully!';
        _isInitialized = true;
      });
      
      _addLog('✅ All Phase 5 services initialized successfully');
      
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

  Future<void> _testProductionOptimization() async {
    _addLog('🏗️ Testing Production Optimization...');
    
    try {
      // Start optimization
      await _productionOptimizer.startOptimization();
      _addLog('🚀 Started production optimization');
      
      // Simulate optimization process
      for (int i = 0; i < 5; i++) {
        await Future.delayed(Duration(seconds: 1));
        _addLog('⚙️ Optimizing... ${i + 1}/5');
        
        setState(() {
          _cpuUsage = 0.3 + (i * 0.1);
          _memoryUsage = 0.4 + (i * 0.05);
          _optimizationRecommendations = (i + 1) * 2;
        });
      }
      
      _addLog('✅ Production Optimization test completed');
      
    } catch (e) {
      _addLog('❌ Production Optimization test failed: $e');
    }
  }

  Future<void> _testSecurityHardening() async {
    _addLog('🔒 Testing Security Hardening...');
    
    try {
      // Start security hardening
      await _securityHardener.startHardening();
      _addLog('🛡️ Started security hardening');
      
      // Run security audit
      final auditResult = await _securityHardener.runSecurityAudit();
      _addLog('🔍 Security audit completed: Score ${auditResult.overallScore.toStringAsFixed(1)}');
      
      // Run vulnerability scan
      final vulnerabilities = await _securityHardener.runVulnerabilityScan();
      _addLog('🔎 Found ${vulnerabilities.length} vulnerabilities');
      
      setState(() {
        _securityScore = auditResult.overallScore;
        _vulnerabilities = vulnerabilities.length;
        _securityIncidents = vulnerabilities.where((v) => v.severity == 'critical').length;
      });
      
      _addLog('✅ Security Hardening test completed');
      
    } catch (e) {
      _addLog('❌ Security Hardening test failed: $e');
    }
  }

  Future<void> _testMonitoringAlerting() async {
    _addLog('📊 Testing Monitoring & Alerting...');
    
    try {
      // Start monitoring
      await _monitoringManager.startMonitoring();
      _addLog('👁️ Started monitoring system');
      
      // Simulate monitoring data
      for (int i = 0; i < 3; i++) {
        await Future.delayed(Duration(seconds: 1));
        _addLog('📈 Collecting metrics... ${i + 1}/3');
        
        setState(() {
          _activeAlerts = i + 1;
          _healthChecks = (i + 1) * 5;
          _systemHealth = 0.8 + (i * 0.05);
        });
      }
      
      _addLog('✅ Monitoring & Alerting test completed');
      
    } catch (e) {
      _addLog('❌ Monitoring & Alerting test failed: $e');
    }
  }

  Future<void> _testDocumentationDeployment() async {
    _addLog('📚 Testing Documentation & Deployment...');
    
    try {
      // Generate API documentation
      await _documentationManager.generateAPIDocumentation();
      _addLog('📖 Generated API documentation');
      
      // Generate user manual
      await _documentationManager.generateUserManual();
      _addLog('📘 Generated user manual');
      
      // Simulate deployment
      _addLog('🚀 Starting deployment process...');
      for (int i = 0; i < 4; i++) {
        await Future.delayed(Duration(seconds: 1));
        _addLog('🔄 Deploying... ${i + 1}/4');
      }
      
      setState(() {
        _apiEndpoints = 25;
        _documentationPages = 15;
        _deploymentStatus = 'Deployed Successfully';
      });
      
      _addLog('✅ Documentation & Deployment test completed');
      
    } catch (e) {
      _addLog('❌ Documentation & Deployment test failed: $e');
    }
  }

  Future<void> _testAllServices() async {
    _addLog('🚀 Testing all Phase 5 services...');
    
    await _testProductionOptimization();
    await Future.delayed(Duration(seconds: 1));
    
    await _testSecurityHardening();
    await Future.delayed(Duration(seconds: 1));
    
    await _testMonitoringAlerting();
    await Future.delayed(Duration(seconds: 1));
    
    await _testDocumentationDeployment();
    
    _addLog('🎉 All Phase 5 tests completed!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phase 5 Demo - Production Deployment'),
        backgroundColor: Colors.indigo,
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
                      'Production Optimization',
                      _optimizationRecommendations,
                      'recommendations',
                      Colors.blue,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _buildServiceCard(
                      'Security Score',
                      _securityScore,
                      '%',
                      Colors.red,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 8),
              
              Row(
                children: [
                  Expanded(
                    child: _buildServiceCard(
                      'Active Alerts',
                      _activeAlerts,
                      'alerts',
                      Colors.orange,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _buildServiceCard(
                      'System Health',
                      _systemHealth,
                      '%',
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
                      'API Endpoints',
                      _apiEndpoints,
                      'endpoints',
                      Colors.purple,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _buildServiceCard(
                      'Documentation',
                      _documentationPages,
                      'pages',
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
                'Phase 5 Tests',
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
                      onPressed: _testProductionOptimization,
                      child: Text('Test Optimization'),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _testSecurityHardening,
                      child: Text('Test Security'),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 8),
              
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _testMonitoringAlerting,
                      child: Text('Test Monitoring'),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _testDocumentationDeployment,
                      child: Text('Test Documentation'),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 8),
              
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _testAllServices,
                      child: Text('Test All'),
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
            
            // Deployment Status
            if (_isInitialized) ...[
              Card(
                color: _deploymentStatus == 'Deployed Successfully' ? Colors.green[50] : Colors.orange[50],
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Deployment Status',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(_deploymentStatus),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 16),
            ],
            
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
              '${count is double ? count.toStringAsFixed(1) : count} $unit',
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
    _productionOptimizer.dispose();
    _securityHardener.dispose();
    _monitoringManager.dispose();
    _documentationManager.dispose();
    super.dispose();
  }
}
