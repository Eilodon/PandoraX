import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_summarizer_state.freezed.dart';

@freezed
class AiSummarizerState with _$AiSummarizerState {
  const factory AiSummarizerState.initial() = _Initial;
  const factory AiSummarizerState.loading() = _Loading;
  const factory AiSummarizerState.success(String summary) = _Success;
  const factory AiSummarizerState.error(String message) = _Error;
}
