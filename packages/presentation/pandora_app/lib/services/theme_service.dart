import 'package:flutter/material.dart';
import 'package:ai_domain/ai_domain.dart';
import 'package:core_utils/core_utils.dart';

/// Service for theme management and customization
class ThemeService {
  static final ThemeService _instance = ThemeService._internal();
  factory ThemeService() => _instance;
  ThemeService._internal();

  bool _isInitialized = false;
  ThemeConfig _currentConfig = ThemeConfig.defaultConfig;
  final List<ThemeConfig> _customThemes = [];
  final Map<String, ThemeConfig> _themePresets = {};

  /// Initialize theme service
  Future<bool> initialize() async {
    try {
      AppLogger.info('Initializing Theme Service...');
      
      // Load theme configuration
      await _loadThemeConfig();
      
      // Initialize theme presets
      _initializeThemePresets();
      
      _isInitialized = true;
      AppLogger.success('Theme Service initialized successfully');
      return true;
    } catch (e) {
      AppLogger.error('Failed to initialize Theme Service', e);
      return false;
    }
  }

  /// Load theme configuration
  Future<void> _loadThemeConfig() async {
    try {
      // TODO: Load from secure storage
      _currentConfig = ThemeConfig.defaultConfig;
      AppLogger.info('Theme configuration loaded');
    } catch (e) {
      AppLogger.error('Failed to load theme configuration', e);
    }
  }

  /// Initialize theme presets
  void _initializeThemePresets() {
    _themePresets['light'] = ThemeConfig.lightConfig;
    _themePresets['dark'] = ThemeConfig.darkConfig;
    _themePresets['high_contrast'] = ThemeConfig.highContrastConfig;
    _themePresets['compact'] = ThemeConfig.compactConfig;
    _themePresets['accessibility'] = ThemeConfig.accessibilityConfig;
    
    AppLogger.info('Theme presets initialized: ${_themePresets.length}');
  }

  /// Get current theme configuration
  ThemeConfig get currentConfig => _currentConfig;

  /// Update theme configuration
  Future<void> updateConfig(ThemeConfig newConfig) async {
    try {
      AppLogger.info('Updating theme configuration');
      
      _currentConfig = newConfig;
      await _saveThemeConfig();
      
      AppLogger.success('Theme configuration updated');
    } catch (e) {
      AppLogger.error('Failed to update theme configuration', e);
    }
  }

  /// Set theme mode
  Future<void> setThemeMode(ThemeMode mode) async {
    try {
      AppLogger.info('Setting theme mode: ${mode.name}');
      
      _currentConfig = _currentConfig.copyWith(themeMode: mode);
      await _saveThemeConfig();
      
      AppLogger.success('Theme mode set to: ${mode.name}');
    } catch (e) {
      AppLogger.error('Failed to set theme mode', e);
    }
  }

  /// Set Pandora theme
  Future<void> setPandoraTheme(PandoraTheme theme) async {
    try {
      AppLogger.info('Setting Pandora theme: ${theme.displayName}');
      
      _currentConfig = _currentConfig.copyWith(pandoraTheme: theme);
      await _saveThemeConfig();
      
      AppLogger.success('Pandora theme set to: ${theme.displayName}');
    } catch (e) {
      AppLogger.error('Failed to set Pandora theme', e);
    }
  }

  /// Set font size
  Future<void> setFontSize(double size) async {
    try {
      AppLogger.info('Setting font size: $size');
      
      _currentConfig = _currentConfig.copyWith(fontSize: size);
      await _saveThemeConfig();
      
      AppLogger.success('Font size set to: $size');
    } catch (e) {
      AppLogger.error('Failed to set font size', e);
    }
  }

  /// Set font scale
  Future<void> setFontScale(double scale) async {
    try {
      AppLogger.info('Setting font scale: $scale');
      
      _currentConfig = _currentConfig.copyWith(fontScale: scale);
      await _saveThemeConfig();
      
      AppLogger.success('Font scale set to: $scale');
    } catch (e) {
      AppLogger.error('Failed to set font scale', e);
    }
  }

  /// Set accessibility level
  Future<void> setAccessibilityLevel(AccessibilityLevel level) async {
    try {
      AppLogger.info('Setting accessibility level: ${level.displayName}');
      
      _currentConfig = _currentConfig.copyWith(accessibilityLevel: level);
      await _saveThemeConfig();
      
      AppLogger.success('Accessibility level set to: ${level.displayName}');
    } catch (e) {
      AppLogger.error('Failed to set accessibility level', e);
    }
  }

  /// Set contrast level
  Future<void> setContrastLevel(ContrastLevel level) async {
    try {
      AppLogger.info('Setting contrast level: ${level.displayName}');
      
      _currentConfig = _currentConfig.copyWith(contrastLevel: level);
      await _saveThemeConfig();
      
      AppLogger.success('Contrast level set to: ${level.displayName}');
    } catch (e) {
      AppLogger.error('Failed to set contrast level', e);
    }
  }

  /// Set size class
  Future<void> setSizeClass(SizeClass sizeClass) async {
    try {
      AppLogger.info('Setting size class: ${sizeClass.displayName}');
      
      _currentConfig = _currentConfig.copyWith(sizeClass: sizeClass);
      await _saveThemeConfig();
      
      AppLogger.success('Size class set to: ${sizeClass.displayName}');
    } catch (e) {
      AppLogger.error('Failed to set size class', e);
    }
  }

  /// Toggle animations
  Future<void> toggleAnimations() async {
    try {
      AppLogger.info('Toggling animations');
      
      _currentConfig = _currentConfig.copyWith(
        enableAnimations: !_currentConfig.enableAnimations,
      );
      await _saveThemeConfig();
      
      AppLogger.success('Animations ${_currentConfig.enableAnimations ? 'enabled' : 'disabled'}');
    } catch (e) {
      AppLogger.error('Failed to toggle animations', e);
    }
  }

  /// Toggle haptic feedback
  Future<void> toggleHapticFeedback() async {
    try {
      AppLogger.info('Toggling haptic feedback');
      
      _currentConfig = _currentConfig.copyWith(
        enableHapticFeedback: !_currentConfig.enableHapticFeedback,
      );
      await _saveThemeConfig();
      
      AppLogger.success('Haptic feedback ${_currentConfig.enableHapticFeedback ? 'enabled' : 'disabled'}');
    } catch (e) {
      AppLogger.error('Failed to toggle haptic feedback', e);
    }
  }

  /// Toggle sound effects
  Future<void> toggleSoundEffects() async {
    try {
      AppLogger.info('Toggling sound effects');
      
      _currentConfig = _currentConfig.copyWith(
        enableSoundEffects: !_currentConfig.enableSoundEffects,
      );
      await _saveThemeConfig();
      
      AppLogger.success('Sound effects ${_currentConfig.enableSoundEffects ? 'enabled' : 'disabled'}');
    } catch (e) {
      AppLogger.error('Failed to toggle sound effects', e);
    }
  }

  /// Apply theme preset
  Future<void> applyPreset(String presetName) async {
    try {
      AppLogger.info('Applying theme preset: $presetName');
      
      final preset = _themePresets[presetName];
      if (preset == null) {
        throw Exception('Theme preset not found: $presetName');
      }
      
      _currentConfig = preset;
      await _saveThemeConfig();
      
      AppLogger.success('Theme preset applied: $presetName');
    } catch (e) {
      AppLogger.error('Failed to apply theme preset', e);
    }
  }

  /// Create custom theme
  Future<void> createCustomTheme(String name, ThemeConfig config) async {
    try {
      AppLogger.info('Creating custom theme: $name');
      
      final customConfig = config.copyWith(
        pandoraTheme: PandoraTheme.custom,
      );
      
      _customThemes.add(customConfig);
      _themePresets[name] = customConfig;
      
      await _saveCustomThemes();
      
      AppLogger.success('Custom theme created: $name');
    } catch (e) {
      AppLogger.error('Failed to create custom theme', e);
    }
  }

  /// Delete custom theme
  Future<void> deleteCustomTheme(String name) async {
    try {
      AppLogger.info('Deleting custom theme: $name');
      
      _customThemes.removeWhere((theme) => theme.pandoraTheme == PandoraTheme.custom);
      _themePresets.remove(name);
      
      await _saveCustomThemes();
      
      AppLogger.success('Custom theme deleted: $name');
    } catch (e) {
      AppLogger.error('Failed to delete custom theme', e);
    }
  }

  /// Get theme presets
  Map<String, ThemeConfig> get themePresets => Map.unmodifiable(_themePresets);

  /// Get custom themes
  List<ThemeConfig> get customThemes => List.unmodifiable(_customThemes);

  /// Get theme by name
  ThemeConfig? getThemeByName(String name) {
    return _themePresets[name];
  }

  /// Check if theme is custom
  bool isCustomTheme(String name) {
    final theme = _themePresets[name];
    return theme?.pandoraTheme == PandoraTheme.custom;
  }

  /// Get theme statistics
  ThemeStatistics getThemeStatistics() {
    try {
      AppLogger.info('Getting theme statistics');
      
      final statistics = ThemeStatistics(
        totalThemes: _themePresets.length,
        customThemes: _customThemes.length,
        presetThemes: _themePresets.length - _customThemes.length,
        currentTheme: _currentConfig.pandoraTheme.displayName,
        currentMode: _currentConfig.themeMode.name,
        fontSize: _currentConfig.effectiveFontSize,
        accessibilityLevel: _currentConfig.accessibilityLevel.displayName,
        contrastLevel: _currentConfig.contrastLevel.displayName,
        sizeClass: _currentConfig.sizeClass.displayName,
        animationsEnabled: _currentConfig.enableAnimations,
        hapticFeedbackEnabled: _currentConfig.enableHapticFeedback,
        soundEffectsEnabled: _currentConfig.enableSoundEffects,
      );
      
      AppLogger.success('Theme statistics retrieved');
      return statistics;
    } catch (e) {
      AppLogger.error('Failed to get theme statistics', e);
      return ThemeStatistics.empty();
    }
  }

  /// Reset to default theme
  Future<void> resetToDefault() async {
    try {
      AppLogger.info('Resetting to default theme');
      
      _currentConfig = ThemeConfig.defaultConfig;
      await _saveThemeConfig();
      
      AppLogger.success('Theme reset to default');
    } catch (e) {
      AppLogger.error('Failed to reset theme', e);
    }
  }

  /// Save theme configuration
  Future<void> _saveThemeConfig() async {
    try {
      // TODO: Save to secure storage
      AppLogger.info('Theme configuration saved');
    } catch (e) {
      AppLogger.error('Failed to save theme configuration', e);
    }
  }

  /// Save custom themes
  Future<void> _saveCustomThemes() async {
    try {
      // TODO: Save custom themes to storage
      AppLogger.info('Custom themes saved');
    } catch (e) {
      AppLogger.error('Failed to save custom themes', e);
    }
  }

  /// Check if service is initialized
  bool get isInitialized => _isInitialized;

  /// Dispose service
  Future<void> dispose() async {
    _customThemes.clear();
    _themePresets.clear();
    _isInitialized = false;
    AppLogger.info('Theme Service disposed');
  }
}

/// Theme statistics
class ThemeStatistics {
  final int totalThemes;
  final int customThemes;
  final int presetThemes;
  final String currentTheme;
  final String currentMode;
  final double fontSize;
  final String accessibilityLevel;
  final String contrastLevel;
  final String sizeClass;
  final bool animationsEnabled;
  final bool hapticFeedbackEnabled;
  final bool soundEffectsEnabled;

  const ThemeStatistics({
    required this.totalThemes,
    required this.customThemes,
    required this.presetThemes,
    required this.currentTheme,
    required this.currentMode,
    required this.fontSize,
    required this.accessibilityLevel,
    required this.contrastLevel,
    required this.sizeClass,
    required this.animationsEnabled,
    required this.hapticFeedbackEnabled,
    required this.soundEffectsEnabled,
  });

  factory ThemeStatistics.empty() {
    return const ThemeStatistics(
      totalThemes: 0,
      customThemes: 0,
      presetThemes: 0,
      currentTheme: 'Unknown',
      currentMode: 'system',
      fontSize: 14.0,
      accessibilityLevel: 'Standard',
      contrastLevel: 'Standard',
      sizeClass: 'Medium',
      animationsEnabled: true,
      hapticFeedbackEnabled: true,
      soundEffectsEnabled: true,
    );
  }

  /// Get theme summary
  String get summary {
    return 'Current: $currentTheme ($currentMode) - $sizeClass, $contrastLevel contrast, ${fontSize.toInt()}px font';
  }
}
