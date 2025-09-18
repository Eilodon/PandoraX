import 'dart:async';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

import '../entities/ai_request.dart';
import '../entities/model_info.dart';
import 'model_manager.dart';
import 'inference_engine.dart';
import '../models/text_generation_model.dart';
import '../models/code_generation_model.dart';
import '../models/image_analysis_model.dart';
import '../models/speech_recognition_model.dart';
import '../models/translation_model.dart';
import '../models/summarization_model.dart';

/// Smart AI model router that selects optimal model for each request
class AIModelRouter {
  static final AIModelRouter _instance = AIModelRouter._internal();
  factory AIModelRouter() => _instance;
  AIModelRouter._internal();

  static final Logger _logger = Logger();
  static final Uuid _uuid = const Uuid();
  
  // Core services
  late ModelManager _modelManager;
  late InferenceEngine _inferenceEngine;
  
  // Model instances
  final Map<String, dynamic> _models = {};
  
  // Configuration
  bool _isInitialized = false;
  bool _isEnabled = true;
  
  // Performance tracking
  final Map<String, int> _modelUsageCount = {};
  final Map<String, Duration> _modelAverageTime = {};
  
  // Streams
  final StreamController<AIResponse> _responseController = 
      StreamController.broadcast();
  final StreamController<ModelSelectionEvent> _selectionController = 
      StreamController.broadcast();

  /// Initialize the AI model router
  Future<void> initialize() async {
    if (_isInitialized) return;

    _logger.i('Initializing AI Model Router...');
    
    try {
      // Initialize core services
      _modelManager = ModelManager();
      _inferenceEngine = InferenceEngine();
      
      await _modelManager.initialize();
      await _inferenceEngine.initialize();
      
      // Initialize specialized models
      await _initializeSpecializedModels();
      
      _isInitialized = true;
      _logger.i('AI Model Router initialized successfully');
      
    } catch (e) {
      _logger.e('Failed to initialize AI Model Router: $e');
      rethrow;
    }
  }

  /// Initialize specialized AI models
  Future<void> _initializeSpecializedModels() async {
    // Text Generation Models
    _models['text_generation'] = TextGenerationModel();
    await _models['text_generation'].initialize();
    
    // Code Generation Models
    _models['code_generation'] = CodeGenerationModel();
    await _models['code_generation'].initialize();
    
    // Image Analysis Models
    _models['image_analysis'] = ImageAnalysisModel();
    await _models['image_analysis'].initialize();
    
    // Speech Recognition Models
    _models['speech_recognition'] = SpeechRecognitionModel();
    await _models['speech_recognition'].initialize();
    
    // Translation Models
    _models['translation'] = TranslationModel();
    await _models['translation'].initialize();
    
    // Summarization Models
    _models['summarization'] = SummarizationModel();
    await _models['summarization'].initialize();
    
    _logger.i('Specialized models initialized');
  }

  /// Process AI request with optimal model selection
  Future<AIResponse> processRequest(AIRequest request) async {
    if (!_isInitialized) {
      throw StateError('AI Model Router not initialized');
    }
    
    if (!_isEnabled) {
      throw StateError('AI Model Router is disabled');
    }
    
    try {
      // Select optimal model
      final selectedModel = await _selectOptimalModel(request);
      
      // Log model selection
      _selectionController.add(ModelSelectionEvent(
        requestId: request.id,
        modelId: selectedModel.id,
        reason: selectedModel.selectionReason,
        timestamp: DateTime.now(),
      ));
      
      // Process request
      final startTime = DateTime.now();
      final response = await _processWithModel(request, selectedModel);
      final processingTime = DateTime.now().difference(startTime);
      
      // Update performance metrics
      _updatePerformanceMetrics(selectedModel.id, processingTime);
      
      // Create response
      final aiResponse = AIResponse(
        id: _uuid.v4(),
        content: response.content,
        confidence: response.confidence,
        modelId: selectedModel.id,
        type: request.type,
        metadata: response.metadata,
        timestamp: DateTime.now(),
        processingTime: processingTime,
      );
      
      // Emit response
      _responseController.add(aiResponse);
      
      return aiResponse;
      
    } catch (e) {
      _logger.e('Failed to process AI request: $e');
      
      // Return error response
      final errorResponse = AIResponse(
        id: _uuid.v4(),
        content: '',
        confidence: 0.0,
        modelId: 'error',
        type: request.type,
        timestamp: DateTime.now(),
        error: e.toString(),
      );
      
      _responseController.add(errorResponse);
      return errorResponse;
    }
  }

  /// Select optimal model for the request
  Future<ModelInfo> _selectOptimalModel(AIRequest request) async {
    // Get available models for request type
    final availableModels = await _modelManager.getAvailableModels(request.type);
    
    if (availableModels.isEmpty) {
      throw StateError('No models available for request type: ${request.type}');
    }
    
    // Score each model based on multiple factors
    ModelInfo? bestModel;
    double bestScore = -1.0;
    
    for (final model in availableModels) {
      final score = await _calculateModelScore(model, request);
      
      if (score > bestScore) {
        bestScore = score;
        bestModel = model;
      }
    }
    
    if (bestModel == null) {
      throw StateError('No suitable model found for request');
    }
    
    // Add selection reason
    bestModel = bestModel.copyWith(
      selectionReason: _getSelectionReason(bestModel, bestScore),
    );
    
    return bestModel;
  }

  /// Calculate model score based on multiple factors
  Future<double> _calculateModelScore(ModelInfo model, AIRequest request) async {
    double score = 0.0;
    
    // Base score from model capability
    score += model.capabilityScore;
    
    // Performance score (faster is better)
    final avgTime = _modelAverageTime[model.id];
    if (avgTime != null) {
      score += (1000 - avgTime.inMilliseconds) / 1000.0;
    }
    
    // Usage score (less used is better for load balancing)
    final usageCount = _modelUsageCount[model.id] ?? 0;
    score += 1.0 / (usageCount + 1);
    
    // Availability score
    if (model.status == ModelStatus.loaded) {
      score += 1.0;
    } else if (model.status == ModelStatus.available) {
      score += 0.5;
    }
    
    // Type-specific scoring
    score += _getTypeSpecificScore(model, request);
    
    return score;
  }

  /// Get type-specific score for model
  double _getTypeSpecificScore(ModelInfo model, AIRequest request) {
    switch (request.type) {
      case AIRequestType.textGeneration:
        return model.supportsTextGeneration ? 1.0 : 0.0;
      case AIRequestType.codeGeneration:
        return model.supportsCodeGeneration ? 1.0 : 0.0;
      case AIRequestType.imageAnalysis:
        return model.supportsImageAnalysis ? 1.0 : 0.0;
      case AIRequestType.speechRecognition:
        return model.supportsSpeechRecognition ? 1.0 : 0.0;
      case AIRequestType.translation:
        return model.supportsTranslation ? 1.0 : 0.0;
      case AIRequestType.summarization:
        return model.supportsSummarization ? 1.0 : 0.0;
      default:
        return 0.5;
    }
  }

  /// Get selection reason for model
  String _getSelectionReason(ModelInfo model, double score) {
    if (model.status == ModelStatus.loaded) {
      return 'Model already loaded with score $score';
    } else if (model.capabilityScore > 0.8) {
      return 'High capability model with score $score';
    } else if (score > 0.7) {
      return 'Well-performing model with score $score';
    } else {
      return 'Best available model with score $score';
    }
  }

  /// Process request with specific model
  Future<ModelResponse> _processWithModel(AIRequest request, ModelInfo model) async {
    // Get model instance
    final modelInstance = _models[model.type] as dynamic;
    
    if (modelInstance == null) {
      throw StateError('Model instance not found: ${model.type}');
    }
    
    // Process request
    return await modelInstance.process(request);
  }

  /// Update performance metrics for model
  void _updatePerformanceMetrics(String modelId, Duration processingTime) {
    _modelUsageCount[modelId] = (_modelUsageCount[modelId] ?? 0) + 1;
    
    final currentAvg = _modelAverageTime[modelId];
    if (currentAvg == null) {
      _modelAverageTime[modelId] = processingTime;
    } else {
      final count = _modelUsageCount[modelId]!;
      final newAvg = Duration(
        milliseconds: ((currentAvg.inMilliseconds * (count - 1)) + 
                     processingTime.inMilliseconds) ~/ count,
      );
      _modelAverageTime[modelId] = newAvg;
    }
  }

  /// Get model performance metrics
  Map<String, ModelPerformance> getModelPerformance() {
    final performance = <String, ModelPerformance>{};
    
    for (final modelId in _modelUsageCount.keys) {
      performance[modelId] = ModelPerformance(
        usageCount: _modelUsageCount[modelId]!,
        averageTime: _modelAverageTime[modelId] ?? Duration.zero,
        lastUsed: DateTime.now(),
      );
    }
    
    return performance;
  }

  /// Enable/disable router
  void setEnabled(bool enabled) {
    _isEnabled = enabled;
    _logger.i('AI Model Router ${enabled ? 'enabled' : 'disabled'}');
  }

  /// Get response stream
  Stream<AIResponse> get responseStream => _responseController.stream;

  /// Get selection stream
  Stream<ModelSelectionEvent> get selectionStream => _selectionController.stream;

  /// Check if initialized
  bool get isInitialized => _isInitialized;

  /// Dispose resources
  void dispose() {
    _responseController.close();
    _selectionController.close();
    _modelManager.dispose();
    _inferenceEngine.dispose();
  }
}

/// Model selection event
class ModelSelectionEvent {
  final String requestId;
  final String modelId;
  final String reason;
  final DateTime timestamp;

  ModelSelectionEvent({
    required this.requestId,
    required this.modelId,
    required this.reason,
    required this.timestamp,
  });
}

/// Model performance metrics
class ModelPerformance {
  final int usageCount;
  final Duration averageTime;
  final DateTime lastUsed;

  ModelPerformance({
    required this.usageCount,
    required this.averageTime,
    required this.lastUsed,
  });
}

/// Model response
class ModelResponse {
  final String content;
  final double confidence;
  final Map<String, dynamic>? metadata;

  ModelResponse({
    required this.content,
    required this.confidence,
    this.metadata,
  });
}
