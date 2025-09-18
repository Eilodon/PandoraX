import 'package:flutter/material.dart';

/// Pandora 4 Typography Tokens
/// 
/// Represents the "Tâm" (Mind) aspect of the design system.
/// These typography styles form the intellectual foundation of our UI.
class PandoraTypography {
  // Private constructor to prevent instantiation
  PandoraTypography._();

  // Font Families
  static const String primaryFontFamily = 'Inter';
  static const String secondaryFontFamily = 'Roboto';
  static const String monospaceFontFamily = 'JetBrains Mono';

  // Font Weights
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;

  // Font Sizes
  static const double fontSize2xs = 10.0;
  static const double fontSizeXs = 12.0;
  static const double fontSizeSm = 14.0;
  static const double fontSizeBase = 16.0;
  static const double fontSizeLg = 18.0;
  static const double fontSizeXl = 20.0;
  static const double fontSize2xl = 24.0;
  static const double fontSize3xl = 30.0;
  static const double fontSize4xl = 36.0;
  static const double fontSize5xl = 48.0;
  static const double fontSize6xl = 60.0;
  static const double fontSize7xl = 72.0;
  static const double fontSize8xl = 96.0;
  static const double fontSize9xl = 128.0;

  // Line Heights
  static const double lineHeightNone = 1.0;
  static const double lineHeightTight = 1.25;
  static const double lineHeightSnug = 1.375;
  static const double lineHeightNormal = 1.5;
  static const double lineHeightRelaxed = 1.625;
  static const double lineHeightLoose = 2.0;

  // Letter Spacing
  static const double letterSpacingTighter = -0.05;
  static const double letterSpacingTight = -0.025;
  static const double letterSpacingNormal = 0.0;
  static const double letterSpacingWide = 0.025;
  static const double letterSpacingWider = 0.05;
  static const double letterSpacingWidest = 0.1;

  // Display Styles - For large headings
  static const TextStyle displayLarge = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSize6xl,
    fontWeight: bold,
    height: lineHeightTight,
    letterSpacing: letterSpacingTighter,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSize5xl,
    fontWeight: bold,
    height: lineHeightTight,
    letterSpacing: letterSpacingTighter,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSize4xl,
    fontWeight: bold,
    height: lineHeightTight,
    letterSpacing: letterSpacingTight,
  );

  // Headline Styles - For section headings
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSize3xl,
    fontWeight: semiBold,
    height: lineHeightTight,
    letterSpacing: letterSpacingTight,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSize2xl,
    fontWeight: semiBold,
    height: lineHeightTight,
    letterSpacing: letterSpacingTight,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSizeXl,
    fontWeight: semiBold,
    height: lineHeightSnug,
    letterSpacing: letterSpacingNormal,
  );

  // Title Styles - For card titles and labels
  static const TextStyle titleLarge = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSizeLg,
    fontWeight: medium,
    height: lineHeightSnug,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSizeBase,
    fontWeight: medium,
    height: lineHeightSnug,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSizeSm,
    fontWeight: medium,
    height: lineHeightSnug,
    letterSpacing: letterSpacingWide,
  );

  // Body Styles - For main content
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSizeBase,
    fontWeight: regular,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSizeSm,
    fontWeight: regular,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSizeXs,
    fontWeight: regular,
    height: lineHeightNormal,
    letterSpacing: letterSpacingWide,
  );

  // Label Styles - For form labels and small text
  static const TextStyle labelLarge = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSizeSm,
    fontWeight: medium,
    height: lineHeightNormal,
    letterSpacing: letterSpacingWide,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSizeXs,
    fontWeight: medium,
    height: lineHeightNormal,
    letterSpacing: letterSpacingWide,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSize2xs,
    fontWeight: medium,
    height: lineHeightNormal,
    letterSpacing: letterSpacingWider,
  );

  // Code Styles - For monospace text
  static const TextStyle codeLarge = TextStyle(
    fontFamily: monospaceFontFamily,
    fontSize: fontSizeBase,
    fontWeight: regular,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle codeMedium = TextStyle(
    fontFamily: monospaceFontFamily,
    fontSize: fontSizeSm,
    fontWeight: regular,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle codeSmall = TextStyle(
    fontFamily: monospaceFontFamily,
    fontSize: fontSizeXs,
    fontWeight: regular,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
  );

  // Caption Styles - For captions and fine print
  static const TextStyle caption = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSize2xs,
    fontWeight: regular,
    height: lineHeightNormal,
    letterSpacing: letterSpacingWide,
  );

  // Overline Styles - For overlines and small caps
  static const TextStyle overline = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSize2xs,
    fontWeight: medium,
    height: lineHeightNormal,
    letterSpacing: letterSpacingWidest,
  );

  /// Get text style by semantic name
  static TextStyle getTextStyle(String semanticName) {
    switch (semanticName) {
      case 'displayLarge':
        return displayLarge;
      case 'displayMedium':
        return displayMedium;
      case 'displaySmall':
        return displaySmall;
      case 'headlineLarge':
        return headlineLarge;
      case 'headlineMedium':
        return headlineMedium;
      case 'headlineSmall':
        return headlineSmall;
      case 'titleLarge':
        return titleLarge;
      case 'titleMedium':
        return titleMedium;
      case 'titleSmall':
        return titleSmall;
      case 'bodyLarge':
        return bodyLarge;
      case 'bodyMedium':
        return bodyMedium;
      case 'bodySmall':
        return bodySmall;
      case 'labelLarge':
        return labelLarge;
      case 'labelMedium':
        return labelMedium;
      case 'labelSmall':
        return labelSmall;
      case 'codeLarge':
        return codeLarge;
      case 'codeMedium':
        return codeMedium;
      case 'codeSmall':
        return codeSmall;
      case 'caption':
        return caption;
      case 'overline':
        return overline;
      default:
        return bodyMedium;
    }
  }

  /// Create custom text style
  static TextStyle createStyle({
    String? fontFamily,
    double? fontSize,
    FontWeight? fontWeight,
    double? height,
    double? letterSpacing,
    Color? color,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? primaryFontFamily,
      fontSize: fontSize ?? fontSizeBase,
      fontWeight: fontWeight ?? regular,
      height: height ?? lineHeightNormal,
      letterSpacing: letterSpacing ?? letterSpacingNormal,
      color: color,
      decoration: decoration,
    );
  }
}
