import 'package:flutter_test/flutter_test.dart';
import 'package:pandora/services/encryption_service.dart';

void main() {
  group('EncryptionService', () {
    late EncryptionService encryptionService;

    setUp(() {
      encryptionService = EncryptionService();
    });

    group('encryptText and decryptText', () {
      test('should encrypt and decrypt text correctly', () {
        // Arrange
        const text = 'Hello, World!';
        const password = 'test_password';

        // Act
        final encrypted = encryptionService.encryptText(text, password);
        final decrypted = encryptionService.decryptText(encrypted, password);

        // Assert
        expect(encrypted, isNot(equals(text)));
        expect(decrypted, equals(text));
      });

      test('should handle empty text', () {
        // Arrange
        const text = '';
        const password = 'test_password';

        // Act
        final encrypted = encryptionService.encryptText(text, password);
        final decrypted = encryptionService.decryptText(encrypted, password);

        // Assert
        expect(decrypted, equals(text));
      });

      test('should handle special characters', () {
        // Arrange
        const text = 'Special chars: !@#\$%^&*()_+-=[]{}|;:,.<>?';
        const password = 'test_password';

        // Act
        final encrypted = encryptionService.encryptText(text, password);
        final decrypted = encryptionService.decryptText(encrypted, password);

        // Assert
        expect(decrypted, equals(text));
      });

      test('should handle unicode text', () {
        // Arrange
        const text = 'Tiếng Việt có dấu: àáạảãâầấậẩẫăằắặẳẵ';
        const password = 'test_password';

        // Act
        final encrypted = encryptionService.encryptText(text, password);
        final decrypted = encryptionService.decryptText(encrypted, password);

        // Assert
        expect(decrypted, equals(text));
      });

      test('should fail with wrong password', () {
        // Arrange
        const text = 'Hello, World!';
        const password = 'test_password';
        const wrongPassword = 'wrong_password';

        // Act
        final encrypted = encryptionService.encryptText(text, password);

        // Assert
        expect(() => encryptionService.decryptText(encrypted, wrongPassword), throwsException);
      });
    });

    group('encryptNoteContent and decryptNoteContent', () {
      test('should encrypt and decrypt note content', () {
        // Arrange
        const content = 'This is a note content with some text.';
        const password = 'note_password';

        // Act
        final encrypted = encryptionService.encryptNoteContent(content, password);
        final decrypted = encryptionService.decryptNoteContent(encrypted, password);

        // Assert
        expect(encrypted, isNot(equals(content)));
        expect(decrypted, equals(content));
      });
    });

    group('hashPassword and verifyPassword', () {
      test('should hash password correctly', () {
        // Arrange
        const password = 'test_password';

        // Act
        final hash = encryptionService.hashPassword(password);

        // Assert
        expect(hash, isNot(equals(password)));
        expect(hash.length, equals(64)); // SHA256 hash length
      });

      test('should verify password correctly', () {
        // Arrange
        const password = 'test_password';
        final hash = encryptionService.hashPassword(password);

        // Act
        final isValid = encryptionService.verifyPassword(password, hash);

        // Assert
        expect(isValid, isTrue);
      });

      test('should reject wrong password', () {
        // Arrange
        const password = 'test_password';
        const wrongPassword = 'wrong_password';
        final hash = encryptionService.hashPassword(password);

        // Act
        final isValid = encryptionService.verifyPassword(wrongPassword, hash);

        // Assert
        expect(isValid, isFalse);
      });
    });

    group('generateSecureToken', () {
      test('should generate secure token', () {
        // Act
        final token1 = encryptionService.generateSecureToken();
        final token2 = encryptionService.generateSecureToken();

        // Assert
        expect(token1, isNot(equals(token2)));
        expect(token1.length, equals(32));
        expect(token2.length, equals(32));
      });
    });

    group('encryptMetadata and decryptMetadata', () {
      test('should encrypt and decrypt metadata', () {
        // Arrange
        final metadata = {
          'title': 'Test Note',
          'author': 'Test User',
          'created_at': '2024-01-01',
        };
        const password = 'test_password';

        // Act
        final encrypted = encryptionService.encryptMetadata(metadata, password);
        final decrypted = encryptionService.decryptMetadata(encrypted, password);

        // Assert
        expect(encrypted['title'], isNot(equals(metadata['title'])));
        expect(decrypted['title'], equals(metadata['title']));
        expect(decrypted['author'], equals(metadata['author']));
        expect(decrypted['created_at'], equals(metadata['created_at']));
      });

      test('should handle empty metadata', () {
        // Arrange
        final metadata = <String, dynamic>{};
        const password = 'test_password';

        // Act
        final encrypted = encryptionService.encryptMetadata(metadata, password);
        final decrypted = encryptionService.decryptMetadata(encrypted, password);

        // Assert
        expect(decrypted, isEmpty);
      });
    });

    group('isEncrypted', () {
      test('should detect encrypted data', () {
        // Arrange
        const text = 'Hello, World!';
        const password = 'test_password';
        final encrypted = encryptionService.encryptText(text, password);

        // Act
        final isEncrypted = encryptionService.isEncrypted(encrypted);

        // Assert
        expect(isEncrypted, isTrue);
      });

      test('should detect non-encrypted data', () {
        // Arrange
        const text = 'Hello, World!';

        // Act
        final isEncrypted = encryptionService.isEncrypted(text);

        // Assert
        expect(isEncrypted, isFalse);
      });
    });

    group('getEncryptionInfo', () {
      test('should return encryption info', () {
        // Act
        final info = encryptionService.getEncryptionInfo();

        // Assert
        expect(info, isA<Map<String, dynamic>>());
        expect(info['algorithm'], isA<String>());
        expect(info['key_derivation'], isA<String>());
        expect(info['timestamp'], isA<String>());
      });
    });
  });
}
