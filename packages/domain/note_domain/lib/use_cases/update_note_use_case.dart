import 'package:common_entities/common_entities.dart';
import '../repositories/note_repository.dart';

/// Use case for updating notes
class UpdateNoteUseCase {
  final NoteRepository _noteRepository;

  const UpdateNoteUseCase(this._noteRepository);

  /// Update an existing note
  Future<void> call({
    required String noteId,
    String? title,
    String? content,
    String? category,
    List<String>? tags,
    bool? isPinned,
    int? priority,
    String? color,
    String? icon,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      // Get existing note
      final existingNote = await _noteRepository.getNoteById(noteId);
      if (existingNote == null) {
        throw Exception('Note not found');
      }

      // Create updated note
      final updatedNote = existingNote.copyWith(
        title: title ?? existingNote.title,
        content: content ?? existingNote.content,
        category: category ?? existingNote.category,
        tags: tags ?? existingNote.tags,
        isPinned: isPinned ?? existingNote.isPinned,
        priority: priority ?? existingNote.priority,
        color: color ?? existingNote.color,
        icon: icon ?? existingNote.icon,
        metadata: metadata ?? existingNote.metadata,
        updatedAt: DateTime.now(),
      );

      await _noteRepository.updateNote(updatedNote);
    } catch (e) {
      rethrow;
    }
  }

  /// Update note title
  Future<void> updateTitle(String noteId, String title) async {
    await call(noteId: noteId, title: title);
  }

  /// Update note content
  Future<void> updateContent(String noteId, String content) async {
    await call(noteId: noteId, content: content);
  }

  /// Update note category
  Future<void> updateCategory(String noteId, String category) async {
    await call(noteId: noteId, category: category);
  }

  /// Update note tags
  Future<void> updateTags(String noteId, List<String> tags) async {
    await call(noteId: noteId, tags: tags);
  }

  /// Toggle pin status
  Future<void> togglePin(String noteId) async {
    try {
      await _noteRepository.togglePin(noteId);
    } catch (e) {
      rethrow;
    }
  }

  /// Toggle archive status
  Future<void> toggleArchive(String noteId) async {
    try {
      await _noteRepository.toggleArchive(noteId);
    } catch (e) {
      rethrow;
    }
  }
}
