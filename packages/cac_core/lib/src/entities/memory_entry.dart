import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:common_entities/common_entities.dart';
import 'memory_type.dart';

part 'memory_entry.freezed.dart';
part 'memory_entry.g.dart';

@freezed
class MemoryEntry with _$MemoryEntry {
  const factory MemoryEntry({
    required String id,
    required DateTime timestamp,
    required String source,
    required String content,
    List<double>? embedding,
    required List<String> causalLinks,
    @Default(MemoryType.explicit) MemoryType type,
    @Default({}) Map<String, dynamic> metadata,
    @Default(0.0) double relevanceScore,
    @Default(false) bool isPinned,
    @Default(false) bool isArchived,
  }) = _MemoryEntry;

  factory MemoryEntry.fromJson(Map<String, dynamic> json) => _$MemoryEntryFromJson(json);
}
