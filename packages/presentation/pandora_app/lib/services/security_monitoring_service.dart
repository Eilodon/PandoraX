import 'dart:async';
import 'package:ai_domain/ai_domain.dart';
import 'package:core_utils/core_utils.dart';

/// Service for security monitoring and threat detection
class SecurityMonitoringService {
  static final SecurityMonitoringService _instance = SecurityMonitoringService._internal();
  factory SecurityMonitoringService() => _instance;
  SecurityMonitoringService._internal();

  bool _isInitialized = false;
  final List<SecurityEvent> _securityEvents = [];
  final Map<String, int> _failedAttempts = {};
  final Map<String, DateTime> _lastAttempts = {};
  Timer? _monitoringTimer;
  SecurityAlertLevel _currentAlertLevel = SecurityAlertLevel.none;

  /// Initialize security monitoring service
  Future<bool> initialize() async {
    try {
      AppLogger.info('Initializing Security Monitoring Service...');
      
      // Start monitoring timer
      _startMonitoring();
      
      _isInitialized = true;
      AppLogger.success('Security Monitoring Service initialized successfully');
      return true;
    } catch (e) {
      AppLogger.error('Failed to initialize Security Monitoring Service', e);
      return false;
    }
  }

  /// Start security monitoring
  void _startMonitoring() {
    _monitoringTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _performSecurityCheck();
    });
    
    AppLogger.info('Security monitoring started');
  }

  /// Stop security monitoring
  void _stopMonitoring() {
    _monitoringTimer?.cancel();
    _monitoringTimer = null;
    AppLogger.info('Security monitoring stopped');
  }

  /// Perform security check
  void _performSecurityCheck() {
    try {
      // Check for suspicious activity
      _checkSuspiciousActivity();
      
      // Check for failed attempts
      _checkFailedAttempts();
      
      // Check for unusual patterns
      _checkUnusualPatterns();
      
      // Update alert level
      _updateAlertLevel();
    } catch (e) {
      AppLogger.error('Security check failed', e);
    }
  }

  /// Check for suspicious activity
  void _checkSuspiciousActivity() {
    try {
      // Check for multiple failed logins
      final now = DateTime.now();
      final recentEvents = _securityEvents.where((event) {
        return event.timestamp.isAfter(now.subtract(const Duration(minutes: 15))) &&
               event.type == SecurityEventType.failedLogin;
      }).toList();
      
      if (recentEvents.length >= 5) {
        _logSecurityEvent(SecurityEventType.suspiciousActivity, 
          description: 'Multiple failed login attempts detected',
          severity: SecuritySeverity.high,
        );
      }
      
      // Check for unusual access patterns
      _checkUnusualAccessPatterns();
      
    } catch (e) {
      AppLogger.error('Failed to check suspicious activity', e);
    }
  }

  /// Check unusual access patterns
  void _checkUnusualAccessPatterns() {
    try {
      // Check for access from unusual times
      final now = DateTime.now();
      final hour = now.hour;
      
      if (hour < 6 || hour > 22) {
        _logSecurityEvent(SecurityEventType.suspiciousActivity,
          description: 'Access during unusual hours',
          severity: SecuritySeverity.medium,
        );
      }
      
      // Check for rapid successive access
      final recentEvents = _securityEvents.where((event) {
        return event.timestamp.isAfter(now.subtract(const Duration(minutes: 5))) &&
               event.type == SecurityEventType.login;
      }).toList();
      
      if (recentEvents.length >= 3) {
        _logSecurityEvent(SecurityEventType.suspiciousActivity,
          description: 'Rapid successive access detected',
          severity: SecuritySeverity.medium,
        );
      }
      
    } catch (e) {
      AppLogger.error('Failed to check unusual access patterns', e);
    }
  }

  /// Check failed attempts
  void _checkFailedAttempts() {
    try {
      final now = DateTime.now();
      final threshold = 3; // Max failed attempts
      final lockoutDuration = const Duration(minutes: 15);
      
      for (final entry in _failedAttempts.entries) {
        final userId = entry.key;
        final attempts = entry.value;
        final lastAttempt = _lastAttempts[userId];
        
        if (attempts >= threshold && lastAttempt != null) {
          final timeSinceLastAttempt = now.difference(lastAttempt);
          
          if (timeSinceLastAttempt < lockoutDuration) {
            _logSecurityEvent(SecurityEventType.lockout,
              description: 'Account locked due to failed attempts',
              severity: SecuritySeverity.high,
              metadata: {'user_id': userId, 'attempts': attempts},
            );
          }
        }
      }
      
    } catch (e) {
      AppLogger.error('Failed to check failed attempts', e);
    }
  }

  /// Check unusual patterns
  void _checkUnusualPatterns() {
    try {
      // Check for data access patterns
      _checkDataAccessPatterns();
      
      // Check for encryption patterns
      _checkEncryptionPatterns();
      
      // Check for backup patterns
      _checkBackupPatterns();
      
    } catch (e) {
      AppLogger.error('Failed to check unusual patterns', e);
    }
  }

  /// Check data access patterns
  void _checkDataAccessPatterns() {
    try {
      final now = DateTime.now();
      final recentEvents = _securityEvents.where((event) {
        return event.timestamp.isAfter(now.subtract(const Duration(hours: 1))) &&
               (event.type == SecurityEventType.dataEncryption ||
                event.type == SecurityEventType.dataDecryption);
      }).toList();
      
      if (recentEvents.length >= 20) {
        _logSecurityEvent(SecurityEventType.suspiciousActivity,
          description: 'Unusual data access pattern detected',
          severity: SecuritySeverity.medium,
        );
      }
      
    } catch (e) {
      AppLogger.error('Failed to check data access patterns', e);
    }
  }

  /// Check encryption patterns
  void _checkEncryptionPatterns() {
    try {
      final now = DateTime.now();
      final recentEvents = _securityEvents.where((event) {
        return event.timestamp.isAfter(now.subtract(const Duration(minutes: 30))) &&
               event.type == SecurityEventType.dataEncryption;
      }).toList();
      
      if (recentEvents.length >= 10) {
        _logSecurityEvent(SecurityEventType.suspiciousActivity,
          description: 'Unusual encryption activity detected',
          severity: SecuritySeverity.low,
        );
      }
      
    } catch (e) {
      AppLogger.error('Failed to check encryption patterns', e);
    }
  }

  /// Check backup patterns
  void _checkBackupPatterns() {
    try {
      final now = DateTime.now();
      final recentEvents = _securityEvents.where((event) {
        return event.timestamp.isAfter(now.subtract(const Duration(hours: 24))) &&
               (event.type == SecurityEventType.backupCreated ||
                event.type == SecurityEventType.backupRestored);
      }).toList();
      
      if (recentEvents.length >= 5) {
        _logSecurityEvent(SecurityEventType.suspiciousActivity,
          description: 'Unusual backup activity detected',
          severity: SecuritySeverity.medium,
        );
      }
      
    } catch (e) {
      AppLogger.error('Failed to check backup patterns', e);
    }
  }

  /// Update alert level
  void _updateAlertLevel() {
    try {
      final now = DateTime.now();
      final recentEvents = _securityEvents.where((event) {
        return event.timestamp.isAfter(now.subtract(const Duration(hours: 1)));
      }).toList();
      
      int criticalCount = 0;
      int highCount = 0;
      int mediumCount = 0;
      
      for (final event in recentEvents) {
        switch (event.severity) {
          case SecuritySeverity.critical:
            criticalCount++;
            break;
          case SecuritySeverity.high:
            highCount++;
            break;
          case SecuritySeverity.medium:
            mediumCount++;
            break;
          case SecuritySeverity.low:
            // Low severity events don't affect alert level
            break;
        }
      }
      
      SecurityAlertLevel newLevel = SecurityAlertLevel.none;
      
      if (criticalCount > 0) {
        newLevel = SecurityAlertLevel.critical;
      } else if (highCount >= 3) {
        newLevel = SecurityAlertLevel.high;
      } else if (highCount >= 1 || mediumCount >= 5) {
        newLevel = SecurityAlertLevel.medium;
      } else if (mediumCount >= 1) {
        newLevel = SecurityAlertLevel.low;
      }
      
      if (newLevel != _currentAlertLevel) {
        _currentAlertLevel = newLevel;
        AppLogger.info('Security alert level changed to: ${newLevel.name}');
      }
      
    } catch (e) {
      AppLogger.error('Failed to update alert level', e);
    }
  }

  /// Log security event
  void _logSecurityEvent(
    SecurityEventType type, {
    String? description,
    SecuritySeverity severity = SecuritySeverity.low,
    Map<String, dynamic>? metadata,
  }) {
    try {
      final event = SecurityEvent(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: type,
        timestamp: DateTime.now(),
        userId: 'current_user', // TODO: Get actual user ID
        description: description ?? event.eventDescription,
        metadata: metadata,
        severity: severity,
      );
      
      _securityEvents.add(event);
      
      // Keep only last 1000 events
      if (_securityEvents.length > 1000) {
        _securityEvents.removeAt(0);
      }
      
      AppLogger.info('Security event logged: ${type.name}');
    } catch (e) {
      AppLogger.error('Failed to log security event', e);
    }
  }

  /// Record failed attempt
  void recordFailedAttempt(String userId, String reason) {
    try {
      _failedAttempts[userId] = (_failedAttempts[userId] ?? 0) + 1;
      _lastAttempts[userId] = DateTime.now();
      
      _logSecurityEvent(SecurityEventType.failedLogin,
        description: 'Failed login attempt: $reason',
        severity: SecuritySeverity.medium,
        metadata: {'user_id': userId, 'reason': reason},
      );
      
      AppLogger.warning('Failed attempt recorded for user: $userId');
    } catch (e) {
      AppLogger.error('Failed to record failed attempt', e);
    }
  }

  /// Reset failed attempts
  void resetFailedAttempts(String userId) {
    try {
      _failedAttempts.remove(userId);
      _lastAttempts.remove(userId);
      
      AppLogger.info('Failed attempts reset for user: $userId');
    } catch (e) {
      AppLogger.error('Failed to reset failed attempts', e);
    }
  }

  /// Get security events
  List<SecurityEvent> getSecurityEvents({
    SecurityEventType? type,
    SecuritySeverity? severity,
    DateTime? since,
    int? limit,
  }) {
    try {
      var events = _securityEvents;
      
      if (type != null) {
        events = events.where((e) => e.type == type).toList();
      }
      
      if (severity != null) {
        events = events.where((e) => e.severity == severity).toList();
      }
      
      if (since != null) {
        events = events.where((e) => e.timestamp.isAfter(since)).toList();
      }
      
      events.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      
      if (limit != null && limit > 0) {
        events = events.take(limit).toList();
      }
      
      return events;
    } catch (e) {
      AppLogger.error('Failed to get security events', e);
      return [];
    }
  }

  /// Get security statistics
  SecurityStatistics getSecurityStatistics() {
    try {
      final now = DateTime.now();
      final last24Hours = now.subtract(const Duration(hours: 24));
      final last7Days = now.subtract(const Duration(days: 7));
      
      final events24h = _securityEvents.where((e) => e.timestamp.isAfter(last24Hours)).toList();
      final events7d = _securityEvents.where((e) => e.timestamp.isAfter(last7Days)).toList();
      
      final statistics = SecurityStatistics(
        totalEvents: _securityEvents.length,
        events24h: events24h.length,
        events7d: events7d.length,
        criticalEvents: _securityEvents.where((e) => e.severity == SecuritySeverity.critical).length,
        highEvents: _securityEvents.where((e) => e.severity == SecuritySeverity.high).length,
        mediumEvents: _securityEvents.where((e) => e.severity == SecuritySeverity.medium).length,
        lowEvents: _securityEvents.where((e) => e.severity == SecuritySeverity.low).length,
        currentAlertLevel: _currentAlertLevel,
        lastEvent: _securityEvents.isNotEmpty ? _securityEvents.last.timestamp : null,
        failedAttempts: _failedAttempts.values.fold(0, (sum, count) => sum + count),
      );
      
      return statistics;
    } catch (e) {
      AppLogger.error('Failed to get security statistics', e);
      return SecurityStatistics.empty();
    }
  }

  /// Get security report
  SecurityReport getSecurityReport() {
    try {
      final statistics = getSecurityStatistics();
      final recentEvents = getSecurityEvents(limit: 10);
      final recommendations = _generateRecommendations();
      
      final report = SecurityReport(
        statistics: statistics,
        recentEvents: recentEvents,
        recommendations: recommendations,
        generatedAt: DateTime.now(),
      );
      
      return report;
    } catch (e) {
      AppLogger.error('Failed to generate security report', e);
      return SecurityReport.empty();
    }
  }

  /// Generate security recommendations
  List<String> _generateRecommendations() {
    final recommendations = <String>[];
    
    final statistics = getSecurityStatistics();
    
    if (statistics.criticalEvents > 0) {
      recommendations.add('Immediate action required: Critical security events detected');
    }
    
    if (statistics.highEvents > 5) {
      recommendations.add('High number of high-severity events: Review security policies');
    }
    
    if (statistics.failedAttempts > 10) {
      recommendations.add('High number of failed attempts: Consider implementing account lockout');
    }
    
    if (statistics.events24h > 50) {
      recommendations.add('High activity in last 24 hours: Monitor for suspicious patterns');
    }
    
    if (recommendations.isEmpty) {
      recommendations.add('Security status is normal');
    }
    
    return recommendations;
  }

  /// Get current alert level
  SecurityAlertLevel get currentAlertLevel => _currentAlertLevel;

  /// Check if service is initialized
  bool get isInitialized => _isInitialized;

  /// Dispose service
  Future<void> dispose() async {
    _stopMonitoring();
    _securityEvents.clear();
    _failedAttempts.clear();
    _lastAttempts.clear();
    _isInitialized = false;
    AppLogger.info('Security Monitoring Service disposed');
  }
}

/// Security alert levels
enum SecurityAlertLevel {
  none,
  low,
  medium,
  high,
  critical,
}

/// Security statistics
class SecurityStatistics {
  final int totalEvents;
  final int events24h;
  final int events7d;
  final int criticalEvents;
  final int highEvents;
  final int mediumEvents;
  final int lowEvents;
  final SecurityAlertLevel currentAlertLevel;
  final DateTime? lastEvent;
  final int failedAttempts;

  const SecurityStatistics({
    required this.totalEvents,
    required this.events24h,
    required this.events7d,
    required this.criticalEvents,
    required this.highEvents,
    required this.mediumEvents,
    required this.lowEvents,
    required this.currentAlertLevel,
    this.lastEvent,
    required this.failedAttempts,
  });

  factory SecurityStatistics.empty() {
    return const SecurityStatistics(
      totalEvents: 0,
      events24h: 0,
      events7d: 0,
      criticalEvents: 0,
      highEvents: 0,
      mediumEvents: 0,
      lowEvents: 0,
      currentAlertLevel: SecurityAlertLevel.none,
      failedAttempts: 0,
    );
  }

  /// Get security score (0-100)
  int get securityScore {
    int score = 100;
    
    // Deduct points for events
    score -= criticalEvents * 20;
    score -= highEvents * 10;
    score -= mediumEvents * 5;
    score -= lowEvents * 1;
    
    // Deduct points for failed attempts
    score -= (failedAttempts * 2).clamp(0, 20);
    
    return score.clamp(0, 100);
  }

  /// Get alert level description
  String get alertLevelDescription {
    switch (currentAlertLevel) {
      case SecurityAlertLevel.none:
        return 'No security alerts';
      case SecurityAlertLevel.low:
        return 'Low security alert';
      case SecurityAlertLevel.medium:
        return 'Medium security alert';
      case SecurityAlertLevel.high:
        return 'High security alert';
      case SecurityAlertLevel.critical:
        return 'Critical security alert';
    }
  }
}

/// Security report
class SecurityReport {
  final SecurityStatistics statistics;
  final List<SecurityEvent> recentEvents;
  final List<String> recommendations;
  final DateTime generatedAt;

  const SecurityReport({
    required this.statistics,
    required this.recentEvents,
    required this.recommendations,
    required this.generatedAt,
  });

  factory SecurityReport.empty() {
    return SecurityReport(
      statistics: SecurityStatistics.empty(),
      recentEvents: [],
      recommendations: [],
      generatedAt: DateTime.now(),
    );
  }
}
