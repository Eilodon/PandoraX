import 'package:flutter/material.dart';

/// PandoraX spacing system following "Thân Tâm Hợp Nhất" philosophy
///
/// Thân (Body): Physical foundation through consistent spacing
/// Tâm (Mind): Mental harmony through comfortable visual rhythm
/// Hợp (Harmony): Visual balance through proportional spacing
/// Nhất (Unity): Perfect integration of all spacing elements
class PandoraSpacing {
  // Base spacing unit (8px)
  static const double baseUnit = 8.0;

  // Micro spacing - For fine adjustments
  static const double xs = baseUnit * 0.25; // 2px
  static const double sm = baseUnit * 0.5;  // 4px
  static const double md = baseUnit * 0.75; // 6px

  // Standard spacing - Most commonly used
  static const double s = baseUnit * 1;     // 8px
  static const double m = baseUnit * 1.5;   // 12px
  static const double l = baseUnit * 2;     // 16px
  static const double xl = baseUnit * 2.5;  // 20px
  static const double xxl = baseUnit * 3;   // 24px

  // Large spacing - For major sections
  static const double xxxl = baseUnit * 4;  // 32px
  static const double huge = baseUnit * 5;  // 40px
  static const double massive = baseUnit * 6; // 48px
  static const double enormous = baseUnit * 8; // 64px

  // Component specific spacing
  static const double buttonPadding = l;
  static const double cardPadding = l;
  static const double screenPadding = l;
  static const double sectionSpacing = xxxl;
  static const double itemSpacing = m;

  // Border radius
  static const double radiusXs = 2;
  static const double radiusSm = 4;
  static const double radiusMd = 6;
  static const double radiusL = 8;
  static const double radiusXl = 12;
  static const double radiusXxl = 16;
  static const double radiusXxxl = 24;
  static const double radiusRound = 999;

  // Border width
  static const double borderThin = 0.5;
  static const double borderNormal = 1.0;
  static const double borderThick = 2.0;

  // Shadow elevation
  static const double elevationNone = 0;
  static const double elevationLow = 1;
  static const double elevationMedium = 2;
  static const double elevationHigh = 4;
  static const double elevationXhigh = 8;
  static const double elevationXxhigh = 16;

  // Icon sizes
  static const double iconXs = 12;
  static const double iconSm = 16;
  static const double iconMd = 20;
  static const double iconL = 24;
  static const double iconXl = 32;
  static const double iconXxl = 40;
  static const double iconXxxl = 48;

  // Avatar sizes
  static const double avatarXs = 24;
  static const double avatarSm = 32;
  static const double avatarMd = 40;
  static const double avatarL = 48;
  static const double avatarXl = 64;
  static const double avatarXxl = 80;
  static const double avatarXxxl = 96;

  // Helper methods
  static EdgeInsets paddingAll(double value) => EdgeInsets.all(value);
  static EdgeInsets paddingHorizontal(double value) => EdgeInsets.symmetric(horizontal: value);
  static EdgeInsets paddingVertical(double value) => EdgeInsets.symmetric(vertical: value);
  static EdgeInsets paddingSymmetric({required double horizontal, required double vertical}) =>
      EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);

  static EdgeInsets marginAll(double value) => EdgeInsets.all(value);
  static EdgeInsets marginHorizontal(double value) => EdgeInsets.symmetric(horizontal: value);
  static EdgeInsets marginVertical(double value) => EdgeInsets.symmetric(vertical: value);
  static EdgeInsets marginSymmetric({required double horizontal, required double vertical}) =>
      EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);

  // Common spacing combinations
  static const EdgeInsets screenPaddingEdgeInsets = EdgeInsets.all(l);
  static const EdgeInsets cardPaddingEdgeInsets = EdgeInsets.all(l);
  static const EdgeInsets buttonPaddingEdgeInsets = EdgeInsets.symmetric(horizontal: l, vertical: m);
  static const EdgeInsets inputPaddingEdgeInsets = EdgeInsets.symmetric(horizontal: l, vertical: m);
  static const EdgeInsets listItemPaddingEdgeInsets = EdgeInsets.symmetric(horizontal: l, vertical: m);
}
