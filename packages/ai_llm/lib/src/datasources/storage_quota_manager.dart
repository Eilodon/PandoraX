import 'dart:io';
import 'package:ai_core/ai_core.dart';
import '../models/storage_analytics.dart';
import '../models/model_cache_entry.dart';

/// Manages storage quotas and policies
class StorageQuotaManager {
  final String _cacheDir;
  final int _maxBytes;
  final double _warningThreshold;
  final double _criticalThreshold;
  final List<StoragePolicy> _policies;

  StorageQuotaManager({
    required String cacheDir,
    required int maxBytes,
    double warningThreshold = 0.8,
    double criticalThreshold = 0.95,
    List<StoragePolicy>? policies,
  }) : _cacheDir = cacheDir,
       _maxBytes = maxBytes,
       _warningThreshold = warningThreshold,
       _criticalThreshold = criticalThreshold,
       _policies = policies ?? _defaultPolicies();

  static List<StoragePolicy> _defaultPolicies() => [
    StoragePolicy(
      name: 'Expired Models',
      description: 'Remove models older than 30 days',
      priority: 1,
      condition: (entry) => entry.isExpired,
      action: StorageAction.delete,
    ),
    StoragePolicy(
      name: 'Low Priority Models',
      description: 'Remove rarely used models when space is low',
      priority: 2,
      condition: (entry) => entry.accessFrequency < 0.1 && !entry.pinned,
      action: StorageAction.delete,
    ),
    StoragePolicy(
      name: 'Large Unused Models',
      description: 'Remove large models that are rarely accessed',
      priority: 3,
      condition: (entry) => entry.size > 100 * 1024 * 1024 && entry.accessFrequency < 0.05 && !entry.pinned,
      action: StorageAction.delete,
    ),
    StoragePolicy(
      name: 'Duplicate Models',
      description: 'Remove duplicate model versions',
      priority: 4,
      condition: (entry) => false, // Would need to implement duplicate detection
      action: StorageAction.delete,
    ),
  ];

  /// Check if storage is within limits
  Future<StorageStatus> checkStorageStatus() async {
    try {
      final usage = await _calculateUsage();
      final percentage = usage.usedBytes / usage.totalBytes;
      
      StorageLevel level;
      if (percentage >= _criticalThreshold) {
        level = StorageLevel.critical;
      } else if (percentage >= _warningThreshold) {
        level = StorageLevel.warning;
      } else {
        level = StorageLevel.normal;
      }
      
      return StorageStatus(
        level: level,
        usage: usage,
        percentage: percentage,
        recommendations: await _getRecommendations(usage),
      );
    } catch (e) {
      return StorageStatus(
        level: StorageLevel.error,
        usage: StorageUsage(
          totalBytes: _maxBytes,
          usedBytes: 0,
          availableBytes: _maxBytes,
          modelCount: 0,
        ),
        percentage: 0.0,
        recommendations: ['Unable to check storage status: $e'],
      );
    }
  }

  /// Enforce storage policies
  Future<StorageCleanupResult> enforcePolicies() async {
    try {
      final status = await checkStorageStatus();
      if (status.level == StorageLevel.normal) {
        return StorageCleanupResult(
          success: true,
          bytesFreed: 0,
          modelsRemoved: 0,
          message: 'No cleanup needed',
        );
      }
      
      final entries = await _getModelEntries();
      final cleanupCandidates = <ModelCacheEntry>[];
      
      // Apply policies in priority order
      for (final policy in _policies..sort((a, b) => a.priority.compareTo(b.priority))) {
        final candidates = entries.where(policy.condition).toList();
        cleanupCandidates.addAll(candidates);
        
        // Stop if we have enough candidates
        if (cleanupCandidates.length >= 10) break;
      }
      
      // Sort by eviction priority
      cleanupCandidates.sort((a, b) => a.evictionPriority.compareTo(b.evictionPriority));
      
      int bytesFreed = 0;
      int modelsRemoved = 0;
      
      for (final entry in cleanupCandidates) {
        try {
          final file = File(entry.filePath);
          if (await file.exists()) {
            final fileSize = await file.length();
            await file.delete();
            bytesFreed += fileSize;
            modelsRemoved++;
          }
        } catch (e) {
          // Continue with next entry
        }
      }
      
      return StorageCleanupResult(
        success: true,
        bytesFreed: bytesFreed,
        modelsRemoved: modelsRemoved,
        message: 'Cleaned up $modelsRemoved models, freed ${(bytesFreed / (1024 * 1024)).toStringAsFixed(1)} MB',
      );
    } catch (e) {
      return StorageCleanupResult(
        success: false,
        bytesFreed: 0,
        modelsRemoved: 0,
        message: 'Cleanup failed: $e',
      );
    }
  }

  /// Get storage recommendations
  Future<List<String>> _getRecommendations(StorageUsage usage) async {
    final recommendations = <String>[];
    final percentage = usage.usedBytes / usage.totalBytes;
    
    if (percentage >= _criticalThreshold) {
      recommendations.add('Storage is critically full (${(percentage * 100).toStringAsFixed(1)}%). Immediate cleanup required.');
    } else if (percentage >= _warningThreshold) {
      recommendations.add('Storage is getting full (${(percentage * 100).toStringAsFixed(1)}%). Consider cleaning up unused models.');
    }
    
    final entries = await _getModelEntries();
    final expiredCount = entries.where((e) => e.isExpired).length;
    if (expiredCount > 0) {
      recommendations.add('$expiredCount expired models can be removed.');
    }
    
    final largeUnusedCount = entries.where((e) => 
      e.size > 100 * 1024 * 1024 && e.accessFrequency < 0.05 && !e.pinned
    ).length;
    if (largeUnusedCount > 0) {
      recommendations.add('$largeUnusedCount large unused models can be removed.');
    }
    
    final pinnedCount = entries.where((e) => e.pinned).length;
    if (pinnedCount > entries.length * 0.5) {
      recommendations.add('Many models are pinned. Consider unpinning unused ones.');
    }
    
    return recommendations;
  }

  /// Calculate current storage usage
  Future<StorageUsage> _calculateUsage() async {
    try {
      final dir = Directory(_cacheDir);
      if (!await dir.exists()) {
        return StorageUsage(
          totalBytes: _maxBytes,
          usedBytes: 0,
          availableBytes: _maxBytes,
          modelCount: 0,
        );
      }
      
      int totalSize = 0;
      int fileCount = 0;
      
      await for (final entity in dir.list(recursive: true)) {
        if (entity is File) {
          totalSize += await entity.length();
          fileCount++;
        }
      }
      
      return StorageUsage(
        totalBytes: _maxBytes,
        usedBytes: totalSize,
        availableBytes: _maxBytes - totalSize,
        modelCount: fileCount,
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

  /// Get model entries (placeholder - would integrate with Isar)
  Future<List<ModelCacheEntry>> _getModelEntries() async {
    // This is a placeholder implementation
    // In a real implementation, this would query the Isar database
    return [];
  }

  /// Get quota information
  QuotaInfo getQuotaInfo() {
    return QuotaInfo(
      maxBytes: _maxBytes,
      warningThreshold: _warningThreshold,
      criticalThreshold: _criticalThreshold,
      policies: _policies,
    );
  }

  /// Add custom storage policy
  void addPolicy(StoragePolicy policy) {
    _policies.add(policy);
    _policies.sort((a, b) => a.priority.compareTo(b.priority));
  }

  /// Remove storage policy
  void removePolicy(String policyName) {
    _policies.removeWhere((policy) => policy.name == policyName);
  }
}

enum StorageLevel { normal, warning, critical, error }

class StorageStatus {
  final StorageLevel level;
  final StorageUsage usage;
  final double percentage;
  final List<String> recommendations;

  const StorageStatus({
    required this.level,
    required this.usage,
    required this.percentage,
    required this.recommendations,
  });

  bool get needsAttention => level == StorageLevel.warning || level == StorageLevel.critical;
  bool get isCritical => level == StorageLevel.critical;
  bool get isError => level == StorageLevel.error;
}

class StoragePolicy {
  final String name;
  final String description;
  final int priority;
  final bool Function(ModelCacheEntry) condition;
  final StorageAction action;

  const StoragePolicy({
    required this.name,
    required this.description,
    required this.priority,
    required this.condition,
    required this.action,
  });
}

enum StorageAction { delete, compress, move }

class StorageCleanupResult {
  final bool success;
  final int bytesFreed;
  final int modelsRemoved;
  final String message;

  const StorageCleanupResult({
    required this.success,
    required this.bytesFreed,
    required this.modelsRemoved,
    required this.message,
  });

  String get sizeFreedDisplay {
    final mb = bytesFreed / (1024 * 1024);
    return '${mb.toStringAsFixed(1)} MB';
  }
}

class QuotaInfo {
  final int maxBytes;
  final double warningThreshold;
  final double criticalThreshold;
  final List<StoragePolicy> policies;

  const QuotaInfo({
    required this.maxBytes,
    required this.warningThreshold,
    required this.criticalThreshold,
    required this.policies,
  });

  String get maxSizeDisplay {
    final gb = maxBytes / (1024 * 1024 * 1024);
    return '${gb.toStringAsFixed(1)} GB';
  }
}
