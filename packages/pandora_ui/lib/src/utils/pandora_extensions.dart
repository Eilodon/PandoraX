import 'package:flutter/material.dart';
import '../tokens/color_tokens.dart';
import '../tokens/typography_tokens.dart';
import '../tokens/spacing_tokens.dart';
import '../tokens/border_tokens.dart';
import '../tokens/shadow_tokens.dart';

/// Pandora 4 Extensions
/// 
/// Extension methods that make it easier to use design tokens
/// throughout the application following "Thân Tâm Hợp Nhất" philosophy.
extension PandoraColorExtensions on Color {
  /// Get color with opacity
  Color withPandoraOpacity(double opacity) => withValues(alpha: opacity);

  /// Get color with alpha
  Color withPandoraAlpha(int alpha) => withAlpha(alpha);

  /// Get lighter version of color
  Color lighter([double amount = 0.1]) {
    return Color.lerp(this, Colors.white, amount) ?? this;
  }

  /// Get darker version of color
  Color darker([double amount = 0.1]) {
    return Color.lerp(this, Colors.black, amount) ?? this;
  }

  /// Get color with brightness adjustment
  Color withBrightness(double brightness) {
    return Color.lerp(this, brightness > 0 ? Colors.white : Colors.black, brightness.abs()) ?? this;
  }

  /// Get color with saturation adjustment
  Color withSaturation(double saturation) {
    final hsl = HSLColor.fromColor(this);
    return hsl.withSaturation((hsl.saturation + saturation).clamp(0.0, 1.0)).toColor();
  }

  /// Get color with lightness adjustment
  Color withLightness(double lightness) {
    final hsl = HSLColor.fromColor(this);
    return hsl.withLightness((hsl.lightness + lightness).clamp(0.0, 1.0)).toColor();
  }
}

extension PandoraTextStyleExtensions on TextStyle {
  /// Apply Pandora typography with color
  TextStyle withPandoraColor(Color color) => copyWith(color: color);

  /// Apply Pandora typography with weight
  TextStyle withPandoraWeight(FontWeight weight) => copyWith(fontWeight: weight);

  /// Apply Pandora typography with size
  TextStyle withPandoraSize(double size) => copyWith(fontSize: size);

  /// Apply Pandora typography with height
  TextStyle withPandoraHeight(double height) => copyWith(height: height);

  /// Apply Pandora typography with letter spacing
  TextStyle withPandoraLetterSpacing(double letterSpacing) => copyWith(letterSpacing: letterSpacing);

  /// Apply Pandora typography with decoration
  TextStyle withPandoraDecoration(TextDecoration decoration) => copyWith(decoration: decoration);

  /// Apply Pandora typography with font family
  TextStyle withPandoraFontFamily(String fontFamily) => copyWith(fontFamily: fontFamily);
}

extension PandoraWidgetExtensions on Widget {
  /// Apply Pandora padding
  Widget pandoraPadding({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: top ?? vertical ?? all ?? 0,
        bottom: bottom ?? vertical ?? all ?? 0,
        left: left ?? horizontal ?? all ?? 0,
        right: right ?? horizontal ?? all ?? 0,
      ),
      child: this,
    );
  }

  /// Apply Pandora margin
  Widget pandoraMargin({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Container(
      margin: EdgeInsets.only(
        top: top ?? vertical ?? all ?? 0,
        bottom: bottom ?? vertical ?? all ?? 0,
        left: left ?? horizontal ?? all ?? 0,
        right: right ?? horizontal ?? all ?? 0,
      ),
      child: this,
    );
  }

  /// Apply Pandora border radius
  Widget pandoraBorderRadius({
    double? all,
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(topLeft ?? all ?? 0),
        topRight: Radius.circular(topRight ?? all ?? 0),
        bottomLeft: Radius.circular(bottomLeft ?? all ?? 0),
        bottomRight: Radius.circular(bottomRight ?? all ?? 0),
      ),
      child: this,
    );
  }

  /// Apply Pandora shadow
  Widget pandoraShadow({
    String size = 'md',
    Color? color,
    Offset? offset,
    double? blurRadius,
    double? spreadRadius,
  }) {
    final shadows = PandoraShadows.getShadow(size);
    return Container(
      decoration: BoxDecoration(
        boxShadow: color != null 
          ? PandoraShadows.createColoredShadow(color, size: size)
          : shadows,
      ),
      child: this,
    );
  }

  /// Apply Pandora background color
  Widget pandoraBackground(Color color) {
    return Container(
      color: color,
      child: this,
    );
  }

  /// Apply Pandora border
  Widget pandoraBorder({
    double width = 1.0,
    Color color = Colors.grey,
    BorderStyle style = BorderStyle.solid,
    double? radius,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: width,
          color: color,
          style: style,
        ),
        borderRadius: radius != null ? BorderRadius.circular(radius) : null,
      ),
      child: this,
    );
  }

  /// Apply Pandora container
  Widget pandoraContainer({
    Color? color,
    double? width,
    double? height,
    EdgeInsets? padding,
    EdgeInsets? margin,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
    Gradient? gradient,
    Border? border,
  }) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
        gradient: gradient,
        border: border,
      ),
      child: this,
    );
  }

  /// Apply Pandora center alignment
  Widget pandoraCenter() => Center(child: this);

  /// Apply Pandora alignment
  Widget pandoraAlign(Alignment alignment) => Align(
    alignment: alignment,
    child: this,
  );

  /// Apply Pandora positioned
  Widget pandoraPositioned({
    double? top,
    double? bottom,
    double? left,
    double? right,
    double? width,
    double? height,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      width: width,
      height: height,
      child: this,
    );
  }

  /// Apply Pandora expanded
  Widget pandoraExpanded([int flex = 1]) => Expanded(
    flex: flex,
    child: this,
  );

  /// Apply Pandora flexible
  Widget pandoraFlexible([int flex = 1]) => Flexible(
    flex: flex,
    child: this,
  );

  /// Apply Pandora sized box
  Widget pandoraSizedBox({
    double? width,
    double? height,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: this,
    );
  }

  /// Apply Pandora opacity
  Widget pandoraOpacity(double opacity) => Opacity(
    opacity: opacity,
    child: this,
  );

  /// Apply Pandora visibility
  Widget pandoraVisibility(bool visible) => Visibility(
    visible: visible,
    child: this,
  );

  /// Apply Pandora safe area
  Widget pandoraSafeArea({
    bool top = true,
    bool bottom = true,
    bool left = true,
    bool right = true,
  }) {
    return SafeArea(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: this,
    );
  }
}

extension PandoraBuildContextExtensions on BuildContext {
  /// Get Pandora theme extension
  // PandoraThemeExtension get pandoraTheme => Theme.of(this).extension<PandoraThemeExtension>()!;

  /// Get Pandora colors (static access)
  // PandoraColors get pandoraColors => PandoraColors;

  /// Get Pandora typography (static access)
  // PandoraTypography get pandoraTypography => PandoraTypography;

  /// Get Pandora spacing (static access)
  // PandoraSpacing get pandoraSpacing => PandoraSpacing;

  /// Get Pandora borders (static access)
  // PandoraBorders get pandoraBorders => PandoraBorders;

  /// Get Pandora shadows (static access)
  // PandoraShadows get pandoraShadows => PandoraShadows;

  /// Get screen size
  Size get screenSize => MediaQuery.of(this).size;

  /// Get screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Get screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Check if screen is mobile
  bool get isMobile => screenWidth < 600;

  /// Check if screen is tablet
  bool get isTablet => screenWidth >= 600 && screenWidth < 900;

  /// Check if screen is desktop
  bool get isDesktop => screenWidth >= 900;

  /// Get responsive spacing
  double getResponsiveSpacing(double baseSpacing) {
    return PandoraSpacing.getResponsiveSpacing(screenWidth, baseSpacing);
  }

  /// Get theme brightness
  Brightness get themeBrightness => Theme.of(this).brightness;

  /// Check if theme is dark
  bool get isDarkTheme => themeBrightness == Brightness.dark;

  /// Check if theme is light
  bool get isLightTheme => themeBrightness == Brightness.light;
}

extension PandoraStringExtensions on String {
  /// Capitalize first letter
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Capitalize all words
  String get capitalizeWords {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  /// Convert to title case
  String get toTitleCase {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  /// Convert to camel case
  String get toCamelCase {
    if (isEmpty) return this;
    final words = split(' ');
    return words[0].toLowerCase() + 
           words.skip(1).map((word) => word.capitalize).join('');
  }

  /// Convert to snake case
  String get toSnakeCase {
    if (isEmpty) return this;
    return replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => '_${match.group(0)!.toLowerCase()}',
    ).toLowerCase();
  }

  /// Convert to kebab case
  String get toKebabCase {
    if (isEmpty) return this;
    return replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => '-${match.group(0)!.toLowerCase()}',
    ).toLowerCase();
  }
}
