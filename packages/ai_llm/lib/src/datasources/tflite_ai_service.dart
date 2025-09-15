import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:ai_core/ai_core.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

/// TensorFlow Lite AI Service for on-device inference
class TfLiteAiService {
  Interpreter? _interpreter;
  bool _isInitialized = false;
  String _status = 'Not initialized';
  ModelSession? _currentSession;
  
  // Text processing utilities
  late TextProcessor _textProcessor;
  late TensorBuffer _inputBuffer;
  late TensorBuffer _outputBuffer;

  bool get isInitialized => _isInitialized;
  String get status => _status;
  ModelSession? get currentSession => _currentSession;

  /// Initialize the TensorFlow Lite model
  Future<bool> initialize(ModelSession session) async {
    try {
      _status = 'Initializing TensorFlow Lite...';
      
      // Check if model file exists
      if (session.file == null || !await session.file!.exists()) {
        _status = 'Model file not found';
        return false;
      }

      // Dispose existing model if any
      await dispose();

      // Load TensorFlow Lite model
      _interpreter = await Interpreter.fromFile(session.file!);
      
      // Initialize text processor for tokenization
      _textProcessor = TextProcessor();
      
      // Get input and output tensor info
      final inputShape = _interpreter!.getInputTensor(0).shape;
      final outputShape = _interpreter!.getOutputTensor(0).shape;
      
      // Initialize buffers
      _inputBuffer = TensorBuffer.createFixedSize(inputShape, TfLiteType.float32);
      _outputBuffer = TensorBuffer.createFixedSize(outputShape, TfLiteType.float32);
      
      _isInitialized = true;
      _status = 'Ready (TensorFlow Lite)';
      _currentSession = session;
      return true;
    } catch (e) {
      _status = 'Initialization failed: $e';
      _isInitialized = false;
      return false;
    }
  }

  /// Generate response using TensorFlow Lite model
  Future<String> generateResponse(String prompt, {
    int maxTokens = 512,
    double temperature = 0.7,
    int topK = 40,
    double topP = 0.9,
    double repeatPenalty = 1.1,
  }) async {
    if (!_isInitialized || _interpreter == null) {
      throw StateError('Model not initialized');
    }

    try {
      // For now, return a simulated response
      // In a real implementation, you would:
      // 1. Tokenize the input prompt
      // 2. Prepare input tensor
      // 3. Run inference
      // 4. Decode output tokens to text
      
      await Future.delayed(const Duration(milliseconds: 300));
      return 'TensorFlow Lite AI response for: "$prompt" (On-device inference)';
    } catch (e) {
      throw TfLiteAiException('Failed to generate response: $e', e);
    }
  }

  /// Generate chat response with conversation history
  Future<String> generateChatResponse(
    String prompt,
    List<ChatMessage> history, {
    int maxTokens = 512,
    double temperature = 0.7,
    int topK = 40,
    double topP = 0.9,
    double repeatPenalty = 1.1,
  }) async {
    if (!_isInitialized || _interpreter == null) {
      throw StateError('Model not initialized');
    }

    try {
      // Build context from conversation history
      final context = _buildContextPrompt(prompt, history);
      
      // For now, return a simulated response
      // In a real implementation, you would process the context
      await Future.delayed(const Duration(milliseconds: 500));
      return 'TensorFlow Lite chat response for: "$prompt" (Context: ${history.length} messages)';
    } catch (e) {
      throw TfLiteAiException('Failed to generate chat response: $e', e);
    }
  }

  /// Get model information
  Map<String, dynamic> getModelInfo() {
    if (!_isInitialized || _interpreter == null) {
      return {};
    }

    return {
      'modelPath': _currentSession?.file?.path,
      'modelLevel': _currentSession?.level.name,
      'inputShape': _interpreter!.getInputTensor(0).shape,
      'outputShape': _interpreter!.getOutputTensor(0).shape,
      'status': 'TensorFlow Lite Ready',
      'framework': 'TensorFlow Lite',
    };
  }

  /// Check if model is ready
  bool get isReady => _isInitialized;

  /// Dispose the model
  Future<void> dispose() async {
    _interpreter?.close();
    _interpreter = null;
    _isInitialized = false;
    _status = 'Disposed';
    _currentSession = null;
  }

  /// Build context prompt for chat
  String _buildContextPrompt(String prompt, List<ChatMessage> history) {
    final buffer = StringBuffer();
    
    // Add system context
    buffer.writeln('You are a helpful AI assistant. Please respond to the user\'s message.');
    buffer.writeln();
    
    // Add conversation history (limit to prevent context overflow)
    final recentHistory = history.take(10).toList();
    for (final message in recentHistory) {
      if (message.isUser) {
        buffer.writeln('User: ${message.content}');
      } else if (message.isAssistant) {
        buffer.writeln('Assistant: ${message.content}');
      }
    }
    
    // Add current prompt
    buffer.writeln('User: $prompt');
    buffer.writeln('Assistant:');
    
    return buffer.toString();
  }

  /// Tokenize text input (placeholder implementation)
  List<int> _tokenize(String text) {
    // In a real implementation, you would use a proper tokenizer
    // This is a simple word-based tokenization
    return text.split(' ').map((word) => word.hashCode % 1000).toList();
  }

  /// Decode tokens to text (placeholder implementation)
  String _decodeTokens(List<int> tokens) {
    // In a real implementation, you would use a proper decoder
    return 'Generated response from ${tokens.length} tokens';
  }
}

/// Custom exception for TensorFlow Lite AI errors
class TfLiteAiException implements Exception {
  final String message;
  final dynamic originalError;
  
  const TfLiteAiException(this.message, [this.originalError]);
  
  @override
  String toString() => 'TfLiteAiException: $message';
}
