import 'package:flutter/material.dart';
import '../../tokens/color_tokens.dart';
import '../../tokens/typography_tokens.dart';
import '../../tokens/spacing_tokens.dart';
import '../../tokens/border_tokens.dart';
import '../../tokens/shadow_tokens.dart';
import '../../utils/pandora_extensions.dart';

/// Pandora 4 Button
/// 
/// A comprehensive button component that embodies the "Thân Tâm Hợp Nhất" philosophy.
/// This button adapts to different contexts while maintaining visual consistency.
enum PandoraButtonVariant {
  primary,
  secondary,
  tertiary,
  ghost,
  link,
  outlined,
}

enum PandoraButtonSize {
  xs,
  sm,
  md,
  lg,
  xl,
}

enum PandoraButtonState {
  enabled,
  disabled,
  loading,
  success,
  error,
}

class PandoraButton extends StatefulWidget {
  const PandoraButton({
    super.key,
    required this.child,
    this.onPressed,
    this.variant = PandoraButtonVariant.primary,
    this.size = PandoraButtonSize.md,
    this.state = PandoraButtonState.enabled,
    this.icon,
    this.iconPosition = IconPosition.start,
    this.fullWidth = false,
    this.borderRadius,
    this.elevation,
    this.shadowColor,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.hoverColor,
    this.focusColor,
    this.splashColor,
    this.disabledColor,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.minWidth,
    this.minHeight,
    this.maxWidth,
    this.maxHeight,
    this.alignment,
    this.semanticLabel,
    this.tooltip,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.style,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final PandoraButtonVariant variant;
  final PandoraButtonSize size;
  final PandoraButtonState state;
  final Widget? icon;
  final IconPosition iconPosition;
  final bool fullWidth;
  final BorderRadius? borderRadius;
  final double? elevation;
  final Color? shadowColor;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final Color? hoverColor;
  final Color? focusColor;
  final Color? splashColor;
  final Color? disabledColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final double? minWidth;
  final double? minHeight;
  final double? maxWidth;
  final double? maxHeight;
  final Alignment? alignment;
  final String? semanticLabel;
  final String? tooltip;
  final bool autofocus;
  final Clip clipBehavior;
  final ButtonStyle? style;

  @override
  State<PandoraButton> createState() => _PandoraButtonState();
}

class _PandoraButtonState extends State<PandoraButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.state == PandoraButtonState.enabled) {
      _animationController.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _handleTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.state == PandoraButtonState.enabled;
    final isDisabled = widget.state == PandoraButtonState.disabled;
    final isLoading = widget.state == PandoraButtonState.loading;
    final isSuccess = widget.state == PandoraButtonState.success;
    final isError = widget.state == PandoraButtonState.error;

    Widget button = _buildButton(
      context: context,
      isEnabled: isEnabled,
      isDisabled: isDisabled,
      isLoading: isLoading,
      isSuccess: isSuccess,
      isError: isError,
    );

    if (widget.tooltip != null && isEnabled) {
      button = Tooltip(
        message: widget.tooltip!,
        child: button,
      );
    }

    if (widget.margin != null) {
      button = Padding(
        padding: widget.margin!,
        child: button,
      );
    }

    return button;
  }

  Widget _buildButton({
    required BuildContext context,
    required bool isEnabled,
    required bool isDisabled,
    required bool isLoading,
    required bool isSuccess,
    required bool isError,
  }) {
    final colors = _getColors(context);
    final dimensions = _getDimensions();
    final borderRadius = widget.borderRadius ?? _getBorderRadius();
    final elevation = widget.elevation ?? _getElevation();

    Widget button = AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: child,
          ),
        );
      },
      child: _buildButtonContent(
        context: context,
        colors: colors,
        dimensions: dimensions,
        borderRadius: borderRadius,
        elevation: elevation,
        isEnabled: isEnabled,
        isDisabled: isDisabled,
        isLoading: isLoading,
        isSuccess: isSuccess,
        isError: isError,
      ),
    );

    if (isEnabled && !isLoading) {
      button = GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: widget.onPressed,
        child: button,
      );
    }

    return button;
  }

  Widget _buildButtonContent({
    required BuildContext context,
    required ButtonColors colors,
    required ButtonDimensions dimensions,
    required BorderRadius borderRadius,
    required double elevation,
    required bool isEnabled,
    required bool isDisabled,
    required bool isLoading,
    required bool isSuccess,
    required bool isError,
  }) {
    return Container(
      width: widget.fullWidth ? double.infinity : widget.width,
      height: widget.height,
      constraints: BoxConstraints(
        minWidth: widget.minWidth ?? dimensions.minWidth,
        minHeight: widget.minHeight ?? dimensions.minHeight,
        maxWidth: widget.maxWidth ?? dimensions.maxWidth,
        maxHeight: widget.maxHeight ?? dimensions.maxHeight,
      ),
      decoration: BoxDecoration(
        color: isDisabled ? colors.disabledColor : colors.backgroundColor,
        borderRadius: borderRadius,
        border: colors.borderColor != null
            ? Border.all(color: colors.borderColor!, width: 1.0)
            : null,
        boxShadow: elevation > 0 ? PandoraShadows.getShadow('button') : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled && !isLoading ? widget.onPressed : null,
          borderRadius: borderRadius,
          splashColor: colors.splashColor,
          highlightColor: colors.hoverColor,
          focusColor: colors.focusColor,
          child: Container(
            padding: widget.padding ?? dimensions.padding,
            alignment: widget.alignment ?? Alignment.center,
            child: _buildButtonChild(
              context: context,
              colors: colors,
              dimensions: dimensions,
              isLoading: isLoading,
              isSuccess: isSuccess,
              isError: isError,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonChild({
    required BuildContext context,
    required ButtonColors colors,
    required ButtonDimensions dimensions,
    required bool isLoading,
    required bool isSuccess,
    required bool isError,
  }) {
    if (isLoading) {
      return SizedBox(
        width: dimensions.iconSize,
        height: dimensions.iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation<Color>(colors.foregroundColor),
        ),
      );
    }

    if (isSuccess) {
      return Icon(
        Icons.check,
        size: dimensions.iconSize,
        color: colors.foregroundColor,
      );
    }

    if (isError) {
      return Icon(
        Icons.error,
        size: dimensions.iconSize,
        color: colors.foregroundColor,
      );
    }

    final children = <Widget>[];

    if (widget.icon != null && widget.iconPosition == IconPosition.start) {
      children.add(
        Padding(
          padding: const EdgeInsets.only(right: PandoraSpacing.space8),
          child: widget.icon!,
        ),
      );
    }

    children.add(
      DefaultTextStyle(
        style: dimensions.textStyle.copyWith(color: colors.foregroundColor),
        child: widget.child,
      ),
    );

    if (widget.icon != null && widget.iconPosition == IconPosition.end) {
      children.add(
        Padding(
          padding: const EdgeInsets.only(left: PandoraSpacing.space8),
          child: widget.icon!,
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  ButtonColors _getColors(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    switch (widget.variant) {
      case PandoraButtonVariant.primary:
        return ButtonColors(
          backgroundColor: widget.backgroundColor ?? 
              (isDark ? PandoraColors.primary400 : PandoraColors.primary500),
          foregroundColor: widget.foregroundColor ?? PandoraColors.white,
          borderColor: widget.borderColor,
          hoverColor: widget.hoverColor ?? 
              (isDark ? PandoraColors.primary300 : PandoraColors.primary600),
          focusColor: widget.focusColor ?? 
              (isDark ? PandoraColors.primary200 : PandoraColors.primary700),
          splashColor: widget.splashColor ?? 
              (isDark ? PandoraColors.primary100 : PandoraColors.primary800),
          disabledColor: widget.disabledColor ?? 
              (isDark ? PandoraColors.neutral600 : PandoraColors.neutral300),
        );
      case PandoraButtonVariant.secondary:
        return ButtonColors(
          backgroundColor: widget.backgroundColor ?? 
              (isDark ? PandoraColors.secondary400 : PandoraColors.secondary500),
          foregroundColor: widget.foregroundColor ?? PandoraColors.white,
          borderColor: widget.borderColor,
          hoverColor: widget.hoverColor ?? 
              (isDark ? PandoraColors.secondary300 : PandoraColors.secondary600),
          focusColor: widget.focusColor ?? 
              (isDark ? PandoraColors.secondary200 : PandoraColors.secondary700),
          splashColor: widget.splashColor ?? 
              (isDark ? PandoraColors.secondary100 : PandoraColors.secondary800),
          disabledColor: widget.disabledColor ?? 
              (isDark ? PandoraColors.neutral600 : PandoraColors.neutral300),
        );
      case PandoraButtonVariant.tertiary:
        return ButtonColors(
          backgroundColor: widget.backgroundColor ?? 
              (isDark ? PandoraColors.info400 : PandoraColors.info500),
          foregroundColor: widget.foregroundColor ?? PandoraColors.white,
          borderColor: widget.borderColor,
          hoverColor: widget.hoverColor ?? 
              (isDark ? PandoraColors.info300 : PandoraColors.info600),
          focusColor: widget.focusColor ?? 
              (isDark ? PandoraColors.info200 : PandoraColors.info700),
          splashColor: widget.splashColor ?? 
              (isDark ? PandoraColors.info100 : PandoraColors.info800),
          disabledColor: widget.disabledColor ?? 
              (isDark ? PandoraColors.neutral600 : PandoraColors.neutral300),
        );
      case PandoraButtonVariant.ghost:
        return ButtonColors(
          backgroundColor: widget.backgroundColor ?? Colors.transparent,
          foregroundColor: widget.foregroundColor ?? 
              (isDark ? PandoraColors.neutral100 : PandoraColors.neutral900),
          borderColor: widget.borderColor ?? 
              (isDark ? PandoraColors.neutral600 : PandoraColors.neutral300),
          hoverColor: widget.hoverColor ?? 
              (isDark ? PandoraColors.neutral700 : PandoraColors.neutral100),
          focusColor: widget.focusColor ?? 
              (isDark ? PandoraColors.neutral600 : PandoraColors.neutral200),
          splashColor: widget.splashColor ?? 
              (isDark ? PandoraColors.neutral500 : PandoraColors.neutral300),
          disabledColor: widget.disabledColor ?? 
              (isDark ? PandoraColors.neutral600 : PandoraColors.neutral300),
        );
      case PandoraButtonVariant.link:
        return ButtonColors(
          backgroundColor: widget.backgroundColor ?? Colors.transparent,
          foregroundColor: widget.foregroundColor ?? 
              (isDark ? PandoraColors.primary400 : PandoraColors.primary500),
          borderColor: widget.borderColor,
          hoverColor: widget.hoverColor ?? 
              (isDark ? PandoraColors.primary300 : PandoraColors.primary600),
          focusColor: widget.focusColor ?? 
              (isDark ? PandoraColors.primary200 : PandoraColors.primary700),
          splashColor: widget.splashColor ?? 
              (isDark ? PandoraColors.primary100 : PandoraColors.primary800),
          disabledColor: widget.disabledColor ?? 
              (isDark ? PandoraColors.neutral600 : PandoraColors.neutral300),
        );
      case PandoraButtonVariant.outlined:
        return ButtonColors(
          backgroundColor: widget.backgroundColor ?? Colors.transparent,
          foregroundColor: widget.foregroundColor ?? 
              (isDark ? PandoraColors.primary400 : PandoraColors.primary500),
          borderColor: widget.borderColor ?? 
              (isDark ? PandoraColors.primary400 : PandoraColors.primary500),
          hoverColor: widget.hoverColor ?? 
              (isDark ? PandoraColors.primary300 : PandoraColors.primary600),
          focusColor: widget.focusColor ?? 
              (isDark ? PandoraColors.primary200 : PandoraColors.primary700),
          splashColor: widget.splashColor ?? 
              (isDark ? PandoraColors.primary100 : PandoraColors.primary800),
          disabledColor: widget.disabledColor ?? 
              (isDark ? PandoraColors.neutral600 : PandoraColors.neutral300),
        );
    }
  }

  ButtonDimensions _getDimensions() {
    switch (widget.size) {
      case PandoraButtonSize.xs:
        return ButtonDimensions(
          padding: const EdgeInsets.symmetric(
            horizontal: PandoraSpacing.space8,
            vertical: PandoraSpacing.space4,
          ),
          minWidth: 32.0,
          minHeight: 24.0,
          maxWidth: double.infinity,
          maxHeight: 32.0,
          iconSize: 12.0,
          textStyle: PandoraTypography.labelSmall,
        );
      case PandoraButtonSize.sm:
        return ButtonDimensions(
          padding: const EdgeInsets.symmetric(
            horizontal: PandoraSpacing.space12,
            vertical: PandoraSpacing.space6,
          ),
          minWidth: 48.0,
          minHeight: 32.0,
          maxWidth: double.infinity,
          maxHeight: 40.0,
          iconSize: 16.0,
          textStyle: PandoraTypography.labelMedium,
        );
      case PandoraButtonSize.md:
        return ButtonDimensions(
          padding: const EdgeInsets.symmetric(
            horizontal: PandoraSpacing.space16,
            vertical: PandoraSpacing.space8,
          ),
          minWidth: 64.0,
          minHeight: 40.0,
          maxWidth: double.infinity,
          maxHeight: 48.0,
          iconSize: 20.0,
          textStyle: PandoraTypography.labelLarge,
        );
      case PandoraButtonSize.lg:
        return ButtonDimensions(
          padding: const EdgeInsets.symmetric(
            horizontal: PandoraSpacing.space20,
            vertical: PandoraSpacing.space10,
          ),
          minWidth: 80.0,
          minHeight: 48.0,
          maxWidth: double.infinity,
          maxHeight: 56.0,
          iconSize: 24.0,
          textStyle: PandoraTypography.titleSmall,
        );
      case PandoraButtonSize.xl:
        return ButtonDimensions(
          padding: const EdgeInsets.symmetric(
            horizontal: PandoraSpacing.space24,
            vertical: PandoraSpacing.space12,
          ),
          minWidth: 96.0,
          minHeight: 56.0,
          maxWidth: double.infinity,
          maxHeight: 64.0,
          iconSize: 28.0,
          textStyle: PandoraTypography.titleMedium,
        );
    }
  }

  BorderRadius _getBorderRadius() {
    switch (widget.size) {
      case PandoraButtonSize.xs:
        return PandoraBorders.borderRadiusSm;
      case PandoraButtonSize.sm:
        return PandoraBorders.borderRadiusSm;
      case PandoraButtonSize.md:
        return PandoraBorders.borderRadiusMd;
      case PandoraButtonSize.lg:
        return PandoraBorders.borderRadiusLg;
      case PandoraButtonSize.xl:
        return PandoraBorders.borderRadiusLg;
    }
  }

  double _getElevation() {
    switch (widget.variant) {
      case PandoraButtonVariant.primary:
      case PandoraButtonVariant.secondary:
      case PandoraButtonVariant.tertiary:
        return 2.0;
      case PandoraButtonVariant.ghost:
      case PandoraButtonVariant.link:
      case PandoraButtonVariant.outlined:
        return 0.0;
    }
  }
}

enum IconPosition { start, end }

class ButtonColors {
  const ButtonColors({
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderColor,
    this.hoverColor,
    this.focusColor,
    this.splashColor,
    this.disabledColor,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
  final Color? hoverColor;
  final Color? focusColor;
  final Color? splashColor;
  final Color? disabledColor;
}

class ButtonDimensions {
  const ButtonDimensions({
    required this.padding,
    required this.minWidth,
    required this.minHeight,
    required this.maxWidth,
    required this.maxHeight,
    required this.iconSize,
    required this.textStyle,
  });

  final EdgeInsets padding;
  final double minWidth;
  final double minHeight;
  final double maxWidth;
  final double maxHeight;
  final double iconSize;
  final TextStyle textStyle;
}
