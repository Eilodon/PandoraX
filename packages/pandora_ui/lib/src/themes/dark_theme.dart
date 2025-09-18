import 'package:flutter/material.dart';
import 'pandora_theme.dart';

/// Pandora 4 Dark Theme
/// 
/// A specialized dark theme that extends the base Pandora theme
/// with dark-specific customizations.
class PandoraDarkTheme {
  // Private constructor to prevent instantiation
  PandoraDarkTheme._();

  /// Get the dark theme
  static ThemeData get theme => PandoraTheme.dark();

  /// Get dark color scheme
  static const ColorScheme colorScheme = PandoraTheme._darkColorScheme;

  /// Get dark text theme
  static final TextTheme textTheme = PandoraTheme._darkTextTheme;

  /// Get dark app bar theme
  static final AppBarTheme appBarTheme = PandoraTheme._darkAppBarTheme;

  /// Get dark button themes
  static final ElevatedButtonThemeData elevatedButtonTheme = PandoraTheme._darkElevatedButtonTheme;
  static final OutlinedButtonThemeData outlinedButtonTheme = PandoraTheme._darkOutlinedButtonTheme;
  static final TextButtonThemeData textButtonTheme = PandoraTheme._darkTextButtonTheme;

  /// Get dark card theme
  static final CardThemeData cardTheme = PandoraTheme._darkCardTheme;

  /// Get dark input decoration theme
  static final InputDecorationTheme inputDecorationTheme = PandoraTheme._darkInputDecorationTheme;

  /// Get dark chip theme
  static const ChipThemeData chipTheme = PandoraTheme._darkChipTheme;

  /// Get dark divider theme
  static const DividerThemeData dividerTheme = PandoraTheme._darkDividerTheme;

  /// Get dark bottom navigation bar theme
  static const BottomNavigationBarThemeData bottomNavigationBarTheme = PandoraTheme._darkBottomNavigationBarTheme;

  /// Get dark navigation bar theme
  static const NavigationBarThemeData navigationBarTheme = PandoraTheme._darkNavigationBarTheme;

  /// Get dark snack bar theme
  static const SnackBarThemeData snackBarTheme = PandoraTheme._darkSnackBarTheme;

  /// Get dark dialog theme
  static const DialogTheme dialogTheme = PandoraTheme._darkDialogTheme;

  /// Get dark bottom sheet theme
  static const BottomSheetThemeData bottomSheetTheme = PandoraTheme._darkBottomSheetTheme;

  /// Get dark drawer theme
  static const DrawerThemeData drawerTheme = PandoraTheme._darkDrawerTheme;

  /// Get dark list tile theme
  static const ListTileThemeData listTileTheme = PandoraTheme._darkListTileTheme;

  /// Get dark switch theme
  static const SwitchThemeData switchTheme = PandoraTheme._darkSwitchTheme;

  /// Get dark checkbox theme
  static const CheckboxThemeData checkboxTheme = PandoraTheme._darkCheckboxTheme;

  /// Get dark radio theme
  static const RadioThemeData radioTheme = PandoraTheme._darkRadioTheme;

  /// Get dark slider theme
  static const SliderThemeData sliderTheme = PandoraTheme._darkSliderTheme;

  /// Get dark progress indicator theme
  static const ProgressIndicatorThemeData progressIndicatorTheme = PandoraTheme._darkProgressIndicatorTheme;

  /// Get dark tab bar theme
  static const TabBarTheme tabBarTheme = PandoraTheme._darkTabBarTheme;

  /// Get dark tooltip theme
  static const TooltipThemeData tooltipTheme = PandoraTheme._darkTooltipTheme;

  /// Get dark popup menu theme
  static const PopupMenuThemeData popupMenuTheme = PandoraTheme._darkPopupMenuTheme;

  /// Get dark data table theme
  static const DataTableThemeData dataTableTheme = PandoraTheme._darkDataTableTheme;
}
