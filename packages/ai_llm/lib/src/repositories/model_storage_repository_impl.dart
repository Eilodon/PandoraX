import 'dart:io';
import 'package:ai_core/ai_core.dart';
import 'package:isar/isar.dart';
import '../../schema.dart';
import '../models/model_cache_entry.dart';
import '../models/health_sample.dart';

/// Implementation of model storage repository using Isar
class ModelStorageRepositoryImpl implements ModelStorageRepository {
  final Isar _isar;
  final String _cacheDir;
  final int _maxBytes;
  final Map<String, HealthSample> _healthSamples = {};

  ModelStorageRepositoryImpl({
    required Isar isar,
    required String cacheDir,
    required int maxBytes,
  }) : _isar = isar,
       _cacheDir = cacheDir,
       _maxBytes = maxBytes;

  @override
  Future<ModelSession?> getModel(ModelLevel level) async {
    try {
      final entry = await _isar.modelCacheEntrys
          .where()
          .keyEqualTo(level.key)
          .findFirst();
      
      if (entry == null) return null;
      
      final file = File(entry.filePath);
      if (!await file.exists()) {
        await _evictEntry(entry);
        return null;
      }
      
      // Update last access
      entry.lastAccess = DateTime.now().millisecondsSinceEpoch;
      await _isar.writeTxn(() => _isar.modelCacheEntrys.put(entry));
      
      return ModelSession(
        key: entry.key,
        filePath: entry.filePath,
        level: level,
        pinned: entry.pinned,
        lastAccess: DateTime.fromMillisecondsSinceEpoch(entry.lastAccess),
        version: entry.version,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<ModelSession> downloadModel(ModelLevel level) async {
    // This is a placeholder implementation
    // In a real implementation, this would:
    // 1. Check available sources
    // 2. Download the model file
    // 3. Verify checksum
    // 4. Store in cache
    
    final filePath = '$_cacheDir/${level.key}.bin';
    final file = File(filePath);
    
    // Create a dummy file for now
    await file.create(recursive: true);
    await file.writeAsString('Dummy model data for ${level.modelId}');
    
    // Create cache entry
    final entry = ModelCacheEntry.create(
      key: level.key,
      filePath: filePath,
      size: await file.length(),
      lastAccess: DateTime.now().millisecondsSinceEpoch,
      version: level.version,
      modelId: level.modelId,
      modelName: level.name,
    );
    
    await _isar.writeTxn(() => _isar.modelCacheEntrys.put(entry));
    
    return ModelSession(
      key: level.key,
      filePath: filePath,
      level: level,
      pinned: false,
      lastAccess: DateTime.now(),
      version: level.version,
    );
  }

  @override
  Future<void> pinModel(String key) async {
    try {
      final entry = await _isar.modelCacheEntrys
          .where()
          .keyEqualTo(key)
          .findFirst();
      
      if (entry != null) {
        entry.pinned = true;
        entry.lastAccess = DateTime.now().millisecondsSinceEpoch;
        await _isar.writeTxn(() => _isar.modelCacheEntrys.put(entry));
      }
    } catch (e) {
      // Handle error silently
    }
  }

  @override
  Future<void> unpinModel(String key) async {
    try {
      final entry = await _isar.modelCacheEntrys
          .where()
          .keyEqualTo(key)
          .findFirst();
      
      if (entry != null) {
        entry.pinned = false;
        entry.lastAccess = DateTime.now().millisecondsSinceEpoch;
        await _isar.writeTxn(() => _isar.modelCacheEntrys.put(entry));
        await evictIfNeeded();
      }
    } catch (e) {
      // Handle error silently
    }
  }

  @override
  Future<void> evictModel(String key) async {
    try {
      final entry = await _isar.modelCacheEntrys
          .where()
          .keyEqualTo(key)
          .findFirst();
      
      if (entry != null) {
        await _evictEntry(entry);
      }
    } catch (e) {
      // Handle error silently
    }
  }

  @override
  Future<List<ModelSession>> getAvailableModels() async {
    try {
      final entries = await _isar.modelCacheEntrys.where().findAll();
      final sessions = <ModelSession>[];
      
      for (final entry in entries) {
        final file = File(entry.filePath);
        if (await file.exists()) {
          // Find corresponding ModelLevel
          final level = ModelLevel.all.firstWhere(
            (l) => l.key == entry.key,
            orElse: () => ModelLevel.tiny, // Fallback
          );
          
          sessions.add(ModelSession(
            key: entry.key,
            filePath: entry.filePath,
            level: level,
            pinned: entry.pinned,
            lastAccess: DateTime.fromMillisecondsSinceEpoch(entry.lastAccess),
            version: entry.version,
          ));
        }
      }
      
      return sessions;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<ModelHealth> getModelHealth(String key) async {
    final samples = _healthSamples[key] ?? HealthSample.success(0);
    
    return ModelHealth(
      successRate: samples.success ? 1.0 : 0.0,
      p50LatencyMs: samples.latencyMs,
      p95LatencyMs: samples.latencyMs,
      totalRequests: 1,
      successfulRequests: samples.success ? 1 : 0,
      failedRequests: samples.success ? 0 : 1,
      lastUpdated: samples.timestamp,
    );
  }

  @override
  Future<void> updateModelHealth(String key, ModelHealth health) async {
    // This is a simplified implementation
    // In a real implementation, this would store health data in Isar
  }

  @override
  Future<bool> isModelAvailable(ModelLevel level) async {
    final session = await getModel(level);
    return session != null;
  }

  @override
  Future<StorageUsage> getStorageUsage() async {
    try {
      final entries = await _isar.modelCacheEntrys.where().findAll();
      final totalSize = entries.fold<int>(0, (sum, entry) => sum + entry.size);
      
      return StorageUsage(
        totalBytes: _maxBytes,
        usedBytes: totalSize,
        availableBytes: _maxBytes - totalSize,
        modelCount: entries.length,
      );
    } catch (e) {
      return StorageUsage(
        totalBytes: _maxBytes,
        usedBytes: 0,
        availableBytes: _maxBytes,
        modelCount: 0,
      );
    }
  }

  @override
  Future<void> evictIfNeeded() async {
    try {
      final entries = await _isar.modelCacheEntrys.where().findAll();
      int totalSize = entries.fold<int>(0, (sum, e) => sum + e.size);

      if (totalSize <= _maxBytes) return;

        final allEntries = await _isar.modelCacheEntrys.where().findAll();
        final victims = allEntries
          .where((entry) => !entry.pinned)
          .toList()
          ..sort((a, b) => a.lastAccess.compareTo(b.lastAccess));

      for (final victim in victims) {
        if (totalSize <= _maxBytes) break;
        await _evictEntry(victim);
        totalSize -= victim.size;
      }
    } catch (e) {
      // Handle error silently
    }
  }

  @override
  Future<void> clearAll() async {
    try {
      final entries = await _isar.modelCacheEntrys.where().findAll();
      for (final entry in entries) {
        await _evictEntry(entry);
      }
    } catch (e) {
      // Handle error silently
    }
  }

  Future<void> _evictEntry(ModelCacheEntry entry) async {
    try {
      final file = File(entry.filePath);
      if (await file.exists()) {
        await file.delete();
      }
      await _isar.writeTxn(() => _isar.modelCacheEntrys.delete(entry.id));
    } catch (e) {
      // Handle error silently
    }
  }
}
