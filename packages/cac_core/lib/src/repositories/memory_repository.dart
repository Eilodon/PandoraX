import 'dart:async';
import '../entities/memory_entry.dart';

abstract class MemoryRepository {
  Future<void> saveMemory(MemoryEntry memory);
  Future<void> saveMemories(List<MemoryEntry> memories);
  Future<MemoryEntry?> getMemory(String id);
  Future<List<MemoryEntry>> getMemories({
    int? limit,
    int? offset,
    String? source,
    DateTime? from,
    DateTime? to,
  });
  Future<List<MemoryEntry>> searchMemories(String query);
  Future<List<MemoryEntry>> getMemoriesByType(String type);
  Future<void> updateMemory(MemoryEntry memory);
  Future<void> deleteMemory(String id);
  Future<void> linkMemories(String fromId, String toId, double strength);
  Future<List<MemoryEntry>> getLinkedMemories(String memoryId);
  Stream<MemoryEntry> getMemoryStream();
  Future<void> clearAllMemories();
}
