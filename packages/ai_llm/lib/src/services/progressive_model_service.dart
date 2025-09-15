import 'dart:async';
import 'package:ai_core/ai_core.dart';
import '../repositories/model_storage_repository_impl.dart';
import '../datasources/download_client.dart';
import '../services/ai_router_service.dart';

/// Progressive model service that manages model downloads and capabilities
class ProgressiveModelService {
  final ModelStorageRepository _storage;
  final DownloadClient _downloadClient;
  final DeviceCapabilityDetector _deviceDetector;
  final NetworkDetector _networkDetector;
  
  // Download state
  final Map<ModelLevel, DownloadProgress> _downloadProgress = {};
  final Map<ModelLevel, StreamController<DownloadProgress>> _progressControllers = {};
  
  // Configuration
  final int _maxConcurrentDownloads;
  final Duration _downloadTimeout;
  final bool _enableAutoDownload;
  
  ProgressiveModelService({
    required ModelStorageRepository storage,
    required DownloadClient downloadClient,
    required DeviceCapabilityDetector deviceDetector,
    required NetworkDetector networkDetector,
    int maxConcurrentDownloads = 2,
    Duration downloadTimeout = const Duration(minutes: 30),
    bool enableAutoDownload = true,
  }) : _storage = storage,
       _downloadClient = downloadClient,
       _deviceDetector = deviceDetector,
       _networkDetector = networkDetector,
       _maxConcurrentDownloads = maxConcurrentDownloads,
       _downloadTimeout = downloadTimeout,
       _enableAutoDownload = enableAutoDownload;

  /// Load the best available model for the device
  Future<ModelSession?> loadOptimalModel() async {
    try {
      // Get device capability
      final capability = await _deviceDetector.getCapability();
      
      // Get available models
      final availableModels = await _storage.getAvailableModels();
      
      if (availableModels.isEmpty) {
        // No models available, try to download the recommended one
        final recommendedLevel = _getRecommendedModelLevel(capability);
        return await downloadModel(recommendedLevel);
      }
      
      // Find the best model for this device
      final bestModel = _selectBestModelForDevice(availableModels, capability);
      
      if (bestModel != null) {
        return bestModel;
      }
      
      // No suitable model found, download recommended one
      final recommendedLevel = _getRecommendedModelLevel(capability);
      return await downloadModel(recommendedLevel);
    } catch (e) {
      throw ProgressiveModelException('Failed to load optimal model: $e', e);
    }
  }

  /// Download a specific model level
  Future<ModelSession?> downloadModel(ModelLevel level) async {
    try {
      // Check if already downloading
      if (_downloadProgress.containsKey(level)) {
        throw ProgressiveModelException('Model ${level.name} is already being downloaded');
      }
      
      // Check network connectivity
      final isConnected = await _networkDetector.isConnected;
      if (!isConnected) {
        throw ProgressiveModelException('No network connectivity for download');
      }
      
      // Check device capability
      final capability = await _deviceDetector.getCapability();
      if (level.sizeBytes > capability.maxModelSize) {
        throw InsufficientCapabilityException(
          'Device cannot handle ${level.name} model (${level.sizeBytes} bytes)'
        );
      }
      
      // Check storage space
      final availableSpace = await _getAvailableStorageSpace();
      if (level.sizeBytes > availableSpace) {
        throw InsufficientStorageException(
          'Insufficient storage space for ${level.name} model'
        );
      }
      
      // Start download
      return await _startDownload(level);
    } catch (e) {
      throw ProgressiveModelException('Failed to download model ${level.name}: $e', e);
    }
  }

  /// Get download progress for a model
  Stream<DownloadProgress> getDownloadProgress(ModelLevel level) {
    if (!_progressControllers.containsKey(level)) {
      _progressControllers[level] = StreamController<DownloadProgress>.broadcast();
    }
    return _progressControllers[level]!.stream;
  }

  /// Cancel a download
  Future<bool> cancelDownload(ModelLevel level) async {
    if (!_downloadProgress.containsKey(level)) {
      return false;
    }
    
    try {
      final progress = _downloadProgress[level]!;
      await progress.cancel();
      
      _downloadProgress.remove(level);
      _progressControllers[level]?.close();
      _progressControllers.remove(level);
      
      return true;
    } catch (e) {
      print('Error canceling download: $e');
      return false;
    }
  }

  /// Get recommended model level for device
  ModelLevel getRecommendedModelLevel(DeviceCapability capability) {
    return _getRecommendedModelLevel(capability);
  }

  /// Get model recommendations based on device and usage
  List<ModelRecommendation> getModelRecommendations() {
    final recommendations = <ModelRecommendation>[];
    
    for (final level in ModelLevel.values) {
      final recommendation = ModelRecommendation(
        level: level,
        isRecommended: _isModelRecommended(level),
        reason: _getRecommendationReason(level),
        priority: _getRecommendationPriority(level),
      );
      recommendations.add(recommendation);
    }
    
    return recommendations;
  }

  /// Check if a model is suitable for the device
  Future<bool> isModelSuitable(ModelLevel level) async {
    final capability = await _deviceDetector.getCapability();
    return level.sizeBytes <= capability.maxModelSize;
  }

  /// Get download statistics
  DownloadStatistics getDownloadStatistics() {
    final totalDownloads = _downloadProgress.length;
    final activeDownloads = _downloadProgress.values.where((p) => p.isActive).length;
    final completedDownloads = _downloadProgress.values.where((p) => p.isCompleted).length;
    final failedDownloads = _downloadProgress.values.where((p) => p.isFailed).length;
    
    return DownloadStatistics(
      totalDownloads: totalDownloads,
      activeDownloads: activeDownloads,
      completedDownloads: completedDownloads,
      failedDownloads: failedDownloads,
    );
  }

  /// Clean up completed downloads
  Future<void> cleanupCompletedDownloads() async {
    final completedLevels = _downloadProgress.entries
        .where((entry) => entry.value.isCompleted || entry.value.isFailed)
        .map((entry) => entry.key)
        .toList();
    
    for (final level in completedLevels) {
      _downloadProgress.remove(level);
      _progressControllers[level]?.close();
      _progressControllers.remove(level);
    }
  }

  // Private methods

  ModelLevel _getRecommendedModelLevel(DeviceCapability capability) {
    if (capability.ramGB >= 6 && capability.storageGB >= 5) {
      return ModelLevel.full;
    } else if (capability.ramGB >= 4 && capability.storageGB >= 2) {
      return ModelLevel.mini;
    } else {
      return ModelLevel.tiny;
    }
  }

  ModelSession? _selectBestModelForDevice(List<ModelSession> models, DeviceCapability capability) {
    // Filter models that fit device capability
    final suitableModels = models.where((model) => 
        model.level.sizeBytes <= capability.maxModelSize).toList();
    
    if (suitableModels.isEmpty) {
      return null;
    }
    
    // Sort by preference: pinned first, then by level (full > mini > tiny)
    suitableModels.sort((a, b) {
      if (a.pinned != b.pinned) {
        return a.pinned ? -1 : 1;
      }
      return _getLevelPriority(b.level) - _getLevelPriority(a.level);
    });
    
    return suitableModels.first;
  }

  int _getLevelPriority(ModelLevel level) {
    switch (level.name) {
      case 'full': return 3;
      case 'mini': return 2;
      case 'tiny': return 1;
      default: return 0;
    }
  }

  Future<int> _getAvailableStorageSpace() async {
    // This would typically use path_provider to get available space
    // For now, return a mock value
    return 5 * 1024 * 1024 * 1024; // 5GB
  }

  Future<ModelSession?> _startDownload(ModelLevel level) async {
    // Create progress tracker
    final progress = DownloadProgress(
      level: level,
      status: DownloadStatus.starting,
      progress: 0.0,
      downloadedBytes: 0,
      totalBytes: level.sizeBytes,
      speed: 0,
      eta: Duration.zero,
    );
    
    _downloadProgress[level] = progress;
    _progressControllers[level] = StreamController<DownloadProgress>.broadcast();
    
    try {
      // Start download
      progress.status = DownloadStatus.downloading;
      _notifyProgress(level, progress);
      
      // Simulate download (replace with actual download logic)
      await _simulateDownload(level, progress);
      
      // Create model session
      final session = ModelSession(
        key: level.key,
        file: null, // Would be actual file
        level: level,
        pinned: false,
      );
      
      // Store in repository
      await _storage.pinModel(level.key);
      
      progress.status = DownloadStatus.completed;
      progress.progress = 1.0;
      _notifyProgress(level, progress);
      
      return session;
    } catch (e) {
      progress.status = DownloadStatus.failed;
      progress.error = e.toString();
      _notifyProgress(level, progress);
      rethrow;
    }
  }

  Future<void> _simulateDownload(ModelLevel level, DownloadProgress progress) async {
    const totalSteps = 100;
    const stepDuration = Duration(milliseconds: 100);
    
    for (int i = 0; i <= totalSteps; i++) {
      if (progress.isCancelled) {
        throw Exception('Download cancelled');
      }
      
      progress.progress = i / totalSteps;
      progress.downloadedBytes = (level.sizeBytes * progress.progress).round();
      progress.speed = level.sizeBytes ~/ 10; // Mock speed
      progress.eta = Duration(seconds: ((1 - progress.progress) * 10).round());
      
      _notifyProgress(level, progress);
      
      await Future.delayed(stepDuration);
    }
  }

  void _notifyProgress(ModelLevel level, DownloadProgress progress) {
    _progressControllers[level]?.add(progress);
  }

  bool _isModelRecommended(ModelLevel level) {
    // This would check device capability and current usage patterns
    return level == ModelLevel.mini; // Default recommendation
  }

  String _getRecommendationReason(ModelLevel level) {
    switch (level.name) {
      case 'tiny':
        return 'Fast and lightweight, suitable for basic tasks';
      case 'mini':
        return 'Balanced performance and size, recommended for most users';
      case 'full':
        return 'Best quality, requires more resources';
      default:
        return 'Unknown model level';
    }
  }

  int _getRecommendationPriority(ModelLevel level) {
    switch (level.name) {
      case 'mini': return 1; // Highest priority
      case 'tiny': return 2;
      case 'full': return 3;
      default: return 4;
    }
  }
}

/// Download progress information
class DownloadProgress {
  final ModelLevel level;
  DownloadStatus status;
  double progress;
  int downloadedBytes;
  final int totalBytes;
  int speed;
  Duration eta;
  String? error;
  bool _isCancelled = false;

  DownloadProgress({
    required this.level,
    required this.status,
    required this.progress,
    required this.downloadedBytes,
    required this.totalBytes,
    required this.speed,
    required this.eta,
    this.error,
  });

  bool get isActive => status == DownloadStatus.downloading || status == DownloadStatus.starting;
  bool get isCompleted => status == DownloadStatus.completed;
  bool get isFailed => status == DownloadStatus.failed;
  bool get isCancelled => _isCancelled;

  Future<void> cancel() async {
    _isCancelled = true;
    status = DownloadStatus.cancelled;
  }
}

enum DownloadStatus {
  starting,
  downloading,
  completed,
  failed,
  cancelled,
}

/// Model recommendation
class ModelRecommendation {
  final ModelLevel level;
  final bool isRecommended;
  final String reason;
  final int priority;

  const ModelRecommendation({
    required this.level,
    required this.isRecommended,
    required this.reason,
    required this.priority,
  });
}

/// Download statistics
class DownloadStatistics {
  final int totalDownloads;
  final int activeDownloads;
  final int completedDownloads;
  final int failedDownloads;

  const DownloadStatistics({
    required this.totalDownloads,
    required this.activeDownloads,
    required this.completedDownloads,
    required this.failedDownloads,
  });
}

/// Custom exceptions
class ProgressiveModelException implements Exception {
  final String message;
  final dynamic originalError;
  
  const ProgressiveModelException(this.message, [this.originalError]);
  
  @override
  String toString() => 'ProgressiveModelException: $message';
}

class InsufficientCapabilityException implements Exception {
  final String message;
  
  const InsufficientCapabilityException(this.message);
  
  @override
  String toString() => 'InsufficientCapabilityException: $message';
}

class InsufficientStorageException implements Exception {
  final String message;
  
  const InsufficientStorageException(this.message);
  
  @override
  String toString() => 'InsufficientStorageException: $message';
}
