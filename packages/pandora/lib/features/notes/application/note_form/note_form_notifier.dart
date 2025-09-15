import 'package:note_domain/note_domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cac_core/cac_core.dart';
import 'package:common_entities/common_entities.dart';
import 'note_form_state.dart';
import '../note_providers.dart';

class NoteFormNotifier extends StateNotifier<NoteFormState> {
  final NoteRepository _repository;
  final MemoryRepository _memoryRepository;
  final EventBusService _eventBusService;
  final AIServiceInterface _aiService;

  NoteFormNotifier(
    this._repository,
    this._memoryRepository,
    this._eventBusService,
    this._aiService,
  ) : super(const NoteFormState());

  void initializeForCreate() {
    state = const NoteFormState();
  }

  void initializeForEdit(Note note) {
    state = NoteFormState(
      title: note.title,
      content: note.content,
      pinned: note.isPinned,
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
              isPinned: state.pinned,
              updatedAt: now,
            )
          : Note(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              title: state.title.trim(),
              content: state.content.trim(),
              isPinned: state.pinned,
              createdAt: now,
              updatedAt: now,
            );

      await _repository.saveNote(noteToSave);
      
      // Save to CAC memory system
      await _saveToMemorySystem(noteToSave, state.isEditing);
      
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

  /// Save note to CAC memory system
  Future<void> _saveToMemorySystem(Note note, bool isEditing) async {
    try {
      // Create embedding for the note content
      final content = '${note.title}\n${note.content}';
      final embedding = await _aiService.createEmbedding(content);
      
      // Create memory entry
      final memoryEntry = MemoryEntry(
        id: const Uuid().v4(),
        timestamp: note.createdAt,
        source: 'notes',
        content: content,
        embedding: embedding,
        causalLinks: [],
        type: MemoryType.explicit,
        metadata: {
          'noteId': note.id,
          'title': note.title,
          'isPinned': note.isPinned,
          'isEditing': isEditing,
          'contentLength': note.content.length,
        },
        relevanceScore: note.isPinned ? 0.9 : 0.7,
        isPinned: note.isPinned,
      );
      
      // Save memory
      await _memoryRepository.saveMemory(memoryEntry);
      
      // Emit event
      if (isEditing) {
        _eventBusService.publishEvent(
          CacEvent.noteUpdated(
            noteId: note.id,
            oldContent: state.note?.content ?? '',
            newContent: note.content,
            timestamp: DateTime.now(),
          ),
        );
      } else {
        _eventBusService.publishEvent(
          CacEvent.noteCreated(
            noteId: note.id,
            content: note.content,
            timestamp: note.createdAt,
            metadata: {
              'title': note.title,
              'isPinned': note.isPinned,
            },
          ),
        );
      }
      
    } catch (e) {
      // Log error but don't fail the note save
      print('Error saving to memory system: $e');
    }
  }

  Future<void> deleteNote() async {
    if (state.note == null) return;

    state = state.copyWith(isSubmitting: true);
    
    try {
      final noteId = state.note!.id;
      await _repository.deleteNote(noteId);
      
      // Emit delete event
      _eventBusService.publishEvent(
        CacEvent.noteDeleted(
          noteId: noteId,
          content: state.note!.content,
          timestamp: DateTime.now(),
        ),
      );
      
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
