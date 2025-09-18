import 'package:flutter/material.dart';
import 'package:design_tokens/design_tokens.dart';

/// Pandora button component following "Thân Tâm Hợp Nhất" philosophy
///
/// Thân (Body): Physical foundation through consistent button design
/// Tâm (Mind): Mental harmony through intuitive button interactions
/// Hợp (Harmony): Visual balance through proper button styling
/// Nhất (Unity): Perfect integration of all button elements
class PandoraButton extends StatelessWidget {
  /// Button text
  final String? text;

  /// Button child widget
  final Widget? child;

  /// Button variant
  final PandoraButtonVariant variant;

  /// Button size
  final PandoraButtonSize size;

  /// Button state
  final PandoraButtonState state;

  /// On pressed callback
  final VoidCallback? onPressed;

  /// Button icon
  final IconData? icon;

  /// Icon position
  final PandoraIconPosition iconPosition;

  /// Button width
  final double? width;

  /// Button height
  final double? height;

  /// Button border radius
  final double? borderRadius;

  /// Button elevation
  final double? elevation;

  /// Button padding
  final EdgeInsets? padding;

  /// Button margin
  final EdgeInsets? margin;

  /// Button color
  final Color? color;

  /// Button text color
  final Color? textColor;

  /// Button border color
  final Color? borderColor;

  /// Button border width
  final double? borderWidth;

  /// Button shadow color
  final Color? shadowColor;

  /// Button gradient
  final Gradient? gradient;

  /// Button animation duration
  final Duration? animationDuration;

  /// Button animation curve
  final Curve? animationCurve;

  /// Button loading indicator
  final Widget? loadingIndicator;

  /// Button tooltip
  final String? tooltip;

  /// Button accessibility label
  final String? accessibilityLabel;

  /// Button accessibility hint
  final String? accessibilityHint;

  const PandoraButton({
    super.key,
    this.text,
    this.child,
    this.variant = PandoraButtonVariant.primary,
    this.size = PandoraButtonSize.medium,
    this.state = PandoraButtonState.enabled,
    this.onPressed,
    this.icon,
    this.iconPosition = PandoraIconPosition.start,
    this.width,
    this.height,
    this.borderRadius,
    this.elevation,
    this.padding,
    this.margin,
    this.color,
    this.textColor,
    this.borderColor,
    this.borderWidth,
    this.shadowColor,
    this.gradient,
    this.animationDuration,
    this.animationCurve,
    this.loadingIndicator,
    this.tooltip,
    this.accessibilityLabel,
    this.accessibilityHint,
  }) : assert(text != null || child != null, 'Either text or child must be provided');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEnabled = state == PandoraButtonState.enabled && onPressed != null;

    Widget button = _buildButton(theme, isEnabled);

    if (margin != null) {
      button = Padding(
        padding: margin!,
        child: button,
      );
    }

    if (tooltip != null && isEnabled) {
      button = Tooltip(
        message: tooltip!,
        child: button,
      );
    }

    return Semantics(
      label: accessibilityLabel ?? text,
      hint: accessibilityHint,
      button: true,
      enabled: isEnabled,
      child: button,
    );
  }

  Widget _buildButton(ThemeData theme, bool isEnabled) {
    switch (variant) {
      case PandoraButtonVariant.primary:
        return _buildPrimaryButton(theme, isEnabled);
      case PandoraButtonVariant.secondary:
        return _buildSecondaryButton(theme, isEnabled);
      case PandoraButtonVariant.outline:
        return _buildOutlineButton(theme, isEnabled);
      case PandoraButtonVariant.text:
        return _buildTextButton(theme, isEnabled);
      case PandoraButtonVariant.icon:
        return _buildIconButton(theme, isEnabled);
      case PandoraButtonVariant.fab:
        return _buildFabButton(theme, isEnabled);
    }
  }

  Widget _buildPrimaryButton(ThemeData theme, bool isEnabled) {
    final colors = _getButtonColors(theme, isEnabled);
    final dimensions = _getButtonDimensions();

    return Container(
      width: width,
      height: height ?? dimensions.height,
      decoration: BoxDecoration(
        gradient: gradient ?? colors.gradient,
        borderRadius: BorderRadius.circular(borderRadius ?? dimensions.borderRadius),
        boxShadow: _getButtonShadow(colors.shadowColor),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          borderRadius: BorderRadius.circular(borderRadius ?? dimensions.borderRadius),
          child: Container(
            padding: padding ?? dimensions.padding,
            child: _buildButtonContent(colors.textColor),
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(ThemeData theme, bool isEnabled) {
    final colors = _getButtonColors(theme, isEnabled);
    final dimensions = _getButtonDimensions();

    return Container(
      width: width,
      height: height ?? dimensions.height,
      decoration: BoxDecoration(
        color: colors.backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius ?? dimensions.borderRadius),
        border: Border.all(
          color: colors.borderColor,
          width: borderWidth ?? 1.0,
        ),
        boxShadow: _getButtonShadow(colors.shadowColor),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          borderRadius: BorderRadius.circular(borderRadius ?? dimensions.borderRadius),
          child: Container(
            padding: padding ?? dimensions.padding,
            child: _buildButtonContent(colors.textColor),
          ),
        ),
      ),
    );
  }

  Widget _buildOutlineButton(ThemeData theme, bool isEnabled) {
    final colors = _getButtonColors(theme, isEnabled);
    final dimensions = _getButtonDimensions();

    return Container(
      width: width,
      height: height ?? dimensions.height,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius ?? dimensions.borderRadius),
        border: Border.all(
          color: colors.borderColor,
          width: borderWidth ?? 2.0,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          borderRadius: BorderRadius.circular(borderRadius ?? dimensions.borderRadius),
          child: Container(
            padding: padding ?? dimensions.padding,
            child: _buildButtonContent(colors.textColor),
          ),
        ),
      ),
    );
  }

  Widget _buildTextButton(ThemeData theme, bool isEnabled) {
    final colors = _getButtonColors(theme, isEnabled);
    final dimensions = _getButtonDimensions();

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEnabled ? onPressed : null,
        borderRadius: BorderRadius.circular(borderRadius ?? dimensions.borderRadius),
        child: Container(
          width: width,
          height: height ?? dimensions.height,
          padding: padding ?? dimensions.padding,
          child: _buildButtonContent(colors.textColor),
        ),
      ),
    );
  }

  Widget _buildIconButton(ThemeData theme, bool isEnabled) {
    final colors = _getButtonColors(theme, isEnabled);
    final dimensions = _getButtonDimensions();

    return Container(
      width: width ?? dimensions.height,
      height: height ?? dimensions.height,
      decoration: BoxDecoration(
        color: colors.backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius ?? dimensions.borderRadius),
        border: borderColor != null ? Border.all(
          color: colors.borderColor,
          width: borderWidth ?? 1.0,
        ) : null,
        boxShadow: _getButtonShadow(colors.shadowColor),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          borderRadius: BorderRadius.circular(borderRadius ?? dimensions.borderRadius),
          child: Container(
            padding: padding ?? dimensions.padding,
            child: _buildButtonContent(colors.textColor),
          ),
        ),
      ),
    );
  }

  Widget _buildFabButton(ThemeData theme, bool isEnabled) {
    final colors = _getButtonColors(theme, isEnabled);
    final dimensions = _getButtonDimensions();

    return Container(
      width: width ?? dimensions.height,
      height: height ?? dimensions.height,
      decoration: BoxDecoration(
        gradient: gradient ?? colors.gradient,
        borderRadius: BorderRadius.circular(borderRadius ?? dimensions.borderRadius),
        boxShadow: _getButtonShadow(colors.shadowColor),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          borderRadius: BorderRadius.circular(borderRadius ?? dimensions.borderRadius),
          child: Container(
            padding: padding ?? dimensions.padding,
            child: _buildButtonContent(colors.textColor),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonContent(Color textColor) {
    if (state == PandoraButtonState.loading) {
      return _buildLoadingContent(textColor);
    }

    if (icon != null && text != null) {
      return _buildIconTextContent(textColor);
    } else if (icon != null) {
      return _buildIconContent(textColor);
    } else if (text != null) {
      return _buildTextContent(textColor);
    } else if (child != null) {
      return child!;
    }

    return const SizedBox.shrink();
  }

  Widget _buildLoadingContent(Color textColor) {
    return loadingIndicator ??
           SizedBox(
             width: 20,
             height: 20,
             child: CircularProgressIndicator(
               strokeWidth: 2,
               valueColor: AlwaysStoppedAnimation<Color>(textColor),
             ),
           );
  }

  Widget _buildIconTextContent(Color textColor) {
    final iconWidget = Icon(
      icon,
      size: _getIconSize(),
      color: textColor,
    );

    final textWidget = Text(
      text!,
      style: _getTextStyle().copyWith(color: textColor),
    );

    if (iconPosition == PandoraIconPosition.start) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [iconWidget, const SizedBox(width: 8), textWidget],
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [textWidget, const SizedBox(width: 8), iconWidget],
      );
    }
  }

  Widget _buildIconContent(Color textColor) {
    return Icon(
      icon,
      size: _getIconSize(),
      color: textColor,
    );
  }

  Widget _buildTextContent(Color textColor) {
    return Text(
      text!,
      style: _getTextStyle().copyWith(color: textColor),
    );
  }

  PandoraButtonColors _getButtonColors(ThemeData theme, bool isEnabled) {
    final baseColors = PandoraColors();

    if (!isEnabled) {
      return PandoraButtonColors(
        backgroundColor: baseColors.surfaceContainer,
        textColor: baseColors.onSurfaceVariant,
        borderColor: baseColors.outlineVariant,
        shadowColor: Colors.transparent,
        gradient: null,
      );
    }

    switch (variant) {
      case PandoraButtonVariant.primary:
        return PandoraButtonColors(
          backgroundColor: color ?? baseColors.primary,
          textColor: textColor ?? baseColors.onPrimary,
          borderColor: borderColor ?? baseColors.primary,
          shadowColor: shadowColor ?? baseColors.shadow,
          gradient: gradient ?? LinearGradient(colors: baseColors.primaryGradient),
        );
      case PandoraButtonVariant.secondary:
        return PandoraButtonColors(
          backgroundColor: color ?? baseColors.secondary,
          textColor: textColor ?? baseColors.onSecondary,
          borderColor: borderColor ?? baseColors.secondary,
          shadowColor: shadowColor ?? baseColors.shadow,
          gradient: gradient ?? LinearGradient(colors: baseColors.secondaryGradient),
        );
      case PandoraButtonVariant.outline:
        return PandoraButtonColors(
          backgroundColor: Colors.transparent,
          textColor: textColor ?? baseColors.primary,
          borderColor: borderColor ?? baseColors.primary,
          shadowColor: Colors.transparent,
          gradient: null,
        );
      case PandoraButtonVariant.text:
        return PandoraButtonColors(
          backgroundColor: Colors.transparent,
          textColor: textColor ?? baseColors.primary,
          borderColor: Colors.transparent,
          shadowColor: Colors.transparent,
          gradient: null,
        );
      case PandoraButtonVariant.icon:
        return PandoraButtonColors(
          backgroundColor: color ?? baseColors.surface,
          textColor: textColor ?? baseColors.onSurface,
          borderColor: borderColor ?? baseColors.outline,
          shadowColor: shadowColor ?? baseColors.shadow,
          gradient: null,
        );
      case PandoraButtonVariant.fab:
        return PandoraButtonColors(
          backgroundColor: color ?? baseColors.primary,
          textColor: textColor ?? baseColors.onPrimary,
          borderColor: borderColor ?? baseColors.primary,
          shadowColor: shadowColor ?? baseColors.shadow,
          gradient: gradient ?? LinearGradient(colors: baseColors.primaryGradient),
        );
    }
  }

  PandoraButtonDimensions _getButtonDimensions() {
    switch (size) {
      case PandoraButtonSize.small:
        return PandoraButtonDimensions(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          borderRadius: 6,
        );
      case PandoraButtonSize.medium:
        return PandoraButtonDimensions(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          borderRadius: 8,
        );
      case PandoraButtonSize.large:
        return PandoraButtonDimensions(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          borderRadius: 10,
        );
    }
  }

  TextStyle _getTextStyle() {
    switch (size) {
      case PandoraButtonSize.small:
        return PandoraTypography.labelMedium;
      case PandoraButtonSize.medium:
        return PandoraTypography.labelLarge;
      case PandoraButtonSize.large:
        return PandoraTypography.titleSmall;
    }
  }

  double _getIconSize() {
    switch (size) {
      case PandoraButtonSize.small:
        return 16;
      case PandoraButtonSize.medium:
        return 20;
      case PandoraButtonSize.large:
        return 24;
    }
  }

  List<BoxShadow> _getButtonShadow(Color shadowColor) {
    if (shadowColor == Colors.transparent) return [];

    return [
      BoxShadow(
        color: shadowColor,
        blurRadius: elevation ?? 4,
        offset: const Offset(0, 2),
      ),
    ];
  }
}

/// Button variant enum
enum PandoraButtonVariant {
  primary,
  secondary,
  outline,
  text,
  icon,
  fab,
}

/// Button size enum
enum PandoraButtonSize {
  small,
  medium,
  large,
}

/// Button state enum
enum PandoraButtonState {
  enabled,
  disabled,
  loading,
}

/// Icon position enum
enum PandoraIconPosition {
  start,
  end,
}

/// Button colors class
class PandoraButtonColors {
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final Color shadowColor;
  final Gradient? gradient;

  const PandoraButtonColors({
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
    required this.shadowColor,
    this.gradient,
  });
}

/// Button dimensions class
class PandoraButtonDimensions {
  final double height;
  final EdgeInsets padding;
  final double borderRadius;

  const PandoraButtonDimensions({
    required this.height,
    required this.padding,
    required this.borderRadius,
  });
}
