import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pandora_ui/pandora_ui.dart';
import '../../../../services/performance_monitor.dart';
import '../../../../services/error_recovery_service.dart';
import '../../../../services/user_analytics_service.dart';

/// Monitoring Dashboard Screen
/// Displays real-time performance metrics, error tracking, and user analytics
class MonitoringDashboardScreen extends ConsumerStatefulWidget {
  const MonitoringDashboardScreen({super.key});

  @override
  ConsumerState<MonitoringDashboardScreen> createState() => _MonitoringDashboardScreenState();
}

class _MonitoringDashboardScreenState extends ConsumerState<MonitoringDashboardScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final PerformanceMonitor _performanceMonitor = PerformanceMonitor();
  final ErrorRecoveryService _errorService = ErrorRecoveryService();
  final UserAnalyticsService _analyticsService = UserAnalyticsService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    await _performanceMonitor.startMonitoring();
    await _errorService.initialize();
    await _analyticsService.initialize();
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
        title: const Text('Monitoring Dashboard'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.speed), text: 'Performance'),
            Tab(icon: Icon(Icons.bug_report), text: 'Errors'),
            Tab(icon: Icon(Icons.analytics), text: 'Analytics'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPerformanceTab(),
          _buildErrorsTab(),
          _buildAnalyticsTab(),
        ],
      ),
    );
  }

  Widget _buildPerformanceTab() {
    return StreamBuilder<Map<String, dynamic>>(
      stream: _performanceMonitor.metricsStream,
      builder: (context, snapshot) {
        final metrics = snapshot.data ?? _performanceMonitor.currentMetrics;
        
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader('Real-time Metrics'),
              const SizedBox(height: 16),
              _buildMetricsGrid(metrics),
              const SizedBox(height: 24),
              _buildSectionHeader('Performance Events'),
              const SizedBox(height: 16),
              _buildPerformanceEvents(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildErrorsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Error Statistics'),
          const SizedBox(height: 16),
          _buildErrorStatistics(),
          const SizedBox(height: 24),
          _buildSectionHeader('Recent Errors'),
          const SizedBox(height: 16),
          _buildRecentErrors(),
          const SizedBox(height: 24),
          _buildSectionHeader('Recovery Actions'),
          const SizedBox(height: 16),
          _buildRecoveryActions(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return StreamBuilder<Map<String, dynamic>>(
      stream: _analyticsService.insightsStream,
      builder: (context, snapshot) {
        final insights = snapshot.data ?? {};
        
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader('User Profile'),
              const SizedBox(height: 16),
              _buildUserProfile(),
              const SizedBox(height: 24),
              _buildSectionHeader('Usage Statistics'),
              const SizedBox(height: 16),
              _buildUsageStatistics(),
              const SizedBox(height: 24),
              _buildSectionHeader('Behavior Insights'),
              const SizedBox(height: 16),
              _buildBehaviorInsights(insights),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _buildMetricsGrid(Map<String, dynamic> metrics) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.5,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildMetricCard('Memory Usage', '${metrics['memory_usage']?.toStringAsFixed(1) ?? '0'} MB', Icons.memory),
        _buildMetricCard('CPU Usage', '${metrics['cpu_usage']?.toStringAsFixed(1) ?? '0'}%', Icons.speed),
        _buildMetricCard('Battery Level', '${metrics['battery_level']?.toStringAsFixed(1) ?? '0'}%', Icons.battery_std),
        _buildMetricCard('UI FPS', '${metrics['ui_fps']?.toStringAsFixed(0) ?? '60'} FPS', Icons.videocam),
        _buildMetricCard('AI Response', '${metrics['ai_response_time']?.toStringAsFixed(0) ?? '0'} ms', Icons.psychology),
        _buildMetricCard('Session Time', '${metrics['session_duration']?.toStringAsFixed(0) ?? '0'} s', Icons.timer),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: Theme.of(context).primaryColor),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceEvents() {
    return StreamBuilder<PerformanceEvent>(
      stream: _performanceMonitor.eventsStream,
      builder: (context, snapshot) {
        final events = _performanceMonitor.recentEvents.take(10).toList();
        
        if (events.isEmpty) {
          return const Center(
            child: Text('No performance events yet'),
          );
        }
        
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[events.length - 1 - index];
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: Icon(
                  _getEventIcon(event.type),
                  color: _getEventColor(event.type),
                ),
                title: Text(event.message),
                subtitle: Text(
                  '${event.timestamp.hour}:${event.timestamp.minute.toString().padLeft(2, '0')}',
                ),
                trailing: Text(
                  event.type.name,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildErrorStatistics() {
    final stats = _errorService.getErrorStatistics();
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildStatRow('Total Errors', stats['total_errors']?.toString() ?? '0'),
            _buildStatRow('Error Types', stats['error_types']?.toString() ?? '0'),
            _buildStatRow('Recent Errors', '${(stats['recent_errors'] as List?)?.length ?? 0}'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentErrors() {
    final errors = _errorService.errorHistory.take(5).toList();
    
    if (errors.isEmpty) {
      return const Center(
        child: Text('No errors recorded'),
      );
    }
    
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: errors.length,
      itemBuilder: (context, index) {
        final error = errors[errors.length - 1 - index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: const Icon(Icons.error, color: Colors.red),
            title: Text(error.message),
            subtitle: Text(
              '${error.timestamp.hour}:${error.timestamp.minute.toString().padLeft(2, '0')} - ${error.type.name}',
            ),
            trailing: Text(
              error.type.name,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRecoveryActions() {
    return StreamBuilder<RecoveryAction>(
      stream: _errorService.recoveryStream,
      builder: (context, snapshot) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recovery Status',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  snapshot.hasData 
                      ? 'Last recovery: ${snapshot.data!.strategy?.name ?? 'None'}'
                      : 'No recovery actions yet',
                ),
                if (snapshot.hasData)
                  Text(
                    'Success: ${snapshot.data!.success ? 'Yes' : 'No'}',
                    style: TextStyle(
                      color: snapshot.data!.success ? Colors.green : Colors.red,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserProfile() {
    final profile = _analyticsService.userProfile;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileRow('Device Model', profile['device_model'] ?? 'Unknown'),
            _buildProfileRow('OS Version', profile['os_version'] ?? 'Unknown'),
            _buildProfileRow('App Version', profile['app_version'] ?? 'Unknown'),
            _buildProfileRow('User Type', profile['user_type'] ?? 'Unknown'),
            _buildProfileRow('First Launch', profile['first_launch'] ?? 'Unknown'),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _buildUsageStatistics() {
    final summary = _analyticsService.getUserAnalyticsSummary();
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildStatRow('Session Duration', '${summary['session_data']['current_session_duration']} min'),
            _buildStatRow('Screen Views', summary['session_data']['screen_views'].toString()),
            _buildStatRow('User Interactions', summary['session_data']['user_interactions'].toString()),
            _buildStatRow('Total Events', summary['total_events'].toString()),
            _buildStatRow('Engagement Level', summary['engagement_level'].toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildBehaviorInsights(Map<String, dynamic> insights) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Behavior Insights',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (insights['most_used_feature'] != null)
              Text('Most Used Feature: ${insights['most_used_feature']}'),
            if (insights['user_engagement_level'] != null)
              Text('Engagement Level: ${insights['user_engagement_level']}'),
            if (insights['ai_usage_stats'] != null)
              Text('AI Interactions: ${insights['ai_usage_stats']['total_interactions']}'),
          ],
        ),
      ),
    );
  }

  IconData _getEventIcon(PerformanceEventType type) {
    switch (type) {
      case PerformanceEventType.memoryWarning:
        return Icons.memory;
      case PerformanceEventType.cpuWarning:
        return Icons.speed;
      case PerformanceEventType.batteryWarning:
        return Icons.battery_alert;
      case PerformanceEventType.frameDrop:
        return Icons.videocam_off;
      case PerformanceEventType.aiResponse:
        return Icons.psychology;
      case PerformanceEventType.userInteraction:
        return Icons.touch_app;
      case PerformanceEventType.apiCall:
        return Icons.api;
      case PerformanceEventType.error:
        return Icons.error;
      case PerformanceEventType.crash:
        return Icons.error_outline;
      default:
        return Icons.info;
    }
  }

  Color _getEventColor(PerformanceEventType type) {
    switch (type) {
      case PerformanceEventType.memoryWarning:
      case PerformanceEventType.cpuWarning:
      case PerformanceEventType.batteryWarning:
        return Colors.orange;
      case PerformanceEventType.frameDrop:
        return Colors.red;
      case PerformanceEventType.aiResponse:
        return Colors.blue;
      case PerformanceEventType.userInteraction:
        return Colors.green;
      case PerformanceEventType.apiCall:
        return Colors.purple;
      case PerformanceEventType.error:
        return Colors.red;
      case PerformanceEventType.crash:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
