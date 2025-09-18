import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';
import '../../../services/interfaces/ai_service.dart';

/// Feature-level AI Service implementation
/// 
/// This is a concrete implementation of the unified AIService interface
/// focused on note management features with Gemini integration
@injectable
class AiService implements AIService {
  final GenerativeModel _model;
  bool _isInitialized = false;
  String _status = 'Not initialized';

  AiService(String apiKey) : _model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

  @override
  Future<bool> initialize() async {
    try {
      _status = 'Initializing...';
      _isInitialized = true;
      _status = 'Ready';
      return true;
    } catch (e) {
      _status = 'Error: $e';
      return false;
    }
  }

  @override
  Future<String> generateResponse(String prompt) async {
    try {
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      return response.text ?? 'Could not generate response.';
    } catch (e) {
      throw Exception('Failed to generate response: $e');
    }
  }

  @override
  Future<String> generateChatResponse(String prompt, List<Map<String, String>> conversationHistory) async {
    try {
      final contextPrompt = 'Bạn là một trợ lý AI thông minh giúp người dùng quản lý ghi chú. Hãy trả lời một cách hữu ích và thân thiện.\n\nLịch sử trò chuyện:\n${conversationHistory.map((msg) => '${msg['role']}: ${msg['content']}').join('\n')}\n\nTin nhắn mới: "$prompt"';
      return await generateResponse(contextPrompt);
    } catch (e) {
      throw Exception('Failed to generate chat response: $e');
    }
  }

  @override
  Future<String> summarizeNote(String content) async {
    try {
      final prompt = 'Summarize the following note in a concise way: "$content"';
      return await generateResponse(prompt);
    } catch (e) {
      throw Exception('Failed to summarize note: $e');
    }
  }

  @override
  Future<List<String>> generateTitleSuggestions(String content) async {
    try {
      final prompt = 'Generate 3 short title suggestions for this note content: "$content". Return only the titles, one per line.';
      final response = await generateResponse(prompt);
      return response.split('\n').where((line) => line.trim().isNotEmpty).take(3).toList();
    } catch (e) {
      throw Exception('Failed to generate title suggestions: $e');
    }
  }

  @override
  Future<String> enhanceContent(String content) async {
    try {
      final prompt = 'Improve and enhance this note content while maintaining its original meaning: "$content"';
      return await generateResponse(prompt);
    } catch (e) {
      throw Exception('Failed to enhance content: $e');
    }
  }

  @override
  Future<List<String>> generateTags(String content) async {
    try {
      final prompt = 'Generate 5 relevant tags for this note content: "$content". Return only the tags, one per line.';
      final response = await generateResponse(prompt);
      return response.split('\n').where((line) => line.trim().isNotEmpty).take(5).toList();
    } catch (e) {
      throw Exception('Failed to generate tags: $e');
    }
  }

  @override
  Future<List<String>> getSuggestions(String input) async {
    try {
      final prompt = 'Provide 3 helpful suggestions based on this input: "$input". Return only the suggestions, one per line.';
      final response = await generateResponse(prompt);
      return response.split('\n').where((line) => line.trim().isNotEmpty).take(3).toList();
    } catch (e) {
      throw Exception('Failed to get suggestions: $e');
    }
  }

  @override
  Future<List<double>> createEmbedding(String content) async {
    // For now, return a simple mock embedding
    // In production, this would use a proper embedding model
    return List.generate(384, (index) => (content.hashCode % 1000) / 1000.0);
  }

  @override
  bool get isAvailable => _isInitialized;

  @override
  Future<bool> isAvailableAsync() async => isAvailable;

  @override
  String get status => _status;

  @override
  Future<Map<String, dynamic>> getModelInfo() async {
    return {
      'model': 'gemini-pro',
      'provider': 'Google Generative AI',
      'status': _status,
      'initialized': _isInitialized,
    };
  }

  @override
  void dispose() {
    _isInitialized = false;
    _status = 'Disposed';
  }
}
