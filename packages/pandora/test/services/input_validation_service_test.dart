import 'package:flutter_test/flutter_test.dart';
import 'package:pandora/services/input_validation_service.dart';

void main() {
  group('InputValidationService', () {
    late InputValidationService validationService;

    setUp(() {
      validationService = InputValidationService();
    });

    group('Note Title Validation', () {
      test('should accept valid note titles', () {
        // Test cases for valid titles
        final validTitles = [
          'Simple Title',
          'Title with Numbers 123',
          'Title-with-dashes',
          'Title_with_underscores',
          'Title.with.dots',
          'Tiếng Việt có dấu',
          'A', // Minimum length
        ];

        for (final title in validTitles) {
          final result = validationService.validateNoteTitle(title);
          expect(result.isValid, isTrue, reason: 'Failed for title: $title');
          expect(result.value, isNotNull);
        }
      });

      test('should reject invalid note titles', () {
        // Test cases for invalid titles
        final invalidTitles = [
          null, // Null
          '', // Empty
          '   ', // Only whitespace
          'A' * 101, // Too long
          '<script>alert("xss")</script>', // XSS attempt
          'Title with "quotes" and \'apostrophes\'', // After sanitization
        ];

        for (final title in invalidTitles) {
          final result = validationService.validateNoteTitle(title);
          expect(result.isValid, isFalse, reason: 'Should fail for title: $title');
          expect(result.error, isNotNull);
        }
      });

      test('should sanitize note titles', () {
        // Arrange
        const title = 'Title with <b>HTML</b> & "quotes"';

        // Act
        final result = validationService.validateNoteTitle(title);

        // Assert
        expect(result.isValid, isTrue);
        expect(result.value, contains('&lt;b&gt;'));
        expect(result.value, contains('&amp;'));
        expect(result.value, contains('&quot;'));
      });
    });

    group('Note Content Validation', () {
      test('should accept valid note content', () {
        // Test cases for valid content
        final validContents = [
          'Simple note content.',
          'Content with\nmultiple\nlines.',
          'Content with numbers 12345 and symbols !@#\$%^&*()',
          'Tiếng Việt với nội dung dài hơn và nhiều ký tự đặc biệt',
          '', // Empty content is allowed
          'A' * 1000, // Large but within limits
        ];

        for (final content in validContents) {
          final result = validationService.validateNoteContent(content);
          expect(result.isValid, isTrue, reason: 'Failed for content length: ${content.length}');
        }
      });

      test('should reject invalid note content', () {
        // Arrange
        final tooLongContent = 'A' * 50001; // Exceeds limit
        const xssContent = '<script>alert("xss")</script>';
        const sqlContent = 'SELECT * FROM users; DROP TABLE notes;';

        // Act & Assert
        expect(validationService.validateNoteContent(tooLongContent).isValid, isFalse);
        expect(validationService.validateNoteContent(xssContent).isValid, isFalse);
        expect(validationService.validateNoteContent(sqlContent).isValid, isFalse);
      });

      test('should handle null content', () {
        // Act
        final result = validationService.validateNoteContent(null);

        // Assert
        expect(result.isValid, isTrue);
        expect(result.value, equals(''));
      });
    });

    group('Email Validation', () {
      test('should accept valid email addresses', () {
        // Test cases for valid emails
        final validEmails = [
          'user@example.com',
          'test.email@domain.org',
          'user+tag@example.co.uk',
          'firstname.lastname@company.com',
          'user123@test-domain.com',
        ];

        for (final email in validEmails) {
          final result = validationService.validateEmail(email);
          expect(result.isValid, isTrue, reason: 'Failed for email: $email');
          expect(result.value, equals(email.toLowerCase()));
        }
      });

      test('should reject invalid email addresses', () {
        // Test cases for invalid emails
        final invalidEmails = [
          null,
          '',
          '   ',
          'invalid-email',
          '@domain.com',
          'user@',
          'user space@domain.com',
          'user@domain',
          'user@.com',
          'a' * 250 + '@example.com', // Too long
        ];

        for (final email in invalidEmails) {
          final result = validationService.validateEmail(email);
          expect(result.isValid, isFalse, reason: 'Should fail for email: $email');
        }
      });
    });

    group('Password Validation', () {
      test('should accept strong passwords', () {
        // Test cases for valid passwords
        final validPasswords = [
          'StrongPass123!',
          'MySecureP@ssw0rd',
          'Complicated123#Password',
          'Test@1234',
          'Aa1!bcdefghij',
        ];

        for (final password in validPasswords) {
          final result = validationService.validatePassword(password);
          expect(result.isValid, isTrue, reason: 'Failed for password: $password');
        }
      });

      test('should reject weak passwords', () {
        // Test cases for invalid passwords
        final invalidPasswords = [
          null,
          '',
          'short',
          'password', // Common password
          '12345678', // No letters
          'PASSWORD', // No lowercase
          'password', // No uppercase
          'Password', // No numbers
          'Password123', // No special characters
          'a' * 129, // Too long
        ];

        for (final password in invalidPasswords) {
          final result = validationService.validatePassword(password);
          expect(result.isValid, isFalse, reason: 'Should fail for password: $password');
        }
      });

      test('should require password complexity', () {
        // Arrange & Act
        final noUppercase = validationService.validatePassword('lowercase123!');
        final noLowercase = validationService.validatePassword('UPPERCASE123!');
        final noNumbers = validationService.validatePassword('NoNumbers!');
        final noSpecial = validationService.validatePassword('NoSpecial123');

        // Assert
        expect(noUppercase.isValid, isFalse);
        expect(noLowercase.isValid, isFalse);
        expect(noNumbers.isValid, isFalse);
        expect(noSpecial.isValid, isFalse);
      });
    });

    group('API Key Validation', () {
      test('should accept valid API keys', () {
        // Test cases for valid API keys
        final validApiKeys = [
          'sk-1234567890abcdef1234567890abcdef',
          'AIzaSyBOTI54Un_N5IDMv4SPK6c8F2XbYzOGz0s', // Google style
          'abc123def456ghi789jkl012mno345pqr678stu901vwx234yz',
          'API-KEY-1234567890-ABCDEFGHIJKLMNOP',
        ];

        for (final apiKey in validApiKeys) {
          final result = validationService.validateApiKey(apiKey);
          expect(result.isValid, isTrue, reason: 'Failed for API key: $apiKey');
        }
      });

      test('should reject invalid API keys', () {
        // Test cases for invalid API keys
        final invalidApiKeys = [
          null,
          '',
          '   ',
          'short', // Too short
          'a' * 501, // Too long
          'key with spaces',
          'key-with-"quotes"',
          '<script>alert("xss")</script>',
          'SELECT * FROM api_keys',
        ];

        for (final apiKey in invalidApiKeys) {
          final result = validationService.validateApiKey(apiKey);
          expect(result.isValid, isFalse, reason: 'Should fail for API key: $apiKey');
        }
      });
    });

    group('URL Validation', () {
      test('should accept valid HTTPS URLs', () {
        // Test cases for valid URLs
        final validUrls = [
          'https://example.com',
          'https://www.google.com',
          'https://api.openai.com/v1/chat/completions',
          'https://subdomain.domain.com/path?query=value',
          'https://localhost:8080/api/test',
        ];

        for (final url in validUrls) {
          final result = validationService.validateUrl(url);
          expect(result.isValid, isTrue, reason: 'Failed for URL: $url');
        }
      });

      test('should reject invalid URLs', () {
        // Test cases for invalid URLs
        final invalidUrls = [
          null,
          '',
          'http://insecure.com', // HTTP not allowed
          'ftp://files.com',
          'not-a-url',
          'https://',
          'https://.' + 'a' * 2050, // Too long
        ];

        for (final url in invalidUrls) {
          final result = validationService.validateUrl(url);
          expect(result.isValid, isFalse, reason: 'Should fail for URL: $url');
        }
      });
    });

    group('File Name Validation', () {
      test('should accept valid file names', () {
        // Test cases for valid file names
        final validFileNames = [
          'document.txt',
          'my-file.pdf',
          'image_001.jpg',
          'data.json',
          'report 2024.xlsx',
        ];

        for (final fileName in validFileNames) {
          final result = validationService.validateFileName(fileName);
          expect(result.isValid, isTrue, reason: 'Failed for file name: $fileName');
        }
      });

      test('should reject invalid file names', () {
        // Test cases for invalid file names
        final invalidFileNames = [
          null,
          '',
          '   ',
          'file<name.txt',
          'file>name.txt',
          'file:name.txt',
          'file"name.txt',
          'file/name.txt',
          'file\\name.txt',
          'file|name.txt',
          'file?name.txt',
          'file*name.txt',
          'CON', // Reserved Windows name
          'PRN.txt', // Reserved Windows name
          'a' * 256, // Too long
        ];

        for (final fileName in invalidFileNames) {
          final result = validationService.validateFileName(fileName);
          expect(result.isValid, isFalse, reason: 'Should fail for file name: $fileName');
        }
      });
    });

    group('Text Sanitization', () {
      test('should sanitize HTML content', () {
        // Arrange
        const htmlContent = '<p>Hello <b>World</b>!</p><script>alert("xss")</script>';

        // Act
        final sanitized = validationService.sanitizeText(htmlContent);

        // Assert
        expect(sanitized, contains('&lt;p&gt;'));
        expect(sanitized, contains('&lt;b&gt;'));
        expect(sanitized, isNot(contains('<script>')));
      });

      test('should remove control characters', () {
        // Arrange
        const textWithControls = 'Hello\x00\x01\x1F\x7FWorld';

        // Act
        final sanitized = validationService.sanitizeText(textWithControls);

        // Assert
        expect(sanitized, equals('HelloWorld'));
      });

      test('should sanitize HTML more aggressively', () {
        // Arrange
        const htmlContent = '<div>Content</div><style>body{color:red}</style><script>evil()</script>';

        // Act
        final sanitized = validationService.sanitizeHtml(htmlContent);

        // Assert
        expect(sanitized, equals('Content'));
        expect(sanitized, isNot(contains('<div>')));
        expect(sanitized, isNot(contains('<style>')));
        expect(sanitized, isNot(contains('<script>')));
      });
    });

    group('JSON Validation', () {
      test('should accept valid JSON', () {
        // Test cases for valid JSON
        final validJsonStrings = [
          '{"key": "value"}',
          '[1, 2, 3]',
          '{"nested": {"object": true}}',
          '{"array": [1, {"inner": "value"}]}',
          'null',
          '42',
          '"string"',
        ];

        for (final jsonString in validJsonStrings) {
          final result = validationService.validateJson(jsonString);
          expect(result.isValid, isTrue, reason: 'Failed for JSON: $jsonString');
        }
      });

      test('should reject invalid JSON', () {
        // Test cases for invalid JSON
        final invalidJsonStrings = [
          null,
          '',
          '{invalid json}',
          '{"unclosed": "string}',
          '{key: "value"}', // Unquoted key
          '{"trailing": "comma",}',
        ];

        for (final jsonString in invalidJsonStrings) {
          final result = validationService.validateJson(jsonString);
          expect(result.isValid, isFalse, reason: 'Should fail for JSON: $jsonString');
        }
      });

      test('should reject deeply nested JSON', () {
        // Arrange - Create deeply nested JSON (more than 10 levels)
        String deepJson = '{"level1":';
        for (int i = 2; i <= 12; i++) {
          deepJson += '{"level$i":';
        }
        deepJson += '"value"';
        for (int i = 2; i <= 12; i++) {
          deepJson += '}';
        }
        deepJson += '}';

        // Act
        final result = validationService.validateJson(deepJson);

        // Assert
        expect(result.isValid, isFalse);
        expect(result.error, contains('too deeply nested'));
      });

      test('should reject oversized JSON', () {
        // Arrange - Create large JSON (over 100KB)
        final largeObject = <String, String>{};
        for (int i = 0; i < 10000; i++) {
          largeObject['key$i'] = 'value' * 20; // Each entry ~30 bytes
        }
        final largeJson = largeObject.toString(); // Will be >100KB

        // Act
        final result = validationService.validateJson(largeJson);

        // Assert
        expect(result.isValid, isFalse);
        expect(result.error, contains('too large'));
      });
    });

    group('Rate Limiting', () {
      test('should allow requests within limit', () {
        // Act
        final isLimited1 = validationService.isRateLimited('test-key', maxRequests: 5);
        final isLimited2 = validationService.isRateLimited('test-key', maxRequests: 5);
        final isLimited3 = validationService.isRateLimited('test-key', maxRequests: 5);

        // Assert
        expect(isLimited1, isFalse);
        expect(isLimited2, isFalse);
        expect(isLimited3, isFalse);
      });

      test('should enforce rate limit', () {
        // Arrange
        const maxRequests = 3;
        const testKey = 'rate-limit-test';

        // Act - Exceed rate limit
        for (int i = 0; i < maxRequests; i++) {
          validationService.isRateLimited(testKey, maxRequests: maxRequests);
        }
        final isLimited = validationService.isRateLimited(testKey, maxRequests: maxRequests);

        // Assert
        expect(isLimited, isTrue);
      });

      test('should handle different keys independently', () {
        // Arrange
        const maxRequests = 2;

        // Act
        validationService.isRateLimited('key1', maxRequests: maxRequests);
        validationService.isRateLimited('key1', maxRequests: maxRequests);
        final key1Limited = validationService.isRateLimited('key1', maxRequests: maxRequests);
        
        final key2Limited = validationService.isRateLimited('key2', maxRequests: maxRequests);

        // Assert
        expect(key1Limited, isTrue);
        expect(key2Limited, isFalse);
      });
    });

    group('Validation Statistics', () {
      test('should return validation statistics', () {
        // Act
        final stats = validationService.getValidationStats();

        // Assert
        expect(stats, isA<Map<String, dynamic>>());
        expect(stats['patterns_count'], isA<Map<String, dynamic>>());
        expect(stats['validation_rules'], isA<Map<String, dynamic>>());
        expect(stats['security_features'], isA<List>());
        expect(stats['timestamp'], isA<String>());
        
        // Check specific values
        expect(stats['validation_rules']['note_title_max_length'], equals(100));
        expect(stats['validation_rules']['password_min_length'], equals(8));
        expect(stats['security_features'], contains('SQL Injection Prevention'));
        expect(stats['security_features'], contains('XSS Protection'));
      });
    });

    group('Security Pattern Detection', () {
      test('should detect SQL injection attempts', () {
        // Test cases for SQL injection
        final sqlInjectionInputs = [
          "'; DROP TABLE users; --",
          "1' OR '1'='1",
          "admin'/*",
          "UNION SELECT * FROM passwords",
          "INSERT INTO users VALUES",
        ];

        for (final input in sqlInjectionInputs) {
          final result = validationService.validateNoteContent(input);
          expect(result.isValid, isFalse, reason: 'Should detect SQL injection in: $input');
        }
      });

      test('should detect XSS attempts', () {
        // Test cases for XSS
        final xssInputs = [
          '<script>alert("xss")</script>',
          'javascript:alert("xss")',
          '<img src="x" onerror="alert(1)">',
          '<div onclick="evil()">click</div>',
          '<iframe src="javascript:alert(1)"></iframe>',
        ];

        for (final input in xssInputs) {
          final result = validationService.validateNoteContent(input);
          expect(result.isValid, isFalse, reason: 'Should detect XSS in: $input');
        }
      });
    });

    group('Edge Cases', () {
      test('should handle extremely long inputs gracefully', () {
        // Arrange
        final extremelyLongInput = 'A' * 100000;

        // Act & Assert
        expect(() => validationService.validateNoteTitle(extremelyLongInput), returnsNormally);
        expect(() => validationService.validateNoteContent(extremelyLongInput), returnsNormally);
        expect(() => validationService.validateEmail(extremelyLongInput), returnsNormally);
      });

      test('should handle special Unicode characters', () {
        // Arrange
        const unicodeInput = '🔒🌟✨ Emojis and symbols: ∑∆πΩ∞ Chinese: 你好世界 Arabic: مرحبا';

        // Act
        final titleResult = validationService.validateNoteTitle(unicodeInput);
        final contentResult = validationService.validateNoteContent(unicodeInput);

        // Assert
        expect(titleResult.isValid, isTrue);
        expect(contentResult.isValid, isTrue);
      });

      test('should handle whitespace-only inputs', () {
        // Test cases for whitespace inputs
        final whitespaceInputs = [
          '   ',
          '\t\t\t',
          '\n\n\n',
          ' \t \n ',
        ];

        for (final input in whitespaceInputs) {
          final titleResult = validationService.validateNoteTitle(input);
          expect(titleResult.isValid, isFalse, reason: 'Should reject whitespace-only title: "$input"');
        }
      });
    });
  });
}
