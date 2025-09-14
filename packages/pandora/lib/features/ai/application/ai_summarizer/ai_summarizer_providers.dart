import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pandora/injection.dart';
import 'ai_summarizer_notifier.dart';
import 'ai_summarizer_state.dart';
import '../ai_service.dart';

final aiServiceProvider = Provider<AiService>((ref) {
  return getIt<AiService>();
});

final aiSummarizerProvider = StateNotifierProvider<AiSummarizerNotifier, AiSummarizerState>((ref) {
  final aiService = ref.watch(aiServiceProvider);
  return AiSummarizerNotifier(aiService);
});
