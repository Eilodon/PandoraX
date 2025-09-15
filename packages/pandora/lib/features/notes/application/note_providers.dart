import 'package:note_domain/note_domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pandora/injection.dart';
import 'note_watcher/note_watcher_notifier.dart';
import 'note_watcher/note_watcher_state.dart';

final noteRepositoryProvider = Provider<NoteRepository>((ref) {
  return getIt<NoteRepository>();
});

final noteWatcherProvider = StateNotifierProvider<NoteWatcherNotifier, NoteWatcherState>((ref) {
  return NoteWatcherNotifier(ref.watch(noteRepositoryProvider));
});
