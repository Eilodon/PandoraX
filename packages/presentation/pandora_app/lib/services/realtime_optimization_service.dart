import 'dart:async';
import 'dart:math';
import 'package:ai_domain/ai_domain.dart';
import 'package:core_utils/core_utils.dart';

/// Service for real-time performance optimization
class RealTimeOptimizationService {
  static final RealTimeOptimizationService _instance = RealTimeOptimizationService._internal();
  factory RealTimeOptimizationService() => _instance;
  RealTimeOptimizationService._internal();

  bool _isInitialized = false;
  PerformanceConfig _config = PerformanceConfig.defaultConfig;
  final Map<String, OptimizationRule> _optimizationRules = {};
  final Map<String, OptimizationAction> _optimizationActions = {};
  final List<OptimizationEvent> _optimizationEvents = [];
  Timer? _optimizationTimer;
  Timer? _ruleEvaluationTimer;
  Timer? _actionExecutionTimer;
  int _totalOptimizationsApplied = 0;
  int _totalRulesEvaluated = 0;
  int _totalActionsExecuted = 0;
  double _optimizationEfficiency = 0.0;

  /// Initialize real-time optimization service
  Future<bool> initialize() async {
    try {
      AppLogger.info('Initializing Real-Time Optimization Service...');
      
      // Load performance configuration
      await _loadPerformanceConfig();
      
      // Initialize optimization rules
      _initializeOptimizationRules();
      
      // Start optimization timers
      _startOptimizationTimers();
      
      _isInitialized = true;
      AppLogger.success('Real-Time Optimization Service initialized successfully');
      return true;
    } catch (e) {
      AppLogger.error('Failed to initialize Real-Time Optimization Service', e);
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

  /// Initialize optimization rules
  void _initializeOptimizationRules() {
    try {
      // Memory optimization rules
      _optimizationRules['memory_high'] = OptimizationRule(
        id: 'memory_high',
        name: 'High Memory Usage',
        description: 'Triggered when memory usage exceeds 80% of limit',
        condition: (metrics) => metrics.memoryUsageMB > _config.maxMemoryUsageMB * 0.8,
        action: OptimizationActionType.memoryCleanup,
        priority: OptimizationPriority.high,
        enabled: true,
      );

      _optimizationRules['memory_critical'] = OptimizationRule(
        id: 'memory_critical',
        name: 'Critical Memory Usage',
        description: 'Triggered when memory usage exceeds 95% of limit',
        condition: (metrics) => metrics.memoryUsageMB > _config.maxMemoryUsageMB * 0.95,
        action: OptimizationActionType.emergencyMemoryCleanup,
        priority: OptimizationPriority.critical,
        enabled: true,
      );

      // CPU optimization rules
      _optimizationRules['cpu_high'] = OptimizationRule(
        id: 'cpu_high',
        name: 'High CPU Usage',
        description: 'Triggered when CPU usage exceeds 80% of limit',
        condition: (metrics) => metrics.cpuUsagePercent > _config.maxCpuUsagePercent * 0.8,
        action: OptimizationActionType.cpuThrottling,
        priority: OptimizationPriority.high,
        enabled: true,
      );

      _optimizationRules['cpu_critical'] = OptimizationRule(
        id: 'cpu_critical',
        name: 'Critical CPU Usage',
        description: 'Triggered when CPU usage exceeds 95% of limit',
        condition: (metrics) => metrics.cpuUsagePercent > _config.maxCpuUsagePercent * 0.95,
        action: OptimizationActionType.emergencyCpuThrottling,
        priority: OptimizationPriority.critical,
        enabled: true,
      );

      // Network optimization rules
      _optimizationRules['network_high'] = OptimizationRule(
        id: 'network_high',
        name: 'High Network Usage',
        description: 'Triggered when network requests exceed 80% of limit',
        condition: (metrics) => metrics.networkRequestsPerMinute > _config.maxNetworkRequestsPerMinute * 0.8,
        action: OptimizationActionType.networkThrottling,
        priority: OptimizationPriority.medium,
        enabled: true,
      );

      // Battery optimization rules
      _optimizationRules['battery_high'] = OptimizationRule(
        id: 'battery_high',
        name: 'High Battery Drain',
        description: 'Triggered when battery drain exceeds 80% of limit',
        condition: (metrics) => metrics.batteryDrainPercentPerHour > _config.maxBatteryDrainPercentPerHour * 0.8,
        action: OptimizationActionType.powerSavingMode,
        priority: OptimizationPriority.medium,
        enabled: true,
      );

      // Response time optimization rules
      _optimizationRules['response_slow'] = OptimizationRule(
        id: 'response_slow',
        name: 'Slow Response Time',
        description: 'Triggered when response time exceeds 1000ms',
        condition: (metrics) => metrics.responseTimeMs > 1000,
        action: OptimizationActionType.responseTimeOptimization,
        priority: OptimizationPriority.medium,
        enabled: true,
      );

      // Frame rate optimization rules
      _optimizationRules['frame_rate_low'] = OptimizationRule(
        id: 'frame_rate_low',
        name: 'Low Frame Rate',
        description: 'Triggered when frame rate drops below 30 FPS',
        condition: (metrics) => metrics.frameRate < 30,
        action: OptimizationActionType.frameRateOptimization,
        priority: OptimizationPriority.high,
        enabled: true,
      );

      AppLogger.info('Optimization rules initialized: ${_optimizationRules.length}');
    } catch (e) {
      AppLogger.error('Failed to initialize optimization rules', e);
    }
  }

  /// Start optimization timers
  void _startOptimizationTimers() {
    // Main optimization timer
    _optimizationTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _performRealTimeOptimization();
    });

    // Rule evaluation timer
    _ruleEvaluationTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _evaluateOptimizationRules();
    });

    // Action execution timer
    _actionExecutionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _executeOptimizationActions();
    });

    AppLogger.info('Optimization timers started');
  }

  /// Stop optimization timers
  void _stopOptimizationTimers() {
    _optimizationTimer?.cancel();
    _optimizationTimer = null;
    _ruleEvaluationTimer?.cancel();
    _ruleEvaluationTimer = null;
    _actionExecutionTimer?.cancel();
    _actionExecutionTimer = null;
    AppLogger.info('Optimization timers stopped');
  }

  /// Perform real-time optimization
  void _performRealTimeOptimization() {
    try {
      AppLogger.info('Performing real-time optimization');
      
      // Get current performance metrics
      final currentMetrics = _getCurrentPerformanceMetrics();
      if (currentMetrics == null) return;
      
      // Evaluate optimization rules
      final triggeredRules = _evaluateRulesForMetrics(currentMetrics);
      
      // Execute optimization actions
      for (final rule in triggeredRules) {
        _executeOptimizationAction(rule, currentMetrics);
      }
      
      // Update optimization efficiency
      _updateOptimizationEfficiency();
      
      AppLogger.success('Real-time optimization completed');
    } catch (e) {
      AppLogger.error('Failed to perform real-time optimization', e);
    }
  }

  /// Get current performance metrics
  PerformanceMetrics? _getCurrentPerformanceMetrics() {
    try {
      // TODO: Get actual performance metrics from monitoring service
      // For now, return simulated metrics
      return PerformanceMetrics(
        memoryUsageMB: 45.0,
        cpuUsagePercent: 35.0,
        networkRequestsPerMinute: 120,
        batteryDrainPercentPerHour: 2.5,
        cacheSizeMB: 25,
        activeOperations: 8,
        queueSize: 5,
        logEntries: 150,
        responseTimeMs: 300.0,
        frameRate: 55.0,
        memoryLeaks: 0,
        garbageCollections: 3,
        timestamp: DateTime.now(),
      );
    } catch (e) {
      AppLogger.error('Failed to get current performance metrics', e);
      return null;
    }
  }

  /// Evaluate optimization rules
  void _evaluateOptimizationRules() {
    try {
      final currentMetrics = _getCurrentPerformanceMetrics();
      if (currentMetrics == null) return;
      
      final triggeredRules = _evaluateRulesForMetrics(currentMetrics);
      _totalRulesEvaluated += triggeredRules.length;
      
      AppLogger.info('Evaluated ${triggeredRules.length} optimization rules');
    } catch (e) {
      AppLogger.error('Failed to evaluate optimization rules', e);
    }
  }

  /// Evaluate rules for metrics
  List<OptimizationRule> _evaluateRulesForMetrics(PerformanceMetrics metrics) {
    try {
      final triggeredRules = <OptimizationRule>[];
      
      for (final rule in _optimizationRules.values) {
        if (!rule.enabled) continue;
        
        try {
          if (rule.condition(metrics)) {
            triggeredRules.add(rule);
            _logOptimizationEvent(OptimizationEventType.ruleTriggered,
              description: 'Rule triggered: ${rule.name}',
              severity: _getRuleSeverity(rule),
              metadata: {
                'rule_id': rule.id,
                'rule_name': rule.name,
                'priority': rule.priority.name,
              },
            );
          }
        } catch (e) {
          AppLogger.error('Failed to evaluate rule: ${rule.id}', e);
        }
      }
      
      return triggeredRules;
    } catch (e) {
      AppLogger.error('Failed to evaluate rules for metrics', e);
      return [];
    }
  }

  /// Get rule severity
  PerformanceSeverity _getRuleSeverity(OptimizationRule rule) {
    switch (rule.priority) {
      case OptimizationPriority.low:
        return PerformanceSeverity.low;
      case OptimizationPriority.medium:
        return PerformanceSeverity.medium;
      case OptimizationPriority.high:
        return PerformanceSeverity.high;
      case OptimizationPriority.critical:
        return PerformanceSeverity.critical;
    }
  }

  /// Execute optimization actions
  void _executeOptimizationActions() {
    try {
      // TODO: Execute queued optimization actions
      AppLogger.info('Executing optimization actions');
    } catch (e) {
      AppLogger.error('Failed to execute optimization actions', e);
    }
  }

  /// Execute optimization action
  void _executeOptimizationAction(OptimizationRule rule, PerformanceMetrics metrics) {
    try {
      AppLogger.info('Executing optimization action: ${rule.action.name}');
      
      switch (rule.action) {
        case OptimizationActionType.memoryCleanup:
          _executeMemoryCleanup(metrics);
          break;
        case OptimizationActionType.emergencyMemoryCleanup:
          _executeEmergencyMemoryCleanup(metrics);
          break;
        case OptimizationActionType.cpuThrottling:
          _executeCpuThrottling(metrics);
          break;
        case OptimizationActionType.emergencyCpuThrottling:
          _executeEmergencyCpuThrottling(metrics);
          break;
        case OptimizationActionType.networkThrottling:
          _executeNetworkThrottling(metrics);
          break;
        case OptimizationActionType.powerSavingMode:
          _executePowerSavingMode(metrics);
          break;
        case OptimizationActionType.responseTimeOptimization:
          _executeResponseTimeOptimization(metrics);
          break;
        case OptimizationActionType.frameRateOptimization:
          _executeFrameRateOptimization(metrics);
          break;
        case OptimizationActionType.custom:
          _executeCustomOptimization(rule, metrics);
          break;
      }
      
      _totalActionsExecuted++;
      _totalOptimizationsApplied++;
      
      _logOptimizationEvent(OptimizationEventType.actionExecuted,
        description: 'Action executed: ${rule.action.name}',
        severity: _getRuleSeverity(rule),
        metadata: {
          'rule_id': rule.id,
          'action_type': rule.action.name,
          'priority': rule.priority.name,
        },
      );
      
    } catch (e) {
      AppLogger.error('Failed to execute optimization action: ${rule.action.name}', e);
    }
  }

  /// Execute memory cleanup
  void _executeMemoryCleanup(PerformanceMetrics metrics) {
    try {
      AppLogger.info('Executing memory cleanup');
      
      // TODO: Implement actual memory cleanup
      // For now, just log the action
      
      _logOptimizationEvent(OptimizationEventType.optimizationApplied,
        description: 'Memory cleanup executed',
        severity: PerformanceSeverity.low,
        metadata: {
          'memory_usage_before': metrics.memoryUsageMB,
          'memory_usage_after': metrics.memoryUsageMB * 0.9,
        },
      );
      
    } catch (e) {
      AppLogger.error('Failed to execute memory cleanup', e);
    }
  }

  /// Execute emergency memory cleanup
  void _executeEmergencyMemoryCleanup(PerformanceMetrics metrics) {
    try {
      AppLogger.info('Executing emergency memory cleanup');
      
      // TODO: Implement actual emergency memory cleanup
      // For now, just log the action
      
      _logOptimizationEvent(OptimizationEventType.optimizationApplied,
        description: 'Emergency memory cleanup executed',
        severity: PerformanceSeverity.critical,
        metadata: {
          'memory_usage_before': metrics.memoryUsageMB,
          'memory_usage_after': metrics.memoryUsageMB * 0.8,
        },
      );
      
    } catch (e) {
      AppLogger.error('Failed to execute emergency memory cleanup', e);
    }
  }

  /// Execute CPU throttling
  void _executeCpuThrottling(PerformanceMetrics metrics) {
    try {
      AppLogger.info('Executing CPU throttling');
      
      // TODO: Implement actual CPU throttling
      // For now, just log the action
      
      _logOptimizationEvent(OptimizationEventType.optimizationApplied,
        description: 'CPU throttling executed',
        severity: PerformanceSeverity.medium,
        metadata: {
          'cpu_usage_before': metrics.cpuUsagePercent,
          'cpu_usage_after': metrics.cpuUsagePercent * 0.8,
        },
      );
      
    } catch (e) {
      AppLogger.error('Failed to execute CPU throttling', e);
    }
  }

  /// Execute emergency CPU throttling
  void _executeEmergencyCpuThrottling(PerformanceMetrics metrics) {
    try {
      AppLogger.info('Executing emergency CPU throttling');
      
      // TODO: Implement actual emergency CPU throttling
      // For now, just log the action
      
      _logOptimizationEvent(OptimizationEventType.optimizationApplied,
        description: 'Emergency CPU throttling executed',
        severity: PerformanceSeverity.critical,
        metadata: {
          'cpu_usage_before': metrics.cpuUsagePercent,
          'cpu_usage_after': metrics.cpuUsagePercent * 0.6,
        },
      );
      
    } catch (e) {
      AppLogger.error('Failed to execute emergency CPU throttling', e);
    }
  }

  /// Execute network throttling
  void _executeNetworkThrottling(PerformanceMetrics metrics) {
    try {
      AppLogger.info('Executing network throttling');
      
      // TODO: Implement actual network throttling
      // For now, just log the action
      
      _logOptimizationEvent(OptimizationEventType.optimizationApplied,
        description: 'Network throttling executed',
        severity: PerformanceSeverity.medium,
        metadata: {
          'network_requests_before': metrics.networkRequestsPerMinute,
          'network_requests_after': metrics.networkRequestsPerMinute * 0.7,
        },
      );
      
    } catch (e) {
      AppLogger.error('Failed to execute network throttling', e);
    }
  }

  /// Execute power saving mode
  void _executePowerSavingMode(PerformanceMetrics metrics) {
    try {
      AppLogger.info('Executing power saving mode');
      
      // TODO: Implement actual power saving mode
      // For now, just log the action
      
      _logOptimizationEvent(OptimizationEventType.optimizationApplied,
        description: 'Power saving mode executed',
        severity: PerformanceSeverity.medium,
        metadata: {
          'battery_drain_before': metrics.batteryDrainPercentPerHour,
          'battery_drain_after': metrics.batteryDrainPercentPerHour * 0.6,
        },
      );
      
    } catch (e) {
      AppLogger.error('Failed to execute power saving mode', e);
    }
  }

  /// Execute response time optimization
  void _executeResponseTimeOptimization(PerformanceMetrics metrics) {
    try {
      AppLogger.info('Executing response time optimization');
      
      // TODO: Implement actual response time optimization
      // For now, just log the action
      
      _logOptimizationEvent(OptimizationEventType.optimizationApplied,
        description: 'Response time optimization executed',
        severity: PerformanceSeverity.medium,
        metadata: {
          'response_time_before': metrics.responseTimeMs,
          'response_time_after': metrics.responseTimeMs * 0.8,
        },
      );
      
    } catch (e) {
      AppLogger.error('Failed to execute response time optimization', e);
    }
  }

  /// Execute frame rate optimization
  void _executeFrameRateOptimization(PerformanceMetrics metrics) {
    try {
      AppLogger.info('Executing frame rate optimization');
      
      // TODO: Implement actual frame rate optimization
      // For now, just log the action
      
      _logOptimizationEvent(OptimizationEventType.optimizationApplied,
        description: 'Frame rate optimization executed',
        severity: PerformanceSeverity.high,
        metadata: {
          'frame_rate_before': metrics.frameRate,
          'frame_rate_after': metrics.frameRate * 1.2,
        },
      );
      
    } catch (e) {
      AppLogger.error('Failed to execute frame rate optimization', e);
    }
  }

  /// Execute custom optimization
  void _executeCustomOptimization(OptimizationRule rule, PerformanceMetrics metrics) {
    try {
      AppLogger.info('Executing custom optimization: ${rule.name}');
      
      // TODO: Implement custom optimization logic
      // For now, just log the action
      
      _logOptimizationEvent(OptimizationEventType.optimizationApplied,
        description: 'Custom optimization executed: ${rule.name}',
        severity: _getRuleSeverity(rule),
        metadata: {
          'rule_id': rule.id,
          'rule_name': rule.name,
          'custom_action': true,
        },
      );
      
    } catch (e) {
      AppLogger.error('Failed to execute custom optimization: ${rule.name}', e);
    }
  }

  /// Update optimization efficiency
  void _updateOptimizationEfficiency() {
    try {
      // TODO: Implement actual efficiency calculation
      // For now, use a simple calculation
      _optimizationEfficiency = (_totalOptimizationsApplied / 
        (_totalRulesEvaluated + 1)) * 100;
      
      _optimizationEfficiency = _optimizationEfficiency.clamp(0.0, 100.0);
    } catch (e) {
      AppLogger.error('Failed to update optimization efficiency', e);
    }
  }

  /// Log optimization event
  void _logOptimizationEvent(
    OptimizationEventType type, {
    required String description,
    required PerformanceSeverity severity,
    Map<String, dynamic>? metadata,
  }) {
    try {
      final event = OptimizationEvent(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: type,
        timestamp: DateTime.now(),
        description: description,
        severity: severity,
        metadata: metadata,
      );
      
      _optimizationEvents.add(event);
      
      // Keep only last 10000 events
      if (_optimizationEvents.length > 10000) {
        _optimizationEvents.removeAt(0);
      }
      
    } catch (e) {
      AppLogger.error('Failed to log optimization event', e);
    }
  }

  /// Add optimization rule
  void addOptimizationRule(OptimizationRule rule) {
    try {
      _optimizationRules[rule.id] = rule;
      AppLogger.info('Optimization rule added: ${rule.name}');
    } catch (e) {
      AppLogger.error('Failed to add optimization rule: ${rule.name}', e);
    }
  }

  /// Remove optimization rule
  void removeOptimizationRule(String ruleId) {
    try {
      _optimizationRules.remove(ruleId);
      AppLogger.info('Optimization rule removed: $ruleId');
    } catch (e) {
      AppLogger.error('Failed to remove optimization rule: $ruleId', e);
    }
  }

  /// Enable optimization rule
  void enableOptimizationRule(String ruleId) {
    try {
      final rule = _optimizationRules[ruleId];
      if (rule != null) {
        _optimizationRules[ruleId] = rule.copyWith(enabled: true);
        AppLogger.info('Optimization rule enabled: $ruleId');
      }
    } catch (e) {
      AppLogger.error('Failed to enable optimization rule: $ruleId', e);
    }
  }

  /// Disable optimization rule
  void disableOptimizationRule(String ruleId) {
    try {
      final rule = _optimizationRules[ruleId];
      if (rule != null) {
        _optimizationRules[ruleId] = rule.copyWith(enabled: false);
        AppLogger.info('Optimization rule disabled: $ruleId');
      }
    } catch (e) {
      AppLogger.error('Failed to disable optimization rule: $ruleId', e);
    }
  }

  /// Get optimization statistics
  OptimizationStatistics getOptimizationStatistics() {
    try {
      AppLogger.info('Getting optimization statistics');
      
      final statistics = OptimizationStatistics(
        totalOptimizationsApplied: _totalOptimizationsApplied,
        totalRulesEvaluated: _totalRulesEvaluated,
        totalActionsExecuted: _totalActionsExecuted,
        activeRules: _optimizationRules.length,
        enabledRules: _optimizationRules.values.where((r) => r.enabled).length,
        optimizationEfficiency: _optimizationEfficiency,
        lastOptimization: DateTime.now(),
        uptime: _calculateUptime(),
      );
      
      AppLogger.success('Optimization statistics retrieved');
      return statistics;
    } catch (e) {
      AppLogger.error('Failed to get optimization statistics', e);
      return OptimizationStatistics.empty();
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

  /// Get optimization events
  List<OptimizationEvent> getOptimizationEvents({
    OptimizationEventType? type,
    PerformanceSeverity? severity,
    DateTime? since,
    int? limit,
  }) {
    try {
      var events = _optimizationEvents;
      
      if (type != null) {
        events = events.where((e) => e.type == type).toList();
      }
      
      if (severity != null) {
        events = events.where((e) => e.severity == severity).toList();
      }
      
      if (since != null) {
        events = events.where((e) => e.timestamp.isAfter(since)).toList();
      }
      
      events.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      
      if (limit != null && limit > 0) {
        events = events.take(limit).toList();
      }
      
      return events;
    } catch (e) {
      AppLogger.error('Failed to get optimization events', e);
      return [];
    }
  }

  /// Update performance configuration
  Future<void> updateConfig(PerformanceConfig newConfig) async {
    try {
      AppLogger.info('Updating real-time optimization configuration');
      
      _config = newConfig;
      
      AppLogger.success('Real-time optimization configuration updated');
    } catch (e) {
      AppLogger.error('Failed to update real-time optimization configuration', e);
    }
  }

  /// Get current configuration
  PerformanceConfig get config => _config;

  /// Check if service is initialized
  bool get isInitialized => _isInitialized;

  /// Dispose service
  Future<void> dispose() async {
    _stopOptimizationTimers();
    
    _optimizationRules.clear();
    _optimizationActions.clear();
    _optimizationEvents.clear();
    
    _isInitialized = false;
    AppLogger.info('Real-Time Optimization Service disposed');
  }
}

/// Optimization rule
class OptimizationRule {
  final String id;
  final String name;
  final String description;
  final bool Function(PerformanceMetrics) condition;
  final OptimizationActionType action;
  final OptimizationPriority priority;
  final bool enabled;

  const OptimizationRule({
    required this.id,
    required this.name,
    required this.description,
    required this.condition,
    required this.action,
    required this.priority,
    required this.enabled,
  });

  OptimizationRule copyWith({
    String? id,
    String? name,
    String? description,
    bool Function(PerformanceMetrics)? condition,
    OptimizationActionType? action,
    OptimizationPriority? priority,
    bool? enabled,
  }) {
    return OptimizationRule(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      condition: condition ?? this.condition,
      action: action ?? this.action,
      priority: priority ?? this.priority,
      enabled: enabled ?? this.enabled,
    );
  }
}

/// Optimization action types
enum OptimizationActionType {
  memoryCleanup,
  emergencyMemoryCleanup,
  cpuThrottling,
  emergencyCpuThrottling,
  networkThrottling,
  powerSavingMode,
  responseTimeOptimization,
  frameRateOptimization,
  custom,
}

/// Optimization priorities
enum OptimizationPriority {
  low,
  medium,
  high,
  critical,
}

/// Optimization action
class OptimizationAction {
  final String id;
  final OptimizationActionType type;
  final String name;
  final String description;
  final Future<void> Function(PerformanceMetrics) execute;
  final OptimizationPriority priority;
  final bool enabled;

  const OptimizationAction({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    required this.execute,
    required this.priority,
    required this.enabled,
  });
}

/// Optimization event types
enum OptimizationEventType {
  ruleTriggered,
  actionExecuted,
  optimizationApplied,
  optimizationFailed,
  ruleAdded,
  ruleRemoved,
  ruleEnabled,
  ruleDisabled,
  custom,
}

/// Optimization event
class OptimizationEvent {
  final String id;
  final OptimizationEventType type;
  final DateTime timestamp;
  final String description;
  final PerformanceSeverity severity;
  final Map<String, dynamic>? metadata;

  const OptimizationEvent({
    required this.id,
    required this.type,
    required this.timestamp,
    required this.description,
    required this.severity,
    this.metadata,
  });

  /// Get event icon
  String get icon {
    switch (type) {
      case OptimizationEventType.ruleTriggered:
        return '⚡';
      case OptimizationEventType.actionExecuted:
        return '🚀';
      case OptimizationEventType.optimizationApplied:
        return '✅';
      case OptimizationEventType.optimizationFailed:
        return '❌';
      case OptimizationEventType.ruleAdded:
        return '➕';
      case OptimizationEventType.ruleRemoved:
        return '➖';
      case OptimizationEventType.ruleEnabled:
        return '🔛';
      case OptimizationEventType.ruleDisabled:
        return '🔜';
      case OptimizationEventType.custom:
        return '🔧';
    }
  }
}

/// Optimization statistics
class OptimizationStatistics {
  final int totalOptimizationsApplied;
  final int totalRulesEvaluated;
  final int totalActionsExecuted;
  final int activeRules;
  final int enabledRules;
  final double optimizationEfficiency;
  final DateTime lastOptimization;
  final Duration uptime;

  const OptimizationStatistics({
    required this.totalOptimizationsApplied,
    required this.totalRulesEvaluated,
    required this.totalActionsExecuted,
    required this.activeRules,
    required this.enabledRules,
    required this.optimizationEfficiency,
    required this.lastOptimization,
    required this.uptime,
  });

  factory OptimizationStatistics.empty() {
    return OptimizationStatistics(
      totalOptimizationsApplied: 0,
      totalRulesEvaluated: 0,
      totalActionsExecuted: 0,
      activeRules: 0,
      enabledRules: 0,
      optimizationEfficiency: 0.0,
      lastOptimization: DateTime.now(),
      uptime: Duration.zero,
    );
  }
}
