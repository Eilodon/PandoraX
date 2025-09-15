import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../tokens/color_tokens.dart';
import '../../tokens/typography_tokens.dart';
import '../../tokens/spacing_tokens.dart';
import '../../tokens/border_tokens.dart';
import '../../tokens/shadow_tokens.dart';
import '../../services/responsive_service.dart';
import '../../services/accessibility_service.dart';
import '../../services/accessibility_colors.dart';
import '../../services/focus_management_service.dart';

/// Mobile-Optimized Pandora Button
/// 
/// Enhanced button component specifically designed for mobile devices
/// with touch-friendly interactions and responsive behavior
class MobilePandoraButton extends StatefulWidget {
  const MobilePandoraButton({
    super.key,
    required this.child,
    this.onPressed,
    this.variant = MobileButtonVariant.primary,
    this.size = MobileButtonSize.medium,
    this.state = MobileButtonState.enabled,
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
    
    // Mobile-specific properties
    this.touchFeedback = true,
    this.hapticFeedback = true,
    this.longPressEnabled = false,
    this.onLongPress,
    this.doubleTapEnabled = false,
    this.onDoubleTap,
    this.rippleEffect = true,
    this.scaleOnPress = true,
    
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
  final MobileButtonVariant variant;
  final MobileButtonSize size;
  final MobileButtonState state;
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
  
  // Mobile-specific properties
  final bool touchFeedback;
  final bool hapticFeedback;
  final bool longPressEnabled;
  final VoidCallback? onLongPress;
  final bool doubleTapEnabled;
  final VoidCallback? onDoubleTap;
  final bool rippleEffect;
  final bool scaleOnPress;
  
  // Accessibility properties
  final String? accessibilityLabel;
  final String? accessibilityHint;
  final String? accessibilityValue;
  final bool excludeSemantics;
  final int? focusOrder;
  final String? focusGroup;
  final String? accessibilityId;

  @override
  State<MobilePandoraButton> createState() => _MobilePandoraButtonState();
}

class _MobilePandoraButtonState extends State<MobilePandoraButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _isPressed = false;

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
        canFocus: widget.state == MobileButtonState.enabled,
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
    if (widget.state == MobileButtonState.enabled) {
      setState(() {
        _isPressed = true;
      });
      
      if (widget.scaleOnPress) {
        _animationController.forward();
      }
      
      if (widget.hapticFeedback) {
        HapticFeedback.lightImpact();
      }
    }
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    
    if (widget.scaleOnPress) {
      _animationController.reverse();
    }
  }

  void _handleTapCancel() {
    setState(() {
      _isPressed = false;
    });
    
    if (widget.scaleOnPress) {
      _animationController.reverse();
    }
  }

  void _handleTap() {
    if (widget.state == MobileButtonState.enabled && widget.onPressed != null) {
      widget.onPressed!();
      AccessibilityService.announceCompletion('Button activated');
    }
  }

  void _handleLongPress() {
    if (widget.state == MobileButtonState.enabled && widget.onLongPress != null) {
      widget.onLongPress!();
      AccessibilityService.announceChange('Long press activated');
    }
  }

  void _handleDoubleTap() {
    if (widget.state == MobileButtonState.enabled && widget.onDoubleTap != null) {
      widget.onDoubleTap!();
      AccessibilityService.announceChange('Double tap activated');
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
    final isEnabled = widget.state == MobileButtonState.enabled;
    final isDisabled = widget.state == MobileButtonState.disabled;
    final isLoading = widget.state == MobileButtonState.loading;
    final isSuccess = widget.state == MobileButtonState.success;
    final isError = widget.state == MobileButtonState.error;

    // Get responsive size
    final responsiveSize = ResponsiveService.getResponsiveSizeFromContext(context);

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
      responsiveSize: responsiveSize,
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
    required ResponsiveSize responsiveSize,
  }) {
    final colors = _getColors(context);
    final dimensions = _getDimensions(responsiveSize);
    final borderRadius = widget.borderRadius ?? _getBorderRadius(responsiveSize);
    final elevation = widget.elevation ?? _getElevation(responsiveSize);

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
        responsiveSize: responsiveSize,
      ),
    );

    if (isEnabled && !isLoading) {
      // Create gesture detector with all supported gestures
      final gestureDetector = GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: _handleTap,
        onLongPress: widget.longPressEnabled ? _handleLongPress : null,
        onDoubleTap: widget.doubleTapEnabled ? _handleDoubleTap : null,
        child: button,
      );

      if (widget.rippleEffect) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _handleTap,
            onLongPress: widget.longPressEnabled ? _handleLongPress : null,
            onDoubleTap: widget.doubleTapEnabled ? _handleDoubleTap : null,
            borderRadius: borderRadius,
            splashColor: colors.splashColor,
            highlightColor: colors.hoverColor,
            child: button,
          ),
        );
      }

      return gestureDetector;
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
    required ResponsiveSize responsiveSize,
  }) {
    // Ensure minimum touch target size for mobile
    final minTouchTarget = ResponsiveService.getResponsiveTouchTargetSize(responsiveSize);
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
          responsiveSize: responsiveSize,
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
    required ResponsiveSize responsiveSize,
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
    
    String hint = AccessibilityService.getAccessibilityHint('button', {
      'isChecked': widget.state == MobileButtonState.enabled,
    });
    
    if (widget.longPressEnabled) {
      hint += ', long press for more options';
    }
    
    if (widget.doubleTapEnabled) {
      hint += ', double tap for quick action';
    }
    
    return hint;
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
      case MobileButtonVariant.primary:
        baseBackgroundColor = widget.backgroundColor ?? 
            (isDark ? PandoraColors.primary400 : PandoraColors.primary500);
        baseForegroundColor = widget.foregroundColor ?? PandoraColors.white;
        break;
      case MobileButtonVariant.secondary:
        baseBackgroundColor = widget.backgroundColor ?? 
            (isDark ? PandoraColors.secondary400 : PandoraColors.secondary500);
        baseForegroundColor = widget.foregroundColor ?? PandoraColors.white;
        break;
      case MobileButtonVariant.tertiary:
        baseBackgroundColor = widget.backgroundColor ?? 
            (isDark ? PandoraColors.info400 : PandoraColors.info500);
        baseForegroundColor = widget.foregroundColor ?? PandoraColors.white;
        break;
      case MobileButtonVariant.ghost:
        baseBackgroundColor = widget.backgroundColor ?? Colors.transparent;
        baseForegroundColor = widget.foregroundColor ?? 
            (isDark ? PandoraColors.neutral100 : PandoraColors.neutral900);
        break;
      case MobileButtonVariant.link:
        baseBackgroundColor = widget.backgroundColor ?? Colors.transparent;
        baseForegroundColor = widget.foregroundColor ?? 
            (isDark ? PandoraColors.primary400 : PandoraColors.primary500);
        break;
      case MobileButtonVariant.outlined:
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

  ButtonDimensions _getDimensions(ResponsiveSize responsiveSize) {
    final baseSize = _getBaseSize();
    final multiplier = _getSizeMultiplier(responsiveSize);
    
    return ButtonDimensions(
      padding: EdgeInsets.symmetric(
        horizontal: baseSize.padding.horizontal * multiplier,
        vertical: baseSize.padding.vertical * multiplier,
      ),
      minWidth: (baseSize.minWidth * multiplier).clamp(44.0, double.infinity),
      minHeight: (baseSize.minHeight * multiplier).clamp(44.0, double.infinity),
      maxWidth: baseSize.maxWidth,
      maxHeight: baseSize.maxHeight * multiplier,
      iconSize: baseSize.iconSize * multiplier,
      textStyle: baseSize.textStyle.copyWith(
        fontSize: baseSize.textStyle.fontSize! * multiplier,
      ),
    );
  }

  _BaseButtonSize _getBaseSize() {
    switch (widget.size) {
      case MobileButtonSize.small:
        return _BaseButtonSize(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          minWidth: 44.0,
          minHeight: 44.0,
          maxWidth: double.infinity,
          maxHeight: 44.0,
          iconSize: 16.0,
          textStyle: PandoraTypography.labelMedium,
        );
      case MobileButtonSize.medium:
        return _BaseButtonSize(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          minWidth: 48.0,
          minHeight: 48.0,
          maxWidth: double.infinity,
          maxHeight: 48.0,
          iconSize: 20.0,
          textStyle: PandoraTypography.labelLarge,
        );
      case MobileButtonSize.large:
        return _BaseButtonSize(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          minWidth: 52.0,
          minHeight: 52.0,
          maxWidth: double.infinity,
          maxHeight: 52.0,
          iconSize: 24.0,
          textStyle: PandoraTypography.titleSmall,
        );
      case MobileButtonSize.extraLarge:
        return _BaseButtonSize(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          minWidth: 56.0,
          minHeight: 56.0,
          maxWidth: double.infinity,
          maxHeight: 56.0,
          iconSize: 28.0,
          textStyle: PandoraTypography.titleMedium,
        );
    }
  }

  double _getSizeMultiplier(ResponsiveSize responsiveSize) {
    switch (responsiveSize) {
      case ResponsiveSize.mobile:
        return 1.0; // Mobile is the base
      case ResponsiveSize.tablet:
        return 1.1;
      case ResponsiveSize.desktop:
        return 1.2;
      case ResponsiveSize.largeDesktop:
        return 1.3;
    }
  }

  BorderRadius _getBorderRadius(ResponsiveSize responsiveSize) {
    final baseRadius = _getBaseBorderRadius();
    return BorderRadius.circular(
      ResponsiveService.getResponsiveBorderRadius(baseRadius, responsiveSize),
    );
  }

  double _getBaseBorderRadius() {
    switch (widget.size) {
      case MobileButtonSize.small:
        return 6.0;
      case MobileButtonSize.medium:
        return 8.0;
      case MobileButtonSize.large:
        return 12.0;
      case MobileButtonSize.extraLarge:
        return 16.0;
    }
  }

  double _getElevation(ResponsiveSize responsiveSize) {
    final baseElevation = _getBaseElevation();
    return ResponsiveService.getResponsiveElevation(baseElevation, responsiveSize);
  }

  double _getBaseElevation() {
    switch (widget.variant) {
      case MobileButtonVariant.primary:
      case MobileButtonVariant.secondary:
      case MobileButtonVariant.tertiary:
        return 2.0;
      case MobileButtonVariant.ghost:
      case MobileButtonVariant.link:
      case MobileButtonVariant.outlined:
        return 0.0;
    }
  }
}

// Enums
enum MobileButtonVariant {
  primary,
  secondary,
  tertiary,
  ghost,
  link,
  outlined,
}

enum MobileButtonSize {
  small,
  medium,
  large,
  extraLarge,
}

enum MobileButtonState {
  enabled,
  disabled,
  loading,
  success,
  error,
}

enum IconPosition { start, end }

// Helper classes
class _BaseButtonSize {
  final EdgeInsets padding;
  final double minWidth;
  final double minHeight;
  final double maxWidth;
  final double maxHeight;
  final double iconSize;
  final TextStyle textStyle;

  const _BaseButtonSize({
    required this.padding,
    required this.minWidth,
    required this.minHeight,
    required this.maxWidth,
    required this.maxHeight,
    required this.iconSize,
    required this.textStyle,
  });
}

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
