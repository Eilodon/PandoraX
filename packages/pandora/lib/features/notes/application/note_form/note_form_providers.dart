import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_domain/note_domain.dart' hide noteRepositoryProvider;
import 'note_form_notifier.dart';
import 'note_form_state.dart';
import '../note_providers.dart';

final noteFormProvider = StateNotifierProvider<NoteFormNotifier, NoteFormState>((ref) {
  return NoteFormNotifier(
    ref.watch(noteRepositoryProvider),
    ref.watch(memoryRepositoryProvider),
    ref.watch(eventBusServiceProvider),
    ref.watch(pandoraAiServiceProvider),
  );
});

// Provider để tạo note mới
final createNoteProvider = Provider<void Function()>((ref) {
  return () {
    ref.read(noteFormProvider.notifier).initializeForCreate();
  };
});

// Provider để edit note
final editNoteProvider = Provider<void Function(Note)>((ref) {
  return (note) {
    ref.read(noteFormProvider.notifier).initializeForEdit(note);
  };
});
