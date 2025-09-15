// file: packages/pandora_ui/lib/src/tokens.dart
import 'package:flutter/material.dart';

// --- Bảng màu Pandora 4 (dựa trên phân tích) ---
class AppColors {
  static const Color primary = Color(0xFF43DCDA);
  static const Color accent = Color(0xFF981DAA);
  static const Color background = Color(0xFF121212);
  static const Color surface = Color(0xFF1E1E1E);
  static const Color onPrimary = Colors.black;
  static const Color onSurface = Color(0xFFE0E0E0);
  static const Color onSurfaceVariant = Color(0xFF9E9E9E);
  static const Color error = Color(0xFFCF6679);

  // Security Cues
  static const Color secureOnDevice = Color(0xFF81C784); // Green
  static const Color secureHybrid = Color(0xFF64B5F6);   // Blue
  static const Color secureCloud = Color(0xFF9575CD);    // Purple
  
  // Warning colors
  static const Color warning500 = Color(0xFFFF9800);
}

// --- Pandora Colors (comprehensive color system) ---
// Note: PandoraColors is now defined in color_tokens.dart to avoid conflicts
// This file only contains the legacy AppColors and PTokens for backward compatibility

// --- Hệ thống Tokens ---
class PTokens {
  // Spacing tokens - static const for const expressions
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 12.0;
  static const double spacingLg = 16.0;
  static const double spacingXl = 24.0;
  
  // Instance getters for backward compatibility
  static const spacing = _Spacing();
  static const radius = _Radius();
  static const elevation = _Elevation();
  static const typography = _Typography();
  static const icon = _Icon();
  static const opacity = _Opacity();
  static const duration = _Duration();
}

// --- Định nghĩa chi tiết từng loại Token ---
class _Spacing {
  const _Spacing();
  double get xs => PTokens.spacingXs;
  double get sm => PTokens.spacingSm;
  double get md => PTokens.spacingMd;
  double get lg => PTokens.spacingLg;
  double get xl => PTokens.spacingXl;
}

class _Radius {
  const _Radius();
  final BorderRadius chip = const BorderRadius.all(Radius.circular(12.0));
  final BorderRadius card = const BorderRadius.all(Radius.circular(16.0));
}

class _Elevation {
  const _Elevation();
  final double chip = 2.0;
  final double card = 6.0;
}

class _Typography {
  const _Typography();
  // Dựa trên phân tích từ PDF
  final TextStyle label = const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.onSurface);
  final TextStyle labelLarge = const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.onSurface);
  final TextStyle body = const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.onSurfaceVariant);
  final TextStyle bodySmall = const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.onSurfaceVariant);
  final TextStyle bodyMedium = const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.onSurfaceVariant);
  final TextStyle bodyLarge = const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.onSurfaceVariant);
  final TextStyle title = const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: AppColors.onSurface);
  final TextStyle titleLarge = const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.onSurface);
  final TextStyle titleMedium = const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.onSurface);
  final TextStyle titleSmall = const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.onSurface);
  final TextStyle headlineSmall = const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.onSurface);
  final TextStyle labelSmall = const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.onSurfaceVariant);
}

class _Icon {
  const _Icon();
  final double size = 20.0;
  final double strokeWidth = 2.25;
}

class _Opacity {
  const _Opacity();
  final double armed = 0.6;
  final double disabled = 0.3;
}

class _Duration {
  const _Duration();
  final Duration short = const Duration(milliseconds: 150);
  final Duration medium = const Duration(milliseconds: 250);
}
