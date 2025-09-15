import 'package:flutter/material.dart';
import '../../services/mobile_optimization_service.dart';
import '../../services/responsive_service.dart';
import '../../services/touch_optimization_service.dart';
import '../../services/accessibility_service.dart';
import '../../tokens/color_tokens.dart';
import '../../tokens/typography_tokens.dart';
import '../../tokens/spacing_tokens.dart';
import '../../tokens/border_tokens.dart';
import '../../tokens/shadow_tokens.dart';

/// Mobile-First Pandora Card
/// 
/// Enhanced card component specifically designed for mobile-first development
/// with advanced responsive behavior and touch optimization
class MobileFirstCard extends StatefulWidget {
  const MobileFirstCard({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.variant = MobileCardVariant.elevated,
    this.size = MobileCardSize.medium,
    this.state = MobileCardState.enabled,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.shadowColor,
    this.elevation,
    this.borderRadius,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.maxWidth,
    this.maxHeight,
    this.alignment,
    this.clipBehavior = Clip.none,
    
    // Mobile-specific properties
    this.touchFeedback = true,
    this.hapticFeedback = true,
    this.rippleEffect = true,
    this.scaleOnPress = true,
    this.enableSwipeGestures = false,
    this.onSwipeLeft,
    this.onSwipeRight,
    this.onSwipeUp,
    this.onSwipeDown,
    this.enablePinchGestures = false,
    this.onPinch,
    this.enableDragGestures = false,
    this.onDrag,
    this.onDragStart,
    this.onDragEnd,
    
    // Accessibility properties
    this.accessibilityLabel,
    this.accessibilityHint,
    this.accessibilityValue,
    this.excludeSemantics = false,
    this.focusOrder,
    this.focusGroup,
    this.accessibilityId,
    
    // Responsive properties
    this.mobileSize,
    this.tabletSize,
    this.desktopSize,
    this.largeDesktopSize,
    this.breakpoint,
  });

  final Widget child;
  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onDoubleTap;
  final MobileCardVariant variant;
  final MobileCardSize size;
  final MobileCardState state;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final Color? shadowColor;
  final double? elevation;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final double? maxWidth;
  final double? maxHeight;
  final Alignment? alignment;
  final Clip clipBehavior;
  
  // Mobile-specific properties
  final bool touchFeedback;
  final bool hapticFeedback;
  final bool rippleEffect;
  final bool scaleOnPress;
  final bool enableSwipeGestures;
  final VoidCallback? onSwipeLeft;
  final VoidCallback? onSwipeRight;
  final VoidCallback? onSwipeUp;
  final VoidCallback? onSwipeDown;
  final bool enablePinchGestures;
  final ValueChanged<double>? onPinch;
  final bool enableDragGestures;
  final ValueChanged<Offset>? onDrag;
  final VoidCallback? onDragStart;
  final VoidCallback? onDragEnd;
  
  // Accessibility properties
  final String? accessibilityLabel;
  final String? accessibilityHint;
  final String? accessibilityValue;
  final bool excludeSemantics;
  final int? focusOrder;
  final String? focusGroup;
  final String? accessibilityId;
  
  // Responsive properties
  final MobileSize? mobileSize;
  final MobileSize? tabletSize;
  final MobileSize? desktopSize;
  final MobileSize? largeDesktopSize;
  final MobileBreakpoint? breakpoint;

  @override
  State<MobileFirstCard> createState() => _MobileFirstCardState();
}

class _MobileFirstCardState extends State<MobileFirstCard>
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
      end: 0.98,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
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
    if (widget.state == MobileCardState.enabled) {
      setState(() {
        _isPressed = true;
      });
      
      if (widget.scaleOnPress) {
        _animationController.forward();
      }
      
      if (widget.hapticFeedback) {
        MobileOptimizationService.triggerMobileHapticFeedback(
          MobileHapticType.light,
          breakpoint: widget.breakpoint,
        );
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
    if (widget.state == MobileCardState.enabled && widget.onTap != null) {
      widget.onTap!();
      AccessibilityService.announceCompletion('Card activated');
    }
  }

  void _handleLongPress() {
    if (widget.state == MobileCardState.enabled && widget.onLongPress != null) {
      widget.onLongPress!();
      AccessibilityService.announceChange('Long press activated');
    }
  }

  void _handleDoubleTap() {
    if (widget.state == MobileCardState.enabled && widget.onDoubleTap != null) {
      widget.onDoubleTap!();
      AccessibilityService.announceChange('Double tap activated');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.state == MobileCardState.enabled;
    final isDisabled = widget.state == MobileCardState.disabled;
    final isLoading = widget.state == MobileCardState.loading;
    final isError = widget.state == MobileCardState.error;

    // Get responsive breakpoint
    final responsiveBreakpoint = widget.breakpoint ?? 
        MobileOptimizationService.getMobileBreakpoint(
          MediaQuery.of(context).size.width,
        );

    // Get responsive size
    final responsiveSize = _getResponsiveSize(responsiveBreakpoint);

    // Get accessibility properties
    final accessibilityLabel = _getAccessibilityLabel();
    final accessibilityHint = _getAccessibilityHint();
    final accessibilityValue = _getAccessibilityValue();

    Widget card = _buildCard(
      context: context,
      isEnabled: isEnabled,
      isDisabled: isDisabled,
      isLoading: isLoading,
      isError: isError,
      responsiveBreakpoint: responsiveBreakpoint,
      responsiveSize: responsiveSize,
    );

    // Add accessibility semantics
    if (!widget.excludeSemantics) {
      card = Semantics(
        label: accessibilityLabel,
        hint: accessibilityHint,
        value: accessibilityValue,
        button: widget.onTap != null,
        enabled: isEnabled,
        focused: _isFocused,
        child: card,
      );
    }

    // Add focus management
    card = Focus(
      focusNode: _focusNode,
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocused = hasFocus;
        });
        if (hasFocus) {
          AccessibilityService.announceChange(accessibilityLabel);
        }
      },
      child: card,
    );

    // Add margin
    if (widget.margin != null) {
      card = Padding(
        padding: widget.margin!,
        child: card,
      );
    }

    return card;
  }

  Widget _buildCard({
    required BuildContext context,
    required bool isEnabled,
    required bool isDisabled,
    required bool isLoading,
    required bool isError,
    required MobileBreakpoint responsiveBreakpoint,
    required MobileSize responsiveSize,
  }) {
    final colors = _getColors(context, responsiveBreakpoint);
    final dimensions = _getDimensions(responsiveBreakpoint, responsiveSize);
    final borderRadius = widget.borderRadius ?? _getBorderRadius(responsiveBreakpoint, responsiveSize);
    final elevation = widget.elevation ?? _getElevation(responsiveBreakpoint, responsiveSize);

    Widget card = AnimatedBuilder(
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
      child: _buildCardContent(
        context: context,
        colors: colors,
        dimensions: dimensions,
        borderRadius: borderRadius,
        elevation: elevation,
        isEnabled: isEnabled,
        isDisabled: isDisabled,
        isLoading: isLoading,
        isError: isError,
        responsiveBreakpoint: responsiveBreakpoint,
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
        onLongPress: widget.onLongPress != null ? _handleLongPress : null,
        onDoubleTap: widget.onDoubleTap != null ? _handleDoubleTap : null,
        child: card,
      );

      // Add swipe gestures
      if (widget.enableSwipeGestures) {
        card = TouchOptimizationService.createSwipeDetector(
          child: gestureDetector,
          onSwipeLeft: widget.onSwipeLeft,
          onSwipeRight: widget.onSwipeRight,
          onSwipeUp: widget.onSwipeUp,
          onSwipeDown: widget.onSwipeDown,
        );
      }

      // Add pinch gestures
      if (widget.enablePinchGestures) {
        card = TouchOptimizationService.createPinchDetector(
          child: card,
          onPinch: widget.onPinch,
        );
      }

      // Add drag gestures
      if (widget.enableDragGestures) {
        card = TouchOptimizationService.createDragDetector(
          child: card,
          onDrag: widget.onDrag,
          onDragStart: widget.onDragStart,
          onDragEnd: widget.onDragEnd,
        );
      }

      // Add ripple effect
      if (widget.rippleEffect) {
        card = Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _handleTap,
            onLongPress: widget.onLongPress != null ? _handleLongPress : null,
            onDoubleTap: widget.onDoubleTap != null ? _handleDoubleTap : null,
            borderRadius: borderRadius,
            splashColor: colors.splashColor,
            highlightColor: colors.hoverColor,
            child: card,
          ),
        );
      }

      return card;
    }

    return card;
  }

  Widget _buildCardContent({
    required BuildContext context,
    required CardColors colors,
    required CardDimensions dimensions,
    required BorderRadius borderRadius,
    required double elevation,
    required bool isEnabled,
    required bool isDisabled,
    required bool isLoading,
    required bool isError,
    required MobileBreakpoint responsiveBreakpoint,
    required MobileSize responsiveSize,
  }) {
    return Container(
      width: widget.width,
      height: widget.height,
      constraints: BoxConstraints(
        maxWidth: widget.maxWidth ?? dimensions.maxWidth,
        maxHeight: widget.maxHeight ?? dimensions.maxHeight,
      ),
      decoration: BoxDecoration(
        color: isDisabled ? colors.disabledColor : colors.backgroundColor,
        borderRadius: borderRadius,
        border: colors.borderColor != null
            ? Border.all(color: colors.borderColor!, width: 1.0)
            : null,
        boxShadow: elevation > 0 ? PandoraShadows.getShadow('card') : null,
      ),
      clipBehavior: widget.clipBehavior,
      child: Container(
        padding: widget.padding ?? dimensions.padding,
        alignment: widget.alignment ?? Alignment.center,
        child: _buildCardChild(
          context: context,
          colors: colors,
          dimensions: dimensions,
          isLoading: isLoading,
          isError: isError,
          responsiveBreakpoint: responsiveBreakpoint,
          responsiveSize: responsiveSize,
        ),
      ),
    );
  }

  Widget _buildCardChild({
    required BuildContext context,
    required CardColors colors,
    required CardDimensions dimensions,
    required bool isLoading,
    required bool isError,
    required MobileBreakpoint responsiveBreakpoint,
    required MobileSize responsiveSize,
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

    if (isError) {
      return Icon(
        Icons.error,
        size: dimensions.iconSize,
        color: colors.foregroundColor,
      );
    }

    final children = <Widget>[];

    // Add leading widget
    if (widget.leading != null) {
      children.add(
        Padding(
          padding: const EdgeInsets.only(right: PandoraSpacing.space8),
          child: widget.leading!,
        ),
      );
    }

    // Add main content
    children.add(
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.title != null)
              Padding(
                padding: const EdgeInsets.only(bottom: PandoraSpacing.space4),
                child: DefaultTextStyle(
                  style: dimensions.titleStyle.copyWith(color: colors.foregroundColor),
                  child: widget.title!,
                ),
              ),
            if (widget.subtitle != null)
              Padding(
                padding: const EdgeInsets.only(bottom: PandoraSpacing.space8),
                child: DefaultTextStyle(
                  style: dimensions.subtitleStyle.copyWith(color: colors.foregroundColor),
                  child: widget.subtitle!,
                ),
              ),
            DefaultTextStyle(
              style: dimensions.contentStyle.copyWith(color: colors.foregroundColor),
              child: widget.child,
            ),
          ],
        ),
      ),
    );

    // Add trailing widget
    if (widget.trailing != null) {
      children.add(
        Padding(
          padding: const EdgeInsets.only(left: PandoraSpacing.space8),
          child: widget.trailing!,
        ),
      );
    }

    return Row(
      children: children,
    );
  }

  String _getAccessibilityLabel() {
    if (widget.accessibilityLabel != null) {
      return widget.accessibilityLabel!;
    }
    
    return AccessibilityService.getSemanticLabel('card', {
      'title': widget.title?.toString() ?? '',
      'state': widget.state.name,
    });
  }

  String _getAccessibilityHint() {
    if (widget.accessibilityHint != null) {
      return widget.accessibilityHint!;
    }
    
    String hint = AccessibilityService.getAccessibilityHint('card', {
      'isEnabled': widget.state == MobileCardState.enabled,
    });
    
    if (widget.onLongPress != null) {
      hint += ', long press for more options';
    }
    
    if (widget.onDoubleTap != null) {
      hint += ', double tap for quick action';
    }
    
    return hint;
  }

  String _getAccessibilityValue() {
    if (widget.accessibilityValue != null) {
      return widget.accessibilityValue!;
    }
    
    return AccessibilityService.getAccessibilityValue('card', {
      'state': widget.state.name,
    });
  }

  MobileSize _getResponsiveSize(MobileBreakpoint breakpoint) {
    switch (breakpoint) {
      case MobileBreakpoint.mobile:
        return widget.mobileSize ?? MobileSize.regular;
      case MobileBreakpoint.tablet:
        return widget.tabletSize ?? MobileSize.comfortable;
      case MobileBreakpoint.desktop:
        return widget.desktopSize ?? MobileSize.spacious;
      case MobileBreakpoint.largeDesktop:
        return widget.largeDesktopSize ?? MobileSize.spacious;
    }
  }

  CardColors _getColors(BuildContext context, MobileBreakpoint breakpoint) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Get base colors
    Color baseBackgroundColor;
    Color baseForegroundColor;
    
    switch (widget.variant) {
      case MobileCardVariant.elevated:
        baseBackgroundColor = widget.backgroundColor ?? 
            (isDark ? PandoraColors.neutral800 : PandoraColors.white);
        baseForegroundColor = widget.foregroundColor ?? 
            (isDark ? PandoraColors.neutral100 : PandoraColors.neutral900);
        break;
      case MobileCardVariant.outlined:
        baseBackgroundColor = widget.backgroundColor ?? 
            (isDark ? PandoraColors.neutral800 : PandoraColors.white);
        baseForegroundColor = widget.foregroundColor ?? 
            (isDark ? PandoraColors.neutral100 : PandoraColors.neutral900);
        break;
      case MobileCardVariant.filled:
        baseBackgroundColor = widget.backgroundColor ?? 
            (isDark ? PandoraColors.neutral700 : PandoraColors.neutral100);
        baseForegroundColor = widget.foregroundColor ?? 
            (isDark ? PandoraColors.neutral100 : PandoraColors.neutral900);
        break;
      case MobileCardVariant.primary:
        baseBackgroundColor = widget.backgroundColor ?? 
            (isDark ? PandoraColors.primary400 : PandoraColors.primary500);
        baseForegroundColor = widget.foregroundColor ?? PandoraColors.white;
        break;
      case MobileCardVariant.secondary:
        baseBackgroundColor = widget.backgroundColor ?? 
            (isDark ? PandoraColors.secondary400 : PandoraColors.secondary500);
        baseForegroundColor = widget.foregroundColor ?? PandoraColors.white;
        break;
    }

    return CardColors(
      backgroundColor: baseBackgroundColor,
      foregroundColor: baseForegroundColor,
      borderColor: widget.borderColor,
      hoverColor: widget.hoverColor,
      focusColor: widget.focusColor,
      splashColor: widget.splashColor,
      disabledColor: widget.disabledColor ?? 
          (isDark ? PandoraColors.neutral600 : PandoraColors.neutral300),
    );
  }

  CardDimensions _getDimensions(MobileBreakpoint breakpoint, MobileSize size) {
    final baseSize = _getBaseSize();
    final multiplier = _getSizeMultiplier(breakpoint, size);
    
    return CardDimensions(
      padding: EdgeInsets.symmetric(
        horizontal: baseSize.padding.horizontal * multiplier,
        vertical: baseSize.padding.vertical * multiplier,
      ),
      maxWidth: baseSize.maxWidth,
      maxHeight: baseSize.maxHeight * multiplier,
      iconSize: baseSize.iconSize * multiplier,
      titleStyle: baseSize.titleStyle.copyWith(
        fontSize: baseSize.titleStyle.fontSize! * multiplier,
      ),
      subtitleStyle: baseSize.subtitleStyle.copyWith(
        fontSize: baseSize.subtitleStyle.fontSize! * multiplier,
      ),
      contentStyle: baseSize.contentStyle.copyWith(
        fontSize: baseSize.contentStyle.fontSize! * multiplier,
      ),
    );
  }

  _BaseCardSize _getBaseSize() {
    switch (widget.size) {
      case MobileCardSize.small:
        return _BaseCardSize(
          padding: const EdgeInsets.all(12),
          maxWidth: double.infinity,
          maxHeight: 120.0,
          iconSize: 16.0,
          titleStyle: PandoraTypography.labelLarge,
          subtitleStyle: PandoraTypography.bodySmall,
          contentStyle: PandoraTypography.bodySmall,
        );
      case MobileCardSize.medium:
        return _BaseCardSize(
          padding: const EdgeInsets.all(16),
          maxWidth: double.infinity,
          maxHeight: 160.0,
          iconSize: 20.0,
          titleStyle: PandoraTypography.titleSmall,
          subtitleStyle: PandoraTypography.bodyMedium,
          contentStyle: PandoraTypography.bodyMedium,
        );
      case MobileCardSize.large:
        return _BaseCardSize(
          padding: const EdgeInsets.all(20),
          maxWidth: double.infinity,
          maxHeight: 200.0,
          iconSize: 24.0,
          titleStyle: PandoraTypography.titleMedium,
          subtitleStyle: PandoraTypography.bodyLarge,
          contentStyle: PandoraTypography.bodyLarge,
        );
      case MobileCardSize.extraLarge:
        return _BaseCardSize(
          padding: const EdgeInsets.all(24),
          maxWidth: double.infinity,
          maxHeight: 240.0,
          iconSize: 28.0,
          titleStyle: PandoraTypography.titleLarge,
          subtitleStyle: PandoraTypography.headlineSmall,
          contentStyle: PandoraTypography.headlineSmall,
        );
    }
  }

  double _getSizeMultiplier(MobileBreakpoint breakpoint, MobileSize size) {
    final sizeMultiplier = _getSizeMultiplierForSize(size);
    final breakpointMultiplier = _getBreakpointMultiplier(breakpoint);
    return sizeMultiplier * breakpointMultiplier;
  }

  double _getSizeMultiplierForSize(MobileSize size) {
    switch (size) {
      case MobileSize.compact:
        return 0.8;
      case MobileSize.regular:
        return 1.0;
      case MobileSize.comfortable:
        return 1.2;
      case MobileSize.spacious:
        return 1.4;
    }
  }

  double _getBreakpointMultiplier(MobileBreakpoint breakpoint) {
    switch (breakpoint) {
      case MobileBreakpoint.mobile:
        return 1.0; // Mobile is the base
      case MobileBreakpoint.tablet:
        return 1.1;
      case MobileBreakpoint.desktop:
        return 1.2;
      case MobileBreakpoint.largeDesktop:
        return 1.3;
    }
  }

  BorderRadius _getBorderRadius(MobileBreakpoint breakpoint, MobileSize size) {
    final baseRadius = _getBaseBorderRadius();
    return BorderRadius.circular(
      MobileOptimizationService.getMobileBorderRadius(
        baseRadius,
        breakpoint,
        size: size,
      ),
    );
  }

  double _getBaseBorderRadius() {
    switch (widget.size) {
      case MobileCardSize.small:
        return 8.0;
      case MobileCardSize.medium:
        return 12.0;
      case MobileCardSize.large:
        return 16.0;
      case MobileCardSize.extraLarge:
        return 20.0;
    }
  }

  double _getElevation(MobileBreakpoint breakpoint, MobileSize size) {
    final baseElevation = _getBaseElevation();
    return MobileOptimizationService.getMobileElevation(
      baseElevation,
      breakpoint,
      size: size,
    );
  }

  double _getBaseElevation() {
    switch (widget.variant) {
      case MobileCardVariant.elevated:
        return 2.0;
      case MobileCardVariant.outlined:
      case MobileCardVariant.filled:
        return 0.0;
      case MobileCardVariant.primary:
      case MobileCardVariant.secondary:
        return 1.0;
    }
  }
}

// Enums
enum MobileCardVariant {
  elevated,
  outlined,
  filled,
  primary,
  secondary,
}

enum MobileCardSize {
  small,
  medium,
  large,
  extraLarge,
}

enum MobileCardState {
  enabled,
  disabled,
  loading,
  error,
}

// Helper classes
class _BaseCardSize {
  final EdgeInsets padding;
  final double maxWidth;
  final double maxHeight;
  final double iconSize;
  final TextStyle titleStyle;
  final TextStyle subtitleStyle;
  final TextStyle contentStyle;

  const _BaseCardSize({
    required this.padding,
    required this.maxWidth,
    required this.maxHeight,
    required this.iconSize,
    required this.titleStyle,
    required this.subtitleStyle,
    required this.contentStyle,
  });
}

class CardColors {
  const CardColors({
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

class CardDimensions {
  const CardDimensions({
    required this.padding,
    required this.maxWidth,
    required this.maxHeight,
    required this.iconSize,
    required this.titleStyle,
    required this.subtitleStyle,
    required this.contentStyle,
  });

  final EdgeInsets padding;
  final double maxWidth;
  final double maxHeight;
  final double iconSize;
  final TextStyle titleStyle;
  final TextStyle subtitleStyle;
  final TextStyle contentStyle;
}
