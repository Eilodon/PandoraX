import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pandora/injection.dart';
import 'ai_chat_notifier.dart';
import 'ai_chat_state.dart';
import '../ai_service.dart';

final aiChatServiceProvider = Provider<AiService>((ref) {
  return getIt<AiService>();
});

final aiChatProvider = StateNotifierProvider<AiChatNotifier, AiChatState>((ref) {
  final aiService = ref.watch(aiChatServiceProvider);
  return AiChatNotifier(aiService);
});
