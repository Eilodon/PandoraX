import 'package:flutter_test/flutter_test.dart';
import 'package:pandora/services/production_encryption_service.dart';

void main() {
  group('ProductionEncryptionService', () {
    late ProductionEncryptionService encryptionService;

    setUp(() {
      encryptionService = ProductionEncryptionService();
    });

    group('Security Self-Test', () {
      test('should pass comprehensive security self-test', () {
        // Act
        final result = encryptionService.performSecuritySelfTest();

        // Assert
        expect(result, isTrue);
      });
    });

    group('Production Encryption/Decryption', () {
      test('should encrypt and decrypt text with AES-256', () {
        // Arrange
        const text = 'Hello, Production World!';
        const password = 'SecurePassword123!';

        // Act
        final encrypted = encryptionService.encryptText(text, password);
        final decrypted = encryptionService.decryptText(encrypted, password);

        // Assert
        expect(encrypted, isNot(equals(text)));
        expect(decrypted, equals(text));
        expect(encrypted.length, greaterThan(text.length)); // Due to salt/IV
      });

      test('should handle large text content', () {
        // Arrange
        final largeText = 'A' * 10000; // 10KB of text
        const password = 'SecurePassword123!';

        // Act
        final encrypted = encryptionService.encryptText(largeText, password);
        final decrypted = encryptionService.decryptText(encrypted, password);

        // Assert
        expect(decrypted, equals(largeText));
        expect(encrypted.length, greaterThan(largeText.length));
      });

      test('should handle Unicode and special characters', () {
        // Arrange
        const text = 'Tiếng Việt có dấu: àáạảãâầấậẩẫăằắặẳẵ 🔒🌟✨ Special: !@#\$%^&*()';
        const password = 'UnicodePassword123!';

        // Act
        final encrypted = encryptionService.encryptText(text, password);
        final decrypted = encryptionService.decryptText(encrypted, password);

        // Assert
        expect(decrypted, equals(text));
      });

      test('should generate different ciphertext for same plaintext', () {
        // Arrange
        const text = 'Same plaintext';
        const password = 'SamePassword123!';

        // Act
        final encrypted1 = encryptionService.encryptText(text, password);
        final encrypted2 = encryptionService.encryptText(text, password);

        // Assert
        expect(encrypted1, isNot(equals(encrypted2))); // Different due to random IV/salt
        expect(encryptionService.decryptText(encrypted1, password), equals(text));
        expect(encryptionService.decryptText(encrypted2, password), equals(text));
      });

      test('should fail with wrong password', () {
        // Arrange
        const text = 'Secret message';
        const correctPassword = 'CorrectPassword123!';
        const wrongPassword = 'WrongPassword123!';

        // Act
        final encrypted = encryptionService.encryptText(text, correctPassword);

        // Assert
        expect(
          () => encryptionService.decryptText(encrypted, wrongPassword),
          throwsException,
        );
      });

      test('should validate password requirements', () {
        // Arrange
        const text = 'Test message';
        const shortPassword = '123'; // Too short

        // Assert
        expect(
          () => encryptionService.encryptText(text, shortPassword),
          throwsA(isA<ArgumentError>()),
        );
      });

      test('should handle empty text gracefully', () {
        // Arrange
        const text = '';
        const password = 'ValidPassword123!';

        // Assert
        expect(
          () => encryptionService.encryptText(text, password),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    group('Note Content Encryption', () {
      test('should encrypt and decrypt note content with metadata', () {
        // Arrange
        const content = 'This is a secure note content.';
        const password = 'NotePassword123!';
        final metadata = {
          'title': 'Test Note',
          'author': 'Test User',
          'tags': ['important', 'secure'],
        };

        // Act
        final encryptedNote = encryptionService.encryptNoteContent(
          content: content,
          password: password,
          metadata: metadata,
        );
        final decryptedNote = encryptionService.decryptNoteContent(
          encryptedNote: encryptedNote,
          password: password,
        );

        // Assert
        expect(decryptedNote['content'], equals(content));
        expect(decryptedNote['algorithm'], equals('AES-256-CBC'));
        expect(decryptedNote['metadata'], isNotNull);
        expect(decryptedNote['metadata']['title'], equals('Test Note'));
      });

      test('should encrypt note content without metadata', () {
        // Arrange
        const content = 'Simple note content.';
        const password = 'NotePassword123!';

        // Act
        final encryptedNote = encryptionService.encryptNoteContent(
          content: content,
          password: password,
        );
        final decryptedNote = encryptionService.decryptNoteContent(
          encryptedNote: encryptedNote,
          password: password,
        );

        // Assert
        expect(decryptedNote['content'], equals(content));
        expect(decryptedNote['metadata'], isNull);
      });
    });

    group('Password Hashing', () {
      test('should hash password with salt using PBKDF2', () {
        // Arrange
        const password = 'TestPassword123!';

        // Act
        final hashedPassword = encryptionService.hashPassword(password);

        // Assert
        expect(hashedPassword['hash'], isNotNull);
        expect(hashedPassword['salt'], isNotNull);
        expect(hashedPassword['algorithm'], equals('PBKDF2-SHA256'));
        expect(hashedPassword['iterations'], equals('10000'));
      });

      test('should verify correct password', () {
        // Arrange
        const password = 'TestPassword123!';
        final hashedPassword = encryptionService.hashPassword(password);

        // Act
        final isValid = encryptionService.verifyPassword(password, hashedPassword);

        // Assert
        expect(isValid, isTrue);
      });

      test('should reject incorrect password', () {
        // Arrange
        const correctPassword = 'CorrectPassword123!';
        const wrongPassword = 'WrongPassword123!';
        final hashedPassword = encryptionService.hashPassword(correctPassword);

        // Act
        final isValid = encryptionService.verifyPassword(wrongPassword, hashedPassword);

        // Assert
        expect(isValid, isFalse);
      });

      test('should generate different hashes for same password', () {
        // Arrange
        const password = 'SamePassword123!';

        // Act
        final hash1 = encryptionService.hashPassword(password);
        final hash2 = encryptionService.hashPassword(password);

        // Assert
        expect(hash1['hash'], isNot(equals(hash2['hash']))); // Different due to random salt
        expect(encryptionService.verifyPassword(password, hash1), isTrue);
        expect(encryptionService.verifyPassword(password, hash2), isTrue);
      });

      test('should validate password length for hashing', () {
        // Arrange
        const shortPassword = 'short'; // Less than 8 characters

        // Assert
        expect(
          () => encryptionService.hashPassword(shortPassword),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    group('Secure Token Generation', () {
      test('should generate secure tokens', () {
        // Act
        final token1 = encryptionService.generateSecureToken();
        final token2 = encryptionService.generateSecureToken();

        // Assert
        expect(token1, isNot(equals(token2)));
        expect(token1.length, equals(32));
        expect(token2.length, equals(32));
        expect(token1, matches(RegExp(r'^[a-zA-Z0-9]+$'))); // Only alphanumeric
      });

      test('should generate tokens with custom length', () {
        // Act
        final shortToken = encryptionService.generateSecureToken(length: 16);
        final longToken = encryptionService.generateSecureToken(length: 64);

        // Assert
        expect(shortToken.length, equals(16));
        expect(longToken.length, equals(64));
      });
    });

    group('Metadata Encryption', () {
      test('should encrypt and decrypt metadata', () {
        // Arrange
        final metadata = {
          'title': 'Test Note',
          'author': 'Test User',
          'created_at': '2024-01-01T00:00:00Z',
          'priority': 'high',
        };
        const password = 'MetadataPassword123!';

        // Act
        final encrypted = encryptionService.encryptMetadata(metadata, password);
        final decrypted = encryptionService.decryptMetadata(encrypted, password);

        // Assert
        expect(encrypted.keys, equals(metadata.keys));
        expect(encrypted['title'], isNot(equals(metadata['title'])));
        expect(decrypted['title'], equals(metadata['title']));
        expect(decrypted['author'], equals(metadata['author']));
        expect(decrypted['created_at'], equals(metadata['created_at']));
        expect(decrypted['priority'], equals(metadata['priority']));
      });

      test('should handle empty metadata', () {
        // Arrange
        final metadata = <String, dynamic>{};
        const password = 'EmptyMetadataPassword123!';

        // Act
        final encrypted = encryptionService.encryptMetadata(metadata, password);
        final decrypted = encryptionService.decryptMetadata(encrypted, password);

        // Assert
        expect(encrypted, isEmpty);
        expect(decrypted, isEmpty);
      });
    });

    group('Encryption Detection', () {
      test('should detect encrypted data', () {
        // Arrange
        const text = 'Test message for encryption detection';
        const password = 'DetectionPassword123!';
        final encrypted = encryptionService.encryptText(text, password);

        // Act
        final isEncrypted = encryptionService.isEncrypted(encrypted);

        // Assert
        expect(isEncrypted, isTrue);
      });

      test('should detect non-encrypted data', () {
        // Arrange
        const plainText = 'This is plain text that is not encrypted';

        // Act
        final isEncrypted = encryptionService.isEncrypted(plainText);

        // Assert
        expect(isEncrypted, isFalse);
      });

      test('should handle invalid base64 data', () {
        // Arrange
        const invalidData = 'This is not valid base64 data!@#';

        // Act
        final isEncrypted = encryptionService.isEncrypted(invalidData);

        // Assert
        expect(isEncrypted, isFalse);
      });
    });

    group('Encryption Info', () {
      test('should return encryption information', () {
        // Act
        final info = encryptionService.getEncryptionInfo();

        // Assert
        expect(info, isA<Map<String, dynamic>>());
        expect(info['algorithm'], equals('AES-256-CBC (Enhanced)'));
        expect(info['key_derivation'], equals('PBKDF2-SHA256'));
        expect(info['iterations'], equals(10000));
        expect(info['key_length'], equals(256));
        expect(info['iv_length'], equals(128));
        expect(info['salt_length'], equals(128));
        expect(info['version'], equals('2.0'));
        expect(info['production_ready'], isTrue);
        expect(info['features'], isA<List>());
        expect(info['timestamp'], isA<String>());
      });
    });

    group('Error Handling', () {
      test('should handle corrupted encrypted data gracefully', () {
        // Arrange
        const password = 'TestPassword123!';
        const corruptedData = 'Q29ycnVwdGVkRGF0YQ=='; // "CorruptedData" in base64

        // Assert
        expect(
          () => encryptionService.decryptText(corruptedData, password),
          throwsException,
        );
      });

      test('should handle invalid base64 encrypted data', () {
        // Arrange
        const password = 'TestPassword123!';
        const invalidBase64 = 'Invalid Base64 Data!';

        // Assert
        expect(
          () => encryptionService.decryptText(invalidBase64, password),
          throwsException,
        );
      });

      test('should handle empty encrypted data', () {
        // Arrange
        const password = 'TestPassword123!';
        const emptyData = '';

        // Assert
        expect(
          () => encryptionService.decryptText(emptyData, password),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    group('Performance Tests', () {
      test('should encrypt/decrypt within reasonable time', () async {
        // Arrange
        const text = 'Performance test message with reasonable length for timing';
        const password = 'PerformancePassword123!';

        // Act & Assert
        final stopwatch = Stopwatch()..start();
        final encrypted = encryptionService.encryptText(text, password);
        final encryptionTime = stopwatch.elapsedMilliseconds;
        
        stopwatch.reset();
        final decrypted = encryptionService.decryptText(encrypted, password);
        final decryptionTime = stopwatch.elapsedMilliseconds;
        stopwatch.stop();

        // Assert performance (should be under 100ms for small text)
        expect(encryptionTime, lessThan(100));
        expect(decryptionTime, lessThan(100));
        expect(decrypted, equals(text));
      });

      test('should handle multiple concurrent operations', () async {
        // Arrange
        const text = 'Concurrent operation test';
        const password = 'ConcurrentPassword123!';

        // Act
        final futures = List.generate(10, (index) async {
          final encrypted = encryptionService.encryptText('$text $index', password);
          return encryptionService.decryptText(encrypted, password);
        });

        final results = await Future.wait(futures);

        // Assert
        for (int i = 0; i < results.length; i++) {
          expect(results[i], equals('$text $i'));
        }
      });
    });
  });
}
