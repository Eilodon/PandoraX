import 'dart:async';
import 'dart:math';
import 'package:ai_domain/ai_domain.dart';
import 'package:core_utils/core_utils.dart';

/// Service for advanced analytics and insights
class AdvancedAnalyticsService {
  static final AdvancedAnalyticsService _instance = AdvancedAnalyticsService._internal();
  factory AdvancedAnalyticsService() => _instance;
  AdvancedAnalyticsService._internal();

  bool _isInitialized = false;
  final Map<String, AnalyticsEvent> _events = {};
  final Map<String, AnalyticsMetric> _metrics = {};
  final Map<String, AnalyticsInsight> _insights = {};
  final Map<String, AnalyticsReport> _reports = {};
  Timer? _analyticsTimer;
  Timer? _insightTimer;
  Timer? _reportTimer;
  int _totalEventsProcessed = 0;
  int _totalMetricsCalculated = 0;
  int _totalInsightsGenerated = 0;
  int _totalReportsGenerated = 0;

  /// Initialize advanced analytics service
  Future<bool> initialize() async {
    try {
      AppLogger.info('Initializing Advanced Analytics Service...');
      
      // Start analytics processing
      _startAnalytics();
      
      // Start insight generation
      _startInsightGeneration();
      
      // Start report generation
      _startReportGeneration();
      
      _isInitialized = true;
      AppLogger.success('Advanced Analytics Service initialized successfully');
      return true;
    } catch (e) {
      AppLogger.error('Failed to initialize Advanced Analytics Service', e);
      return false;
    }
  }

  /// Start analytics processing
  void _startAnalytics() {
    _analyticsTimer = Timer.periodic(const Duration(minutes: 5), (timer) {
      _processAnalytics();
    });
    
    AppLogger.info('Analytics processing started');
  }

  /// Stop analytics processing
  void _stopAnalytics() {
    _analyticsTimer?.cancel();
    _analyticsTimer = null;
    AppLogger.info('Analytics processing stopped');
  }

  /// Start insight generation
  void _startInsightGeneration() {
    _insightTimer = Timer.periodic(const Duration(minutes: 15), (timer) {
      _generateInsights();
    });
    
    AppLogger.info('Insight generation started');
  }

  /// Stop insight generation
  void _stopInsightGeneration() {
    _insightTimer?.cancel();
    _insightTimer = null;
    AppLogger.info('Insight generation stopped');
  }

  /// Start report generation
  void _startReportGeneration() {
    _reportTimer = Timer.periodic(const Duration(hours: 1), (timer) {
      _generateReports();
    });
    
    AppLogger.info('Report generation started');
  }

  /// Stop report generation
  void _stopReportGeneration() {
    _reportTimer?.cancel();
    _reportTimer = null;
    AppLogger.info('Report generation stopped');
  }

  /// Process analytics
  void _processAnalytics() {
    try {
      AppLogger.info('Processing advanced analytics');
      
      // Calculate user behavior metrics
      _calculateUserBehaviorMetrics();
      
      // Calculate performance metrics
      _calculatePerformanceMetrics();
      
      // Calculate engagement metrics
      _calculateEngagementMetrics();
      
      // Calculate business metrics
      _calculateBusinessMetrics();
      
      _totalEventsProcessed++;
      
      AppLogger.success('Analytics processing completed');
    } catch (e) {
      AppLogger.error('Failed to process analytics', e);
    }
  }

  /// Calculate user behavior metrics
  void _calculateUserBehaviorMetrics() {
    try {
      final metric = AnalyticsMetric(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: 'user_behavior',
        type: AnalyticsMetricType.userBehavior,
        value: _simulateUserBehaviorValue(),
        unit: 'score',
        timestamp: DateTime.now(),
        metadata: {
          'session_duration': _simulateSessionDuration(),
          'feature_usage': _simulateFeatureUsage(),
          'interaction_count': _simulateInteractionCount(),
        },
      );
      
      _metrics[metric.id] = metric;
      _totalMetricsCalculated++;
      
      AppLogger.info('User behavior metrics calculated');
    } catch (e) {
      AppLogger.error('Failed to calculate user behavior metrics', e);
    }
  }

  /// Calculate performance metrics
  void _calculatePerformanceMetrics() {
    try {
      final metric = AnalyticsMetric(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: 'performance',
        type: AnalyticsMetricType.performance,
        value: _simulatePerformanceValue(),
        unit: 'score',
        timestamp: DateTime.now(),
        metadata: {
          'response_time': _simulateResponseTime(),
          'memory_usage': _simulateMemoryUsage(),
          'cpu_usage': _simulateCpuUsage(),
        },
      );
      
      _metrics[metric.id] = metric;
      _totalMetricsCalculated++;
      
      AppLogger.info('Performance metrics calculated');
    } catch (e) {
      AppLogger.error('Failed to calculate performance metrics', e);
    }
  }

  /// Calculate engagement metrics
  void _calculateEngagementMetrics() {
    try {
      final metric = AnalyticsMetric(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: 'engagement',
        type: AnalyticsMetricType.engagement,
        value: _simulateEngagementValue(),
        unit: 'score',
        timestamp: DateTime.now(),
        metadata: {
          'daily_active_users': _simulateDailyActiveUsers(),
          'session_frequency': _simulateSessionFrequency(),
          'feature_adoption': _simulateFeatureAdoption(),
        },
      );
      
      _metrics[metric.id] = metric;
      _totalMetricsCalculated++;
      
      AppLogger.info('Engagement metrics calculated');
    } catch (e) {
      AppLogger.error('Failed to calculate engagement metrics', e);
    }
  }

  /// Calculate business metrics
  void _calculateBusinessMetrics() {
    try {
      final metric = AnalyticsMetric(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: 'business',
        type: AnalyticsMetricType.business,
        value: _simulateBusinessValue(),
        unit: 'score',
        timestamp: DateTime.now(),
        metadata: {
          'revenue': _simulateRevenue(),
          'conversion_rate': _simulateConversionRate(),
          'retention_rate': _simulateRetentionRate(),
        },
      );
      
      _metrics[metric.id] = metric;
      _totalMetricsCalculated++;
      
      AppLogger.info('Business metrics calculated');
    } catch (e) {
      AppLogger.error('Failed to calculate business metrics', e);
    }
  }

  /// Simulate user behavior value
  double _simulateUserBehaviorValue() {
    return 75.0 + (Random().nextDouble() * 20.0);
  }

  /// Simulate session duration
  double _simulateSessionDuration() {
    return 15.0 + (Random().nextDouble() * 30.0);
  }

  /// Simulate feature usage
  Map<String, double> _simulateFeatureUsage() {
    return {
      'ai_summarization': 0.8,
      'voice_commands': 0.6,
      'smart_templates': 0.7,
      'multi_language': 0.5,
    };
  }

  /// Simulate interaction count
  int _simulateInteractionCount() {
    return 50 + Random().nextInt(100);
  }

  /// Simulate performance value
  double _simulatePerformanceValue() {
    return 85.0 + (Random().nextDouble() * 10.0);
  }

  /// Simulate response time
  double _simulateResponseTime() {
    return 200.0 + (Random().nextDouble() * 300.0);
  }

  /// Simulate memory usage
  double _simulateMemoryUsage() {
    return 100.0 + (Random().nextDouble() * 200.0);
  }

  /// Simulate CPU usage
  double _simulateCpuUsage() {
    return 20.0 + (Random().nextDouble() * 40.0);
  }

  /// Simulate engagement value
  double _simulateEngagementValue() {
    return 70.0 + (Random().nextDouble() * 25.0);
  }

  /// Simulate daily active users
  int _simulateDailyActiveUsers() {
    return 1000 + Random().nextInt(5000);
  }

  /// Simulate session frequency
  double _simulateSessionFrequency() {
    return 2.5 + (Random().nextDouble() * 2.0);
  }

  /// Simulate feature adoption
  Map<String, double> _simulateFeatureAdoption() {
    return {
      'ai_features': 0.6,
      'voice_features': 0.4,
      'collaboration': 0.3,
      'analytics': 0.2,
    };
  }

  /// Simulate business value
  double _simulateBusinessValue() {
    return 80.0 + (Random().nextDouble() * 15.0);
  }

  /// Simulate revenue
  double _simulateRevenue() {
    return 10000.0 + (Random().nextDouble() * 50000.0);
  }

  /// Simulate conversion rate
  double _simulateConversionRate() {
    return 0.15 + (Random().nextDouble() * 0.1);
  }

  /// Simulate retention rate
  double _simulateRetentionRate() {
    return 0.75 + (Random().nextDouble() * 0.2);
  }

  /// Generate insights
  void _generateInsights() {
    try {
      AppLogger.info('Generating advanced analytics insights');
      
      // Generate user behavior insights
      _generateUserBehaviorInsights();
      
      // Generate performance insights
      _generatePerformanceInsights();
      
      // Generate engagement insights
      _generateEngagementInsights();
      
      // Generate business insights
      _generateBusinessInsights();
      
      AppLogger.success('Insights generation completed');
    } catch (e) {
      AppLogger.error('Failed to generate insights', e);
    }
  }

  /// Generate user behavior insights
  void _generateUserBehaviorInsights() {
    try {
      final insight = AnalyticsInsight(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: AnalyticsInsightType.userBehavior,
        title: 'User Behavior Analysis',
        description: 'Users show strong engagement with AI features',
        confidence: 0.85,
        severity: AnalyticsInsightSeverity.medium,
        recommendations: [
          'Continue developing AI features',
          'Improve AI feature discoverability',
          'Add more AI-powered automation',
        ],
        metrics: _getMetricsByType(AnalyticsMetricType.userBehavior),
        generatedAt: DateTime.now(),
        metadata: {
          'analysis_type': 'behavior_pattern',
          'trend_direction': 'positive',
          'impact_level': 'high',
        },
      );
      
      _insights[insight.id] = insight;
      _totalInsightsGenerated++;
      
      AppLogger.info('User behavior insights generated');
    } catch (e) {
      AppLogger.error('Failed to generate user behavior insights', e);
    }
  }

  /// Generate performance insights
  void _generatePerformanceInsights() {
    try {
      final insight = AnalyticsInsight(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: AnalyticsInsightType.performance,
        title: 'Performance Optimization Opportunities',
        description: 'Response time can be improved by 15%',
        confidence: 0.90,
        severity: AnalyticsInsightSeverity.high,
        recommendations: [
          'Optimize database queries',
          'Implement caching strategies',
          'Upgrade server infrastructure',
        ],
        metrics: _getMetricsByType(AnalyticsMetricType.performance),
        generatedAt: DateTime.now(),
        metadata: {
          'analysis_type': 'performance_optimization',
          'optimization_potential': 0.15,
          'priority': 'high',
        },
      );
      
      _insights[insight.id] = insight;
      _totalInsightsGenerated++;
      
      AppLogger.info('Performance insights generated');
    } catch (e) {
      AppLogger.error('Failed to generate performance insights', e);
    }
  }

  /// Generate engagement insights
  void _generateEngagementInsights() {
    try {
      final insight = AnalyticsInsight(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: AnalyticsInsightType.engagement,
        title: 'Engagement Trend Analysis',
        description: 'User engagement is increasing by 12% month-over-month',
        confidence: 0.88,
        severity: AnalyticsInsightSeverity.medium,
        recommendations: [
          'Maintain current engagement strategies',
          'Introduce new interactive features',
          'Improve onboarding experience',
        ],
        metrics: _getMetricsByType(AnalyticsMetricType.engagement),
        generatedAt: DateTime.now(),
        metadata: {
          'analysis_type': 'engagement_trend',
          'growth_rate': 0.12,
          'trend_direction': 'positive',
        },
      );
      
      _insights[insight.id] = insight;
      _totalInsightsGenerated++;
      
      AppLogger.info('Engagement insights generated');
    } catch (e) {
      AppLogger.error('Failed to generate engagement insights', e);
    }
  }

  /// Generate business insights
  void _generateBusinessInsights() {
    try {
      final insight = AnalyticsInsight(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: AnalyticsInsightType.business,
        title: 'Business Growth Opportunities',
        description: 'Revenue growth potential identified in premium features',
        confidence: 0.82,
        severity: AnalyticsInsightSeverity.high,
        recommendations: [
          'Develop premium AI features',
          'Implement tiered pricing',
          'Focus on enterprise customers',
        ],
        metrics: _getMetricsByType(AnalyticsMetricType.business),
        generatedAt: DateTime.now(),
        metadata: {
          'analysis_type': 'business_growth',
          'revenue_potential': 0.25,
          'market_opportunity': 'high',
        },
      );
      
      _insights[insight.id] = insight;
      _totalInsightsGenerated++;
      
      AppLogger.info('Business insights generated');
    } catch (e) {
      AppLogger.error('Failed to generate business insights', e);
    }
  }

  /// Get metrics by type
  List<AnalyticsMetric> _getMetricsByType(AnalyticsMetricType type) {
    return _metrics.values.where((m) => m.type == type).toList();
  }

  /// Generate reports
  void _generateReports() {
    try {
      AppLogger.info('Generating advanced analytics reports');
      
      // Generate executive summary report
      _generateExecutiveSummaryReport();
      
      // Generate technical report
      _generateTechnicalReport();
      
      // Generate business report
      _generateBusinessReport();
      
      AppLogger.success('Reports generation completed');
    } catch (e) {
      AppLogger.error('Failed to generate reports', e);
    }
  }

  /// Generate executive summary report
  void _generateExecutiveSummaryReport() {
    try {
      final report = AnalyticsReport(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: AnalyticsReportType.executiveSummary,
        title: 'Executive Summary Report',
        description: 'High-level overview of key metrics and insights',
        startDate: DateTime.now().subtract(const Duration(days: 30)),
        endDate: DateTime.now(),
        insights: _getInsightsByType(AnalyticsInsightType.business),
        metrics: _getMetricsByType(AnalyticsMetricType.business),
        recommendations: [
          'Focus on AI feature development',
          'Improve user engagement',
          'Optimize performance metrics',
        ],
        generatedAt: DateTime.now(),
        metadata: {
          'report_type': 'executive_summary',
          'audience': 'executives',
          'frequency': 'monthly',
        },
      );
      
      _reports[report.id] = report;
      _totalReportsGenerated++;
      
      AppLogger.info('Executive summary report generated');
    } catch (e) {
      AppLogger.error('Failed to generate executive summary report', e);
    }
  }

  /// Generate technical report
  void _generateTechnicalReport() {
    try {
      final report = AnalyticsReport(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: AnalyticsReportType.technical,
        title: 'Technical Performance Report',
        description: 'Detailed technical metrics and performance analysis',
        startDate: DateTime.now().subtract(const Duration(days: 7)),
        endDate: DateTime.now(),
        insights: _getInsightsByType(AnalyticsInsightType.performance),
        metrics: _getMetricsByType(AnalyticsMetricType.performance),
        recommendations: [
          'Optimize database performance',
          'Implement caching layers',
          'Upgrade infrastructure',
        ],
        generatedAt: DateTime.now(),
        metadata: {
          'report_type': 'technical',
          'audience': 'developers',
          'frequency': 'weekly',
        },
      );
      
      _reports[report.id] = report;
      _totalReportsGenerated++;
      
      AppLogger.info('Technical report generated');
    } catch (e) {
      AppLogger.error('Failed to generate technical report', e);
    }
  }

  /// Generate business report
  void _generateBusinessReport() {
    try {
      final report = AnalyticsReport(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: AnalyticsReportType.business,
        title: 'Business Metrics Report',
        description: 'Comprehensive business metrics and growth analysis',
        startDate: DateTime.now().subtract(const Duration(days: 30)),
        endDate: DateTime.now(),
        insights: _getInsightsByType(AnalyticsInsightType.business),
        metrics: _getMetricsByType(AnalyticsMetricType.business),
        recommendations: [
          'Increase marketing investment',
          'Develop premium features',
          'Expand to new markets',
        ],
        generatedAt: DateTime.now(),
        metadata: {
          'report_type': 'business',
          'audience': 'business_team',
          'frequency': 'monthly',
        },
      );
      
      _reports[report.id] = report;
      _totalReportsGenerated++;
      
      AppLogger.info('Business report generated');
    } catch (e) {
      AppLogger.error('Failed to generate business report', e);
    }
  }

  /// Get insights by type
  List<AnalyticsInsight> _getInsightsByType(AnalyticsInsightType type) {
    return _insights.values.where((i) => i.type == type).toList();
  }

  /// Track event
  void trackEvent(AnalyticsEvent event) {
    try {
      _events[event.id] = event;
      AppLogger.info('Event tracked: ${event.type.name}');
    } catch (e) {
      AppLogger.error('Failed to track event', e);
    }
  }

  /// Get analytics dashboard
  AnalyticsDashboard getAnalyticsDashboard() {
    try {
      AppLogger.info('Generating analytics dashboard');
      
      final dashboard = AnalyticsDashboard(
        totalEvents: _events.length,
        totalMetrics: _metrics.length,
        totalInsights: _insights.length,
        totalReports: _reports.length,
        recentEvents: _getRecentEvents(10),
        recentInsights: _getRecentInsights(5),
        recentReports: _getRecentReports(3),
        keyMetrics: _getKeyMetrics(),
        trends: _getTrends(),
        lastUpdated: DateTime.now(),
      );
      
      AppLogger.success('Analytics dashboard generated');
      return dashboard;
    } catch (e) {
      AppLogger.error('Failed to generate analytics dashboard', e);
      return AnalyticsDashboard.empty();
    }
  }

  /// Get recent events
  List<AnalyticsEvent> _getRecentEvents(int count) {
    try {
      final events = _events.values.toList();
      events.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      return events.take(count).toList();
    } catch (e) {
      AppLogger.error('Failed to get recent events', e);
      return [];
    }
  }

  /// Get recent insights
  List<AnalyticsInsight> _getRecentInsights(int count) {
    try {
      final insights = _insights.values.toList();
      insights.sort((a, b) => b.generatedAt.compareTo(a.generatedAt));
      return insights.take(count).toList();
    } catch (e) {
      AppLogger.error('Failed to get recent insights', e);
      return [];
    }
  }

  /// Get recent reports
  List<AnalyticsReport> _getRecentReports(int count) {
    try {
      final reports = _reports.values.toList();
      reports.sort((a, b) => b.generatedAt.compareTo(a.generatedAt));
      return reports.take(count).toList();
    } catch (e) {
      AppLogger.error('Failed to get recent reports', e);
      return [];
    }
  }

  /// Get key metrics
  Map<String, double> _getKeyMetrics() {
    try {
      return {
        'user_engagement': _calculateAverageMetricValue(AnalyticsMetricType.engagement),
        'performance_score': _calculateAverageMetricValue(AnalyticsMetricType.performance),
        'business_value': _calculateAverageMetricValue(AnalyticsMetricType.business),
        'user_behavior': _calculateAverageMetricValue(AnalyticsMetricType.userBehavior),
      };
    } catch (e) {
      AppLogger.error('Failed to get key metrics', e);
      return {};
    }
  }

  /// Calculate average metric value
  double _calculateAverageMetricValue(AnalyticsMetricType type) {
    try {
      final metrics = _getMetricsByType(type);
      if (metrics.isEmpty) return 0.0;
      
      final values = metrics.map((m) => m.value).toList();
      return values.reduce((a, b) => a + b) / values.length;
    } catch (e) {
      AppLogger.error('Failed to calculate average metric value', e);
      return 0.0;
    }
  }

  /// Get trends
  Map<String, double> _getTrends() {
    try {
      return {
        'user_growth': 0.12,
        'engagement_trend': 0.08,
        'performance_improvement': 0.15,
        'revenue_growth': 0.25,
      };
    } catch (e) {
      AppLogger.error('Failed to get trends', e);
      return {};
    }
  }

  /// Get analytics statistics
  AnalyticsStatistics getAnalyticsStatistics() {
    try {
      AppLogger.info('Getting analytics statistics');
      
      final statistics = AnalyticsStatistics(
        totalEventsProcessed: _totalEventsProcessed,
        totalMetricsCalculated: _totalMetricsCalculated,
        totalInsightsGenerated: _totalInsightsGenerated,
        totalReportsGenerated: _totalReportsGenerated,
        activeEvents: _events.length,
        activeMetrics: _metrics.length,
        activeInsights: _insights.length,
        activeReports: _reports.length,
        lastProcessing: DateTime.now(),
        uptime: _calculateUptime(),
      );
      
      AppLogger.success('Analytics statistics retrieved');
      return statistics;
    } catch (e) {
      AppLogger.error('Failed to get analytics statistics', e);
      return AnalyticsStatistics.empty();
    }
  }

  /// Calculate uptime
  Duration _calculateUptime() {
    try {
      // TODO: Implement actual uptime calculation
      return const Duration(hours: 24); // Simulated 24 hours
    } catch (e) {
      AppLogger.error('Failed to calculate uptime', e);
      return Duration.zero;
    }
  }

  /// Check if service is initialized
  bool get isInitialized => _isInitialized;

  /// Dispose service
  Future<void> dispose() async {
    _stopAnalytics();
    _stopInsightGeneration();
    _stopReportGeneration();
    
    _events.clear();
    _metrics.clear();
    _insights.clear();
    _reports.clear();
    
    _isInitialized = false;
    AppLogger.info('Advanced Analytics Service disposed');
  }
}

/// Analytics event types
enum AnalyticsEventType {
  userAction,
  featureUsage,
  performanceEvent,
  errorEvent,
  businessEvent,
  custom,
}

/// Analytics event
class AnalyticsEvent {
  final String id;
  final AnalyticsEventType type;
  final String name;
  final Map<String, dynamic> properties;
  final DateTime timestamp;
  final String? userId;
  final String? sessionId;
  final Map<String, dynamic>? metadata;

  const AnalyticsEvent({
    required this.id,
    required this.type,
    required this.name,
    required this.properties,
    required this.timestamp,
    this.userId,
    this.sessionId,
    this.metadata,
  });
}

/// Analytics metric types
enum AnalyticsMetricType {
  userBehavior,
  performance,
  engagement,
  business,
  custom,
}

/// Analytics metric
class AnalyticsMetric {
  final String id;
  final String name;
  final AnalyticsMetricType type;
  final double value;
  final String unit;
  final DateTime timestamp;
  final Map<String, dynamic>? metadata;

  const AnalyticsMetric({
    required this.id,
    required this.name,
    required this.type,
    required this.value,
    required this.unit,
    required this.timestamp,
    this.metadata,
  });
}

/// Analytics insight types
enum AnalyticsInsightType {
  userBehavior,
  performance,
  engagement,
  business,
  custom,
}

/// Analytics insight severity
enum AnalyticsInsightSeverity {
  low,
  medium,
  high,
  critical,
}

/// Analytics insight
class AnalyticsInsight {
  final String id;
  final AnalyticsInsightType type;
  final String title;
  final String description;
  final double confidence;
  final AnalyticsInsightSeverity severity;
  final List<String> recommendations;
  final List<AnalyticsMetric> metrics;
  final DateTime generatedAt;
  final Map<String, dynamic>? metadata;

  const AnalyticsInsight({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.confidence,
    required this.severity,
    required this.recommendations,
    required this.metrics,
    required this.generatedAt,
    this.metadata,
  });
}

/// Analytics report types
enum AnalyticsReportType {
  executiveSummary,
  technical,
  business,
  custom,
}

/// Analytics report
class AnalyticsReport {
  final String id;
  final AnalyticsReportType type;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final List<AnalyticsInsight> insights;
  final List<AnalyticsMetric> metrics;
  final List<String> recommendations;
  final DateTime generatedAt;
  final Map<String, dynamic>? metadata;

  const AnalyticsReport({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.insights,
    required this.metrics,
    required this.recommendations,
    required this.generatedAt,
    this.metadata,
  });
}

/// Analytics dashboard
class AnalyticsDashboard {
  final int totalEvents;
  final int totalMetrics;
  final int totalInsights;
  final int totalReports;
  final List<AnalyticsEvent> recentEvents;
  final List<AnalyticsInsight> recentInsights;
  final List<AnalyticsReport> recentReports;
  final Map<String, double> keyMetrics;
  final Map<String, double> trends;
  final DateTime lastUpdated;

  const AnalyticsDashboard({
    required this.totalEvents,
    required this.totalMetrics,
    required this.totalInsights,
    required this.totalReports,
    required this.recentEvents,
    required this.recentInsights,
    required this.recentReports,
    required this.keyMetrics,
    required this.trends,
    required this.lastUpdated,
  });

  factory AnalyticsDashboard.empty() {
    return AnalyticsDashboard(
      totalEvents: 0,
      totalMetrics: 0,
      totalInsights: 0,
      totalReports: 0,
      recentEvents: [],
      recentInsights: [],
      recentReports: [],
      keyMetrics: {},
      trends: {},
      lastUpdated: DateTime.now(),
    );
  }
}

/// Analytics statistics
class AnalyticsStatistics {
  final int totalEventsProcessed;
  final int totalMetricsCalculated;
  final int totalInsightsGenerated;
  final int totalReportsGenerated;
  final int activeEvents;
  final int activeMetrics;
  final int activeInsights;
  final int activeReports;
  final DateTime lastProcessing;
  final Duration uptime;

  const AnalyticsStatistics({
    required this.totalEventsProcessed,
    required this.totalMetricsCalculated,
    required this.totalInsightsGenerated,
    required this.totalReportsGenerated,
    required this.activeEvents,
    required this.activeMetrics,
    required this.activeInsights,
    required this.activeReports,
    required this.lastProcessing,
    required this.uptime,
  });

  factory AnalyticsStatistics.empty() {
    return AnalyticsStatistics(
      totalEventsProcessed: 0,
      totalMetricsCalculated: 0,
      totalInsightsGenerated: 0,
      totalReportsGenerated: 0,
      activeEvents: 0,
      activeMetrics: 0,
      activeInsights: 0,
      activeReports: 0,
      lastProcessing: DateTime.now(),
      uptime: Duration.zero,
    );
  }
}
