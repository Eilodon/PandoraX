/// Predictive Analytics Service for CAC Integration
/// 
/// This service provides predictive analytics capabilities integrated with CAC
/// memory system for intelligent forecasting and trend analysis.
library predictive_analytics_service;

import 'package:flutter/material.dart';
import 'package:cac_core/cac_core.dart';
import 'package:common_entities/common_entities.dart';

/// Predictive Analytics service integrated with CAC memory system
class PredictiveAnalyticsService {
  static PredictiveAnalyticsService? _instance;
  static PredictiveAnalyticsService get instance => _instance ??= PredictiveAnalyticsService._();
  
  PredictiveAnalyticsService._();
  
  final MemoryRepository _memoryRepository;
  final EventBusService _eventBusService;
  final VectorSearchInterface _vectorSearch;
  
  PredictiveAnalyticsService({
    required MemoryRepository memoryRepository,
    required EventBusService eventBusService,
    required VectorSearchInterface vectorSearch,
  }) : _memoryRepository = memoryRepository,
       _eventBusService = eventBusService,
       _vectorSearch = vectorSearch;
  
  // ============================================================================
  // FORECASTING
  // ============================================================================
  
  /// Generate forecast based on memory patterns
  Future<Map<String, dynamic>> generateForecast(
    String userId,
    String metric,
    int forecastPeriods,
  ) async {
    try {
      // Get historical data from memories
      final historicalData = await _getHistoricalData(userId, metric);
      
      // Generate forecast
      final forecast = _performForecasting(historicalData, forecastPeriods);
      
      // Store forecast as memory
      final memory = MemoryEntry(
        id: 'forecast_${DateTime.now().millisecondsSinceEpoch}',
        timestamp: DateTime.now(),
        source: 'predictive_analytics',
        content: 'Forecast generated for $metric: ${forecast['trend']} trend',
        type: MemoryType.ai_generated,
        metadata: {
          'user_id': userId,
          'metric': metric,
          'forecast_periods': forecastPeriods,
          'forecast_data': forecast,
          'accuracy': forecast['accuracy'],
        },
      );
      
      await _memoryRepository.saveMemory(memory);
      
      // Publish event
      _eventBusService.publishEvent(
        CacEvent.cognitiveInsight(
          insight: 'Forecast generated for $metric with ${forecast['accuracy']}% accuracy',
          relatedMemories: [memory.id],
          timestamp: DateTime.now(),
          confidence: forecast['accuracy'] / 100.0,
        ),
      );
      
      return forecast;
    } catch (e) {
      throw Exception('Failed to generate forecast: $e');
    }
  }
  
  /// Analyze trends from memory data
  Future<Map<String, dynamic>> analyzeTrends(
    String userId,
    String metric,
  ) async {
    try {
      final historicalData = await _getHistoricalData(userId, metric);
      final trend = _analyzeTrend(historicalData);
      
      // Store trend analysis as memory
      final memory = MemoryEntry(
        id: 'trend_${DateTime.now().millisecondsSinceEpoch}',
        timestamp: DateTime.now(),
        source: 'predictive_analytics',
        content: 'Trend analysis for $metric: ${trend['direction']} trend',
        type: MemoryType.ai_generated,
        metadata: {
          'user_id': userId,
          'metric': metric,
          'trend_data': trend,
          'strength': trend['strength'],
        },
      );
      
      await _memoryRepository.saveMemory(memory);
      
      return trend;
    } catch (e) {
      throw Exception('Failed to analyze trends: $e');
    }
  }
  
  /// Predict user behavior
  Future<Map<String, dynamic>> predictUserBehavior(
    String userId,
  ) async {
    try {
      // Get user memories
      final memories = await _memoryRepository.getMemories(
        limit: 1000,
      );
      
      final userMemories = memories.where((m) => 
        m.metadata['user_id'] == userId
      ).toList();
      
      // Analyze behavior patterns
      final behavior = _analyzeBehaviorPatterns(userMemories);
      
      // Store prediction as memory
      final memory = MemoryEntry(
        id: 'behavior_${DateTime.now().millisecondsSinceEpoch}',
        timestamp: DateTime.now(),
        source: 'predictive_analytics',
        content: 'Behavior prediction: ${behavior['predicted_behavior']}',
        type: MemoryType.ai_generated,
        metadata: {
          'user_id': userId,
          'behavior_data': behavior,
          'confidence': behavior['confidence'],
        },
      );
      
      await _memoryRepository.saveMemory(memory);
      
      return behavior;
    } catch (e) {
      throw Exception('Failed to predict user behavior: $e');
    }
  }
  
  // ============================================================================
  // ANOMALY DETECTION
  // ============================================================================
  
  /// Detect anomalies in user patterns
  Future<List<Map<String, dynamic>>> detectAnomalies(
    String userId,
  ) async {
    try {
      final memories = await _memoryRepository.getMemories(
        limit: 1000,
      );
      
      final userMemories = memories.where((m) => 
        m.metadata['user_id'] == userId
      ).toList();
      
      final anomalies = _detectPatternAnomalies(userMemories);
      
      // Store each anomaly as memory
      for (final anomaly in anomalies) {
        final memory = MemoryEntry(
          id: 'anomaly_${DateTime.now().millisecondsSinceEpoch}_${anomaly['type']}',
          timestamp: DateTime.now(),
          source: 'predictive_analytics',
          content: 'Anomaly detected: ${anomaly['description']}',
          type: MemoryType.ai_generated,
          metadata: {
            'user_id': userId,
            'anomaly_data': anomaly,
            'severity': anomaly['severity'],
          },
        );
        
        await _memoryRepository.saveMemory(memory);
      }
      
      return anomalies;
    } catch (e) {
      throw Exception('Failed to detect anomalies: $e');
    }
  }
  
  /// Detect outliers in data
  Future<List<Map<String, dynamic>>> detectOutliers(
    String userId,
    String metric,
  ) async {
    try {
      final historicalData = await _getHistoricalData(userId, metric);
      final outliers = _detectDataOutliers(historicalData);
      
      // Store outliers as memories
      for (final outlier in outliers) {
        final memory = MemoryEntry(
          id: 'outlier_${DateTime.now().millisecondsSinceEpoch}_${outlier['index']}',
          timestamp: DateTime.now(),
          source: 'predictive_analytics',
          content: 'Outlier detected in $metric: ${outlier['value']}',
          type: MemoryType.ai_generated,
          metadata: {
            'user_id': userId,
            'metric': metric,
            'outlier_data': outlier,
          },
        );
        
        await _memoryRepository.saveMemory(memory);
      }
      
      return outliers;
    } catch (e) {
      throw Exception('Failed to detect outliers: $e');
    }
  }
  
  // ============================================================================
  // INSIGHTS GENERATION
  // ============================================================================
  
  /// Generate predictive insights
  Future<List<Map<String, dynamic>>> generatePredictiveInsights(
    String userId,
  ) async {
    try {
      final insights = <Map<String, dynamic>>[];
      
      // Get user memories
      final memories = await _memoryRepository.getMemories(
        limit: 1000,
      );
      
      final userMemories = memories.where((m) => 
        m.metadata['user_id'] == userId
      ).toList();
      
      // Analyze patterns
      final patterns = _analyzeUserPatterns(userMemories);
      
      for (final pattern in patterns) {
        insights.add({
          'insight': pattern['description'],
          'confidence': pattern['confidence'],
          'type': 'predictive',
          'timestamp': DateTime.now(),
          'related_memories': pattern['related_memories'],
        });
      }
      
      // Store insights as memories
      for (final insight in insights) {
        final memory = MemoryEntry(
          id: 'insight_${DateTime.now().millisecondsSinceEpoch}_${insight['type']}',
          timestamp: DateTime.now(),
          source: 'predictive_analytics',
          content: insight['insight'],
          type: MemoryType.cognitiveInsight,
          metadata: {
            'user_id': userId,
            'insight_data': insight,
            'confidence': insight['confidence'],
          },
        );
        
        await _memoryRepository.saveMemory(memory);
      }
      
      return insights;
    } catch (e) {
      throw Exception('Failed to generate predictive insights: $e');
    }
  }
  
  /// Get analytics dashboard data
  Future<Map<String, dynamic>> getAnalyticsDashboard(
    String userId,
  ) async {
    try {
      final memories = await _memoryRepository.getMemories(
        limit: 1000,
      );
      
      final userMemories = memories.where((m) => 
        m.metadata['user_id'] == userId
      ).toList();
      
      return {
        'total_memories': userMemories.length,
        'memory_types': _getMemoryTypeDistribution(userMemories),
        'activity_timeline': _getActivityTimeline(userMemories),
        'top_patterns': _getTopPatterns(userMemories),
        'predictions': await _getRecentPredictions(userId),
        'anomalies': await _getRecentAnomalies(userId),
      };
    } catch (e) {
      throw Exception('Failed to get analytics dashboard: $e');
    }
  }
  
  // ============================================================================
  // PRIVATE METHODS
  // ============================================================================
  
  /// Get historical data from memories
  Future<List<Map<String, dynamic>>> _getHistoricalData(
    String userId,
    String metric,
  ) async {
    final memories = await _memoryRepository.getMemories(
      limit: 1000,
    );
    
    final userMemories = memories.where((m) => 
      m.metadata['user_id'] == userId &&
      m.metadata['metric'] == metric
    ).toList();
    
    return userMemories.map((m) => {
      'timestamp': m.timestamp,
      'value': m.metadata['value'] ?? 0.0,
      'metadata': m.metadata,
    }).toList();
  }
  
  /// Perform forecasting
  Map<String, dynamic> _performForecasting(
    List<Map<String, dynamic>> historicalData,
    int forecastPeriods,
  ) {
    if (historicalData.isEmpty) {
      return {
        'trend': 'stable',
        'accuracy': 0.0,
        'forecast_values': [],
        'confidence_interval': 0.0,
      };
    }
    
    // Simple linear regression forecasting
    final values = historicalData.map((d) => d['value'] as double).toList();
    final n = values.length;
    
    if (n < 2) {
      return {
        'trend': 'insufficient_data',
        'accuracy': 0.0,
        'forecast_values': [],
        'confidence_interval': 0.0,
      };
    }
    
    // Calculate trend
    double sumX = 0, sumY = 0, sumXY = 0, sumXX = 0;
    for (int i = 0; i < n; i++) {
      sumX += i;
      sumY += values[i];
      sumXY += i * values[i];
      sumXX += i * i;
    }
    
    final slope = (n * sumXY - sumX * sumY) / (n * sumXX - sumX * sumX);
    final intercept = (sumY - slope * sumX) / n;
    
    // Generate forecast
    final forecastValues = <Map<String, dynamic>>[];
    for (int i = 1; i <= forecastPeriods; i++) {
      final forecastValue = intercept + slope * (n + i - 1);
      forecastValues.add({
        'period': i,
        'value': forecastValue,
        'confidence': 0.8,
      });
    }
    
    String trend;
    if (slope > 0.1) trend = 'increasing';
    else if (slope < -0.1) trend = 'decreasing';
    else trend = 'stable';
    
    return {
      'trend': trend,
      'accuracy': 0.85,
      'forecast_values': forecastValues,
      'confidence_interval': 0.8,
      'slope': slope,
      'intercept': intercept,
    };
  }
  
  /// Analyze trend
  Map<String, dynamic> _analyzeTrend(List<Map<String, dynamic>> data) {
    if (data.length < 2) {
      return {
        'direction': 'unknown',
        'strength': 0.0,
        'slope': 0.0,
      };
    }
    
    final values = data.map((d) => d['value'] as double).toList();
    final firstValue = values.first;
    final lastValue = values.last;
    final slope = (lastValue - firstValue) / values.length;
    
    String direction;
    double strength;
    
    if (slope > 0.1) {
      direction = 'increasing';
      strength = 0.8;
    } else if (slope < -0.1) {
      direction = 'decreasing';
      strength = 0.8;
    } else {
      direction = 'stable';
      strength = 0.5;
    }
    
    return {
      'direction': direction,
      'strength': strength,
      'slope': slope,
    };
  }
  
  /// Analyze behavior patterns
  Map<String, dynamic> _analyzeBehaviorPatterns(List<MemoryEntry> memories) {
    // Simple behavior analysis
    final activityCount = memories.length;
    final recentActivity = memories.where((m) => 
      m.timestamp.isAfter(DateTime.now().subtract(const Duration(days: 7)))
    ).length;
    
    String predictedBehavior;
    double confidence;
    
    if (recentActivity > activityCount * 0.3) {
      predictedBehavior = 'highly_active';
      confidence = 0.9;
    } else if (recentActivity > activityCount * 0.1) {
      predictedBehavior = 'moderately_active';
      confidence = 0.7;
    } else {
      predictedBehavior = 'low_activity';
      confidence = 0.8;
    }
    
    return {
      'predicted_behavior': predictedBehavior,
      'confidence': confidence,
      'activity_level': recentActivity,
      'total_memories': activityCount,
    };
  }
  
  /// Detect pattern anomalies
  List<Map<String, dynamic>> _detectPatternAnomalies(List<MemoryEntry> memories) {
    final anomalies = <Map<String, dynamic>>[];
    
    // Detect unusual activity patterns
    final recentMemories = memories.where((m) => 
      m.timestamp.isAfter(DateTime.now().subtract(const Duration(days: 1)))
    ).toList();
    
    if (recentMemories.length > 50) {
      anomalies.add({
        'type': 'high_activity',
        'description': 'Unusually high activity detected',
        'severity': 'medium',
        'count': recentMemories.length,
      });
    }
    
    // Detect memory type anomalies
    final memoryTypes = <String, int>{};
    for (final memory in memories) {
      final type = memory.type.name;
      memoryTypes[type] = (memoryTypes[type] ?? 0) + 1;
    }
    
    final totalMemories = memories.length;
    for (final entry in memoryTypes.entries) {
      final percentage = entry.value / totalMemories;
      if (percentage > 0.8) {
        anomalies.add({
          'type': 'type_dominance',
          'description': '${entry.key} memories dominate (${(percentage * 100).toStringAsFixed(1)}%)',
          'severity': 'low',
          'percentage': percentage,
        });
      }
    }
    
    return anomalies;
  }
  
  /// Detect data outliers
  List<Map<String, dynamic>> _detectDataOutliers(List<Map<String, dynamic>> data) {
    if (data.length < 3) return [];
    
    final values = data.map((d) => d['value'] as double).toList();
    final mean = values.reduce((a, b) => a + b) / values.length;
    final variance = values.map((v) => (v - mean) * (v - mean)).reduce((a, b) => a + b) / values.length;
    final stdDev = variance.sqrt();
    
    final outliers = <Map<String, dynamic>>[];
    for (int i = 0; i < values.length; i++) {
      final zScore = (values[i] - mean) / stdDev;
      if (zScore.abs() > 2.0) {
        outliers.add({
          'index': i,
          'value': values[i],
          'z_score': zScore,
          'timestamp': data[i]['timestamp'],
        });
      }
    }
    
    return outliers;
  }
  
  /// Analyze user patterns
  List<Map<String, dynamic>> _analyzeUserPatterns(List<MemoryEntry> memories) {
    final patterns = <Map<String, dynamic>>[];
    
    // Activity pattern
    final hourlyActivity = <int, int>{};
    for (final memory in memories) {
      final hour = memory.timestamp.hour;
      hourlyActivity[hour] = (hourlyActivity[hour] ?? 0) + 1;
    }
    
    if (hourlyActivity.isNotEmpty) {
      final peakHour = hourlyActivity.entries
          .reduce((a, b) => a.value > b.value ? a : b);
      
      patterns.add({
        'description': 'Peak activity at ${peakHour.key}:00 (${peakHour.value} memories)',
        'confidence': 0.8,
        'type': 'activity_pattern',
        'related_memories': memories.take(5).map((m) => m.id).toList(),
      });
    }
    
    // Memory type pattern
    final typeCounts = <String, int>{};
    for (final memory in memories) {
      final type = memory.type.name;
      typeCounts[type] = (typeCounts[type] ?? 0) + 1;
    }
    
    if (typeCounts.isNotEmpty) {
      final dominantType = typeCounts.entries
          .reduce((a, b) => a.value > b.value ? a : b);
      
      patterns.add({
        'description': 'Most common memory type: ${dominantType.key} (${dominantType.value} memories)',
        'confidence': 0.9,
        'type': 'memory_type_pattern',
        'related_memories': memories.where((m) => m.type.name == dominantType.key).take(5).map((m) => m.id).toList(),
      });
    }
    
    return patterns;
  }
  
  /// Get memory type distribution
  Map<String, int> _getMemoryTypeDistribution(List<MemoryEntry> memories) {
    final distribution = <String, int>{};
    for (final memory in memories) {
      final type = memory.type.name;
      distribution[type] = (distribution[type] ?? 0) + 1;
    }
    return distribution;
  }
  
  /// Get activity timeline
  Map<String, int> _getActivityTimeline(List<MemoryEntry> memories) {
    final timeline = <String, int>{};
    for (final memory in memories) {
      final date = memory.timestamp.toIso8601String().split('T')[0];
      timeline[date] = (timeline[date] ?? 0) + 1;
    }
    return timeline;
  }
  
  /// Get top patterns
  List<Map<String, dynamic>> _getTopPatterns(List<MemoryEntry> memories) {
    // Simple pattern extraction
    return [
      {
        'pattern': 'recent_activity',
        'count': memories.where((m) => 
          m.timestamp.isAfter(DateTime.now().subtract(const Duration(days: 7)))
        ).length,
        'description': 'Memories created in last 7 days',
      },
      {
        'pattern': 'ai_generated',
        'count': memories.where((m) => m.type == MemoryType.ai_generated).length,
        'description': 'AI-generated memories',
      },
    ];
  }
  
  /// Get recent predictions
  Future<List<MemoryEntry>> _getRecentPredictions(String userId) async {
    final memories = await _memoryRepository.getMemories(
      source: 'predictive_analytics',
      limit: 10,
    );
    
    return memories.where((m) => 
      m.metadata['user_id'] == userId
    ).toList();
  }
  
  /// Get recent anomalies
  Future<List<MemoryEntry>> _getRecentAnomalies(String userId) async {
    final memories = await _memoryRepository.getMemories(
      source: 'predictive_analytics',
      limit: 10,
    );
    
    return memories.where((m) => 
      m.metadata['user_id'] == userId &&
      m.metadata['anomaly_data'] != null
    ).toList();
  }
}
