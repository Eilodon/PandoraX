import 'dart:async';
import 'dart:io';
import 'package:ai_core/ai_core.dart';
import 'package:crypto/crypto.dart';
import 'download_client.dart' hide CompressionType;
import 'compression_codec.dart';
import 'delta_applier.dart';
import 'adaptive_health_monitor.dart';

class ModelDownloadManager {
  final DownloadClient _downloadClient;
  final CodecRegistry _codecRegistry;
  final DeltaUpdateManager _deltaManager;
  final HealthMonitor _healthMonitor;
  final String _cacheDir;
  // final int _maxRetries;
  final Duration _retryDelay;

  ModelDownloadManager({
    required DownloadClient downloadClient,
    required CodecRegistry codecRegistry,
    required DeltaUpdateManager deltaManager,
    required HealthMonitor healthMonitor,
    required String cacheDir,
    int maxRetries = 3,
    Duration retryDelay = const Duration(seconds: 2),
  }) : _downloadClient = downloadClient,
       _codecRegistry = codecRegistry,
       _deltaManager = deltaManager,
       _healthMonitor = healthMonitor,
       _cacheDir = cacheDir,
       _retryDelay = retryDelay;

  /// Download model with progress callback
  Future<ModelSession> downloadModel(
    ModelLevel level, {
    void Function(int bytesDownloaded, int totalBytes)? onProgress,
    void Function(String status)? onStatus,
  }) async {
    onStatus?.call('Preparing download...');
    
    // Get available sources
    final sources = await _downloadClient.getAvailableSources(level.modelId, level.version);
    if (sources.isEmpty) {
      throw DownloadException('No sources available for ${level.modelId}');
    }

    // Sort sources by priority and availability
    final sortedSources = _sortSources(sources);
    
    onStatus?.call('Found ${sortedSources.length} sources');

    // Try each source until one succeeds
    Exception? lastError;
    
    for (int i = 0; i < sortedSources.length; i++) {
      final source = sortedSources[i];
      onStatus?.call('Trying source ${i + 1}/${sortedSources.length}: ${source.name}');
      
      try {
        final session = await _downloadFromSource(
          level,
          source,
          onProgress: onProgress,
          onStatus: onStatus,
        );
        
        _healthMonitor.record(true, 0);
        onStatus?.call('Download completed successfully');
        return session;
      } catch (e) {
        lastError = e is Exception ? e : Exception(e.toString());
        _healthMonitor.record(false, 0);
        onStatus?.call('Source failed: ${e.toString()}');
        
        if (i < sortedSources.length - 1) {
          onStatus?.call('Retrying with next source...');
          await Future.delayed(_retryDelay);
        }
      }
    }
    
    throw DownloadException('All sources failed: ${lastError?.toString() ?? 'Unknown error'}');
  }

  /// Download with delta update if possible
  Future<ModelSession> downloadWithDelta(
    ModelLevel level,
    String baseModelKey, {
    void Function(int bytesDownloaded, int totalBytes)? onProgress,
    void Function(String status)? onStatus,
  }) async {
    onStatus?.call('Checking for delta updates...');
    
    // Get delta sources
    final sources = await _downloadClient.getAvailableSources(level.modelId, level.version);
    final deltaSources = sources.where((s) => s.isDelta).toList();
    
    if (deltaSources.isEmpty) {
      onStatus?.call('No delta updates available, downloading full model');
      return downloadModel(level, onProgress: onProgress, onStatus: onStatus);
    }

    // Find base model file
    final baseFile = File('$_cacheDir/$baseModelKey.bin');
    if (!await baseFile.exists()) {
      onStatus?.call('Base model not found, downloading full model');
      return downloadModel(level, onProgress: onProgress, onStatus: onStatus);
    }

    // Try delta sources
    for (final source in deltaSources) {
      try {
        onStatus?.call('Trying delta update from ${source.name}');
        
        final session = await _applyDeltaUpdate(
          level,
          baseFile,
          source,
          onProgress: onProgress,
          onStatus: onStatus,
        );
        
        _healthMonitor.record(true, 0);
        onStatus?.call('Delta update completed successfully');
        return session;
      } catch (e) {
        onStatus?.call('Delta update failed: ${e.toString()}');
        continue;
      }
    }
    
    // Fallback to full download
    onStatus?.call('Delta updates failed, downloading full model');
    return downloadModel(level, onProgress: onProgress, onStatus: onStatus);
  }

  Future<ModelSession> _downloadFromSource(
    ModelLevel level,
    Source source, {
    void Function(int bytesDownloaded, int totalBytes)? onProgress,
    void Function(String status)? onStatus,
  }) async {
    onStatus?.call('Downloading from ${source.name}...');
    
    // Create output file
    final outputFile = File('$_cacheDir/${level.key}.bin');
    await outputFile.parent.create(recursive: true);
    
    // Download with progress
    final result = await _downloadClient.get(source);
    
    onStatus?.call('Decompressing...');
    
    // Decompress if needed
    final codec = _codecRegistry.availableFor(source.compression);
    if (codec != null && source.compression != CompressionType.none) {
      await _decompressToFile(result, outputFile, codec);
    } else {
      await _copyStreamToFile(result.input, outputFile);
    }
    
    // Verify checksum
    if (result.expectedSha256 != null) {
      onStatus?.call('Verifying checksum...');
      final isValid = await _verifyChecksum(outputFile, result.expectedSha256!);
      if (!isValid) {
        await outputFile.delete();
        throw DownloadException('Checksum verification failed');
      }
    }
    
    onStatus?.call('Download completed');
    
    return ModelSession(
      key: level.key,
      filePath: outputFile.path,
      level: level,
      pinned: false,
      lastAccess: DateTime.now(),
      version: level.version,
    );
  }

  Future<ModelSession> _applyDeltaUpdate(
    ModelLevel level,
    File baseFile,
    Source deltaSource, {
    void Function(int bytesDownloaded, int totalBytes)? onProgress,
    void Function(String status)? onStatus,
  }) async {
    onStatus?.call('Downloading delta patch...');
    
    // Download delta patch
    final result = await _downloadClient.get(deltaSource);
    
    onStatus?.call('Applying delta patch...');
    
    // Create output file
    final outputFile = File('$_cacheDir/${level.key}.bin');
    await outputFile.parent.create(recursive: true);
    
    // Decompress patch if needed
    final codec = _codecRegistry.availableFor(deltaSource.compression);
    Stream<List<int>> patchStream = result.input;
    
    if (codec != null && deltaSource.compression != CompressionType.none) {
      final tempPatch = File('$_cacheDir/temp_patch.bin');
      await _decompressToFile(result, tempPatch, codec);
      patchStream = tempPatch.openRead();
    }
    
    // Apply delta
    await _deltaManager.applyDelta(
      baseFile,
      patchStream,
      outputFile,
      result.expectedSha256,
    );
    
    // Clean up temp file
    final tempPatch = File('$_cacheDir/temp_patch.bin');
    if (await tempPatch.exists()) {
      await tempPatch.delete();
    }
    
    return ModelSession(
      key: level.key,
      filePath: outputFile.path,
      level: level,
      pinned: false,
      lastAccess: DateTime.now(),
      version: level.version,
    );
  }

  Future<void> _decompressToFile(DownloadResult result, File outputFile, CompressionCodec codec) async {
    final sink = outputFile.openWrite();
    try {
      await codec.decompress(result.input, sink);
    } finally {
      await sink.close();
    }
  }

  Future<void> _copyStreamToFile(Stream<List<int>> input, File outputFile) async {
    final sink = outputFile.openWrite();
    try {
      await for (final chunk in input) {
        sink.add(chunk);
      }
    } finally {
      await sink.close();
    }
  }

  List<Source> _sortSources(List<Source> sources) {
    final sorted = sources.toList();
    sorted.sort((a, b) {
      // Sort by priority (higher first)
      if (a.priority != b.priority) {
        return b.priority.compareTo(a.priority);
      }
      
      // Then by compression preference
      final aCodec = _codecRegistry.availableFor(a.compression);
      final bCodec = _codecRegistry.availableFor(b.compression);
      
      if (aCodec != null && bCodec == null) return -1;
      if (aCodec == null && bCodec != null) return 1;
      
      // Prefer non-delta over delta
      if (a.isDelta != b.isDelta) {
        return a.isDelta ? 1 : -1;
      }
      
      return 0;
    });
    
    return sorted;
  }

  /// Get download statistics
  DownloadStats getStats() {
    final health = _healthMonitor.snapshot();
    return DownloadStats(
      totalDownloads: 0, // Would be tracked in real implementation
      successfulDownloads: 0,
      failedDownloads: 0,
      averageLatency: health.p50LatencyMs,
      successRate: health.successRate,
    );
  }

  Future<bool> _verifyChecksum(File file, String expectedSha256) async {
    try {
      final bytes = await file.readAsBytes();
      final digest = sha256.convert(bytes);
      final actualSha256 = digest.toString();
      return actualSha256.toLowerCase() == expectedSha256.toLowerCase();
    } catch (e) {
      return false;
    }
  }

  Future<void> dispose() async {
    await _downloadClient.dispose();
  }
}

class DownloadStats {
  final int totalDownloads;
  final int successfulDownloads;
  final int failedDownloads;
  final int averageLatency;
  final double successRate;

  const DownloadStats({
    required this.totalDownloads,
    required this.successfulDownloads,
    required this.failedDownloads,
    required this.averageLatency,
    required this.successRate,
  });

  double get failureRate => 1.0 - successRate;
}
