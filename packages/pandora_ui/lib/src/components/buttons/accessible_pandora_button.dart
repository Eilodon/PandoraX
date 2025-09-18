import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../tokens/color_tokens.dart';
import '../../tokens/typography_tokens.dart';
import '../../tokens/spacing_tokens.dart';
import '../../tokens/border_tokens.dart';
import '../../tokens/shadow_tokens.dart';
import '../../services/accessibility_service.dart';
import '../../services/accessibility_colors.dart';
import '../../services/focus_management_service.dart';
import 'pandora_button_enums.dart';

/// Accessible Pandora 4 Button
/// 
/// Enhanced button component with comprehensive accessibility support
class AccessiblePandoraButton extends StatefulWidget {
  const AccessiblePandoraButton({
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
    
    // Accessibility properties
    this.accessibilityLabel,
    this.accessibilityHint,
    this.accessibilityValue,
    this.excludeSemantics = false,
    this.focusOrder,
    this.focusGroup,
    this.accessibilityId,
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
  
  // Accessibility properties
  final String? accessibilityLabel;
  final String? accessibilityHint;
  final String? accessibilityValue;
  final bool excludeSemantics;
  final int? focusOrder;
  final String? focusGroup;
  final String? accessibilityId;

  @override
  State<AccessiblePandoraButton> createState() => _AccessiblePandoraButtonState();
}

class _AccessiblePandoraButtonState extends State<AccessiblePandoraButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late FocusNode _focusNode;
  bool _isFocused = false;

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
    
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
    
    // Register with focus management if order is provided
    if (widget.focusOrder != null) {
      FocusManagementService.registerFocusable(
        id: widget.accessibilityId ?? widget.key.toString(),
        focusNode: _focusNode,
        order: widget.focusOrder!,
        group: widget.focusGroup,
        canFocus: widget.state == PandoraButtonState.enabled,
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.state == PandoraButtonState.enabled) {
      _animationController.forward();
      HapticFeedback.lightImpact();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _handleTapCancel() {
    _animationController.reverse();
  }

  void _handleTap() {
    if (widget.state == PandoraButtonState.enabled && widget.onPressed != null) {
      widget.onPressed!();
      AccessibilityService.announceCompletion('Button activated');
    }
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.enter ||
          event.logicalKey == LogicalKeyboardKey.space) {
        _handleTap();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.state == PandoraButtonState.enabled;
    final isDisabled = widget.state == PandoraButtonState.disabled;
    final isLoading = widget.state == PandoraButtonState.loading;
    final isSuccess = widget.state == PandoraButtonState.success;
    final isError = widget.state == PandoraButtonState.error;

    // Get accessibility properties
    final accessibilityLabel = _getAccessibilityLabel();
    final accessibilityHint = _getAccessibilityHint();
    final accessibilityValue = _getAccessibilityValue();

    Widget button = _buildButton(
      context: context,
      isEnabled: isEnabled,
      isDisabled: isDisabled,
      isLoading: isLoading,
      isSuccess: isSuccess,
      isError: isError,
    );

    // Add accessibility semantics
    if (!widget.excludeSemantics) {
      button = Semantics(
        label: accessibilityLabel,
        hint: accessibilityHint,
        value: accessibilityValue,
        button: true,
        enabled: isEnabled,
        focused: _isFocused,
        child: button,
      );
    }

    // Add keyboard listener
    button = KeyboardListener(
      onKeyEvent: _handleKeyEvent,
      focusNode: _focusNode,
      child: button,
    );

    // Add focus management
    button = Focus(
      focusNode: _focusNode,
      autofocus: widget.autofocus,
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocused = hasFocus;
        });
        if (hasFocus) {
          AccessibilityService.announceChange(accessibilityLabel);
        }
      },
      child: button,
    );

    // Add tooltip
    if (widget.tooltip != null && isEnabled) {
      button = Tooltip(
        message: widget.tooltip!,
        child: button,
      );
    }

    // Add margin
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
        onTap: _handleTap,
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
    // Ensure minimum touch target size for accessibility
    final minTouchTarget = 44.0;
    final effectiveMinWidth = (widget.minWidth ?? dimensions.minWidth).clamp(minTouchTarget, double.infinity);
    final effectiveMinHeight = (widget.minHeight ?? dimensions.minHeight).clamp(minTouchTarget, double.infinity);

    return Container(
      width: widget.fullWidth ? double.infinity : widget.width,
      height: widget.height,
      constraints: BoxConstraints(
        minWidth: effectiveMinWidth,
        minHeight: effectiveMinHeight,
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
          onTap: isEnabled && !isLoading ? _handleTap : null,
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

  String _getAccessibilityLabel() {
    if (widget.accessibilityLabel != null) {
      return widget.accessibilityLabel!;
    }
    
    if (widget.semanticLabel != null) {
      return widget.semanticLabel!;
    }
    
    // Extract text from child widget
    String text = '';
    if (widget.child is Text) {
      text = (widget.child as Text).data ?? '';
    }
    
    return AccessibilityService.getSemanticLabel('button', {
      'text': text,
      'state': widget.state.name,
    });
  }

  String _getAccessibilityHint() {
    if (widget.accessibilityHint != null) {
      return widget.accessibilityHint!;
    }
    
    return AccessibilityService.getAccessibilityHint('button', {
      'isChecked': widget.state == PandoraButtonState.enabled,
    });
  }

  String _getAccessibilityValue() {
    if (widget.accessibilityValue != null) {
      return widget.accessibilityValue!;
    }
    
    return AccessibilityService.getAccessibilityValue('button', {
      'state': widget.state.name,
    });
  }

  ButtonColors _getColors(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Get base colors
    Color baseBackgroundColor;
    Color baseForegroundColor;
    
    switch (widget.variant) {
      case PandoraButtonVariant.primary:
        baseBackgroundColor = widget.backgroundColor ?? 
            (isDark ? PandoraColors.primary400 : PandoraColors.primary500);
        baseForegroundColor = widget.foregroundColor ?? PandoraColors.white;
        break;
      case PandoraButtonVariant.secondary:
        baseBackgroundColor = widget.backgroundColor ?? 
            (isDark ? PandoraColors.secondary400 : PandoraColors.secondary500);
        baseForegroundColor = widget.foregroundColor ?? PandoraColors.white;
        break;
      case PandoraButtonVariant.tertiary:
        baseBackgroundColor = widget.backgroundColor ?? 
            (isDark ? PandoraColors.info400 : PandoraColors.info500);
        baseForegroundColor = widget.foregroundColor ?? PandoraColors.white;
        break;
      case PandoraButtonVariant.ghost:
        baseBackgroundColor = widget.backgroundColor ?? Colors.transparent;
        baseForegroundColor = widget.foregroundColor ?? 
            (isDark ? PandoraColors.neutral100 : PandoraColors.neutral900);
        break;
      case PandoraButtonVariant.link:
        baseBackgroundColor = widget.backgroundColor ?? Colors.transparent;
        baseForegroundColor = widget.foregroundColor ?? 
            (isDark ? PandoraColors.primary400 : PandoraColors.primary500);
        break;
      case PandoraButtonVariant.outlined:
        baseBackgroundColor = widget.backgroundColor ?? Colors.transparent;
        baseForegroundColor = widget.foregroundColor ?? 
            (isDark ? PandoraColors.primary400 : PandoraColors.primary500);
        break;
    }

    // Ensure accessible contrast
    final accessibleForegroundColor = AccessibilityColors.getAccessibleColor(
      baseForegroundColor,
      baseBackgroundColor,
      isUIComponent: true,
    );

    return ButtonColors(
      backgroundColor: baseBackgroundColor,
      foregroundColor: accessibleForegroundColor,
      borderColor: widget.borderColor,
      hoverColor: widget.hoverColor,
      focusColor: widget.focusColor,
      splashColor: widget.splashColor,
      disabledColor: widget.disabledColor ?? 
          (isDark ? PandoraColors.neutral600 : PandoraColors.neutral300),
    );
  }

  ButtonDimensions _getDimensions() {
    switch (widget.size) {
      case PandoraButtonSize.xs:
        return ButtonDimensions(
          padding: const EdgeInsets.symmetric(
            horizontal: PandoraSpacing.space8,
            vertical: PandoraSpacing.space4,
          ),
          minWidth: 44.0, // Minimum touch target
          minHeight: 44.0, // Minimum touch target
          maxWidth: double.infinity,
          maxHeight: 44.0,
          iconSize: 12.0,
          textStyle: PandoraTypography.labelSmall,
        );
      case PandoraButtonSize.sm:
        return ButtonDimensions(
          padding: const EdgeInsets.symmetric(
            horizontal: PandoraSpacing.space12,
            vertical: PandoraSpacing.space6,
          ),
          minWidth: 44.0,
          minHeight: 44.0,
          maxWidth: double.infinity,
          maxHeight: 44.0,
          iconSize: 16.0,
          textStyle: PandoraTypography.labelMedium,
        );
      case PandoraButtonSize.md:
        return ButtonDimensions(
          padding: const EdgeInsets.symmetric(
            horizontal: PandoraSpacing.space16,
            vertical: PandoraSpacing.space8,
          ),
          minWidth: 44.0,
          minHeight: 44.0,
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
          minWidth: 44.0,
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
          minWidth: 44.0,
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
