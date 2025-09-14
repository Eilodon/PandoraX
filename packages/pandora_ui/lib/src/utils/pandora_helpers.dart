import 'package:flutter/material.dart';
import '../tokens/color_tokens.dart';
import '../tokens/typography_tokens.dart';
import '../tokens/spacing_tokens.dart';
import '../tokens/border_tokens.dart';
import '../tokens/shadow_tokens.dart';

/// Pandora 4 Helpers
/// 
/// Utility functions that make it easier to work with design tokens
/// and create consistent UI components following "Thân Tâm Hợp Nhất" philosophy.
class PandoraHelpers {
  // Private constructor to prevent instantiation
  PandoraHelpers._();

  /// Create a responsive breakpoint
  static T responsive<T>({
    required T mobile,
    T? tablet,
    T? desktop,
    required double screenWidth,
  }) {
    if (screenWidth < 600) {
      return mobile;
    } else if (screenWidth < 900) {
      return tablet ?? mobile;
    } else {
      return desktop ?? tablet ?? mobile;
    }
  }

  /// Create a responsive spacing
  static double responsiveSpacing(double baseSpacing, double screenWidth) {
    return PandoraSpacing.getResponsiveSpacing(screenWidth, baseSpacing);
  }

  /// Create a color with opacity
  static Color colorWithOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  /// Create a color with alpha
  static Color colorWithAlpha(Color color, int alpha) {
    return color.withAlpha(alpha);
  }

  /// Create a gradient
  static LinearGradient createLinearGradient({
    required List<Color> colors,
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
    List<double>? stops,
  }) {
    return LinearGradient(
      colors: colors,
      begin: begin,
      end: end,
      stops: stops,
    );
  }

  /// Create a radial gradient
  static RadialGradient createRadialGradient({
    required List<Color> colors,
    AlignmentGeometry center = Alignment.center,
    double radius = 0.5,
    List<double>? stops,
  }) {
    return RadialGradient(
      colors: colors,
      center: center,
      radius: radius,
      stops: stops,
    );
  }

  /// Create a sweep gradient
  static SweepGradient createSweepGradient({
    required List<Color> colors,
    AlignmentGeometry center = Alignment.center,
    double startAngle = 0.0,
    double endAngle = 6.28318, // 2 * pi
    List<double>? stops,
  }) {
    return SweepGradient(
      colors: colors,
      center: center,
      startAngle: startAngle,
      endAngle: endAngle,
      stops: stops,
    );
  }

  /// Create a box decoration
  static BoxDecoration createBoxDecoration({
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

  /// Create a button decoration
  static BoxDecoration createButtonDecoration({
    Color? color,
    Border? border,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
    Gradient? gradient,
  }) {
    return BoxDecoration(
      color: color,
      border: border ?? PandoraBorders.getButtonBorder(),
      borderRadius: borderRadius ?? PandoraBorders.borderRadiusMd,
      boxShadow: boxShadow ?? PandoraShadows.buttonShadow,
      gradient: gradient,
    );
  }

  /// Create a card decoration
  static BoxDecoration createCardDecoration({
    Color? color,
    Border? border,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
  }) {
    return BoxDecoration(
      color: color,
      border: border ?? PandoraBorders.getCardBorder(),
      borderRadius: borderRadius ?? PandoraBorders.borderRadiusLg,
      boxShadow: boxShadow ?? PandoraShadows.cardShadow,
    );
  }

  /// Create an input decoration
  static BoxDecoration createInputDecoration({
    Color? color,
    Border? border,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
  }) {
    return BoxDecoration(
      color: color,
      border: border ?? PandoraBorders.getInputBorder(),
      borderRadius: borderRadius ?? PandoraBorders.borderRadiusMd,
      boxShadow: boxShadow ?? PandoraShadows.inputShadow,
    );
  }

  /// Create a text style
  static TextStyle createTextStyle({
    String? fontFamily,
    double? fontSize,
    FontWeight? fontWeight,
    double? height,
    double? letterSpacing,
    Color? color,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? PandoraTypography.primaryFontFamily,
      fontSize: fontSize ?? PandoraTypography.fontSizeBase,
      fontWeight: fontWeight ?? PandoraTypography.regular,
      height: height ?? PandoraTypography.lineHeightNormal,
      letterSpacing: letterSpacing ?? PandoraTypography.letterSpacingNormal,
      color: color,
      decoration: decoration,
    );
  }

  /// Create a button text style
  static TextStyle createButtonTextStyle({
    Color? color,
    FontWeight? fontWeight,
  }) {
    return PandoraTypography.labelLarge.copyWith(
      color: color,
      fontWeight: fontWeight ?? PandoraTypography.medium,
    );
  }

  /// Create a heading text style
  static TextStyle createHeadingTextStyle({
    String size = 'medium',
    Color? color,
    FontWeight? fontWeight,
  }) {
    switch (size) {
      case 'large':
        return PandoraTypography.headlineLarge.copyWith(
          color: color,
          fontWeight: fontWeight,
        );
      case 'medium':
        return PandoraTypography.headlineMedium.copyWith(
          color: color,
          fontWeight: fontWeight,
        );
      case 'small':
        return PandoraTypography.headlineSmall.copyWith(
          color: color,
          fontWeight: fontWeight,
        );
      default:
        return PandoraTypography.headlineMedium.copyWith(
          color: color,
          fontWeight: fontWeight,
        );
    }
  }

  /// Create a body text style
  static TextStyle createBodyTextStyle({
    String size = 'medium',
    Color? color,
    FontWeight? fontWeight,
  }) {
    switch (size) {
      case 'large':
        return PandoraTypography.bodyLarge.copyWith(
          color: color,
          fontWeight: fontWeight,
        );
      case 'medium':
        return PandoraTypography.bodyMedium.copyWith(
          color: color,
          fontWeight: fontWeight,
        );
      case 'small':
        return PandoraTypography.bodySmall.copyWith(
          color: color,
          fontWeight: fontWeight,
        );
      default:
        return PandoraTypography.bodyMedium.copyWith(
          color: color,
          fontWeight: fontWeight,
        );
    }
  }

  /// Create a label text style
  static TextStyle createLabelTextStyle({
    String size = 'medium',
    Color? color,
    FontWeight? fontWeight,
  }) {
    switch (size) {
      case 'large':
        return PandoraTypography.labelLarge.copyWith(
          color: color,
          fontWeight: fontWeight,
        );
      case 'medium':
        return PandoraTypography.labelMedium.copyWith(
          color: color,
          fontWeight: fontWeight,
        );
      case 'small':
        return PandoraTypography.labelSmall.copyWith(
          color: color,
          fontWeight: fontWeight,
        );
      default:
        return PandoraTypography.labelMedium.copyWith(
          color: color,
          fontWeight: fontWeight,
        );
    }
  }

  /// Create a code text style
  static TextStyle createCodeTextStyle({
    String size = 'medium',
    Color? color,
    FontWeight? fontWeight,
  }) {
    switch (size) {
      case 'large':
        return PandoraTypography.codeLarge.copyWith(
          color: color,
          fontWeight: fontWeight,
        );
      case 'medium':
        return PandoraTypography.codeMedium.copyWith(
          color: color,
          fontWeight: fontWeight,
        );
      case 'small':
        return PandoraTypography.codeSmall.copyWith(
          color: color,
          fontWeight: fontWeight,
        );
      default:
        return PandoraTypography.codeMedium.copyWith(
          color: color,
          fontWeight: fontWeight,
        );
    }
  }

  /// Create a padding
  static EdgeInsets createPadding({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return EdgeInsets.only(
      top: top ?? vertical ?? all ?? 0,
      bottom: bottom ?? vertical ?? all ?? 0,
      left: left ?? horizontal ?? all ?? 0,
      right: right ?? horizontal ?? all ?? 0,
    );
  }

  /// Create a margin
  static EdgeInsets createMargin({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return EdgeInsets.only(
      top: top ?? vertical ?? all ?? 0,
      bottom: bottom ?? vertical ?? all ?? 0,
      left: left ?? horizontal ?? all ?? 0,
      right: right ?? horizontal ?? all ?? 0,
    );
  }

  /// Create a border radius
  static BorderRadius createBorderRadius({
    double? all,
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
  }) {
    if (all != null) {
      return BorderRadius.circular(all);
    }
    
    return BorderRadius.only(
      topLeft: Radius.circular(topLeft ?? 0),
      topRight: Radius.circular(topRight ?? 0),
      bottomLeft: Radius.circular(bottomLeft ?? 0),
      bottomRight: Radius.circular(bottomRight ?? 0),
    );
  }

  /// Create a border
  static Border createBorder({
    double width = 1.0,
    Color color = Colors.grey,
    BorderStyle style = BorderStyle.solid,
  }) {
    return Border.all(
      width: width,
      color: color,
      style: style,
    );
  }

  /// Create a box shadow
  static BoxShadow createBoxShadow({
    Color? color,
    Offset? offset,
    double? blurRadius,
    double? spreadRadius,
  }) {
    return BoxShadow(
      color: color ?? PandoraColors.shadowColor,
      offset: offset ?? PandoraShadows.offsetMd,
      blurRadius: blurRadius ?? PandoraShadows.blurRadiusMd,
      spreadRadius: spreadRadius ?? PandoraShadows.spreadRadiusMd,
    );
  }

  /// Create a list of box shadows
  static List<BoxShadow> createBoxShadows({
    String size = 'md',
    Color? color,
  }) {
    if (color != null) {
      return PandoraShadows.createColoredShadow(color, size: size);
    }
    return PandoraShadows.getShadow(size);
  }

  /// Create a size
  static Size createSize({
    double? width,
    double? height,
  }) {
    return Size(width ?? 0, height ?? 0);
  }

  /// Create an offset
  static Offset createOffset({
    double? x,
    double? y,
  }) {
    return Offset(x ?? 0, y ?? 0);
  }

  /// Create a duration
  static Duration createDuration({
    int milliseconds = 300,
    int seconds = 0,
    int minutes = 0,
    int hours = 0,
    int days = 0,
  }) {
    return Duration(
      milliseconds: milliseconds,
      seconds: seconds,
      minutes: minutes,
      hours: hours,
      days: days,
    );
  }

  /// Create a curve
  static Curve createCurve({
    String type = 'easeInOut',
  }) {
    switch (type) {
      case 'linear':
        return Curves.linear;
      case 'easeIn':
        return Curves.easeIn;
      case 'easeOut':
        return Curves.easeOut;
      case 'easeInOut':
        return Curves.easeInOut;
      case 'fastOutSlowIn':
        return Curves.fastOutSlowIn;
      case 'bounceIn':
        return Curves.bounceIn;
      case 'bounceOut':
        return Curves.bounceOut;
      case 'bounceInOut':
        return Curves.bounceInOut;
      case 'elasticIn':
        return Curves.elasticIn;
      case 'elasticOut':
        return Curves.elasticOut;
      case 'elasticInOut':
        return Curves.elasticInOut;
      default:
        return Curves.easeInOut;
    }
  }

  /// Create an animation controller
  static AnimationController createAnimationController({
    required TickerProvider vsync,
    Duration duration = const Duration(milliseconds: 300),
    Duration? reverseDuration,
    double lowerBound = 0.0,
    double upperBound = 1.0,
  }) {
    return AnimationController(
      vsync: vsync,
      duration: duration,
      reverseDuration: reverseDuration,
      lowerBound: lowerBound,
      upperBound: upperBound,
    );
  }

  /// Create a tween
  static Tween<T> createTween<T>({
    required T begin,
    required T end,
  }) {
    return Tween<T>(begin: begin, end: end);
  }

  /// Create a color tween
  static ColorTween createColorTween({
    required Color begin,
    required Color end,
  }) {
    return ColorTween(begin: begin, end: end);
  }

  /// Create a size tween
  static SizeTween createSizeTween({
    required Size begin,
    required Size end,
  }) {
    return SizeTween(begin: begin, end: end);
  }

  /// Create a rect tween
  static RectTween createRectTween({
    required Rect begin,
    required Rect end,
  }) {
    return RectTween(begin: begin, end: end);
  }

  /// Create an offset tween
  static Tween<Offset> createOffsetTween({
    required Offset begin,
    required Offset end,
  }) {
    return Tween<Offset>(begin: begin, end: end);
  }

  /// Create a matrix4 tween
  static Matrix4Tween createMatrix4Tween({
    required Matrix4 begin,
    required Matrix4 end,
  }) {
    return Matrix4Tween(begin: begin, end: end);
  }

  /// Create a text style tween
  static TextStyleTween createTextStyleTween({
    required TextStyle begin,
    required TextStyle end,
  }) {
    return TextStyleTween(begin: begin, end: end);
  }

  /// Create a border radius tween
  static BorderRadiusTween createBorderRadiusTween({
    required BorderRadius begin,
    required BorderRadius end,
  }) {
    return BorderRadiusTween(begin: begin, end: end);
  }

  /// Create a border tween
  static BorderTween createBorderTween({
    required Border begin,
    required Border end,
  }) {
    return BorderTween(begin: begin, end: end);
  }

  /// Create a box shadow tween
  static BoxShadowTween createBoxShadowTween({
    required BoxShadow begin,
    required BoxShadow end,
  }) {
    return BoxShadowTween(begin: begin, end: end);
  }

  /// Create a gradient tween
  static GradientTween createGradientTween({
    required Gradient begin,
    required Gradient end,
  }) {
    return GradientTween(begin: begin, end: end);
  }

  /// Create a decoration tween
  static DecorationTween createDecorationTween({
    required Decoration begin,
    required Decoration end,
  }) {
    return DecorationTween(begin: begin, end: end);
  }

  /// Create a shape tween
  static ShapeBorderTween createShapeBorderTween({
    required ShapeBorder begin,
    required ShapeBorder end,
  }) {
    return ShapeBorderTween(begin: begin, end: end);
  }

  /// Create a path tween
  static PathTween createPathTween({
    required Path begin,
    required Path end,
  }) {
    return PathTween(begin: begin, end: end);
  }

  /// Create a curve tween
  static CurveTween createCurveTween({
    required Curve curve,
  }) {
    return CurveTween(curve: curve);
  }

  /// Create a reverse curve tween
  static ReverseCurveTween createReverseCurveTween({
    required Curve curve,
  }) {
    return ReverseCurveTween(curve: curve);
  }

  /// Create a sawtooth curve tween
  static SawtoothTween createSawtoothTween({
    required int count,
  }) {
    return SawtoothTween(count: count);
  }

  /// Create a step tween
  static StepTween createStepTween({
    required int begin,
    required int end,
  }) {
    return StepTween(begin: begin, end: end);
  }

  /// Create a int tween
  static IntTween createIntTween({
    required int begin,
    required int end,
  }) {
    return IntTween(begin: begin, end: end);
  }

  /// Create a double tween
  static Tween<double> createDoubleTween({
    required double begin,
    required double end,
  }) {
    return Tween<double>(begin: begin, end: end);
  }

  /// Create a string tween
  static Tween<String> createStringTween({
    required String begin,
    required String end,
  }) {
    return Tween<String>(begin: begin, end: end);
  }

  /// Create a bool tween
  static Tween<bool> createBoolTween({
    required bool begin,
    required bool end,
  }) {
    return Tween<bool>(begin: begin, end: end);
  }

  /// Create a list tween
  static Tween<List<T>> createListTween<T>({
    required List<T> begin,
    required List<T> end,
  }) {
    return Tween<List<T>>(begin: begin, end: end);
  }

  /// Create a map tween
  static Tween<Map<K, V>> createMapTween<K, V>({
    required Map<K, V> begin,
    required Map<K, V> end,
  }) {
    return Tween<Map<K, V>>(begin: begin, end: end);
  }

  /// Create a set tween
  static Tween<Set<T>> createSetTween<T>({
    required Set<T> begin,
    required Set<T> end,
  }) {
    return Tween<Set<T>>(begin: begin, end: end);
  }

  /// Create a nullable tween
  static Tween<T?> createNullableTween<T>({
    required T? begin,
    required T? end,
  }) {
    return Tween<T?>(begin: begin, end: end);
  }

  /// Create a generic tween
  static Tween<T> createGenericTween<T>({
    required T begin,
    required T end,
  }) {
    return Tween<T>(begin: begin, end: end);
  }
}
