import 'package:note_domain/note_domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'note_form_state.dart';
import '../note_providers.dart';

class NoteFormNotifier extends StateNotifier<NoteFormState> {
  final NoteRepository _repository;

  NoteFormNotifier(this._repository) : super(const NoteFormState());

  void initializeForCreate() {
    state = const NoteFormState();
  }

  void initializeForEdit(Note note) {
    state = NoteFormState(
      title: note.title,
      content: note.content,
      pinned: note.pinned,
      note: note,
    );
  }

  void titleChanged(String title) {
    state = state.copyWith(
      title: title,
      errorMessage: null,
    );
  }

  void contentChanged(String content) {
    state = state.copyWith(
      content: content,
      errorMessage: null,
    );
  }

  void pinnedChanged(bool pinned) {
    state = state.copyWith(pinned: pinned);
  }

  Future<bool> saveNote() async {
    if (!state.isValid) {
      state = state.copyWith(showErrorMessages: true);
      return false;
    }

    state = state.copyWith(
      isSubmitting: true,
      showErrorMessages: false,
      errorMessage: null,
    );

    try {
      final now = DateTime.now();
      final noteToSave = state.isEditing
          ? state.note!.copyWith(
              title: state.title.trim(),
              content: state.content.trim(),
              pinned: state.pinned,
              updatedAt: now,
            )
          : Note(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              title: state.title.trim(),
              content: state.content.trim(),
              pinned: state.pinned,
              createdAt: now,
              updatedAt: now,
              syncStatus: SyncStatus.pending,
            );

      await _repository.saveNote(noteToSave);
      
      state = state.copyWith(isSubmitting: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  Future<void> deleteNote() async {
    if (state.note == null) return;

    state = state.copyWith(isSubmitting: true);
    
    try {
      await _repository.deleteNote(state.note!.id);
      state = state.copyWith(isSubmitting: false);
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: e.toString(),
      );
    }
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}
