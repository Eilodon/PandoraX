/// Analytics Demo for Phase 6 Analytics & Optimization
/// 
/// This demo showcases all Phase 6 features including analytics,
/// A/B testing, performance monitoring, and optimization.
library analytics_demo;

import 'package:flutter/material.dart';
import 'package:core/core.dart';

/// Analytics demo screen showcasing Phase 6 features
class AnalyticsDemo extends StatefulWidget {
  const AnalyticsDemo({super.key});

  @override
  State<AnalyticsDemo> createState() => _AnalyticsDemoState();
}

class _AnalyticsDemoState extends State<AnalyticsDemo> with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  bool _analyticsEnabled = true;
  bool _abTestingEnabled = true;
  bool _performanceMonitoringEnabled = true;
  bool _journeyTrackingEnabled = true;
  bool _optimizationEnabled = true;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    
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
        title: const Text('Phase 6: Analytics & Optimization Demo'),
        backgroundColor: DesignTokens.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _showSettings,
            icon: const Icon(Icons.settings),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.analytics), text: 'Analytics'),
            Tab(icon: Icon(Icons.science), text: 'A/B Testing'),
            Tab(icon: Icon(Icons.speed), text: 'Performance'),
            Tab(icon: Icon(Icons.route), text: 'Journey'),
            Tab(icon: Icon(Icons.tune), text: 'Optimization'),
          ],
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildAnalyticsTab(),
            _buildABTestingTab(),
            _buildPerformanceTab(),
            _buildJourneyTab(),
            _buildOptimizationTab(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(DesignTokens.spacing6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Analytics Overview
          _buildSection(
            title: 'Analytics Overview',
            children: [
              _buildInfoCard(
                title: 'User Behavior Tracking',
                content: 'Track user actions, screen views, and feature usage',
                color: DesignTokens.primary,
                onTap: () => _testUserBehaviorTracking(),
              ),
              _buildInfoCard(
                title: 'Performance Metrics',
                content: 'Monitor app performance and resource usage',
                color: DesignTokens.secondary,
                onTap: () => _testPerformanceMetrics(),
              ),
              _buildInfoCard(
                title: 'Business Metrics',
                content: 'Track conversions, revenue, and engagement',
                color: DesignTokens.info,
                onTap: () => _testBusinessMetrics(),
              ),
              _buildInfoCard(
                title: 'Error Tracking',
                content: 'Monitor errors and crashes for debugging',
                color: DesignTokens.error,
                onTap: () => _testErrorTracking(),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacing8),
          
          // Analytics Features
          _buildSection(
            title: 'Analytics Features',
            children: [
              _buildFeatureCard(
                title: 'Real-time Analytics',
                description: 'Get real-time insights into user behavior',
                icon: Icons.timeline,
                enabled: _analyticsEnabled,
                onToggle: (value) => setState(() => _analyticsEnabled = value),
              ),
              _buildFeatureCard(
                title: 'Custom Events',
                description: 'Track custom events and properties',
                icon: Icons.event,
                enabled: _analyticsEnabled,
                onToggle: (value) => setState(() => _analyticsEnabled = value),
              ),
              _buildFeatureCard(
                title: 'User Segmentation',
                description: 'Segment users based on behavior and demographics',
                icon: Icons.people,
                enabled: _analyticsEnabled,
                onToggle: (value) => setState(() => _analyticsEnabled = value),
              ),
              _buildFeatureCard(
                title: 'Funnel Analysis',
                description: 'Analyze conversion funnels and drop-off points',
                icon: Icons.trending_down,
                enabled: _analyticsEnabled,
                onToggle: (value) => setState(() => _analyticsEnabled = value),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildABTestingTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(DesignTokens.spacing6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // A/B Testing Overview
          _buildSection(
            title: 'A/B Testing Overview',
            children: [
              _buildInfoCard(
                title: 'Experiment Management',
                content: 'Create, manage, and monitor A/B tests',
                color: DesignTokens.primary,
                onTap: () => _testExperimentManagement(),
              ),
              _buildInfoCard(
                title: 'Variant Assignment',
                content: 'Automatically assign users to test variants',
                color: DesignTokens.secondary,
                onTap: () => _testVariantAssignment(),
              ),
              _buildInfoCard(
                title: 'Statistical Analysis',
                content: 'Analyze results with statistical significance',
                color: DesignTokens.info,
                onTap: () => _testStatisticalAnalysis(),
              ),
              _buildInfoCard(
                title: 'Conversion Tracking',
                content: 'Track conversions and measure test impact',
                color: DesignTokens.success,
                onTap: () => _testConversionTracking(),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacing8),
          
          // A/B Testing Features
          _buildSection(
            title: 'A/B Testing Features',
            children: [
              _buildFeatureCard(
                title: 'Multi-variant Testing',
                description: 'Test multiple variants simultaneously',
                icon: Icons.compare_arrows,
                enabled: _abTestingEnabled,
                onToggle: (value) => setState(() => _abTestingEnabled = value),
              ),
              _buildFeatureCard(
                title: 'Segmented Testing',
                description: 'Run tests on specific user segments',
                icon: Icons.group,
                enabled: _abTestingEnabled,
                onToggle: (value) => setState(() => _abTestingEnabled = value),
              ),
              _buildFeatureCard(
                title: 'Automated Testing',
                description: 'Automatically start and stop tests',
                icon: Icons.automation,
                enabled: _abTestingEnabled,
                onToggle: (value) => setState(() => _abTestingEnabled = value),
              ),
              _buildFeatureCard(
                title: 'Real-time Results',
                description: 'View test results in real-time',
                icon: Icons.dashboard,
                enabled: _abTestingEnabled,
                onToggle: (value) => setState(() => _abTestingEnabled = value),
              ),
            ],
          ),
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
          // Performance Overview
          _buildSection(
            title: 'Performance Overview',
            children: [
              _buildInfoCard(
                title: 'Real-time Monitoring',
                content: 'Monitor performance metrics in real-time',
                color: DesignTokens.primary,
                onTap: () => _testRealTimeMonitoring(),
              ),
              _buildInfoCard(
                title: 'Performance Alerts',
                content: 'Get alerts when performance thresholds are exceeded',
                color: DesignTokens.warning,
                onTap: () => _testPerformanceAlerts(),
              ),
              _buildInfoCard(
                title: 'Resource Usage',
                content: 'Track CPU, memory, and network usage',
                color: DesignTokens.info,
                onTap: () => _testResourceUsage(),
              ),
              _buildInfoCard(
                title: 'Optimization Recommendations',
                content: 'Get intelligent optimization suggestions',
                color: DesignTokens.success,
                onTap: () => _testOptimizationRecommendations(),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacing8),
          
          // Performance Features
          _buildSection(
            title: 'Performance Features',
            children: [
              _buildFeatureCard(
                title: 'Performance Dashboard',
                description: 'Comprehensive performance monitoring dashboard',
                icon: Icons.dashboard,
                enabled: _performanceMonitoringEnabled,
                onToggle: (value) => setState(() => _performanceMonitoringEnabled = value),
              ),
              _buildFeatureCard(
                title: 'Performance Trends',
                description: 'Track performance trends over time',
                icon: Icons.trending_up,
                enabled: _performanceMonitoringEnabled,
                onToggle: (value) => setState(() => _performanceMonitoringEnabled = value),
              ),
              _buildFeatureCard(
                title: 'Performance Alerts',
                description: 'Configure and manage performance alerts',
                icon: Icons.notifications,
                enabled: _performanceMonitoringEnabled,
                onToggle: (value) => setState(() => _performanceMonitoringEnabled = value),
              ),
              _buildFeatureCard(
                title: 'Performance Reports',
                description: 'Generate detailed performance reports',
                icon: Icons.assessment,
                enabled: _performanceMonitoringEnabled,
                onToggle: (value) => setState(() => _performanceMonitoringEnabled = value),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildJourneyTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(DesignTokens.spacing6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Journey Overview
          _buildSection(
            title: 'User Journey Overview',
            children: [
              _buildInfoCard(
                title: 'Journey Mapping',
                content: 'Map complete user journeys and flows',
                color: DesignTokens.primary,
                onTap: () => _testJourneyMapping(),
              ),
              _buildInfoCard(
                title: 'Conversion Funnels',
                content: 'Analyze conversion funnels and drop-off points',
                color: DesignTokens.secondary,
                onTap: () => _testConversionFunnels(),
              ),
              _buildInfoCard(
                title: 'Journey Analytics',
                content: 'Get insights into user journey patterns',
                color: DesignTokens.info,
                onTap: () => _testJourneyAnalytics(),
              ),
              _buildInfoCard(
                title: 'Journey Optimization',
                content: 'Optimize user journeys for better conversion',
                color: DesignTokens.success,
                onTap: () => _testJourneyOptimization(),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacing8),
          
          // Journey Features
          _buildSection(
            title: 'Journey Features',
            children: [
              _buildFeatureCard(
                title: 'Journey Visualization',
                description: 'Visualize user journeys with flow diagrams',
                icon: Icons.account_tree,
                enabled: _journeyTrackingEnabled,
                onToggle: (value) => setState(() => _journeyTrackingEnabled = value),
              ),
              _buildFeatureCard(
                title: 'Journey Segmentation',
                description: 'Segment users based on journey patterns',
                icon: Icons.group_work,
                enabled: _journeyTrackingEnabled,
                onToggle: (value) => setState(() => _journeyTrackingEnabled = value),
              ),
              _buildFeatureCard(
                title: 'Journey Heatmaps',
                description: 'Create heatmaps of user journey activity',
                icon: Icons.heat_pump,
                enabled: _journeyTrackingEnabled,
                onToggle: (value) => setState(() => _journeyTrackingEnabled = value),
              ),
              _buildFeatureCard(
                title: 'Journey Insights',
                description: 'Get AI-powered journey insights',
                icon: Icons.lightbulb,
                enabled: _journeyTrackingEnabled,
                onToggle: (value) => setState(() => _journeyTrackingEnabled = value),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildOptimizationTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(DesignTokens.spacing6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Optimization Overview
          _buildSection(
            title: 'Optimization Overview',
            children: [
              _buildInfoCard(
                title: 'Intelligent Optimization',
                content: 'AI-powered optimization recommendations',
                color: DesignTokens.primary,
                onTap: () => _testIntelligentOptimization(),
              ),
              _buildInfoCard(
                title: 'Performance Optimization',
                content: 'Optimize app performance automatically',
                color: DesignTokens.secondary,
                onTap: () => _testPerformanceOptimization(),
              ),
              _buildInfoCard(
                title: 'UX Optimization',
                content: 'Optimize user experience and flow',
                color: DesignTokens.info,
                onTap: () => _testUXOptimization(),
              ),
              _buildInfoCard(
                title: 'Business Optimization',
                content: 'Optimize business metrics and conversion',
                color: DesignTokens.success,
                onTap: () => _testBusinessOptimization(),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacing8),
          
          // Optimization Features
          _buildSection(
            title: 'Optimization Features',
            children: [
              _buildFeatureCard(
                title: 'Automated Optimization',
                description: 'Automatically apply optimization strategies',
                icon: Icons.automation,
                enabled: _optimizationEnabled,
                onToggle: (value) => setState(() => _optimizationEnabled = value),
              ),
              _buildFeatureCard(
                title: 'Optimization Monitoring',
                description: 'Monitor optimization progress and results',
                icon: Icons.monitor,
                enabled: _optimizationEnabled,
                onToggle: (value) => setState(() => _optimizationEnabled = value),
              ),
              _buildFeatureCard(
                title: 'ROI Analysis',
                description: 'Analyze optimization return on investment',
                icon: Icons.attach_money,
                enabled: _optimizationEnabled,
                onToggle: (value) => setState(() => _optimizationEnabled = value),
              ),
              _buildFeatureCard(
                title: 'Optimization History',
                description: 'Track optimization history and results',
                icon: Icons.history,
                enabled: _optimizationEnabled,
                onToggle: (value) => setState(() => _optimizationEnabled = value),
              ),
            ],
          ),
        ],
      ),
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
  
  Widget _buildInfoCard({
    required String title,
    required String content,
    required Color color,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: DesignTokens.spacing3),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
          child: Container(
            padding: const EdgeInsets.all(DesignTokens.spacing4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color,
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
                        content,
                        style: const TextStyle(
                          fontSize: DesignTokens.fontSizeSm,
                          color: DesignTokens.neutral600,
                        ),
                      ),
                    ],
                  ),
                ),
                if (onTap != null)
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: color,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildFeatureCard({
    required String title,
    required String description,
    required IconData icon,
    required bool enabled,
    required ValueChanged<bool> onToggle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: DesignTokens.spacing3),
      padding: const EdgeInsets.all(DesignTokens.spacing4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
        boxShadow: DesignTokens.shadowBase,
        border: Border.all(
          color: enabled ? DesignTokens.primary : DesignTokens.neutral200,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(DesignTokens.spacing3),
            decoration: BoxDecoration(
              color: enabled ? DesignTokens.primary.withOpacity(0.1) : DesignTokens.neutral100,
              borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
            ),
            child: Icon(
              icon,
              color: enabled ? DesignTokens.primary : DesignTokens.neutral500,
            ),
          ),
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
                    color: enabled ? DesignTokens.neutral900 : DesignTokens.neutral500,
                  ),
                ),
                const SizedBox(height: DesignTokens.spacing1),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeSm,
                    color: enabled ? DesignTokens.neutral600 : DesignTokens.neutral400,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: enabled,
            onChanged: onToggle,
            activeColor: DesignTokens.primary,
          ),
        ],
      ),
    );
  }
  
  // ============================================================================
  // TEST METHODS
  // ============================================================================
  
  void _testUserBehaviorTracking() {
    AnalyticsService.instance.trackUserAction('demo_interaction', {
      'feature': 'analytics_demo',
      'action': 'user_behavior_tracking_test',
      'timestamp': DateTime.now().toIso8601String(),
    });
    _showSnackBar('User behavior tracking test completed');
  }
  
  void _testPerformanceMetrics() {
    AnalyticsService.instance.trackPerformance('demo_metric', 85.5, context: {
      'test_type': 'performance_metrics_test',
    });
    _showSnackBar('Performance metrics test completed');
  }
  
  void _testBusinessMetrics() {
    AnalyticsService.instance.trackConversion('demo_conversion', 1.0, context: {
      'test_type': 'business_metrics_test',
    });
    _showSnackBar('Business metrics test completed');
  }
  
  void _testErrorTracking() {
    AnalyticsService.instance.trackError('Demo error for testing', 'Stack trace here', context: {
      'test_type': 'error_tracking_test',
    });
    _showSnackBar('Error tracking test completed');
  }
  
  void _testExperimentManagement() {
    ABTestingService.instance.createExperiment(
      experimentId: 'demo_experiment',
      name: 'Demo Experiment',
      description: 'A demo experiment for testing',
      variants: ['control', 'variant_a', 'variant_b'],
      metric: 'conversion_rate',
    );
    _showSnackBar('Experiment management test completed');
  }
  
  void _testVariantAssignment() {
    final variant = ABTestingService.instance.getVariant('demo_experiment', 'user123');
    _showSnackBar('Variant assignment test completed: $variant');
  }
  
  void _testStatisticalAnalysis() {
    final significance = ABTestingService.instance.getStatisticalSignificance('demo_experiment');
    _showSnackBar('Statistical analysis test completed: ${significance.toStringAsFixed(2)}');
  }
  
  void _testConversionTracking() {
    ABTestingService.instance.trackConversion('demo_experiment', 'user123', 'demo_conversion', 1.0);
    _showSnackBar('Conversion tracking test completed');
  }
  
  void _testRealTimeMonitoring() {
    PerformanceMonitoringService.instance.trackAppStartup(const Duration(milliseconds: 1200));
    _showSnackBar('Real-time monitoring test completed');
  }
  
  void _testPerformanceAlerts() {
    PerformanceMonitoringService.instance.trackMemoryUsage(95);
    _showSnackBar('Performance alerts test completed');
  }
  
  void _testResourceUsage() {
    PerformanceMonitoringService.instance.trackCpuUsage(75.5);
    _showSnackBar('Resource usage test completed');
  }
  
  void _testOptimizationRecommendations() {
    final recommendations = PerformanceMonitoringService.instance.getOptimizationRecommendations();
    _showSnackBar('Optimization recommendations test completed: ${recommendations.length} recommendations');
  }
  
  void _testJourneyMapping() {
    UserJourneyService.instance.trackJourneyStart('demo_journey', {
      'journey_type': 'demo',
      'user_id': 'user123',
    });
    _showSnackBar('Journey mapping test completed');
  }
  
  void _testConversionFunnels() {
    UserJourneyService.instance.trackJourneyConversion('demo_journey', 'demo_conversion', 1.0);
    _showSnackBar('Conversion funnels test completed');
  }
  
  void _testJourneyAnalytics() {
    final insights = UserJourneyService.instance.getUserJourneyInsights();
    _showSnackBar('Journey analytics test completed: ${insights.length} insights');
  }
  
  void _testJourneyOptimization() {
    final recommendations = UserJourneyService.instance.getJourneyOptimizationRecommendations('demo_journey');
    _showSnackBar('Journey optimization test completed: ${recommendations.length} recommendations');
  }
  
  void _testIntelligentOptimization() {
    final suggestions = OptimizationEngine.instance.getIntelligentOptimizationSuggestions();
    _showSnackBar('Intelligent optimization test completed: ${suggestions.length} suggestions');
  }
  
  void _testPerformanceOptimization() {
    OptimizationEngine.instance.applyAutomatedOptimization('performance');
    _showSnackBar('Performance optimization test completed');
  }
  
  void _testUXOptimization() {
    OptimizationEngine.instance.applyAutomatedOptimization('ux');
    _showSnackBar('UX optimization test completed');
  }
  
  void _testBusinessOptimization() {
    OptimizationEngine.instance.applyAutomatedOptimization('business');
    _showSnackBar('Business optimization test completed');
  }
  
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
  
  void _showSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Analytics Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: const Text('Analytics'),
              subtitle: const Text('Enable analytics tracking'),
              value: _analyticsEnabled,
              onChanged: (value) => setState(() => _analyticsEnabled = value),
            ),
            SwitchListTile(
              title: const Text('A/B Testing'),
              subtitle: const Text('Enable A/B testing'),
              value: _abTestingEnabled,
              onChanged: (value) => setState(() => _abTestingEnabled = value),
            ),
            SwitchListTile(
              title: const Text('Performance Monitoring'),
              subtitle: const Text('Enable performance monitoring'),
              value: _performanceMonitoringEnabled,
              onChanged: (value) => setState(() => _performanceMonitoringEnabled = value),
            ),
            SwitchListTile(
              title: const Text('Journey Tracking'),
              subtitle: const Text('Enable journey tracking'),
              value: _journeyTrackingEnabled,
              onChanged: (value) => setState(() => _journeyTrackingEnabled = value),
            ),
            SwitchListTile(
              title: const Text('Optimization'),
              subtitle: const Text('Enable optimization engine'),
              value: _optimizationEnabled,
              onChanged: (value) => setState(() => _optimizationEnabled = value),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
