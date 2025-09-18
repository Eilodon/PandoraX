import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:cac_core/cac_core.dart';
import '../datasources/isar_memory_datasource.dart';
import '../services/isar_write_queue_service.dart';

@LazySingleton(as: MemoryRepository)
class MemoryRepositoryImpl implements MemoryRepository {
  final IsarMemoryDatasource _datasource;
  final IsarWriteQueueService _writeQueue;
  final Logger _logger = Logger();
  final StreamController<MemoryEntry> _memoryStreamController = StreamController<MemoryEntry>.broadcast();

  MemoryRepositoryImpl(this._datasource, this._writeQueue);

  @override
  Future<void> saveMemory(MemoryEntry memory) async {
    final isarMemory = IsarMemoryEntry.fromMemoryEntry(memory);
    await _writeQueue.add(() => _datasource.saveMemory(isarMemory));
    _memoryStreamController.add(memory);
    _logger.d('Memory queued for save: ${memory.id}');
  }

  @override
  Future<void> saveMemories(List<MemoryEntry> memories) async {
    final isarMemories = memories.map((m) => IsarMemoryEntry.fromMemoryEntry(m)).toList();
    await _writeQueue.add(() => _datasource.saveMemories(isarMemories));
    
    for (final memory in memories) {
      _memoryStreamController.add(memory);
    }
    
    _logger.d('${memories.length} memories queued for save');
  }

  @override
  Future<MemoryEntry?> getMemory(String id) async {
    final isarMemory = await _datasource.getMemory(id);
    return isarMemory?.toMemoryEntry();
  }

  @override
  Future<List<MemoryEntry>> getMemories({
    int? limit,
    int? offset,
    String? source,
    DateTime? from,
    DateTime? to,
  }) async {
    final isarMemories = await _datasource.getMemories(
      limit: limit,
      offset: offset,
      source: source,
      from: from,
      to: to,
    );
    
    return isarMemories.map((m) => m.toMemoryEntry()).toList();
  }

  @override
  Future<List<MemoryEntry>> searchMemories(String query) async {
    final isarMemories = await _datasource.searchMemories(query);
    return isarMemories.map((m) => m.toMemoryEntry()).toList();
  }

  @override
  Future<List<MemoryEntry>> getMemoriesByType(String type) async {
    final isarMemories = await _datasource.getMemoriesByType(type);
    return isarMemories.map((m) => m.toMemoryEntry()).toList();
  }

  @override
  Future<void> updateMemory(MemoryEntry memory) async {
    final isarMemory = IsarMemoryEntry.fromMemoryEntry(memory);
    await _writeQueue.add(() => _datasource.updateMemory(isarMemory));
    _memoryStreamController.add(memory);
    _logger.d('Memory queued for update: ${memory.id}');
  }

  @override
  Future<void> deleteMemory(String id) async {
    await _writeQueue.add(() => _datasource.deleteMemory(id));
    _logger.d('Memory queued for deletion: $id');
  }

  @override
  Future<void> linkMemories(String fromId, String toId, double strength) async {
    // This would need to be implemented in the datasource
    // For now, we'll just log it
    _logger.d('Linking memories: $fromId -> $toId (strength: $strength)');
  }

  @override
  Future<List<MemoryEntry>> getLinkedMemories(String memoryId) async {
    // This would need to be implemented in the datasource
    // For now, return empty list
    return [];
  }

  @override
  Stream<MemoryEntry> getMemoryStream() {
    return _memoryStreamController.stream;
  }

  @override
  Future<void> clearAllMemories() async {
    await _writeQueue.add(() => _datasource.clearAllMemories());
    _logger.i('All memories queued for deletion');
  }

  void dispose() {
    _memoryStreamController.close();
  }
}
