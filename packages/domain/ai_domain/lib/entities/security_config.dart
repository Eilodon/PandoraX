import 'package:freezed_annotation/freezed_annotation.dart';

part 'security_config.freezed.dart';
part 'security_config.g.dart';

/// Security configuration for encryption and authentication
@freezed
class SecurityConfig with _$SecurityConfig {
  const factory SecurityConfig({
    @Default(true) bool enableEncryption,
    @Default(EncryptionAlgorithm.aes256) EncryptionAlgorithm encryptionAlgorithm,
    @Default(true) bool enableBiometricAuth,
    @Default(true) bool enablePinAuth,
    @Default(true) bool enablePasswordAuth,
    @Default(6) int pinLength,
    @Default(8) int minPasswordLength,
    @Default(true) bool requireSpecialChars,
    @Default(true) bool requireNumbers,
    @Default(true) bool requireUppercase,
    @Default(true) bool requireLowercase,
    @Default(300) int sessionTimeoutSeconds,
    @Default(true) bool autoLockOnBackground,
    @Default(true) bool enableDataWiping,
    @Default(5) int maxFailedAttempts,
    @Default(300) int lockoutDurationSeconds,
    @Default(true) bool enableAuditLogging,
    @Default(true) bool enableSecurityMonitoring,
    @Default(true) bool enablePrivacyMode,
    @Default(true) bool enableSecureStorage,
    Map<String, dynamic>? customSettings,
  }) = _SecurityConfig;

  const SecurityConfig._();

  factory SecurityConfig.fromJson(Map<String, dynamic> json) =>
      _$SecurityConfigFromJson(json);

  /// Get default security configuration
  static SecurityConfig get defaultConfig => const SecurityConfig();

  /// Get high security configuration
  static SecurityConfig get highSecurityConfig => const SecurityConfig(
    enableEncryption: true,
    encryptionAlgorithm: EncryptionAlgorithm.aes256,
    enableBiometricAuth: true,
    enablePinAuth: true,
    enablePasswordAuth: true,
    pinLength: 8,
    minPasswordLength: 12,
    requireSpecialChars: true,
    requireNumbers: true,
    requireUppercase: true,
    requireLowercase: true,
    sessionTimeoutSeconds: 180,
    autoLockOnBackground: true,
    enableDataWiping: true,
    maxFailedAttempts: 3,
    lockoutDurationSeconds: 600,
    enableAuditLogging: true,
    enableSecurityMonitoring: true,
    enablePrivacyMode: true,
    enableSecureStorage: true,
  );

  /// Get low security configuration (for development)
  static SecurityConfig get lowSecurityConfig => const SecurityConfig(
    enableEncryption: false,
    enableBiometricAuth: false,
    enablePinAuth: false,
    enablePasswordAuth: false,
    sessionTimeoutSeconds: 3600,
    autoLockOnBackground: false,
    enableDataWiping: false,
    maxFailedAttempts: 10,
    lockoutDurationSeconds: 60,
    enableAuditLogging: false,
    enableSecurityMonitoring: false,
    enablePrivacyMode: false,
    enableSecureStorage: false,
  );

  /// Check if password meets requirements
  bool isPasswordValid(String password) {
    if (password.length < minPasswordLength) return false;
    
    if (requireUppercase && !password.contains(RegExp(r'[A-Z]'))) return false;
    if (requireLowercase && !password.contains(RegExp(r'[a-z]'))) return false;
    if (requireNumbers && !password.contains(RegExp(r'[0-9]'))) return false;
    if (requireSpecialChars && !password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false;
    
    return true;
  }

  /// Get password requirements description
  String get passwordRequirements {
    final requirements = <String>[];
    
    requirements.add('At least $minPasswordLength characters');
    if (requireUppercase) requirements.add('Uppercase letters');
    if (requireLowercase) requirements.add('Lowercase letters');
    if (requireNumbers) requirements.add('Numbers');
    if (requireSpecialChars) requirements.add('Special characters');
    
    return requirements.join(', ');
  }

  /// Get security level
  SecurityLevel get securityLevel {
    int score = 0;
    
    if (enableEncryption) score += 2;
    if (enableBiometricAuth) score += 3;
    if (enablePinAuth) score += 1;
    if (enablePasswordAuth) score += 1;
    if (minPasswordLength >= 12) score += 2;
    if (requireSpecialChars) score += 1;
    if (requireNumbers) score += 1;
    if (requireUppercase) score += 1;
    if (requireLowercase) score += 1;
    if (sessionTimeoutSeconds <= 300) score += 1;
    if (autoLockOnBackground) score += 1;
    if (enableDataWiping) score += 1;
    if (maxFailedAttempts <= 3) score += 1;
    if (enableAuditLogging) score += 1;
    if (enableSecurityMonitoring) score += 1;
    if (enablePrivacyMode) score += 1;
    if (enableSecureStorage) score += 1;
    
    if (score >= 20) return SecurityLevel.high;
    if (score >= 15) return SecurityLevel.medium;
    if (score >= 10) return SecurityLevel.low;
    return SecurityLevel.minimal;
  }
}

/// Encryption algorithm enumeration
enum EncryptionAlgorithm {
  aes128,
  aes256,
  chacha20,
  blowfish,
}

/// Security level enumeration
enum SecurityLevel {
  minimal,
  low,
  medium,
  high,
  maximum,
}

/// Authentication method enumeration
enum AuthenticationMethod {
  biometric,
  pin,
  password,
  pattern,
  none,
}

/// Security event types
enum SecurityEventType {
  login,
  logout,
  failedLogin,
  passwordChange,
  pinChange,
  biometricEnrollment,
  biometricRemoval,
  dataEncryption,
  dataDecryption,
  backupCreated,
  backupRestored,
  dataWiped,
  securityConfigChanged,
  suspiciousActivity,
  lockout,
  unlock,
}

/// Security event
@freezed
class SecurityEvent with _$SecurityEvent {
  const factory SecurityEvent({
    required String id,
    required SecurityEventType type,
    required DateTime timestamp,
    required String userId,
    String? description,
    String? ipAddress,
    String? deviceId,
    Map<String, dynamic>? metadata,
    SecuritySeverity severity,
  }) = _SecurityEvent;

  const SecurityEvent._();

  factory SecurityEvent.fromJson(Map<String, dynamic> json) =>
      _$SecurityEventFromJson(json);

  /// Get event description
  String get eventDescription {
    switch (type) {
      case SecurityEventType.login:
        return 'User logged in';
      case SecurityEventType.logout:
        return 'User logged out';
      case SecurityEventType.failedLogin:
        return 'Failed login attempt';
      case SecurityEventType.passwordChange:
        return 'Password changed';
      case SecurityEventType.pinChange:
        return 'PIN changed';
      case SecurityEventType.biometricEnrollment:
        return 'Biometric enrolled';
      case SecurityEventType.biometricRemoval:
        return 'Biometric removed';
      case SecurityEventType.dataEncryption:
        return 'Data encrypted';
      case SecurityEventType.dataDecryption:
        return 'Data decrypted';
      case SecurityEventType.backupCreated:
        return 'Backup created';
      case SecurityEventType.backupRestored:
        return 'Backup restored';
      case SecurityEventType.dataWiped:
        return 'Data wiped';
      case SecurityEventType.securityConfigChanged:
        return 'Security configuration changed';
      case SecurityEventType.suspiciousActivity:
        return 'Suspicious activity detected';
      case SecurityEventType.lockout:
        return 'Account locked out';
      case SecurityEventType.unlock:
        return 'Account unlocked';
    }
  }

  /// Get event icon
  String get eventIcon {
    switch (type) {
      case SecurityEventType.login:
        return '🔓';
      case SecurityEventType.logout:
        return '🔒';
      case SecurityEventType.failedLogin:
        return '❌';
      case SecurityEventType.passwordChange:
        return '🔑';
      case SecurityEventType.pinChange:
        return '🔢';
      case SecurityEventType.biometricEnrollment:
        return '👆';
      case SecurityEventType.biometricRemoval:
        return '👆';
      case SecurityEventType.dataEncryption:
        return '🔐';
      case SecurityEventType.dataDecryption:
        return '🔓';
      case SecurityEventType.backupCreated:
        return '💾';
      case SecurityEventType.backupRestored:
        return '📥';
      case SecurityEventType.dataWiped:
        return '🗑️';
      case SecurityEventType.securityConfigChanged:
        return '⚙️';
      case SecurityEventType.suspiciousActivity:
        return '⚠️';
      case SecurityEventType.lockout:
        return '🚫';
      case SecurityEventType.unlock:
        return '✅';
    }
  }
}

/// Security severity levels
enum SecuritySeverity {
  low,
  medium,
  high,
  critical,
}

/// Security status
@freezed
class SecurityStatus with _$SecurityStatus {
  const factory SecurityStatus({
    required bool isLocked,
    required bool isAuthenticated,
    required DateTime lastActivity,
    required int failedAttempts,
    required DateTime? lockoutUntil,
    required List<AuthenticationMethod> availableMethods,
    required SecurityLevel currentLevel,
    required bool isEncryptionEnabled,
    required bool isBiometricEnabled,
    required bool isPinEnabled,
    required bool isPasswordEnabled,
  }) = _SecurityStatus;

  const SecurityStatus._();

  factory SecurityStatus.fromJson(Map<String, dynamic> json) =>
      _$SecurityStatusFromJson(json);

  /// Check if account is locked
  bool get isAccountLocked => lockoutUntil != null && 
      DateTime.now().isBefore(lockoutUntil!);

  /// Get remaining lockout time
  Duration? get remainingLockoutTime {
    if (lockoutUntil == null) return null;
    final now = DateTime.now();
    if (now.isAfter(lockoutUntil!)) return null;
    return lockoutUntil!.difference(now);
  }

  /// Get security score
  int get securityScore {
    int score = 0;
    
    if (isEncryptionEnabled) score += 20;
    if (isBiometricEnabled) score += 30;
    if (isPinEnabled) score += 15;
    if (isPasswordEnabled) score += 15;
    if (availableMethods.length > 1) score += 10;
    if (failedAttempts == 0) score += 10;
    
    return score.clamp(0, 100);
  }

  /// Get security status message
  String get statusMessage {
    if (isAccountLocked) {
      final remaining = remainingLockoutTime;
      if (remaining != null) {
        final minutes = remaining.inMinutes;
        return 'Account locked for $minutes more minutes';
      }
      return 'Account is locked';
    }
    
    if (isAuthenticated) {
      return 'Authenticated and secure';
    }
    
    if (failedAttempts > 0) {
      return 'Failed attempts: $failedAttempts';
    }
    
    return 'Not authenticated';
  }
}
