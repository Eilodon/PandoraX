import 'dart:async';
import 'package:isar/isar.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:cac_core/cac_core.dart';

part 'isar_memory_datasource.g.dart';

@collection
class IsarMemoryEntry {
  Id id = Isar.autoIncrement;
  late String memoryId;
  late DateTime timestamp;
  late String source;
  late String content;
  List<double>? embedding;
  late List<String> causalLinks;
  late String type;
  @ignore
  late Map<String, dynamic> metadata;
  late double relevanceScore;
  late bool isPinned;
  late bool isArchived;

  IsarMemoryEntry();

  factory IsarMemoryEntry.fromMemoryEntry(MemoryEntry memory) {
    final isarMemory = IsarMemoryEntry();
    isarMemory.memoryId = memory.id;
    isarMemory.timestamp = memory.timestamp;
    isarMemory.source = memory.source;
    isarMemory.content = memory.content;
    isarMemory.embedding = memory.embedding;
    isarMemory.causalLinks = memory.causalLinks;
    isarMemory.type = memory.type.name;
    isarMemory.metadata = memory.metadata;
    isarMemory.relevanceScore = memory.relevanceScore;
    isarMemory.isPinned = memory.isPinned;
    isarMemory.isArchived = memory.isArchived;
    return isarMemory;
  }

  MemoryEntry toMemoryEntry() {
    return MemoryEntry(
      id: memoryId,
      timestamp: timestamp,
      source: source,
      content: content,
      embedding: embedding,
      causalLinks: causalLinks,
      type: MemoryType.values.firstWhere((t) => t.name == type),
      metadata: metadata,
      relevanceScore: relevanceScore,
      isPinned: isPinned,
      isArchived: isArchived,
    );
  }
}

@LazySingleton()
class IsarMemoryDatasource {
  late Isar _isar;
  final Logger _logger = Logger();

  Future<void> initialize() async {
    _isar = await Isar.open([IsarMemoryEntrySchema]);
    _logger.i('Isar database initialized');
  }

  Future<void> saveMemory(IsarMemoryEntry memory) async {
    await _isar.writeTxn(() async {
      await _isar.isarMemoryEntries.put(memory);
    });
    _logger.d('Memory saved: ${memory.memoryId}');
  }

  Future<void> saveMemories(List<IsarMemoryEntry> memories) async {
    await _isar.writeTxn(() async {
      await _isar.isarMemoryEntries.putAll(memories);
    });
    _logger.d('${memories.length} memories saved');
  }

  Future<IsarMemoryEntry?> getMemory(String memoryId) async {
    return await _isar.isarMemoryEntries
        .where()
        .memoryIdEqualTo(memoryId)
        .findFirst();
  }

  Future<List<IsarMemoryEntry>> getMemories({
    int? limit,
    int? offset,
    String? source,
    DateTime? from,
    DateTime? to,
  }) async {
    var query = _isar.isarMemoryEntries.where();

    if (source != null) {
      query = query.sourceEqualTo(source);
    }

    if (from != null) {
      query = query.timestampGreaterThan(from);
    }

    if (to != null) {
      query = query.timestampLessThan(to);
    }

    query = query.sortByTimestampDesc();

    if (offset != null) {
      query = query.offset(offset);
    }

    if (limit != null) {
      query = query.limit(limit);
    }

    return await query.findAll();
  }

  Future<List<IsarMemoryEntry>> searchMemories(String query) async {
    return await _isar.isarMemoryEntries
        .where()
        .contentContains(query, caseSensitive: false)
        .sortByTimestampDesc()
        .findAll();
  }

  Future<List<IsarMemoryEntry>> getMemoriesByType(String type) async {
    return await _isar.isarMemoryEntries
        .where()
        .typeEqualTo(type)
        .sortByTimestampDesc()
        .findAll();
  }

  Future<void> updateMemory(IsarMemoryEntry memory) async {
    await _isar.writeTxn(() async {
      await _isar.isarMemoryEntries.put(memory);
    });
    _logger.d('Memory updated: ${memory.memoryId}');
  }

  Future<void> deleteMemory(String memoryId) async {
    await _isar.writeTxn(() async {
      await _isar.isarMemoryEntries
          .where()
          .memoryIdEqualTo(memoryId)
          .deleteFirst();
    });
    _logger.d('Memory deleted: $memoryId');
  }

  Future<void> clearAllMemories() async {
    await _isar.writeTxn(() async {
      await _isar.isarMemoryEntries.clear();
    });
    _logger.i('All memories cleared');
  }

  Future<void> close() async {
    await _isar.close();
  }
}
