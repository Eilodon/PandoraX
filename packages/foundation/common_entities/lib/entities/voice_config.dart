import 'package:freezed_annotation/freezed_annotation.dart';

part 'voice_config.freezed.dart';
part 'voice_config.g.dart';

/// Voice command configuration
@freezed
class VoiceCommand with _$VoiceCommand {
  const factory VoiceCommand({
    required String id,
    required String name,
    required String description,
    required VoiceCommandType type,
    required List<String> keywords,
    required String action,
    required Map<String, dynamic> parameters,
    @Default(true) bool isEnabled,
    @Default(0.8) double confidenceThreshold,
    @Default(1) int priority,
    String? category,
    String? icon,
    String? shortcut,
  }) = _VoiceCommand;

  factory VoiceCommand.fromJson(Map<String, dynamic> json) =>
      _$VoiceCommandFromJson(json);
}

/// Voice command types
@freezed
class VoiceCommandType with _$VoiceCommandType {
  const factory VoiceCommandType.navigation() = NavigationCommand;
  const factory VoiceCommandType.action() = ActionCommand;
  const factory VoiceCommandType.query() = QueryCommand;
  const factory VoiceCommandType.creation() = CreationCommand;
  const factory VoiceCommandType.deletion() = DeletionCommand;
  const factory VoiceCommandType.modification() = ModificationCommand;
  const factory VoiceCommandType.search() = SearchCommand;
  const factory VoiceCommandType.filter() = FilterCommand;
  const factory VoiceCommandType.sort() = SortCommand;
  const factory VoiceCommandType.export() = ExportCommand;
  const factory VoiceCommandType.import() = ImportCommand;

  factory VoiceCommandType.fromJson(Map<String, dynamic> json) =>
      _$VoiceCommandTypeFromJson(json);
}

/// Voice language configuration
@freezed
class VoiceLanguage with _$VoiceLanguage {
  const factory VoiceLanguage({
    required String code,
    required String name,
    required String nativeName,
    required String countryCode,
    @Default(0.8) double confidence,
    @Default(true) bool isSupported,
    @Default(false) bool isDefault,
    String? model,
    String? accent,
  }) = _VoiceLanguage;

  factory VoiceLanguage.fromJson(Map<String, dynamic> json) =>
      _$VoiceLanguageFromJson(json);
}

/// Voice recognition settings
@freezed
class VoiceRecognitionSettings with _$VoiceRecognitionSettings {
  const factory VoiceRecognitionSettings({
    required VoiceLanguage language,
    @Default(0.8) double confidenceThreshold,
    @Default(5000) int timeoutMs,
    @Default(true) bool enablePartialResults,
    @Default(true) bool enablePunctuation,
    @Default(true) bool enableCapitalization,
    @Default(false) bool enableProfanityFilter,
    @Default(true) bool enableAutoPunctuation,
    @Default(1.0) double speechRate,
    @Default(1.0) double pitch,
    @Default(1.0) double volume,
  }) = _VoiceRecognitionSettings;

  factory VoiceRecognitionSettings.fromJson(Map<String, dynamic> json) =>
      _$VoiceRecognitionSettingsFromJson(json);
}
