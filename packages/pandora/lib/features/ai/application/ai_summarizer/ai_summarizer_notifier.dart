import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'ai_summarizer_state.dart';
import '../ai_service.dart';

@injectable
class AiSummarizerNotifier extends StateNotifier<AiSummarizerState> {
  final AiService _aiService;

  AiSummarizerNotifier(this._aiService) : super(const AiSummarizerState.initial());

  Future<void> summarizeText(String text) async {
    if (text.trim().isEmpty) {
      state = const AiSummarizerState.error('Text cannot be empty');
      return;
    }

    state = const AiSummarizerState.loading();

    try {
      final summary = await _aiService.summarizeText(text);
      state = AiSummarizerState.success(summary);
    } catch (e) {
      state = AiSummarizerState.error('Failed to summarize: ${e.toString()}');
    }
  }

  void reset() {
    state = const AiSummarizerState.initial();
  }
}
