// file: packages/pandora_ui/lib/src/theme.dart
import 'package:flutter/material.dart';
import 'package:pandora_ui/src/tokens.dart';

/// Creates the main Pandora 4 theme with dark mode as default
ThemeData createPandoraTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      background: AppColors.background,
      surface: AppColors.surface,
      error: AppColors.error,
      onPrimary: AppColors.onPrimary,
      onSecondary: Colors.white,
      onBackground: AppColors.onSurface,
      onSurface: AppColors.onSurface,
      onError: Colors.black,
    ),
    textTheme: TextTheme(
      titleMedium: PTokens.typography.title,
      bodyMedium: PTokens.typography.body,
      labelLarge: PTokens.typography.label,
    ),
    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.onSurface,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.onSurface,
      ),
    ),
    // Card Theme
    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: PTokens.elevation.card,
      shape: RoundedRectangleBorder(
        borderRadius: PTokens.radius.card,
      ),
      margin: const EdgeInsets.all(PTokens.spacingMd),
    ),
    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: PTokens.elevation.chip,
        shape: RoundedRectangleBorder(
          borderRadius: PTokens.radius.chip,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: PTokens.spacingLg,
          vertical: PTokens.spacingMd,
        ),
      ),
    ),
    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: PTokens.radius.chip,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: PTokens.spacingLg,
          vertical: PTokens.spacingMd,
        ),
      ),
    ),
    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary),
        shape: RoundedRectangleBorder(
          borderRadius: PTokens.radius.chip,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: PTokens.spacingLg,
          vertical: PTokens.spacingMd,
        ),
      ),
    ),
    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      border: OutlineInputBorder(
        borderRadius: PTokens.radius.chip,
        borderSide: const BorderSide(color: AppColors.onSurfaceVariant),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: PTokens.radius.chip,
        borderSide: const BorderSide(color: AppColors.onSurfaceVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: PTokens.radius.chip,
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: PTokens.radius.chip,
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: PTokens.radius.chip,
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: PTokens.spacingLg,
        vertical: PTokens.spacingMd,
      ),
      labelStyle: PTokens.typography.label,
      hintStyle: PTokens.typography.body.copyWith(
        color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
      ),
    ),
    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.surface,
      selectedColor: AppColors.primary.withValues(alpha: 0.2),
      disabledColor: AppColors.onSurfaceVariant.withValues(alpha: PTokens.opacity.disabled),
      labelStyle: PTokens.typography.label,
      shape: RoundedRectangleBorder(
        borderRadius: PTokens.radius.chip,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: PTokens.spacingMd,
        vertical: PTokens.spacingSm,
      ),
    ),
    // Icon Theme
    iconTheme: const IconThemeData(
      color: AppColors.onSurface,
      size: 20.0,
    ),
    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: AppColors.onSurfaceVariant,
      thickness: 1,
      space: 1,
    ),
    // Snackbar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.surface,
      contentTextStyle: PTokens.typography.body,
      shape: RoundedRectangleBorder(
        borderRadius: PTokens.radius.card,
      ),
      behavior: SnackBarBehavior.floating,
      elevation: PTokens.elevation.card,
    ),
    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.onSurfaceVariant,
      type: BottomNavigationBarType.fixed,
      elevation: 2.0,
    ),
    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.onPrimary,
      elevation: 6.0,
    ),
    // Dialog Theme
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: PTokens.radius.card,
      ),
      elevation: PTokens.elevation.card,
      titleTextStyle: PTokens.typography.title,
      contentTextStyle: PTokens.typography.body,
    ),
    // Bottom Sheet Theme
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      elevation: 6.0,
    ),
    // Switch Theme
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return AppColors.onSurfaceVariant;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary.withValues(alpha: 0.5);
        }
        return AppColors.onSurfaceVariant.withValues(alpha: 0.3);
      }),
    ),
    // Checkbox Theme
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(AppColors.onPrimary),
      side: const BorderSide(color: AppColors.onSurfaceVariant),
      shape: RoundedRectangleBorder(
        borderRadius: PTokens.radius.chip,
      ),
    ),
    // Radio Theme
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return AppColors.onSurfaceVariant;
      }),
    ),
    // Slider Theme
    sliderTheme: SliderThemeData(
      activeTrackColor: AppColors.primary,
      inactiveTrackColor: AppColors.onSurfaceVariant.withValues(alpha: 0.3),
      thumbColor: AppColors.primary,
      overlayColor: AppColors.primary.withValues(alpha: 0.2),
      valueIndicatorColor: AppColors.primary,
      valueIndicatorTextStyle: PTokens.typography.label,
    ),
    // Progress Indicator Theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
      linearTrackColor: AppColors.onSurfaceVariant,
      circularTrackColor: AppColors.onSurfaceVariant,
    ),
    // Tab Bar Theme
    tabBarTheme: const TabBarThemeData(
      labelColor: AppColors.primary,
      unselectedLabelColor: AppColors.onSurfaceVariant,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: AppColors.primary, width: 2),
      ),
      labelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}

/// Creates a light theme variant for Pandora 4
ThemeData createPandoraLightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      background: Colors.white,
      surface: Color(0xFFF5F5F5),
      error: AppColors.error,
      onPrimary: AppColors.onPrimary,
      onSecondary: Colors.white,
      onBackground: Color(0xFF212121),
      onSurface: Color(0xFF212121),
      onError: Colors.white,
    ),
    textTheme: TextTheme(
      titleMedium: PTokens.typography.title.copyWith(color: const Color(0xFF212121)),
      bodyMedium: PTokens.typography.body.copyWith(color: const Color(0xFF424242)),
      labelLarge: PTokens.typography.label.copyWith(color: const Color(0xFF212121)),
    ),
    // Similar component themes as dark theme but with light colors
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Color(0xFF212121),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(0xFF212121),
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: PTokens.elevation.card,
      shape: RoundedRectangleBorder(
        borderRadius: PTokens.radius.card,
      ),
      margin: const EdgeInsets.all(PTokens.spacingMd),
    ),
  );
}
