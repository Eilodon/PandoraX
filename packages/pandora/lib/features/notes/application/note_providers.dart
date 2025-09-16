import 'package:note_domain/note_domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pandora/injection.dart';
import 'package:cac_core/cac_core.dart';
import 'package:pandora/features/services/interfaces/ai_service.dart' as ai;
import 'note_watcher/note_watcher_notifier.dart';
import 'note_watcher/note_watcher_state.dart';

final noteRepositoryProvider = Provider<NoteRepository>((ref) {
  return getIt<NoteRepository>();
});

final noteWatcherProvider = StateNotifierProvider<NoteWatcherNotifier, NoteWatcherState>((ref) {
  return NoteWatcherNotifier(ref.watch(noteRepositoryProvider));
});

final memoryRepositoryProvider = Provider<MemoryRepository>((ref) {
  return getIt<MemoryRepository>();
});

final eventBusServiceProvider = Provider<EventBusService>((ref) {
  return getIt<EventBusService>();
});

final pandoraAiServiceProvider = Provider<ai.AIService>((ref) {
  return getIt<ai.AIService>();
});
