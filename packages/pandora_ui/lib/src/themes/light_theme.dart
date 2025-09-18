import 'package:flutter/material.dart';
import 'pandora_theme.dart';

/// Pandora 4 Light Theme
/// 
/// A specialized light theme that extends the base Pandora theme
/// with light-specific customizations.
class PandoraLightTheme {
  // Private constructor to prevent instantiation
  PandoraLightTheme._();

  /// Get the light theme
  static ThemeData get theme => PandoraTheme.light();

  /// Get light color scheme
  static const ColorScheme colorScheme = PandoraTheme._lightColorScheme;

  /// Get light text theme
  static final TextTheme textTheme = PandoraTheme._lightTextTheme;

  /// Get light app bar theme
  static final AppBarTheme appBarTheme = PandoraTheme._lightAppBarTheme;

  /// Get light button themes
  static final ElevatedButtonThemeData elevatedButtonTheme = PandoraTheme._lightElevatedButtonTheme;
  static final OutlinedButtonThemeData outlinedButtonTheme = PandoraTheme._lightOutlinedButtonTheme;
  static final TextButtonThemeData textButtonTheme = PandoraTheme._lightTextButtonTheme;

  /// Get light card theme
  static final CardThemeData cardTheme = PandoraTheme._lightCardTheme;

  /// Get light input decoration theme
  static final InputDecorationTheme inputDecorationTheme = PandoraTheme._lightInputDecorationTheme;

  /// Get light chip theme
  static const ChipThemeData chipTheme = PandoraTheme._lightChipTheme;

  /// Get light divider theme
  static const DividerThemeData dividerTheme = PandoraTheme._lightDividerTheme;

  /// Get light bottom navigation bar theme
  static const BottomNavigationBarThemeData bottomNavigationBarTheme = PandoraTheme._lightBottomNavigationBarTheme;

  /// Get light navigation bar theme
  static const NavigationBarThemeData navigationBarTheme = PandoraTheme._lightNavigationBarTheme;

  /// Get light snack bar theme
  static const SnackBarThemeData snackBarTheme = PandoraTheme._lightSnackBarTheme;

  /// Get light dialog theme
  static const DialogTheme dialogTheme = PandoraTheme._lightDialogTheme;

  /// Get light bottom sheet theme
  static const BottomSheetThemeData bottomSheetTheme = PandoraTheme._lightBottomSheetTheme;

  /// Get light drawer theme
  static const DrawerThemeData drawerTheme = PandoraTheme._lightDrawerTheme;

  /// Get light list tile theme
  static const ListTileThemeData listTileTheme = PandoraTheme._lightListTileTheme;

  /// Get light switch theme
  static const SwitchThemeData switchTheme = PandoraTheme._lightSwitchTheme;

  /// Get light checkbox theme
  static const CheckboxThemeData checkboxTheme = PandoraTheme._lightCheckboxTheme;

  /// Get light radio theme
  static const RadioThemeData radioTheme = PandoraTheme._lightRadioTheme;

  /// Get light slider theme
  static const SliderThemeData sliderTheme = PandoraTheme._lightSliderTheme;

  /// Get light progress indicator theme
  static const ProgressIndicatorThemeData progressIndicatorTheme = PandoraTheme._lightProgressIndicatorTheme;

  /// Get light tab bar theme
  static const TabBarTheme tabBarTheme = PandoraTheme._lightTabBarTheme;

  /// Get light tooltip theme
  static const TooltipThemeData tooltipTheme = PandoraTheme._lightTooltipTheme;

  /// Get light popup menu theme
  static const PopupMenuThemeData popupMenuTheme = PandoraTheme._lightPopupMenuTheme;

  /// Get light data table theme
  static const DataTableThemeData dataTableTheme = PandoraTheme._lightDataTableTheme;
}
