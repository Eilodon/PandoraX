import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';

enum CompressionType { none, gzip, zstd, brotli }

abstract class CompressionCodec {
  CompressionType get type;
  bool get isAvailable;
  Future<void> decompress(Stream<List<int>> input, StreamSink<List<int>> output);
  Future<Uint8List> decompressBytes(Uint8List input);
  String get name;
}

class NoneCodec implements CompressionCodec {
  @override
  CompressionType get type => CompressionType.none;
  
  @override
  bool get isAvailable => true;
  
  @override
  String get name => 'None';
  
  @override
  Future<void> decompress(Stream<List<int>> input, StreamSink<List<int>> output) async {
    await for (final chunk in input) {
      output.add(chunk);
    }
  }
  
  @override
  Future<Uint8List> decompressBytes(Uint8List input) async {
    return input;
  }
}

class GzipCodec implements CompressionCodec {
  @override
  CompressionType get type => CompressionType.gzip;
  
  @override
  bool get isAvailable => true;
  
  @override
  String get name => 'GZIP';
  
  @override
  Future<void> decompress(Stream<List<int>> input, StreamSink<List<int>> output) async {
    await for (final chunk in input) {
      final decompressed = gzip.decode(chunk);
      output.add(decompressed);
    }
  }
  
  @override
  Future<Uint8List> decompressBytes(Uint8List input) async {
    return Uint8List.fromList(gzip.decode(input));
  }
}

class ZstdCodec implements CompressionCodec {
  @override
  CompressionType get type => CompressionType.zstd;
  
  @override
  bool get isAvailable => false; // Requires native plugin
  
  @override
  String get name => 'ZSTD';
  
  @override
  Future<void> decompress(Stream<List<int>> input, StreamSink<List<int>> output) async {
    throw UnsupportedError('ZSTD not available - requires native plugin');
  }
  
  @override
  Future<Uint8List> decompressBytes(Uint8List input) async {
    throw UnsupportedError('ZSTD not available - requires native plugin');
  }
}

class BrotliCodec implements CompressionCodec {
  @override
  CompressionType get type => CompressionType.brotli;
  
  @override
  bool get isAvailable => false; // Requires native plugin
  
  @override
  String get name => 'Brotli';
  
  @override
  Future<void> decompress(Stream<List<int>> input, StreamSink<List<int>> output) async {
    throw UnsupportedError('Brotli not available - requires native plugin');
  }
  
  @override
  Future<Uint8List> decompressBytes(Uint8List input) async {
    throw UnsupportedError('Brotli not available - requires native plugin');
  }
}

class CodecRegistry {
  final Map<CompressionType, CompressionCodec> _codecs;
  final Map<String, CompressionType> _mimeTypes;

  CodecRegistry({
    Map<CompressionType, CompressionCodec>? codecs,
  }) : _codecs = codecs ?? {
          CompressionType.none: NoneCodec(),
          CompressionType.gzip: GzipCodec(),
          CompressionType.zstd: ZstdCodec(),
          CompressionType.brotli: BrotliCodec(),
        },
         _mimeTypes = {
           'application/gzip': CompressionType.gzip,
           'application/x-gzip': CompressionType.gzip,
           'application/zstd': CompressionType.zstd,
           'application/x-zstd': CompressionType.zstd,
           'application/brotli': CompressionType.brotli,
           'application/x-brotli': CompressionType.brotli,
         };

  CompressionCodec? availableFor(CompressionType type) {
    final codec = _codecs[type];
    return codec?.isAvailable == true ? codec : null;
  }

  CompressionCodec? fromMimeType(String mimeType) {
    final type = _mimeTypes[mimeType.toLowerCase()];
    return type != null ? availableFor(type) : null;
  }

  CompressionCodec? fromFileExtension(String filename) {
    final extension = filename.toLowerCase().split('.').last;
    switch (extension) {
      case 'gz':
      case 'gzip':
        return availableFor(CompressionType.gzip);
      case 'zst':
      case 'zstd':
        return availableFor(CompressionType.zstd);
      case 'br':
      case 'brotli':
        return availableFor(CompressionType.brotli);
      default:
        return availableFor(CompressionType.none);
    }
  }

  List<CompressionType> get availableTypes {
    return _codecs.entries
        .where((entry) => entry.value.isAvailable)
        .map((entry) => entry.key)
        .toList();
  }

  List<CompressionCodec> get availableCodecs {
    return _codecs.values
        .where((codec) => codec.isAvailable)
        .toList();
  }

  /// Get preferred codec for a given priority list
  CompressionCodec? getPreferredCodec(List<CompressionType> preferences) {
    for (final type in preferences) {
      final codec = availableFor(type);
      if (codec != null) return codec;
    }
    return availableFor(CompressionType.none);
  }
}

/// Utility class for compression operations
class CompressionUtils {
  static Future<bool> verifyCompressedFile(File file, CompressionType type) async {
    try {
      final codec = CodecRegistry().availableFor(type);
      if (codec == null) return false;
      
      // Try to read first few bytes to verify format
      final bytes = await file.openRead(0, 1024).first;
      return isValidCompressedData(bytes, type);
    } catch (e) {
      return false;
    }
  }

  static bool isValidCompressedData(List<int> data, CompressionType type) {
    if (data.isEmpty) return false;
    
    switch (type) {
      case CompressionType.gzip:
        // GZIP magic number: 1f 8b
        return data.length >= 2 && data[0] == 0x1f && data[1] == 0x8b;
      case CompressionType.zstd:
        // ZSTD magic number: 28 b5 2f fd
        return data.length >= 4 && 
               data[0] == 0x28 && data[1] == 0xb5 && 
               data[2] == 0x2f && data[3] == 0xfd;
      case CompressionType.brotli:
        // Brotli magic number: 81 1a 00 00
        return data.length >= 4 && 
               data[0] == 0x81 && data[1] == 0x1a && 
               data[2] == 0x00 && data[3] == 0x00;
      case CompressionType.none:
        return true;
    }
  }

  static String getFileExtension(CompressionType type) {
    switch (type) {
      case CompressionType.gzip:
        return '.gz';
      case CompressionType.zstd:
        return '.zst';
      case CompressionType.brotli:
        return '.br';
      case CompressionType.none:
        return '';
    }
  }

  static String getMimeType(CompressionType type) {
    switch (type) {
      case CompressionType.gzip:
        return 'application/gzip';
      case CompressionType.zstd:
        return 'application/zstd';
      case CompressionType.brotli:
        return 'application/brotli';
      case CompressionType.none:
        return 'application/octet-stream';
    }
  }
}