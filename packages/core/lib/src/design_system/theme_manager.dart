/// Theme Manager for Phase 4 Architecture
/// 
/// This file provides a centralized theme management system
/// with support for light/dark modes and custom themes.
library theme_manager;

import 'package:flutter/material.dart';
import 'design_tokens.dart';

/// Theme Manager for managing app themes
class ThemeManager {
  static ThemeManager? _instance;
  static ThemeManager get instance => _instance ??= ThemeManager._();
  
  ThemeManager._();
  
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  
  /// Toggle between light and dark mode
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
  }
  
  /// Set theme mode
  void setThemeMode(bool isDark) {
    _isDarkMode = isDark;
  }
  
  /// Get current theme
  ThemeData get currentTheme => _isDarkMode ? darkTheme : lightTheme;
  
  /// Get current color scheme
  ColorScheme get currentColorScheme => _isDarkMode ? darkColorScheme : lightColorScheme;
  
  /// Light theme
  ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    textTheme: lightTextTheme,
    appBarTheme: lightAppBarTheme,
    cardTheme: lightCardTheme,
    elevatedButtonTheme: lightElevatedButtonTheme,
    textButtonTheme: lightTextButtonTheme,
    outlinedButtonTheme: lightOutlinedButtonTheme,
    inputDecorationTheme: lightInputDecorationTheme,
    bottomNavigationBarTheme: lightBottomNavigationBarTheme,
    floatingActionButtonTheme: lightFloatingActionButtonTheme,
    snackBarTheme: lightSnackBarTheme,
    dividerTheme: lightDividerTheme,
    iconTheme: lightIconTheme,
    primaryIconTheme: lightIconTheme,
    scaffoldBackgroundColor: DesignTokens.backgroundLight,
  );
  
  /// Dark theme
  ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    textTheme: darkTextTheme,
    appBarTheme: darkAppBarTheme,
    cardTheme: darkCardTheme,
    elevatedButtonTheme: darkElevatedButtonTheme,
    textButtonTheme: darkTextButtonTheme,
    outlinedButtonTheme: darkOutlinedButtonTheme,
    inputDecorationTheme: darkInputDecorationTheme,
    bottomNavigationBarTheme: darkBottomNavigationBarTheme,
    floatingActionButtonTheme: darkFloatingActionButtonTheme,
    snackBarTheme: darkSnackBarTheme,
    dividerTheme: darkDividerTheme,
    iconTheme: darkIconTheme,
    primaryIconTheme: darkIconTheme,
    scaffoldBackgroundColor: DesignTokens.backgroundDark,
  );
  
  // ============================================================================
  // COLOR SCHEMES
  // ============================================================================
  
  /// Light color scheme
  ColorScheme get lightColorScheme => const ColorScheme.light(
    primary: DesignTokens.primary,
    onPrimary: Colors.white,
    primaryContainer: DesignTokens.primaryLight,
    onPrimaryContainer: DesignTokens.neutral900,
    secondary: DesignTokens.secondary,
    onSecondary: Colors.white,
    secondaryContainer: DesignTokens.secondaryLight,
    onSecondaryContainer: DesignTokens.neutral900,
    tertiary: DesignTokens.info,
    onTertiary: Colors.white,
    error: DesignTokens.error,
    onError: Colors.white,
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),
    background: DesignTokens.backgroundLight,
    onBackground: DesignTokens.neutral900,
    surface: DesignTokens.surfaceLight,
    onSurface: DesignTokens.neutral900,
    surfaceVariant: DesignTokens.neutral100,
    onSurfaceVariant: DesignTokens.neutral600,
    outline: DesignTokens.neutral300,
    outlineVariant: DesignTokens.neutral200,
    shadow: DesignTokens.neutral900,
    scrim: DesignTokens.neutral900,
    inverseSurface: DesignTokens.neutral800,
    onInverseSurface: DesignTokens.neutral100,
    inversePrimary: DesignTokens.primaryLight,
    surfaceTint: DesignTokens.primary,
  );
  
  /// Dark color scheme
  ColorScheme get darkColorScheme => const ColorScheme.dark(
    primary: DesignTokens.primaryLight,
    onPrimary: DesignTokens.neutral900,
    primaryContainer: DesignTokens.primary,
    onPrimaryContainer: Colors.white,
    secondary: DesignTokens.secondaryLight,
    onSecondary: DesignTokens.neutral900,
    secondaryContainer: DesignTokens.secondary,
    onSecondaryContainer: Colors.white,
    tertiary: DesignTokens.info,
    onTertiary: DesignTokens.neutral900,
    error: DesignTokens.error,
    onError: Colors.white,
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),
    background: DesignTokens.backgroundDark,
    onBackground: DesignTokens.neutral100,
    surface: DesignTokens.surfaceDark,
    onSurface: DesignTokens.neutral100,
    surfaceVariant: DesignTokens.neutral700,
    onSurfaceVariant: DesignTokens.neutral300,
    outline: DesignTokens.neutral600,
    outlineVariant: DesignTokens.neutral700,
    shadow: DesignTokens.neutral900,
    scrim: DesignTokens.neutral900,
    inverseSurface: DesignTokens.neutral100,
    onInverseSurface: DesignTokens.neutral800,
    inversePrimary: DesignTokens.primary,
    surfaceTint: DesignTokens.primaryLight,
  );
  
  // ============================================================================
  // TEXT THEMES
  // ============================================================================
  
  /// Light text theme
  TextTheme get lightTextTheme => const TextTheme(
    displayLarge: TextStyle(
      fontFamily: DesignTokens.fontFamily,
      fontSize: DesignTokens.fontSize5Xl,
      fontWeight: DesignTokens.fontWeightBold,
      color: DesignTokens.neutral900,
      height: DesignTokens.lineHeightTight,
    ),
    displayMedium: TextStyle(
      fontFamily: DesignTokens.fontFamily,
      fontSize: DesignTokens.fontSize4Xl,
      fontWeight: DesignTokens.fontWeightBold,
      color: DesignTokens.neutral900,
      height: DesignTokens.lineHeightTight,
    ),
    displaySmall: TextStyle(
      fontFamily: DesignTokens.fontFamily,
      fontSize: DesignTokens.fontSize3Xl,
      fontWeight: DesignTokens.fontWeightBold,
      color: DesignTokens.neutral900,
      height: DesignTokens.lineHeightTight,
    ),
    headlineLarge: TextStyle(
      fontFamily: DesignTokens.fontFamily,
      fontSize: DesignTokens.fontSize2Xl,
      fontWeight: DesignTokens.fontWeightSemiBold,
      color: DesignTokens.neutral900,
      height: DesignTokens.lineHeightTight,
    ),
    headlineMedium: TextStyle(
      fontFamily: DesignTokens.fontFamily,
      fontSize: DesignTokens.fontSizeXl,
      fontWeight: DesignTokens.fontWeightSemiBold,
      color: DesignTokens.neutral900,
      height: DesignTokens.lineHeightTight,
    ),
    headlineSmall: TextStyle(
      fontFamily: DesignTokens.fontFamily,
      fontSize: DesignTokens.fontSizeLg,
      fontWeight: DesignTokens.fontWeightSemiBold,
      color: DesignTokens.neutral900,
      height: DesignTokens.lineHeightTight,
    ),
    titleLarge: TextStyle(
      fontFamily: DesignTokens.fontFamily,
      fontSize: DesignTokens.fontSizeBase,
      fontWeight: DesignTokens.fontWeightSemiBold,
      color: DesignTokens.neutral900,
      height: DesignTokens.lineHeightNormal,
    ),
    titleMedium: TextStyle(
      fontFamily: DesignTokens.fontFamily,
      fontSize: DesignTokens.fontSizeSm,
      fontWeight: DesignTokens.fontWeightMedium,
      color: DesignTokens.neutral900,
      height: DesignTokens.lineHeightNormal,
    ),
    titleSmall: TextStyle(
      fontFamily: DesignTokens.fontFamily,
      fontSize: DesignTokens.fontSizeXs,
      fontWeight: DesignTokens.fontWeightMedium,
      color: DesignTokens.neutral900,
      height: DesignTokens.lineHeightNormal,
    ),
    bodyLarge: TextStyle(
      fontFamily: DesignTokens.fontFamily,
      fontSize: DesignTokens.fontSizeBase,
      fontWeight: DesignTokens.fontWeightRegular,
      color: DesignTokens.neutral700,
      height: DesignTokens.lineHeightNormal,
    ),
    bodyMedium: TextStyle(
      fontFamily: DesignTokens.fontFamily,
      fontSize: DesignTokens.fontSizeSm,
      fontWeight: DesignTokens.fontWeightRegular,
      color: DesignTokens.neutral700,
      height: DesignTokens.lineHeightNormal,
    ),
    bodySmall: TextStyle(
      fontFamily: DesignTokens.fontFamily,
      fontSize: DesignTokens.fontSizeXs,
      fontWeight: DesignTokens.fontWeightRegular,
      color: DesignTokens.neutral600,
      height: DesignTokens.lineHeightNormal,
    ),
    labelLarge: TextStyle(
      fontFamily: DesignTokens.fontFamily,
      fontSize: DesignTokens.fontSizeSm,
      fontWeight: DesignTokens.fontWeightMedium,
      color: DesignTokens.neutral700,
      height: DesignTokens.lineHeightNormal,
    ),
    labelMedium: TextStyle(
      fontFamily: DesignTokens.fontFamily,
      fontSize: DesignTokens.fontSizeXs,
      fontWeight: DesignTokens.fontWeightMedium,
      color: DesignTokens.neutral700,
      height: DesignTokens.lineHeightNormal,
    ),
    labelSmall: TextStyle(
      fontFamily: DesignTokens.fontFamily,
      fontSize: DesignTokens.fontSizeXs,
      fontWeight: DesignTokens.fontWeightMedium,
      color: DesignTokens.neutral600,
      height: DesignTokens.lineHeightNormal,
    ),
  );
  
  /// Dark text theme
  TextTheme get darkTextTheme => lightTextTheme.apply(
    bodyColor: DesignTokens.neutral100,
    displayColor: DesignTokens.neutral100,
  );
  
  // ============================================================================
  // COMPONENT THEMES
  // ============================================================================
  
  /// Light app bar theme
  AppBarTheme get lightAppBarTheme => const AppBarTheme(
    backgroundColor: DesignTokens.backgroundLight,
    foregroundColor: DesignTokens.neutral900,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontFamily: DesignTokens.fontFamily,
      fontSize: DesignTokens.fontSizeLg,
      fontWeight: DesignTokens.fontWeightSemiBold,
      color: DesignTokens.neutral900,
    ),
  );
  
  /// Dark app bar theme
  AppBarTheme get darkAppBarTheme => const AppBarTheme(
    backgroundColor: DesignTokens.backgroundDark,
    foregroundColor: DesignTokens.neutral100,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontFamily: DesignTokens.fontFamily,
      fontSize: DesignTokens.fontSizeLg,
      fontWeight: DesignTokens.fontWeightSemiBold,
      color: DesignTokens.neutral100,
    ),
  );
  
  /// Light card theme
  CardTheme get lightCardTheme => CardTheme(
    color: DesignTokens.surfaceLight,
    elevation: 2,
    shadowColor: DesignTokens.neutral900.withOpacity(0.1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
    ),
  );
  
  /// Dark card theme
  CardTheme get darkCardTheme => CardTheme(
    color: DesignTokens.surfaceDark,
    elevation: 2,
    shadowColor: DesignTokens.neutral900.withOpacity(0.3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
    ),
  );
  
  /// Light elevated button theme
  ElevatedButtonThemeData get lightElevatedButtonTheme => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: DesignTokens.primary,
      foregroundColor: Colors.white,
      elevation: 2,
      shadowColor: DesignTokens.primary.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacing6,
        vertical: DesignTokens.spacing3,
      ),
    ),
  );
  
  /// Dark elevated button theme
  ElevatedButtonThemeData get darkElevatedButtonTheme => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: DesignTokens.primaryLight,
      foregroundColor: DesignTokens.neutral900,
      elevation: 2,
      shadowColor: DesignTokens.primaryLight.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacing6,
        vertical: DesignTokens.spacing3,
      ),
    ),
  );
  
  /// Light text button theme
  TextButtonThemeData get lightTextButtonTheme => TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: DesignTokens.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacing4,
        vertical: DesignTokens.spacing2,
      ),
    ),
  );
  
  /// Dark text button theme
  TextButtonThemeData get darkTextButtonTheme => TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: DesignTokens.primaryLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacing4,
        vertical: DesignTokens.spacing2,
      ),
    ),
  );
  
  /// Light outlined button theme
  OutlinedButtonThemeData get lightOutlinedButtonTheme => OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: DesignTokens.primary,
      side: const BorderSide(color: DesignTokens.primary),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacing6,
        vertical: DesignTokens.spacing3,
      ),
    ),
  );
  
  /// Dark outlined button theme
  OutlinedButtonThemeData get darkOutlinedButtonTheme => OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: DesignTokens.primaryLight,
      side: const BorderSide(color: DesignTokens.primaryLight),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacing6,
        vertical: DesignTokens.spacing3,
      ),
    ),
  );
  
  /// Light input decoration theme
  InputDecorationTheme get lightInputDecorationTheme => InputDecorationTheme(
    filled: true,
    fillColor: DesignTokens.neutral50,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
      borderSide: const BorderSide(color: DesignTokens.neutral300),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
      borderSide: const BorderSide(color: DesignTokens.neutral300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
      borderSide: const BorderSide(color: DesignTokens.primary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
      borderSide: const BorderSide(color: DesignTokens.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
      borderSide: const BorderSide(color: DesignTokens.error, width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: DesignTokens.spacing4,
      vertical: DesignTokens.spacing3,
    ),
  );
  
  /// Dark input decoration theme
  InputDecorationTheme get darkInputDecorationTheme => InputDecorationTheme(
    filled: true,
    fillColor: DesignTokens.neutral800,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
      borderSide: const BorderSide(color: DesignTokens.neutral600),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
      borderSide: const BorderSide(color: DesignTokens.neutral600),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
      borderSide: const BorderSide(color: DesignTokens.primaryLight, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
      borderSide: const BorderSide(color: DesignTokens.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
      borderSide: const BorderSide(color: DesignTokens.error, width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: DesignTokens.spacing4,
      vertical: DesignTokens.spacing3,
    ),
  );
  
  /// Light bottom navigation bar theme
  BottomNavigationBarThemeData get lightBottomNavigationBarTheme => const BottomNavigationBarThemeData(
    backgroundColor: DesignTokens.backgroundLight,
    selectedItemColor: DesignTokens.primary,
    unselectedItemColor: DesignTokens.neutral500,
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  );
  
  /// Dark bottom navigation bar theme
  BottomNavigationBarThemeData get darkBottomNavigationBarTheme => const BottomNavigationBarThemeData(
    backgroundColor: DesignTokens.backgroundDark,
    selectedItemColor: DesignTokens.primaryLight,
    unselectedItemColor: DesignTokens.neutral400,
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  );
  
  /// Light floating action button theme
  FloatingActionButtonThemeData get lightFloatingActionButtonTheme => const FloatingActionButtonThemeData(
    backgroundColor: DesignTokens.primary,
    foregroundColor: Colors.white,
    elevation: 6,
  );
  
  /// Dark floating action button theme
  FloatingActionButtonThemeData get darkFloatingActionButtonTheme => const FloatingActionButtonThemeData(
    backgroundColor: DesignTokens.primaryLight,
    foregroundColor: DesignTokens.neutral900,
    elevation: 6,
  );
  
  /// Light snack bar theme
  SnackBarThemeData get lightSnackBarTheme => const SnackBarThemeData(
    backgroundColor: DesignTokens.neutral800,
    contentTextStyle: TextStyle(
      fontFamily: DesignTokens.fontFamily,
      color: Colors.white,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(DesignTokens.radiusBase),
      ),
    ),
  );
  
  /// Dark snack bar theme
  SnackBarThemeData get darkSnackBarTheme => const SnackBarThemeData(
    backgroundColor: DesignTokens.neutral700,
    contentTextStyle: TextStyle(
      fontFamily: DesignTokens.fontFamily,
      color: DesignTokens.neutral100,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(DesignTokens.radiusBase),
      ),
    ),
  );
  
  /// Light divider theme
  DividerThemeData get lightDividerTheme => const DividerThemeData(
    color: DesignTokens.neutral200,
    thickness: 1,
    space: 1,
  );
  
  /// Dark divider theme
  DividerThemeData get darkDividerTheme => const DividerThemeData(
    color: DesignTokens.neutral700,
    thickness: 1,
    space: 1,
  );
  
  /// Light icon theme
  IconThemeData get lightIconTheme => const IconThemeData(
    color: DesignTokens.neutral700,
    size: 24,
  );
  
  /// Dark icon theme
  IconThemeData get darkIconTheme => const IconThemeData(
    color: DesignTokens.neutral300,
    size: 24,
  );
}
