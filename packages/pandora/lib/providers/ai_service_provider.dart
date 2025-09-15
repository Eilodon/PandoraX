import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../injection.dart';
import '../services/interfaces/ai_service.dart';
import '../config/environment.dart';

/// AI Chat conversation state
class AIChatState {
  final List<ChatMessage> messages;
  final bool isLoading;
  final String? error;
  final bool isInitialized;

  const AIChatState({
    this.messages = const [],
    this.isLoading = false,
    this.error,
    this.isInitialized = false,
  });

  AIChatState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    String? error,
    bool? isInitialized,
  }) {
    return AIChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }
}

/// Chat message model
class ChatMessage {
  final String id;
  final String content;
  final bool isUser;
  final DateTime timestamp;
  final bool isError;

  ChatMessage({
    required this.id,
    required this.content,
    required this.isUser,
    required this.timestamp,
    this.isError = false,
  });

  factory ChatMessage.user(String content) {
    return ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      isUser: true,
      timestamp: DateTime.now(),
    );
  }

  factory ChatMessage.ai(String content) {
    return ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      isUser: false,
      timestamp: DateTime.now(),
    );
  }

  factory ChatMessage.error(String content) {
    return ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      isUser: false,
      timestamp: DateTime.now(),
      isError: true,
    );
  }
}

/// AI Chat State Notifier
class AIChatNotifier extends StateNotifier<AIChatState> {
  late AIService _aiService;
  bool _serviceInitialized = false;

  AIChatNotifier() : super(const AIChatState()) {
    _initializeAIService();
  }

  /// Initialize AI service
  Future<void> _initializeAIService() async {
    try {
      _aiService = getIt<AIService>();
      
      if (!_aiService.isAvailable) {
        await _aiService.initialize();
      }
      
      _serviceInitialized = _aiService.isAvailable;
      
      state = state.copyWith(
        isInitialized: _serviceInitialized,
      );

      if (_serviceInitialized) {
        // Add welcome message
        _addWelcomeMessage();
      }
      
      if (Environment.enableLogging) {
        print('✅ AI Chat service initialized: $_serviceInitialized');
      }
    } catch (e) {
      state = state.copyWith(
        error: 'Failed to initialize AI service: $e',
        isInitialized: false,
      );
      
      if (Environment.enableLogging) {
        print('❌ AI Chat service initialization failed: $e');
      }
    }
  }

  /// Add welcome message
  void _addWelcomeMessage() {
    final welcomeMessage = ChatMessage.ai(
      'Hello! I\'m your AI assistant powered by Google Gemini. How can I help you today?',
    );
    
    state = state.copyWith(
      messages: [welcomeMessage],
    );
  }

  /// Send message to AI
  Future<void> sendMessage(String content) async {
    if (!_serviceInitialized || content.trim().isEmpty) return;

    // Add user message
    final userMessage = ChatMessage.user(content.trim());
    final newMessages = [...state.messages, userMessage];
    
    state = state.copyWith(
      messages: newMessages,
      isLoading: true,
      error: null,
    );

    try {
      // Get conversation history for context
      final history = state.messages
          .where((msg) => msg.content.isNotEmpty && !msg.isError)
          .map((msg) => {
                'role': msg.isUser ? 'user' : 'assistant',
                'content': msg.content,
              })
          .toList();

      // Generate AI response
      final response = await _aiService.generateChatResponse(content, history);
      
      // Add AI response
      final aiMessage = ChatMessage.ai(response);
      final updatedMessages = [...state.messages, aiMessage];
      
      state = state.copyWith(
        messages: updatedMessages,
        isLoading: false,
      );
      
      if (Environment.enableLogging) {
        print('💬 AI response generated successfully');
      }
    } catch (e) {
      // Add error message
      final errorMessage = ChatMessage.error('Sorry, I encountered an error: $e');
      final updatedMessages = [...state.messages, errorMessage];
      
      state = state.copyWith(
        messages: updatedMessages,
        isLoading: false,
        error: e.toString(),
      );
      
      if (Environment.enableLogging) {
        print('❌ AI response generation failed: $e');
      }
    }
  }

  /// Clear chat history
  void clearChat() {
    state = state.copyWith(
      messages: [],
      error: null,
    );
    
    if (_serviceInitialized) {
      _addWelcomeMessage();
    }
  }

  /// Retry last failed message
  Future<void> retryLastMessage() async {
    if (state.messages.isEmpty) return;
    
    // Find last user message
    ChatMessage? lastUserMessage;
    for (int i = state.messages.length - 1; i >= 0; i--) {
      if (state.messages[i].isUser) {
        lastUserMessage = state.messages[i];
        break;
      }
    }
    
    if (lastUserMessage != null) {
      // Remove error messages after the last user message
      final messagesUpToUser = <ChatMessage>[];
      for (final message in state.messages) {
        messagesUpToUser.add(message);
        if (message.id == lastUserMessage.id) break;
      }
      
      state = state.copyWith(messages: messagesUpToUser);
      
      // Retry the message
      await sendMessage(lastUserMessage.content);
    }
  }

  /// Reinitialize AI service
  Future<void> reinitialize() async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );
    
    await _initializeAIService();
    
    state = state.copyWith(isLoading: false);
  }
}

/// AI Enhancement state
class AIEnhancementState {
  final String? summary;
  final String? enhancedContent;
  final List<String> titleSuggestions;
  final List<String> tags;
  final bool isLoading;
  final String? error;

  const AIEnhancementState({
    this.summary,
    this.enhancedContent,
    this.titleSuggestions = const [],
    this.tags = const [],
    this.isLoading = false,
    this.error,
  });

  AIEnhancementState copyWith({
    String? summary,
    String? enhancedContent,
    List<String>? titleSuggestions,
    List<String>? tags,
    bool? isLoading,
    String? error,
  }) {
    return AIEnhancementState(
      summary: summary ?? this.summary,
      enhancedContent: enhancedContent ?? this.enhancedContent,
      titleSuggestions: titleSuggestions ?? this.titleSuggestions,
      tags: tags ?? this.tags,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  void clear() {
    // Clear all enhancement results
  }
}

/// AI Enhancement Notifier
class AIEnhancementNotifier extends StateNotifier<AIEnhancementState> {
  late AIService _aiService;

  AIEnhancementNotifier() : super(const AIEnhancementState()) {
    _aiService = getIt<AIService>();
  }

  /// Generate summary for content
  Future<void> generateSummary(String content) async {
    if (content.trim().isEmpty) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final summary = await _aiService.summarizeNote(content);
      state = state.copyWith(
        summary: summary,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to generate summary: $e',
      );
    }
  }

  /// Enhance content
  Future<void> enhanceContent(String content) async {
    if (content.trim().isEmpty) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final enhanced = await _aiService.enhanceContent(content);
      state = state.copyWith(
        enhancedContent: enhanced,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to enhance content: $e',
      );
    }
  }

  /// Generate title suggestions
  Future<void> generateTitles(String content) async {
    if (content.trim().isEmpty) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final titles = await _aiService.generateTitleSuggestions(content);
      state = state.copyWith(
        titleSuggestions: titles,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to generate titles: $e',
      );
    }
  }

  /// Generate tags
  Future<void> generateTags(String content) async {
    if (content.trim().isEmpty) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final tags = await _aiService.generateTags(content);
      state = state.copyWith(
        tags: tags,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to generate tags: $e',
      );
    }
  }

  /// Run all enhancements
  Future<void> enhanceAll(String content) async {
    if (content.trim().isEmpty) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final results = await Future.wait([
        _aiService.summarizeNote(content),
        _aiService.enhanceContent(content),
        _aiService.generateTitleSuggestions(content),
        _aiService.generateTags(content),
      ]);

      state = state.copyWith(
        summary: results[0] as String,
        enhancedContent: results[1] as String,
        titleSuggestions: results[2] as List<String>,
        tags: results[3] as List<String>,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to run enhancements: $e',
      );
    }
  }

  /// Clear all results
  void clearResults() {
    state = const AIEnhancementState();
  }
}

/// Providers
final aiChatProvider = StateNotifierProvider<AIChatNotifier, AIChatState>((ref) {
  return AIChatNotifier();
});

final aiEnhancementProvider = StateNotifierProvider<AIEnhancementNotifier, AIEnhancementState>((ref) {
  return AIEnhancementNotifier();
});

/// AI Service availability provider
final aiServiceAvailableProvider = FutureProvider<bool>((ref) async {
  try {
    final aiService = getIt<AIService>();
    if (!aiService.isAvailable) {
      await aiService.initialize();
    }
    return aiService.isAvailable;
  } catch (e) {
    return false;
  }
});

/// AI Service status provider
final aiServiceStatusProvider = Provider<String>((ref) {
  try {
    final aiService = getIt<AIService>();
    return aiService.status;
  } catch (e) {
    return 'Service not available';
  }
});
