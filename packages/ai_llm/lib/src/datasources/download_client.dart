import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'compression_codec.dart';

class Source {
  final String name;
  final String url;
  final int priority;
  final CompressionType compression;
  final bool isDelta;
  final String? checksumSha256;
  final Map<String, String> headers;

  const Source({
    required this.name,
    required this.url,
    this.priority = 100,
    this.compression = CompressionType.none,
    this.isDelta = false,
    this.checksumSha256,
    this.headers = const {},
  });

  Source copyWith({
    String? name,
    String? url,
    int? priority,
    CompressionType? compression,
    bool? isDelta,
    String? checksumSha256,
    Map<String, String>? headers,
  }) {
    return Source(
      name: name ?? this.name,
      url: url ?? this.url,
      priority: priority ?? this.priority,
      compression: compression ?? this.compression,
      isDelta: isDelta ?? this.isDelta,
      checksumSha256: checksumSha256 ?? this.checksumSha256,
      headers: headers ?? this.headers,
    );
  }
}

class DownloadResult {
  final Stream<List<int>> input;
  final int contentLength;
  final CompressionType compression;
  final String? expectedSha256;
  final VoidCallback close;
  final Map<String, String> responseHeaders;

  const DownloadResult({
    required this.input,
    required this.contentLength,
    required this.compression,
    this.expectedSha256,
    required this.close,
    this.responseHeaders = const {},
  });
}

class DownloadException implements Exception {
  final String message;
  final String? source;
  final int? statusCode;
  
  const DownloadException(this.message, {this.source, this.statusCode});
  
  @override
  String toString() {
    if (source != null) {
      return 'DownloadException from $source: $message';
    }
    return 'DownloadException: $message';
  }
}

abstract class DownloadClient {
  Future<DownloadResult> get(Source source, {int? rangeStart, int timeoutMs = 15000});
  Future<List<Source>> getAvailableSources(String modelId, String version);
  Future<void> dispose();
}

class FlutterDownloadClient implements DownloadClient {
  final http.Client _client;
  final Duration _timeout;
  final Map<String, List<Source>> _sourceCache = {};

  FlutterDownloadClient({
    http.Client? client,
    Duration? timeout,
  }) : _client = client ?? http.Client(),
       _timeout = timeout ?? const Duration(seconds: 15);

  @override
  Future<DownloadResult> get(Source source, {int? rangeStart, int timeoutMs = 15000}) async {
    try {
      final request = http.Request('GET', Uri.parse(source.url));
      
      // Add custom headers
      source.headers.forEach((key, value) {
        request.headers[key] = value;
      });
      
      // Add range header if specified
      if (rangeStart != null) {
        request.headers['Range'] = 'bytes=$rangeStart-';
      }
      
      // Add compression support
      request.headers['Accept-Encoding'] = 'gzip, deflate, br';
      
      final response = await _client.send(request).timeout(Duration(milliseconds: timeoutMs));
      
      if (response.statusCode < 200 || response.statusCode > 206) {
        throw DownloadException(
          'HTTP ${response.statusCode} for ${source.url}',
          source: source.name,
          statusCode: response.statusCode,
        );
      }
      
      // Extract response headers
      final responseHeaders = <String, String>{};
      response.headers.forEach((key, value) {
        responseHeaders[key.toLowerCase()] = value;
      });
      
      // Get expected checksum from headers or source
      final expectedSha256 = source.checksumSha256 ?? 
                           responseHeaders['x-checksum-sha256'] ??
                           responseHeaders['checksum-sha256'];
      
      return DownloadResult(
        input: response.stream,
        contentLength: response.contentLength ?? -1,
        compression: source.compression,
        expectedSha256: expectedSha256,
        responseHeaders: responseHeaders,
        close: () => response.stream.listen((_) {}).cancel(),
      );
    } catch (e) {
      if (e is DownloadException) rethrow;
      throw DownloadException(
        'Failed to download from ${source.url}: $e',
        source: source.name,
      );
    }
  }

  @override
  Future<List<Source>> getAvailableSources(String modelId, String version) async {
    final cacheKey = '${modelId}_$version';
    
    if (_sourceCache.containsKey(cacheKey)) {
      return _sourceCache[cacheKey]!;
    }
    
    // This is a placeholder implementation
    // In a real implementation, this would fetch from a manifest API
    final sources = <Source>[
      Source(
        name: 'CDN-Primary-GZIP',
        url: 'https://cdn.example.com/$modelId/$version/model.bin.gz',
        priority: 200,
        compression: CompressionType.gzip,
        isDelta: false,
        checksumSha256: 'expected_sha256_here',
      ),
      Source(
        name: 'CDN-Backup-None',
        url: 'https://backup.example.com/$modelId/$version/model.bin',
        priority: 150,
        compression: CompressionType.none,
        isDelta: false,
        checksumSha256: 'expected_sha256_here',
      ),
    ];
    
    _sourceCache[cacheKey] = sources;
    return sources;
  }

  /// Download with progress callback
  Future<DownloadResult> getWithProgress(
    Source source, {
    int? rangeStart,
    int timeoutMs = 15000,
    void Function(int bytesDownloaded, int totalBytes)? onProgress,
  }) async {
    final result = await get(source, rangeStart: rangeStart, timeoutMs: timeoutMs);
    
    if (onProgress != null && result.contentLength > 0) {
      int bytesDownloaded = 0;
      final progressStream = result.input.map((chunk) {
        bytesDownloaded += chunk.length;
        onProgress(bytesDownloaded, result.contentLength);
        return chunk;
      });
      
      return DownloadResult(
        input: progressStream,
        contentLength: result.contentLength,
        compression: result.compression,
        expectedSha256: result.expectedSha256,
        responseHeaders: result.responseHeaders,
        close: result.close,
      );
    }
    
    return result;
  }

  /// Verify file checksum
  Future<bool> verifyChecksum(File file, String expectedSha256) async {
    try {
      final bytes = await file.readAsBytes();
      final digest = sha256.convert(bytes);
      final actualSha256 = digest.toString();
      return actualSha256.toLowerCase() == expectedSha256.toLowerCase();
    } catch (e) {
      return false;
    }
  }

  /// Get file checksum
  Future<String> getFileChecksum(File file) async {
    final bytes = await file.readAsBytes();
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Future<void> dispose() async {
    _client.close();
    _sourceCache.clear();
  }
}
