class StorageAnalytics {
  final int totalModels;
  final int pinnedModels;
  final int expiredModels;
  final int totalSizeBytes;
  final int usedSizeBytes;
  final int availableSizeBytes;
  final double usagePercentage;
  final Map<String, int> modelsByType;
  final Map<String, int> modelsByCompression;
  final List<ModelUsage> topUsedModels;
  final List<ModelUsage> recentlyAccessed;
  final StorageTrends trends;
  final DateTime lastUpdated;

  const StorageAnalytics({
    required this.totalModels,
    required this.pinnedModels,
    required this.expiredModels,
    required this.totalSizeBytes,
    required this.usedSizeBytes,
    required this.availableSizeBytes,
    required this.usagePercentage,
    required this.modelsByType,
    required this.modelsByCompression,
    required this.topUsedModels,
    required this.recentlyAccessed,
    required this.trends,
    required this.lastUpdated,
  });

  String get usageDisplay {
    final usedMB = usedSizeBytes / (1024 * 1024);
    final totalMB = totalSizeBytes / (1024 * 1024);
    return '${usedMB.toStringAsFixed(1)} MB / ${totalMB.toStringAsFixed(1)} MB';
  }

  String get usageStatus {
    if (usagePercentage < 0.5) return 'Low';
    if (usagePercentage < 0.8) return 'Medium';
    if (usagePercentage < 0.95) return 'High';
    return 'Critical';
  }

  bool get needsCleanup => usagePercentage > 0.9 || expiredModels > 0;
}

class ModelUsage {
  final String modelId;
  final String modelName;
  final int accessCount;
  final int lastAccess;
  final int sizeBytes;
  final bool isPinned;

  const ModelUsage({
    required this.modelId,
    required this.modelName,
    required this.accessCount,
    required this.lastAccess,
    required this.sizeBytes,
    required this.isPinned,
  });

  String get sizeDisplay {
    final sizeMB = sizeBytes / (1024 * 1024);
    return '${sizeMB.toStringAsFixed(1)} MB';
  }

  String get lastAccessDisplay {
    final now = DateTime.now().millisecondsSinceEpoch;
    final daysAgo = (now - lastAccess) ~/ (1000 * 60 * 60 * 24);
    
    if (daysAgo == 0) return 'Today';
    if (daysAgo == 1) return 'Yesterday';
    if (daysAgo < 7) return '$daysAgo days ago';
    if (daysAgo < 30) return '${(daysAgo / 7).floor()} weeks ago';
    return '${(daysAgo / 30).floor()} months ago';
  }
}

class StorageTrends {
  final double sizeGrowthRate; // MB per day
  final double accessGrowthRate; // accesses per day
  final List<StorageSnapshot> dailySnapshots;
  final String trendDirection; // 'increasing', 'decreasing', 'stable'

  const StorageTrends({
    required this.sizeGrowthRate,
    required this.accessGrowthRate,
    required this.dailySnapshots,
    required this.trendDirection,
  });

  bool get isGrowing => sizeGrowthRate > 0.1;
  bool get isStable => sizeGrowthRate.abs() < 0.1;
  bool get isShrinking => sizeGrowthRate < -0.1;
}

class StorageSnapshot {
  final DateTime timestamp;
  final int totalSizeBytes;
  final int usedSizeBytes;
  final int modelCount;
  final int accessCount;

  const StorageSnapshot({
    required this.timestamp,
    required this.totalSizeBytes,
    required this.usedSizeBytes,
    required this.modelCount,
    required this.accessCount,
  });

  double get usagePercentage => usedSizeBytes / totalSizeBytes;
}