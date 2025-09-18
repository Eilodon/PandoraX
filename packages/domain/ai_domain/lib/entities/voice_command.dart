import 'package:freezed_annotation/freezed_annotation.dart';

part 'voice_command.freezed.dart';
part 'voice_command.g.dart';

/// Voice command for voice recognition
@freezed
class VoiceCommand with _$VoiceCommand {
  const factory VoiceCommand({
    required String id,
    required String name,
    required String description,
    required List<String> patterns,
    required VoiceCommandType type,
    required Map<String, dynamic> parameters,
    @Default(true) bool isEnabled,
    @Default(0) int usageCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _VoiceCommand;

  const VoiceCommand._();

  factory VoiceCommand.fromJson(Map<String, dynamic> json) =>
      _$VoiceCommandFromJson(json);

  /// Get display name for UI
  String get displayName => name;

  /// Get icon for UI based on type
  String get icon {
    switch (type) {
      case VoiceCommandType.createNote:
        return '📝';
      case VoiceCommandType.searchNotes:
        return '🔍';
      case VoiceCommandType.openSettings:
        return '⚙️';
      case VoiceCommandType.help:
        return '❓';
      case VoiceCommandType.translate:
        return '🌐';
      case VoiceCommandType.summarize:
        return '📊';
      case VoiceCommandType.voiceNote:
        return '🎤';
      case VoiceCommandType.stopListening:
        return '⏹️';
      case VoiceCommandType.startListening:
        return '▶️';
      case VoiceCommandType.custom:
        return '⚙️';
    }
  }

  /// Check if command matches the given text
  bool matches(String text) {
    final normalizedText = text.toLowerCase().trim();
    return patterns.any((pattern) {
      final normalizedPattern = pattern.toLowerCase().trim();
      
      // Exact match
      if (normalizedText == normalizedPattern) return true;
      
      // Contains match
      if (normalizedText.contains(normalizedPattern)) return true;
      
      // Fuzzy match (simple implementation)
      if (_fuzzyMatch(normalizedText, normalizedPattern)) return true;
      
      return false;
    });
  }

  /// Simple fuzzy matching
  bool _fuzzyMatch(String text, String pattern) {
    if (text.length < pattern.length) return false;
    
    int matches = 0;
    int patternIndex = 0;
    
    for (int i = 0; i < text.length && patternIndex < pattern.length; i++) {
      if (text[i] == pattern[patternIndex]) {
        matches++;
        patternIndex++;
      }
    }
    
    // Consider it a match if 80% of characters match
    return matches >= (pattern.length * 0.8);
  }

  /// Get confidence score for text match
  double getConfidenceScore(String text) {
    final normalizedText = text.toLowerCase().trim();
    double maxScore = 0.0;
    
    for (final pattern in patterns) {
      final normalizedPattern = pattern.toLowerCase().trim();
      double score = 0.0;
      
      // Exact match gets highest score
      if (normalizedText == normalizedPattern) {
        score = 1.0;
      }
      // Contains match gets medium score
      else if (normalizedText.contains(normalizedPattern)) {
        score = 0.8;
      }
      // Fuzzy match gets lower score
      else if (_fuzzyMatch(normalizedText, normalizedPattern)) {
        score = 0.6;
      }
      
      if (score > maxScore) {
        maxScore = score;
      }
    }
    
    return maxScore;
  }

  /// Get required parameters
  List<String> get requiredParameters {
    return parameters.keys.where((key) => 
      parameters[key] is String && (parameters[key] as String).contains('required')
    ).toList();
  }

  /// Check if all required parameters are provided
  bool hasAllRequiredParameters(Map<String, dynamic>? values) {
    if (values == null) return false;
    
    final required = requiredParameters;
    return required.every((param) => values.containsKey(param));
  }
}

/// Voice command types
enum VoiceCommandType {
  createNote,
  searchNotes,
  openSettings,
  help,
  translate,
  summarize,
  voiceNote,
  stopListening,
  startListening,
  custom,
}

/// Predefined voice commands
class VoiceCommands {
  static const VoiceCommand createNote = VoiceCommand(
    id: 'create_note',
    name: 'Create Note',
    description: 'Create a new note',
    patterns: [
      'create note',
      'new note',
      'add note',
      'write note',
      'note about',
    ],
    type: VoiceCommandType.createNote,
    parameters: {
      'title': 'required',
      'content': 'optional',
    },
  );

  static const VoiceCommand searchNotes = VoiceCommand(
    id: 'search_notes',
    name: 'Search Notes',
    description: 'Search for notes',
    patterns: [
      'search notes',
      'find notes',
      'look for',
      'search for',
      'find',
    ],
    type: VoiceCommandType.searchNotes,
    parameters: {
      'query': 'required',
    },
  );

  static const VoiceCommand openSettings = VoiceCommand(
    id: 'open_settings',
    name: 'Open Settings',
    description: 'Open app settings',
    patterns: [
      'open settings',
      'settings',
      'preferences',
      'configuration',
      'options',
    ],
    type: VoiceCommandType.openSettings,
    parameters: {},
  );

  static const VoiceCommand help = VoiceCommand(
    id: 'help',
    name: 'Help',
    description: 'Show help information',
    patterns: [
      'help',
      'what can you do',
      'commands',
      'how to',
      'assistance',
    ],
    type: VoiceCommandType.help,
    parameters: {},
  );

  static const VoiceCommand translate = VoiceCommand(
    id: 'translate',
    name: 'Translate',
    description: 'Translate text',
    patterns: [
      'translate',
      'translate to',
      'convert to',
      'change language',
    ],
    type: VoiceCommandType.translate,
    parameters: {
      'text': 'required',
      'targetLanguage': 'required',
    },
  );

  static const VoiceCommand summarize = VoiceCommand(
    id: 'summarize',
    name: 'Summarize',
    description: 'Summarize text',
    patterns: [
      'summarize',
      'summary',
      'brief',
      'short version',
      'key points',
    ],
    type: VoiceCommandType.summarize,
    parameters: {
      'text': 'required',
      'style': 'optional',
    },
  );

  static const VoiceCommand voiceNote = VoiceCommand(
    id: 'voice_note',
    name: 'Voice Note',
    description: 'Create a voice note',
    patterns: [
      'voice note',
      'record note',
      'audio note',
      'speak note',
      'voice memo',
    ],
    type: VoiceCommandType.voiceNote,
    parameters: {
      'title': 'optional',
    },
  );

  static const VoiceCommand stopListening = VoiceCommand(
    id: 'stop_listening',
    name: 'Stop Listening',
    description: 'Stop voice recognition',
    patterns: [
      'stop listening',
      'stop',
      'pause',
      'end',
      'finish',
    ],
    type: VoiceCommandType.stopListening,
    parameters: {},
  );

  static const VoiceCommand startListening = VoiceCommand(
    id: 'start_listening',
    name: 'Start Listening',
    description: 'Start voice recognition',
    patterns: [
      'start listening',
      'listen',
      'voice command',
      'speak',
      'talk',
    ],
    type: VoiceCommandType.startListening,
    parameters: {},
  );

  /// Get all built-in commands
  static List<VoiceCommand> get all => [
    createNote,
    searchNotes,
    openSettings,
    help,
    translate,
    summarize,
    voiceNote,
    stopListening,
    startListening,
  ];

  /// Get commands by type
  static List<VoiceCommand> getByType(VoiceCommandType type) {
    return all.where((command) => command.type == type).toList();
  }

  /// Get command by ID
  static VoiceCommand? getById(String id) {
    try {
      return all.firstWhere((command) => command.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get enabled commands
  static List<VoiceCommand> get enabled {
    return all.where((command) => command.isEnabled).toList();
  }

  /// Get most used commands
  static List<VoiceCommand> get mostUsed {
    final sorted = List<VoiceCommand>.from(all);
    sorted.sort((a, b) => b.usageCount.compareTo(a.usageCount));
    return sorted.take(5).toList();
  }
}
