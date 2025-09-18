import 'package:core_utils/core_utils.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/api_config.dart';

/// AI Service for handling AI operations
class AIService {
  static final AIService _instance = AIService._internal();
  factory AIService() => _instance;
  AIService._internal();

  GenerativeModel? _model;
  bool _isInitialized = false;

  /// Initialize the AI service
  Future<void> initialize() async {
    try {
      AppLogger.info('🤖 Initializing AI service...');
      
      // Initialize Gemini model with real API key
      final apiKey = ApiConfig.getGeminiApiKey();
      
      if (apiKey.isEmpty) {
        AppLogger.warning('Gemini API key not configured. Using fallback responses only.');
        AppLogger.info('To enable AI features:');
        AppLogger.info('1. Get your free API key from https://makersuite.google.com/app/apikey');
        AppLogger.info('2. Update lib/config/api_config.dart with your API key');
        AppLogger.info('3. Or set GEMINI_API_KEY environment variable');
        _isInitialized = false;
        return;
      }
      
      _model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
      );
      
      _isInitialized = true;
      AppLogger.success('✅ AI service initialized');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to initialize AI service', e, stackTrace);
      _isInitialized = false;
    }
  }

  /// Generate AI response based on user input
  Future<String> generateResponse(String userMessage) async {
    try {
      AppLogger.info('🤖 Generating AI response for: $userMessage');
      
      if (!_isInitialized || _model == null) {
        AppLogger.warning('AI service not initialized, using fallback response');
        return _generateRuleBasedResponse(userMessage);
      }
      
      // Use real Gemini API
      final content = [Content.text(userMessage)];
      final response = await _model!.generateContent(content);
      
      final aiResponse = response.text ?? 'Sorry, I could not generate a response.';
      
      AppLogger.success('AI response generated successfully');
      return aiResponse;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to generate AI response', e, stackTrace);
      // Fallback to rule-based response
      return _generateRuleBasedResponse(userMessage);
    }
  }

  /// Summarize note content
  Future<String> summarizeNote(String content) async {
    try {
      AppLogger.info('📝 Summarizing note content...');
      
      if (!_isInitialized || _model == null) {
        AppLogger.warning('AI service not initialized, using simple summarization');
        return _simpleSummarization(content);
      }
      
      // Use real AI for summarization
      final prompt = 'Please summarize the following text in 2-3 sentences:\n\n$content';
      final aiContent = [Content.text(prompt)];
      final response = await _model!.generateContent(aiContent);
      
      final summary = response.text ?? _simpleSummarization(content);
      
      AppLogger.success('Note summarized successfully');
      return summary;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to summarize note', e, stackTrace);
      return _simpleSummarization(content);
    }
  }

  /// Generate note title from content
  Future<String> generateTitle(String content) async {
    try {
      AppLogger.info('📝 Generating title from content...');
      
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Take first few words as title
      final words = content.split(' ').take(5).join(' ');
      return words.isEmpty ? 'Untitled Note' : words;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to generate title', e, stackTrace);
      return 'Untitled Note';
    }
  }

  /// Generate tags from content
  Future<List<String>> generateTags(String content) async {
    try {
      AppLogger.info('🏷️ Generating tags from content...');
      
      await Future.delayed(const Duration(milliseconds: 800));
      
      // Simple tag generation based on keywords
      final keywords = _extractKeywords(content);
      return keywords.take(5).toList();
    } catch (e, stackTrace) {
      AppLogger.error('Failed to generate tags', e, stackTrace);
      return [];
    }
  }

  /// Generate category suggestion
  Future<String?> generateCategory(String content) async {
    try {
      AppLogger.info('📁 Generating category suggestion...');
      
      await Future.delayed(const Duration(milliseconds: 600));
      
      // Simple category detection
      final lowerContent = content.toLowerCase();
      
      if (lowerContent.contains('work') || lowerContent.contains('meeting') || lowerContent.contains('project')) {
        return 'Work';
      } else if (lowerContent.contains('personal') || lowerContent.contains('family') || lowerContent.contains('home')) {
        return 'Personal';
      } else if (lowerContent.contains('idea') || lowerContent.contains('thought') || lowerContent.contains('creative')) {
        return 'Ideas';
      } else if (lowerContent.contains('shopping') || lowerContent.contains('buy') || lowerContent.contains('purchase')) {
        return 'Shopping';
      } else if (lowerContent.contains('todo') || lowerContent.contains('task') || lowerContent.contains('reminder')) {
        return 'Tasks';
      }
      
      return null;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to generate category', e, stackTrace);
      return null;
    }
  }

  /// Generate rule-based response
  String _generateRuleBasedResponse(String userMessage) {
    final message = userMessage.toLowerCase();
    
    if (message.contains('hello') || message.contains('hi')) {
      return "Hello! I'm PandoraX AI Assistant. I can help you with note-taking, organization, and productivity. What would you like to do today?";
    } else if (message.contains('note') || message.contains('write')) {
      return "I can help you create, organize, and manage your notes. You can create new notes, search through existing ones, or get suggestions for better organization. Would you like me to help you create a new note?";
    } else if (message.contains('help')) {
      return "I can assist you with:\n\n• Creating and editing notes\n• Organizing your content with tags and categories\n• Providing writing suggestions\n• Summarizing long notes\n• Generating titles and tags\n• Answering questions about your notes\n\nWhat specific help do you need?";
    } else if (message.contains('organize') || message.contains('organize')) {
      return "I can help you organize your notes by:\n\n• Suggesting categories based on content\n• Generating relevant tags\n• Creating summaries\n• Finding related notes\n• Setting priorities\n\nWould you like me to help organize your existing notes?";
    } else if (message.contains('search')) {
      return "I can help you search through your notes by:\n\n• Keywords in title or content\n• Tags and categories\n• Date ranges\n• Priority levels\n• Specific phrases\n\nWhat are you looking for?";
    } else if (message.contains('weather')) {
      return "I don't have access to real-time weather data, but I can help you create notes about weather observations, plan outdoor activities, or organize weather-related information!";
    } else if (message.contains('time') || message.contains('date')) {
      return "The current time is ${DateTime.now().toString().substring(11, 19)}. I can help you create time-based notes, set reminders, or organize your schedule.";
    } else if (message.contains('thank')) {
      return "You're welcome! I'm here to help you stay organized and productive. Is there anything else I can assist you with?";
    } else if (message.contains('bye') || message.contains('goodbye')) {
      return "Goodbye! Feel free to come back anytime you need help with your notes. Have a great day!";
    } else {
      return "That's an interesting question! I'm designed to help with note-taking and organization. Could you tell me more about what you're trying to accomplish? I might be able to suggest some helpful features or approaches.";
    }
  }

  /// Extract keywords from content
  List<String> _extractKeywords(String content) {
    final words = content.toLowerCase()
        .replaceAll(RegExp(r'[^\w\s]'), ' ')
        .split(' ')
        .where((word) => word.length > 3)
        .toList();
    
    // Simple frequency-based keyword extraction
    final wordCount = <String, int>{};
    for (final word in words) {
      wordCount[word] = (wordCount[word] ?? 0) + 1;
    }
    
    final sortedWords = wordCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    return sortedWords.take(5).map((e) => e.key).toList();
  }

  /// Simple summarization fallback
  String _simpleSummarization(String content) {
    final words = content.split(' ');
    if (words.length <= 20) {
      return content; // Already short enough
    }
    
    // Take first 20 words as summary
    return words.take(20).join(' ') + '...';
  }
}
