import 'dart:io';
import 'package:ai_domain/ai_domain.dart';
import 'package:core_utils/core_utils.dart';

/// Service for biometric authentication
class BiometricAuthService {
  static final BiometricAuthService _instance = BiometricAuthService._internal();
  factory BiometricAuthService() => _instance;
  BiometricAuthService._internal();

  bool _isInitialized = false;
  bool _isAvailable = false;
  List<BiometricType> _availableTypes = [];
  BiometricStatus _status = BiometricStatus.notAvailable;

  /// Initialize biometric authentication service
  Future<bool> initialize() async {
    try {
      AppLogger.info('Initializing Biometric Authentication Service...');
      
      // Check platform support
      if (!_isPlatformSupported()) {
        AppLogger.warning('Biometric authentication not supported on this platform');
        _status = BiometricStatus.notSupported;
        return false;
      }
      
      // Check availability
      _isAvailable = await _checkAvailability();
      
      if (_isAvailable) {
        _status = BiometricStatus.available;
        AppLogger.success('Biometric authentication available');
      } else {
        _status = BiometricStatus.notAvailable;
        AppLogger.warning('Biometric authentication not available');
      }
      
      _isInitialized = true;
      AppLogger.success('Biometric Authentication Service initialized successfully');
      return true;
    } catch (e) {
      AppLogger.error('Failed to initialize Biometric Authentication Service', e);
      _status = BiometricStatus.error;
      return false;
    }
  }

  /// Check if platform supports biometric authentication
  bool _isPlatformSupported() {
    return Platform.isAndroid || Platform.isIOS;
  }

  /// Check biometric availability
  Future<bool> _checkAvailability() async {
    try {
      // TODO: Implement actual biometric availability check
      // For now, simulate availability based on platform
      if (Platform.isAndroid || Platform.isIOS) {
        _availableTypes = [BiometricType.fingerprint, BiometricType.face];
        return true;
      }
      return false;
    } catch (e) {
      AppLogger.error('Failed to check biometric availability', e);
      return false;
    }
  }

  /// Authenticate with biometric
  Future<BiometricAuthResult> authenticate({
    String? reason,
    String? title,
    String? subtitle,
    String? description,
    String? negativeButtonText,
    bool allowCredentials = true,
  }) async {
    if (!_isInitialized) {
      return BiometricAuthResult.error('Biometric service not initialized');
    }

    if (!_isAvailable) {
      return BiometricAuthResult.error('Biometric authentication not available');
    }

    try {
      AppLogger.info('Starting biometric authentication');
      
      // TODO: Implement actual biometric authentication
      // For now, simulate authentication
      await Future.delayed(const Duration(seconds: 2));
      
      // Simulate success/failure based on random chance
      final random = DateTime.now().millisecondsSinceEpoch % 10;
      final success = random > 2; // 80% success rate
      
      if (success) {
        AppLogger.success('Biometric authentication successful');
        return BiometricAuthResult.success(
          message: 'Biometric authentication successful',
          biometricType: _availableTypes.first,
        );
      } else {
        AppLogger.warning('Biometric authentication failed');
        return BiometricAuthResult.error('Biometric authentication failed');
      }
    } catch (e, stackTrace) {
      AppLogger.error('Biometric authentication failed with exception', e, stackTrace);
      return BiometricAuthResult.error('Biometric authentication failed: $e');
    }
  }

  /// Check if biometric is enrolled
  Future<bool> isBiometricEnrolled() async {
    if (!_isInitialized || !_isAvailable) {
      return false;
    }

    try {
      AppLogger.info('Checking biometric enrollment status');
      
      // TODO: Implement actual biometric enrollment check
      // For now, simulate enrollment status
      final isEnrolled = _availableTypes.isNotEmpty;
      
      AppLogger.info('Biometric enrollment status: $isEnrolled');
      return isEnrolled;
    } catch (e) {
      AppLogger.error('Failed to check biometric enrollment', e);
      return false;
    }
  }

  /// Get available biometric types
  List<BiometricType> getAvailableTypes() {
    return List.unmodifiable(_availableTypes);
  }

  /// Get biometric status
  BiometricStatus get status => _status;

  /// Check if biometric is available
  bool get isAvailable => _isAvailable;

  /// Check if service is initialized
  bool get isInitialized => _isInitialized;

  /// Get biometric strength
  BiometricStrength get strength {
    if (!_isAvailable) return BiometricStrength.none;
    
    int score = 0;
    if (_availableTypes.contains(BiometricType.fingerprint)) score += 2;
    if (_availableTypes.contains(BiometricType.face)) score += 3;
    if (_availableTypes.contains(BiometricType.iris)) score += 4;
    if (_availableTypes.contains(BiometricType.voice)) score += 1;
    
    if (score >= 4) return BiometricStrength.strong;
    if (score >= 2) return BiometricStrength.medium;
    return BiometricStrength.weak;
  }

  /// Get biometric security level
  SecurityLevel get securityLevel {
    switch (strength) {
      case BiometricStrength.none:
        return SecurityLevel.minimal;
      case BiometricStrength.weak:
        return SecurityLevel.low;
      case BiometricStrength.medium:
        return SecurityLevel.medium;
      case BiometricStrength.strong:
        return SecurityLevel.high;
    }
  }

  /// Get biometric description
  String get description {
    if (!_isAvailable) return 'Biometric authentication not available';
    
    final types = _availableTypes.map((type) => type.displayName).join(', ');
    return 'Available: $types';
  }

  /// Get biometric icon
  String get icon {
    if (!_isAvailable) return '🚫';
    
    if (_availableTypes.contains(BiometricType.face)) return '👤';
    if (_availableTypes.contains(BiometricType.fingerprint)) return '👆';
    if (_availableTypes.contains(BiometricType.iris)) return '👁️';
    if (_availableTypes.contains(BiometricType.voice)) return '🎤';
    
    return '🔐';
  }

  /// Dispose service
  Future<void> dispose() async {
    _availableTypes.clear();
    _isInitialized = false;
    _isAvailable = false;
    _status = BiometricStatus.notAvailable;
    AppLogger.info('Biometric Authentication Service disposed');
  }
}

/// Biometric type enumeration
enum BiometricType {
  fingerprint,
  face,
  iris,
  voice,
  palm,
}

/// Biometric status enumeration
enum BiometricStatus {
  notAvailable,
  available,
  notSupported,
  error,
  locked,
  permanentlyLocked,
}

/// Biometric strength enumeration
enum BiometricStrength {
  none,
  weak,
  medium,
  strong,
}

/// Biometric authentication result
class BiometricAuthResult {
  final bool success;
  final String message;
  final BiometricType? biometricType;
  final String? error;
  final Map<String, dynamic>? metadata;

  const BiometricAuthResult._({
    required this.success,
    required this.message,
    this.biometricType,
    this.error,
    this.metadata,
  });

  factory BiometricAuthResult.success({
    required String message,
    required BiometricType biometricType,
    Map<String, dynamic>? metadata,
  }) {
    return BiometricAuthResult._(
      success: true,
      message: message,
      biometricType: biometricType,
      metadata: metadata,
    );
  }

  factory BiometricAuthResult.error(String error) {
    return BiometricAuthResult._(
      success: false,
      message: 'Authentication failed',
      error: error,
    );
  }
}

/// Extension for BiometricType
extension BiometricTypeExtension on BiometricType {
  String get displayName {
    switch (this) {
      case BiometricType.fingerprint:
        return 'Fingerprint';
      case BiometricType.face:
        return 'Face ID';
      case BiometricType.iris:
        return 'Iris';
      case BiometricType.voice:
        return 'Voice';
      case BiometricType.palm:
        return 'Palm';
    }
  }

  String get icon {
    switch (this) {
      case BiometricType.fingerprint:
        return '👆';
      case BiometricType.face:
        return '👤';
      case BiometricType.iris:
        return '👁️';
      case BiometricType.voice:
        return '🎤';
      case BiometricType.palm:
        return '✋';
    }
  }

  String get description {
    switch (this) {
      case BiometricType.fingerprint:
        return 'Use your fingerprint to authenticate';
      case BiometricType.face:
        return 'Use your face to authenticate';
      case BiometricType.iris:
        return 'Use your iris to authenticate';
      case BiometricType.voice:
        return 'Use your voice to authenticate';
      case BiometricType.palm:
        return 'Use your palm to authenticate';
    }
  }

  int get securityScore {
    switch (this) {
      case BiometricType.fingerprint:
        return 2;
      case BiometricType.face:
        return 3;
      case BiometricType.iris:
        return 4;
      case BiometricType.voice:
        return 1;
      case BiometricType.palm:
        return 2;
    }
  }
}

/// Extension for BiometricStatus
extension BiometricStatusExtension on BiometricStatus {
  String get displayName {
    switch (this) {
      case BiometricStatus.notAvailable:
        return 'Not Available';
      case BiometricStatus.available:
        return 'Available';
      case BiometricStatus.notSupported:
        return 'Not Supported';
      case BiometricStatus.error:
        return 'Error';
      case BiometricStatus.locked:
        return 'Locked';
      case BiometricStatus.permanentlyLocked:
        return 'Permanently Locked';
    }
  }

  String get icon {
    switch (this) {
      case BiometricStatus.notAvailable:
        return '❌';
      case BiometricStatus.available:
        return '✅';
      case BiometricStatus.notSupported:
        return '🚫';
      case BiometricStatus.error:
        return '⚠️';
      case BiometricStatus.locked:
        return '🔒';
      case BiometricStatus.permanentlyLocked:
        return '🔐';
    }
  }

  String get description {
    switch (this) {
      case BiometricStatus.notAvailable:
        return 'Biometric authentication is not available on this device';
      case BiometricStatus.available:
        return 'Biometric authentication is available and ready to use';
      case BiometricStatus.notSupported:
        return 'Biometric authentication is not supported on this platform';
      case BiometricStatus.error:
        return 'An error occurred with biometric authentication';
      case BiometricStatus.locked:
        return 'Biometric authentication is temporarily locked';
      case BiometricStatus.permanentlyLocked:
        return 'Biometric authentication is permanently locked';
    }
  }
}

/// Extension for BiometricStrength
extension BiometricStrengthExtension on BiometricStrength {
  String get displayName {
    switch (this) {
      case BiometricStrength.none:
        return 'None';
      case BiometricStrength.weak:
        return 'Weak';
      case BiometricStrength.medium:
        return 'Medium';
      case BiometricStrength.strong:
        return 'Strong';
    }
  }

  String get icon {
    switch (this) {
      case BiometricStrength.none:
        return '🚫';
      case BiometricStrength.weak:
        return '⚠️';
      case BiometricStrength.medium:
        return '✅';
      case BiometricStrength.strong:
        return '🔒';
    }
  }

  String get description {
    switch (this) {
      case BiometricStrength.none:
        return 'No biometric authentication available';
      case BiometricStrength.weak:
        return 'Basic biometric authentication available';
      case BiometricStrength.medium:
        return 'Good biometric authentication available';
      case BiometricStrength.strong:
        return 'Strong biometric authentication available';
    }
  }
}
