import 'dart:async';
import 'package:ai_core/ai_core.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Hybrid AI Service - Cloud AI with local fallback
class HybridAiService {
  GenerativeModel? _model;
  bool _isInitialized = false;
  String _status = 'Not initialized';
  ModelSession? _currentSession;
  final Connectivity _connectivity = Connectivity();
  
  // Configuration
  static const String _apiKey = 'AIzaSyCgP2ooYE6SuDoo1CWkp-NI4Dl67RhIK-0'; // Google AI API Key
  static const String _modelName = 'gemini-1.5-flash';

  bool get isInitialized => _isInitialized;
  String get status => _status;
  ModelSession? get currentSession => _currentSession;

  /// Initialize the Hybrid AI service
  Future<bool> initialize(ModelSession session) async {
    try {
      _status = 'Initializing Hybrid AI...';
      
      // Check connectivity
      final connectivityResult = await _connectivity.checkConnectivity();
      final hasInternet = connectivityResult != ConnectivityResult.none;
      
      if (hasInternet) {
        // Initialize Google Generative AI
        _model = GenerativeModel(
          model: _modelName,
          apiKey: _apiKey,
        );
        _status = 'Ready (Cloud AI)';
      } else {
        // Fallback to local simulation
        _status = 'Ready (Local Fallback)';
      }
      
      _isInitialized = true;
      _currentSession = session;
      return true;
    } catch (e) {
      // Fallback to local simulation on any error
      _status = 'Ready (Local Fallback - Error: $e)';
      _isInitialized = true;
      _currentSession = session;
      return true;
    }
  }

  /// Generate response using Hybrid AI
  Future<String> generateResponse(String prompt, {
    int maxTokens = 512,
    double temperature = 0.7,
    int topK = 40,
    double topP = 0.9,
    double repeatPenalty = 1.1,
  }) async {
    if (!_isInitialized) {
      throw StateError('Service not initialized');
    }

    try {
      // Check connectivity
      final connectivityResult = await _connectivity.checkConnectivity();
      final hasInternet = connectivityResult != ConnectivityResult.none;
      
      if (hasInternet && _model != null) {
        // Use cloud AI
        final content = [Content.text(prompt)];
        final response = await _model!.generateContent(
          content,
          generationConfig: GenerationConfig(
            maxOutputTokens: maxTokens,
            temperature: temperature,
            topK: topK,
            topP: topP,
          ),
        );
        
        return response.text ?? 'No response generated';
      } else {
        // Use local fallback
        return _generateLocalResponse(prompt, maxTokens, temperature);
      }
    } catch (e) {
      // Fallback to local response on error
      return _generateLocalResponse(prompt, maxTokens, temperature);
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
    if (!_isInitialized) {
      throw StateError('Service not initialized');
    }

    try {
      // Check connectivity
      final connectivityResult = await _connectivity.checkConnectivity();
      final hasInternet = connectivityResult != ConnectivityResult.none;
      
      if (hasInternet && _model != null) {
        // Use cloud AI with conversation history
        final content = <Content>[];
        
        // Add conversation history
        for (final message in history.take(10)) { // Limit history
          if (message.isUser) {
            content.add(Content.text('User: ${message.content}'));
          } else if (message.isAssistant) {
            content.add(Content.text('Assistant: ${message.content}'));
          }
        }
        
        // Add current prompt
        content.add(Content.text('User: $prompt\nAssistant:'));
        
        final response = await _model!.generateContent(
          content,
          generationConfig: GenerationConfig(
            maxOutputTokens: maxTokens,
            temperature: temperature,
            topK: topK,
            topP: topP,
          ),
        );
        
        return response.text ?? 'No response generated';
      } else {
        // Use local fallback
        return _generateLocalChatResponse(prompt, history, maxTokens, temperature);
      }
    } catch (e) {
      // Fallback to local response on error
      return _generateLocalChatResponse(prompt, history, maxTokens, temperature);
    }
  }

  /// Get model information
  Map<String, dynamic> getModelInfo() {
    if (!_isInitialized) {
      return {};
    }

    return {
      'modelPath': _currentSession?.file.path,
      'modelLevel': _currentSession?.level.name,
      'status': _status,
      'framework': 'Hybrid AI (Google AI + Local Fallback)',
      'hasInternet': _model != null,
    };
  }

  /// Check if model is ready
  bool get isReady => _isInitialized;

  /// Dispose the service
  Future<void> dispose() async {
    _model = null;
    _isInitialized = false;
    _status = 'Disposed';
    _currentSession = null;
  }

  /// Generate local fallback response
  String _generateLocalResponse(String prompt, int maxTokens, double temperature) {
    // Simple rule-based responses for common patterns
    final lowerPrompt = prompt.toLowerCase();
    
    if (lowerPrompt.contains('hello') || lowerPrompt.contains('hi')) {
      return 'Hello! I\'m your AI assistant. How can I help you today? (Local AI)';
    } else if (lowerPrompt.contains('how are you')) {
      return 'I\'m doing well, thank you for asking! I\'m here to help you with any questions you might have. (Local AI)';
    } else if (lowerPrompt.contains('what') && lowerPrompt.contains('time')) {
      return 'I don\'t have access to the current time, but I can help you with other questions! (Local AI)';
    } else if (lowerPrompt.contains('weather')) {
      return 'I can\'t check the weather right now, but I recommend checking a weather app or website. (Local AI)';
    } else if (lowerPrompt.contains('help')) {
      return 'I\'m here to help! You can ask me questions about various topics, and I\'ll do my best to assist you. (Local AI)';
    } else {
      return 'I understand you\'re asking about "$prompt". This is a local AI response. For more detailed answers, please check your internet connection. (Local AI)';
    }
  }

  /// Generate local fallback chat response
  String _generateLocalChatResponse(String prompt, List<ChatMessage> history, int maxTokens, double temperature) {
    // final context = _buildContextPrompt(prompt, history);
    return 'Based on our conversation (${history.length} messages), I understand you\'re asking about "$prompt". This is a local AI response. For more detailed answers, please check your internet connection. (Local AI)';
  }

  // /// Build context prompt for chat
  // String _buildContextPrompt(String prompt, List<ChatMessage> history) {
  //   final buffer = StringBuffer();
  //   
  //   // Add system context
  //   buffer.writeln('You are a helpful AI assistant. Please respond to the user\'s message.');
  //   buffer.writeln();
  //   
  //   // Add conversation history (limit to prevent context overflow)
  //   final recentHistory = history.take(10).toList();
  //   for (final message in recentHistory) {
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
}

/// Custom exception for Hybrid AI errors
class HybridAiException implements Exception {
  final String message;
  final dynamic originalError;
  
  const HybridAiException(this.message, [this.originalError]);
  
  @override
  String toString() => 'HybridAiException: $message';
}
