import 'package:flutter_test/flutter_test.dart';
import 'package:ai_llm/ai_llm.dart';

void main() {
  group('StorageAnalytics', () {
    test('should create analytics with correct properties', () {
      final analytics = StorageAnalytics(
        totalModels: 10,
        pinnedModels: 3,
        expiredModels: 2,
        totalSizeBytes: 1000 * 1024 * 1024, // 1GB
        usedSizeBytes: 500 * 1024 * 1024, // 500MB
        availableSizeBytes: 500 * 1024 * 1024, // 500MB
        usagePercentage: 0.5,
        modelsByType: {'tiny': 5, 'mini': 3, 'full': 2},
        modelsByCompression: {'gzip': 8, 'none': 2},
        topUsedModels: [],
        recentlyAccessed: [],
        trends: StorageTrends(
          sizeGrowthRate: 10.0,
          accessGrowthRate: 5.0,
          dailySnapshots: [],
          trendDirection: 'increasing',
        ),
        lastUpdated: DateTime.now(),
      );

      expect(analytics.totalModels, 10);
      expect(analytics.pinnedModels, 3);
      expect(analytics.expiredModels, 2);
      expect(analytics.usagePercentage, 0.5);
      expect(analytics.usageDisplay, '500.0 MB / 1000.0 MB');
      expect(analytics.usageStatus, 'Medium');
      expect(analytics.needsCleanup, true); // true because expiredModels = 2 > 0
    });

    test('should identify high usage status', () {
      final analytics = StorageAnalytics(
        totalModels: 10,
        pinnedModels: 3,
        expiredModels: 2,
        totalSizeBytes: 1000 * 1024 * 1024,
        usedSizeBytes: 900 * 1024 * 1024, // 90% usage
        availableSizeBytes: 100 * 1024 * 1024,
        usagePercentage: 0.9,
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

      expect(analytics.usageStatus, 'High');
      expect(analytics.needsCleanup, true);
    });

    test('should identify critical usage status', () {
      final analytics = StorageAnalytics(
        totalModels: 10,
        pinnedModels: 3,
        expiredModels: 2,
        totalSizeBytes: 1000 * 1024 * 1024,
        usedSizeBytes: 960 * 1024 * 1024, // 96% usage
        availableSizeBytes: 40 * 1024 * 1024,
        usagePercentage: 0.96,
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

      expect(analytics.usageStatus, 'Critical');
      expect(analytics.needsCleanup, true);
    });
  });

  group('ModelUsage', () {
    test('should format size correctly', () {
      final usage = ModelUsage(
        modelId: 'phi-3-mini',
        modelName: 'mini',
        accessCount: 100,
        lastAccess: DateTime.now().millisecondsSinceEpoch,
        sizeBytes: 200 * 1024 * 1024, // 200MB
        isPinned: false,
      );

      expect(usage.sizeDisplay, '200.0 MB');
    });

    test('should format last access correctly', () {
      final now = DateTime.now().millisecondsSinceEpoch;
      final usage = ModelUsage(
        modelId: 'phi-3-mini',
        modelName: 'mini',
        accessCount: 100,
        lastAccess: now,
        sizeBytes: 200 * 1024 * 1024,
        isPinned: false,
      );

      expect(usage.lastAccessDisplay, 'Today');
    });

    test('should format yesterday access', () {
      final yesterday = DateTime.now().subtract(Duration(days: 1)).millisecondsSinceEpoch;
      final usage = ModelUsage(
        modelId: 'phi-3-mini',
        modelName: 'mini',
        accessCount: 100,
        lastAccess: yesterday,
        sizeBytes: 200 * 1024 * 1024,
        isPinned: false,
      );

      expect(usage.lastAccessDisplay, 'Yesterday');
    });

    test('should format days ago access', () {
      final daysAgo = DateTime.now().subtract(Duration(days: 5)).millisecondsSinceEpoch;
      final usage = ModelUsage(
        modelId: 'phi-3-mini',
        modelName: 'mini',
        accessCount: 100,
        lastAccess: daysAgo,
        sizeBytes: 200 * 1024 * 1024,
        isPinned: false,
      );

      expect(usage.lastAccessDisplay, '5 days ago');
    });
  });

  group('StorageTrends', () {
    test('should identify growing trend', () {
      final trends = StorageTrends(
        sizeGrowthRate: 10.0,
        accessGrowthRate: 5.0,
        dailySnapshots: [],
        trendDirection: 'increasing',
      );

      expect(trends.isGrowing, true);
      expect(trends.isStable, false);
      expect(trends.isShrinking, false);
    });

    test('should identify stable trend', () {
      final trends = StorageTrends(
        sizeGrowthRate: 0.05,
        accessGrowthRate: 0.02,
        dailySnapshots: [],
        trendDirection: 'stable',
      );

      expect(trends.isGrowing, false);
      expect(trends.isStable, true);
      expect(trends.isShrinking, false);
    });

    test('should identify shrinking trend', () {
      final trends = StorageTrends(
        sizeGrowthRate: -5.0,
        accessGrowthRate: -2.0,
        dailySnapshots: [],
        trendDirection: 'decreasing',
      );

      expect(trends.isGrowing, false);
      expect(trends.isStable, false);
      expect(trends.isShrinking, true);
    });
  });

  group('StorageSnapshot', () {
    test('should calculate usage percentage correctly', () {
      final snapshot = StorageSnapshot(
        timestamp: DateTime.now(),
        totalSizeBytes: 1000 * 1024 * 1024, // 1GB
        usedSizeBytes: 500 * 1024 * 1024, // 500MB
        modelCount: 10,
        accessCount: 100,
      );

      expect(snapshot.usagePercentage, 0.5);
    });
  });
}
