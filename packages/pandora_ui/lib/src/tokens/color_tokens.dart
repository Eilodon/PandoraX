import 'package:flutter/material.dart';

/// Pandora 4 Color Tokens
/// 
/// Represents the "Thân" (Body) aspect of the design system.
/// These colors form the physical foundation of our UI components.
class PandoraColors {
  // Private constructor to prevent instantiation
  PandoraColors._();

  // Primary Colors - The heart of our design system
  static const Color primary50 = Color(0xFFE8F4FD);
  static const Color primary100 = Color(0xFFB8DCFA);
  static const Color primary200 = Color(0xFF88C4F7);
  static const Color primary300 = Color(0xFF58ACF4);
  static const Color primary400 = Color(0xFF2894F1);
  static const Color primary500 = Color(0xFF1E7CE8); // Main primary
  static const Color primary600 = Color(0xFF1A6BCF);
  static const Color primary700 = Color(0xFF165AB6);
  static const Color primary800 = Color(0xFF12499D);
  static const Color primary900 = Color(0xFF0E3884);

  // Secondary Colors - Supporting the primary
  static const Color secondary50 = Color(0xFFF0F9FF);
  static const Color secondary100 = Color(0xFFE0F2FE);
  static const Color secondary200 = Color(0xFFBAE6FD);
  static const Color secondary300 = Color(0xFF7DD3FC);
  static const Color secondary400 = Color(0xFF38BDF8);
  static const Color secondary500 = Color(0xFF0EA5E9); // Main secondary
  static const Color secondary600 = Color(0xFF0284C7);
  static const Color secondary700 = Color(0xFF0369A1);
  static const Color secondary800 = Color(0xFF075985);
  static const Color secondary900 = Color(0xFF0C4A6E);

  // Neutral Colors - The foundation
  static const Color neutral50 = Color(0xFFFAFAFA);
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral200 = Color(0xFFE5E5E5);
  static const Color neutral300 = Color(0xFFD4D4D4);
  static const Color neutral400 = Color(0xFFA3A3A3);
  static const Color neutral500 = Color(0xFF737373);
  static const Color neutral600 = Color(0xFF525252);
  static const Color neutral700 = Color(0xFF404040);
  static const Color neutral800 = Color(0xFF262626);
  static const Color neutral900 = Color(0xFF171717);

  // Success Colors - Positive feedback
  static const Color success50 = Color(0xFFF0FDF4);
  static const Color success100 = Color(0xFFDCFCE7);
  static const Color success200 = Color(0xFFBBF7D0);
  static const Color success300 = Color(0xFF86EFAC);
  static const Color success400 = Color(0xFF4ADE80);
  static const Color success500 = Color(0xFF22C55E); // Main success
  static const Color success600 = Color(0xFF16A34A);
  static const Color success700 = Color(0xFF15803D);
  static const Color success800 = Color(0xFF166534);
  static const Color success900 = Color(0xFF14532D);

  // Warning Colors - Caution
  static const Color warning50 = Color(0xFFFFFBEB);
  static const Color warning100 = Color(0xFFFEF3C7);
  static const Color warning200 = Color(0xFFFDE68A);
  static const Color warning300 = Color(0xFFFCD34D);
  static const Color warning400 = Color(0xFFFBBF24);
  static const Color warning500 = Color(0xFFF59E0B); // Main warning
  static const Color warning600 = Color(0xFFD97706);
  static const Color warning700 = Color(0xFFB45309);
  static const Color warning800 = Color(0xFF92400E);
  static const Color warning900 = Color(0xFF78350F);

  // Error Colors - Negative feedback
  static const Color error50 = Color(0xFFFEF2F2);
  static const Color error100 = Color(0xFFFEE2E2);
  static const Color error200 = Color(0xFFFECACA);
  static const Color error300 = Color(0xFFFCA5A5);
  static const Color error400 = Color(0xFFF87171);
  static const Color error500 = Color(0xFFEF4444); // Main error
  static const Color error600 = Color(0xFFDC2626);
  static const Color error700 = Color(0xFFB91C1C);
  static const Color error800 = Color(0xFF991B1B);
  static const Color error900 = Color(0xFF7F1D1D);

  // Info Colors - Information
  static const Color info50 = Color(0xFFF0F9FF);
  static const Color info100 = Color(0xFFE0F2FE);
  static const Color info200 = Color(0xFFBAE6FD);
  static const Color info300 = Color(0xFF7DD3FC);
  static const Color info400 = Color(0xFF38BDF8);
  static const Color info500 = Color(0xFF0EA5E9); // Main info
  static const Color info600 = Color(0xFF0284C7);
  static const Color info700 = Color(0xFF0369A1);
  static const Color info800 = Color(0xFF075985);
  static const Color info900 = Color(0xFF0C4A6E);

  // Surface Colors - Background layers
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF8FAFC);
  static const Color surfaceContainer = Color(0xFFF1F5F9);
  static const Color surfaceContainerHigh = Color(0xFFE2E8F0);
  static const Color surfaceContainerHighest = Color(0xFFCBD5E1);

  // On Surface Colors - Text on surfaces
  static const Color onSurface = Color(0xFF1E293B);
  static const Color onSurfaceVariant = Color(0xFF475569);
  static const Color onSurfaceDisabled = Color(0xFF94A3B8);

  // Outline Colors - Borders and dividers
  static const Color outline = Color(0xFFE2E8F0);
  static const Color outlineVariant = Color(0xFFF1F5F9);
  static const Color outlineDisabled = Color(0xFFF8FAFC);

  // Special Colors
  static const Color transparent = Color(0x00000000);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color shadowColor = Color(0x1A000000);

  /// Get color by semantic name
  static Color getColor(String semanticName) {
    switch (semanticName) {
      case 'primary':
        return primary500;
      case 'secondary':
        return secondary500;
      case 'success':
        return success500;
      case 'warning':
        return warning500;
      case 'error':
        return error500;
      case 'info':
        return info500;
      case 'surface':
        return surface;
      case 'onSurface':
        return onSurface;
      case 'outline':
        return outline;
      default:
        return primary500;
    }
  }

  /// Get color with opacity
  static Color withOpacity(Color color, double opacity) {
    return color.withValues(alpha: opacity);
  }

  /// Get color with alpha
  static Color withAlpha(Color color, int alpha) {
    return color.withAlpha(alpha);
  }
}
