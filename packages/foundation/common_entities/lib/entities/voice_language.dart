import 'package:freezed_annotation/freezed_annotation.dart';

part 'voice_language.freezed.dart';
part 'voice_language.g.dart';

/// Voice language entity
@freezed
class VoiceLanguage with _$VoiceLanguage {
  const factory VoiceLanguage({
    required String code,
    required String name,
    required String nativeName,
    @Default(true) bool isSTTSupported,
    @Default(true) bool isTTSSupported,
    required String sttCode,
    required String ttsCode,
    @Default(1.0) double defaultSpeechRate,
    @Default(1.0) double defaultVolume,
    @Default(1.0) double defaultPitch,
  }) = _VoiceLanguage;

  factory VoiceLanguage.fromJson(Map<String, dynamic> json) =>
      _$VoiceLanguageFromJson(json);
}
