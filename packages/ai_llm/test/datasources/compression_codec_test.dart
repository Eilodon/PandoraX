import 'package:flutter_test/flutter_test.dart';
import 'package:ai_llm/ai_llm.dart';
import 'dart:io';
import 'dart:typed_data';

void main() {
  group('CompressionCodec', () {
    group('NoneCodec', () {
      test('should be available', () {
        final codec = NoneCodec();
        expect(codec.isAvailable, true);
        expect(codec.type, CompressionType.none);
        expect(codec.name, 'None');
      });

      test('should pass through data unchanged', () async {
        final codec = NoneCodec();
        final input = Uint8List.fromList([1, 2, 3, 4, 5]);
        
        final output = await codec.decompressBytes(input);
        expect(output, equals(input));
      });
    });

    group('GzipCodec', () {
      test('should be available', () {
        final codec = GzipCodec();
        expect(codec.isAvailable, true);
        expect(codec.type, CompressionType.gzip);
        expect(codec.name, 'GZIP');
      });

      test('should decompress gzip data', () async {
        final codec = GzipCodec();
        final original = Uint8List.fromList('Hello, World!'.codeUnits);
        
        // Compress data
        final compressed = Uint8List.fromList(gzip.encode(original));
        
        // Decompress using our codec
        final decompressed = await codec.decompressBytes(compressed);
        
        expect(String.fromCharCodes(decompressed), 'Hello, World!');
      });
    });

    group('ZstdCodec', () {
      test('should not be available', () {
        final codec = ZstdCodec();
        expect(codec.isAvailable, false);
        expect(codec.type, CompressionType.zstd);
        expect(codec.name, 'ZSTD');
      });

      test('should throw when trying to decompress', () async {
        final codec = ZstdCodec();
        final input = Uint8List.fromList([1, 2, 3, 4, 5]);
        
        expect(
          () => codec.decompressBytes(input),
          throwsA(isA<UnsupportedError>()),
        );
      });
    });

    group('BrotliCodec', () {
      test('should not be available', () {
        final codec = BrotliCodec();
        expect(codec.isAvailable, false);
        expect(codec.type, CompressionType.brotli);
        expect(codec.name, 'Brotli');
      });

      test('should throw when trying to decompress', () async {
        final codec = BrotliCodec();
        final input = Uint8List.fromList([1, 2, 3, 4, 5]);
        
        expect(
          () => codec.decompressBytes(input),
          throwsA(isA<UnsupportedError>()),
        );
      });
    });
  });

  group('CodecRegistry', () {
    late CodecRegistry registry;

    setUp(() {
      registry = CodecRegistry();
    });

    test('should return available codecs', () {
      final noneCodec = registry.availableFor(CompressionType.none);
      final gzipCodec = registry.availableFor(CompressionType.gzip);
      final zstdCodec = registry.availableFor(CompressionType.zstd);
      final brotliCodec = registry.availableFor(CompressionType.brotli);

      expect(noneCodec, isNotNull);
      expect(gzipCodec, isNotNull);
      expect(zstdCodec, isNull);
      expect(brotliCodec, isNull);
    });

    test('should return correct available types', () {
      final availableTypes = registry.availableTypes;
      expect(availableTypes, contains(CompressionType.none));
      expect(availableTypes, contains(CompressionType.gzip));
      expect(availableTypes, isNot(contains(CompressionType.zstd)));
      expect(availableTypes, isNot(contains(CompressionType.brotli)));
    });

    test('should return codec from file extension', () {
      final gzipCodec = registry.fromFileExtension('test.gz');
      final zstdCodec = registry.fromFileExtension('test.zst');
      final noneCodec = registry.fromFileExtension('test.bin');

      expect(gzipCodec, isNotNull);
      expect(gzipCodec?.type, CompressionType.gzip);
      expect(zstdCodec, isNull);
      expect(noneCodec, isNotNull);
      expect(noneCodec?.type, CompressionType.none);
    });

    test('should return preferred codec', () {
      final preferences = [
        CompressionType.zstd,
        CompressionType.gzip,
        CompressionType.none,
      ];

      final preferred = registry.getPreferredCodec(preferences);
      expect(preferred, isNotNull);
      expect(preferred?.type, CompressionType.gzip);
    });
  });

  group('CompressionUtils', () {
    test('should return correct file extensions', () {
      expect(CompressionUtils.getFileExtension(CompressionType.none), '');
      expect(CompressionUtils.getFileExtension(CompressionType.gzip), '.gz');
      expect(CompressionUtils.getFileExtension(CompressionType.zstd), '.zst');
      expect(CompressionUtils.getFileExtension(CompressionType.brotli), '.br');
    });

    test('should return correct MIME types', () {
      expect(CompressionUtils.getMimeType(CompressionType.none), 'application/octet-stream');
      expect(CompressionUtils.getMimeType(CompressionType.gzip), 'application/gzip');
      expect(CompressionUtils.getMimeType(CompressionType.zstd), 'application/zstd');
      expect(CompressionUtils.getMimeType(CompressionType.brotli), 'application/brotli');
    });

    test('should validate compressed data', () {
      // GZIP magic number: 1f 8b
      final gzipData = Uint8List.fromList([0x1f, 0x8b, 0x08, 0x00]);
      expect(CompressionUtils.isValidCompressedData(gzipData, CompressionType.gzip), true);
      
      // Invalid data
      final invalidData = Uint8List.fromList([0x00, 0x00, 0x00, 0x00]);
      expect(CompressionUtils.isValidCompressedData(invalidData, CompressionType.gzip), false);
    });
  });
}
