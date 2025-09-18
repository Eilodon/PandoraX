import 'package:flutter/material.dart';
import 'package:ai_domain/ai_domain.dart';
import 'package:core_utils/core_utils.dart';

/// Service for accessibility features and support
class AccessibilityService {
  static final AccessibilityService _instance = AccessibilityService._internal();
  factory AccessibilityService() => _instance;
  AccessibilityService._internal();

  bool _isInitialized = false;
  AccessibilityConfig _config = AccessibilityConfig.defaultConfig;
  final List<AccessibilityEvent> _accessibilityEvents = [];

  /// Initialize accessibility service
  Future<bool> initialize() async {
    try {
      AppLogger.info('Initializing Accessibility Service...');
      
      // Load accessibility configuration
      await _loadAccessibilityConfig();
      
      // Initialize accessibility features
      await _initializeAccessibilityFeatures();
      
      _isInitialized = true;
      AppLogger.success('Accessibility Service initialized successfully');
      return true;
    } catch (e) {
      AppLogger.error('Failed to initialize Accessibility Service', e);
      return false;
    }
  }

  /// Load accessibility configuration
  Future<void> _loadAccessibilityConfig() async {
    try {
      // TODO: Load from secure storage
      _config = AccessibilityConfig.defaultConfig;
      AppLogger.info('Accessibility configuration loaded');
    } catch (e) {
      AppLogger.error('Failed to load accessibility configuration', e);
    }
  }

  /// Initialize accessibility features
  Future<void> _initializeAccessibilityFeatures() async {
    try {
      // TODO: Initialize platform-specific accessibility features
      AppLogger.info('Accessibility features initialized');
    } catch (e) {
      AppLogger.error('Failed to initialize accessibility features', e);
    }
  }

  /// Get current accessibility configuration
  AccessibilityConfig get config => _config;

  /// Update accessibility configuration
  Future<void> updateConfig(AccessibilityConfig newConfig) async {
    try {
      AppLogger.info('Updating accessibility configuration');
      
      _config = newConfig;
      await _saveAccessibilityConfig();
      
      // Log accessibility event
      await _logAccessibilityEvent(AccessibilityEventType.configChanged);
      
      AppLogger.success('Accessibility configuration updated');
    } catch (e) {
      AppLogger.error('Failed to update accessibility configuration', e);
    }
  }

  /// Enable accessibility feature
  Future<void> enableFeature(AccessibilityFeature feature) async {
    try {
      AppLogger.info('Enabling accessibility feature: ${feature.displayName}');
      
      _config = _config.copyWith(
        enabledFeatures: [..._config.enabledFeatures, feature],
      );
      await _saveAccessibilityConfig();
      
      // Log accessibility event
      await _logAccessibilityEvent(AccessibilityEventType.featureEnabled, 
        metadata: {'feature': feature.name});
      
      AppLogger.success('Accessibility feature enabled: ${feature.displayName}');
    } catch (e) {
      AppLogger.error('Failed to enable accessibility feature', e);
    }
  }

  /// Disable accessibility feature
  Future<void> disableFeature(AccessibilityFeature feature) async {
    try {
      AppLogger.info('Disabling accessibility feature: ${feature.displayName}');
      
      _config = _config.copyWith(
        enabledFeatures: _config.enabledFeatures.where((f) => f != feature).toList(),
      );
      await _saveAccessibilityConfig();
      
      // Log accessibility event
      await _logAccessibilityEvent(AccessibilityEventType.featureDisabled,
        metadata: {'feature': feature.name});
      
      AppLogger.success('Accessibility feature disabled: ${feature.displayName}');
    } catch (e) {
      AppLogger.error('Failed to disable accessibility feature', e);
    }
  }

  /// Check if feature is enabled
  bool isFeatureEnabled(AccessibilityFeature feature) {
    return _config.enabledFeatures.contains(feature);
  }

  /// Set font scale
  Future<void> setFontScale(double scale) async {
    try {
      AppLogger.info('Setting font scale: $scale');
      
      _config = _config.copyWith(fontScale: scale);
      await _saveAccessibilityConfig();
      
      // Log accessibility event
      await _logAccessibilityEvent(AccessibilityEventType.fontScaleChanged,
        metadata: {'scale': scale});
      
      AppLogger.success('Font scale set to: $scale');
    } catch (e) {
      AppLogger.error('Failed to set font scale', e);
    }
  }

  /// Set high contrast mode
  Future<void> setHighContrast(bool enabled) async {
    try {
      AppLogger.info('Setting high contrast mode: $enabled');
      
      _config = _config.copyWith(highContrast: enabled);
      await _saveAccessibilityConfig();
      
      // Log accessibility event
      await _logAccessibilityEvent(AccessibilityEventType.highContrastChanged,
        metadata: {'enabled': enabled});
      
      AppLogger.success('High contrast mode ${enabled ? 'enabled' : 'disabled'}');
    } catch (e) {
      AppLogger.error('Failed to set high contrast mode', e);
    }
  }

  /// Set reduced motion
  Future<void> setReducedMotion(bool enabled) async {
    try {
      AppLogger.info('Setting reduced motion: $enabled');
      
      _config = _config.copyWith(reducedMotion: enabled);
      await _saveAccessibilityConfig();
      
      // Log accessibility event
      await _logAccessibilityEvent(AccessibilityEventType.reducedMotionChanged,
        metadata: {'enabled': enabled});
      
      AppLogger.success('Reduced motion ${enabled ? 'enabled' : 'disabled'}');
    } catch (e) {
      AppLogger.error('Failed to set reduced motion', e);
    }
  }

  /// Set screen reader support
  Future<void> setScreenReaderSupport(bool enabled) async {
    try {
      AppLogger.info('Setting screen reader support: $enabled');
      
      _config = _config.copyWith(screenReaderSupport: enabled);
      await _saveAccessibilityConfig();
      
      // Log accessibility event
      await _logAccessibilityEvent(AccessibilityEventType.screenReaderChanged,
        metadata: {'enabled': enabled});
      
      AppLogger.success('Screen reader support ${enabled ? 'enabled' : 'disabled'}');
    } catch (e) {
      AppLogger.error('Failed to set screen reader support', e);
    }
  }

  /// Set voice guidance
  Future<void> setVoiceGuidance(bool enabled) async {
    try {
      AppLogger.info('Setting voice guidance: $enabled');
      
      _config = _config.copyWith(voiceGuidance: enabled);
      await _saveAccessibilityConfig();
      
      // Log accessibility event
      await _logAccessibilityEvent(AccessibilityEventType.voiceGuidanceChanged,
        metadata: {'enabled': enabled});
      
      AppLogger.success('Voice guidance ${enabled ? 'enabled' : 'disabled'}');
    } catch (e) {
      AppLogger.error('Failed to set voice guidance', e);
    }
  }

  /// Set haptic feedback
  Future<void> setHapticFeedback(bool enabled) async {
    try {
      AppLogger.info('Setting haptic feedback: $enabled');
      
      _config = _config.copyWith(hapticFeedback: enabled);
      await _saveAccessibilityConfig();
      
      // Log accessibility event
      await _logAccessibilityEvent(AccessibilityEventType.hapticFeedbackChanged,
        metadata: {'enabled': enabled});
      
      AppLogger.success('Haptic feedback ${enabled ? 'enabled' : 'disabled'}');
    } catch (e) {
      AppLogger.error('Failed to set haptic feedback', e);
    }
  }

  /// Set large text
  Future<void> setLargeText(bool enabled) async {
    try {
      AppLogger.info('Setting large text: $enabled');
      
      _config = _config.copyWith(largeText: enabled);
      await _saveAccessibilityConfig();
      
      // Log accessibility event
      await _logAccessibilityEvent(AccessibilityEventType.largeTextChanged,
        metadata: {'enabled': enabled});
      
      AppLogger.success('Large text ${enabled ? 'enabled' : 'disabled'}');
    } catch (e) {
      AppLogger.error('Failed to set large text', e);
    }
  }

  /// Set bold text
  Future<void> setBoldText(bool enabled) async {
    try {
      AppLogger.info('Setting bold text: $enabled');
      
      _config = _config.copyWith(boldText: enabled);
      await _saveAccessibilityConfig();
      
      // Log accessibility event
      await _logAccessibilityEvent(AccessibilityEventType.boldTextChanged,
        metadata: {'enabled': enabled});
      
      AppLogger.success('Bold text ${enabled ? 'enabled' : 'disabled'}');
    } catch (e) {
      AppLogger.error('Failed to set bold text', e);
    }
  }

  /// Set color inversion
  Future<void> setColorInversion(bool enabled) async {
    try {
      AppLogger.info('Setting color inversion: $enabled');
      
      _config = _config.copyWith(colorInversion: enabled);
      await _saveAccessibilityConfig();
      
      // Log accessibility event
      await _logAccessibilityEvent(AccessibilityEventType.colorInversionChanged,
        metadata: {'enabled': enabled});
      
      AppLogger.success('Color inversion ${enabled ? 'enabled' : 'disabled'}');
    } catch (e) {
      AppLogger.error('Failed to set color inversion', e);
    }
  }

  /// Set grayscale
  Future<void> setGrayscale(bool enabled) async {
    try {
      AppLogger.info('Setting grayscale: $enabled');
      
      _config = _config.copyWith(grayscale: enabled);
      await _saveAccessibilityConfig();
      
      // Log accessibility event
      await _logAccessibilityEvent(AccessibilityEventType.grayscaleChanged,
        metadata: {'enabled': enabled});
      
      AppLogger.success('Grayscale ${enabled ? 'enabled' : 'disabled'}');
    } catch (e) {
      AppLogger.error('Failed to set grayscale', e);
    }
  }

  /// Get accessibility score
  int getAccessibilityScore() {
    int score = 0;
    
    // Base score
    score += 20;
    
    // Feature scores
    if (_config.highContrast) score += 15;
    if (_config.screenReaderSupport) score += 20;
    if (_config.voiceGuidance) score += 15;
    if (_config.hapticFeedback) score += 10;
    if (_config.largeText) score += 10;
    if (_config.boldText) score += 5;
    if (_config.colorInversion) score += 5;
    if (_config.grayscale) score += 5;
    
    // Font scale bonus
    if (_config.fontScale >= 1.2) score += 10;
    if (_config.fontScale >= 1.5) score += 5;
    
    // Reduced motion bonus
    if (_config.reducedMotion) score += 5;
    
    return score.clamp(0, 100);
  }

  /// Get accessibility level
  AccessibilityLevel getAccessibilityLevel() {
    final score = getAccessibilityScore();
    
    if (score >= 90) return AccessibilityLevel.maximum;
    if (score >= 70) return AccessibilityLevel.high;
    if (score >= 50) return AccessibilityLevel.standard;
    return AccessibilityLevel.minimal;
  }

  /// Get accessibility report
  AccessibilityReport getAccessibilityReport() {
    try {
      AppLogger.info('Generating accessibility report');
      
      final report = AccessibilityReport(
        score: getAccessibilityScore(),
        level: getAccessibilityLevel(),
        enabledFeatures: _config.enabledFeatures,
        fontScale: _config.fontScale,
        highContrast: _config.highContrast,
        reducedMotion: _config.reducedMotion,
        screenReaderSupport: _config.screenReaderSupport,
        voiceGuidance: _config.voiceGuidance,
        hapticFeedback: _config.hapticFeedback,
        largeText: _config.largeText,
        boldText: _config.boldText,
        colorInversion: _config.colorInversion,
        grayscale: _config.grayscale,
        recommendations: _generateRecommendations(),
        lastUpdated: DateTime.now(),
      );
      
      AppLogger.success('Accessibility report generated');
      return report;
    } catch (e) {
      AppLogger.error('Failed to generate accessibility report', e);
      return AccessibilityReport.empty();
    }
  }

  /// Generate accessibility recommendations
  List<String> _generateRecommendations() {
    final recommendations = <String>[];
    
    if (!_config.highContrast) {
      recommendations.add('Enable high contrast mode for better visibility');
    }
    
    if (!_config.screenReaderSupport) {
      recommendations.add('Enable screen reader support for better accessibility');
    }
    
    if (!_config.voiceGuidance) {
      recommendations.add('Enable voice guidance for audio assistance');
    }
    
    if (!_config.hapticFeedback) {
      recommendations.add('Enable haptic feedback for tactile feedback');
    }
    
    if (_config.fontScale < 1.2) {
      recommendations.add('Increase font scale for better readability');
    }
    
    if (!_config.largeText) {
      recommendations.add('Enable large text for better readability');
    }
    
    if (!_config.boldText) {
      recommendations.add('Enable bold text for better text visibility');
    }
    
    if (recommendations.isEmpty) {
      recommendations.add('Accessibility settings are well configured');
    }
    
    return recommendations;
  }

  /// Log accessibility event
  Future<void> _logAccessibilityEvent(
    AccessibilityEventType type, {
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final event = AccessibilityEvent(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: type,
        timestamp: DateTime.now(),
        userId: 'current_user', // TODO: Get actual user ID
        description: _getEventDescription(type),
        metadata: metadata,
        severity: _getEventSeverity(type),
      );
      
      _accessibilityEvents.add(event);
      
      // Keep only last 1000 events
      if (_accessibilityEvents.length > 1000) {
        _accessibilityEvents.removeAt(0);
      }
      
      AppLogger.info('Accessibility event logged: ${type.name}');
    } catch (e) {
      AppLogger.error('Failed to log accessibility event', e);
    }
  }

  /// Get event description
  String _getEventDescription(AccessibilityEventType type) {
    switch (type) {
      case AccessibilityEventType.configChanged:
        return 'Accessibility configuration changed';
      case AccessibilityEventType.featureEnabled:
        return 'Accessibility feature enabled';
      case AccessibilityEventType.featureDisabled:
        return 'Accessibility feature disabled';
      case AccessibilityEventType.fontScaleChanged:
        return 'Font scale changed';
      case AccessibilityEventType.highContrastChanged:
        return 'High contrast mode changed';
      case AccessibilityEventType.reducedMotionChanged:
        return 'Reduced motion setting changed';
      case AccessibilityEventType.screenReaderChanged:
        return 'Screen reader support changed';
      case AccessibilityEventType.voiceGuidanceChanged:
        return 'Voice guidance setting changed';
      case AccessibilityEventType.hapticFeedbackChanged:
        return 'Haptic feedback setting changed';
      case AccessibilityEventType.largeTextChanged:
        return 'Large text setting changed';
      case AccessibilityEventType.boldTextChanged:
        return 'Bold text setting changed';
      case AccessibilityEventType.colorInversionChanged:
        return 'Color inversion setting changed';
      case AccessibilityEventType.grayscaleChanged:
        return 'Grayscale setting changed';
    }
  }

  /// Get event severity
  AccessibilitySeverity _getEventSeverity(AccessibilityEventType type) {
    switch (type) {
      case AccessibilityEventType.configChanged:
        return AccessibilitySeverity.medium;
      case AccessibilityEventType.featureEnabled:
        return AccessibilitySeverity.low;
      case AccessibilityEventType.featureDisabled:
        return AccessibilitySeverity.medium;
      case AccessibilityEventType.fontScaleChanged:
        return AccessibilitySeverity.low;
      case AccessibilityEventType.highContrastChanged:
        return AccessibilitySeverity.medium;
      case AccessibilityEventType.reducedMotionChanged:
        return AccessibilitySeverity.low;
      case AccessibilityEventType.screenReaderChanged:
        return AccessibilitySeverity.high;
      case AccessibilityEventType.voiceGuidanceChanged:
        return AccessibilitySeverity.medium;
      case AccessibilityEventType.hapticFeedbackChanged:
        return AccessibilitySeverity.low;
      case AccessibilityEventType.largeTextChanged:
        return AccessibilitySeverity.low;
      case AccessibilityEventType.boldTextChanged:
        return AccessibilitySeverity.low;
      case AccessibilityEventType.colorInversionChanged:
        return AccessibilitySeverity.low;
      case AccessibilityEventType.grayscaleChanged:
        return AccessibilitySeverity.low;
    }
  }

  /// Save accessibility configuration
  Future<void> _saveAccessibilityConfig() async {
    try {
      // TODO: Save to secure storage
      AppLogger.info('Accessibility configuration saved');
    } catch (e) {
      AppLogger.error('Failed to save accessibility configuration', e);
    }
  }

  /// Get accessibility events
  List<AccessibilityEvent> getAccessibilityEvents({
    AccessibilityEventType? type,
    AccessibilitySeverity? severity,
    DateTime? since,
    int? limit,
  }) {
    try {
      var events = _accessibilityEvents;
      
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
      AppLogger.error('Failed to get accessibility events', e);
      return [];
    }
  }

  /// Check if service is initialized
  bool get isInitialized => _isInitialized;

  /// Dispose service
  Future<void> dispose() async {
    _accessibilityEvents.clear();
    _isInitialized = false;
    AppLogger.info('Accessibility Service disposed');
  }
}

/// Accessibility configuration
class AccessibilityConfig {
  final List<AccessibilityFeature> enabledFeatures;
  final double fontScale;
  final bool highContrast;
  final bool reducedMotion;
  final bool screenReaderSupport;
  final bool voiceGuidance;
  final bool hapticFeedback;
  final bool largeText;
  final bool boldText;
  final bool colorInversion;
  final bool grayscale;
  final Map<String, dynamic>? customSettings;

  const AccessibilityConfig({
    this.enabledFeatures = const [],
    this.fontScale = 1.0,
    this.highContrast = false,
    this.reducedMotion = false,
    this.screenReaderSupport = false,
    this.voiceGuidance = false,
    this.hapticFeedback = true,
    this.largeText = false,
    this.boldText = false,
    this.colorInversion = false,
    this.grayscale = false,
    this.customSettings,
  });

  factory AccessibilityConfig.defaultConfig() => const AccessibilityConfig();

  factory AccessibilityConfig.highAccessibility() => const AccessibilityConfig(
    enabledFeatures: [
      AccessibilityFeature.highContrast,
      AccessibilityFeature.screenReader,
      AccessibilityFeature.voiceGuidance,
      AccessibilityFeature.hapticFeedback,
      AccessibilityFeature.largeText,
      AccessibilityFeature.boldText,
    ],
    fontScale: 1.5,
    highContrast: true,
    reducedMotion: true,
    screenReaderSupport: true,
    voiceGuidance: true,
    hapticFeedback: true,
    largeText: true,
    boldText: true,
  );

  AccessibilityConfig copyWith({
    List<AccessibilityFeature>? enabledFeatures,
    double? fontScale,
    bool? highContrast,
    bool? reducedMotion,
    bool? screenReaderSupport,
    bool? voiceGuidance,
    bool? hapticFeedback,
    bool? largeText,
    bool? boldText,
    bool? colorInversion,
    bool? grayscale,
    Map<String, dynamic>? customSettings,
  }) {
    return AccessibilityConfig(
      enabledFeatures: enabledFeatures ?? this.enabledFeatures,
      fontScale: fontScale ?? this.fontScale,
      highContrast: highContrast ?? this.highContrast,
      reducedMotion: reducedMotion ?? this.reducedMotion,
      screenReaderSupport: screenReaderSupport ?? this.screenReaderSupport,
      voiceGuidance: voiceGuidance ?? this.voiceGuidance,
      hapticFeedback: hapticFeedback ?? this.hapticFeedback,
      largeText: largeText ?? this.largeText,
      boldText: boldText ?? this.boldText,
      colorInversion: colorInversion ?? this.colorInversion,
      grayscale: grayscale ?? this.grayscale,
      customSettings: customSettings ?? this.customSettings,
    );
  }
}

/// Accessibility features
enum AccessibilityFeature {
  highContrast,
  screenReader,
  voiceGuidance,
  hapticFeedback,
  largeText,
  boldText,
  colorInversion,
  grayscale,
  reducedMotion,
  keyboardNavigation,
  focusIndicators,
  alternativeText,
}

/// Accessibility event types
enum AccessibilityEventType {
  configChanged,
  featureEnabled,
  featureDisabled,
  fontScaleChanged,
  highContrastChanged,
  reducedMotionChanged,
  screenReaderChanged,
  voiceGuidanceChanged,
  hapticFeedbackChanged,
  largeTextChanged,
  boldTextChanged,
  colorInversionChanged,
  grayscaleChanged,
}

/// Accessibility event
class AccessibilityEvent {
  final String id;
  final AccessibilityEventType type;
  final DateTime timestamp;
  final String userId;
  final String? description;
  final Map<String, dynamic>? metadata;
  final AccessibilitySeverity severity;

  const AccessibilityEvent({
    required this.id,
    required this.type,
    required this.timestamp,
    required this.userId,
    this.description,
    this.metadata,
    required this.severity,
  });
}

/// Accessibility severity levels
enum AccessibilitySeverity {
  low,
  medium,
  high,
  critical,
}

/// Accessibility report
class AccessibilityReport {
  final int score;
  final AccessibilityLevel level;
  final List<AccessibilityFeature> enabledFeatures;
  final double fontScale;
  final bool highContrast;
  final bool reducedMotion;
  final bool screenReaderSupport;
  final bool voiceGuidance;
  final bool hapticFeedback;
  final bool largeText;
  final bool boldText;
  final bool colorInversion;
  final bool grayscale;
  final List<String> recommendations;
  final DateTime lastUpdated;

  const AccessibilityReport({
    required this.score,
    required this.level,
    required this.enabledFeatures,
    required this.fontScale,
    required this.highContrast,
    required this.reducedMotion,
    required this.screenReaderSupport,
    required this.voiceGuidance,
    required this.hapticFeedback,
    required this.largeText,
    required this.boldText,
    required this.colorInversion,
    required this.grayscale,
    required this.recommendations,
    required this.lastUpdated,
  });

  factory AccessibilityReport.empty() {
    return AccessibilityReport(
      score: 0,
      level: AccessibilityLevel.minimal,
      enabledFeatures: [],
      fontScale: 1.0,
      highContrast: false,
      reducedMotion: false,
      screenReaderSupport: false,
      voiceGuidance: false,
      hapticFeedback: false,
      largeText: false,
      boldText: false,
      colorInversion: false,
      grayscale: false,
      recommendations: [],
      lastUpdated: DateTime.now(),
    );
  }
}

/// Extension for AccessibilityFeature
extension AccessibilityFeatureExtension on AccessibilityFeature {
  String get displayName {
    switch (this) {
      case AccessibilityFeature.highContrast:
        return 'High Contrast';
      case AccessibilityFeature.screenReader:
        return 'Screen Reader';
      case AccessibilityFeature.voiceGuidance:
        return 'Voice Guidance';
      case AccessibilityFeature.hapticFeedback:
        return 'Haptic Feedback';
      case AccessibilityFeature.largeText:
        return 'Large Text';
      case AccessibilityFeature.boldText:
        return 'Bold Text';
      case AccessibilityFeature.colorInversion:
        return 'Color Inversion';
      case AccessibilityFeature.grayscale:
        return 'Grayscale';
      case AccessibilityFeature.reducedMotion:
        return 'Reduced Motion';
      case AccessibilityFeature.keyboardNavigation:
        return 'Keyboard Navigation';
      case AccessibilityFeature.focusIndicators:
        return 'Focus Indicators';
      case AccessibilityFeature.alternativeText:
        return 'Alternative Text';
    }
  }

  String get icon {
    switch (this) {
      case AccessibilityFeature.highContrast:
        return '🔆';
      case AccessibilityFeature.screenReader:
        return '📢';
      case AccessibilityFeature.voiceGuidance:
        return '🎤';
      case AccessibilityFeature.hapticFeedback:
        return '📳';
      case AccessibilityFeature.largeText:
        return '🔍';
      case AccessibilityFeature.boldText:
        return 'B';
      case AccessibilityFeature.colorInversion:
        return '🔄';
      case AccessibilityFeature.grayscale:
        return '⚫';
      case AccessibilityFeature.reducedMotion:
        return '⏸️';
      case AccessibilityFeature.keyboardNavigation:
        return '⌨️';
      case AccessibilityFeature.focusIndicators:
        return '🎯';
      case AccessibilityFeature.alternativeText:
        return '📝';
    }
  }

  String get description {
    switch (this) {
      case AccessibilityFeature.highContrast:
        return 'Increases contrast for better visibility';
      case AccessibilityFeature.screenReader:
        return 'Provides screen reader support';
      case AccessibilityFeature.voiceGuidance:
        return 'Provides audio guidance and feedback';
      case AccessibilityFeature.hapticFeedback:
        return 'Provides tactile feedback through vibrations';
      case AccessibilityFeature.largeText:
        return 'Increases text size for better readability';
      case AccessibilityFeature.boldText:
        return 'Makes text bold for better visibility';
      case AccessibilityFeature.colorInversion:
        return 'Inverts colors for better visibility';
      case AccessibilityFeature.grayscale:
        return 'Converts colors to grayscale';
      case AccessibilityFeature.reducedMotion:
        return 'Reduces animations and motion effects';
      case AccessibilityFeature.keyboardNavigation:
        return 'Enables keyboard navigation support';
      case AccessibilityFeature.focusIndicators:
        return 'Shows focus indicators for navigation';
      case AccessibilityFeature.alternativeText:
        return 'Provides alternative text for images';
    }
  }
}
