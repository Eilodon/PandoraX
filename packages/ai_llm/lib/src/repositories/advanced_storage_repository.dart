import 'dart:io';
import 'package:ai_core/ai_core.dart';
import 'package:isar/isar.dart';
import '../../schema.dart';
import '../models/model_cache_entry.dart';
import '../models/storage_analytics.dart';

/// Advanced storage repository with analytics and intelligent caching
class AdvancedStorageRepository implements ModelStorageRepository {
  final Isar _isar;
  final String _cacheDir;
  final int _maxBytes;
  final Map<String, StorageSnapshot> _dailySnapshots = {};

  AdvancedStorageRepository({
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
      
      // Update access statistics
      await _updateAccessStats(entry);
      
      return ModelSession(
        key: entry.key,
        filePath: entry.filePath,
        level: level,
        pinned: entry.pinned,
        lastAccess: DateTime.fromMillisecondsSinceEpoch(entry.lastAccess),
        version: entry.version,
        metadata: entry.metadata,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<ModelSession> downloadModel(ModelLevel level) async {
    // This is a placeholder - in real implementation, this would
    // coordinate with ModelDownloadManager
    final filePath = '$_cacheDir/${level.key}.bin';
    final file = File(filePath);
    
    // Create a dummy file for now
    await file.create(recursive: true);
    await file.writeAsString('Dummy model data for ${level.modelId}');
    
    // Create cache entry with analytics
    final entry = ModelCacheEntry.create(
      key: level.key,
      filePath: filePath,
      size: await file.length(),
      lastAccess: DateTime.now().millisecondsSinceEpoch,
      version: level.version,
      modelId: level.modelId,
      modelName: level.name,
      compressionType: 'none',
      checksum: 'dummy_checksum',
      downloadTime: DateTime.now().millisecondsSinceEpoch,
      accessCount: 0,
      downloadSource: 'test',
      metadata: {
        'created_at': DateTime.now().toIso8601String(),
        'model_type': level.name,
      },
    );
    
    await _isar.writeTxn(() => _isar.modelCacheEntrys.put(entry));
    await _recordDailySnapshot();
    
    return ModelSession(
      key: level.key,
      filePath: filePath,
      level: level,
      pinned: false,
      lastAccess: DateTime.now(),
      version: level.version,
      metadata: entry.metadata,
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
            metadata: entry.metadata,
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
    try {
      final entry = await _isar.modelCacheEntrys
          .where()
          .keyEqualTo(key)
          .findFirst();
      
      if (entry == null) {
        return ModelHealth.empty();
      }
      
      // Calculate health based on access patterns
      final accessFrequency = entry.accessFrequency;
      final ageInDays = entry.ageInDays;
      
      // Health score based on usage and recency
      double healthScore = 1.0;
      if (ageInDays > 7) healthScore -= 0.2;
      if (ageInDays > 30) healthScore -= 0.3;
      if (accessFrequency < 0.1) healthScore -= 0.2;
      
      return ModelHealth(
        successRate: healthScore.clamp(0.0, 1.0),
        p50LatencyMs: 100, // Placeholder
        p95LatencyMs: 500, // Placeholder
        totalRequests: entry.accessCount,
        successfulRequests: (entry.accessCount * healthScore).round(),
        failedRequests: (entry.accessCount * (1 - healthScore)).round(),
        lastUpdated: DateTime.fromMillisecondsSinceEpoch(entry.lastAccess),
      );
    } catch (e) {
      return ModelHealth.empty();
    }
  }

  @override
  Future<void> updateModelHealth(String key, ModelHealth health) async {
    // In a real implementation, this would store health data
    // For now, we'll use access patterns as a proxy
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
      final totalSize = await _isar.modelCacheEntrys
          .where()
          .findAll()
          .then((entries) => entries.fold<int>(0, (sum, e) => sum + e.size));
      
      if (totalSize <= _maxBytes) return;
      
      // Get all entries sorted by eviction priority
      final entries = await _isar.modelCacheEntrys
          .where()
          .findAll();
      
      // Sort by eviction priority (lower = more likely to be evicted)
      entries.sort((a, b) => a.evictionPriority.compareTo(b.evictionPriority));
      
      int currentSize = totalSize;
      for (final entry in entries) {
        if (currentSize <= _maxBytes) break;
        if (entry.pinned) continue; // Skip pinned entries
        
        await _evictEntry(entry);
        currentSize -= entry.size;
      }
      
      await _recordDailySnapshot();
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
      await _recordDailySnapshot();
    } catch (e) {
      // Handle error silently
    }
  }

  /// Get comprehensive storage analytics
  Future<StorageAnalytics> getAnalytics() async {
    try {
      final entries = await _isar.modelCacheEntrys.where().findAll();
      final usage = await getStorageUsage();
      
      // Calculate statistics
      final totalModels = entries.length;
      final pinnedModels = entries.where((e) => e.pinned).length;
      final expiredModels = entries.where((e) => e.isExpired).length;
      
      // Group by type and compression
      final modelsByType = <String, int>{};
      final modelsByCompression = <String, int>{};
      
      for (final entry in entries) {
        modelsByType[entry.modelName] = (modelsByType[entry.modelName] ?? 0) + 1;
        modelsByCompression[entry.compressionType] = (modelsByCompression[entry.compressionType] ?? 0) + 1;
      }
      
      // Get top used models
      final topUsedModels = entries
          .map((e) => ModelUsage(
                modelId: e.modelId,
                modelName: e.modelName,
                accessCount: e.accessCount,
                lastAccess: e.lastAccess,
                sizeBytes: e.size,
                isPinned: e.pinned,
              ))
          .toList()
        ..sort((a, b) => b.accessCount.compareTo(a.accessCount));
      
      // Get recently accessed models
      final recentlyAccessed = entries
          .map((e) => ModelUsage(
                modelId: e.modelId,
                modelName: e.modelName,
                accessCount: e.accessCount,
                lastAccess: e.lastAccess,
                sizeBytes: e.size,
                isPinned: e.pinned,
              ))
          .toList()
        ..sort((a, b) => b.lastAccess.compareTo(a.lastAccess));
      
      // Calculate trends
      final trends = await _calculateTrends();
      
      return StorageAnalytics(
        totalModels: totalModels,
        pinnedModels: pinnedModels,
        expiredModels: expiredModels,
        totalSizeBytes: usage.totalBytes,
        usedSizeBytes: usage.usedBytes,
        availableSizeBytes: usage.availableBytes,
        usagePercentage: usage.usagePercentage,
        modelsByType: modelsByType,
        modelsByCompression: modelsByCompression,
        topUsedModels: topUsedModels.take(10).toList(),
        recentlyAccessed: recentlyAccessed.take(10).toList(),
        trends: trends,
        lastUpdated: DateTime.now(),
      );
    } catch (e) {
      return StorageAnalytics(
        totalModels: 0,
        pinnedModels: 0,
        expiredModels: 0,
        totalSizeBytes: _maxBytes,
        usedSizeBytes: 0,
        availableSizeBytes: _maxBytes,
        usagePercentage: 0.0,
        modelsByType: {},
        modelsByCompression: {},
        topUsedModels: [],
        recentlyAccessed: [],
        trends: StorageTrends(
          sizeGrowthRate: 0.0,
          accessGrowthRate: 0.0,
          dailySnapshots: [],
          trendDirection: 'stable',
        ),
        lastUpdated: DateTime.now(),
      );
    }
  }

  /// Clean up expired models
  Future<int> cleanupExpiredModels() async {
    try {
      final expiredEntries = await _isar.modelCacheEntrys
          .where()
          .findAll()
          .then((entries) => entries.where((e) => e.isExpired).toList());
      
      int cleanedCount = 0;
      for (final entry in expiredEntries) {
        await _evictEntry(entry);
        cleanedCount++;
      }
      
      await _recordDailySnapshot();
      return cleanedCount;
    } catch (e) {
      return 0;
    }
  }

  /// Get storage recommendations
  Future<StorageRecommendations> getRecommendations() async {
    final analytics = await getAnalytics();
    final recommendations = <String>[];
    
    if (analytics.usagePercentage > 0.9) {
      recommendations.add('Storage is nearly full. Consider cleaning up unused models.');
    }
    
    if (analytics.expiredModels > 0) {
      recommendations.add('${analytics.expiredModels} expired models can be removed.');
    }
    
    if (analytics.pinnedModels > analytics.totalModels * 0.5) {
      recommendations.add('Many models are pinned. Consider unpinning unused ones.');
    }
    
    if (analytics.trends.isGrowing) {
      recommendations.add('Storage usage is growing rapidly. Monitor space usage.');
    }
    
    return StorageRecommendations(
      recommendations: recommendations,
      priority: analytics.needsCleanup ? 'high' : 'medium',
      estimatedSpaceSavings: analytics.expiredModels * 100, // Placeholder
    );
  }

  Future<void> _updateAccessStats(ModelCacheEntry entry) async {
    entry.accessCount++;
    entry.lastAccess = DateTime.now().millisecondsSinceEpoch;
    await _isar.writeTxn(() => _isar.modelCacheEntrys.put(entry));
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

  Future<void> _recordDailySnapshot() async {
    try {
      final usage = await getStorageUsage();
      final entries = await _isar.modelCacheEntrys.where().findAll();
      final accessCount = entries.fold<int>(0, (sum, e) => sum + e.accessCount);
      
      final snapshot = StorageSnapshot(
        timestamp: DateTime.now(),
        totalSizeBytes: usage.totalBytes,
        usedSizeBytes: usage.usedBytes,
        modelCount: entries.length,
        accessCount: accessCount,
      );
      
      final today = DateTime.now().toIso8601String().split('T')[0];
      _dailySnapshots[today] = snapshot;
      
      // Keep only last 30 days
      if (_dailySnapshots.length > 30) {
        final sortedKeys = _dailySnapshots.keys.toList()..sort();
        for (int i = 0; i < _dailySnapshots.length - 30; i++) {
          _dailySnapshots.remove(sortedKeys[i]);
        }
      }
    } catch (e) {
      // Handle error silently
    }
  }

  Future<StorageTrends> _calculateTrends() async {
    final snapshots = _dailySnapshots.values.toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
    
    if (snapshots.length < 2) {
      return StorageTrends(
        sizeGrowthRate: 0.0,
        accessGrowthRate: 0.0,
        dailySnapshots: snapshots,
        trendDirection: 'stable',
      );
    }
    
    // Calculate growth rates
    final firstSnapshot = snapshots.first;
    final lastSnapshot = snapshots.last;
    final daysDiff = lastSnapshot.timestamp.difference(firstSnapshot.timestamp).inDays;
    
    if (daysDiff == 0) {
      return StorageTrends(
        sizeGrowthRate: 0.0,
        accessGrowthRate: 0.0,
        dailySnapshots: snapshots,
        trendDirection: 'stable',
      );
    }
    
    final sizeGrowthRate = (lastSnapshot.usedSizeBytes - firstSnapshot.usedSizeBytes) / 
                          (1024 * 1024 * daysDiff); // MB per day
    final accessGrowthRate = (lastSnapshot.accessCount - firstSnapshot.accessCount) / daysDiff;
    
    String trendDirection = 'stable';
    if (sizeGrowthRate > 1.0) trendDirection = 'increasing';
    else if (sizeGrowthRate < -1.0) trendDirection = 'decreasing';
    
    return StorageTrends(
      sizeGrowthRate: sizeGrowthRate,
      accessGrowthRate: accessGrowthRate,
      dailySnapshots: snapshots,
      trendDirection: trendDirection,
    );
  }
}

class StorageRecommendations {
  final List<String> recommendations;
  final String priority; // 'low', 'medium', 'high'
  final int estimatedSpaceSavings; // in MB

  const StorageRecommendations({
    required this.recommendations,
    required this.priority,
    required this.estimatedSpaceSavings,
  });
}
