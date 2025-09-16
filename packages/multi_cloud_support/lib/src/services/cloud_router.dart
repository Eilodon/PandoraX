import 'dart:async';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

import '../models/cloud_provider.dart';
import '../models/cloud_config.dart';
import '../models/cloud_metrics.dart';
import '../providers/aws_provider.dart';
import '../providers/gcp_provider.dart';
import '../providers/azure_provider.dart';
import '../providers/firebase_provider.dart';

/// Smart cloud router that selects optimal cloud provider for each request
class CloudRouter {
  static final CloudRouter _instance = CloudRouter._internal();
  factory CloudRouter() => _instance;
  CloudRouter._internal();

  static final Logger _logger = Logger();
  static final Uuid _uuid = const Uuid();
  
  // Cloud providers
  final Map<CloudProviderType, CloudProvider> _providers = {};
  
  // Configuration
  CloudConfig? _config;
  bool _isInitialized = false;
  bool _isEnabled = true;
  
  // Performance tracking
  final Map<CloudProviderType, CloudMetrics> _providerMetrics = {};
  final Map<String, CloudRequest> _activeRequests = {};
  
  // Streams
  final StreamController<CloudSelectionEvent> _selectionController = 
      StreamController.broadcast();
  final StreamController<CloudMetrics> _metricsController = 
      StreamController.broadcast();
  final StreamController<CloudHealthEvent> _healthController = 
      StreamController.broadcast();

  /// Initialize cloud router
  Future<void> initialize({
    CloudConfig? config,
  }) async {
    if (_isInitialized) return;

    _logger.i('Initializing Cloud Router...');
    
    try {
      // Set configuration
      _config = config ?? CloudConfig.defaultConfig();
      
      // Initialize cloud providers
      await _initializeProviders();
      
      // Start health monitoring
      _startHealthMonitoring();
      
      _isInitialized = true;
      _logger.i('Cloud Router initialized successfully');
      
    } catch (e) {
      _logger.e('Failed to initialize Cloud Router: $e');
      rethrow;
    }
  }

  /// Initialize cloud providers
  Future<void> _initializeProviders() async {
    // Initialize AWS provider
    if (_config!.enableAWS) {
      _providers[CloudProviderType.aws] = AWSProvider();
      await _providers[CloudProviderType.aws]!.initialize();
    }
    
    // Initialize GCP provider
    if (_config!.enableGCP) {
      _providers[CloudProviderType.gcp] = GCPProvider();
      await _providers[CloudProviderType.gcp]!.initialize();
    }
    
    // Initialize Azure provider
    if (_config!.enableAzure) {
      _providers[CloudProviderType.azure] = AzureProvider();
      await _providers[CloudProviderType.azure]!.initialize();
    }
    
    // Initialize Firebase provider
    if (_config!.enableFirebase) {
      _providers[CloudProviderType.firebase] = FirebaseProvider();
      await _providers[CloudProviderType.firebase]!.initialize();
    }
    
    _logger.i('Cloud providers initialized: ${_providers.keys}');
  }

  /// Start health monitoring
  void _startHealthMonitoring() {
    Timer.periodic(Duration(minutes: 5), (timer) {
      if (_isEnabled) {
        _checkProviderHealth();
      }
    });
  }

  /// Check health of all providers
  Future<void> _checkProviderHealth() async {
    for (final entry in _providers.entries) {
      try {
        final health = await entry.value.checkHealth();
        _providerMetrics[entry.key] = health;
        
        if (health.status == CloudProviderStatus.unhealthy) {
          _healthController.add(CloudHealthEvent.unhealthy(entry.key, health.error));
        } else if (health.status == CloudProviderStatus.healthy) {
          _healthController.add(CloudHealthEvent.healthy(entry.key));
        }
        
      } catch (e) {
        _logger.e('Health check failed for ${entry.key}: $e');
        _healthController.add(CloudHealthEvent.error(entry.key, e.toString()));
      }
    }
  }

  /// Route request to optimal cloud provider
  Future<CloudResponse> routeRequest(CloudRequest request) async {
    if (!_isInitialized) {
      throw StateError('Cloud Router not initialized');
    }
    
    if (!_isEnabled) {
      throw StateError('Cloud Router is disabled');
    }
    
    try {
      // Select optimal provider
      final selectedProvider = await _selectOptimalProvider(request);
      
      // Log selection
      _selectionController.add(CloudSelectionEvent(
        requestId: request.id,
        provider: selectedProvider,
        reason: _getSelectionReason(selectedProvider, request),
        timestamp: DateTime.now(),
      ));
      
      // Execute request
      final startTime = DateTime.now();
      final response = await _executeRequest(request, selectedProvider);
      final duration = DateTime.now().difference(startTime);
      
      // Update metrics
      _updateProviderMetrics(selectedProvider, duration, true);
      
      return response;
      
    } catch (e) {
      _logger.e('Failed to route request: $e');
      
      // Update metrics
      if (request.provider != null) {
        _updateProviderMetrics(request.provider!, Duration.zero, false);
      }
      
      return CloudResponse(
        requestId: request.id,
        success: false,
        data: null,
        error: e.toString(),
        provider: request.provider,
        duration: Duration.zero,
        timestamp: DateTime.now(),
      );
    }
  }

  /// Select optimal cloud provider for request
  Future<CloudProviderType> _selectOptimalProvider(CloudRequest request) async {
    // If provider is specified, use it
    if (request.provider != null) {
      return request.provider!;
    }
    
    // Get available providers for request type
    final availableProviders = _getAvailableProviders(request.type);
    
    if (availableProviders.isEmpty) {
      throw StateError('No providers available for request type: ${request.type}');
    }
    
    // Score each provider
    CloudProviderType? bestProvider;
    double bestScore = -1.0;
    
    for (final provider in availableProviders) {
      final score = await _calculateProviderScore(provider, request);
      
      if (score > bestScore) {
        bestScore = score;
        bestProvider = provider;
      }
    }
    
    if (bestProvider == null) {
      throw StateError('No suitable provider found for request');
    }
    
    return bestProvider;
  }

  /// Get available providers for request type
  List<CloudProviderType> _getAvailableProviders(CloudRequestType type) {
    final available = <CloudProviderType>[];
    
    for (final entry in _providers.entries) {
      if (entry.value.supportsRequestType(type)) {
        available.add(entry.key);
      }
    }
    
    return available;
  }

  /// Calculate provider score based on multiple factors
  Future<double> _calculateProviderScore(CloudProviderType provider, CloudRequest request) async {
    double score = 0.0;
    
    // Base score from provider capability
    score += _getProviderCapabilityScore(provider, request.type);
    
    // Performance score
    final metrics = _providerMetrics[provider];
    if (metrics != null) {
      score += _getPerformanceScore(metrics);
    }
    
    // Cost score (lower cost is better)
    final cost = await _getProviderCost(provider, request);
    score += _getCostScore(cost);
    
    // Health score
    score += _getHealthScore(provider);
    
    // Geographic score (if applicable)
    score += _getGeographicScore(provider, request);
    
    return score;
  }

  /// Get provider capability score
  double _getProviderCapabilityScore(CloudProviderType provider, CloudRequestType type) {
    switch (provider) {
      case CloudProviderType.aws:
        return _getAWSCapabilityScore(type);
      case CloudProviderType.gcp:
        return _getGCPCapabilityScore(type);
      case CloudProviderType.azure:
        return _getAzureCapabilityScore(type);
      case CloudProviderType.firebase:
        return _getFirebaseCapabilityScore(type);
    }
  }

  /// Get AWS capability score
  double _getAWSCapabilityScore(CloudRequestType type) {
    switch (type) {
      case CloudRequestType.compute:
        return 0.9; // EC2, Lambda
      case CloudRequestType.storage:
        return 0.95; // S3
      case CloudRequestType.database:
        return 0.9; // RDS, DynamoDB
      case CloudRequestType.ml:
        return 0.85; // SageMaker
      case CloudRequestType.analytics:
        return 0.8; // CloudWatch
      default:
        return 0.7;
    }
  }

  /// Get GCP capability score
  double _getGCPCapabilityScore(CloudRequestType type) {
    switch (type) {
      case CloudRequestType.compute:
        return 0.9; // Compute Engine, Cloud Functions
      case CloudRequestType.storage:
        return 0.9; // Cloud Storage
      case CloudRequestType.database:
        return 0.95; // Cloud SQL, Firestore
      case CloudRequestType.ml:
        return 0.95; // AI Platform
      case CloudRequestType.analytics:
        return 0.9; // BigQuery
      default:
        return 0.8;
    }
  }

  /// Get Azure capability score
  double _getAzureCapabilityScore(CloudRequestType type) {
    switch (type) {
      case CloudRequestType.compute:
        return 0.85; // Virtual Machines, Functions
      case CloudRequestType.storage:
        return 0.9; // Blob Storage
      case CloudRequestType.database:
        return 0.9; // SQL Database, Cosmos DB
      case CloudRequestType.ml:
        return 0.8; // Machine Learning
      case CloudRequestType.analytics:
        return 0.85; // Application Insights
      default:
        return 0.7;
    }
  }

  /// Get Firebase capability score
  double _getFirebaseCapabilityScore(CloudRequestType type) {
    switch (type) {
      case CloudRequestType.compute:
        return 0.6; // Cloud Functions
      case CloudRequestType.storage:
        return 0.9; // Cloud Storage
      case CloudRequestType.database:
        return 0.95; // Firestore, Realtime Database
      case CloudRequestType.ml:
        return 0.7; // ML Kit
      case CloudRequestType.analytics:
        return 0.9; // Firebase Analytics
      default:
        return 0.6;
    }
  }

  /// Get performance score
  double _getPerformanceScore(CloudMetrics metrics) {
    if (metrics.status != CloudProviderStatus.healthy) {
      return 0.0;
    }
    
    // Score based on response time and availability
    final responseTimeScore = (1000 - metrics.averageResponseTime.inMilliseconds) / 1000.0;
    final availabilityScore = metrics.availability / 100.0;
    
    return (responseTimeScore + availabilityScore) / 2.0;
  }

  /// Get cost score (lower cost = higher score)
  double _getCostScore(double cost) {
    if (cost <= 0) return 0.5; // Unknown cost
    return 1.0 / (1.0 + cost); // Inverse relationship
  }

  /// Get health score
  double _getHealthScore(CloudProviderType provider) {
    final metrics = _providerMetrics[provider];
    if (metrics == null) return 0.5; // Unknown health
    
    switch (metrics.status) {
      case CloudProviderStatus.healthy:
        return 1.0;
      case CloudProviderStatus.degraded:
        return 0.7;
      case CloudProviderStatus.unhealthy:
        return 0.0;
    }
  }

  /// Get geographic score
  double _getGeographicScore(CloudProviderType provider, CloudRequest request) {
    // This would consider geographic proximity
    // For now, return neutral score
    return 0.5;
  }

  /// Get provider cost for request
  Future<double> _getProviderCost(CloudProviderType provider, CloudRequest request) async {
    // This would calculate actual cost based on request
    // For now, return placeholder values
    switch (provider) {
      case CloudProviderType.aws:
        return 0.1;
      case CloudProviderType.gcp:
        return 0.12;
      case CloudProviderType.azure:
        return 0.11;
      case CloudProviderType.firebase:
        return 0.08;
    }
  }

  /// Execute request with selected provider
  Future<CloudResponse> _executeRequest(CloudRequest request, CloudProviderType provider) async {
    final providerInstance = _providers[provider];
    if (providerInstance == null) {
      throw StateError('Provider not available: $provider');
    }
    
    return await providerInstance.executeRequest(request);
  }

  /// Update provider metrics
  void _updateProviderMetrics(CloudProviderType provider, Duration duration, bool success) {
    final current = _providerMetrics[provider];
    if (current == null) {
      _providerMetrics[provider] = CloudMetrics(
        provider: provider,
        status: success ? CloudProviderStatus.healthy : CloudProviderStatus.degraded,
        averageResponseTime: duration,
        availability: success ? 100.0 : 0.0,
        totalRequests: 1,
        successfulRequests: success ? 1 : 0,
        lastUpdated: DateTime.now(),
      );
    } else {
      final totalRequests = current.totalRequests + 1;
      final successfulRequests = current.successfulRequests + (success ? 1 : 0);
      final newResponseTime = Duration(
        milliseconds: ((current.averageResponseTime.inMilliseconds * current.totalRequests) + 
                     duration.inMilliseconds) ~/ totalRequests,
      );
      
      _providerMetrics[provider] = current.copyWith(
        averageResponseTime: newResponseTime,
        availability: (successfulRequests / totalRequests) * 100.0,
        totalRequests: totalRequests,
        successfulRequests: successfulRequests,
        lastUpdated: DateTime.now(),
      );
    }
    
    _metricsController.add(_providerMetrics[provider]!);
  }

  /// Get selection reason
  String _getSelectionReason(CloudProviderType provider, CloudRequest request) {
    final metrics = _providerMetrics[provider];
    if (metrics?.status == CloudProviderStatus.healthy) {
      return 'Healthy provider with good performance';
    } else if (metrics?.status == CloudProviderStatus.degraded) {
      return 'Degraded but available provider';
    } else {
      return 'Best available provider for request type';
    }
  }

  /// Get current metrics for all providers
  Map<CloudProviderType, CloudMetrics> get providerMetrics => 
      Map.unmodifiable(_providerMetrics);

  /// Get selection stream
  Stream<CloudSelectionEvent> get selectionStream => _selectionController.stream;

  /// Get metrics stream
  Stream<CloudMetrics> get metricsStream => _metricsController.stream;

  /// Get health stream
  Stream<CloudHealthEvent> get healthStream => _healthController.stream;

  /// Check if initialized
  bool get isInitialized => _isInitialized;

  /// Enable/disable router
  void setEnabled(bool enabled) {
    _isEnabled = enabled;
    _logger.i('Cloud Router ${enabled ? 'enabled' : 'disabled'}');
  }

  /// Dispose resources
  void dispose() {
    _selectionController.close();
    _metricsController.close();
    _healthController.close();
    
    for (final provider in _providers.values) {
      provider.dispose();
    }
  }
}

/// Cloud selection event
class CloudSelectionEvent {
  final String requestId;
  final CloudProviderType provider;
  final String reason;
  final DateTime timestamp;

  CloudSelectionEvent({
    required this.requestId,
    required this.provider,
    required this.reason,
    required this.timestamp,
  });
}

/// Cloud health event
class CloudHealthEvent {
  final CloudProviderType provider;
  final CloudHealthEventType type;
  final String? error;
  final DateTime timestamp;

  CloudHealthEvent._(this.provider, this.type, this.error, this.timestamp);

  factory CloudHealthEvent.healthy(CloudProviderType provider) {
    return CloudHealthEvent._(provider, CloudHealthEventType.healthy, null, DateTime.now());
  }

  factory CloudHealthEvent.unhealthy(CloudProviderType provider, String error) {
    return CloudHealthEvent._(provider, CloudHealthEventType.unhealthy, error, DateTime.now());
  }

  factory CloudHealthEvent.error(CloudProviderType provider, String error) {
    return CloudHealthEvent._(provider, CloudHealthEventType.error, error, DateTime.now());
  }
}

enum CloudHealthEventType {
  healthy,
  unhealthy,
  error,
}
