import 'package:freezed_annotation/freezed_annotation.dart';

part 'voice_command.freezed.dart';
part 'voice_command.g.dart';

/// Voice command types
enum VoiceCommandType {
  createNote,
  searchNote,
  deleteNote,
  openSettings,
  enableVoice,
  disableVoice,
  translate,
  summarize,
  help,
  quit,
}

/// Voice command entity
@freezed
class VoiceCommand with _$VoiceCommand {
  const factory VoiceCommand({
    required String id,
    required String name,
    required String description,
    required VoiceCommandType type,
    required List<String> keywords,
    @Default(true) bool isEnabled,
    Map<String, dynamic>? parameters,
  }) = _VoiceCommand;

  factory VoiceCommand.fromJson(Map<String, dynamic> json) =>
      _$VoiceCommandFromJson(json);
}
