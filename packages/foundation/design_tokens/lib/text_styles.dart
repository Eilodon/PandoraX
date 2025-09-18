import 'package:flutter/material.dart';
import 'colors.dart';
import 'typography.dart';

/// PandoraX text styles following "Thân Tâm Hợp Nhất" philosophy
///
/// Thân (Body): Physical foundation through consistent text styles
/// Tâm (Mind): Mental harmony through readable and beautiful text
/// Hợp (Harmony): Visual balance through proper text hierarchy
/// Nhất (Unity): Perfect integration of all text elements
class PandoraTextStyles {
  // Display styles
  static const TextStyle displayLarge = PandoraTypography.displayLarge;
  static const TextStyle displayMedium = PandoraTypography.displayMedium;
  static const TextStyle displaySmall = PandoraTypography.displaySmall;

  // Headline styles
  static const TextStyle headlineLarge = PandoraTypography.headlineLarge;
  static const TextStyle headlineMedium = PandoraTypography.headlineMedium;
  static const TextStyle headlineSmall = PandoraTypography.headlineSmall;

  // Title styles
  static const TextStyle titleLarge = PandoraTypography.titleLarge;
  static const TextStyle titleMedium = PandoraTypography.titleMedium;
  static const TextStyle titleSmall = PandoraTypography.titleSmall;

  // Body styles
  static const TextStyle bodyLarge = PandoraTypography.bodyLarge;
  static const TextStyle bodyMedium = PandoraTypography.bodyMedium;
  static const TextStyle bodySmall = PandoraTypography.bodySmall;

  // Label styles
  static const TextStyle labelLarge = PandoraTypography.labelLarge;
  static const TextStyle labelMedium = PandoraTypography.labelMedium;
  static const TextStyle labelSmall = PandoraTypography.labelSmall;

  // Button styles
  static const TextStyle buttonLarge = PandoraTypography.buttonLarge;
  static const TextStyle buttonMedium = PandoraTypography.buttonMedium;
  static const TextStyle buttonSmall = PandoraTypography.buttonSmall;

  // Code styles
  static const TextStyle codeLarge = PandoraTypography.codeLarge;
  static const TextStyle codeMedium = PandoraTypography.codeMedium;
  static const TextStyle codeSmall = PandoraTypography.codeSmall;

  // Special styles
  static const TextStyle caption = PandoraTypography.caption;
  static const TextStyle overline = PandoraTypography.overline;

  // Helper methods
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }

  static TextStyle withSize(TextStyle style, double size) {
    return style.copyWith(fontSize: size);
  }

  // Color variants
  static TextStyle primary(TextStyle style) {
    return style.copyWith(color: PandoraColors.primary);
  }

  static TextStyle secondary(TextStyle style) {
    return style.copyWith(color: PandoraColors.secondary);
  }

  static TextStyle error(TextStyle style) {
    return style.copyWith(color: PandoraColors.error);
  }

  static TextStyle success(TextStyle style) {
    return style.copyWith(color: PandoraColors.success);
  }

  static TextStyle warning(TextStyle style) {
    return style.copyWith(color: PandoraColors.warning);
  }

  static TextStyle info(TextStyle style) {
    return style.copyWith(color: PandoraColors.info);
  }

  static TextStyle onSurface(TextStyle style) {
    return style.copyWith(color: PandoraColors.onSurface);
  }

  static TextStyle onSurfaceVariant(TextStyle style) {
    return style.copyWith(color: PandoraColors.onSurfaceVariant);
  }

  static TextStyle onBackground(TextStyle style) {
    return style.copyWith(color: PandoraColors.onBackground);
  }

  // Dark theme variants
  static TextStyle darkOnSurface(TextStyle style) {
    return style.copyWith(color: PandoraColors.darkOnSurface);
  }

  static TextStyle darkOnSurfaceVariant(TextStyle style) {
    return style.copyWith(color: PandoraColors.darkOnSurfaceVariant);
  }

  static TextStyle darkOnBackground(TextStyle style) {
    return style.copyWith(color: PandoraColors.darkOnBackground);
  }
}
