import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_statistics.freezed.dart';
part 'note_statistics.g.dart';

/// Note statistics entity
@freezed
class NoteStatistics with _$NoteStatistics {
  const factory NoteStatistics({
    required int totalNotes,
    required int pinnedNotes,
    required int archivedNotes,
    required int totalWords,
    required int totalCharacters,
    required Map<String, int> categoryCounts,
    required Map<String, int> tagCounts,
    required DateTime lastUpdated,
  }) = _NoteStatistics;

  factory NoteStatistics.fromJson(Map<String, dynamic> json) =>
      _$NoteStatisticsFromJson(json);
}
