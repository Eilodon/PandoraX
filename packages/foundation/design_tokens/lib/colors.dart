import 'package:flutter/material.dart';

/// PandoraX color palette following "Thân Tâm Hợp Nhất" philosophy
///
/// Thân (Body): Physical foundation through consistent colors
/// Tâm (Mind): Mental harmony through intuitive color relationships
/// Hợp (Harmony): Visual balance through complementary colors
/// Nhất (Unity): Perfect integration of all color elements
class PandoraColors {
  // Primary Colors - Core brand colors
  static const Color primary = Color(0xFF6366F1); // Indigo 500
  static const Color primaryLight = Color(0xFF818CF8); // Indigo 400
  static const Color primaryDark = Color(0xFF4F46E5); // Indigo 600
  static const Color primaryContainer = Color(0xFFE0E7FF); // Indigo 100

  // Secondary Colors - Supporting brand colors
  static const Color secondary = Color(0xFF8B5CF6); // Violet 500
  static const Color secondaryLight = Color(0xFFA78BFA); // Violet 400
  static const Color secondaryDark = Color(0xFF7C3AED); // Violet 600
  static const Color secondaryContainer = Color(0xFFEDE9FE); // Violet 100

  // Accent Colors - Highlighting and emphasis
  static const Color accent = Color(0xFF06B6D4); // Cyan 500
  static const Color accentLight = Color(0xFF22D3EE); // Cyan 400
  static const Color accentDark = Color(0xFF0891B2); // Cyan 600
  static const Color accentContainer = Color(0xFFCFFAFE); // Cyan 100

  // Semantic Colors - Status and feedback
  static const Color success = Color(0xFF10B981); // Emerald 500
  static const Color successLight = Color(0xFF34D399); // Emerald 400
  static const Color successDark = Color(0xFF059669); // Emerald 600
  static const Color successContainer = Color(0xFFD1FAE5); // Emerald 100

  static const Color warning = Color(0xFFF59E0B); // Amber 500
  static const Color warningLight = Color(0xFFFBBF24); // Amber 400
  static const Color warningDark = Color(0xFFD97706); // Amber 600
  static const Color warningContainer = Color(0xFFFEF3C7); // Amber 100

  static const Color error = Color(0xFFEF4444); // Red 500
  static const Color errorLight = Color(0xFFF87171); // Red 400
  static const Color errorDark = Color(0xFFDC2626); // Red 600
  static const Color errorContainer = Color(0xFFFEE2E2); // Red 100

  static const Color info = Color(0xFF3B82F6); // Blue 500
  static const Color infoLight = Color(0xFF60A5FA); // Blue 400
  static const Color infoDark = Color(0xFF2563EB); // Blue 600
  static const Color infoContainer = Color(0xFFDBEAFE); // Blue 100

  // Neutral Colors - Text and backgrounds
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF8FAFC);
  static const Color surfaceContainer = Color(0xFFF1F5F9);
  static const Color surfaceContainerHigh = Color(0xFFE2E8F0);

  static const Color background = Color(0xFFFAFAFA);
  static const Color backgroundVariant = Color(0xFFF4F4F5);

  // Text Colors
  static const Color onSurface = Color(0xFF1E293B);
  static const Color onSurfaceVariant = Color(0xFF475569);
  static const Color onBackground = Color(0xFF0F172A);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onAccent = Color(0xFFFFFFFF);
  
  // Secondary text colors
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textTertiary = Color(0xFF94A3B8);

  // Border Colors
  static const Color outline = Color(0xFFE2E8F0);
  static const Color outlineVariant = Color(0xFFCBD5E1);
  static const Color outlineFocus = Color(0xFF6366F1);

  // Shadow Colors
  static const Color shadow = Color(0x1A000000);
  static const Color shadowLight = Color(0x0D000000);
  static const Color shadowDark = Color(0x33000000);

  // Dark Theme Colors
  static const Color darkSurface = Color(0xFF0F172A);
  static const Color darkSurfaceVariant = Color(0xFF1E293B);
  static const Color darkSurfaceContainer = Color(0xFF334155);
  static const Color darkBackground = Color(0xFF020617);
  static const Color darkOnSurface = Color(0xFFF8FAFC);
  static const Color darkOnSurfaceVariant = Color(0xFFCBD5E1);
  static const Color darkOnBackground = Color(0xFFFFFFFF);

  // Container Colors (On Colors)
  static const Color onPrimaryContainer = Color(0xFF1E1B93);
  static const Color onSecondaryContainer = Color(0xFF4C1D95);
  static const Color onErrorContainer = Color(0xFF7F1D1D);

  // Gradient Colors
  static const List<Color> primaryGradient = [
    Color(0xFF6366F1),
    Color(0xFF8B5CF6),
  ];

  static const List<Color> secondaryGradient = [
    Color(0xFF8B5CF6),
    Color(0xFF06B6D4),
  ];

  static const List<Color> successGradient = [
    Color(0xFF10B981),
    Color(0xFF34D399),
  ];

  static const List<Color> errorGradient = [
    Color(0xFFEF4444),
    Color(0xFFF87171),
  ];
}
