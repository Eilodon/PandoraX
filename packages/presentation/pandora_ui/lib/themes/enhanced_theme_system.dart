import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:design_tokens/design_tokens.dart';

/// Enhanced theme system with advanced customization options
class EnhancedThemeSystem {
  /// Get light theme with enhanced styling
  static ThemeData getLightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: PandoraColorScheme.light,
      textTheme: PandoraTextTheme.light,
      
      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: PandoraColors.surface,
        foregroundColor: PandoraColors.onSurface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: PandoraTextStyles.headlineSmall.copyWith(
          color: PandoraColors.onSurface,
          fontWeight: FontWeight.w600,
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: PandoraColors.surface,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      ),

      // Card Theme
      cardTheme: CardTheme(
        color: PandoraColors.surface,
        elevation: 2,
        shadowColor: PandoraColors.shadow.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: PandoraBorderRadius.medium,
        ),
        margin: const EdgeInsets.all(8),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: PandoraColors.primary,
          foregroundColor: PandoraColors.onPrimary,
          elevation: 2,
          shadowColor: PandoraColors.shadow.withOpacity(0.2),
          shape: RoundedRectangleBorder(
            borderRadius: PandoraBorderRadius.medium,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: PandoraTextStyles.labelLarge.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: PandoraColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: PandoraBorderRadius.small,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: PandoraTextStyles.labelLarge.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: PandoraColors.primary,
          side: BorderSide(color: PandoraColors.outline),
          shape: RoundedRectangleBorder(
            borderRadius: PandoraBorderRadius.medium,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: PandoraTextStyles.labelLarge.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: PandoraColors.primary,
        foregroundColor: PandoraColors.onPrimary,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: PandoraBorderRadius.large,
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: PandoraColors.surfaceVariant.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: PandoraBorderRadius.medium,
          borderSide: BorderSide(color: PandoraColors.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: PandoraBorderRadius.medium,
          borderSide: BorderSide(color: PandoraColors.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: PandoraBorderRadius.medium,
          borderSide: BorderSide(color: PandoraColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: PandoraBorderRadius.medium,
          borderSide: BorderSide(color: PandoraColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: PandoraBorderRadius.medium,
          borderSide: BorderSide(color: PandoraColors.error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelStyle: PandoraTextStyles.bodyMedium.copyWith(
          color: PandoraColors.textSecondary,
        ),
        hintStyle: PandoraTextStyles.bodyMedium.copyWith(
          color: PandoraColors.textSecondary,
        ),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: PandoraColors.surface,
        selectedItemColor: PandoraColors.primary,
        unselectedItemColor: PandoraColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: PandoraTextStyles.labelSmall.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: PandoraTextStyles.labelSmall,
      ),

      // Divider Theme
      dividerTheme: DividerThemeData(
        color: PandoraColors.outline,
        thickness: 1,
        space: 1,
      ),

      // Icon Theme
      iconTheme: IconThemeData(
        color: PandoraColors.onSurface,
        size: 24,
      ),

      // Primary Icon Theme
      primaryIconTheme: IconThemeData(
        color: PandoraColors.onPrimary,
        size: 24,
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: PandoraColors.surfaceVariant,
        selectedColor: PandoraColors.primary,
        disabledColor: PandoraColors.surfaceVariant.withOpacity(0.5),
        labelStyle: PandoraTextStyles.labelMedium,
        secondaryLabelStyle: PandoraTextStyles.labelMedium.copyWith(
          color: PandoraColors.onPrimary,
        ),
        brightness: Brightness.light,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: PandoraBorderRadius.medium,
        ),
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return PandoraColors.onPrimary;
          }
          return PandoraColors.surface;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return PandoraColors.primary;
          }
          return PandoraColors.outline;
        }),
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return PandoraColors.primary;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(PandoraColors.onPrimary),
        side: BorderSide(color: PandoraColors.outline),
        shape: RoundedRectangleBorder(
          borderRadius: PandoraBorderRadius.small,
        ),
      ),

      // Radio Theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return PandoraColors.primary;
          }
          return PandoraColors.outline;
        }),
      ),

      // Slider Theme
      sliderTheme: SliderThemeData(
        activeTrackColor: PandoraColors.primary,
        inactiveTrackColor: PandoraColors.surfaceVariant,
        thumbColor: PandoraColors.primary,
        overlayColor: PandoraColors.primary.withOpacity(0.1),
        valueIndicatorColor: PandoraColors.primary,
        valueIndicatorTextStyle: PandoraTextStyles.labelSmall.copyWith(
          color: PandoraColors.onPrimary,
        ),
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: PandoraColors.primary,
        linearTrackColor: PandoraColors.surfaceVariant,
        circularTrackColor: PandoraColors.surfaceVariant,
      ),

      // Snack Bar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: PandoraColors.inverseSurface,
        contentTextStyle: PandoraTextStyles.bodyMedium.copyWith(
          color: PandoraColors.onInverseSurface,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: PandoraBorderRadius.medium,
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 4,
      ),

      // Dialog Theme
      dialogTheme: DialogTheme(
        backgroundColor: PandoraColors.surface,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: PandoraBorderRadius.large,
        ),
        titleTextStyle: PandoraTextStyles.headlineSmall.copyWith(
          color: PandoraColors.onSurface,
          fontWeight: FontWeight.w600,
        ),
        contentTextStyle: PandoraTextStyles.bodyMedium.copyWith(
          color: PandoraColors.onSurface,
        ),
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: PandoraColors.surface,
        elevation: 8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAlias,
      ),

      // List Tile Theme
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: PandoraBorderRadius.medium,
        ),
        titleTextStyle: PandoraTextStyles.bodyLarge.copyWith(
          color: PandoraColors.onSurface,
        ),
        subtitleTextStyle: PandoraTextStyles.bodyMedium.copyWith(
          color: PandoraColors.textSecondary,
        ),
        leadingAndTrailingTextStyle: PandoraTextStyles.bodyMedium.copyWith(
          color: PandoraColors.textSecondary,
        ),
      ),

      // Tab Bar Theme
      tabBarTheme: TabBarTheme(
        labelColor: PandoraColors.primary,
        unselectedLabelColor: PandoraColors.textSecondary,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: PandoraColors.primary, width: 2),
        ),
        labelStyle: PandoraTextStyles.labelMedium.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: PandoraTextStyles.labelMedium,
      ),

      // Drawer Theme
      drawerTheme: DrawerThemeData(
        backgroundColor: PandoraColors.surface,
        elevation: 16,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),

      // Navigation Bar Theme
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: PandoraColors.surface,
        indicatorColor: PandoraColors.primary.withOpacity(0.1),
        labelTextStyle: WidgetStateProperty.all(
          PandoraTextStyles.labelSmall.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: PandoraColors.primary);
          }
          return IconThemeData(color: PandoraColors.textSecondary);
        }),
      ),

      // Navigation Rail Theme
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: PandoraColors.surface,
        indicatorColor: PandoraColors.primary.withOpacity(0.1),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return PandoraTextStyles.labelSmall.copyWith(
              color: PandoraColors.primary,
              fontWeight: FontWeight.w600,
            );
          }
          return PandoraTextStyles.labelSmall.copyWith(
            color: PandoraColors.textSecondary,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: PandoraColors.primary);
          }
          return IconThemeData(color: PandoraColors.textSecondary);
        }),
      ),
    );
  }

  /// Get dark theme with enhanced styling
  static ThemeData getDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: PandoraColorScheme.dark,
      textTheme: PandoraTextTheme.dark,
      
      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: PandoraColors.surface,
        foregroundColor: PandoraColors.onSurface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: PandoraTextStyles.headlineSmall.copyWith(
          color: PandoraColors.onSurface,
          fontWeight: FontWeight.w600,
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: PandoraColors.surface,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      ),

      // Card Theme
      cardTheme: CardTheme(
        color: PandoraColors.surface,
        elevation: 2,
        shadowColor: PandoraColors.shadow.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: PandoraBorderRadius.medium,
        ),
        margin: const EdgeInsets.all(8),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: PandoraColors.primary,
          foregroundColor: PandoraColors.onPrimary,
          elevation: 2,
          shadowColor: PandoraColors.shadow.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: PandoraBorderRadius.medium,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: PandoraTextStyles.labelLarge.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: PandoraColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: PandoraBorderRadius.small,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: PandoraTextStyles.labelLarge.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: PandoraColors.primary,
          side: BorderSide(color: PandoraColors.outline),
          shape: RoundedRectangleBorder(
            borderRadius: PandoraBorderRadius.medium,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: PandoraTextStyles.labelLarge.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: PandoraColors.primary,
        foregroundColor: PandoraColors.onPrimary,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: PandoraBorderRadius.large,
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: PandoraColors.surfaceVariant.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: PandoraBorderRadius.medium,
          borderSide: BorderSide(color: PandoraColors.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: PandoraBorderRadius.medium,
          borderSide: BorderSide(color: PandoraColors.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: PandoraBorderRadius.medium,
          borderSide: BorderSide(color: PandoraColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: PandoraBorderRadius.medium,
          borderSide: BorderSide(color: PandoraColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: PandoraBorderRadius.medium,
          borderSide: BorderSide(color: PandoraColors.error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelStyle: PandoraTextStyles.bodyMedium.copyWith(
          color: PandoraColors.textSecondary,
        ),
        hintStyle: PandoraTextStyles.bodyMedium.copyWith(
          color: PandoraColors.textSecondary,
        ),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: PandoraColors.surface,
        selectedItemColor: PandoraColors.primary,
        unselectedItemColor: PandoraColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: PandoraTextStyles.labelSmall.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: PandoraTextStyles.labelSmall,
      ),

      // Divider Theme
      dividerTheme: DividerThemeData(
        color: PandoraColors.outline,
        thickness: 1,
        space: 1,
      ),

      // Icon Theme
      iconTheme: IconThemeData(
        color: PandoraColors.onSurface,
        size: 24,
      ),

      // Primary Icon Theme
      primaryIconTheme: IconThemeData(
        color: PandoraColors.onPrimary,
        size: 24,
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: PandoraColors.surfaceVariant,
        selectedColor: PandoraColors.primary,
        disabledColor: PandoraColors.surfaceVariant.withOpacity(0.5),
        labelStyle: PandoraTextStyles.labelMedium,
        secondaryLabelStyle: PandoraTextStyles.labelMedium.copyWith(
          color: PandoraColors.onPrimary,
        ),
        brightness: Brightness.dark,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: PandoraBorderRadius.medium,
        ),
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return PandoraColors.onPrimary;
          }
          return PandoraColors.surface;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return PandoraColors.primary;
          }
          return PandoraColors.outline;
        }),
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return PandoraColors.primary;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(PandoraColors.onPrimary),
        side: BorderSide(color: PandoraColors.outline),
        shape: RoundedRectangleBorder(
          borderRadius: PandoraBorderRadius.small,
        ),
      ),

      // Radio Theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return PandoraColors.primary;
          }
          return PandoraColors.outline;
        }),
      ),

      // Slider Theme
      sliderTheme: SliderThemeData(
        activeTrackColor: PandoraColors.primary,
        inactiveTrackColor: PandoraColors.surfaceVariant,
        thumbColor: PandoraColors.primary,
        overlayColor: PandoraColors.primary.withOpacity(0.1),
        valueIndicatorColor: PandoraColors.primary,
        valueIndicatorTextStyle: PandoraTextStyles.labelSmall.copyWith(
          color: PandoraColors.onPrimary,
        ),
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: PandoraColors.primary,
        linearTrackColor: PandoraColors.surfaceVariant,
        circularTrackColor: PandoraColors.surfaceVariant,
      ),

      // Snack Bar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: PandoraColors.inverseSurface,
        contentTextStyle: PandoraTextStyles.bodyMedium.copyWith(
          color: PandoraColors.onInverseSurface,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: PandoraBorderRadius.medium,
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 4,
      ),

      // Dialog Theme
      dialogTheme: DialogTheme(
        backgroundColor: PandoraColors.surface,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: PandoraBorderRadius.large,
        ),
        titleTextStyle: PandoraTextStyles.headlineSmall.copyWith(
          color: PandoraColors.onSurface,
          fontWeight: FontWeight.w600,
        ),
        contentTextStyle: PandoraTextStyles.bodyMedium.copyWith(
          color: PandoraColors.onSurface,
        ),
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: PandoraColors.surface,
        elevation: 8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAlias,
      ),

      // List Tile Theme
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: PandoraBorderRadius.medium,
        ),
        titleTextStyle: PandoraTextStyles.bodyLarge.copyWith(
          color: PandoraColors.onSurface,
        ),
        subtitleTextStyle: PandoraTextStyles.bodyMedium.copyWith(
          color: PandoraColors.textSecondary,
        ),
        leadingAndTrailingTextStyle: PandoraTextStyles.bodyMedium.copyWith(
          color: PandoraColors.textSecondary,
        ),
      ),

      // Tab Bar Theme
      tabBarTheme: TabBarTheme(
        labelColor: PandoraColors.primary,
        unselectedLabelColor: PandoraColors.textSecondary,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: PandoraColors.primary, width: 2),
        ),
        labelStyle: PandoraTextStyles.labelMedium.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: PandoraTextStyles.labelMedium,
      ),

      // Drawer Theme
      drawerTheme: DrawerThemeData(
        backgroundColor: PandoraColors.surface,
        elevation: 16,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),

      // Navigation Bar Theme
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: PandoraColors.surface,
        indicatorColor: PandoraColors.primary.withOpacity(0.1),
        labelTextStyle: WidgetStateProperty.all(
          PandoraTextStyles.labelSmall.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: PandoraColors.primary);
          }
          return IconThemeData(color: PandoraColors.textSecondary);
        }),
      ),

      // Navigation Rail Theme
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: PandoraColors.surface,
        indicatorColor: PandoraColors.primary.withOpacity(0.1),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return PandoraTextStyles.labelSmall.copyWith(
              color: PandoraColors.primary,
              fontWeight: FontWeight.w600,
            );
          }
          return PandoraTextStyles.labelSmall.copyWith(
            color: PandoraColors.textSecondary,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: PandoraColors.primary);
          }
          return IconThemeData(color: PandoraColors.textSecondary);
        }),
      ),
    );
  }

  /// Get custom theme with specified colors
  static ThemeData getCustomTheme({
    required Color primaryColor,
    required Color secondaryColor,
    required Color surfaceColor,
    required Color backgroundColor,
    required Brightness brightness,
  }) {
    final baseTheme = brightness == Brightness.light
        ? getLightTheme()
        : getDarkTheme();

    return baseTheme.copyWith(
      colorScheme: baseTheme.colorScheme.copyWith(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        background: backgroundColor,
      ),
    );
  }

  /// Get theme based on system preference
  static ThemeData getSystemTheme(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.light
        ? getLightTheme()
        : getDarkTheme();
  }

  /// Get theme with custom typography
  static ThemeData getThemeWithTypography({
    required ThemeData baseTheme,
    required TextTheme customTextTheme,
  }) {
    return baseTheme.copyWith(
      textTheme: customTextTheme,
      primaryTextTheme: customTextTheme,
    );
  }

  /// Get theme with custom color scheme
  static ThemeData getThemeWithColorScheme({
    required ThemeData baseTheme,
    required ColorScheme customColorScheme,
  }) {
    return baseTheme.copyWith(
      colorScheme: customColorScheme,
    );
  }
}
