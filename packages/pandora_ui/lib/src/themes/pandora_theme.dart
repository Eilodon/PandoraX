import 'package:flutter/material.dart';
import '../tokens/color_tokens.dart';
import '../tokens/typography_tokens.dart';
import '../tokens/spacing_tokens.dart';
import '../tokens/border_tokens.dart';
import '../tokens/shadow_tokens.dart';

/// Pandora 4 Theme
/// 
/// The central theme class that brings together all design tokens
/// to create a cohesive design system following "Thân Tâm Hợp Nhất" philosophy.
class PandoraTheme {
  // Private constructor to prevent instantiation
  PandoraTheme._();

  /// Create light theme
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: _lightColorScheme,
      textTheme: _lightTextTheme,
      appBarTheme: _lightAppBarTheme,
      elevatedButtonTheme: _lightElevatedButtonTheme,
      outlinedButtonTheme: _lightOutlinedButtonTheme,
      textButtonTheme: _lightTextButtonTheme,
      cardTheme: _lightCardTheme,
      inputDecorationTheme: _lightInputDecorationTheme,
      chipTheme: _lightChipTheme,
      dividerTheme: _lightDividerTheme,
      bottomNavigationBarTheme: _lightBottomNavigationBarTheme,
      navigationBarTheme: _lightNavigationBarTheme,
      snackBarTheme: _lightSnackBarTheme,
      dialogTheme: _lightDialogTheme,
      bottomSheetTheme: _lightBottomSheetTheme,
      drawerTheme: _lightDrawerTheme,
      listTileTheme: _lightListTileTheme,
      switchTheme: _lightSwitchTheme,
      checkboxTheme: _lightCheckboxTheme,
      radioTheme: _lightRadioTheme,
      sliderTheme: _lightSliderTheme,
      progressIndicatorTheme: _lightProgressIndicatorTheme,
      tabBarTheme: _lightTabBarTheme,
      tooltipTheme: _lightTooltipTheme,
      popupMenuTheme: _lightPopupMenuTheme,
      dataTableTheme: _lightDataTableTheme,
      extensions: <ThemeExtension<dynamic>>[
        PandoraThemeExtension.light(),
      ],
    );
  }

  /// Create dark theme
  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: _darkColorScheme,
      textTheme: _darkTextTheme,
      appBarTheme: _darkAppBarTheme,
      elevatedButtonTheme: _darkElevatedButtonTheme,
      outlinedButtonTheme: _darkOutlinedButtonTheme,
      textButtonTheme: _darkTextButtonTheme,
      cardTheme: _darkCardTheme,
      inputDecorationTheme: _darkInputDecorationTheme,
      chipTheme: _darkChipTheme,
      dividerTheme: _darkDividerTheme,
      bottomNavigationBarTheme: _darkBottomNavigationBarTheme,
      navigationBarTheme: _darkNavigationBarTheme,
      snackBarTheme: _darkSnackBarTheme,
      dialogTheme: _darkDialogTheme,
      bottomSheetTheme: _darkBottomSheetTheme,
      drawerTheme: _darkDrawerTheme,
      listTileTheme: _darkListTileTheme,
      switchTheme: _darkSwitchTheme,
      checkboxTheme: _darkCheckboxTheme,
      radioTheme: _darkRadioTheme,
      sliderTheme: _darkSliderTheme,
      progressIndicatorTheme: _darkProgressIndicatorTheme,
      tabBarTheme: _darkTabBarTheme,
      tooltipTheme: _darkTooltipTheme,
      popupMenuTheme: _darkPopupMenuTheme,
      dataTableTheme: _darkDataTableTheme,
      extensions: <ThemeExtension<dynamic>>[
        PandoraThemeExtension.dark(),
      ],
    );
  }

  // Light Color Scheme
  static const ColorScheme _lightColorScheme = ColorScheme.light(
    primary: PandoraColors.primary500,
    onPrimary: PandoraColors.white,
    primaryContainer: PandoraColors.primary100,
    onPrimaryContainer: PandoraColors.primary900,
    secondary: PandoraColors.secondary500,
    onSecondary: PandoraColors.white,
    secondaryContainer: PandoraColors.secondary100,
    onSecondaryContainer: PandoraColors.secondary900,
    tertiary: PandoraColors.info500,
    onTertiary: PandoraColors.white,
    tertiaryContainer: PandoraColors.info100,
    onTertiaryContainer: PandoraColors.info900,
    error: PandoraColors.error500,
    onError: PandoraColors.white,
    errorContainer: PandoraColors.error100,
    onErrorContainer: PandoraColors.error900,
    background: PandoraColors.surface,
    onBackground: PandoraColors.onSurface,
    surface: PandoraColors.surface,
    onSurface: PandoraColors.onSurface,
    surfaceVariant: PandoraColors.surfaceVariant,
    onSurfaceVariant: PandoraColors.onSurfaceVariant,
    outline: PandoraColors.outline,
    outlineVariant: PandoraColors.outlineVariant,
    shadow: PandoraColors.shadowColor,
    scrim: PandoraColors.black,
    inverseSurface: PandoraColors.neutral800,
    onInverseSurface: PandoraColors.neutral100,
    inversePrimary: PandoraColors.primary200,
    surfaceTint: PandoraColors.primary500,
  );

  // Dark Color Scheme
  static const ColorScheme _darkColorScheme = ColorScheme.dark(
    primary: PandoraColors.primary400,
    onPrimary: PandoraColors.primary900,
    primaryContainer: PandoraColors.primary800,
    onPrimaryContainer: PandoraColors.primary100,
    secondary: PandoraColors.secondary400,
    onSecondary: PandoraColors.secondary900,
    secondaryContainer: PandoraColors.secondary800,
    onSecondaryContainer: PandoraColors.secondary100,
    tertiary: PandoraColors.info400,
    onTertiary: PandoraColors.info900,
    tertiaryContainer: PandoraColors.info800,
    onTertiaryContainer: PandoraColors.info100,
    error: PandoraColors.error400,
    onError: PandoraColors.error900,
    errorContainer: PandoraColors.error800,
    onErrorContainer: PandoraColors.error100,
    background: PandoraColors.neutral900,
    onBackground: PandoraColors.neutral100,
    surface: PandoraColors.neutral800,
    onSurface: PandoraColors.neutral100,
    surfaceVariant: PandoraColors.neutral700,
    onSurfaceVariant: PandoraColors.neutral300,
    outline: PandoraColors.neutral600,
    outlineVariant: PandoraColors.neutral700,
    shadow: PandoraColors.black,
    scrim: PandoraColors.black,
    inverseSurface: PandoraColors.neutral100,
    onInverseSurface: PandoraColors.neutral800,
    inversePrimary: PandoraColors.primary600,
    surfaceTint: PandoraColors.primary400,
  );

  // Light Text Theme
  static const TextTheme _lightTextTheme = TextTheme(
    displayLarge: PandoraTypography.displayLarge,
    displayMedium: PandoraTypography.displayMedium,
    displaySmall: PandoraTypography.displaySmall,
    headlineLarge: PandoraTypography.headlineLarge,
    headlineMedium: PandoraTypography.headlineMedium,
    headlineSmall: PandoraTypography.headlineSmall,
    titleLarge: PandoraTypography.titleLarge,
    titleMedium: PandoraTypography.titleMedium,
    titleSmall: PandoraTypography.titleSmall,
    bodyLarge: PandoraTypography.bodyLarge,
    bodyMedium: PandoraTypography.bodyMedium,
    bodySmall: PandoraTypography.bodySmall,
    labelLarge: PandoraTypography.labelLarge,
    labelMedium: PandoraTypography.labelMedium,
    labelSmall: PandoraTypography.labelSmall,
  );

  // Dark Text Theme
  static const TextTheme _darkTextTheme = TextTheme(
    displayLarge: PandoraTypography.displayLarge.copyWith(color: PandoraColors.neutral100),
    displayMedium: PandoraTypography.displayMedium.copyWith(color: PandoraColors.neutral100),
    displaySmall: PandoraTypography.displaySmall.copyWith(color: PandoraColors.neutral100),
    headlineLarge: PandoraTypography.headlineLarge.copyWith(color: PandoraColors.neutral100),
    headlineMedium: PandoraTypography.headlineMedium.copyWith(color: PandoraColors.neutral100),
    headlineSmall: PandoraTypography.headlineSmall.copyWith(color: PandoraColors.neutral100),
    titleLarge: PandoraTypography.titleLarge.copyWith(color: PandoraColors.neutral100),
    titleMedium: PandoraTypography.titleMedium.copyWith(color: PandoraColors.neutral100),
    titleSmall: PandoraTypography.titleSmall.copyWith(color: PandoraColors.neutral200),
    bodyLarge: PandoraTypography.bodyLarge.copyWith(color: PandoraColors.neutral100),
    bodyMedium: PandoraTypography.bodyMedium.copyWith(color: PandoraColors.neutral200),
    bodySmall: PandoraTypography.bodySmall.copyWith(color: PandoraColors.neutral300),
    labelLarge: PandoraTypography.labelLarge.copyWith(color: PandoraColors.neutral100),
    labelMedium: PandoraTypography.labelMedium.copyWith(color: PandoraColors.neutral200),
    labelSmall: PandoraTypography.labelSmall.copyWith(color: PandoraColors.neutral300),
  );

  // App Bar Themes
  static const AppBarTheme _lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    titleTextStyle: PandoraTypography.titleLarge,
    backgroundColor: PandoraColors.surface,
    foregroundColor: PandoraColors.onSurface,
    shadowColor: PandoraColors.shadowColor,
  );

  static const AppBarTheme _darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    titleTextStyle: PandoraTypography.titleLarge.copyWith(color: PandoraColors.neutral100),
    backgroundColor: PandoraColors.neutral800,
    foregroundColor: PandoraColors.neutral100,
    shadowColor: PandoraColors.black,
  );

  // Button Themes
  static final ElevatedButtonThemeData _lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      padding: const EdgeInsets.symmetric(
        horizontal: PandoraSpacing.space24,
        vertical: PandoraSpacing.space12,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: PandoraBorders.borderRadiusMd,
      ),
      textStyle: PandoraTypography.labelLarge,
    ),
  );

  static final ElevatedButtonThemeData _darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      padding: const EdgeInsets.symmetric(
        horizontal: PandoraSpacing.space24,
        vertical: PandoraSpacing.space12,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: PandoraBorders.borderRadiusMd,
      ),
      textStyle: PandoraTypography.labelLarge,
    ),
  );

  static final OutlinedButtonThemeData _lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        horizontal: PandoraSpacing.space24,
        vertical: PandoraSpacing.space12,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: PandoraBorders.borderRadiusMd,
      ),
      textStyle: PandoraTypography.labelLarge,
    ),
  );

  static final OutlinedButtonThemeData _darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        horizontal: PandoraSpacing.space24,
        vertical: PandoraSpacing.space12,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: PandoraBorders.borderRadiusMd,
      ),
      textStyle: PandoraTypography.labelLarge,
    ),
  );

  static final TextButtonThemeData _lightTextButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        horizontal: PandoraSpacing.space16,
        vertical: PandoraSpacing.space8,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: PandoraBorders.borderRadiusMd,
      ),
      textStyle: PandoraTypography.labelLarge,
    ),
  );

  static final TextButtonThemeData _darkTextButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        horizontal: PandoraSpacing.space16,
        vertical: PandoraSpacing.space8,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: PandoraBorders.borderRadiusMd,
      ),
      textStyle: PandoraTypography.labelLarge,
    ),
  );

  // Card Theme
  static final CardTheme _lightCardTheme = CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: PandoraBorders.borderRadiusLg,
      side: const BorderSide(color: PandoraColors.outline),
    ),
    margin: const EdgeInsets.all(PandoraSpacing.space8),
    shadowColor: PandoraColors.shadowColor,
  );

  static final CardTheme _darkCardTheme = CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: PandoraBorders.borderRadiusLg,
      side: const BorderSide(color: PandoraColors.neutral600),
    ),
    margin: const EdgeInsets.all(PandoraSpacing.space8),
    shadowColor: PandoraColors.black,
  );

  // Input Decoration Theme
  static final InputDecorationTheme _lightInputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: PandoraColors.surfaceVariant,
    border: OutlineInputBorder(
      borderRadius: PandoraBorders.borderRadiusMd,
      borderSide: const BorderSide(color: PandoraColors.outline),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: PandoraBorders.borderRadiusMd,
      borderSide: const BorderSide(color: PandoraColors.outline),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: PandoraBorders.borderRadiusMd,
      borderSide: const BorderSide(color: PandoraColors.primary500, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: PandoraBorders.borderRadiusMd,
      borderSide: const BorderSide(color: PandoraColors.error500),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: PandoraBorders.borderRadiusMd,
      borderSide: const BorderSide(color: PandoraColors.error500, width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: PandoraSpacing.space16,
      vertical: PandoraSpacing.space12,
    ),
    labelStyle: PandoraTypography.bodyMedium,
    hintStyle: PandoraTypography.bodyMedium.copyWith(
      color: PandoraColors.onSurfaceDisabled,
    ),
  );

  static final InputDecorationTheme _darkInputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: PandoraColors.neutral700,
    border: OutlineInputBorder(
      borderRadius: PandoraBorders.borderRadiusMd,
      borderSide: const BorderSide(color: PandoraColors.neutral600),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: PandoraBorders.borderRadiusMd,
      borderSide: const BorderSide(color: PandoraColors.neutral600),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: PandoraBorders.borderRadiusMd,
      borderSide: const BorderSide(color: PandoraColors.primary400, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: PandoraBorders.borderRadiusMd,
      borderSide: const BorderSide(color: PandoraColors.error400),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: PandoraBorders.borderRadiusMd,
      borderSide: const BorderSide(color: PandoraColors.error400, width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: PandoraSpacing.space16,
      vertical: PandoraSpacing.space12,
    ),
    labelStyle: PandoraTypography.bodyMedium.copyWith(color: PandoraColors.neutral200),
    hintStyle: PandoraTypography.bodyMedium.copyWith(
      color: PandoraColors.neutral400,
    ),
  );

  // Additional theme components would go here...
  // (Chip, Divider, BottomNavigationBar, etc.)
  
  static const ChipThemeData _lightChipTheme = ChipThemeData();
  static const ChipThemeData _darkChipTheme = ChipThemeData();
  static const DividerThemeData _lightDividerTheme = DividerThemeData();
  static const DividerThemeData _darkDividerTheme = DividerThemeData();
  static const BottomNavigationBarThemeData _lightBottomNavigationBarTheme = BottomNavigationBarThemeData();
  static const BottomNavigationBarThemeData _darkBottomNavigationBarTheme = BottomNavigationBarThemeData();
  static const NavigationBarThemeData _lightNavigationBarTheme = NavigationBarThemeData();
  static const NavigationBarThemeData _darkNavigationBarTheme = NavigationBarThemeData();
  static const SnackBarThemeData _lightSnackBarTheme = SnackBarThemeData();
  static const SnackBarThemeData _darkSnackBarTheme = SnackBarThemeData();
  static const DialogTheme _lightDialogTheme = DialogTheme();
  static const DialogTheme _darkDialogTheme = DialogTheme();
  static const BottomSheetThemeData _lightBottomSheetTheme = BottomSheetThemeData();
  static const BottomSheetThemeData _darkBottomSheetTheme = BottomSheetThemeData();
  static const DrawerThemeData _lightDrawerTheme = DrawerThemeData();
  static const DrawerThemeData _darkDrawerTheme = DrawerThemeData();
  static const ListTileThemeData _lightListTileTheme = ListTileThemeData();
  static const ListTileThemeData _darkListTileTheme = ListTileThemeData();
  static const SwitchThemeData _lightSwitchTheme = SwitchThemeData();
  static const SwitchThemeData _darkSwitchTheme = SwitchThemeData();
  static const CheckboxThemeData _lightCheckboxTheme = CheckboxThemeData();
  static const CheckboxThemeData _darkCheckboxTheme = CheckboxThemeData();
  static const RadioThemeData _lightRadioTheme = RadioThemeData();
  static const RadioThemeData _darkRadioTheme = RadioThemeData();
  static const SliderThemeData _lightSliderTheme = SliderThemeData();
  static const SliderThemeData _darkSliderTheme = SliderThemeData();
  static const ProgressIndicatorThemeData _lightProgressIndicatorTheme = ProgressIndicatorThemeData();
  static const ProgressIndicatorThemeData _darkProgressIndicatorTheme = ProgressIndicatorThemeData();
  static const TabBarTheme _lightTabBarTheme = TabBarTheme();
  static const TabBarTheme _darkTabBarTheme = TabBarTheme();
  static const TooltipThemeData _lightTooltipTheme = TooltipThemeData();
  static const TooltipThemeData _darkTooltipTheme = TooltipThemeData();
  static const PopupMenuThemeData _lightPopupMenuTheme = PopupMenuThemeData();
  static const PopupMenuThemeData _darkPopupMenuTheme = PopupMenuThemeData();
  static const DataTableThemeData _lightDataTableTheme = DataTableThemeData();
  static const DataTableThemeData _darkDataTableTheme = DataTableThemeData();
}

/// Pandora Theme Extension
/// 
/// Custom theme extension for additional design tokens
@immutable
class PandoraThemeExtension extends ThemeExtension<PandoraThemeExtension> {
  const PandoraThemeExtension({
    required this.spacing,
    required this.borders,
    required this.shadows,
  });

  final PandoraSpacing spacing;
  final PandoraBorders borders;
  final PandoraShadows shadows;

  static PandoraThemeExtension light() => const PandoraThemeExtension(
    spacing: PandoraSpacing._(),
    borders: PandoraBorders._(),
    shadows: PandoraShadows._(),
  );

  static PandoraThemeExtension dark() => const PandoraThemeExtension(
    spacing: PandoraSpacing._(),
    borders: PandoraBorders._(),
    shadows: PandoraShadows._(),
  );

  @override
  PandoraThemeExtension copyWith({
    PandoraSpacing? spacing,
    PandoraBorders? borders,
    PandoraShadows? shadows,
  }) {
    return PandoraThemeExtension(
      spacing: spacing ?? this.spacing,
      borders: borders ?? this.borders,
      shadows: shadows ?? this.shadows,
    );
  }

  @override
  PandoraThemeExtension lerp(ThemeExtension<PandoraThemeExtension>? other, double t) {
    if (other is! PandoraThemeExtension) {
      return this;
    }
    return PandoraThemeExtension(
      spacing: spacing,
      borders: borders,
      shadows: shadows,
    );
  }
}
