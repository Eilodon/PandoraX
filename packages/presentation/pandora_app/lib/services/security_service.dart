import 'package:core_utils/core_utils.dart';
import 'package:common_entities/common_entities.dart';
import 'package:encrypt/encrypt.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

/// Security Service for handling security operations
class SecurityService {
  static final SecurityService _instance = SecurityService._internal();
  factory SecurityService() => _instance;
  SecurityService._internal();

  late Encrypter _encrypter;
  late Key _key;
  late IV _iv;
  final List<SecurityEvent> _securityEvents = [];

  /// Initialize security service
  Future<void> initialize() async {
    try {
      AppLogger.info('🔒 Initializing SecurityService...');
      
      // Generate encryption key
      _key = Key.fromSecureRandom(32);
      _iv = IV.fromSecureRandom(16);
      _encrypter = Encrypter(AES(_key));
      
      AppLogger.success('✅ SecurityService initialized');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to initialize SecurityService', e, stackTrace);
      rethrow;
    }
  }

  /// Encrypt data
  String encryptData(String data) {
    try {
      final encrypted = _encrypter.encrypt(data, iv: _iv);
      return encrypted.base64;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to encrypt data', e, stackTrace);
      rethrow;
    }
  }

  /// Decrypt data
  String decryptData(String encryptedData) {
    try {
      final encrypted = Encrypted.fromBase64(encryptedData);
      return _encrypter.decrypt(encrypted, iv: _iv);
    } catch (e, stackTrace) {
      AppLogger.error('Failed to decrypt data', e, stackTrace);
      rethrow;
    }
  }

  /// Hash data
  String hashData(String data) {
    final bytes = utf8.encode(data);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Log security event
  void logSecurityEvent(SecurityEvent event) {
    _securityEvents.add(event);
    AppLogger.info('🔒 Security event logged: ${event.type}');
  }

  /// Get security events
  List<SecurityEvent> getSecurityEvents() {
    return List.unmodifiable(_securityEvents);
  }

  /// Clear security events
  void clearSecurityEvents() {
    _securityEvents.clear();
    AppLogger.info('🔒 Security events cleared');
  }

  /// Validate data integrity
  bool validateDataIntegrity(String data, String hash) {
    final calculatedHash = hashData(data);
    return calculatedHash == hash;
  }

  /// Generate secure token
  String generateSecureToken() {
    final random = DateTime.now().millisecondsSinceEpoch.toString();
    return hashData(random);
  }
}
