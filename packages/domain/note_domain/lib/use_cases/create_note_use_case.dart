import 'package:common_entities/common_entities.dart';
import '../repositories/note_repository.dart';

/// Use case for creating a new note
class CreateNoteUseCase {
  final NoteRepository _noteRepository;

  const CreateNoteUseCase(this._noteRepository);

  /// Create a new note
  Future<String> call({
    required String title,
    required String content,
    String? category,
    List<String>? tags,
    bool isEncrypted = false,
    bool isPinned = false,
    int priority = 0,
    String? color,
    String? icon,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final now = DateTime.now();
      final note = Note(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        content: content,
        createdAt: now,
        updatedAt: now,
        category: category,
        tags: tags ?? [],
        isEncrypted: isEncrypted,
        isPinned: isPinned,
        priority: priority,
        color: color,
        icon: icon,
        metadata: metadata,
      );

      return await _noteRepository.createNote(note);
    } catch (e) {
      rethrow;
    }
  }

  /// Create a note from template
  Future<String> fromTemplate({
    required String templateId,
    required String title,
    required String content,
    String? category,
    List<String>? tags,
  }) async {
    try {
      // TODO: Implement template-based note creation
      return await call(
        title: title,
        content: content,
        category: category,
        tags: tags ?? [],
      );
    } catch (e) {
      rethrow;
    }
  }
}
