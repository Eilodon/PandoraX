import 'dart:async';
import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';
import 'package:crypto/crypto.dart';

import '../models/local_model.dart';
import '../models/global_model.dart';
import '../models/model_update.dart';
import '../models/training_data.dart';
import '../privacy/differential_privacy.dart';
import '../privacy/secure_aggregation.dart';
import '../communication/federation_client.dart';
import '../training/local_trainer.dart';
import '../training/global_trainer.dart';

/// Main federated learning service
class FederatedLearner {
  static final FederatedLearner _instance = FederatedLearner._internal();
  factory FederatedLearner() => _instance;
  FederatedLearner._internal();

  static final Logger _logger = Logger();
  static final Uuid _uuid = const Uuid();
  
  // Core services
  late LocalTrainer _localTrainer;
  late GlobalTrainer _globalTrainer;
  late FederationClient _federationClient;
  late DifferentialPrivacy _differentialPrivacy;
  late SecureAggregation _secureAggregation;
  
  // State
  bool _isInitialized = false;
  bool _isParticipating = false;
  String? _federationId;
  String? _participantId;
  
  // Local model
  LocalModel? _localModel;
  GlobalModel? _globalModel;
  
  // Training data
  final List<TrainingData> _localTrainingData = [];
  
  // Privacy settings
  double _privacyEpsilon = 1.0;
  double _privacyDelta = 1e-5;
  
  // Streams
  final StreamController<FederatedLearningEvent> _eventController = 
      StreamController.broadcast();
  final StreamController<ModelUpdate> _updateController = 
      StreamController.broadcast();
  final StreamController<PrivacyMetrics> _privacyController = 
      StreamController.broadcast();

  /// Initialize federated learning
  Future<void> initialize({
    String? federationId,
    String? participantId,
    double? privacyEpsilon,
    double? privacyDelta,
  }) async {
    if (_isInitialized) return;

    _logger.i('Initializing Federated Learning...');
    
    try {
      // Set configuration
      _federationId = federationId ?? _uuid.v4();
      _participantId = participantId ?? _uuid.v4();
      _privacyEpsilon = privacyEpsilon ?? 1.0;
      _privacyDelta = privacyDelta ?? 1e-5;
      
      // Initialize core services
      _localTrainer = LocalTrainer();
      _globalTrainer = GlobalTrainer();
      _federationClient = FederationClient();
      _differentialPrivacy = DifferentialPrivacy();
      _secureAggregation = SecureAggregation();
      
      // Initialize services
      await _localTrainer.initialize();
      await _globalTrainer.initialize();
      await _federationClient.initialize();
      await _differentialPrivacy.initialize();
      await _secureAggregation.initialize();
      
      // Initialize local model
      _localModel = LocalModel(
        id: _uuid.v4(),
        participantId: _participantId!,
        version: 1,
        parameters: {},
        metadata: {},
        timestamp: DateTime.now(),
      );
      
      _isInitialized = true;
      _logger.i('Federated Learning initialized successfully');
      
      _eventController.add(FederatedLearningEvent.initialized);
      
    } catch (e) {
      _logger.e('Failed to initialize Federated Learning: $e');
      _eventController.add(FederatedLearningEvent.error(e.toString()));
      rethrow;
    }
  }

  /// Join federation
  Future<void> joinFederation(String federationUrl) async {
    if (!_isInitialized) {
      throw StateError('Federated Learning not initialized');
    }
    
    if (_isParticipating) return;

    _logger.i('Joining federation: $federationUrl');
    
    try {
      // Connect to federation server
      await _federationClient.connect(federationUrl);
      
      // Register participant
      await _federationClient.registerParticipant(
        _participantId!,
        _federationId!,
      );
      
      _isParticipating = true;
      _logger.i('Successfully joined federation');
      
      _eventController.add(FederatedLearningEvent.joined);
      
    } catch (e) {
      _logger.e('Failed to join federation: $e');
      _eventController.add(FederatedLearningEvent.error(e.toString()));
      rethrow;
    }
  }

  /// Leave federation
  Future<void> leaveFederation() async {
    if (!_isParticipating) return;

    _logger.i('Leaving federation...');
    
    try {
      // Unregister participant
      await _federationClient.unregisterParticipant(_participantId!);
      
      // Disconnect from server
      await _federationClient.disconnect();
      
      _isParticipating = false;
      _logger.i('Successfully left federation');
      
      _eventController.add(FederatedLearningEvent.left);
      
    } catch (e) {
      _logger.e('Failed to leave federation: $e');
      _eventController.add(FederatedLearningEvent.error(e.toString()));
    }
  }

  /// Add local training data
  void addTrainingData(TrainingData data) {
    _localTrainingData.add(data);
    _logger.d('Added training data. Total: ${_localTrainingData.length}');
  }

  /// Start local training
  Future<void> startLocalTraining() async {
    if (!_isInitialized) {
      throw StateError('Federated Learning not initialized');
    }
    
    if (_localTrainingData.isEmpty) {
      _logger.w('No local training data available');
      return;
    }

    _logger.i('Starting local training...');
    
    try {
      // Train local model
      final updatedModel = await _localTrainer.train(
        _localModel!,
        _localTrainingData,
      );
      
      // Apply differential privacy
      final privacyPreservedModel = await _differentialPrivacy.addNoise(
        updatedModel,
        _privacyEpsilon,
        _privacyDelta,
      );
      
      // Update local model
      _localModel = privacyPreservedModel;
      
      _logger.i('Local training completed');
      _eventController.add(FederatedLearningEvent.localTrainingCompleted);
      
    } catch (e) {
      _logger.e('Failed to complete local training: $e');
      _eventController.add(FederatedLearningEvent.error(e.toString()));
      rethrow;
    }
  }

  /// Participate in global aggregation
  Future<void> participateInAggregation() async {
    if (!_isParticipating) {
      throw StateError('Not participating in federation');
    }
    
    if (_localModel == null) {
      throw StateError('No local model available');
    }

    _logger.i('Participating in global aggregation...');
    
    try {
      // Create model update
      final modelUpdate = ModelUpdate(
        id: _uuid.v4(),
        participantId: _participantId!,
        federationId: _federationId!,
        modelId: _localModel!.id,
        parameters: _localModel!.parameters,
        metadata: _localModel!.metadata,
        timestamp: DateTime.now(),
        privacyEpsilon: _privacyEpsilon,
        privacyDelta: _privacyDelta,
      );
      
      // Send update to federation
      await _federationClient.sendModelUpdate(modelUpdate);
      
      _logger.i('Model update sent to federation');
      _eventController.add(FederatedLearningEvent.updateSent);
      
    } catch (e) {
      _logger.e('Failed to participate in aggregation: $e');
      _eventController.add(FederatedLearningEvent.error(e.toString()));
      rethrow;
    }
  }

  /// Receive global model update
  Future<void> receiveGlobalModel(GlobalModel globalModel) async {
    if (!_isInitialized) {
      throw StateError('Federated Learning not initialized');
    }

    _logger.i('Receiving global model update...');
    
    try {
      // Validate global model
      if (!_validateGlobalModel(globalModel)) {
        throw StateError('Invalid global model received');
      }
      
      // Update global model
      _globalModel = globalModel;
      
      // Merge with local model
      _localModel = await _mergeModels(_localModel!, globalModel);
      
      _logger.i('Global model update received and merged');
      _eventController.add(FederatedLearningEvent.globalModelReceived);
      
    } catch (e) {
      _logger.e('Failed to receive global model: $e');
      _eventController.add(FederatedLearningEvent.error(e.toString()));
      rethrow;
    }
  }

  /// Validate global model
  bool _validateGlobalModel(GlobalModel globalModel) {
    // Check if model is from same federation
    if (globalModel.federationId != _federationId) {
      return false;
    }
    
    // Check model version
    if (globalModel.version <= (_globalModel?.version ?? 0)) {
      return false;
    }
    
    // Check model integrity
    final expectedHash = _calculateModelHash(globalModel);
    if (globalModel.hash != expectedHash) {
      return false;
    }
    
    return true;
  }

  /// Calculate model hash
  String _calculateModelHash(GlobalModel model) {
    final modelData = jsonEncode({
      'id': model.id,
      'version': model.version,
      'parameters': model.parameters,
      'metadata': model.metadata,
    });
    
    final bytes = utf8.encode(modelData);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Merge local and global models
  Future<LocalModel> _mergeModels(LocalModel localModel, GlobalModel globalModel) async {
    // Simple weighted average merge
    final mergedParameters = <String, dynamic>{};
    
    for (final key in globalModel.parameters.keys) {
      final globalValue = globalModel.parameters[key];
      final localValue = localModel.parameters[key];
      
      if (globalValue is num && localValue is num) {
        // Weighted average (70% global, 30% local)
        mergedParameters[key] = (globalValue * 0.7) + (localValue * 0.3);
      } else {
        // Use global value if types don't match
        mergedParameters[key] = globalValue;
      }
    }
    
    return LocalModel(
      id: _uuid.v4(),
      participantId: _participantId!,
      version: globalModel.version + 1,
      parameters: mergedParameters,
      metadata: {
        ...globalModel.metadata,
        'merged_from_global': true,
        'merge_timestamp': DateTime.now().toIso8601String(),
      },
      timestamp: DateTime.now(),
    );
  }

  /// Get privacy metrics
  PrivacyMetrics getPrivacyMetrics() {
    return PrivacyMetrics(
      epsilon: _privacyEpsilon,
      delta: _privacyDelta,
      dataPoints: _localTrainingData.length,
      lastUpdate: DateTime.now(),
    );
  }

  /// Set privacy parameters
  void setPrivacyParameters(double epsilon, double delta) {
    _privacyEpsilon = epsilon;
    _privacyDelta = delta;
    
    _logger.i('Privacy parameters updated: ε=$epsilon, δ=$delta');
    _privacyController.add(getPrivacyMetrics());
  }

  /// Get current local model
  LocalModel? get localModel => _localModel;

  /// Get current global model
  GlobalModel? get globalModel => _globalModel;

  /// Check if participating
  bool get isParticipating => _isParticipating;

  /// Get event stream
  Stream<FederatedLearningEvent> get eventStream => _eventController.stream;

  /// Get update stream
  Stream<ModelUpdate> get updateStream => _updateController.stream;

  /// Get privacy stream
  Stream<PrivacyMetrics> get privacyStream => _privacyController.stream;

  /// Dispose resources
  void dispose() {
    _eventController.close();
    _updateController.close();
    _privacyController.close();
    _localTrainer.dispose();
    _globalTrainer.dispose();
    _federationClient.dispose();
    _differentialPrivacy.dispose();
    _secureAggregation.dispose();
  }
}

/// Federated learning events
enum FederatedLearningEvent {
  initialized,
  joined,
  left,
  localTrainingCompleted,
  updateSent,
  globalModelReceived,
  error,
}

/// Privacy metrics
class PrivacyMetrics {
  final double epsilon;
  final double delta;
  final int dataPoints;
  final DateTime lastUpdate;

  PrivacyMetrics({
    required this.epsilon,
    required this.delta,
    required this.dataPoints,
    required this.lastUpdate,
  });
}
