import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_core/ai_core.dart';
import '../widgets/ai_mode_indicator.dart' as mode_indicator;
import '../widgets/chat_message_widget.dart';
import '../widgets/ai_input_widget.dart';
import '../widgets/ai_health_status_widget.dart' as health_widget;

/// AI Mode Provider
final aiModeProvider = StateProvider<AIMode>((ref) => const AIMode(
  isOnDevice: false,
  modelName: 'Gemini',
  status: 'Ready',
  lastSwitch: null,
));

/// AI Mode class
class AIMode {
  final bool isOnDevice;
  final String modelName;
  final String status;
  final DateTime? lastSwitch;

  const AIMode({
    required this.isOnDevice,
    required this.modelName,
    required this.status,
    this.lastSwitch,
  });
}

/// Enhanced AI Chat Screen with on-device features
class EnhancedAIChatScreen extends ConsumerStatefulWidget {
  const EnhancedAIChatScreen({super.key});

  @override
  ConsumerState<EnhancedAIChatScreen> createState() => _EnhancedAIChatScreenState();
}

class _EnhancedAIChatScreenState extends ConsumerState<EnhancedAIChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize AI services
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(aiChatProvider.notifier).initialize();
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(aiChatProvider);
    final aiMode = ref.watch(aiModeProvider);
    final healthStatus = ref.watch(health_widget.aiHealthStatusProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Chat'),
        centerTitle: true,
        actions: [
          // AI Mode Indicator
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: mode_indicator.AIModeIndicator(
              onTap: _showAIModeSettings,
              showDetails: true,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Health Status Bar
          if (healthStatus != health_widget.HealthStatus.healthy)
            _buildHealthWarning(healthStatus),
          
          // Chat Messages
          Expanded(
            child: _buildChatMessages(chatState.messages),
          ),
          
          // AI Input
          _buildAIInput(),
        ],
      ),
    );
  }

  Widget _buildHealthWarning(health_widget.HealthStatus healthStatus) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.orange.shade50,
      child: Row(
        children: [
          Icon(
            Icons.warning,
            color: Colors.orange.shade600,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'AI system needs attention',
              style: TextStyle(
                color: Colors.orange.shade700,
                fontSize: 12,
              ),
            ),
          ),
          TextButton(
            onPressed: _showHealthDetails,
            child: Text(
              'Details',
              style: TextStyle(
                color: Colors.orange.shade700,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatMessages(List<ChatMessage> messages) {
    if (messages.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return ChatMessageWidget(
          message: message,
          onRetry: message.isAssistant && message.hasError 
              ? () => _retryMessage(message)
              : null,
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Start a conversation with AI',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Ask questions, get help, or just chat!',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAIInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
      ),
      child: AIInputWidget(
        controller: _messageController,
        isLoading: _isLoading,
        onSend: _sendMessage,
        onVoiceInput: _startVoiceInput,
        onAttachFile: _attachFile,
      ),
    );
  }

  void _sendMessage(String message) async {
    if (message.trim().isEmpty || _isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Add user message
      ref.read(aiChatProvider.notifier).addMessage(
        ChatMessage.user(message),
      );

      // Clear input
      _messageController.clear();

      // Scroll to bottom
      _scrollToBottom();

      // Get AI response
      final response = await ref.read(aiChatProvider.notifier).getAIResponse(message);

      // Add AI response
      ref.read(aiChatProvider.notifier).addMessage(
        ChatMessage.assistant(response),
      );

      // Scroll to bottom
      _scrollToBottom();
    } catch (e) {
      // Add error message
      ref.read(aiChatProvider.notifier).addMessage(
        ChatMessage.assistant('Sorry, I encountered an error: ${e.toString()}'),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _retryMessage(ChatMessage message) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Remove the error message
      ref.read(aiChatProvider.notifier).removeMessage(message);

      // Get AI response again
      final response = await ref.read(aiChatProvider.notifier).getAIResponse(message.content);

      // Add new AI response
      ref.read(aiChatProvider.notifier).addMessage(
        ChatMessage.assistant(response),
      );

      // Scroll to bottom
      _scrollToBottom();
    } catch (e) {
      // Add error message
      ref.read(aiChatProvider.notifier).addMessage(
        ChatMessage.assistant('Sorry, I encountered an error: ${e.toString()}'),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _startVoiceInput() {
    // TODO: Implement voice input
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Voice input coming soon!')),
    );
  }

  void _attachFile() {
    // TODO: Implement file attachment
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('File attachment coming soon!')),
    );
  }

  void _showAIModeSettings() {
    showModalBottomSheet(
      context: context,
      builder: (context) => _buildAIModeSettingsSheet(),
    );
  }

  Widget _buildAIModeSettingsSheet() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AI Mode Settings',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const mode_indicator.DetailedAIModeIndicator(),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(aiModeProvider.notifier).state = AIMode(
                      isOnDevice: true,
                      modelName: 'phi-3-mini',
                      status: 'Ready',
                      lastSwitch: DateTime.now(),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('Use On-Device'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(aiModeProvider.notifier).state = AIMode(
                      isOnDevice: false,
                      modelName: 'Gemini',
                      status: 'Ready',
                      lastSwitch: DateTime.now(),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('Use Cloud'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showHealthDetails() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('AI Health Status'),
        content: const AIHealthStatusWidget(),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}

/// AI Chat Provider
final aiChatProvider = StateNotifierProvider<AIChatNotifier, AIChatState>((ref) {
  return AIChatNotifier();
});

/// AI Chat State
class AIChatState {
  final List<ChatMessage> messages;
  final bool isInitialized;
  final String? error;

  const AIChatState({
    this.messages = const [],
    this.isInitialized = false,
    this.error,
  });
}

/// AI Chat Notifier
class AIChatNotifier extends StateNotifier<AIChatState> {
  AIChatNotifier() : super(const AIChatState());

  void initialize() {
    state = state.copyWith(isInitialized: true);
  }

  void addMessage(ChatMessage message) {
    state = state.copyWith(
      messages: [...state.messages, message],
    );
  }

  void removeMessage(ChatMessage message) {
    state = state.copyWith(
      messages: state.messages.where((m) => m != message).toList(),
    );
  }

  Future<String> getAIResponse(String prompt) async {
    // Simulate AI response
    await Future.delayed(const Duration(seconds: 2));
    
    // Simulate occasional errors
    if (DateTime.now().millisecondsSinceEpoch % 10 < 2) {
      throw Exception('Simulated AI error');
    }
    
    return 'AI response to: $prompt';
  }
}

/// Extension for AIChatState
extension AIChatStateExtension on AIChatState {
  AIChatState copyWith({
    List<ChatMessage>? messages,
    bool? isInitialized,
    String? error,
  }) {
    return AIChatState(
      messages: messages ?? this.messages,
      isInitialized: isInitialized ?? this.isInitialized,
      error: error ?? this.error,
    );
  }
}

/// Extension for ChatMessage
extension ChatMessageExtension on ChatMessage {
  bool get hasError => content.contains('error') || content.contains('Error');
}
