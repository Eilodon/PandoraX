import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:ai_llm/ai_llm.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  group('FlutterDownloadClient', () {
    late FlutterDownloadClient client;

    setUp(() {
      client = FlutterDownloadClient();
    });

    tearDown(() {
      client.dispose();
    });

    test('should download successfully with valid source', () async {
      // Mock HTTP client
      final mockClient = MockClient((request) async {
        return http.Response('test data', 200, headers: {
          'Content-Length': '9',
          'X-Checksum-SHA256': 'test_checksum',
        });
      });

      final client = FlutterDownloadClient(client: mockClient);
      
      final source = Source(
        name: 'Test Source',
        url: 'https://example.com/test.bin',
        checksumSha256: 'test_checksum',
      );

      final result = await client.get(source);

      expect(result.contentLength, 9);
      expect(result.expectedSha256, 'test_checksum');
      expect(result.compression, CompressionType.none);
    });

    test('should handle HTTP errors', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Not Found', 404);
      });

      final client = FlutterDownloadClient(client: mockClient);
      
      final source = Source(
        name: 'Test Source',
        url: 'https://example.com/notfound.bin',
      );

      expect(
        () => client.get(source),
        throwsA(isA<DownloadException>()),
      );
    });

    test('should support range requests', () async {
      final mockClient = MockClient((request) async {
        expect(request.headers['Range'], 'bytes=100-');
        return http.Response('partial data', 206, headers: {
          'Content-Length': '12',
        });
      });

      final client = FlutterDownloadClient(client: mockClient);
      
      final source = Source(
        name: 'Test Source',
        url: 'https://example.com/test.bin',
      );

      final result = await client.get(source, rangeStart: 100);

      expect(result.contentLength, 12);
    });

    test('should verify checksum correctly', () async {
      final testData = 'Hello, World!';
      final expectedHash = 'dffd6021bb2bd5b0af676290809ec3a53191dd81c7f70a4b28688a362182986f';
      
      final tempFile = await File('test_file.txt').writeAsString(testData);
      
      final isValid = await client.verifyChecksum(tempFile, expectedHash);
      expect(isValid, true);
      
      final invalidHash = 'invalid_hash';
      final isInvalid = await client.verifyChecksum(tempFile, invalidHash);
      expect(isInvalid, false);
      
      await tempFile.delete();
    });

    test('should get file checksum', () async {
      final testData = 'Hello, World!';
      final tempFile = await File('test_file.txt').writeAsString(testData);
      
      final checksum = await client.getFileChecksum(tempFile);
      expect(checksum, isNotEmpty);
      expect(checksum.length, 64); // SHA-256 hex length
      
      await tempFile.delete();
    });
  });

  group('Source', () {
    test('should create source with default values', () {
      final source = Source(
        name: 'Test',
        url: 'https://example.com/test.bin',
      );

      expect(source.name, 'Test');
      expect(source.url, 'https://example.com/test.bin');
      expect(source.priority, 100);
      expect(source.compression, CompressionType.none);
      expect(source.isDelta, false);
      expect(source.checksumSha256, null);
      expect(source.headers, isEmpty);
    });

    test('should copy with new values', () {
      final original = Source(
        name: 'Original',
        url: 'https://example.com/original.bin',
        priority: 100,
        compression: CompressionType.none,
      );

      final copied = original.copyWith(
        name: 'Copied',
        priority: 200,
        compression: CompressionType.gzip,
      );

      expect(copied.name, 'Copied');
      expect(copied.url, 'https://example.com/original.bin');
      expect(copied.priority, 200);
      expect(copied.compression, CompressionType.gzip);
    });
  });
}
