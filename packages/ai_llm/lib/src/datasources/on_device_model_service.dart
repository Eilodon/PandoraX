import 'dart:async';
import 'package:ai_core/ai_core.dart';
import 'adaptive_health_monitor.dart';
// import 'llama_cpp_service.dart';  // Temporarily disabled
// import 'tflite_ai_service.dart';  // TensorFlow Lite AI service - Has namespace issues
// import 'onnx_ai_service.dart';  // ONNX Runtime AI service - Not available
// import 'hybrid_ai_service.dart';  // Hybrid AI service (Cloud + Local Fallback)
// import 'tflite_ondevice_service.dart';  // TensorFlow Lite On-Device AI service - Has namespace issues
import 'onnx_ffi_service.dart';  // ONNX Runtime FFI On-Device AI service

class OnDeviceModelService {
  final ModelStorageRepository _storage;
  final AdaptiveHealthMonitor _health;
  // final LlamaCppService _llamaService;  // Temporarily disabled
  // final TfLiteAiService _tfliteService;  // TensorFlow Lite AI service - Has namespace issues
  // final OnnxAiService _onnxService;  // ONNX Runtime AI service - Not available
  // final HybridAiService _hybridService;  // Hybrid AI service (Cloud + Local Fallback)
  // final TfLiteOnDeviceService _tfliteOnDeviceService;  // TensorFlow Lite On-Device AI service - Has namespace issues
  final OnnxFfiService _onnxFfiService;  // ONNX Runtime FFI On-Device AI service
  bool _isInitialized = false;
  String _status = 'Not initialized';
  String _currentModel = 'None';
  ModelSession? _currentSession;

  OnDeviceModelService(this._storage, this._health) : _onnxFfiService = OnnxFfiService();

  Future<bool> initialize() async {
    try {
      _status = 'Initializing...';
      
      // Check if any model is available
      final availableModels = await _storage.getAvailableModels();
      if (availableModels.isEmpty) {
        _status = 'No models available';
        return false;
      }
      
      // Initialize with the best available model
      final bestModel = _selectBestModel(availableModels);
      await _loadModel(bestModel);
      
      // Initialize ONNX Runtime FFI On-Device service
      final onnxInitialized = await _onnxFfiService.initialize(bestModel);
      if (!onnxInitialized) {
        _status = 'ONNX Runtime FFI On-Device initialization failed';
        return false;
      }
      
      _isInitialized = true;
      _status = 'Ready';
      _currentModel = bestModel.level.modelId;
      _currentSession = bestModel;
      return true;
    } catch (e) {
      _status = 'Initialization failed: $e';
      return false;
    }
  }

  Future<String> generateResponse(String prompt) async {
    if (!_isInitialized) {
      throw StateError('On-device model not initialized');
    }
    
    if (prompt.trim().isEmpty) {
      throw ArgumentError('Prompt cannot be empty');
    }
    
    final stopwatch = Stopwatch()..start();
    try {
      // Use ONNX Runtime FFI On-Device service for actual model execution
      final response = await _onnxFfiService.generateResponse(
        prompt,
        maxTokens: _getMaxTokens(),
        temperature: _getTemperature(),
        topK: _getTopK(),
        topP: _getTopP(),
        repeatPenalty: _getRepeatPenalty(),
      );
      stopwatch.stop();
      
      _health.record(true, stopwatch.elapsedMilliseconds);
      return response;
    } catch (e) {
      stopwatch.stop();
      _health.record(false, stopwatch.elapsedMilliseconds);
      
      // Log the error for debugging
      print('OnDeviceModelService error: $e');
      
      // Re-throw with more context
      throw OnDeviceModelException('Failed to generate response: $e', e);
    }
  }

  Future<String> generateChatResponse(String prompt, List<ChatMessage> history) async {
    if (!_isInitialized) {
      throw StateError('On-device model not initialized');
    }
    
    if (prompt.trim().isEmpty) {
      throw ArgumentError('Prompt cannot be empty');
    }
    
    final stopwatch = Stopwatch()..start();
    try {
      // Use ONNX Runtime FFI On-Device service for chat response
      final response = await _onnxFfiService.generateChatResponse(
        prompt,
        history,
        maxTokens: _getMaxTokens(),
        temperature: _getTemperature(),
        topK: _getTopK(),
        topP: _getTopP(),
        repeatPenalty: _getRepeatPenalty(),
      );
      stopwatch.stop();
      
      _health.record(true, stopwatch.elapsedMilliseconds);
      return response;
    } catch (e) {
      stopwatch.stop();
      _health.record(false, stopwatch.elapsedMilliseconds);
      
      // Log the error for debugging
      print('OnDeviceModelService chat error: $e');
      
      // Re-throw with more context
      throw OnDeviceModelException('Failed to generate chat response: $e', e);
    }
  }

  bool get isAvailable => _isInitialized;
  String get status => _status;
  String get currentModel => _currentModel;
  bool get isOnDevice => true;
  ModelSession? get currentSession => _currentSession;
  
  /// Get health status of the current model
  HealthSnapshot get healthSnapshot => _health.snapshot();
  
  /// Get detailed health report
  HealthReport get healthReport => _health.getDetailedReport();
  
  /// Check if the model is performing well
  bool get isHealthy => _health.snapshot().isHealthy;

  /// Switch to a different model if available
  Future<bool> switchModel(ModelLevel level) async {
    if (!_isInitialized) {
      return false;
    }
    
    try {
      final newSession = await _storage.getModel(level);
      if (newSession == null) {
        return false;
      }
      
      await _loadModel(newSession);
      
      // Reinitialize ONNX Runtime FFI On-Device service with new model
      final onnxInitialized = await _onnxFfiService.initialize(newSession);
      if (!onnxInitialized) {
        _status = 'ONNX Runtime FFI On-Device reinitialization failed';
        return false;
      }
      
      _currentModel = newSession.level.modelId;
      _currentSession = newSession;
      return true;
    } catch (e) {
      _status = 'Model switch failed: $e';
      return false;
    }
  }
  
  /// Reload current model
  Future<bool> reloadModel() async {
    if (_currentSession == null) {
      return false;
    }
    
    try {
      await _loadModel(_currentSession!);
      
      // Reinitialize ONNX Runtime FFI On-Device service
      final onnxInitialized = await _onnxFfiService.initialize(_currentSession!);
      if (!onnxInitialized) {
        _status = 'ONNX Runtime FFI On-Device reload failed';
        return false;
      }
      
      return true;
    } catch (e) {
      _status = 'Model reload failed: $e';
      return false;
    }
  }
  
  /// Get available models
  Future<List<ModelSession>> getAvailableModels() async {
    return await _storage.getAvailableModels();
  }

  void dispose() async {
    await _onnxFfiService.dispose();
    _isInitialized = false;
    _status = 'Disposed';
    _currentModel = 'None';
    _currentSession = null;
  }

  ModelSession _selectBestModel(List<ModelSession> models) {
    // Prefer pinned models, then by level (full > mini > tiny)
    final sorted = models.toList()
      ..sort((a, b) {
        if (a.pinned != b.pinned) {
          return a.pinned ? -1 : 1;
        }
        return _getLevelPriority(b.level) - _getLevelPriority(a.level);
      });
    
    return sorted.first;
  }

  int _getLevelPriority(ModelLevel level) {
    switch (level.name) {
      case 'full': return 3;
      case 'mini': return 2;
      case 'tiny': return 1;
      default: return 0;
    }
  }

  Future<void> _loadModel(ModelSession session) async {
    // Pin the model to prevent eviction
    await _storage.pinModel(session.key);
    
    // Verify model file exists
    if (!await session.file.exists()) {
      throw StateError('Model file not found: ${session.filePath}');
    }
    
    // This is where we would initialize the actual model
    // For now, just simulate loading
    await Future.delayed(const Duration(milliseconds: 100));
  }


  // String _buildContextPrompt(String prompt, List<ChatMessage> history) {
  //   final buffer = StringBuffer();
  //   
  //   // Add system context
  //   buffer.writeln('You are a helpful AI assistant. Please respond to the user\'s message.');
  //   buffer.writeln();
  //   
  //   // Add conversation history
  //   for (final message in history.take(10)) { // Limit to last 10 messages
  //     if (message.isUser) {
  //       buffer.writeln('User: ${message.content}');
  //     } else if (message.isAssistant) {
  //       buffer.writeln('Assistant: ${message.content}');
  //     }
  //   }
  //   
  //   // Add current prompt
  //   buffer.writeln('User: $prompt');
  //   buffer.writeln('Assistant:');
  //   
  //   return buffer.toString();
  // }

  /// Get max tokens based on model level
  int _getMaxTokens() {
    switch (_currentSession?.level.name) {
      case 'full':
        return 1024;
      case 'mini':
        return 512;
      case 'tiny':
        return 256;
      default:
        return 128;
    }
  }

  /// Get temperature based on model level
  double _getTemperature() {
    switch (_currentSession?.level.name) {
      case 'full':
        return 0.7; // More creative for full model
      case 'mini':
        return 0.8;
      case 'tiny':
        return 0.9; // More deterministic for tiny model
      default:
        return 0.8;
    }
  }

  /// Get top-k based on model level
  int _getTopK() {
    switch (_currentSession?.level.name) {
      case 'full':
        return 40;
      case 'mini':
        return 30;
      case 'tiny':
        return 20;
      default:
        return 20;
    }
  }

  /// Get top-p based on model level
  double _getTopP() {
    switch (_currentSession?.level.name) {
      case 'full':
        return 0.9;
      case 'mini':
        return 0.85;
      case 'tiny':
        return 0.8;
      default:
        return 0.8;
    }
  }

  /// Get repeat penalty based on model level
  double _getRepeatPenalty() {
    switch (_currentSession?.level.name) {
      case 'full':
        return 1.1;
      case 'mini':
        return 1.05;
      case 'tiny':
        return 1.0;
      default:
        return 1.0;
    }
  }
}

/// Custom exception for on-device model errors
class OnDeviceModelException implements Exception {
  final String message;
  final dynamic originalError;
  
  const OnDeviceModelException(this.message, [this.originalError]);
  
  @override
  String toString() => 'OnDeviceModelException: $message';
}

