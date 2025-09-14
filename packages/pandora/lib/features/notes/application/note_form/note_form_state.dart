import 'package:note_domain/note_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_form_state.freezed.dart';

@freezed
class NoteFormState with _$NoteFormState {
  const factory NoteFormState({
    @Default('') String title,
    @Default('') String content,
    @Default(false) bool pinned,
    @Default(false) bool isSubmitting,
    @Default(false) bool showErrorMessages,
    Note? note, // For editing existing note
    String? errorMessage,
  }) = _NoteFormState;

  const NoteFormState._();

  bool get isEditing => note != null;
  
  bool get isValid => title.trim().isNotEmpty && content.trim().isNotEmpty;
  
  String? get titleError {
    if (!showErrorMessages) return null;
    if (title.trim().isEmpty) return 'Title cannot be empty';
    if (title.trim().length < 3) return 'Title must be at least 3 characters';
    return null;
  }
  
  String? get contentError {
    if (!showErrorMessages) return null;
    if (content.trim().isEmpty) return 'Content cannot be empty';
    if (content.trim().length < 10) return 'Content must be at least 10 characters';
    return null;
  }
}
