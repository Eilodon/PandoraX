/// Analytics Dashboard for Phase 6 Analytics & Optimization
/// 
/// This component provides a comprehensive analytics dashboard with
/// real-time metrics, charts, and insights visualization.
library analytics_dashboard;

import 'package:flutter/material.dart';
import 'package:core/core.dart';

/// Analytics dashboard widget for comprehensive insights
class AnalyticsDashboard extends StatefulWidget {
  final String? title;
  final Map<String, dynamic>? initialData;
  final bool showRealTimeMetrics;
  final bool showCharts;
  final bool showInsights;
  final VoidCallback? onRefresh;
  
  const AnalyticsDashboard({
    super.key,
    this.title,
    this.initialData,
    this.showRealTimeMetrics = true,
    this.showCharts = true,
    this.showInsights = true,
    this.onRefresh,
  });
  
  @override
  State<AnalyticsDashboard> createState() => _AnalyticsDashboardState();
}

class _AnalyticsDashboardState extends State<AnalyticsDashboard>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  Map<String, dynamic> _dashboardData = {};
  bool _isLoading = true;
  String _selectedTimeRange = '7d';
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    
    _loadDashboardData();
    _animationController.forward();
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? 'Analytics Dashboard'),
        backgroundColor: DesignTokens.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _refreshData,
            icon: const Icon(Icons.refresh),
          ),
          PopupMenuButton<String>(
            onSelected: _onTimeRangeSelected,
            itemBuilder: (context) => [
              const PopupMenuItem(value: '1d', child: Text('Last 24 hours')),
              const PopupMenuItem(value: '7d', child: Text('Last 7 days')),
              const PopupMenuItem(value: '30d', child: Text('Last 30 days')),
              const PopupMenuItem(value: '90d', child: Text('Last 90 days')),
            ],
            child: const Icon(Icons.calendar_today),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.dashboard), text: 'Overview'),
            Tab(icon: Icon(Icons.trending_up), text: 'Performance'),
            Tab(icon: Icon(Icons.people), text: 'Users'),
            Tab(icon: Icon(Icons.insights), text: 'Insights'),
          ],
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildOverviewTab(),
            _buildPerformanceTab(),
            _buildUsersTab(),
            _buildInsightsTab(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(DesignTokens.spacing6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Key Metrics
          _buildKeyMetricsSection(),
          const SizedBox(height: DesignTokens.spacing8),
          
          // Real-time Metrics
          if (widget.showRealTimeMetrics) ...[
            _buildRealTimeMetricsSection(),
            const SizedBox(height: DesignTokens.spacing8),
          ],
          
          // Charts
          if (widget.showCharts) ...[
            _buildChartsSection(),
            const SizedBox(height: DesignTokens.spacing8),
          ],
          
          // Quick Actions
          _buildQuickActionsSection(),
        ],
      ),
    );
  }
  
  Widget _buildPerformanceTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(DesignTokens.spacing6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Performance Metrics
          _buildPerformanceMetricsSection(),
          const SizedBox(height: DesignTokens.spacing8),
          
          // Performance Charts
          _buildPerformanceChartsSection(),
          const SizedBox(height: DesignTokens.spacing8),
          
          // Performance Alerts
          _buildPerformanceAlertsSection(),
        ],
      ),
    );
  }
  
  Widget _buildUsersTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(DesignTokens.spacing6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Metrics
          _buildUserMetricsSection(),
          const SizedBox(height: DesignTokens.spacing8),
          
          // User Journey
          _buildUserJourneySection(),
          const SizedBox(height: DesignTokens.spacing8),
          
          // User Segmentation
          _buildUserSegmentationSection(),
        ],
      ),
    );
  }
  
  Widget _buildInsightsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(DesignTokens.spacing6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AI Insights
          _buildAIInsightsSection(),
          const SizedBox(height: DesignTokens.spacing8),
          
          // Recommendations
          _buildRecommendationsSection(),
          const SizedBox(height: DesignTokens.spacing8),
          
          // Optimization
          _buildOptimizationSection(),
        ],
      ),
    );
  }
  
  Widget _buildKeyMetricsSection() {
    return _buildSection(
      title: 'Key Metrics',
      children: [
        _buildMetricCard(
          title: 'Total Users',
          value: '1,234',
          change: '+12.5%',
          changeType: 'positive',
          icon: Icons.people,
        ),
        _buildMetricCard(
          title: 'Active Users',
          value: '856',
          change: '+8.3%',
          changeType: 'positive',
          icon: Icons.person,
        ),
        _buildMetricCard(
          title: 'Conversion Rate',
          value: '3.2%',
          change: '+0.5%',
          changeType: 'positive',
          icon: Icons.trending_up,
        ),
        _buildMetricCard(
          title: 'Revenue',
          value: '\$12,345',
          change: '+15.2%',
          changeType: 'positive',
          icon: Icons.attach_money,
        ),
      ],
    );
  }
  
  Widget _buildRealTimeMetricsSection() {
    return _buildSection(
      title: 'Real-time Metrics',
      children: [
        _buildRealTimeMetricCard(
          title: 'Current Users',
          value: '42',
          subtitle: 'Online now',
          color: DesignTokens.success,
        ),
        _buildRealTimeMetricCard(
          title: 'Page Views',
          value: '1,234',
          subtitle: 'Last hour',
          color: DesignTokens.info,
        ),
        _buildRealTimeMetricCard(
          title: 'Response Time',
          value: '245ms',
          subtitle: 'Average',
          color: DesignTokens.warning,
        ),
        _buildRealTimeMetricCard(
          title: 'Error Rate',
          value: '0.1%',
          subtitle: 'Last hour',
          color: DesignTokens.error,
        ),
      ],
    );
  }
  
  Widget _buildChartsSection() {
    return _buildSection(
      title: 'Charts',
      children: [
        _buildChartCard(
          title: 'User Growth',
          subtitle: 'Last 30 days',
          child: _buildSampleChart(),
        ),
        _buildChartCard(
          title: 'Revenue Trend',
          subtitle: 'Last 30 days',
          child: _buildSampleChart(),
        ),
      ],
    );
  }
  
  Widget _buildQuickActionsSection() {
    return _buildSection(
      title: 'Quick Actions',
      children: [
        _buildActionCard(
          title: 'Export Data',
          subtitle: 'Download analytics data',
          icon: Icons.download,
          onTap: _exportData,
        ),
        _buildActionCard(
          title: 'Generate Report',
          subtitle: 'Create detailed report',
          icon: Icons.assessment,
          onTap: _generateReport,
        ),
        _buildActionCard(
          title: 'Schedule Report',
          subtitle: 'Set up automated reports',
          icon: Icons.schedule,
          onTap: _scheduleReport,
        ),
        _buildActionCard(
          title: 'Settings',
          subtitle: 'Configure analytics',
          icon: Icons.settings,
          onTap: _openSettings,
        ),
      ],
    );
  }
  
  Widget _buildPerformanceMetricsSection() {
    return _buildSection(
      title: 'Performance Metrics',
      children: [
        _buildPerformanceMetricCard(
          title: 'App Startup Time',
          value: '1.2s',
          threshold: '2.0s',
          status: 'good',
        ),
        _buildPerformanceMetricCard(
          title: 'Screen Load Time',
          value: '0.8s',
          threshold: '1.0s',
          status: 'good',
        ),
        _buildPerformanceMetricCard(
          title: 'API Response Time',
          value: '245ms',
          threshold: '500ms',
          status: 'good',
        ),
        _buildPerformanceMetricCard(
          title: 'Memory Usage',
          value: '85MB',
          threshold: '100MB',
          status: 'warning',
        ),
      ],
    );
  }
  
  Widget _buildPerformanceChartsSection() {
    return _buildSection(
      title: 'Performance Charts',
      children: [
        _buildChartCard(
          title: 'Performance Over Time',
          subtitle: 'Last 24 hours',
          child: _buildSampleChart(),
        ),
        _buildChartCard(
          title: 'Resource Usage',
          subtitle: 'CPU, Memory, Network',
          child: _buildSampleChart(),
        ),
      ],
    );
  }
  
  Widget _buildPerformanceAlertsSection() {
    return _buildSection(
      title: 'Performance Alerts',
      children: [
        _buildAlertCard(
          title: 'High Memory Usage',
          message: 'Memory usage exceeded 90% threshold',
          severity: 'warning',
          timestamp: '2 minutes ago',
        ),
        _buildAlertCard(
          title: 'Slow API Response',
          message: 'API response time exceeded 1s threshold',
          severity: 'info',
          timestamp: '5 minutes ago',
        ),
      ],
    );
  }
  
  Widget _buildUserMetricsSection() {
    return _buildSection(
      title: 'User Metrics',
      children: [
        _buildUserMetricCard(
          title: 'New Users',
          value: '234',
          change: '+15.2%',
          changeType: 'positive',
        ),
        _buildUserMetricCard(
          title: 'Returning Users',
          value: '622',
          change: '+8.7%',
          changeType: 'positive',
        ),
        _buildUserMetricCard(
          title: 'User Retention',
          value: '68%',
          change: '+2.1%',
          changeType: 'positive',
        ),
        _buildUserMetricCard(
          title: 'Session Duration',
          value: '4m 32s',
          change: '+12.3%',
          changeType: 'positive',
        ),
      ],
    );
  }
  
  Widget _buildUserJourneySection() {
    return _buildSection(
      title: 'User Journey',
      children: [
        _buildJourneyCard(
          title: 'Onboarding Flow',
          completionRate: 78.5,
          steps: 5,
          dropOffStep: 3,
        ),
        _buildJourneyCard(
          title: 'Purchase Flow',
          completionRate: 45.2,
          steps: 4,
          dropOffStep: 2,
        ),
      ],
    );
  }
  
  Widget _buildUserSegmentationSection() {
    return _buildSection(
      title: 'User Segmentation',
      children: [
        _buildSegmentationCard(
          title: 'Power Users',
          count: 156,
          percentage: 12.5,
          color: DesignTokens.primary,
        ),
        _buildSegmentationCard(
          title: 'Regular Users',
          count: 678,
          percentage: 54.2,
          color: DesignTokens.secondary,
        ),
        _buildSegmentationCard(
          title: 'New Users',
          count: 234,
          percentage: 18.7,
          color: DesignTokens.info,
        ),
        _buildSegmentationCard(
          title: 'Inactive Users',
          count: 186,
          percentage: 14.9,
          color: DesignTokens.warning,
        ),
      ],
    );
  }
  
  Widget _buildAIInsightsSection() {
    return _buildSection(
      title: 'AI Insights',
      children: [
        _buildInsightCard(
          title: 'User Behavior Pattern',
          description: 'Users are most active between 2-4 PM on weekdays',
          confidence: 0.85,
          type: 'pattern',
        ),
        _buildInsightCard(
          title: 'Performance Bottleneck',
          description: 'Screen load time is 40% slower on mobile devices',
          confidence: 0.92,
          type: 'performance',
        ),
        _buildInsightCard(
          title: 'Conversion Opportunity',
          description: 'Adding progress indicators could improve conversion by 15%',
          confidence: 0.78,
          type: 'conversion',
        ),
      ],
    );
  }
  
  Widget _buildRecommendationsSection() {
    return _buildSection(
      title: 'Recommendations',
      children: [
        _buildRecommendationCard(
          title: 'Optimize Mobile Performance',
          description: 'Implement lazy loading and image optimization for mobile',
          priority: 'high',
          impact: 'high',
          effort: 'medium',
        ),
        _buildRecommendationCard(
          title: 'Improve Onboarding Flow',
          description: 'Add progress indicators and reduce steps in onboarding',
          priority: 'medium',
          impact: 'medium',
          effort: 'low',
        ),
        _buildRecommendationCard(
          title: 'Implement A/B Testing',
          description: 'Test different layouts to improve conversion rates',
          priority: 'low',
          impact: 'high',
          effort: 'high',
        ),
      ],
    );
  }
  
  Widget _buildOptimizationSection() {
    return _buildSection(
      title: 'Optimization',
      children: [
        _buildOptimizationCard(
          title: 'Performance Optimization',
          status: 'completed',
          improvement: 15.2,
          description: 'Reduced app startup time by 15.2%',
        ),
        _buildOptimizationCard(
          title: 'UX Optimization',
          status: 'in_progress',
          improvement: 0.0,
          description: 'Improving user journey flow',
        ),
        _buildOptimizationCard(
          title: 'Business Optimization',
          status: 'scheduled',
          improvement: 0.0,
          description: 'A/B testing conversion improvements',
        ),
      ],
    );
  }
  
  // ============================================================================
  // HELPER WIDGETS
  // ============================================================================
  
  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: DesignTokens.fontSize2Xl,
            fontWeight: DesignTokens.fontWeightBold,
            color: DesignTokens.neutral900,
          ),
        ),
        const SizedBox(height: DesignTokens.spacing4),
        ...children,
      ],
    );
  }
  
  Widget _buildMetricCard({
    required String title,
    required String value,
    required String change,
    required String changeType,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: DesignTokens.spacing3),
      padding: const EdgeInsets.all(DesignTokens.spacing4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
        boxShadow: DesignTokens.shadowBase,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(DesignTokens.spacing3),
            decoration: BoxDecoration(
              color: DesignTokens.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
            ),
            child: Icon(icon, color: DesignTokens.primary),
          ),
          const SizedBox(width: DesignTokens.spacing4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: DesignTokens.fontSizeSm,
                    color: DesignTokens.neutral600,
                  ),
                ),
                const SizedBox(height: DesignTokens.spacing1),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: DesignTokens.fontSize2Xl,
                    fontWeight: DesignTokens.fontWeightBold,
                    color: DesignTokens.neutral900,
                  ),
                ),
                const SizedBox(height: DesignTokens.spacing1),
                Text(
                  change,
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeSm,
                    color: changeType == 'positive' ? DesignTokens.success : DesignTokens.error,
                    fontWeight: DesignTokens.fontWeightMedium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildRealTimeMetricCard({
    required String title,
    required String value,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: DesignTokens.spacing3),
      padding: const EdgeInsets.all(DesignTokens.spacing4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: DesignTokens.fontSizeSm,
              color: DesignTokens.neutral600,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing1),
          Text(
            value,
            style: TextStyle(
              fontSize: DesignTokens.fontSize2Xl,
              fontWeight: DesignTokens.fontWeightBold,
              color: color,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing1),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: DesignTokens.fontSizeXs,
              color: DesignTokens.neutral500,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildChartCard({
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: DesignTokens.spacing3),
      padding: const EdgeInsets.all(DesignTokens.spacing4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
        boxShadow: DesignTokens.shadowBase,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: DesignTokens.fontSizeLg,
              fontWeight: DesignTokens.fontWeightSemiBold,
              color: DesignTokens.neutral900,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing1),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: DesignTokens.fontSizeSm,
              color: DesignTokens.neutral600,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing4),
          child,
        ],
      ),
    );
  }
  
  Widget _buildSampleChart() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: DesignTokens.neutral50,
        borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
      ),
      child: const Center(
        child: Text(
          'Chart Placeholder',
          style: TextStyle(
            color: DesignTokens.neutral500,
            fontSize: DesignTokens.fontSizeSm,
          ),
        ),
      ),
    );
  }
  
  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: DesignTokens.spacing3),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
          child: Padding(
            padding: const EdgeInsets.all(DesignTokens.spacing4),
            child: Row(
              children: [
                Icon(icon, color: DesignTokens.primary),
                const SizedBox(width: DesignTokens.spacing4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: DesignTokens.fontSizeBase,
                          fontWeight: DesignTokens.fontWeightSemiBold,
                          color: DesignTokens.neutral900,
                        ),
                      ),
                      const SizedBox(height: DesignTokens.spacing1),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: DesignTokens.fontSizeSm,
                          color: DesignTokens.neutral600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildPerformanceMetricCard({
    required String title,
    required String value,
    required String threshold,
    required String status,
  }) {
    Color statusColor;
    switch (status) {
      case 'good':
        statusColor = DesignTokens.success;
        break;
      case 'warning':
        statusColor = DesignTokens.warning;
        break;
      case 'error':
        statusColor = DesignTokens.error;
        break;
      default:
        statusColor = DesignTokens.neutral500;
    }
    
    return Container(
      margin: const EdgeInsets.only(bottom: DesignTokens.spacing3),
      padding: const EdgeInsets.all(DesignTokens.spacing4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
        boxShadow: DesignTokens.shadowBase,
        border: Border.all(color: statusColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: DesignTokens.spacing4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: DesignTokens.fontSizeBase,
                    fontWeight: DesignTokens.fontWeightSemiBold,
                    color: DesignTokens.neutral900,
                  ),
                ),
                const SizedBox(height: DesignTokens.spacing1),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeXl,
                    fontWeight: DesignTokens.fontWeightBold,
                    color: statusColor,
                  ),
                ),
                const SizedBox(height: DesignTokens.spacing1),
                Text(
                  'Threshold: $threshold',
                  style: const TextStyle(
                    fontSize: DesignTokens.fontSizeSm,
                    color: DesignTokens.neutral600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildAlertCard({
    required String title,
    required String message,
    required String severity,
    required String timestamp,
  }) {
    Color severityColor;
    switch (severity) {
      case 'critical':
        severityColor = DesignTokens.error;
        break;
      case 'warning':
        severityColor = DesignTokens.warning;
        break;
      case 'info':
        severityColor = DesignTokens.info;
        break;
      default:
        severityColor = DesignTokens.neutral500;
    }
    
    return Container(
      margin: const EdgeInsets.only(bottom: DesignTokens.spacing3),
      padding: const EdgeInsets.all(DesignTokens.spacing4),
      decoration: BoxDecoration(
        color: severityColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
        border: Border.all(color: severityColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.warning, color: severityColor),
          const SizedBox(width: DesignTokens.spacing4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeBase,
                    fontWeight: DesignTokens.fontWeightSemiBold,
                    color: severityColor,
                  ),
                ),
                const SizedBox(height: DesignTokens.spacing1),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: DesignTokens.fontSizeSm,
                    color: DesignTokens.neutral700,
                  ),
                ),
                const SizedBox(height: DesignTokens.spacing1),
                Text(
                  timestamp,
                  style: const TextStyle(
                    fontSize: DesignTokens.fontSizeXs,
                    color: DesignTokens.neutral500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildUserMetricCard({
    required String title,
    required String value,
    required String change,
    required String changeType,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: DesignTokens.spacing3),
      padding: const EdgeInsets.all(DesignTokens.spacing4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
        boxShadow: DesignTokens.shadowBase,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: DesignTokens.fontSizeSm,
              color: DesignTokens.neutral600,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing1),
          Text(
            value,
            style: const TextStyle(
              fontSize: DesignTokens.fontSize2Xl,
              fontWeight: DesignTokens.fontWeightBold,
              color: DesignTokens.neutral900,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing1),
          Text(
            change,
            style: TextStyle(
              fontSize: DesignTokens.fontSizeSm,
              color: changeType == 'positive' ? DesignTokens.success : DesignTokens.error,
              fontWeight: DesignTokens.fontWeightMedium,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildJourneyCard({
    required String title,
    required double completionRate,
    required int steps,
    required int dropOffStep,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: DesignTokens.spacing3),
      padding: const EdgeInsets.all(DesignTokens.spacing4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
        boxShadow: DesignTokens.shadowBase,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: DesignTokens.fontSizeLg,
              fontWeight: DesignTokens.fontWeightSemiBold,
              color: DesignTokens.neutral900,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing2),
          Text(
            '${completionRate.toStringAsFixed(1)}% completion rate',
            style: const TextStyle(
              fontSize: DesignTokens.fontSizeBase,
              color: DesignTokens.neutral700,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing2),
          LinearProgressIndicator(
            value: completionRate / 100,
            backgroundColor: DesignTokens.neutral200,
            valueColor: AlwaysStoppedAnimation<Color>(
              completionRate > 70 ? DesignTokens.success : DesignTokens.warning,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing2),
          Text(
            'Drop-off at step $dropOffStep of $steps',
            style: const TextStyle(
              fontSize: DesignTokens.fontSizeSm,
              color: DesignTokens.neutral600,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSegmentationCard({
    required String title,
    required int count,
    required double percentage,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: DesignTokens.spacing3),
      padding: const EdgeInsets.all(DesignTokens.spacing4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: DesignTokens.spacing4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: DesignTokens.fontSizeBase,
                    fontWeight: DesignTokens.fontWeightSemiBold,
                    color: DesignTokens.neutral900,
                  ),
                ),
                const SizedBox(height: DesignTokens.spacing1),
                Text(
                  '$count users (${percentage.toStringAsFixed(1)}%)',
                  style: const TextStyle(
                    fontSize: DesignTokens.fontSizeSm,
                    color: DesignTokens.neutral600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildInsightCard({
    required String title,
    required String description,
    required double confidence,
    required String type,
  }) {
    Color typeColor;
    switch (type) {
      case 'pattern':
        typeColor = DesignTokens.info;
        break;
      case 'performance':
        typeColor = DesignTokens.warning;
        break;
      case 'conversion':
        typeColor = DesignTokens.success;
        break;
      default:
        typeColor = DesignTokens.neutral500;
    }
    
    return Container(
      margin: const EdgeInsets.only(bottom: DesignTokens.spacing3),
      padding: const EdgeInsets.all(DesignTokens.spacing4),
      decoration: BoxDecoration(
        color: typeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
        border: Border.all(color: typeColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb, color: typeColor, size: 20),
              const SizedBox(width: DesignTokens.spacing2),
              Text(
                title,
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeBase,
                  fontWeight: DesignTokens.fontWeightSemiBold,
                  color: typeColor,
                ),
              ),
              const Spacer(),
              Text(
                '${(confidence * 100).toStringAsFixed(0)}% confidence',
                style: const TextStyle(
                  fontSize: DesignTokens.fontSizeSm,
                  color: DesignTokens.neutral600,
                ),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacing2),
          Text(
            description,
            style: const TextStyle(
              fontSize: DesignTokens.fontSizeSm,
              color: DesignTokens.neutral700,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildRecommendationCard({
    required String title,
    required String description,
    required String priority,
    required String impact,
    required String effort,
  }) {
    Color priorityColor;
    switch (priority) {
      case 'high':
        priorityColor = DesignTokens.error;
        break;
      case 'medium':
        priorityColor = DesignTokens.warning;
        break;
      case 'low':
        priorityColor = DesignTokens.info;
        break;
      default:
        priorityColor = DesignTokens.neutral500;
    }
    
    return Container(
      margin: const EdgeInsets.only(bottom: DesignTokens.spacing3),
      padding: const EdgeInsets.all(DesignTokens.spacing4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
        boxShadow: DesignTokens.shadowBase,
        border: Border.all(color: priorityColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: DesignTokens.spacing2,
                  vertical: DesignTokens.spacing1,
                ),
                decoration: BoxDecoration(
                  color: priorityColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
                ),
                child: Text(
                  priority.toUpperCase(),
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeXs,
                    fontWeight: DesignTokens.fontWeightBold,
                    color: priorityColor,
                  ),
                ),
              ),
              const SizedBox(width: DesignTokens.spacing2),
              Text(
                'Impact: $impact',
                style: const TextStyle(
                  fontSize: DesignTokens.fontSizeSm,
                  color: DesignTokens.neutral600,
                ),
              ),
              const SizedBox(width: DesignTokens.spacing2),
              Text(
                'Effort: $effort',
                style: const TextStyle(
                  fontSize: DesignTokens.fontSizeSm,
                  color: DesignTokens.neutral600,
                ),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacing2),
          Text(
            title,
            style: const TextStyle(
              fontSize: DesignTokens.fontSizeBase,
              fontWeight: DesignTokens.fontWeightSemiBold,
              color: DesignTokens.neutral900,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing1),
          Text(
            description,
            style: const TextStyle(
              fontSize: DesignTokens.fontSizeSm,
              color: DesignTokens.neutral700,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildOptimizationCard({
    required String title,
    required String status,
    required double improvement,
    required String description,
  }) {
    Color statusColor;
    IconData statusIcon;
    switch (status) {
      case 'completed':
        statusColor = DesignTokens.success;
        statusIcon = Icons.check_circle;
        break;
      case 'in_progress':
        statusColor = DesignTokens.warning;
        statusIcon = Icons.hourglass_empty;
        break;
      case 'scheduled':
        statusColor = DesignTokens.info;
        statusIcon = Icons.schedule;
        break;
      default:
        statusColor = DesignTokens.neutral500;
        statusIcon = Icons.help;
    }
    
    return Container(
      margin: const EdgeInsets.only(bottom: DesignTokens.spacing3),
      padding: const EdgeInsets.all(DesignTokens.spacing4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
        boxShadow: DesignTokens.shadowBase,
        border: Border.all(color: statusColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(statusIcon, color: statusColor),
          const SizedBox(width: DesignTokens.spacing4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: DesignTokens.fontSizeBase,
                    fontWeight: DesignTokens.fontWeightSemiBold,
                    color: DesignTokens.neutral900,
                  ),
                ),
                const SizedBox(height: DesignTokens.spacing1),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: DesignTokens.fontSizeSm,
                    color: DesignTokens.neutral700,
                  ),
                ),
                if (improvement > 0) ...[
                  const SizedBox(height: DesignTokens.spacing1),
                  Text(
                    '+${improvement.toStringAsFixed(1)}% improvement',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeSm,
                      color: DesignTokens.success,
                      fontWeight: DesignTokens.fontWeightMedium,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  // ============================================================================
  // METHODS
  // ============================================================================
  
  void _loadDashboardData() {
    setState(() {
      _isLoading = true;
    });
    
    // Simulate loading
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
        _dashboardData = widget.initialData ?? {};
      });
    });
  }
  
  void _refreshData() {
    _loadDashboardData();
    widget.onRefresh?.call();
  }
  
  void _onTimeRangeSelected(String timeRange) {
    setState(() {
      _selectedTimeRange = timeRange;
    });
    _refreshData();
  }
  
  void _exportData() {
    // Implement data export
    _logger.info('Exporting analytics data');
  }
  
  void _generateReport() {
    // Implement report generation
    _logger.info('Generating analytics report');
  }
  
  void _scheduleReport() {
    // Implement report scheduling
    _logger.info('Scheduling analytics report');
  }
  
  void _openSettings() {
    // Implement settings
    _logger.info('Opening analytics settings');
  }
}
