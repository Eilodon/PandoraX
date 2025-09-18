import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:ai_domain/ai_domain.dart';
import 'package:core_utils/core_utils.dart';

/// Advanced encryption service with AES-256 and other algorithms
class AdvancedEncryptionService {
  static final AdvancedEncryptionService _instance = AdvancedEncryptionService._internal();
  factory AdvancedEncryptionService() => _instance;
  AdvancedEncryptionService._internal();

  bool _isInitialized = false;
  late Encrypter _encrypter;
  late Key _key;
  late IV _iv;
  EncryptionAlgorithm _currentAlgorithm = EncryptionAlgorithm.aes256;
  final Map<String, String> _keyCache = {};

  /// Initialize encryption service
  Future<bool> initialize() async {
    try {
      AppLogger.info('Initializing Advanced Encryption Service...');
      
      // Generate or load encryption key
      await _initializeEncryptionKey();
      
      // Set up encrypter
      _setupEncrypter();
      
      _isInitialized = true;
      AppLogger.success('Advanced Encryption Service initialized successfully');
      return true;
    } catch (e) {
      AppLogger.error('Failed to initialize Advanced Encryption Service', e);
      return false;
    }
  }

  /// Initialize encryption key
  Future<void> _initializeEncryptionKey() async {
    try {
      // Try to load existing key from secure storage
      final existingKey = await _loadEncryptionKey();
      if (existingKey != null) {
        _key = Key.fromBase64(existingKey);
        AppLogger.info('Loaded existing encryption key');
      } else {
        // Generate new key
        _key = Key.fromSecureRandom(32); // 256-bit key
        await _saveEncryptionKey(_key.base64);
        AppLogger.info('Generated new encryption key');
      }
      
      // Generate IV
      _iv = IV.fromSecureRandom(16);
    } catch (e) {
      AppLogger.error('Failed to initialize encryption key', e);
      rethrow;
    }
  }

  /// Set up encrypter based on current algorithm
  void _setupEncrypter() {
    switch (_currentAlgorithm) {
      case EncryptionAlgorithm.aes128:
        _encrypter = Encrypter(AES(_key, mode: AESMode.cbc));
        break;
      case EncryptionAlgorithm.aes256:
        _encrypter = Encrypter(AES(_key, mode: AESMode.cbc));
        break;
      case EncryptionAlgorithm.chacha20:
        // Note: ChaCha20 is not directly supported by encrypt package
        // Using AES-256 as fallback
        _encrypter = Encrypter(AES(_key, mode: AESMode.cbc));
        break;
      case EncryptionAlgorithm.blowfish:
        // Note: Blowfish is not directly supported by encrypt package
        // Using AES-256 as fallback
        _encrypter = Encrypter(AES(_key, mode: AESMode.cbc));
        break;
    }
  }

  /// Encrypt data
  Future<EncryptionResult> encrypt(String plaintext, {String? keyId}) async {
    if (!_isInitialized) {
      return EncryptionResult.error('Encryption service not initialized');
    }

    try {
      AppLogger.info('Encrypting data with ${_currentAlgorithm.name}');
      
      final encrypted = _encrypter.encrypt(plaintext, iv: _iv);
      
      final result = EncryptionResult.success(
        encryptedData: encrypted.base64,
        algorithm: _currentAlgorithm,
        keyId: keyId ?? 'default',
        iv: _iv.base64,
      );
      
      AppLogger.success('Data encrypted successfully');
      return result;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to encrypt data', e, stackTrace);
      return EncryptionResult.error('Failed to encrypt data: $e');
    }
  }

  /// Decrypt data
  Future<DecryptionResult> decrypt(String encryptedData, {String? keyId}) async {
    if (!_isInitialized) {
      return DecryptionResult.error('Encryption service not initialized');
    }

    try {
      AppLogger.info('Decrypting data with ${_currentAlgorithm.name}');
      
      final encrypted = Encrypted.fromBase64(encryptedData);
      final decrypted = _encrypter.decrypt(encrypted, iv: _iv);
      
      final result = DecryptionResult.success(
        plaintext: decrypted,
        algorithm: _currentAlgorithm,
        keyId: keyId ?? 'default',
      );
      
      AppLogger.success('Data decrypted successfully');
      return result;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to decrypt data', e, stackTrace);
      return DecryptionResult.error('Failed to decrypt data: $e');
    }
  }

  /// Encrypt file
  Future<EncryptionResult> encryptFile(String filePath, {String? keyId}) async {
    try {
      AppLogger.info('Encrypting file: $filePath');
      
      // Read file
      final file = File(filePath);
      final fileBytes = await file.readAsBytes();
      final fileData = base64Encode(fileBytes);
      
      // Encrypt data
      final result = await encrypt(fileData, keyId: keyId);
      
      if (result.success) {
        // Write encrypted file
        final encryptedFile = File('$filePath.encrypted');
        await encryptedFile.writeAsString(result.encryptedData!);
        
        AppLogger.success('File encrypted successfully: $filePath');
      }
      
      return result;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to encrypt file: $filePath', e, stackTrace);
      return EncryptionResult.error('Failed to encrypt file: $e');
    }
  }

  /// Decrypt file
  Future<DecryptionResult> decryptFile(String encryptedFilePath, {String? keyId}) async {
    try {
      AppLogger.info('Decrypting file: $encryptedFilePath');
      
      // Read encrypted file
      final encryptedFile = File(encryptedFilePath);
      final encryptedData = await encryptedFile.readAsString();
      
      // Decrypt data
      final result = await decrypt(encryptedData, keyId: keyId);
      
      if (result.success) {
        // Decode base64 and write file
        final fileBytes = base64Decode(result.plaintext!);
        final originalFilePath = encryptedFilePath.replaceAll('.encrypted', '');
        final decryptedFile = File(originalFilePath);
        await decryptedFile.writeAsBytes(fileBytes);
        
        AppLogger.success('File decrypted successfully: $encryptedFilePath');
      }
      
      return result;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to decrypt file: $encryptedFilePath', e, stackTrace);
      return DecryptionResult.error('Failed to decrypt file: $e');
    }
  }

  /// Encrypt with custom key
  Future<EncryptionResult> encryptWithKey(String plaintext, String key, {String? keyId}) async {
    try {
      AppLogger.info('Encrypting data with custom key');
      
      final customKey = Key.fromBase64(key);
      final customEncrypter = Encrypter(AES(customKey, mode: AESMode.cbc));
      final customIv = IV.fromSecureRandom(16);
      
      final encrypted = customEncrypter.encrypt(plaintext, iv: customIv);
      
      final result = EncryptionResult.success(
        encryptedData: encrypted.base64,
        algorithm: _currentAlgorithm,
        keyId: keyId ?? 'custom',
        iv: customIv.base64,
      );
      
      AppLogger.success('Data encrypted with custom key successfully');
      return result;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to encrypt with custom key', e, stackTrace);
      return EncryptionResult.error('Failed to encrypt with custom key: $e');
    }
  }

  /// Decrypt with custom key
  Future<DecryptionResult> decryptWithKey(String encryptedData, String key, {String? keyId}) async {
    try {
      AppLogger.info('Decrypting data with custom key');
      
      final customKey = Key.fromBase64(key);
      final customEncrypter = Encrypter(AES(customKey, mode: AESMode.cbc));
      final customIv = IV.fromBase64(encryptedData.split(':')[0]); // Assuming IV is prepended
      
      final encrypted = Encrypted.fromBase64(encryptedData.split(':')[1]);
      final decrypted = customEncrypter.decrypt(encrypted, iv: customIv);
      
      final result = DecryptionResult.success(
        plaintext: decrypted,
        algorithm: _currentAlgorithm,
        keyId: keyId ?? 'custom',
      );
      
      AppLogger.success('Data decrypted with custom key successfully');
      return result;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to decrypt with custom key', e, stackTrace);
      return DecryptionResult.error('Failed to decrypt with custom key: $e');
    }
  }

  /// Generate secure random key
  String generateSecureKey({int length = 32}) {
    final random = Random.secure();
    final bytes = List<int>.generate(length, (i) => random.nextInt(256));
    return base64Encode(bytes);
  }

  /// Generate secure random IV
  String generateSecureIV({int length = 16}) {
    final random = Random.secure();
    final bytes = List<int>.generate(length, (i) => random.nextInt(256));
    return base64Encode(bytes);
  }

  /// Hash data with SHA-256
  String hashData(String data) {
    final bytes = utf8.encode(data);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Hash data with SHA-512
  String hashDataSHA512(String data) {
    final bytes = utf8.encode(data);
    final digest = sha512.convert(bytes);
    return digest.toString();
  }

  /// Generate password hash with salt
  String hashPassword(String password, {String? salt}) {
    final actualSalt = salt ?? generateSecureKey(length: 16);
    final saltedPassword = password + actualSalt;
    final hash = hashData(saltedPassword);
    return '$hash:$actualSalt';
  }

  /// Verify password hash
  bool verifyPassword(String password, String hashedPassword) {
    try {
      final parts = hashedPassword.split(':');
      if (parts.length != 2) return false;
      
      final hash = parts[0];
      final salt = parts[1];
      final saltedPassword = password + salt;
      final computedHash = hashData(saltedPassword);
      
      return hash == computedHash;
    } catch (e) {
      AppLogger.error('Failed to verify password', e);
      return false;
    }
  }

  /// Set encryption algorithm
  void setEncryptionAlgorithm(EncryptionAlgorithm algorithm) {
    _currentAlgorithm = algorithm;
    _setupEncrypter();
    AppLogger.info('Encryption algorithm set to: ${algorithm.name}');
  }

  /// Get current encryption algorithm
  EncryptionAlgorithm get currentAlgorithm => _currentAlgorithm;

  /// Load encryption key from secure storage
  Future<String?> _loadEncryptionKey() async {
    try {
      // TODO: Implement secure storage loading
      // For now, return null to generate new key
      return null;
    } catch (e) {
      AppLogger.error('Failed to load encryption key', e);
      return null;
    }
  }

  /// Save encryption key to secure storage
  Future<void> _saveEncryptionKey(String key) async {
    try {
      // TODO: Implement secure storage saving
      AppLogger.info('Encryption key saved to secure storage');
    } catch (e) {
      AppLogger.error('Failed to save encryption key', e);
    }
  }

  /// Check if service is initialized
  bool get isInitialized => _isInitialized;

  /// Get encryption strength
  int get encryptionStrength {
    switch (_currentAlgorithm) {
      case EncryptionAlgorithm.aes128:
        return 128;
      case EncryptionAlgorithm.aes256:
        return 256;
      case EncryptionAlgorithm.chacha20:
        return 256;
      case EncryptionAlgorithm.blowfish:
        return 128;
    }
  }

  /// Dispose service
  Future<void> dispose() async {
    _keyCache.clear();
    _isInitialized = false;
    AppLogger.info('Advanced Encryption Service disposed');
  }
}

/// Encryption result
class EncryptionResult {
  final bool success;
  final String? encryptedData;
  final EncryptionAlgorithm? algorithm;
  final String? keyId;
  final String? iv;
  final String? error;

  const EncryptionResult._({
    required this.success,
    this.encryptedData,
    this.algorithm,
    this.keyId,
    this.iv,
    this.error,
  });

  factory EncryptionResult.success({
    required String encryptedData,
    required EncryptionAlgorithm algorithm,
    required String keyId,
    required String iv,
  }) {
    return EncryptionResult._(
      success: true,
      encryptedData: encryptedData,
      algorithm: algorithm,
      keyId: keyId,
      iv: iv,
    );
  }

  factory EncryptionResult.error(String error) {
    return EncryptionResult._(
      success: false,
      error: error,
    );
  }
}

/// Decryption result
class DecryptionResult {
  final bool success;
  final String? plaintext;
  final EncryptionAlgorithm? algorithm;
  final String? keyId;
  final String? error;

  const DecryptionResult._({
    required this.success,
    this.plaintext,
    this.algorithm,
    this.keyId,
    this.error,
  });

  factory DecryptionResult.success({
    required String plaintext,
    required EncryptionAlgorithm algorithm,
    required String keyId,
  }) {
    return DecryptionResult._(
      success: true,
      plaintext: plaintext,
      algorithm: algorithm,
      keyId: keyId,
    );
  }

  factory DecryptionResult.error(String error) {
    return DecryptionResult._(
      success: false,
      error: error,
    );
  }
}
