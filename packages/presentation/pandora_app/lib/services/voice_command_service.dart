import 'package:ai_domain/ai_domain.dart';
import 'package:core_utils/core_utils.dart';

/// Service for processing voice commands
class VoiceCommandService {
  static final VoiceCommandService _instance = VoiceCommandService._internal();
  factory VoiceCommandService() => _instance;
  VoiceCommandService._internal();

  final List<VoiceCommand> _commands = List.from(VoiceCommands.all);
  final Map<String, Function(Map<String, dynamic>)> _handlers = {};
  
  bool _isInitialized = false;

  /// Initialize voice command service
  Future<bool> initialize() async {
    try {
      AppLogger.info('Initializing Voice Command Service...');
      
      // Register default command handlers
      _registerDefaultHandlers();
      
      _isInitialized = true;
      AppLogger.success('Voice Command Service initialized successfully');
      return true;
    } catch (e) {
      AppLogger.error('Failed to initialize Voice Command Service', e);
      return false;
    }
  }

  /// Register default command handlers
  void _registerDefaultHandlers() {
    _handlers[VoiceCommands.createNote.id] = _handleCreateNote;
    _handlers[VoiceCommands.searchNotes.id] = _handleSearchNotes;
    _handlers[VoiceCommands.openSettings.id] = _handleOpenSettings;
    _handlers[VoiceCommands.help.id] = _handleHelp;
    _handlers[VoiceCommands.translate.id] = _handleTranslate;
    _handlers[VoiceCommands.summarize.id] = _handleSummarize;
    _handlers[VoiceCommands.voiceNote.id] = _handleVoiceNote;
    _handlers[VoiceCommands.stopListening.id] = _handleStopListening;
    _handlers[VoiceCommands.startListening.id] = _handleStartListening;
  }

  /// Process voice command
  Future<VoiceCommandResult> processCommand(String text) async {
    if (!_isInitialized) {
      AppLogger.warning('Voice Command Service not initialized');
      return VoiceCommandResult.error('Service not initialized');
    }

    try {
      AppLogger.info('Processing voice command: $text');
      
      // Find matching command
      final command = _findMatchingCommand(text);
      if (command == null) {
        AppLogger.warning('No matching command found for: $text');
        return VoiceCommandResult.notFound('No matching command found');
      }

      // Extract parameters
      final parameters = _extractParameters(text, command);
      
      // Execute command
      final result = await _executeCommand(command, parameters);
      
      AppLogger.success('Voice command executed successfully: ${command.name}');
      return result;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to process voice command', e, stackTrace);
      return VoiceCommandResult.error('Failed to process command: $e');
    }
  }

  /// Find matching command
  VoiceCommand? _findMatchingCommand(String text) {
    VoiceCommand? bestMatch;
    double bestScore = 0.0;

    for (final command in _commands) {
      if (!command.isEnabled) continue;
      
      final score = command.getConfidenceScore(text);
      if (score > bestScore && score > 0.5) { // Minimum confidence threshold
        bestMatch = command;
        bestScore = score;
      }
    }

    return bestMatch;
  }

  /// Extract parameters from text
  Map<String, dynamic> _extractParameters(String text, VoiceCommand command) {
    final parameters = <String, dynamic>{};
    
    switch (command.type) {
      case VoiceCommandType.createNote:
        parameters['title'] = _extractTitle(text);
        parameters['content'] = _extractContent(text);
        break;
      case VoiceCommandType.searchNotes:
        parameters['query'] = _extractSearchQuery(text);
        break;
      case VoiceCommandType.translate:
        parameters['text'] = _extractText(text);
        parameters['targetLanguage'] = _extractTargetLanguage(text);
        break;
      case VoiceCommandType.summarize:
        parameters['text'] = _extractText(text);
        parameters['style'] = _extractSummarizationStyle(text);
        break;
      case VoiceCommandType.voiceNote:
        parameters['title'] = _extractTitle(text);
        break;
      default:
        // No parameters needed
        break;
    }

    return parameters;
  }

  /// Extract title from text
  String _extractTitle(String text) {
    // Look for patterns like "note about X" or "title X"
    final patterns = [
      RegExp(r'note about (.+)', caseSensitive: false),
      RegExp(r'title (.+)', caseSensitive: false),
      RegExp(r'create note (.+)', caseSensitive: false),
    ];

    for (final pattern in patterns) {
      final match = pattern.firstMatch(text);
      if (match != null) {
        return match.group(1)?.trim() ?? 'Untitled';
      }
    }

    return 'Untitled';
  }

  /// Extract content from text
  String _extractContent(String text) {
    // Look for patterns like "content X" or "about X"
    final patterns = [
      RegExp(r'content (.+)', caseSensitive: false),
      RegExp(r'about (.+)', caseSensitive: false),
      RegExp(r'with (.+)', caseSensitive: false),
    ];

    for (final pattern in patterns) {
      final match = pattern.firstMatch(text);
      if (match != null) {
        return match.group(1)?.trim() ?? '';
      }
    }

    return '';
  }

  /// Extract search query from text
  String _extractSearchQuery(String text) {
    // Remove command words and return the rest
    final commandWords = ['search', 'find', 'look for', 'search for'];
    String query = text.toLowerCase();
    
    for (final word in commandWords) {
      query = query.replaceAll(word, '').trim();
    }
    
    return query.isEmpty ? text : query;
  }

  /// Extract text for translation/summarization
  String _extractText(String text) {
    // Look for patterns like "translate X" or "summarize X"
    final patterns = [
      RegExp(r'translate (.+)', caseSensitive: false),
      RegExp(r'summarize (.+)', caseSensitive: false),
      RegExp(r'text (.+)', caseSensitive: false),
    ];

    for (final pattern in patterns) {
      final match = pattern.firstMatch(text);
      if (match != null) {
        return match.group(1)?.trim() ?? text;
      }
    }

    return text;
  }

  /// Extract target language from text
  String _extractTargetLanguage(String text) {
    // Look for language names or codes
    final languageMap = {
      'english': 'en',
      'vietnamese': 'vi',
      'spanish': 'es',
      'french': 'fr',
      'german': 'de',
      'japanese': 'ja',
      'korean': 'ko',
      'chinese': 'zh',
      'arabic': 'ar',
      'hindi': 'hi',
    };

    final lowerText = text.toLowerCase();
    for (final entry in languageMap.entries) {
      if (lowerText.contains(entry.key)) {
        return entry.value;
      }
    }

    return 'en'; // Default to English
  }

  /// Extract summarization style from text
  String _extractSummarizationStyle(String text) {
    final lowerText = text.toLowerCase();
    
    if (lowerText.contains('bullet') || lowerText.contains('points')) {
      return 'bulletPoints';
    } else if (lowerText.contains('executive') || lowerText.contains('summary')) {
      return 'executiveSummary';
    } else if (lowerText.contains('detailed') || lowerText.contains('analysis')) {
      return 'detailedAnalysis';
    }
    
    return 'bulletPoints'; // Default style
  }

  /// Execute command
  Future<VoiceCommandResult> _executeCommand(VoiceCommand command, Map<String, dynamic> parameters) async {
    final handler = _handlers[command.id];
    if (handler == null) {
      return VoiceCommandResult.error('No handler found for command: ${command.id}');
    }

    try {
      await handler(parameters);
      return VoiceCommandResult.success('Command executed successfully', command, parameters);
    } catch (e) {
      AppLogger.error('Failed to execute command: ${command.id}', e);
      return VoiceCommandResult.error('Failed to execute command: $e');
    }
  }

  /// Command handlers
  void _handleCreateNote(Map<String, dynamic> parameters) {
    AppLogger.info('Creating note with parameters: $parameters');
    // TODO: Implement note creation
  }

  void _handleSearchNotes(Map<String, dynamic> parameters) {
    AppLogger.info('Searching notes with query: ${parameters['query']}');
    // TODO: Implement note search
  }

  void _handleOpenSettings(Map<String, dynamic> parameters) {
    AppLogger.info('Opening settings');
    // TODO: Implement settings opening
  }

  void _handleHelp(Map<String, dynamic> parameters) {
    AppLogger.info('Showing help');
    // TODO: Implement help display
  }

  void _handleTranslate(Map<String, dynamic> parameters) {
    AppLogger.info('Translating text: ${parameters['text']} to ${parameters['targetLanguage']}');
    // TODO: Implement translation
  }

  void _handleSummarize(Map<String, dynamic> parameters) {
    AppLogger.info('Summarizing text: ${parameters['text']} with style: ${parameters['style']}');
    // TODO: Implement summarization
  }

  void _handleVoiceNote(Map<String, dynamic> parameters) {
    AppLogger.info('Creating voice note with title: ${parameters['title']}');
    // TODO: Implement voice note creation
  }

  void _handleStopListening(Map<String, dynamic> parameters) {
    AppLogger.info('Stopping voice recognition');
    // TODO: Implement stop listening
  }

  void _handleStartListening(Map<String, dynamic> parameters) {
    AppLogger.info('Starting voice recognition');
    // TODO: Implement start listening
  }

  /// Add custom command
  void addCommand(VoiceCommand command, Function(Map<String, dynamic>) handler) {
    _commands.add(command);
    _handlers[command.id] = handler;
    AppLogger.info('Added custom command: ${command.name}');
  }

  /// Remove command
  void removeCommand(String commandId) {
    _commands.removeWhere((command) => command.id == commandId);
    _handlers.remove(commandId);
    AppLogger.info('Removed command: $commandId');
  }

  /// Get all commands
  List<VoiceCommand> get commands => List.unmodifiable(_commands);

  /// Get enabled commands
  List<VoiceCommand> get enabledCommands => _commands.where((command) => command.isEnabled).toList();

  /// Check if service is initialized
  bool get isInitialized => _isInitialized;

  /// Dispose service
  Future<void> dispose() async {
    _commands.clear();
    _handlers.clear();
    _isInitialized = false;
    AppLogger.info('Voice Command Service disposed');
  }
}

/// Voice command result
class VoiceCommandResult {
  final bool success;
  final String message;
  final VoiceCommand? command;
  final Map<String, dynamic>? parameters;

  const VoiceCommandResult._({
    required this.success,
    required this.message,
    this.command,
    this.parameters,
  });

  factory VoiceCommandResult.success(String message, VoiceCommand command, Map<String, dynamic> parameters) {
    return VoiceCommandResult._(
      success: true,
      message: message,
      command: command,
      parameters: parameters,
    );
  }

  factory VoiceCommandResult.error(String message) {
    return VoiceCommandResult._(
      success: false,
      message: message,
    );
  }

  factory VoiceCommandResult.notFound(String message) {
    return VoiceCommandResult._(
      success: false,
      message: message,
    );
  }
}
