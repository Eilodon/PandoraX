import 'dart:async';
import 'package:note_domain/note_domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'note_watcher_state.dart';

class NoteWatcherNotifier extends StateNotifier<NoteWatcherState> {
  final NoteRepository _repository;
  StreamSubscription? _subscription;

  NoteWatcherNotifier(this._repository) : super(const NoteWatcherState.initial()) {
    watchAllNotes();
  }

  void watchAllNotes() {
    state = const NoteWatcherState.loading();
    _subscription?.cancel();
    _subscription = _repository.watchAllNotes().listen(
      (notes) => state = NoteWatcherState.loadSuccess(notes),
      onError: (error) => state = NoteWatcherState.loadFailure(error.toString()),
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
