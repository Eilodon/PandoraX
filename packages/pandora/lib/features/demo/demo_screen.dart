import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../demo/demo_mode.dart';
import '../../demo/test_scenarios.dart';
import '../../demo/demo_data.dart';

/// Demo Screen - Màn hình quản lý demo mode và test scenarios
class DemoScreen extends ConsumerStatefulWidget {
  const DemoScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends ConsumerState<DemoScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.science, color: Colors.orange),
            SizedBox(width: 8),
            Text('Demo & Testing'),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.toggle_on), text: 'Demo Mode'),
            Tab(icon: Icon(Icons.play_arrow), text: 'Test Scenarios'),
            Tab(icon: Icon(Icons.data_object), text: 'Demo Data'),
            Tab(icon: Icon(Icons.analytics), text: 'Analytics'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDemoModeTab(),
          _buildTestScenariosTab(),
          _buildDemoDataTab(),
          _buildAnalyticsTab(),
        ],
      ),
    );
  }

  /// Tab Demo Mode Control
  Widget _buildDemoModeTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Demo Mode Toggle Card
          DemoModeToggle(),
          
          SizedBox(height: 16),
          
          // Demo Mode Info
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: Colors.blue),
                      SizedBox(width: 8),
                      Text(
                        'Về Demo Mode',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Demo Mode cho phép bạn test ứng dụng với dữ liệu giả lập mà không cần:',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 8),
                  _buildFeatureList([
                    '🔑 API keys (Gemini AI, Firebase)',
                    '☁️ Internet connection',
                    '📱 Microphone permissions',
                    '💾 Real database setup',
                    '🔔 Notification permissions',
                  ]),
                  SizedBox(height: 12),
                  Text(
                    'Tất cả tính năng sẽ hoạt động với mock services và demo data.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 16),
          
          // Quick Actions
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Actions',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => _showDemoDataDialog(),
                        icon: Icon(Icons.data_object),
                        label: Text('Load Demo Data'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => _showMockServicesDialog(),
                        icon: Icon(Icons.settings),
                        label: Text('Mock Services'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => _exportDemoData(),
                        icon: Icon(Icons.download),
                        label: Text('Export Data'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Tab Test Scenarios
  Widget _buildTestScenariosTab() {
    final demoState = ref.watch(demoModeProvider);
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Run Tests Card
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.play_circle, color: Colors.green),
                      SizedBox(width: 8),
                      Text(
                        'Test Scenarios',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Chạy các kịch bản test tự động để kiểm tra tất cả tính năng:',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 16),
                  
                  if (!demoState.isEnabled)
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.orange.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.warning, color: Colors.orange),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Bật Demo Mode để chạy test scenarios',
                              style: TextStyle(color: Colors.orange.shade800),
                            ),
                          ),
                        ],
                      ),
                    )
                  else ...[
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: demoState.isLoading 
                          ? null 
                          : () => ref.read(demoModeProvider.notifier).runTestScenarios(),
                        icon: demoState.isLoading 
                          ? SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Icon(Icons.play_arrow),
                        label: Text(
                          demoState.isLoading 
                            ? 'Running Tests...' 
                            : 'Run All Test Scenarios',
                        ),
                      ),
                    ),
                    
                    if (demoState.lastTestResult != null) ...[
                      SizedBox(height: 16),
                      TestResultsWidget(result: demoState.lastTestResult!),
                    ],
                  ],
                ],
              ),
            ),
          ),
          
          SizedBox(height: 16),
          
          // Available Scenarios
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Available Test Scenarios',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 12),
                  ..._buildScenariosList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Tab Demo Data
  Widget _buildDemoDataTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Demo Notes
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.note, color: Colors.blue),
                      SizedBox(width: 8),
                      Text(
                        'Demo Notes',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text('${DemoDataGenerator.generateDemoNotes().length} demo notes available'),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => _showDemoNotesDialog(),
                    child: Text('View Demo Notes'),
                  ),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 16),
          
          // Demo Conversations
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.chat, color: Colors.green),
                      SizedBox(width: 8),
                      Text(
                        'Demo Conversations',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text('${DemoDataGenerator.generateDemoConversations().length} AI conversations'),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => _showDemoConversationsDialog(),
                    child: Text('View Conversations'),
                  ),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 16),
          
          // Demo Voice Recordings
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.mic, color: Colors.purple),
                      SizedBox(width: 8),
                      Text(
                        'Demo Voice Recordings',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text('${DemoDataGenerator.generateDemoVoiceRecordings().length} voice samples'),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => _showVoiceRecordingsDialog(),
                    child: Text('View Voice Data'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Tab Analytics
  Widget _buildAnalyticsTab() {
    final analytics = DemoDataGenerator.generateDemoAnalytics();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // User Stats
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.blue),
                      SizedBox(width: 8),
                      Text(
                        'User Statistics',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  _buildStatsGrid(analytics['user_stats']),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 16),
          
          // Usage Patterns
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.timeline, color: Colors.green),
                      SizedBox(width: 8),
                      Text(
                        'Usage Patterns',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  _buildUsagePatterns(analytics['usage_patterns']),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 16),
          
          // AI Stats
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.smart_toy, color: Colors.purple),
                      SizedBox(width: 8),
                      Text(
                        'AI Statistics',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  _buildAiStats(analytics['ai_stats']),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build feature list
  Widget _buildFeatureList(List<String> features) {
    return Column(
      children: features.map((feature) => Padding(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• '),
            Expanded(child: Text(feature)),
          ],
        ),
      )).toList(),
    );
  }

  /// Build scenarios list
  List<Widget> _buildScenariosList() {
    final scenarios = [
      {'name': 'Note Management', 'icon': Icons.note, 'description': 'Test CRUD operations for notes'},
      {'name': 'AI Chat', 'icon': Icons.chat, 'description': 'Test AI service interactions'},
      {'name': 'Speech Recognition', 'icon': Icons.mic, 'description': 'Test voice-to-text features'},
      {'name': 'Cloud Sync', 'icon': Icons.cloud, 'description': 'Test data synchronization'},
      {'name': 'Notifications', 'icon': Icons.notifications, 'description': 'Test notification system'},
      {'name': 'Error Handling', 'icon': Icons.error, 'description': 'Test error scenarios'},
      {'name': 'Performance', 'icon': Icons.speed, 'description': 'Test app performance'},
    ];
    
    return scenarios.map((scenario) => ListTile(
      leading: Icon(scenario['icon'] as IconData),
      title: Text(scenario['name'] as String),
      subtitle: Text(scenario['description'] as String),
      dense: true,
    )).toList();
  }

  /// Build stats grid
  Widget _buildStatsGrid(Map<String, dynamic> stats) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      childAspectRatio: 2,
      children: stats.entries.map((entry) => Container(
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              entry.value.toString(),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Text(
                entry.key.replaceAll('_', ' '),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }

  /// Build usage patterns
  Widget _buildUsagePatterns(Map<String, dynamic> patterns) {
    return Column(
      children: patterns.entries.map((entry) => ListTile(
        title: Text(entry.key.replaceAll('_', ' ')),
        trailing: Text(entry.value.toString()),
      )).toList(),
    );
  }

  /// Build AI stats
  Widget _buildAiStats(Map<String, dynamic> aiStats) {
    return Column(
      children: aiStats.entries.map((entry) => ListTile(
        title: Text(entry.key.replaceAll('_', ' ')),
        trailing: Text(entry.value.toString()),
      )).toList(),
    );
  }

  // Dialog methods
  void _showDemoDataDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Load Demo Data'),
        content: Text('This will load sample notes and data into the app. Continue?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Demo data loaded!')),
              );
            },
            child: Text('Load'),
          ),
        ],
      ),
    );
  }

  void _showMockServicesDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Mock Services Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(title: Text('AI Service'), trailing: Icon(Icons.check, color: Colors.green)),
            ListTile(title: Text('Speech Recognition'), trailing: Icon(Icons.check, color: Colors.green)),
            ListTile(title: Text('Cloud Sync'), trailing: Icon(Icons.check, color: Colors.green)),
            ListTile(title: Text('Notifications'), trailing: Icon(Icons.check, color: Colors.green)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _exportDemoData() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Demo data exported to downloads!')),
    );
  }

  void _showDemoNotesDialog() {
    final notes = DemoDataGenerator.generateDemoNotes();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Demo Notes'),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(notes[index].title),
              subtitle: Text(notes[index].content, maxLines: 2, overflow: TextOverflow.ellipsis),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showDemoConversationsDialog() {
    final conversations = DemoDataGenerator.generateDemoConversations();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Demo Conversations'),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: ListView.builder(
            itemCount: conversations.length,
            itemBuilder: (context, index) {
              final conv = conversations[index];
              final messages = conv['messages'] as List;
              return ExpansionTile(
                title: Text('Conversation ${index + 1}'),
                subtitle: Text('${messages.length} messages'),
                children: messages.map<Widget>((msg) => ListTile(
                  leading: Icon(msg['isUser'] ? Icons.person : Icons.smart_toy),
                  title: Text(msg['message'], maxLines: 3, overflow: TextOverflow.ellipsis),
                )).toList(),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showVoiceRecordingsDialog() {
    final recordings = DemoDataGenerator.generateDemoVoiceRecordings();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Demo Voice Recordings'),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: ListView.builder(
            itemCount: recordings.length,
            itemBuilder: (context, index) {
              final recording = recordings[index];
              return ListTile(
                leading: Icon(Icons.mic),
                title: Text(recording['text']),
                subtitle: Text('Duration: ${recording['duration']}'),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}
