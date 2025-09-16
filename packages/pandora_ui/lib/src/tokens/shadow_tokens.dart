import 'package:flutter/material.dart';
import 'color_tokens.dart';

/// Pandora 4 Shadow Tokens
/// 
/// Represents the "Hợp Nhất" (Harmony and Unity) aspect of the design system.
/// These shadow styles create depth and hierarchy in our UI.
class PandoraShadows {
  // Private constructor to prevent instantiation
  PandoraShadows._();

  // Shadow Colors
  static const Color shadowColor = Color(0x1A000000); // 10% black
  static const Color shadowColorLight = Color(0x0D000000); // 5% black
  static const Color shadowColorDark = Color(0x33000000); // 20% black
  static const Color shadowColorColored = Color(0x1A1E7CE8); // 10% primary

  // Elevation Levels
  static const double elevation0 = 0.0;
  static const double elevation1 = 1.0;
  static const double elevation2 = 2.0;
  static const double elevation4 = 4.0;
  static const double elevation8 = 8.0;
  static const double elevation12 = 12.0;
  static const double elevation16 = 16.0;
  static const double elevation24 = 24.0;
  static const double elevation32 = 32.0;
  static const double elevation48 = 48.0;
  static const double elevation64 = 64.0;

  // Shadow Blur Radius
  static const double blurRadiusXs = 2.0;
  static const double blurRadiusSm = 4.0;
  static const double blurRadiusMd = 8.0;
  static const double blurRadiusLg = 16.0;
  static const double blurRadiusXl = 24.0;
  static const double blurRadius2xl = 32.0;
  static const double blurRadius3xl = 48.0;

  // Shadow Spread Radius
  static const double spreadRadiusXs = 0.0;
  static const double spreadRadiusSm = 1.0;
  static const double spreadRadiusMd = 2.0;
  static const double spreadRadiusLg = 4.0;
  static const double spreadRadiusXl = 8.0;
  static const double spreadRadius2xl = 12.0;
  static const double spreadRadius3xl = 16.0;

  // Shadow Offset
  static const Offset offsetXs = Offset(0, 1);
  static const Offset offsetSm = Offset(0, 2);
  static const Offset offsetMd = Offset(0, 4);
  static const Offset offsetLg = Offset(0, 8);
  static const Offset offsetXl = Offset(0, 12);
  static const Offset offset2xl = Offset(0, 16);
  static const Offset offset3xl = Offset(0, 24);

  // Predefined Shadows
  static const BoxShadow shadowXs = BoxShadow(
    color: shadowColorLight,
    offset: offsetXs,
    blurRadius: blurRadiusXs,
    spreadRadius: spreadRadiusXs,
  );

  static const BoxShadow shadowSm = BoxShadow(
    color: shadowColor,
    offset: offsetSm,
    blurRadius: blurRadiusSm,
    spreadRadius: spreadRadiusSm,
  );

  static const BoxShadow shadowMd = BoxShadow(
    color: shadowColor,
    offset: offsetMd,
    blurRadius: blurRadiusMd,
    spreadRadius: spreadRadiusMd,
  );

  static const BoxShadow shadowLg = BoxShadow(
    color: shadowColor,
    offset: offsetLg,
    blurRadius: blurRadiusLg,
    spreadRadius: spreadRadiusLg,
  );

  static const BoxShadow shadowXl = BoxShadow(
    color: shadowColor,
    offset: offsetXl,
    blurRadius: blurRadiusXl,
    spreadRadius: spreadRadiusXl,
  );

  static const BoxShadow shadow2xl = BoxShadow(
    color: shadowColor,
    offset: offset2xl,
    blurRadius: blurRadius2xl,
    spreadRadius: spreadRadius2xl,
  );

  static const BoxShadow shadow3xl = BoxShadow(
    color: shadowColor,
    offset: offset3xl,
    blurRadius: blurRadius3xl,
    spreadRadius: spreadRadius3xl,
  );

  // Colored Shadows
  static BoxShadow getColoredShadow({
    Color color = shadowColorColored,
    Offset offset = offsetMd,
    double blurRadius = blurRadiusMd,
    double spreadRadius = spreadRadiusMd,
  }) {
    return BoxShadow(
      color: color,
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
    );
  }

  // Multiple Shadow Layers
  static const List<BoxShadow> shadowLayersXs = [shadowXs];
  static const List<BoxShadow> shadowLayersSm = [shadowSm];
  static const List<BoxShadow> shadowLayersMd = [shadowMd];
  static const List<BoxShadow> shadowLayersLg = [shadowLg, shadowSm];
  static const List<BoxShadow> shadowLayersXl = [shadowXl, shadowMd];
  static const List<BoxShadow> shadowLayers2xl = [shadow2xl, shadowLg, shadowSm];
  static const List<BoxShadow> shadowLayers3xl = [shadow3xl, shadowXl, shadowMd];

  // Component-specific Shadows
  static const List<BoxShadow> buttonShadow = [shadowSm];
  static const List<BoxShadow> buttonShadowHover = [shadowMd];
  static const List<BoxShadow> buttonShadowPressed = [shadowXs];

  static const List<BoxShadow> cardShadow = [shadowMd];
  static const List<BoxShadow> cardShadowHover = [shadowLg];
  static const List<BoxShadow> cardShadowSelected = [shadowXl];

  static const List<BoxShadow> inputShadow = [shadowXs];
  static const List<BoxShadow> inputShadowFocus = [shadowSm];
  static const List<BoxShadow> inputShadowError = [shadowSm];

  static const List<BoxShadow> modalShadow = [shadow2xl, shadowLg];
  static const List<BoxShadow> dropdownShadow = [shadowLg, shadowSm];
  static const List<BoxShadow> tooltipShadow = [shadowMd];

  static const List<BoxShadow> appBarShadow = [shadowSm];
  static const List<BoxShadow> bottomSheetShadow = [shadowXl, shadowMd];
  static const List<BoxShadow> drawerShadow = [shadowLg];

  // Elevation-based Shadows
  static List<BoxShadow> getElevationShadow(double elevation) {
    if (elevation <= 0) return [];
    if (elevation <= 1) return shadowLayersXs;
    if (elevation <= 2) return shadowLayersSm;
    if (elevation <= 4) return shadowLayersMd;
    if (elevation <= 8) return shadowLayersLg;
    if (elevation <= 12) return shadowLayersXl;
    if (elevation <= 16) return shadowLayers2xl;
    return shadowLayers3xl;
  }

  // Material Design 3 Shadows
  static const List<BoxShadow> md3Shadow1 = [
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 1),
      blurRadius: 1,
      spreadRadius: -1,
    ),
  ];

  static const List<BoxShadow> md3Shadow2 = [
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 1),
      blurRadius: 5,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 2),
      blurRadius: 2,
      spreadRadius: -1,
    ),
  ];

  static const List<BoxShadow> md3Shadow3 = [
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 1),
      blurRadius: 8,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 3),
      blurRadius: 4,
      spreadRadius: -1,
    ),
  ];

  static const List<BoxShadow> md3Shadow4 = [
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 2),
      blurRadius: 10,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 4),
      blurRadius: 5,
      spreadRadius: -2,
    ),
  ];

  static const List<BoxShadow> md3Shadow5 = [
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 4),
      blurRadius: 14,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 6),
      blurRadius: 10,
      spreadRadius: -4,
    ),
  ];

  /// Get shadow by semantic name
  static List<BoxShadow> getShadow(String semanticName) {
    switch (semanticName) {
      case 'xs':
        return shadowLayersXs;
      case 'sm':
        return shadowLayersSm;
      case 'md':
        return shadowLayersMd;
      case 'lg':
        return shadowLayersLg;
      case 'xl':
        return shadowLayersXl;
      case '2xl':
        return shadowLayers2xl;
      case '3xl':
        return shadowLayers3xl;
      case 'button':
        return buttonShadow;
      case 'buttonHover':
        return buttonShadowHover;
      case 'buttonPressed':
        return buttonShadowPressed;
      case 'card':
        return cardShadow;
      case 'cardHover':
        return cardShadowHover;
      case 'cardSelected':
        return cardShadowSelected;
      case 'input':
        return inputShadow;
      case 'inputFocus':
        return inputShadowFocus;
      case 'inputError':
        return inputShadowError;
      case 'modal':
        return modalShadow;
      case 'dropdown':
        return dropdownShadow;
      case 'tooltip':
        return tooltipShadow;
      case 'appBar':
        return appBarShadow;
      case 'bottomSheet':
        return bottomSheetShadow;
      case 'drawer':
        return drawerShadow;
      default:
        return shadowLayersMd;
    }
  }

  /// Create custom shadow
  static BoxShadow createShadow({
    Color? color,
    Offset? offset,
    double? blurRadius,
    double? spreadRadius,
  }) {
    return BoxShadow(
      color: color ?? shadowColor,
      offset: offset ?? offsetMd,
      blurRadius: blurRadius ?? blurRadiusMd,
      spreadRadius: spreadRadius ?? spreadRadiusMd,
    );
  }

  /// Create multiple shadow layers
  static List<BoxShadow> createShadowLayers(List<BoxShadow> shadows) {
    return List.from(shadows);
  }

  /// Get shadow for specific elevation
  static List<BoxShadow> getShadowForElevation(double elevation) {
    return getElevationShadow(elevation);
  }

  /// Create colored shadow
  static List<BoxShadow> createColoredShadow(
    Color color, {
    String size = 'md',
  }) {
    final baseShadow = getShadow(size);
    return baseShadow.map((shadow) => BoxShadow(
      color: color.withValues(alpha: 0.1),
      offset: shadow.offset,
      blurRadius: shadow.blurRadius,
      spreadRadius: shadow.spreadRadius,
    )).toList();
  }
}
