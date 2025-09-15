import '../entities/model_session.dart';
import '../entities/model_level.dart';
import '../entities/model_health.dart';

/// Abstract interface for model storage management
abstract class ModelStorageRepository {
  /// Get model session if available
  Future<ModelSession?> getModel(ModelLevel level);

  /// Download and store model
  Future<ModelSession> downloadModel(ModelLevel level);

  /// Pin model to prevent eviction
  Future<void> pinModel(String key);

  /// Unpin model to allow eviction
  Future<void> unpinModel(String key);

  /// Evict model from storage
  Future<void> evictModel(String key);

  /// Get all available models
  Future<List<ModelSession>> getAvailableModels();

  /// Get model health information
  Future<ModelHealth> getModelHealth(String key);

  /// Update model health information
  Future<void> updateModelHealth(String key, ModelHealth health);

  /// Check if model is available
  Future<bool> isModelAvailable(ModelLevel level);

  /// Get storage usage information
  Future<StorageUsage> getStorageUsage();

  /// Evict models if storage quota exceeded
  Future<void> evictIfNeeded();

  /// Clear all models
  Future<void> clearAll();
}

class StorageUsage {
  final int totalBytes;
  final int usedBytes;
  final int availableBytes;
  final int modelCount;

  const StorageUsage({
    required this.totalBytes,
    required this.usedBytes,
    required this.availableBytes,
    required this.modelCount,
  });

  double get usagePercentage => usedBytes / totalBytes;
  
  String get usageDisplay {
    final usedMB = usedBytes / (1024 * 1024);
    final totalMB = totalBytes / (1024 * 1024);
    return '${usedMB.toStringAsFixed(1)} MB / ${totalMB.toStringAsFixed(1)} MB';
  }
}
