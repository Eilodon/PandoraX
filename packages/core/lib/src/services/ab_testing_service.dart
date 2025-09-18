/// A/B Testing Service for Phase 6 Analytics & Optimization
/// 
/// This service provides comprehensive A/B testing capabilities including
/// experiment management, variant assignment, and statistical analysis.
library ab_testing_service;

import 'package:flutter/material.dart';
import 'package:core/core.dart';

/// A/B testing service for feature experimentation and optimization
class ABTestingService {
  static ABTestingService? _instance;
  static ABTestingService get instance => _instance ??= ABTestingService._();
  
  ABTestingService._();
  
  final LoggingService _logger = LoggingService.instance;
  final AnalyticsService _analytics = AnalyticsService.instance;
  
  // ============================================================================
  // EXPERIMENT MANAGEMENT
  // ============================================================================
  
  /// Create new A/B test experiment
  void createExperiment({
    required String experimentId,
    required String name,
    required String description,
    required List<String> variants,
    required String metric,
    double confidenceLevel = 0.95,
    int minimumSampleSize = 1000,
    Duration duration = const Duration(days: 30),
  }) {
    try {
      final experiment = _createExperiment(
        experimentId: experimentId,
        name: name,
        description: description,
        variants: variants,
        metric: metric,
        confidenceLevel: confidenceLevel,
        minimumSampleSize: minimumSampleSize,
        duration: duration,
      );
      
      _storeExperiment(experiment);
      _logger.info('Created A/B test experiment: $experimentId');
    } catch (e) {
      _logger.warning('Failed to create experiment: $e');
    }
  }
  
  /// Start experiment
  void startExperiment(String experimentId) {
    try {
      final experiment = _getExperiment(experimentId);
      if (experiment != null) {
        experiment['status'] = 'running';
        experiment['started_at'] = DateTime.now().toIso8601String();
        _storeExperiment(experiment);
        _logger.info('Started experiment: $experimentId');
      }
    } catch (e) {
      _logger.warning('Failed to start experiment: $e');
    }
  }
  
  /// Stop experiment
  void stopExperiment(String experimentId) {
    try {
      final experiment = _getExperiment(experimentId);
      if (experiment != null) {
        experiment['status'] = 'stopped';
        experiment['stopped_at'] = DateTime.now().toIso8601String();
        _storeExperiment(experiment);
        _logger.info('Stopped experiment: $experimentId');
      }
    } catch (e) {
      _logger.warning('Failed to stop experiment: $e');
    }
  }
  
  /// Pause experiment
  void pauseExperiment(String experimentId) {
    try {
      final experiment = _getExperiment(experimentId);
      if (experiment != null) {
        experiment['status'] = 'paused';
        experiment['paused_at'] = DateTime.now().toIso8601String();
        _storeExperiment(experiment);
        _logger.info('Paused experiment: $experimentId');
      }
    } catch (e) {
      _logger.warning('Failed to pause experiment: $e');
    }
  }
  
  /// Resume experiment
  void resumeExperiment(String experimentId) {
    try {
      final experiment = _getExperiment(experimentId);
      if (experiment != null) {
        experiment['status'] = 'running';
        experiment['resumed_at'] = DateTime.now().toIso8601String();
        _storeExperiment(experiment);
        _logger.info('Resumed experiment: $experimentId');
      }
    } catch (e) {
      _logger.warning('Failed to resume experiment: $e');
    }
  }
  
  // ============================================================================
  // VARIANT ASSIGNMENT
  // ============================================================================
  
  /// Get variant for user
  String getVariant(String experimentId, String userId) {
    try {
      final experiment = _getExperiment(experimentId);
      if (experiment == null || experiment['status'] != 'running') {
        return 'control';
      }
      
      final variant = _assignVariant(experimentId, userId);
      _trackVariantAssignment(experimentId, userId, variant);
      
      return variant;
    } catch (e) {
      _logger.warning('Failed to get variant: $e');
      return 'control';
    }
  }
  
  /// Check if user is in experiment
  bool isUserInExperiment(String experimentId, String userId) {
    try {
      final experiment = _getExperiment(experimentId);
      if (experiment == null || experiment['status'] != 'running') {
        return false;
      }
      
      return _isUserAssigned(experimentId, userId);
    } catch (e) {
      _logger.warning('Failed to check user in experiment: $e');
      return false;
    }
  }
  
  /// Get all active experiments for user
  List<String> getActiveExperiments(String userId) {
    try {
      final experiments = _getActiveExperiments();
      final userExperiments = <String>[];
      
      for (final experiment in experiments) {
        if (_isUserAssigned(experiment['id'], userId)) {
          userExperiments.add(experiment['id']);
        }
      }
      
      return userExperiments;
    } catch (e) {
      _logger.warning('Failed to get active experiments: $e');
      return [];
    }
  }
  
  // ============================================================================
  // METRIC TRACKING
  // ============================================================================
  
  /// Track experiment metric
  void trackMetric(String experimentId, String userId, String metric, double value) {
    try {
      final variant = getVariant(experimentId, userId);
      
      _trackMetricValue(experimentId, userId, variant, metric, value);
      
      _analytics.trackCustomEvent('ab_test_metric', {
        'experiment_id': experimentId,
        'user_id': userId,
        'variant': variant,
        'metric': metric,
        'value': value,
      });
      
      _logger.debug('Tracked metric for experiment $experimentId: $metric = $value');
    } catch (e) {
      _logger.warning('Failed to track metric: $e');
    }
  }
  
  /// Track conversion
  void trackConversion(String experimentId, String userId, String conversionType, double value) {
    try {
      final variant = getVariant(experimentId, userId);
      
      _trackConversionValue(experimentId, userId, variant, conversionType, value);
      
      _analytics.trackConversion(conversionType, value, context: {
        'experiment_id': experimentId,
        'variant': variant,
      });
      
      _logger.debug('Tracked conversion for experiment $experimentId: $conversionType = $value');
    } catch (e) {
      _logger.warning('Failed to track conversion: $e');
    }
  }
  
  /// Track engagement
  void trackEngagement(String experimentId, String userId, String engagementType, Duration duration) {
    try {
      final variant = getVariant(experimentId, userId);
      
      _trackEngagementValue(experimentId, userId, variant, engagementType, duration);
      
      _analytics.trackEngagement(engagementType, duration, context: {
        'experiment_id': experimentId,
        'variant': variant,
      });
      
      _logger.debug('Tracked engagement for experiment $experimentId: $engagementType');
    } catch (e) {
      _logger.warning('Failed to track engagement: $e');
    }
  }
  
  // ============================================================================
  // STATISTICAL ANALYSIS
  // ============================================================================
  
  /// Get experiment results
  Map<String, dynamic> getExperimentResults(String experimentId) {
    try {
      final experiment = _getExperiment(experimentId);
      if (experiment == null) {
        return {};
      }
      
      final results = _calculateExperimentResults(experimentId);
      return results;
    } catch (e) {
      _logger.warning('Failed to get experiment results: $e');
      return {};
    }
  }
  
  /// Get statistical significance
  double getStatisticalSignificance(String experimentId) {
    try {
      final results = getExperimentResults(experimentId);
      return results['statistical_significance'] ?? 0.0;
    } catch (e) {
      _logger.warning('Failed to get statistical significance: $e');
      return 0.0;
    }
  }
  
  /// Get confidence interval
  Map<String, double> getConfidenceInterval(String experimentId, String variant) {
    try {
      final results = getExperimentResults(experimentId);
      final variantResults = results['variants'][variant];
      if (variantResults == null) {
        return {'lower': 0.0, 'upper': 0.0};
      }
      
      return {
        'lower': variantResults['confidence_interval_lower'] ?? 0.0,
        'upper': variantResults['confidence_interval_upper'] ?? 0.0,
      };
    } catch (e) {
      _logger.warning('Failed to get confidence interval: $e');
      return {'lower': 0.0, 'upper': 0.0};
    }
  }
  
  /// Get winning variant
  String? getWinningVariant(String experimentId) {
    try {
      final results = getExperimentResults(experimentId);
      final significance = results['statistical_significance'] ?? 0.0;
      final confidenceLevel = results['confidence_level'] ?? 0.95;
      
      if (significance >= confidenceLevel) {
        return results['winning_variant'];
      }
      
      return null;
    } catch (e) {
      _logger.warning('Failed to get winning variant: $e');
      return null;
    }
  }
  
  /// Check if experiment is statistically significant
  bool isStatisticallySignificant(String experimentId) {
    try {
      final significance = getStatisticalSignificance(experimentId);
      final experiment = _getExperiment(experimentId);
      final confidenceLevel = experiment?['confidence_level'] ?? 0.95;
      
      return significance >= confidenceLevel;
    } catch (e) {
      _logger.warning('Failed to check statistical significance: $e');
      return false;
    }
  }
  
  // ============================================================================
  // EXPERIMENT INSIGHTS
  // ============================================================================
  
  /// Get experiment insights
  Map<String, dynamic> getExperimentInsights(String experimentId) {
    try {
      final experiment = _getExperiment(experimentId);
      if (experiment == null) {
        return {};
      }
      
      final results = getExperimentResults(experimentId);
      final insights = _generateExperimentInsights(experiment, results);
      
      return insights;
    } catch (e) {
      _logger.warning('Failed to get experiment insights: $e');
      return {};
    }
  }
  
  /// Get all experiments summary
  Map<String, dynamic> getAllExperimentsSummary() {
    try {
      final experiments = _getAllExperiments();
      final summary = _generateExperimentsSummary(experiments);
      
      return summary;
    } catch (e) {
      _logger.warning('Failed to get experiments summary: $e');
      return {};
    }
  }
  
  /// Get experiment recommendations
  List<String> getExperimentRecommendations() {
    try {
      final experiments = _getAllExperiments();
      final recommendations = _generateExperimentRecommendations(experiments);
      
      return recommendations;
    } catch (e) {
      _logger.warning('Failed to get experiment recommendations: $e');
      return [];
    }
  }
  
  // ============================================================================
  // DATA MANAGEMENT
  // ============================================================================
  
  /// Create experiment
  Map<String, dynamic> _createExperiment({
    required String experimentId,
    required String name,
    required String description,
    required List<String> variants,
    required String metric,
    required double confidenceLevel,
    required int minimumSampleSize,
    required Duration duration,
  }) {
    return {
      'id': experimentId,
      'name': name,
      'description': description,
      'variants': variants,
      'metric': metric,
      'confidence_level': confidenceLevel,
      'minimum_sample_size': minimumSampleSize,
      'duration': duration.inDays,
      'status': 'draft',
      'created_at': DateTime.now().toIso8601String(),
      'created_by': _getCurrentUserId(),
    };
  }
  
  /// Store experiment
  void _storeExperiment(Map<String, dynamic> experiment) {
    // In a real implementation, you would store in database
    _logger.debug('Stored experiment: ${experiment['id']}');
  }
  
  /// Get experiment
  Map<String, dynamic>? _getExperiment(String experimentId) {
    // In a real implementation, you would load from database
    return null;
  }
  
  /// Get active experiments
  List<Map<String, dynamic>> _getActiveExperiments() {
    // In a real implementation, you would load from database
    return [];
  }
  
  /// Get all experiments
  List<Map<String, dynamic>> _getAllExperiments() {
    // In a real implementation, you would load from database
    return [];
  }
  
  /// Assign variant to user
  String _assignVariant(String experimentId, String userId) {
    // Simple hash-based assignment for consistency
    final hash = _hashString('$experimentId$userId');
    final variants = _getExperiment(experimentId)?['variants'] ?? ['control'];
    final index = hash % variants.length;
    return variants[index];
  }
  
  /// Check if user is assigned
  bool _isUserAssigned(String experimentId, String userId) {
    // In a real implementation, you would check assignment database
    return true;
  }
  
  /// Track variant assignment
  void _trackVariantAssignment(String experimentId, String userId, String variant) {
    _analytics.trackCustomEvent('ab_test_assignment', {
      'experiment_id': experimentId,
      'user_id': userId,
      'variant': variant,
    });
  }
  
  /// Track metric value
  void _trackMetricValue(String experimentId, String userId, String variant, String metric, double value) {
    // In a real implementation, you would store in database
    _logger.debug('Tracked metric value: $experimentId, $variant, $metric = $value');
  }
  
  /// Track conversion value
  void _trackConversionValue(String experimentId, String userId, String variant, String conversionType, double value) {
    // In a real implementation, you would store in database
    _logger.debug('Tracked conversion value: $experimentId, $variant, $conversionType = $value');
  }
  
  /// Track engagement value
  void _trackEngagementValue(String experimentId, String userId, String variant, String engagementType, Duration duration) {
    // In a real implementation, you would store in database
    _logger.debug('Tracked engagement value: $experimentId, $variant, $engagementType');
  }
  
  /// Calculate experiment results
  Map<String, dynamic> _calculateExperimentResults(String experimentId) {
    // In a real implementation, you would perform statistical analysis
    return {
      'experiment_id': experimentId,
      'statistical_significance': 0.0,
      'confidence_level': 0.95,
      'winning_variant': null,
      'variants': {},
    };
  }
  
  /// Generate experiment insights
  Map<String, dynamic> _generateExperimentInsights(Map<String, dynamic> experiment, Map<String, dynamic> results) {
    return {
      'experiment_id': experiment['id'],
      'name': experiment['name'],
      'status': experiment['status'],
      'statistical_significance': results['statistical_significance'],
      'winning_variant': results['winning_variant'],
      'recommendations': [],
    };
  }
  
  /// Generate experiments summary
  Map<String, dynamic> _generateExperimentsSummary(List<Map<String, dynamic>> experiments) {
    return {
      'total_experiments': experiments.length,
      'active_experiments': experiments.where((e) => e['status'] == 'running').length,
      'completed_experiments': experiments.where((e) => e['status'] == 'stopped').length,
      'paused_experiments': experiments.where((e) => e['status'] == 'paused').length,
    };
  }
  
  /// Generate experiment recommendations
  List<String> _generateExperimentRecommendations(List<Map<String, dynamic>> experiments) {
    return [
      'Consider running more experiments to improve conversion rates',
      'Focus on high-impact features for better results',
      'Ensure proper statistical power for reliable results',
    ];
  }
  
  /// Hash string for consistent assignment
  int _hashString(String input) {
    int hash = 0;
    for (int i = 0; i < input.length; i++) {
      hash = ((hash << 5) - hash + input.codeUnitAt(i)) & 0xffffffff;
    }
    return hash.abs();
  }
  
  /// Get current user ID
  String _getCurrentUserId() {
    // In a real implementation, you would get from user manager
    return 'user_anonymous';
  }
  
  // ============================================================================
  // CONFIGURATION
  // ============================================================================
  
  /// Enable/disable A/B testing
  bool _abTestingEnabled = true;
  bool get abTestingEnabled => _abTestingEnabled;
  
  void setABTestingEnabled(bool enabled) {
    _abTestingEnabled = enabled;
    _logger.info('A/B testing ${enabled ? 'enabled' : 'disabled'}');
  }
  
  /// Set A/B testing configuration
  void setABTestingConfiguration(Map<String, dynamic> config) {
    _logger.info('A/B testing configuration updated: $config');
  }
  
  /// Get A/B testing configuration
  Map<String, dynamic> getABTestingConfiguration() {
    return {
      'ab_testing_enabled': _abTestingEnabled,
      'default_confidence_level': 0.95,
      'default_minimum_sample_size': 1000,
      'default_duration_days': 30,
      'assignment_method': 'hash_based',
      'tracking_enabled': true,
    };
  }
}
