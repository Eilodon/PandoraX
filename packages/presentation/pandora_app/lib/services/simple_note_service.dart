import 'package:common_entities/common_entities.dart';
// import 'package:note_domain/note_domain.dart'; // Temporarily disabled
import 'package:core_utils/core_utils.dart';

/// Simple note service for development
class SimpleNoteService {
  final List<Note> _notes = [];
  int _nextId = 1;

  // @override
  Future<List<Note>> getAllNotes() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_notes);
  }

  // @override
  Future<Note?> getNoteById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _notes.firstWhere((note) => note.id == id);
    } catch (e) {
      return null;
    }
  }

  // @override
  Future<String> createNote(Note note) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final newNote = note.copyWith(
      id: _nextId.toString(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    _nextId++;
    _notes.add(newNote);
    return newNote.id;
  }

  // @override
  Future<void> updateNote(Note note) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _notes.indexWhere((n) => n.id == note.id);
    if (index != -1) {
      _notes[index] = note.copyWith(updatedAt: DateTime.now());
    }
  }

  // @override
  Future<void> deleteNote(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _notes.removeWhere((note) => note.id == id);
  }

  // @override
  Future<List<Note>> searchNotes(String query) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _notes.where((note) => 
      note.title.toLowerCase().contains(query.toLowerCase()) ||
      note.content.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  // @override
  Future<List<Note>> getNotesByCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _notes.where((note) => note.category == category).toList();
  }

  // @override
  Future<List<Note>> getNotesByTag(String tag) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _notes.where((note) => note.tags.contains(tag)).toList();
  }

  // @override
  Future<List<Note>> getPinnedNotes() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _notes.where((note) => note.isPinned).toList();
  }

  // @override
  Future<List<Note>> getRecentNotes({int? limit}) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final sortedNotes = List<Note>.from(_notes);
    sortedNotes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return limit != null ? sortedNotes.take(limit).toList() : sortedNotes;
  }

  // @override
  Future<List<Note>> getNotesByDateRange(DateTime start, DateTime end) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _notes.where((note) => 
      note.createdAt.isAfter(start) && note.createdAt.isBefore(end)
    ).toList();
  }

  // @override
  Future<List<String>> getAllCategories() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _notes
        .map((note) => note.category)
        .where((category) => category != null)
        .cast<String>()
        .toSet()
        .toList();
  }

  // @override
  Future<List<String>> getAllTags() async {
    await Future.delayed(const Duration(milliseconds: 200));
    final tags = <String>{};
    for (final note in _notes) {
      tags.addAll(note.tags);
    }
    return tags.toList();
  }

  // @override
  Future<void> togglePin(String noteId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _notes.indexWhere((note) => note.id == noteId);
    if (index != -1) {
      _notes[index] = _notes[index].copyWith(isPinned: !_notes[index].isPinned);
    }
  }

  // @override
  Future<void> toggleArchive(String noteId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _notes.indexWhere((note) => note.id == noteId);
    if (index != -1) {
      _notes[index] = _notes[index].copyWith(isArchived: !_notes[index].isArchived);
    }
  }

  // @override
  Future<String> exportNotes(List<String> noteIds, String format) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return 'Mock export data';
  }

  // @override
  Future<List<String>> importNotes(String data, String format) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ['mock_id_1', 'mock_id_2'];
  }

  // @override
  Future<Map<String, dynamic>> getStatistics() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      'totalNotes': _notes.length,
      'pinnedNotes': _notes.where((n) => n.isPinned).length,
      'archivedNotes': _notes.where((n) => n.isArchived).length,
      'totalWords': _notes.fold(0, (sum, note) => sum + (note.content.split(' ').length)),
      'totalCharacters': _notes.fold(0, (sum, note) => sum + note.content.length),
      'categoryCounts': <String, int>{},
      'tagCounts': <String, int>{},
      'lastUpdated': DateTime.now(),
    };
  }

  // @override
  Future<void> syncNotes() async {
    await Future.delayed(const Duration(milliseconds: 1000));
  }

  // @override
  Future<bool> isSynced() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return true;
  }
}
