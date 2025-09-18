import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:design_tokens/design_tokens.dart';
import '../services/settings_service.dart';

/// Theme provider for managing app theme
class ThemeNotifier extends StateNotifier<ThemeData> {
  final SettingsService _settingsService;
  bool _isDarkMode = false;
  double _fontSize = 1.0;

  ThemeNotifier(this._settingsService) : super(_buildLightTheme(1.0)) {
    _loadSettings();
  }

  /// Load settings from storage
  Future<void> _loadSettings() async {
    try {
      _isDarkMode = _settingsService.isDarkMode;
      _fontSize = _settingsService.fontSize;
      
      state = _isDarkMode 
          ? _buildDarkTheme(_fontSize)
          : _buildLightTheme(_fontSize);
    } catch (e) {
      // Use default theme if loading fails
      state = _buildLightTheme(1.0);
    }
  }

  /// Toggle dark/light mode
  Future<void> toggleTheme() async {
    try {
      _isDarkMode = !_isDarkMode;
      await _settingsService.setDarkMode(_isDarkMode);
      
      state = _isDarkMode 
          ? _buildDarkTheme(_fontSize)
          : _buildLightTheme(_fontSize);
    } catch (e) {
      // Revert on error
      _isDarkMode = !_isDarkMode;
    }
  }

  /// Set font size
  Future<void> setFontSize(double size) async {
    try {
      _fontSize = size;
      await _settingsService.setFontSize(size);
      
      state = _isDarkMode 
          ? _buildDarkTheme(_fontSize)
          : _buildLightTheme(_fontSize);
    } catch (e) {
      // Revert on error
      _fontSize = 1.0;
    }
  }

  /// Get current theme mode
  bool get isDarkMode => _isDarkMode;

  /// Get current font size
  double get fontSize => _fontSize;

  /// Build light theme
  static ThemeData _buildLightTheme(double fontSize) {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter',
      colorScheme: ColorScheme.fromSeed(
        seedColor: PandoraColors.primary,
        brightness: Brightness.light,
      ),
      textTheme: _buildTextTheme(fontSize, Brightness.light),
      appBarTheme: AppBarTheme(
        backgroundColor: PandoraColors.primary,
        foregroundColor: PandoraColors.onPrimary,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: PandoraColors.primary,
          foregroundColor: PandoraColors.onPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: PandoraColors.primary,
        foregroundColor: PandoraColors.onPrimary,
      ),
    );
  }

  /// Build dark theme
  static ThemeData _buildDarkTheme(double fontSize) {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter',
      colorScheme: ColorScheme.fromSeed(
        seedColor: PandoraColors.primary,
        brightness: Brightness.dark,
      ),
      textTheme: _buildTextTheme(fontSize, Brightness.dark),
      appBarTheme: AppBarTheme(
        backgroundColor: PandoraColors.primary,
        foregroundColor: PandoraColors.onPrimary,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: PandoraColors.primary,
          foregroundColor: PandoraColors.onPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: PandoraColors.primary,
        foregroundColor: PandoraColors.onPrimary,
      ),
    );
  }

  /// Build text theme with custom font size
  static TextTheme _buildTextTheme(double fontSize, Brightness brightness) {
    // Note: baseTextTheme is kept for future use when implementing different themes
    // ignore: unused_local_variable
    final baseTextTheme = brightness == Brightness.light
        ? PandoraTextStyles.bodyMedium
        : PandoraTextStyles.bodyMedium;

    return TextTheme(
      displayLarge: PandoraTextStyles.displayLarge.copyWith(
        fontSize: PandoraTextStyles.displayLarge.fontSize! * fontSize,
      ),
      displayMedium: PandoraTextStyles.displayMedium.copyWith(
        fontSize: PandoraTextStyles.displayMedium.fontSize! * fontSize,
      ),
      displaySmall: PandoraTextStyles.displaySmall.copyWith(
        fontSize: PandoraTextStyles.displaySmall.fontSize! * fontSize,
      ),
      headlineLarge: PandoraTextStyles.headlineLarge.copyWith(
        fontSize: PandoraTextStyles.headlineLarge.fontSize! * fontSize,
      ),
      headlineMedium: PandoraTextStyles.headlineMedium.copyWith(
        fontSize: PandoraTextStyles.headlineMedium.fontSize! * fontSize,
      ),
      headlineSmall: PandoraTextStyles.headlineSmall.copyWith(
        fontSize: PandoraTextStyles.headlineSmall.fontSize! * fontSize,
      ),
      titleLarge: PandoraTextStyles.titleLarge.copyWith(
        fontSize: PandoraTextStyles.titleLarge.fontSize! * fontSize,
      ),
      titleMedium: PandoraTextStyles.titleMedium.copyWith(
        fontSize: PandoraTextStyles.titleMedium.fontSize! * fontSize,
      ),
      titleSmall: PandoraTextStyles.titleSmall.copyWith(
        fontSize: PandoraTextStyles.titleSmall.fontSize! * fontSize,
      ),
      bodyLarge: PandoraTextStyles.bodyLarge.copyWith(
        fontSize: PandoraTextStyles.bodyLarge.fontSize! * fontSize,
      ),
      bodyMedium: PandoraTextStyles.bodyMedium.copyWith(
        fontSize: PandoraTextStyles.bodyMedium.fontSize! * fontSize,
      ),
      bodySmall: PandoraTextStyles.bodySmall.copyWith(
        fontSize: PandoraTextStyles.bodySmall.fontSize! * fontSize,
      ),
      labelLarge: PandoraTextStyles.labelLarge.copyWith(
        fontSize: PandoraTextStyles.labelLarge.fontSize! * fontSize,
      ),
      labelMedium: PandoraTextStyles.labelMedium.copyWith(
        fontSize: PandoraTextStyles.labelMedium.fontSize! * fontSize,
      ),
      labelSmall: PandoraTextStyles.labelSmall.copyWith(
        fontSize: PandoraTextStyles.labelSmall.fontSize! * fontSize,
      ),
    );
  }
}

/// Theme provider
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier(SettingsService());
});
