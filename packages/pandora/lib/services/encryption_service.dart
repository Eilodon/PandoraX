import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:injectable/injectable.dart';

/// Service for encrypting and decrypting sensitive data
@injectable
class EncryptionService {
  static const String _keyPrefix = 'pandora_notes_';
  
  /// Generate a secure key from user input
  String _generateKey(String input) {
    final bytes = utf8.encode(_keyPrefix + input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
  
  /// Encrypt text data
  String encryptText(String text, String password) {
    try {
      final key = _generateKey(password);
      final bytes = utf8.encode(text);
      
      // Simple XOR encryption (for demo purposes)
      // In production, use proper encryption like AES
      final encrypted = <int>[];
      for (int i = 0; i < bytes.length; i++) {
        encrypted.add(bytes[i] ^ key.codeUnitAt(i % key.length));
      }
      
      return base64.encode(encrypted);
    } catch (e) {
      throw Exception('Encryption failed: $e');
    }
  }
  
  /// Decrypt text data
  String decryptText(String encryptedText, String password) {
    try {
      final key = _generateKey(password);
      final encrypted = base64.decode(encryptedText);
      
      // Simple XOR decryption (for demo purposes)
      final decrypted = <int>[];
      for (int i = 0; i < encrypted.length; i++) {
        decrypted.add(encrypted[i] ^ key.codeUnitAt(i % key.length));
      }
      
      return utf8.decode(decrypted);
    } catch (e) {
      throw Exception('Decryption failed: $e');
    }
  }
  
  /// Encrypt note content
  String encryptNoteContent(String content, String password) {
    return encryptText(content, password);
  }
  
  /// Decrypt note content
  String decryptNoteContent(String encryptedContent, String password) {
    return decryptText(encryptedContent, password);
  }
  
  /// Hash password for storage
  String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
  
  /// Verify password hash
  bool verifyPassword(String password, String hash) {
    return hashPassword(password) == hash;
  }
  
  /// Generate secure random string
  String generateSecureToken() {
    final random = DateTime.now().millisecondsSinceEpoch.toString();
    final bytes = utf8.encode(random);
    final digest = sha256.convert(bytes);
    return digest.toString().substring(0, 32);
  }
  
  /// Encrypt sensitive metadata
  Map<String, String> encryptMetadata(Map<String, dynamic> metadata, String password) {
    final encrypted = <String, String>{};
    
    for (final entry in metadata.entries) {
      if (entry.value is String) {
        encrypted[entry.key] = encryptText(entry.value, password);
      } else {
        encrypted[entry.key] = encryptText(entry.value.toString(), password);
      }
    }
    
    return encrypted;
  }
  
  /// Decrypt sensitive metadata
  Map<String, String> decryptMetadata(Map<String, String> encryptedMetadata, String password) {
    final decrypted = <String, String>{};
    
    for (final entry in encryptedMetadata.entries) {
      decrypted[entry.key] = decryptText(entry.value, password);
    }
    
    return decrypted;
  }
  
  /// Check if data is encrypted
  bool isEncrypted(String data) {
    try {
      base64.decode(data);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  /// Get encryption info
  Map<String, dynamic> getEncryptionInfo() {
    return {
      'algorithm': 'XOR + Base64 (Demo)',
      'key_derivation': 'SHA256',
      'timestamp': DateTime.now().toIso8601String(),
      'note': 'This is a demo implementation. Use proper encryption in production.',
    };
  }
}
