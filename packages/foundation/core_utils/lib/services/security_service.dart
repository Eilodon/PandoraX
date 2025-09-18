import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:core_utils/core_utils.dart';

/// Enhanced security service for data encryption and security
class SecurityService {
  static final SecurityService _instance = SecurityService._internal();
  factory SecurityService() => _instance;
  SecurityService._internal();

  late Encrypter _encrypter;
  late Key _key;
  late IV _iv;
  late SharedPreferences _prefs;
  bool _isInitialized = false;

  /// Initialize security service
  Future<void> initialize() async {
    try {
      AppLogger.info('Initializing Security Service...');
      
      _prefs = await SharedPreferences.getInstance();
      
      // Get or generate encryption key
      await _initializeEncryption();
      
      _isInitialized = true;
      AppLogger.success('Security Service initialized successfully');
    } catch (e) {
      AppLogger.error('Failed to initialize Security Service', e);
      rethrow;
    }
  }

  /// Initialize encryption with secure key management
  Future<void> _initializeEncryption() async {
    try {
      // Try to get existing key
      String? keyString = _prefs.getString('encryption_key');
      String? ivString = _prefs.getString('encryption_iv');
      
      if (keyString != null && ivString != null) {
        // Use existing key
        _key = Key.fromBase64(keyString);
        _iv = IV.fromBase64(ivString);
        AppLogger.info('Using existing encryption key');
      } else {
        // Generate new key
        _key = Key.fromSecureRandom(32);
        _iv = IV.fromSecureRandom(16);
        
        // Save key securely
        await _prefs.setString('encryption_key', _key.base64);
        await _prefs.setString('encryption_iv', _iv.base64);
        AppLogger.info('Generated new encryption key');
      }
      
      _encrypter = Encrypter(AES(_key));
    } catch (e) {
      AppLogger.error('Failed to initialize encryption', e);
      rethrow;
    }
  }

  /// Encrypt sensitive data
  String encrypt(String plainText) {
    if (!_isInitialized) {
      throw Exception('SecurityService not initialized');
    }

    try {
      final encrypted = _encrypter.encrypt(plainText, iv: _iv);
      return encrypted.base64;
    } catch (e) {
      AppLogger.error('Failed to encrypt data', e);
      rethrow;
    }
  }

  /// Decrypt sensitive data
  String decrypt(String encryptedText) {
    if (!_isInitialized) {
      throw Exception('SecurityService not initialized');
    }

    try {
      final encrypted = Encrypted.fromBase64(encryptedText);
      return _encrypter.decrypt(encrypted, iv: _iv);
    } catch (e) {
      AppLogger.error('Failed to decrypt data', e);
      rethrow;
    }
  }

  /// Encrypt note content
  String encryptNote(String content) {
    return encrypt(content);
  }

  /// Decrypt note content
  String decryptNote(String encryptedContent) {
    return decrypt(encryptedContent);
  }

  /// Hash password with salt
  String hashPassword(String password, String salt) {
    try {
      final bytes = utf8.encode(password + salt);
      final digest = sha256.convert(bytes);
      return digest.toString();
    } catch (e) {
      AppLogger.error('Failed to hash password', e);
      rethrow;
    }
  }

  /// Generate secure salt
  String generateSalt() {
    final random = Random.secure();
    final saltBytes = List<int>.generate(32, (i) => random.nextInt(256));
    return base64Encode(saltBytes);
  }

  /// Generate secure token
  String generateSecureToken() {
    final random = Random.secure();
    final tokenBytes = List<int>.generate(64, (i) => random.nextInt(256));
    return base64Encode(tokenBytes);
  }

  /// Validate password strength
  PasswordStrength validatePasswordStrength(String password) {
    int score = 0;
    List<String> feedback = [];

    // Length check
    if (password.length >= 8) {
      score += 1;
    } else {
      feedback.add('Password should be at least 8 characters long');
    }

    // Uppercase check
    if (password.contains(RegExp(r'[A-Z]'))) {
      score += 1;
    } else {
      feedback.add('Password should contain uppercase letters');
    }

    // Lowercase check
    if (password.contains(RegExp(r'[a-z]'))) {
      score += 1;
    } else {
      feedback.add('Password should contain lowercase letters');
    }

    // Number check
    if (password.contains(RegExp(r'[0-9]'))) {
      score += 1;
    } else {
      feedback.add('Password should contain numbers');
    }

    // Special character check
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      score += 1;
    } else {
      feedback.add('Password should contain special characters');
    }

    // Determine strength
    if (score >= 4) {
      return PasswordStrength.strong;
    } else if (score >= 2) {
      return PasswordStrength.medium;
    } else {
      return PasswordStrength.weak;
    }
  }

  /// Secure data storage
  Future<void> storeSecureData(String key, String value) async {
    try {
      final encryptedValue = encrypt(value);
      await _prefs.setString('secure_$key', encryptedValue);
      AppLogger.info('Secure data stored: $key');
    } catch (e) {
      AppLogger.error('Failed to store secure data: $key', e);
      rethrow;
    }
  }

  /// Retrieve secure data
  Future<String?> getSecureData(String key) async {
    try {
      final encryptedValue = _prefs.getString('secure_$key');
      if (encryptedValue == null) return null;
      
      return decrypt(encryptedValue);
    } catch (e) {
      AppLogger.error('Failed to retrieve secure data: $key', e);
      return null;
    }
  }

  /// Remove secure data
  Future<void> removeSecureData(String key) async {
    try {
      await _prefs.remove('secure_$key');
      AppLogger.info('Secure data removed: $key');
    } catch (e) {
      AppLogger.error('Failed to remove secure data: $key', e);
    }
  }

  /// Generate biometric key
  String generateBiometricKey() {
    final random = Random.secure();
    final keyBytes = List<int>.generate(32, (i) => random.nextInt(256));
    return base64Encode(keyBytes);
  }

  /// Validate biometric data
  bool validateBiometric(String storedData, String inputData) {
    try {
      return storedData == inputData;
    } catch (e) {
      AppLogger.error('Failed to validate biometric data', e);
      return false;
    }
  }

  /// Secure file encryption
  Uint8List encryptFile(Uint8List fileData) {
    if (!_isInitialized) {
      throw Exception('SecurityService not initialized');
    }

    try {
      final encrypted = _encrypter.encryptBytes(fileData, iv: _iv);
      return encrypted.bytes;
    } catch (e) {
      AppLogger.error('Failed to encrypt file', e);
      rethrow;
    }
  }

  /// Secure file decryption
  Uint8List decryptFile(Uint8List encryptedData) {
    if (!_isInitialized) {
      throw Exception('SecurityService not initialized');
    }

    try {
      final encrypted = Encrypted(encryptedData);
      return _encrypter.decryptBytes(encrypted, iv: _iv);
    } catch (e) {
      AppLogger.error('Failed to decrypt file', e);
      rethrow;
    }
  }

  /// Check if service is initialized
  bool get isInitialized => _isInitialized;

  /// Dispose resources
  void dispose() {
    _isInitialized = false;
  }
}

/// Password strength enumeration
enum PasswordStrength {
  weak,
  medium,
  strong,
}
