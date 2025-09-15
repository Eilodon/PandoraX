import 'package:flutter_test/flutter_test.dart';
import 'package:ai_llm/ai_llm.dart';
import 'package:ai_core/ai_core.dart';
import 'dart:io';

void main() {
  group('StorageQuotaManager', () {
    late StorageQuotaManager manager;
    late Directory tempDir;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('storage_test_');
      manager = StorageQuotaManager(
        cacheDir: tempDir.path,
        maxBytes: 100 * 1024 * 1024, // 100MB
        warningThreshold: 0.8,
        criticalThreshold: 0.95,
      );
    });

    tearDown(() {
      tempDir.deleteSync(recursive: true);
    });

    test('should initialize with correct settings', () {
      expect(manager.getQuotaInfo().maxBytes, 100 * 1024 * 1024);
      expect(manager.getQuotaInfo().warningThreshold, 0.8);
      expect(manager.getQuotaInfo().criticalThreshold, 0.95);
    });

    test('should report normal status when storage is low', () async {
      // Create a small file
      final file = File('${tempDir.path}/small_file.txt');
      await file.writeAsString('small content');
      
      final status = await manager.checkStorageStatus();
      expect(status.level, StorageLevel.normal);
      expect(status.percentage, lessThan(0.8));
    });

    test('should report warning status when storage is high', () async {
      // Create a large file to trigger warning
      final file = File('${tempDir.path}/large_file.txt');
      final content = 'x' * (85 * 1024 * 1024); // 85MB
      await file.writeAsString(content);
      
      final status = await manager.checkStorageStatus();
      expect(status.level, StorageLevel.warning);
      expect(status.percentage, greaterThan(0.8));
    });

    test('should report critical status when storage is very high', () async {
      // Create a very large file to trigger critical
      final file = File('${tempDir.path}/very_large_file.txt');
      final content = 'x' * (96 * 1024 * 1024); // 96MB
      await file.writeAsString(content);
      
      final status = await manager.checkStorageStatus();
      expect(status.level, StorageLevel.critical);
      expect(status.percentage, greaterThan(0.95));
    });

    test('should provide recommendations when storage is high', () async {
      // Create a large file
      final file = File('${tempDir.path}/large_file.txt');
      final content = 'x' * (85 * 1024 * 1024); // 85MB
      await file.writeAsString(content);
      
      final status = await manager.checkStorageStatus();
      expect(status.recommendations, isNotEmpty);
      expect(status.recommendations.any((r) => r.contains('full')), true);
    });

    test('should add custom policy', () {
      final customPolicy = StoragePolicy(
        name: 'Custom Policy',
        description: 'Test policy',
        priority: 1,
        condition: (entry) => entry.size > 50 * 1024 * 1024,
        action: StorageAction.delete,
      );
      
      manager.addPolicy(customPolicy);
      final policies = manager.getQuotaInfo().policies;
      expect(policies.any((p) => p.name == 'Custom Policy'), true);
    });

    test('should remove policy', () {
      manager.removePolicy('Expired Models');
      final policies = manager.getQuotaInfo().policies;
      expect(policies.any((p) => p.name == 'Expired Models'), false);
    });
  });

  group('StorageStatus', () {
    test('should identify critical status', () {
      final status = StorageStatus(
        level: StorageLevel.critical,
        usage: StorageUsage(
          totalBytes: 100,
          usedBytes: 96,
          availableBytes: 4,
          modelCount: 1,
        ),
        percentage: 0.96,
        recommendations: ['Critical storage'],
      );
      
      expect(status.isCritical, true);
      expect(status.needsAttention, true);
      expect(status.isError, false);
    });

    test('should identify warning status', () {
      final status = StorageStatus(
        level: StorageLevel.warning,
        usage: StorageUsage(
          totalBytes: 100,
          usedBytes: 85,
          availableBytes: 15,
          modelCount: 1,
        ),
        percentage: 0.85,
        recommendations: ['Warning storage'],
      );
      
      expect(status.isCritical, false);
      expect(status.needsAttention, true);
      expect(status.isError, false);
    });

    test('should identify normal status', () {
      final status = StorageStatus(
        level: StorageLevel.normal,
        usage: StorageUsage(
          totalBytes: 100,
          usedBytes: 50,
          availableBytes: 50,
          modelCount: 1,
        ),
        percentage: 0.5,
        recommendations: [],
      );
      
      expect(status.isCritical, false);
      expect(status.needsAttention, false);
      expect(status.isError, false);
    });
  });

  group('StorageCleanupResult', () {
    test('should format size correctly', () {
      final result = StorageCleanupResult(
        success: true,
        bytesFreed: 1024 * 1024, // 1MB
        modelsRemoved: 5,
        message: 'Cleaned up 5 models',
      );
      
      expect(result.sizeFreedDisplay, '1.0 MB');
    });
  });

  group('QuotaInfo', () {
    test('should format max size correctly', () {
      final quota = QuotaInfo(
        maxBytes: 1024 * 1024 * 1024, // 1GB
        warningThreshold: 0.8,
        criticalThreshold: 0.95,
        policies: [],
      );
      
      expect(quota.maxSizeDisplay, '1.0 GB');
    });
  });
}
