import 'dart:convert';
import 'dart:math';
import 'package:encrypt/encrypt.dart';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'logger.dart';

/// Service for handling data encryption and decryption
class EncryptionService {
  static const String _keyStorageKey = 'encryption_key';
  static const String _ivStorageKey = 'encryption_iv';

  late final Encrypter _encrypter;
  late final Key _key;
  late final IV _iv;

  /// Initialize encryption service
  Future<void> initialize() async {
    try {
      AppLogger.info('🔐 Initializing encryption service...');

      final prefs = await SharedPreferences.getInstance();

      // Get or generate encryption key
      String? keyString = prefs.getString(_keyStorageKey);
      if (keyString == null) {
        keyString = _generateKey();
        await prefs.setString(_keyStorageKey, keyString);
      }

      // Get or generate IV
      String? ivString = prefs.getString(_ivStorageKey);
      if (ivString == null) {
        ivString = _generateIV();
        await prefs.setString(_ivStorageKey, ivString);
      }

      _key = Key.fromBase64(keyString);
      _iv = IV.fromBase64(ivString);
      _encrypter = Encrypter(AES(_key));

      AppLogger.success('Encryption service initialized successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to initialize encryption service', e, stackTrace);
      rethrow;
    }
  }

  /// Encrypt text data
  String encrypt(String text) {
    try {
      final encrypted = _encrypter.encrypt(text, iv: _iv);
      return encrypted.base64;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to encrypt text', e, stackTrace);
      rethrow;
    }
  }

  /// Decrypt text data
  String decrypt(String encryptedText) {
    try {
      final encrypted = Encrypted.fromBase64(encryptedText);
      return _encrypter.decrypt(encrypted, iv: _iv);
    } catch (e, stackTrace) {
      AppLogger.error('Failed to decrypt text', e, stackTrace);
      rethrow;
    }
  }

  /// Encrypt JSON data
  String encryptJson(Map<String, dynamic> json) {
    final jsonString = jsonEncode(json);
    return encrypt(jsonString);
  }

  /// Decrypt JSON data
  Map<String, dynamic> decryptJson(String encryptedJson) {
    final jsonString = decrypt(encryptedJson);
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  /// Generate a new encryption key
  String _generateKey() {
    final random = Random.secure();
    final bytes = List<int>.generate(32, (i) => random.nextInt(256));
    return base64Encode(bytes);
  }

  /// Generate a new IV
  String _generateIV() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (i) => random.nextInt(256));
    return base64Encode(bytes);
  }

  /// Hash password for storage
  String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Verify password against hash
  bool verifyPassword(String password, String hash) {
    return hashPassword(password) == hash;
  }
}
