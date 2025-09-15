import 'dart:async';
import 'package:ai_core/ai_core.dart';
import '../datasources/on_device_model_service.dart';
import '../datasources/adaptive_health_monitor.dart';

/// Smart routing service that decides between on-device and cloud AI
class AIRouterService {
  final OnDeviceModelService _onDeviceService;
  final AIService _cloudService;
  final AdaptiveHealthMonitor _healthMonitor;
  final NetworkDetector _networkDetector;
  final DeviceCapabilityDetector _deviceDetector;
  
  // Routing state
  bool _isUsingOnDevice = false;
  String _currentModel = 'None';
  AITaskType _lastTaskType = AITaskType.quickResponse;
  DateTime _lastSwitchTime = DateTime.now();
  
  // Configuration
  final double _minOnDeviceSuccessRate;
  final int _maxOnDeviceLatencyMs;
  final int _switchCooldownMs;
  final bool _enableAutoSwitching;
  
  AIRouterService({
    required OnDeviceModelService onDeviceService,
    required AIService cloudService,
    required AdaptiveHealthMonitor healthMonitor,
    required NetworkDetector networkDetector,
    required DeviceCapabilityDetector deviceDetector,
    double minOnDeviceSuccessRate = 0.8,
    int maxOnDeviceLatencyMs = 5000,
    int switchCooldownMs = 30000, // 30 seconds
    bool enableAutoSwitching = true,
  }) : _onDeviceService = onDeviceService,
       _cloudService = cloudService,
       _healthMonitor = healthMonitor,
       _networkDetector = networkDetector,
       _deviceDetector = deviceDetector,
       _minOnDeviceSuccessRate = minOnDeviceSuccessRate,
       _maxOnDeviceLatencyMs = maxOnDeviceLatencyMs,
       _switchCooldownMs = switchCooldownMs,
       _enableAutoSwitching = enableAutoSwitching;

  /// Route a request to the appropriate AI service
  Future<String> routeRequest(String prompt, AITaskType taskType) async {
    _lastTaskType = taskType;
    
    // Determine routing strategy
    final routingDecision = await _determineRoutingStrategy(prompt, taskType);
    
    try {
      String response;
      String modelUsed;
      bool isOnDevice;
      
      if (routingDecision.useOnDevice) {
        // Use on-device service
        response = await _executeOnDevice(prompt, taskType);
        modelUsed = _onDeviceService.currentModel;
        isOnDevice = true;
        _isUsingOnDevice = true;
        _currentModel = modelUsed;
      } else {
        // Use cloud service
        response = await _executeCloud(prompt, taskType);
        modelUsed = 'Gemini';
        isOnDevice = false;
        _isUsingOnDevice = false;
        _currentModel = modelUsed;
      }
      
      // Record performance metrics
      _recordPerformanceMetrics(routingDecision, true, 0);
      
      return response;
    } catch (e) {
      // Handle failure and potentially retry with fallback
      return await _handleFailure(prompt, taskType, routingDecision, e);
    }
  }

  /// Route chat request with conversation history
  Future<String> routeChatRequest(String prompt, List<ChatMessage> history, AITaskType taskType) async {
    _lastTaskType = taskType;
    
    final routingDecision = await _determineRoutingStrategy(prompt, taskType);
    
    try {
      String response;
      String modelUsed;
      bool isOnDevice;
      
      if (routingDecision.useOnDevice) {
        response = await _executeOnDeviceChat(prompt, history, taskType);
        modelUsed = _onDeviceService.currentModel;
        isOnDevice = true;
        _isUsingOnDevice = true;
        _currentModel = modelUsed;
      } else {
        response = await _executeCloudChat(prompt, history, taskType);
        modelUsed = 'Gemini';
        isOnDevice = false;
        _isUsingOnDevice = false;
        _currentModel = modelUsed;
      }
      
      _recordPerformanceMetrics(routingDecision, true, 0);
      return response;
    } catch (e) {
      return await _handleChatFailure(prompt, history, taskType, routingDecision, e);
    }
  }

  /// Get current routing status
  AIRoutingStatus get routingStatus => AIRoutingStatus(
    isUsingOnDevice: _isUsingOnDevice,
    currentModel: _currentModel,
    lastTaskType: _lastTaskType,
    lastSwitchTime: _lastSwitchTime,
    healthSnapshot: _healthMonitor.snapshot(),
    networkStatus: _networkDetector.isConnected,
  );

  /// Get routing recommendations
  List<RoutingRecommendation> getRoutingRecommendations() {
    final recommendations = <RoutingRecommendation>[];
    final health = _healthMonitor.snapshot();
    
    if (_isUsingOnDevice) {
      if (health.successRate < _minOnDeviceSuccessRate) {
        recommendations.add(RoutingRecommendation(
          type: RecommendationType.switchToCloud,
          reason: 'On-device success rate is low (${(health.successRate * 100).toStringAsFixed(1)}%)',
          priority: RecommendationPriority.high,
        ));
      }
      
      if (health.p95LatencyMs > _maxOnDeviceLatencyMs) {
        recommendations.add(RoutingRecommendation(
          type: RecommendationType.switchToCloud,
          reason: 'On-device latency is high (${health.p95LatencyMs}ms)',
          priority: RecommendationPriority.medium,
        ));
      }
    } else {
      if (health.isHealthy && _onDeviceService.isAvailable) {
        recommendations.add(RoutingRecommendation(
          type: RecommendationType.switchToOnDevice,
          reason: 'On-device model is healthy and available',
          priority: RecommendationPriority.low,
        ));
      }
    }
    
    return recommendations;
  }

  /// Force switch to specific service
  Future<bool> forceSwitchToOnDevice() async {
    if (!_onDeviceService.isAvailable) {
      return false;
    }
    
    _isUsingOnDevice = true;
    _currentModel = _onDeviceService.currentModel;
    _lastSwitchTime = DateTime.now();
    return true;
  }

  /// Force switch to cloud service
  Future<bool> forceSwitchToCloud() async {
    _isUsingOnDevice = false;
    _currentModel = 'Gemini';
    _lastSwitchTime = DateTime.now();
    return true;
  }

  /// Get routing statistics
  RoutingStatistics getStatistics() {
    final health = _healthMonitor.snapshot();
    return RoutingStatistics(
      totalRequests: health.totalSamples,
      onDeviceRequests: _isUsingOnDevice ? health.totalSamples : 0,
      cloudRequests: !_isUsingOnDevice ? health.totalSamples : 0,
      averageLatencyMs: health.p50LatencyMs,
      successRate: health.successRate,
      lastSwitchTime: _lastSwitchTime,
    );
  }

  // Private methods

  Future<RoutingDecision> _determineRoutingStrategy(String prompt, AITaskType taskType) async {
    // Check if auto-switching is enabled and cooldown has passed
    final canSwitch = _enableAutoSwitching && 
                     DateTime.now().difference(_lastSwitchTime).inMilliseconds > _switchCooldownMs;
    
    // Check network connectivity
    final isNetworkAvailable = await _networkDetector.isConnected;
    
    // Check on-device availability and health
    final isOnDeviceAvailable = _onDeviceService.isAvailable;
    final isOnDeviceHealthy = _onDeviceService.isHealthy;
    final healthSnapshot = _healthMonitor.snapshot();
    
    // Check device capability for the task
    final deviceCapability = await _deviceDetector.getCapability();
    final isTaskSuitableForOnDevice = _isTaskSuitableForOnDevice(taskType, deviceCapability);
    
    // Decision logic
    if (!isNetworkAvailable && isOnDeviceAvailable) {
      // No network, must use on-device
      return RoutingDecision(
        useOnDevice: true,
        reason: 'No network connectivity',
        confidence: 1.0,
        fallbackAvailable: false,
      );
    }
    
    if (!isOnDeviceAvailable) {
      // No on-device model, use cloud
      return RoutingDecision(
        useOnDevice: false,
        reason: 'On-device model not available',
        confidence: 1.0,
        fallbackAvailable: isNetworkAvailable,
      );
    }
    
    if (!isOnDeviceHealthy && canSwitch) {
      // On-device is unhealthy, switch to cloud
      return RoutingDecision(
        useOnDevice: false,
        reason: 'On-device model is unhealthy',
        confidence: 0.8,
        fallbackAvailable: isNetworkAvailable,
      );
    }
    
    if (!isTaskSuitableForOnDevice && canSwitch) {
      // Task not suitable for on-device, use cloud
      return RoutingDecision(
        useOnDevice: false,
        reason: 'Task not suitable for on-device model',
        confidence: 0.7,
        fallbackAvailable: isNetworkAvailable,
      );
    }
    
    if (isOnDeviceAvailable && isOnDeviceHealthy && isTaskSuitableForOnDevice) {
      // Use on-device
      return RoutingDecision(
        useOnDevice: true,
        reason: 'On-device model is optimal',
        confidence: 0.9,
        fallbackAvailable: isNetworkAvailable,
      );
    }
    
    // Default to current routing
    return RoutingDecision(
      useOnDevice: _isUsingOnDevice,
      reason: 'Maintaining current routing',
      confidence: 0.5,
      fallbackAvailable: isNetworkAvailable,
    );
  }

  bool _isTaskSuitableForOnDevice(AITaskType taskType, DeviceCapability capability) {
    switch (taskType) {
      case AITaskType.quickResponse:
      case AITaskType.simpleSummary:
      case AITaskType.realTimeChat:
        return true;
      case AITaskType.complexAnalysis:
        return capability.ramGB >= 4; // Need more RAM for complex analysis
      case AITaskType.creativeWriting:
        return capability.ramGB >= 6; // Need even more RAM for creative tasks
    }
  }

  Future<String> _executeOnDevice(String prompt, AITaskType taskType) async {
    return await _onDeviceService.generateResponse(prompt);
  }

  Future<String> _executeOnDeviceChat(String prompt, List<ChatMessage> history, AITaskType taskType) async {
    return await _onDeviceService.generateChatResponse(prompt, history);
  }

  Future<String> _executeCloud(String prompt, AITaskType taskType) async {
    return await _cloudService.generateResponse(prompt);
  }

  Future<String> _executeCloudChat(String prompt, List<ChatMessage> history, AITaskType taskType) async {
    return await _cloudService.generateChatResponse(prompt, _convertToMapList(history));
  }

  Future<String> _handleFailure(String prompt, AITaskType taskType, RoutingDecision decision, dynamic error) async {
    if (decision.useOnDevice && decision.fallbackAvailable) {
      // Try cloud fallback
      try {
        final response = await _executeCloud(prompt, taskType);
        _isUsingOnDevice = false;
        _currentModel = 'Gemini';
        _lastSwitchTime = DateTime.now();
        return response;
      } catch (e) {
        throw AIRoutingException('Both on-device and cloud services failed', e);
      }
    } else {
      throw AIRoutingException('AI service failed: $error', error);
    }
  }

  Future<String> _handleChatFailure(String prompt, List<ChatMessage> history, AITaskType taskType, RoutingDecision decision, dynamic error) async {
    if (decision.useOnDevice && decision.fallbackAvailable) {
      try {
        final response = await _executeCloudChat(prompt, history, taskType);
        _isUsingOnDevice = false;
        _currentModel = 'Gemini';
        _lastSwitchTime = DateTime.now();
        return response;
      } catch (e) {
        throw AIRoutingException('Both on-device and cloud services failed', e);
      }
    } else {
      throw AIRoutingException('AI service failed: $error', error);
    }
  }

  void _recordPerformanceMetrics(RoutingDecision decision, bool success, int latencyMs) {
    _healthMonitor.record(success, latencyMs);
  }

  List<Map<String, String>> _convertToMapList(List<ChatMessage> messages) {
    return messages.map((message) => {
      'role': message.role.name,
      'content': message.content,
    }).toList();
  }
}

/// AI Task Types for routing decisions
enum AITaskType {
  quickResponse,
  simpleSummary,
  realTimeChat,
  complexAnalysis,
  creativeWriting,
}

/// Routing decision result
class RoutingDecision {
  final bool useOnDevice;
  final String reason;
  final double confidence;
  final bool fallbackAvailable;

  const RoutingDecision({
    required this.useOnDevice,
    required this.reason,
    required this.confidence,
    required this.fallbackAvailable,
  });
}

/// Routing status information
class AIRoutingStatus {
  final bool isUsingOnDevice;
  final String currentModel;
  final AITaskType lastTaskType;
  final DateTime lastSwitchTime;
  final HealthSnapshot healthSnapshot;
  final bool networkStatus;

  const AIRoutingStatus({
    required this.isUsingOnDevice,
    required this.currentModel,
    required this.lastTaskType,
    required this.lastSwitchTime,
    required this.healthSnapshot,
    required this.networkStatus,
  });
}

/// Routing recommendation
class RoutingRecommendation {
  final RecommendationType type;
  final String reason;
  final RecommendationPriority priority;

  const RoutingRecommendation({
    required this.type,
    required this.reason,
    required this.priority,
  });
}

enum RecommendationType {
  switchToOnDevice,
  switchToCloud,
  optimizeSettings,
  downloadModel,
}

enum RecommendationPriority {
  low,
  medium,
  high,
  critical,
}

/// Routing statistics
class RoutingStatistics {
  final int totalRequests;
  final int onDeviceRequests;
  final int cloudRequests;
  final int averageLatencyMs;
  final double successRate;
  final DateTime lastSwitchTime;

  const RoutingStatistics({
    required this.totalRequests,
    required this.onDeviceRequests,
    required this.cloudRequests,
    required this.averageLatencyMs,
    required this.successRate,
    required this.lastSwitchTime,
  });
}

/// Custom exception for routing errors
class AIRoutingException implements Exception {
  final String message;
  final dynamic originalError;
  
  const AIRoutingException(this.message, [this.originalError]);
  
  @override
  String toString() => 'AIRoutingException: $message';
}

/// Network detection interface
abstract class NetworkDetector {
  Future<bool> get isConnected;
}

/// Device capability detection interface
abstract class DeviceCapabilityDetector {
  Future<DeviceCapability> getCapability();
}

/// Device capability information
class DeviceCapability {
  final int ramGB;
  final int storageGB;
  final int cpuCores;
  final bool hasGpu;
  final int maxModelSize;

  const DeviceCapability({
    required this.ramGB,
    required this.storageGB,
    required this.cpuCores,
    required this.hasGpu,
    required this.maxModelSize,
  });
}
