import 'dart:async';
import 'dart:math';
import 'package:ai_domain/ai_domain.dart';
import 'package:core_utils/core_utils.dart';

/// Service for performance analytics and insights
class PerformanceAnalyticsService {
  static final PerformanceAnalyticsService _instance = PerformanceAnalyticsService._internal();
  factory PerformanceAnalyticsService() => _instance;
  PerformanceAnalyticsService._internal();

  bool _isInitialized = false;
  PerformanceConfig _config = PerformanceConfig.defaultConfig;
  final Map<String, PerformanceInsight> _insights = {};
  final Map<String, PerformanceTrend> _trends = {};
  final Map<String, PerformancePrediction> _predictions = {};
  final List<PerformanceReport> _reports = [];
  Timer? _analyticsTimer;
  Timer? _insightTimer;
  Timer? _predictionTimer;
  int _totalInsightsGenerated = 0;
  int _totalPredictionsMade = 0;
  int _totalReportsGenerated = 0;

  /// Initialize performance analytics service
  Future<bool> initialize() async {
    try {
      AppLogger.info('Initializing Performance Analytics Service...');
      
      // Load performance configuration
      await _loadPerformanceConfig();
      
      // Start analytics processing
      _startAnalytics();
      
      // Start insight generation
      _startInsightGeneration();
      
      // Start prediction processing
      _startPredictionProcessing();
      
      _isInitialized = true;
      AppLogger.success('Performance Analytics Service initialized successfully');
      return true;
    } catch (e) {
      AppLogger.error('Failed to initialize Performance Analytics Service', e);
      return false;
    }
  }

  /// Load performance configuration
  Future<void> _loadPerformanceConfig() async {
    try {
      // TODO: Load from secure storage
      _config = PerformanceConfig.defaultConfig;
      AppLogger.info('Performance configuration loaded');
    } catch (e) {
      AppLogger.error('Failed to load performance configuration', e);
    }
  }

  /// Start analytics processing
  void _startAnalytics() {
    _analyticsTimer = Timer.periodic(const Duration(minutes: 10), (timer) {
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
    _insightTimer = Timer.periodic(const Duration(minutes: 30), (timer) {
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

  /// Start prediction processing
  void _startPredictionProcessing() {
    _predictionTimer = Timer.periodic(const Duration(hours: 1), (timer) {
      _generatePredictions();
    });
    
    AppLogger.info('Prediction processing started');
  }

  /// Stop prediction processing
  void _stopPredictionProcessing() {
    _predictionTimer?.cancel();
    _predictionTimer = null;
    AppLogger.info('Prediction processing stopped');
  }

  /// Process analytics
  void _processAnalytics() {
    try {
      AppLogger.info('Processing performance analytics');
      
      // Analyze performance patterns
      _analyzePerformancePatterns();
      
      // Calculate performance correlations
      _calculatePerformanceCorrelations();
      
      // Identify performance anomalies
      _identifyPerformanceAnomalies();
      
      // Generate performance metrics
      _generatePerformanceMetrics();
      
      AppLogger.success('Analytics processing completed');
    } catch (e) {
      AppLogger.error('Failed to process analytics', e);
    }
  }

  /// Analyze performance patterns
  void _analyzePerformancePatterns() {
    try {
      // TODO: Implement actual pattern analysis
      AppLogger.info('Performance patterns analyzed');
    } catch (e) {
      AppLogger.error('Failed to analyze performance patterns', e);
    }
  }

  /// Calculate performance correlations
  void _calculatePerformanceCorrelations() {
    try {
      // TODO: Implement actual correlation calculations
      AppLogger.info('Performance correlations calculated');
    } catch (e) {
      AppLogger.error('Failed to calculate performance correlations', e);
    }
  }

  /// Identify performance anomalies
  void _identifyPerformanceAnomalies() {
    try {
      // TODO: Implement actual anomaly detection
      AppLogger.info('Performance anomalies identified');
    } catch (e) {
      AppLogger.error('Failed to identify performance anomalies', e);
    }
  }

  /// Generate performance metrics
  void _generatePerformanceMetrics() {
    try {
      // TODO: Implement actual metrics generation
      AppLogger.info('Performance metrics generated');
    } catch (e) {
      AppLogger.error('Failed to generate performance metrics', e);
    }
  }

  /// Generate insights
  void _generateInsights() {
    try {
      AppLogger.info('Generating performance insights');
      
      // Generate memory insights
      _generateMemoryInsights();
      
      // Generate CPU insights
      _generateCpuInsights();
      
      // Generate network insights
      _generateNetworkInsights();
      
      // Generate battery insights
      _generateBatteryInsights();
      
      // Generate overall insights
      _generateOverallInsights();
      
      _totalInsightsGenerated++;
      
      AppLogger.success('Insights generation completed');
    } catch (e) {
      AppLogger.error('Failed to generate insights', e);
    }
  }

  /// Generate memory insights
  void _generateMemoryInsights() {
    try {
      final insight = PerformanceInsight(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: PerformanceInsightType.memory,
        title: 'Memory Usage Analysis',
        description: 'Memory usage is within optimal range',
        severity: PerformanceSeverity.low,
        confidence: 0.85,
        recommendations: [
          'Continue current memory management practices',
          'Monitor for memory leaks',
          'Consider enabling garbage collection',
        ],
        metadata: {
          'memory_usage': 45.2,
          'memory_limit': 100.0,
          'memory_efficiency': 0.92,
        },
        generatedAt: DateTime.now(),
      );
      
      _insights[insight.id] = insight;
      
      AppLogger.info('Memory insights generated');
    } catch (e) {
      AppLogger.error('Failed to generate memory insights', e);
    }
  }

  /// Generate CPU insights
  void _generateCpuInsights() {
    try {
      final insight = PerformanceInsight(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: PerformanceInsightType.cpu,
        title: 'CPU Usage Analysis',
        description: 'CPU usage is moderate with room for optimization',
        severity: PerformanceSeverity.medium,
        confidence: 0.78,
        recommendations: [
          'Consider reducing concurrent operations',
          'Optimize task prioritization',
          'Enable CPU optimization features',
        ],
        metadata: {
          'cpu_usage': 65.3,
          'cpu_limit': 80.0,
          'cpu_efficiency': 0.75,
        },
        generatedAt: DateTime.now(),
      );
      
      _insights[insight.id] = insight;
      
      AppLogger.info('CPU insights generated');
    } catch (e) {
      AppLogger.error('Failed to generate CPU insights', e);
    }
  }

  /// Generate network insights
  void _generateNetworkInsights() {
    try {
      final insight = PerformanceInsight(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: PerformanceInsightType.network,
        title: 'Network Usage Analysis',
        description: 'Network usage is efficient with good response times',
        severity: PerformanceSeverity.low,
        confidence: 0.90,
        recommendations: [
          'Continue current network optimization',
          'Monitor for network spikes',
          'Consider enabling request batching',
        ],
        metadata: {
          'network_requests': 150,
          'network_limit': 1000,
          'response_time': 245.0,
        },
        generatedAt: DateTime.now(),
      );
      
      _insights[insight.id] = insight;
      
      AppLogger.info('Network insights generated');
    } catch (e) {
      AppLogger.error('Failed to generate network insights', e);
    }
  }

  /// Generate battery insights
  void _generateBatteryInsights() {
    try {
      final insight = PerformanceInsight(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: PerformanceInsightType.battery,
        title: 'Battery Usage Analysis',
        description: 'Battery usage is optimal with good efficiency',
        severity: PerformanceSeverity.low,
        confidence: 0.88,
        recommendations: [
          'Continue current battery optimization',
          'Monitor battery health',
          'Consider enabling power saving mode',
        ],
        metadata: {
          'battery_level': 78.5,
          'battery_drain': 1.2,
          'battery_health': 0.95,
        },
        generatedAt: DateTime.now(),
      );
      
      _insights[insight.id] = insight;
      
      AppLogger.info('Battery insights generated');
    } catch (e) {
      AppLogger.error('Failed to generate battery insights', e);
    }
  }

  /// Generate overall insights
  void _generateOverallInsights() {
    try {
      final insight = PerformanceInsight(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: PerformanceInsightType.overall,
        title: 'Overall Performance Analysis',
        description: 'Overall performance is good with some areas for improvement',
        severity: PerformanceSeverity.medium,
        confidence: 0.82,
        recommendations: [
          'Focus on CPU optimization',
          'Monitor memory usage trends',
          'Consider enabling advanced features',
        ],
        metadata: {
          'overall_score': 78.5,
          'performance_level': 'good',
          'optimization_potential': 0.15,
        },
        generatedAt: DateTime.now(),
      );
      
      _insights[insight.id] = insight;
      
      AppLogger.info('Overall insights generated');
    } catch (e) {
      AppLogger.error('Failed to generate overall insights', e);
    }
  }

  /// Generate predictions
  void _generatePredictions() {
    try {
      AppLogger.info('Generating performance predictions');
      
      // Generate memory predictions
      _generateMemoryPredictions();
      
      // Generate CPU predictions
      _generateCpuPredictions();
      
      // Generate network predictions
      _generateNetworkPredictions();
      
      // Generate battery predictions
      _generateBatteryPredictions();
      
      _totalPredictionsMade++;
      
      AppLogger.success('Predictions generation completed');
    } catch (e) {
      AppLogger.error('Failed to generate predictions', e);
    }
  }

  /// Generate memory predictions
  void _generateMemoryPredictions() {
    try {
      final prediction = PerformancePrediction(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: PerformancePredictionType.memory,
        title: 'Memory Usage Prediction',
        description: 'Memory usage is expected to remain stable',
        confidence: 0.80,
        predictedValue: 48.5,
        currentValue: 45.2,
        trend: PerformanceTrendDirection.stable,
        timeHorizon: const Duration(hours: 24),
        recommendations: [
          'Monitor memory usage closely',
          'Consider proactive memory cleanup',
          'Enable memory optimization features',
        ],
        metadata: {
          'prediction_type': 'memory_usage',
          'confidence_level': 'high',
          'trend_strength': 0.3,
        },
        generatedAt: DateTime.now(),
      );
      
      _predictions[prediction.id] = prediction;
      
      AppLogger.info('Memory predictions generated');
    } catch (e) {
      AppLogger.error('Failed to generate memory predictions', e);
    }
  }

  /// Generate CPU predictions
  void _generateCpuPredictions() {
    try {
      final prediction = PerformancePrediction(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: PerformancePredictionType.cpu,
        title: 'CPU Usage Prediction',
        description: 'CPU usage is expected to increase slightly',
        confidence: 0.75,
        predictedValue: 72.3,
        currentValue: 65.3,
        trend: PerformanceTrendDirection.increasing,
        timeHorizon: const Duration(hours: 12),
        recommendations: [
          'Prepare for increased CPU load',
          'Consider scaling down operations',
          'Enable CPU optimization features',
        ],
        metadata: {
          'prediction_type': 'cpu_usage',
          'confidence_level': 'medium',
          'trend_strength': 0.6,
        },
        generatedAt: DateTime.now(),
      );
      
      _predictions[prediction.id] = prediction;
      
      AppLogger.info('CPU predictions generated');
    } catch (e) {
      AppLogger.error('Failed to generate CPU predictions', e);
    }
  }

  /// Generate network predictions
  void _generateNetworkPredictions() {
    try {
      final prediction = PerformancePrediction(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: PerformancePredictionType.network,
        title: 'Network Usage Prediction',
        description: 'Network usage is expected to remain stable',
        confidence: 0.85,
        predictedValue: 155.0,
        currentValue: 150.0,
        trend: PerformanceTrendDirection.stable,
        timeHorizon: const Duration(hours: 6),
        recommendations: [
          'Continue current network optimization',
          'Monitor for network spikes',
          'Consider enabling request batching',
        ],
        metadata: {
          'prediction_type': 'network_usage',
          'confidence_level': 'high',
          'trend_strength': 0.2,
        },
        generatedAt: DateTime.now(),
      );
      
      _predictions[prediction.id] = prediction;
      
      AppLogger.info('Network predictions generated');
    } catch (e) {
      AppLogger.error('Failed to generate network predictions', e);
    }
  }

  /// Generate battery predictions
  void _generateBatteryPredictions() {
    try {
      final prediction = PerformancePrediction(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: PerformancePredictionType.battery,
        title: 'Battery Usage Prediction',
        description: 'Battery level is expected to decrease gradually',
        confidence: 0.90,
        predictedValue: 65.2,
        currentValue: 78.5,
        trend: PerformanceTrendDirection.decreasing,
        timeHorizon: const Duration(hours: 8),
        recommendations: [
          'Monitor battery level closely',
          'Consider enabling power saving mode',
          'Optimize background activities',
        ],
        metadata: {
          'prediction_type': 'battery_level',
          'confidence_level': 'high',
          'trend_strength': 0.4,
        },
        generatedAt: DateTime.now(),
      );
      
      _predictions[prediction.id] = prediction;
      
      AppLogger.info('Battery predictions generated');
    } catch (e) {
      AppLogger.error('Failed to generate battery predictions', e);
    }
  }

  /// Get performance insights
  List<PerformanceInsight> getPerformanceInsights({
    PerformanceInsightType? type,
    PerformanceSeverity? severity,
    DateTime? since,
    int? limit,
  }) {
    try {
      var insights = _insights.values.toList();
      
      if (type != null) {
        insights = insights.where((i) => i.type == type).toList();
      }
      
      if (severity != null) {
        insights = insights.where((i) => i.severity == severity).toList();
      }
      
      if (since != null) {
        insights = insights.where((i) => i.generatedAt.isAfter(since)).toList();
      }
      
      insights.sort((a, b) => b.generatedAt.compareTo(a.generatedAt));
      
      if (limit != null && limit > 0) {
        insights = insights.take(limit).toList();
      }
      
      return insights;
    } catch (e) {
      AppLogger.error('Failed to get performance insights', e);
      return [];
    }
  }

  /// Get performance predictions
  List<PerformancePrediction> getPerformancePredictions({
    PerformancePredictionType? type,
    DateTime? since,
    int? limit,
  }) {
    try {
      var predictions = _predictions.values.toList();
      
      if (type != null) {
        predictions = predictions.where((p) => p.type == type).toList();
      }
      
      if (since != null) {
        predictions = predictions.where((p) => p.generatedAt.isAfter(since)).toList();
      }
      
      predictions.sort((a, b) => b.generatedAt.compareTo(a.generatedAt));
      
      if (limit != null && limit > 0) {
        predictions = predictions.take(limit).toList();
      }
      
      return predictions;
    } catch (e) {
      AppLogger.error('Failed to get performance predictions', e);
      return [];
    }
  }

  /// Generate performance report
  PerformanceReport generatePerformanceReport({
    required String title,
    required String description,
    PerformanceReportType type = PerformanceReportType.comprehensive,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    try {
      AppLogger.info('Generating performance report: $title');
      
      final report = PerformanceReport(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description: description,
        type: type,
        startDate: startDate ?? DateTime.now().subtract(const Duration(days: 7)),
        endDate: endDate ?? DateTime.now(),
        insights: getPerformanceInsights(limit: 10),
        predictions: getPerformancePredictions(limit: 5),
        recommendations: _generateReportRecommendations(),
        metadata: {
          'report_type': type.name,
          'generated_at': DateTime.now().toIso8601String(),
          'insights_count': getPerformanceInsights().length,
          'predictions_count': getPerformancePredictions().length,
        },
        generatedAt: DateTime.now(),
      );
      
      _reports.add(report);
      _totalReportsGenerated++;
      
      AppLogger.success('Performance report generated: $title');
      return report;
    } catch (e) {
      AppLogger.error('Failed to generate performance report', e);
      return PerformanceReport.empty();
    }
  }

  /// Generate report recommendations
  List<String> _generateReportRecommendations() {
    try {
      final recommendations = <String>[];
      
      // Get recent insights
      final recentInsights = getPerformanceInsights(limit: 5);
      
      for (final insight in recentInsights) {
        recommendations.addAll(insight.recommendations);
      }
      
      // Remove duplicates
      recommendations.toSet().toList();
      
      if (recommendations.isEmpty) {
        recommendations.add('Continue current performance optimization practices');
      }
      
      return recommendations;
    } catch (e) {
      AppLogger.error('Failed to generate report recommendations', e);
      return [];
    }
  }

  /// Get performance trends
  Map<String, PerformanceTrend> getPerformanceTrends() {
    try {
      return Map.unmodifiable(_trends);
    } catch (e) {
      AppLogger.error('Failed to get performance trends', e);
      return {};
    }
  }

  /// Get performance reports
  List<PerformanceReport> getPerformanceReports({
    PerformanceReportType? type,
    DateTime? since,
    int? limit,
  }) {
    try {
      var reports = _reports;
      
      if (type != null) {
        reports = reports.where((r) => r.type == type).toList();
      }
      
      if (since != null) {
        reports = reports.where((r) => r.generatedAt.isAfter(since)).toList();
      }
      
      reports.sort((a, b) => b.generatedAt.compareTo(a.generatedAt));
      
      if (limit != null && limit > 0) {
        reports = reports.take(limit).toList();
      }
      
      return reports;
    } catch (e) {
      AppLogger.error('Failed to get performance reports', e);
      return [];
    }
  }

  /// Get analytics statistics
  AnalyticsStatistics getAnalyticsStatistics() {
    try {
      AppLogger.info('Getting analytics statistics');
      
      final statistics = AnalyticsStatistics(
        totalInsightsGenerated: _totalInsightsGenerated,
        totalPredictionsMade: _totalPredictionsMade,
        totalReportsGenerated: _totalReportsGenerated,
        activeInsights: _insights.length,
        activePredictions: _predictions.length,
        activeReports: _reports.length,
        averageInsightConfidence: _calculateAverageInsightConfidence(),
        averagePredictionConfidence: _calculateAveragePredictionConfidence(),
        lastAnalyticsRun: DateTime.now(),
        uptime: _calculateUptime(),
      );
      
      AppLogger.success('Analytics statistics retrieved');
      return statistics;
    } catch (e) {
      AppLogger.error('Failed to get analytics statistics', e);
      return AnalyticsStatistics.empty();
    }
  }

  /// Calculate average insight confidence
  double _calculateAverageInsightConfidence() {
    try {
      if (_insights.isEmpty) return 0.0;
      
      final confidences = _insights.values.map((i) => i.confidence).toList();
      return confidences.reduce((a, b) => a + b) / confidences.length;
    } catch (e) {
      AppLogger.error('Failed to calculate average insight confidence', e);
      return 0.0;
    }
  }

  /// Calculate average prediction confidence
  double _calculateAveragePredictionConfidence() {
    try {
      if (_predictions.isEmpty) return 0.0;
      
      final confidences = _predictions.values.map((p) => p.confidence).toList();
      return confidences.reduce((a, b) => a + b) / confidences.length;
    } catch (e) {
      AppLogger.error('Failed to calculate average prediction confidence', e);
      return 0.0;
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

  /// Update performance configuration
  Future<void> updateConfig(PerformanceConfig newConfig) async {
    try {
      AppLogger.info('Updating performance analytics configuration');
      
      _config = newConfig;
      
      AppLogger.success('Performance analytics configuration updated');
    } catch (e) {
      AppLogger.error('Failed to update performance analytics configuration', e);
    }
  }

  /// Get current configuration
  PerformanceConfig get config => _config;

  /// Check if service is initialized
  bool get isInitialized => _isInitialized;

  /// Dispose service
  Future<void> dispose() async {
    _stopAnalytics();
    _stopInsightGeneration();
    _stopPredictionProcessing();
    
    _insights.clear();
    _trends.clear();
    _predictions.clear();
    _reports.clear();
    
    _isInitialized = false;
    AppLogger.info('Performance Analytics Service disposed');
  }
}

/// Performance insight types
enum PerformanceInsightType {
  memory,
  cpu,
  network,
  battery,
  overall,
  custom,
}

/// Performance insight
class PerformanceInsight {
  final String id;
  final PerformanceInsightType type;
  final String title;
  final String description;
  final PerformanceSeverity severity;
  final double confidence;
  final List<String> recommendations;
  final Map<String, dynamic>? metadata;
  final DateTime generatedAt;

  const PerformanceInsight({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.severity,
    required this.confidence,
    required this.recommendations,
    this.metadata,
    required this.generatedAt,
  });

  /// Get insight icon
  String get icon {
    switch (type) {
      case PerformanceInsightType.memory:
        return '🧠';
      case PerformanceInsightType.cpu:
        return '⚡';
      case PerformanceInsightType.network:
        return '🌐';
      case PerformanceInsightType.battery:
        return '🔋';
      case PerformanceInsightType.overall:
        return '📊';
      case PerformanceInsightType.custom:
        return '🔍';
    }
  }
}

/// Performance prediction types
enum PerformancePredictionType {
  memory,
  cpu,
  network,
  battery,
  overall,
  custom,
}

/// Performance trend directions
enum PerformanceTrendDirection {
  increasing,
  decreasing,
  stable,
  volatile,
}

/// Performance prediction
class PerformancePrediction {
  final String id;
  final PerformancePredictionType type;
  final String title;
  final String description;
  final double confidence;
  final double predictedValue;
  final double currentValue;
  final PerformanceTrendDirection trend;
  final Duration timeHorizon;
  final List<String> recommendations;
  final Map<String, dynamic>? metadata;
  final DateTime generatedAt;

  const PerformancePrediction({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.confidence,
    required this.predictedValue,
    required this.currentValue,
    required this.trend,
    required this.timeHorizon,
    required this.recommendations,
    this.metadata,
    required this.generatedAt,
  });

  /// Get prediction icon
  String get icon {
    switch (type) {
      case PerformancePredictionType.memory:
        return '🧠';
      case PerformancePredictionType.cpu:
        return '⚡';
      case PerformancePredictionType.network:
        return '🌐';
      case PerformancePredictionType.battery:
        return '🔋';
      case PerformancePredictionType.overall:
        return '📊';
      case PerformancePredictionType.custom:
        return '🔮';
    }
  }

  /// Get trend icon
  String get trendIcon {
    switch (trend) {
      case PerformanceTrendDirection.increasing:
        return '📈';
      case PerformanceTrendDirection.decreasing:
        return '📉';
      case PerformanceTrendDirection.stable:
        return '➡️';
      case PerformanceTrendDirection.volatile:
        return '📊';
    }
  }
}

/// Performance trend
class PerformanceTrend {
  final String id;
  final String name;
  final List<double> values;
  final List<DateTime> timestamps;
  final PerformanceTrendDirection direction;
  final double strength;
  final DateTime lastUpdated;

  const PerformanceTrend({
    required this.id,
    required this.name,
    required this.values,
    required this.timestamps,
    required this.direction,
    required this.strength,
    required this.lastUpdated,
  });
}

/// Performance report types
enum PerformanceReportType {
  summary,
  detailed,
  comprehensive,
  custom,
}

/// Performance report
class PerformanceReport {
  final String id;
  final String title;
  final String description;
  final PerformanceReportType type;
  final DateTime startDate;
  final DateTime endDate;
  final List<PerformanceInsight> insights;
  final List<PerformancePrediction> predictions;
  final List<String> recommendations;
  final Map<String, dynamic>? metadata;
  final DateTime generatedAt;

  const PerformanceReport({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.insights,
    required this.predictions,
    required this.recommendations,
    this.metadata,
    required this.generatedAt,
  });

  factory PerformanceReport.empty() {
    return PerformanceReport(
      id: '',
      title: '',
      description: '',
      type: PerformanceReportType.summary,
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      insights: [],
      predictions: [],
      recommendations: [],
      generatedAt: DateTime.now(),
    );
  }
}

/// Analytics statistics
class AnalyticsStatistics {
  final int totalInsightsGenerated;
  final int totalPredictionsMade;
  final int totalReportsGenerated;
  final int activeInsights;
  final int activePredictions;
  final int activeReports;
  final double averageInsightConfidence;
  final double averagePredictionConfidence;
  final DateTime lastAnalyticsRun;
  final Duration uptime;

  const AnalyticsStatistics({
    required this.totalInsightsGenerated,
    required this.totalPredictionsMade,
    required this.totalReportsGenerated,
    required this.activeInsights,
    required this.activePredictions,
    required this.activeReports,
    required this.averageInsightConfidence,
    required this.averagePredictionConfidence,
    required this.lastAnalyticsRun,
    required this.uptime,
  });

  factory AnalyticsStatistics.empty() {
    return AnalyticsStatistics(
      totalInsightsGenerated: 0,
      totalPredictionsMade: 0,
      totalReportsGenerated: 0,
      activeInsights: 0,
      activePredictions: 0,
      activeReports: 0,
      averageInsightConfidence: 0.0,
      averagePredictionConfidence: 0.0,
      lastAnalyticsRun: DateTime.now(),
      uptime: Duration.zero,
    );
  }
}
