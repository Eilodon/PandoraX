import 'package:freezed_annotation/freezed_annotation.dart';

part 'speech_recognition_state.freezed.dart';

@freezed
class SpeechRecognitionState with _$SpeechRecognitionState {
  const factory SpeechRecognitionState({
    @Default(false) bool isListening,
    @Default(false) bool isInitialized,
    @Default('') String recognizedText,
    @Default('') String partialText,
    @Default(false) bool hasError,
    String? errorMessage,
  }) = _SpeechRecognitionState;
}
