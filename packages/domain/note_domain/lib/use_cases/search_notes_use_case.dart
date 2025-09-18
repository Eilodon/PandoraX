import 'package:common_entities/common_entities.dart';
import '../repositories/note_repository.dart';

/// Use case for searching notes
class SearchNotesUseCase {
  final NoteRepository _noteRepository;

  const SearchNotesUseCase(this._noteRepository);

  /// Search notes by query
  Future<List<Note>> call({
    required String query,
    String? category,
    List<String>? tags,
    bool? isPinned,
    bool? isEncrypted,
    DateTime? startDate,
    DateTime? endDate,
    int? limit,
  }) async {
    try {
      if (query.isEmpty) {
        return await _noteRepository.getAllNotes();
      }

      // Basic search implementation
      final allNotes = await _noteRepository.getAllNotes();
      final filteredNotes = allNotes.where((note) {
        // Text search
        final matchesText = note.title.toLowerCase().contains(query.toLowerCase()) ||
                           note.content.toLowerCase().contains(query.toLowerCase());

        // Category filter
        final matchesCategory = category == null || note.category == category;

        // Tags filter
        final matchesTags = tags == null ||
                           tags.isEmpty ||
                           (note.tags != null && note.tags!.any((tag) => tags.contains(tag)));

        // Pinned filter
        final matchesPinned = isPinned == null || note.isPinned == isPinned;

        // Encrypted filter
        final matchesEncrypted = isEncrypted == null || note.isEncrypted == isEncrypted;

        // Date range filter
        final matchesDateRange = startDate == null || endDate == null ||
                                (note.createdAt.isAfter(startDate) && note.createdAt.isBefore(endDate));

        return matchesText &&
               matchesCategory &&
               matchesTags &&
               matchesPinned &&
               matchesEncrypted &&
               matchesDateRange;
      }).toList();

      // Sort by updated date (most recent first)
      filteredNotes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

      // Apply limit
      if (limit != null && limit > 0) {
        return filteredNotes.take(limit).toList();
      }

      return filteredNotes;
    } catch (e) {
      rethrow;
    }
  }

  /// Search notes by category
  Future<List<Note>> byCategory(String category) async {
    try {
      return await _noteRepository.getNotesByCategory(category);
    } catch (e) {
      rethrow;
    }
  }

  /// Search notes by tag
  Future<List<Note>> byTag(String tag) async {
    try {
      return await _noteRepository.getNotesByTag(tag);
    } catch (e) {
      rethrow;
    }
  }

  /// Get recent notes
  Future<List<Note>> recent({int limit = 10}) async {
    try {
      return await _noteRepository.getRecentNotes(limit: limit);
    } catch (e) {
      rethrow;
    }
  }

  /// Get pinned notes
  Future<List<Note>> pinned() async {
    try {
      return await _noteRepository.getPinnedNotes();
    } catch (e) {
      rethrow;
    }
  }
}
