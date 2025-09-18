import 'dart:async';
import 'package:ai_core/ai_core.dart';
import '../datasources/on_device_model_service.dart';
import '../datasources/adaptive_health_monitor.dart';

/// Implementation of AI repository with on-device and cloud fallback
class AIRepositoryImpl implements AIRepository {
  final OnDeviceModelService _onDeviceService;
  final AIService _cloudService; // Existing Gemini service
  bool _isInitialized = false;
  int _consecutiveFailures = 0;
  static const int _maxConsecutiveFailures = 3;

  AIRepositoryImpl(this._onDeviceService, this._cloudService);

  @override
  Future<AIResponse> generateResponse(String prompt) async {
    if (prompt.trim().isEmpty) {
      throw ArgumentError('Prompt cannot be empty');
    }

    final stopwatch = Stopwatch()..start();
    try {
      String response;
      String modelUsed;
      bool isOnDevice;

      // Try on-device first if available and healthy
      if (_onDeviceService.isAvailable && _onDeviceService.isHealthy && _consecutiveFailures < _maxConsecutiveFailures) {
        try {
          response = await _onDeviceService.generateResponse(prompt);
          modelUsed = _onDeviceService.currentModel;
          isOnDevice = true;
          _consecutiveFailures = 0; // Reset failure counter on success
        } catch (e) {
          _consecutiveFailures++;
          print('On-device model failed (${_consecutiveFailures}/$_maxConsecutiveFailures): $e');
          
          // Fallback to cloud service
          response = await _cloudService.generateResponse(prompt);
          modelUsed = 'Gemini';
          isOnDevice = false;
        }
      } else {
        // Use cloud service
        response = await _cloudService.generateResponse(prompt);
        modelUsed = 'Gemini';
        isOnDevice = false;
      }

      stopwatch.stop();

      return AIResponse(
        content: response,
        modelUsed: modelUsed,
        processingTimeMs: stopwatch.elapsedMilliseconds,
        isOnDevice: isOnDevice,
        timestamp: DateTime.now(),
      );
    } catch (e) {
      stopwatch.stop();
      return AIResponse(
        content: 'Sorry, I encountered an error: ${e.toString()}',
        modelUsed: 'Error',
        processingTimeMs: stopwatch.elapsedMilliseconds,
        isOnDevice: false,
        timestamp: DateTime.now(),
        error: e.toString(),
      );
    }
  }

  @override
  Future<AIResponse> generateChatResponse(String prompt, List<ChatMessage> conversationHistory) async {
    if (prompt.trim().isEmpty) {
      throw ArgumentError('Prompt cannot be empty');
    }

    final stopwatch = Stopwatch()..start();
    try {
      String response;
      String modelUsed;
      bool isOnDevice;

      // Try on-device first if available and healthy
      if (_onDeviceService.isAvailable && _onDeviceService.isHealthy && _consecutiveFailures < _maxConsecutiveFailures) {
        try {
          response = await _onDeviceService.generateChatResponse(prompt, conversationHistory);
          modelUsed = _onDeviceService.currentModel;
          isOnDevice = true;
          _consecutiveFailures = 0; // Reset failure counter on success
        } catch (e) {
          _consecutiveFailures++;
          print('On-device chat model failed (${_consecutiveFailures}/$_maxConsecutiveFailures): $e');
          
          // Fallback to cloud service
          response = await _cloudService.generateChatResponse(prompt, _convertToMapList(conversationHistory));
          modelUsed = 'Gemini';
          isOnDevice = false;
        }
      } else {
        // Use cloud service
        response = await _cloudService.generateChatResponse(prompt, _convertToMapList(conversationHistory));
        modelUsed = 'Gemini';
        isOnDevice = false;
      }

      stopwatch.stop();

      return AIResponse(
        content: response,
        modelUsed: modelUsed,
        processingTimeMs: stopwatch.elapsedMilliseconds,
        isOnDevice: isOnDevice,
        timestamp: DateTime.now(),
      );
    } catch (e) {
      stopwatch.stop();
      return AIResponse(
        content: 'Sorry, I encountered an error: ${e.toString()}',
        modelUsed: 'Error',
        processingTimeMs: stopwatch.elapsedMilliseconds,
        isOnDevice: false,
        timestamp: DateTime.now(),
        error: e.toString(),
      );
    }
  }

  @override
  Future<AIResponse> summarizeNote(String content) async {
    if (content.trim().isEmpty) {
      throw ArgumentError('Content cannot be empty');
    }

    final prompt = '''
Please summarize the following note content in a concise and clear manner. 
Focus on the main points and key information. Keep the summary to 2-3 sentences.

Content:
$content

Summary:''';

    return await generateResponse(prompt);
  }

  @override
  Future<List<String>> generateTitleSuggestions(String content) async {
    if (content.trim().isEmpty) {
      throw ArgumentError('Content cannot be empty');
    }

    final prompt = '''
Based on the following note content, suggest 3 concise and descriptive titles. 
Each title should be under 50 characters and capture the main topic.
Return only the titles, one per line, without numbering or bullet points.

Content:
$content

Titles:''';

    try {
      final response = await generateResponse(prompt);
      final titles = response.content
          .split('\n')
          .where((title) => title.trim().isNotEmpty)
          .map((title) => title.trim())
          .take(3)
          .toList();
      
      return titles.isNotEmpty ? titles : ['Untitled Note'];
    } catch (e) {
      return ['Untitled Note'];
    }
  }

  @override
  Future<AIResponse> enhanceContent(String content) async {
    if (content.trim().isEmpty) {
      throw ArgumentError('Content cannot be empty');
    }

    final prompt = '''
Please enhance and improve the following note content while preserving its core meaning and structure. 
Make it more clear, well-organized, and professional without changing the fundamental information.

Original content:
$content

Enhanced content:''';

    return await generateResponse(prompt);
  }

  @override
  Future<List<String>> generateTags(String content) async {
    if (content.trim().isEmpty) {
      throw ArgumentError('Content cannot be empty');
    }

    final prompt = '''
Based on the following note content, suggest relevant tags that categorize and describe the content.
Return 3-5 single-word tags that would help in organizing and finding this note.
Return only the tags, one per line, without symbols or formatting.

Content:
$content

Tags:''';

    try {
      final response = await generateResponse(prompt);
      final tags = response.content
          .split('\n')
          .where((tag) => tag.trim().isNotEmpty)
          .map((tag) => tag.trim().toLowerCase())
          .where((tag) => tag.length > 2 && tag.length < 20)
          .take(5)
          .toList();
      
      return tags.isNotEmpty ? tags : ['general'];
    } catch (e) {
      return ['general'];
    }
  }

  @override
  bool get isAvailable => _onDeviceService.isAvailable || _cloudService.isAvailable;

  @override
  String get status {
    if (_onDeviceService.isAvailable) {
      return 'On-device: ${_onDeviceService.status}';
    }
    return 'Cloud: ${_cloudService.status}';
  }

  @override
  String get currentModel {
    if (_onDeviceService.isAvailable) {
      return _onDeviceService.currentModel;
    }
    return 'Gemini';
  }

  @override
  bool get isOnDevice => _onDeviceService.isAvailable;

  /// Get health status of the on-device model
  HealthSnapshot get onDeviceHealth => _onDeviceService.healthSnapshot;
  
  /// Get detailed health report
  HealthReport get healthReport => _onDeviceService.healthReport;
  
  /// Check if on-device model is healthy
  bool get isOnDeviceHealthy => _onDeviceService.isHealthy;
  
  /// Get consecutive failure count
  int get consecutiveFailures => _consecutiveFailures;
  
  /// Reset failure counter (useful for recovery)
  void resetFailureCounter() {
    _consecutiveFailures = 0;
  }
  
  /// Force reload on-device model
  Future<bool> reloadOnDeviceModel() async {
    return await _onDeviceService.reloadModel();
  }
  
  /// Switch to different model level
  Future<bool> switchModelLevel(ModelLevel level) async {
    return await _onDeviceService.switchModel(level);
  }

  @override
  void dispose() {
    _onDeviceService.dispose();
    _cloudService.dispose();
  }

  List<Map<String, String>> _convertToMapList(List<ChatMessage> messages) {
    return messages.map((message) => {
      'role': message.role.name,
      'content': message.content,
    }).toList();
  }
}

// Placeholder for existing AIService interface
abstract class AIService {
  Future<String> generateResponse(String prompt);
  Future<String> generateChatResponse(String prompt, List<Map<String, String>> conversationHistory);
  bool get isAvailable;
  String get status;
  void dispose();
}
