import '../entities/model_session.dart';
import '../entities/model_level.dart';
import '../repositories/model_storage_repository.dart';

/// Use case for downloading AI models
class DownloadModel {
  final ModelStorageRepository _storageRepository;

  const DownloadModel(this._storageRepository);

  /// Download model for specified level
  Future<ModelSession> call(ModelLevel level) async {
    // Check if model already exists
    final existing = await _storageRepository.getModel(level);
    if (existing != null) {
      return existing;
    }

    // Download model
    return await _storageRepository.downloadModel(level);
  }

  /// Download model with progress callback
  Future<ModelSession> callWithProgress(
    ModelLevel level,
    void Function(int bytesDownloaded, int totalBytes)? onProgress,
  ) async {
    // Check if model already exists
    final existing = await _storageRepository.getModel(level);
    if (existing != null) {
      return existing;
    }

    // Download model with progress tracking
    // This will be implemented in the data layer
    return await _storageRepository.downloadModel(level);
  }

  /// Check if model is available for download
  Future<bool> isAvailable(ModelLevel level) async {
    return await _storageRepository.isModelAvailable(level);
  }

  /// Get download size for model
  int getDownloadSize(ModelLevel level) {
    return level.sizeBytes;
  }
}
