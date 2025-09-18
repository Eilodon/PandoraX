import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../interfaces/ai_service.dart';
import '../../config/api_config.dart';
import '../../config/environment.dart' as env;

/// Production implementation of AI service using Google Gemini
@LazySingleton(as: AIService)
class AIServiceImpl implements AIService {
  GenerativeModel? _model;
  bool _isInitialized = false;
  String _status = 'Not initialized';

  @override
  Future<bool> initialize() async {
    try {
      _status = 'Initializing...';
      
      // Get API key from secure storage
      final apiKey = await ApiConfig.getGeminiApiKey();
      if (apiKey.isEmpty) {
        _status = 'API key not configured';
        return false;
      }

      // Initialize Gemini model
      _model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
        generationConfig: GenerationConfig(
          temperature: 0.7,
          topP: 0.8,
          topK: 40,
          maxOutputTokens: 2048,
          responseMimeType: 'text/plain',
        ),
        safetySettings: [
          SafetySetting(HarmCategory.harassment, HarmBlockThreshold.medium),
          SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.medium),
          SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.medium),
          SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.medium),
        ],
      );

      _isInitialized = true;
      _status = 'Ready';
      
      if (env.Environment.enableLogging) {
        print('✅ AI Service (Gemini) initialized successfully');
      }
      
      return true;
    } catch (e) {
      _status = 'Initialization failed: $e';
      if (env.Environment.enableLogging) {
        print('❌ AI Service initialization failed: $e');
      }
      return false;
    }
  }

  @override
  Future<String> generateResponse(String prompt) async {
    if (!_isInitialized || _model == null) {
      throw StateError('AI Service not initialized. Call initialize() first.');
    }

    if (prompt.trim().isEmpty) {
      throw ArgumentError('Prompt cannot be empty');
    }

    try {
      _status = 'Generating response...';
      
      final content = [Content.text(prompt.trim())];
      final response = await _model!.generateContent(content);
      
      _status = 'Ready';
      
      final result = response.text;
      if (result == null || result.isEmpty) {
        throw Exception('No response generated from AI model');
      }
      
      if (env.Environment.enableLogging) {
        print('🤖 AI Response generated for prompt: ${prompt.substring(0, 50)}...');
      }
      
      return result.trim();
    } catch (e) {
      _status = 'Error: $e';
      if (env.Environment.enableLogging) {
        print('❌ AI Response generation failed: $e');
      }
      throw Exception('Failed to generate AI response: $e');
    }
  }

  @override
  Future<String> generateChatResponse(String prompt, List<Map<String, String>> conversationHistory) async {
    if (!_isInitialized || _model == null) {
      throw StateError('AI Service not initialized. Call initialize() first.');
    }

    try {
      _status = 'Generating chat response...';
      
      // Build conversation context
      final chat = _model!.startChat(history: _buildChatHistory(conversationHistory));
      
      // Generate response
      final response = await chat.sendMessage(Content.text(prompt.trim()));
      
      _status = 'Ready';
      
      final result = response.text;
      if (result == null || result.isEmpty) {
        throw Exception('No chat response generated');
      }
      
      if (env.Environment.enableLogging) {
        print('💬 AI Chat response generated');
      }
      
      return result.trim();
    } catch (e) {
      _status = 'Error: $e';
      if (env.Environment.enableLogging) {
        print('❌ AI Chat response generation failed: $e');
      }
      throw Exception('Failed to generate chat response: $e');
    }
  }

  @override
  Future<String> summarizeNote(String content) async {
    if (content.trim().isEmpty) {
      throw ArgumentError('Content cannot be empty');
    }

    final prompt = '''
Please summarize the following note content in a concise and clear manner. 
Focus on the main points and key information. Keep the summary to 2-3 sentences.

Content:
$content

Summary:''';

    try {
      final summary = await generateResponse(prompt);
      
      if (env.Environment.enableLogging) {
        print('📝 Note summarized successfully');
      }
      
      return summary;
    } catch (e) {
      throw Exception('Failed to summarize note: $e');
    }
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
      final titles = response
          .split('\n')
          .where((title) => title.trim().isNotEmpty)
          .map((title) => title.trim())
          .take(3)
          .toList();
      
      if (env.Environment.enableLogging) {
        print('🏷️ Generated ${titles.length} title suggestions');
      }
      
      return titles.isNotEmpty ? titles : ['Untitled Note'];
    } catch (e) {
      if (env.Environment.enableLogging) {
        print('❌ Title generation failed: $e');
      }
      return ['Untitled Note'];
    }
  }

  @override
  Future<String> enhanceContent(String content) async {
    if (content.trim().isEmpty) {
      throw ArgumentError('Content cannot be empty');
    }

    final prompt = '''
Please enhance and improve the following note content while preserving its core meaning and structure. 
Make it more clear, well-organized, and professional without changing the fundamental information.

Original content:
$content

Enhanced content:''';

    try {
      final enhanced = await generateResponse(prompt);
      
      if (env.Environment.enableLogging) {
        print('✨ Content enhanced successfully');
      }
      
      return enhanced;
    } catch (e) {
      throw Exception('Failed to enhance content: $e');
    }
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
      final tags = response
          .split('\n')
          .where((tag) => tag.trim().isNotEmpty)
          .map((tag) => tag.trim().toLowerCase())
          .where((tag) => tag.length > 2 && tag.length < 20)
          .take(5)
          .toList();
      
      if (env.Environment.enableLogging) {
        print('🏷️ Generated ${tags.length} tags');
      }
      
      return tags.isNotEmpty ? tags : ['general'];
    } catch (e) {
      if (env.Environment.enableLogging) {
        print('❌ Tag generation failed: $e');
      }
      return ['general'];
    }
  }

  @override
  bool get isAvailable => _isInitialized && _model != null;

  @override
  String get status => _status;

  @override
  void dispose() {
    _model = null;
    _isInitialized = false;
    _status = 'Disposed';
    
    if (env.Environment.enableLogging) {
      print('🗑️ AI Service disposed');
    }
  }

  /// Convert conversation history to Gemini chat history format
  List<Content> _buildChatHistory(List<Map<String, String>> conversationHistory) {
    return conversationHistory.map((message) {
      final role = message['role'] ?? 'user';
      final text = message['content'] ?? '';
      
      if (role == 'assistant' || role == 'model') {
        return Content.model([TextPart(text)]);
      } else {
        return Content.text(text);
      }
    }).toList();
  }
}
