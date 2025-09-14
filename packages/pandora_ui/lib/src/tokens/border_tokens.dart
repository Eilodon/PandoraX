import 'package:flutter/material.dart';
import 'spacing_tokens.dart';

/// Pandora 4 Border Tokens
/// 
/// Represents the "Nhất" (Unity) aspect of the design system.
/// These border styles create visual boundaries and structure.
class PandoraBorders {
  // Private constructor to prevent instantiation
  PandoraBorders._();

  // Border Widths
  static const double borderWidth0 = 0.0;
  static const double borderWidth1 = 1.0;
  static const double borderWidth2 = 2.0;
  static const double borderWidth4 = 4.0;
  static const double borderWidth8 = 8.0;

  // Border Styles
  static const BorderStyle solid = BorderStyle.solid;
  static const BorderStyle dashed = BorderStyle.solid; // Flutter doesn't support dashed directly
  static const BorderStyle dotted = BorderStyle.solid; // Flutter doesn't support dotted directly
  static const BorderStyle none = BorderStyle.none;

  // Border Radius - Using spacing tokens
  static const double radiusXs = PandoraSpacing.radiusXs;
  static const double radiusSm = PandoraSpacing.radiusSm;
  static const double radiusMd = PandoraSpacing.radiusMd;
  static const double radiusLg = PandoraSpacing.radiusLg;
  static const double radiusXl = PandoraSpacing.radiusXl;
  static const double radius2xl = PandoraSpacing.radius2xl;
  static const double radius3xl = PandoraSpacing.radius3xl;
  static const double radiusFull = PandoraSpacing.radiusFull;

  // Predefined Border Radius
  static const BorderRadius borderRadiusXs = BorderRadius.all(Radius.circular(radiusXs));
  static const BorderRadius borderRadiusSm = BorderRadius.all(Radius.circular(radiusSm));
  static const BorderRadius borderRadiusMd = BorderRadius.all(Radius.circular(radiusMd));
  static const BorderRadius borderRadiusLg = BorderRadius.all(Radius.circular(radiusLg));
  static const BorderRadius borderRadiusXl = BorderRadius.all(Radius.circular(radiusXl));
  static const BorderRadius borderRadius2xl = BorderRadius.all(Radius.circular(radius2xl));
  static const BorderRadius borderRadius3xl = BorderRadius.all(Radius.circular(radius3xl));
  static const BorderRadius borderRadiusFull = BorderRadius.all(Radius.circular(radiusFull));

  // Asymmetric Border Radius
  static const BorderRadius borderRadiusTopXs = BorderRadius.only(
    topLeft: Radius.circular(radiusXs),
    topRight: Radius.circular(radiusXs),
  );
  static const BorderRadius borderRadiusTopSm = BorderRadius.only(
    topLeft: Radius.circular(radiusSm),
    topRight: Radius.circular(radiusSm),
  );
  static const BorderRadius borderRadiusTopMd = BorderRadius.only(
    topLeft: Radius.circular(radiusMd),
    topRight: Radius.circular(radiusMd),
  );
  static const BorderRadius borderRadiusTopLg = BorderRadius.only(
    topLeft: Radius.circular(radiusLg),
    topRight: Radius.circular(radiusLg),
  );

  static const BorderRadius borderRadiusBottomXs = BorderRadius.only(
    bottomLeft: Radius.circular(radiusXs),
    bottomRight: Radius.circular(radiusXs),
  );
  static const BorderRadius borderRadiusBottomSm = BorderRadius.only(
    bottomLeft: Radius.circular(radiusSm),
    bottomRight: Radius.circular(radiusSm),
  );
  static const BorderRadius borderRadiusBottomMd = BorderRadius.only(
    bottomLeft: Radius.circular(radiusMd),
    bottomRight: Radius.circular(radiusMd),
  );
  static const BorderRadius borderRadiusBottomLg = BorderRadius.only(
    bottomLeft: Radius.circular(radiusLg),
    bottomRight: Radius.circular(radiusLg),
  );

  static const BorderRadius borderRadiusLeftXs = BorderRadius.only(
    topLeft: Radius.circular(radiusXs),
    bottomLeft: Radius.circular(radiusXs),
  );
  static const BorderRadius borderRadiusLeftSm = BorderRadius.only(
    topLeft: Radius.circular(radiusSm),
    bottomLeft: Radius.circular(radiusSm),
  );
  static const BorderRadius borderRadiusLeftMd = BorderRadius.only(
    topLeft: Radius.circular(radiusMd),
    bottomLeft: Radius.circular(radiusMd),
  );
  static const BorderRadius borderRadiusLeftLg = BorderRadius.only(
    topLeft: Radius.circular(radiusLg),
    bottomLeft: Radius.circular(radiusLg),
  );

  static const BorderRadius borderRadiusRightXs = BorderRadius.only(
    topRight: Radius.circular(radiusXs),
    bottomRight: Radius.circular(radiusXs),
  );
  static const BorderRadius borderRadiusRightSm = BorderRadius.only(
    topRight: Radius.circular(radiusSm),
    bottomRight: Radius.circular(radiusSm),
  );
  static const BorderRadius borderRadiusRightMd = BorderRadius.only(
    topRight: Radius.circular(radiusMd),
    bottomRight: Radius.circular(radiusMd),
  );
  static const BorderRadius borderRadiusRightLg = BorderRadius.only(
    topRight: Radius.circular(radiusLg),
    bottomRight: Radius.circular(radiusLg),
  );

  // Predefined Borders
  static Border getBorder({
    double width = borderWidth1,
    Color color = Colors.grey,
    BorderStyle style = solid,
    double? radius,
  }) {
    return Border.all(
      width: width,
      color: color,
      style: style,
    );
  }

  static Border getBorderRadius({
    double width = borderWidth1,
    Color color = Colors.grey,
    BorderStyle style = solid,
    double radius = radiusMd,
  }) {
    return Border.all(
      width: width,
      color: color,
      style: style,
    );
  }

  // Component-specific borders
  static Border getButtonBorder({
    double width = borderWidth1,
    Color color = Colors.grey,
    BorderStyle style = solid,
  }) {
    return Border.all(
      width: width,
      color: color,
      style: style,
    );
  }

  static Border getCardBorder({
    double width = borderWidth1,
    Color color = Colors.grey,
    BorderStyle style = solid,
  }) {
    return Border.all(
      width: width,
      color: color,
      style: style,
    );
  }

  static Border getInputBorder({
    double width = borderWidth1,
    Color color = Colors.grey,
    BorderStyle style = solid,
  }) {
    return Border.all(
      width: width,
      color: color,
      style: style,
    );
  }

  static Border getDividerBorder({
    double width = borderWidth1,
    Color color = Colors.grey,
    BorderStyle style = solid,
  }) {
    return Border.all(
      width: width,
      color: color,
      style: style,
    );
  }

  // Decoration helpers
  static BoxDecoration getBoxDecoration({
    Color? color,
    Border? border,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
    Gradient? gradient,
  }) {
    return BoxDecoration(
      color: color,
      border: border,
      borderRadius: borderRadius,
      boxShadow: boxShadow,
      gradient: gradient,
    );
  }

  static BoxDecoration getCardDecoration({
    Color? color,
    Border? border,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
  }) {
    return BoxDecoration(
      color: color,
      border: border ?? getCardBorder(),
      borderRadius: borderRadius ?? borderRadiusMd,
      boxShadow: boxShadow,
    );
  }

  static BoxDecoration getButtonDecoration({
    Color? color,
    Border? border,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
    Gradient? gradient,
  }) {
    return BoxDecoration(
      color: color,
      border: border ?? getButtonBorder(),
      borderRadius: borderRadius ?? borderRadiusMd,
      boxShadow: boxShadow,
      gradient: gradient,
    );
  }

  static BoxDecoration getInputDecoration({
    Color? color,
    Border? border,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
  }) {
    return BoxDecoration(
      color: color,
      border: border ?? getInputBorder(),
      borderRadius: borderRadius ?? borderRadiusMd,
      boxShadow: boxShadow,
    );
  }

  /// Get border radius by semantic name
  static BorderRadius getBorderRadius(String semanticName) {
    switch (semanticName) {
      case 'xs':
        return borderRadiusXs;
      case 'sm':
        return borderRadiusSm;
      case 'md':
        return borderRadiusMd;
      case 'lg':
        return borderRadiusLg;
      case 'xl':
        return borderRadiusXl;
      case '2xl':
        return borderRadius2xl;
      case '3xl':
        return borderRadius3xl;
      case 'full':
        return borderRadiusFull;
      case 'top-xs':
        return borderRadiusTopXs;
      case 'top-sm':
        return borderRadiusTopSm;
      case 'top-md':
        return borderRadiusTopMd;
      case 'top-lg':
        return borderRadiusTopLg;
      case 'bottom-xs':
        return borderRadiusBottomXs;
      case 'bottom-sm':
        return borderRadiusBottomMd;
      case 'bottom-md':
        return borderRadiusBottomMd;
      case 'bottom-lg':
        return borderRadiusBottomLg;
      case 'left-xs':
        return borderRadiusLeftXs;
      case 'left-sm':
        return borderRadiusLeftSm;
      case 'left-md':
        return borderRadiusLeftMd;
      case 'left-lg':
        return borderRadiusLeftLg;
      case 'right-xs':
        return borderRadiusRightXs;
      case 'right-sm':
        return borderRadiusRightSm;
      case 'right-md':
        return borderRadiusRightMd;
      case 'right-lg':
        return borderRadiusRightLg;
      default:
        return borderRadiusMd;
    }
  }

  /// Get border width by semantic name
  static double getBorderWidth(String semanticName) {
    switch (semanticName) {
      case '0':
        return borderWidth0;
      case '1':
        return borderWidth1;
      case '2':
        return borderWidth2;
      case '4':
        return borderWidth4;
      case '8':
        return borderWidth8;
      default:
        return borderWidth1;
    }
  }

  /// Create custom border radius
  static BorderRadius createBorderRadius({
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
    double? all,
  }) {
    if (all != null) {
      return BorderRadius.all(Radius.circular(all));
    }
    
    return BorderRadius.only(
      topLeft: Radius.circular(topLeft ?? 0),
      topRight: Radius.circular(topRight ?? 0),
      bottomLeft: Radius.circular(bottomLeft ?? 0),
      bottomRight: Radius.circular(bottomRight ?? 0),
    );
  }
}
