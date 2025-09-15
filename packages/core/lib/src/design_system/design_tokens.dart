/// Design Tokens for Phase 4 Architecture
/// 
/// This file contains all design tokens for consistent styling
/// across the entire application.
library design_tokens;

import 'package:flutter/material.dart';

/// Design tokens for consistent styling
class DesignTokens {
  // Private constructor to prevent instantiation
  DesignTokens._();

  // ============================================================================
  // COLORS
  // ============================================================================
  
  /// Primary colors
  static const Color primary = Color(0xFF6366F1);
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryDark = Color(0xFF4F46E5);
  
  /// Secondary colors
  static const Color secondary = Color(0xFF10B981);
  static const Color secondaryLight = Color(0xFF34D399);
  static const Color secondaryDark = Color(0xFF059669);
  
  /// Neutral colors
  static const Color neutral50 = Color(0xFFF9FAFB);
  static const Color neutral100 = Color(0xFFF3F4F6);
  static const Color neutral200 = Color(0xFFE5E7EB);
  static const Color neutral300 = Color(0xFFD1D5DB);
  static const Color neutral400 = Color(0xFF9CA3AF);
  static const Color neutral500 = Color(0xFF6B7280);
  static const Color neutral600 = Color(0xFF4B5563);
  static const Color neutral700 = Color(0xFF374151);
  static const Color neutral800 = Color(0xFF1F2937);
  static const Color neutral900 = Color(0xFF111827);
  
  /// Semantic colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);
  
  /// Background colors
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color surfaceLight = Color(0xFFF8FAFC);
  static const Color surfaceDark = Color(0xFF1E293B);
  
  // ============================================================================
  // TYPOGRAPHY
  // ============================================================================
  
  /// Font families
  static const String fontFamily = 'Inter';
  static const String fontFamilyMono = 'JetBrains Mono';
  
  /// Font weights
  static const FontWeight fontWeightLight = FontWeight.w300;
  static const FontWeight fontWeightRegular = FontWeight.w400;
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightSemiBold = FontWeight.w600;
  static const FontWeight fontWeightBold = FontWeight.w700;
  
  /// Font sizes
  static const double fontSizeXs = 12.0;
  static const double fontSizeSm = 14.0;
  static const double fontSizeBase = 16.0;
  static const double fontSizeLg = 18.0;
  static const double fontSizeXl = 20.0;
  static const double fontSize2Xl = 24.0;
  static const double fontSize3Xl = 30.0;
  static const double fontSize4Xl = 36.0;
  static const double fontSize5Xl = 48.0;
  
  /// Line heights
  static const double lineHeightTight = 1.25;
  static const double lineHeightNormal = 1.5;
  static const double lineHeightRelaxed = 1.75;
  
  // ============================================================================
  // SPACING
  // ============================================================================
  
  /// Spacing scale (based on 4px grid)
  static const double spacing0 = 0.0;
  static const double spacing1 = 4.0;
  static const double spacing2 = 8.0;
  static const double spacing3 = 12.0;
  static const double spacing4 = 16.0;
  static const double spacing5 = 20.0;
  static const double spacing6 = 24.0;
  static const double spacing8 = 32.0;
  static const double spacing10 = 40.0;
  static const double spacing12 = 48.0;
  static const double spacing16 = 64.0;
  static const double spacing20 = 80.0;
  static const double spacing24 = 96.0;
  static const double spacing32 = 128.0;
  
  // ============================================================================
  // BORDERS
  // ============================================================================
  
  /// Border radius
  static const double radiusNone = 0.0;
  static const double radiusSm = 4.0;
  static const double radiusBase = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 20.0;
  static const double radius2Xl = 24.0;
  static const double radiusFull = 9999.0;
  
  /// Border widths
  static const double borderWidth0 = 0.0;
  static const double borderWidth1 = 1.0;
  static const double borderWidth2 = 2.0;
  static const double borderWidth4 = 4.0;
  
  // ============================================================================
  // SHADOWS
  // ============================================================================
  
  /// Shadow elevations
  static const List<BoxShadow> shadowSm = [
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 2.0,
      offset: Offset(0, 1),
    ),
  ];
  
  static const List<BoxShadow> shadowBase = [
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 4.0,
      offset: Offset(0, 1),
    ),
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 2.0,
      offset: Offset(0, 1),
    ),
  ];
  
  static const List<BoxShadow> shadowMd = [
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 4.0,
      offset: Offset(0, 1),
    ),
  ];
  
  static const List<BoxShadow> shadowLg = [
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 10.0,
      offset: Offset(0, 4),
    ),
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ];
  
  static const List<BoxShadow> shadowXl = [
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 20.0,
      offset: Offset(0, 8),
    ),
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 10.0,
      offset: Offset(0, 4),
    ),
  ];
  
  // ============================================================================
  // ANIMATIONS
  // ============================================================================
  
  /// Animation durations
  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationNormal = Duration(milliseconds: 300);
  static const Duration durationSlow = Duration(milliseconds: 500);
  static const Duration durationVerySlow = Duration(milliseconds: 1000);
  
  /// Animation curves
  static const Curve curveEaseIn = Curves.easeIn;
  static const Curve curveEaseOut = Curves.easeOut;
  static const Curve curveEaseInOut = Curves.easeInOut;
  static const Curve curveFastOutSlowIn = Curves.fastOutSlowIn;
  
  // ============================================================================
  // BREAKPOINTS
  // ============================================================================
  
  /// Responsive breakpoints
  static const double breakpointMobile = 600.0;
  static const double breakpointTablet = 900.0;
  static const double breakpointDesktop = 1200.0;
  static const double breakpointLargeDesktop = 1600.0;
  
  // ============================================================================
  // Z-INDEX
  // ============================================================================
  
  /// Z-index scale
  static const int zIndex0 = 0;
  static const int zIndex10 = 10;
  static const int zIndex20 = 20;
  static const int zIndex30 = 30;
  static const int zIndex40 = 40;
  static const int zIndex50 = 50;
  static const int zIndexAuto = 9999;
}
