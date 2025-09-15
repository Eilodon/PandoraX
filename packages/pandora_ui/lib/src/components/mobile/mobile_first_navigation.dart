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

/// Mobile-First Pandora Navigation
/// 
/// Enhanced navigation component specifically designed for mobile-first development
/// with advanced responsive behavior, touch optimization, and mobile UX enhancements
class MobileFirstNavigation extends StatefulWidget {
  const MobileFirstNavigation({
    super.key,
    required this.items,
    this.currentIndex = 0,
    this.onTap,
    this.type = MobileNavigationType.bottom,
    this.variant = MobileNavigationVariant.elevated,
    this.size = MobileNavigationSize.medium,
    this.state = MobileNavigationState.enabled,
    this.backgroundColor,
    this.foregroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.borderColor,
    this.hoverColor,
    this.focusColor,
    this.splashColor,
    this.disabledColor,
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

  final List<MobileNavigationItem> items;
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final MobileNavigationType type;
  final MobileNavigationVariant variant;
  final MobileNavigationSize size;
  final MobileNavigationState state;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? borderColor;
  final Color? hoverColor;
  final Color? focusColor;
  final Color? splashColor;
  final Color? disabledColor;
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
  State<MobileFirstNavigation> createState() => _MobileFirstNavigationState();
}

class _MobileFirstNavigationState extends State<MobileFirstNavigation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late List<FocusNode> _focusNodes;
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
    
    _focusNodes = List.generate(
      widget.items.length,
      (index) => FocusNode(),
    );
    
    for (final focusNode in _focusNodes) {
      focusNode.addListener(_onFocusChange);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    for (final focusNode in _focusNodes) {
      focusNode.removeListener(_onFocusChange);
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNodes.any((node) => node.hasFocus);
    });
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.state == MobileNavigationState.enabled) {
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

  void _handleItemTap(int index) {
    if (widget.state == MobileNavigationState.enabled && widget.onTap != null) {
      widget.onTap!(index);
      AccessibilityService.announceCompletion('Navigation item ${index + 1} selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.state == MobileNavigationState.enabled;
    final isDisabled = widget.state == MobileNavigationState.disabled;
    final isLoading = widget.state == MobileNavigationState.loading;
    final isError = widget.state == MobileNavigationState.error;

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

    Widget navigation = _buildNavigation(
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
      navigation = Semantics(
        label: accessibilityLabel,
        hint: accessibilityHint,
        value: accessibilityValue,
        button: true,
        enabled: isEnabled,
        focused: _isFocused,
        child: navigation,
      );
    }

    // Add margin
    if (widget.margin != null) {
      navigation = Padding(
        padding: widget.margin!,
        child: navigation,
      );
    }

    return navigation;
  }

  Widget _buildNavigation({
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

    Widget navigation = AnimatedBuilder(
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
      child: _buildNavigationContent(
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
        child: navigation,
      );

      // Add swipe gestures
      if (widget.enableSwipeGestures) {
        navigation = TouchOptimizationService.createSwipeDetector(
          child: gestureDetector,
          onSwipeLeft: widget.onSwipeLeft,
          onSwipeRight: widget.onSwipeRight,
          onSwipeUp: widget.onSwipeUp,
          onSwipeDown: widget.onSwipeDown,
        );
      }

      // Add pinch gestures
      if (widget.enablePinchGestures) {
        navigation = TouchOptimizationService.createPinchDetector(
          child: navigation,
          onPinch: widget.onPinch,
        );
      }

      // Add drag gestures
      if (widget.enableDragGestures) {
        navigation = TouchOptimizationService.createDragDetector(
          child: navigation,
          onDrag: widget.onDrag,
          onDragStart: widget.onDragStart,
          onDragEnd: widget.onDragEnd,
        );
      }

      // Add ripple effect
      if (widget.rippleEffect) {
        navigation = Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {}, // Empty tap handler
            borderRadius: borderRadius,
            splashColor: colors.splashColor,
            highlightColor: colors.hoverColor,
            child: navigation,
          ),
        );
      }

      return navigation;
    }

    return navigation;
  }

  Widget _buildNavigationContent({
    required BuildContext context,
    required NavigationColors colors,
    required NavigationDimensions dimensions,
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
        boxShadow: elevation > 0 ? PandoraShadows.getShadow('navigation') : null,
      ),
      clipBehavior: widget.clipBehavior,
      child: Container(
        padding: widget.padding ?? dimensions.padding,
        alignment: widget.alignment ?? Alignment.center,
        child: _buildNavigationChild(
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

  Widget _buildNavigationChild({
    required BuildContext context,
    required NavigationColors colors,
    required NavigationDimensions dimensions,
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

    switch (widget.type) {
      case MobileNavigationType.bottom:
        return _buildBottomNavigation(colors, dimensions);
      case MobileNavigationType.top:
        return _buildTopNavigation(colors, dimensions);
      case MobileNavigationType.side:
        return _buildSideNavigation(colors, dimensions);
      case MobileNavigationType.tab:
        return _buildTabNavigation(colors, dimensions);
    }
  }

  Widget _buildBottomNavigation(NavigationColors colors, NavigationDimensions dimensions) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: widget.items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final isSelected = index == widget.currentIndex;
        
        return _buildNavigationItem(
          item: item,
          index: index,
          isSelected: isSelected,
          colors: colors,
          dimensions: dimensions,
        );
      }).toList(),
    );
  }

  Widget _buildTopNavigation(NavigationColors colors, NavigationDimensions dimensions) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: widget.items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final isSelected = index == widget.currentIndex;
        
        return _buildNavigationItem(
          item: item,
          index: index,
          isSelected: isSelected,
          colors: colors,
          dimensions: dimensions,
        );
      }).toList(),
    );
  }

  Widget _buildSideNavigation(NavigationColors colors, NavigationDimensions dimensions) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: widget.items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final isSelected = index == widget.currentIndex;
        
        return _buildNavigationItem(
          item: item,
          index: index,
          isSelected: isSelected,
          colors: colors,
          dimensions: dimensions,
        );
      }).toList(),
    );
  }

  Widget _buildTabNavigation(NavigationColors colors, NavigationDimensions dimensions) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: widget.items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final isSelected = index == widget.currentIndex;
        
        return _buildNavigationItem(
          item: item,
          index: index,
          isSelected: isSelected,
          colors: colors,
          dimensions: dimensions,
        );
      }).toList(),
    );
  }

  Widget _buildNavigationItem({
    required MobileNavigationItem item,
    required int index,
    required bool isSelected,
    required NavigationColors colors,
    required NavigationDimensions dimensions,
  }) {
    final itemColors = isSelected ? colors.selectedColor : colors.unselectedColor;
    
    return GestureDetector(
      onTap: () => _handleItemTap(index),
      child: Container(
        padding: dimensions.itemPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              item.icon,
              size: dimensions.iconSize,
              color: itemColors,
            ),
            if (item.label != null) ...[
              SizedBox(height: dimensions.iconLabelSpacing),
              Text(
                item.label!,
                style: dimensions.labelStyle.copyWith(color: itemColors),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _getAccessibilityLabel() {
    if (widget.accessibilityLabel != null) {
      return widget.accessibilityLabel!;
    }
    
    return AccessibilityService.getSemanticLabel('navigation', {
      'type': widget.type.name,
      'state': widget.state.name,
    });
  }

  String _getAccessibilityHint() {
    if (widget.accessibilityHint != null) {
      return widget.accessibilityHint!;
    }
    
    String hint = AccessibilityService.getAccessibilityHint('navigation', {
      'isEnabled': widget.state == MobileNavigationState.enabled,
    });
    
    hint += ', ${widget.items.length} items';
    
    return hint;
  }

  String _getAccessibilityValue() {
    if (widget.accessibilityValue != null) {
      return widget.accessibilityValue!;
    }
    
    return AccessibilityService.getAccessibilityValue('navigation', {
      'currentIndex': widget.currentIndex,
      'totalItems': widget.items.length,
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

  NavigationColors _getColors(BuildContext context, MobileBreakpoint breakpoint) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Get base colors
    Color baseBackgroundColor;
    Color baseForegroundColor;
    
    switch (widget.variant) {
      case MobileNavigationVariant.elevated:
        baseBackgroundColor = widget.backgroundColor ?? 
            (isDark ? PandoraColors.neutral800 : PandoraColors.white);
        baseForegroundColor = widget.foregroundColor ?? 
            (isDark ? PandoraColors.neutral100 : PandoraColors.neutral900);
        break;
      case MobileNavigationVariant.filled:
        baseBackgroundColor = widget.backgroundColor ?? 
            (isDark ? PandoraColors.neutral700 : PandoraColors.neutral100);
        baseForegroundColor = widget.foregroundColor ?? 
            (isDark ? PandoraColors.neutral100 : PandoraColors.neutral900);
        break;
      case MobileNavigationVariant.primary:
        baseBackgroundColor = widget.backgroundColor ?? 
            (isDark ? PandoraColors.primary400 : PandoraColors.primary500);
        baseForegroundColor = widget.foregroundColor ?? PandoraColors.white;
        break;
      case MobileNavigationVariant.secondary:
        baseBackgroundColor = widget.backgroundColor ?? 
            (isDark ? PandoraColors.secondary400 : PandoraColors.secondary500);
        baseForegroundColor = widget.foregroundColor ?? PandoraColors.white;
        break;
    }

    return NavigationColors(
      backgroundColor: baseBackgroundColor,
      foregroundColor: baseForegroundColor,
      selectedColor: widget.selectedColor ?? 
          (isDark ? PandoraColors.primary400 : PandoraColors.primary500),
      unselectedColor: widget.unselectedColor ?? 
          (isDark ? PandoraColors.neutral400 : PandoraColors.neutral600),
      borderColor: widget.borderColor,
      hoverColor: widget.hoverColor,
      focusColor: widget.focusColor,
      splashColor: widget.splashColor,
      disabledColor: widget.disabledColor ?? 
          (isDark ? PandoraColors.neutral600 : PandoraColors.neutral300),
    );
  }

  NavigationDimensions _getDimensions(MobileBreakpoint breakpoint, MobileSize size) {
    final baseSize = _getBaseSize();
    final multiplier = _getSizeMultiplier(breakpoint, size);
    
    return NavigationDimensions(
      padding: EdgeInsets.symmetric(
        horizontal: baseSize.padding.horizontal * multiplier,
        vertical: baseSize.padding.vertical * multiplier,
      ),
      itemPadding: EdgeInsets.symmetric(
        horizontal: baseSize.itemPadding.horizontal * multiplier,
        vertical: baseSize.itemPadding.vertical * multiplier,
      ),
      maxWidth: baseSize.maxWidth,
      maxHeight: baseSize.maxHeight * multiplier,
      iconSize: baseSize.iconSize * multiplier,
      iconLabelSpacing: baseSize.iconLabelSpacing * multiplier,
      labelStyle: baseSize.labelStyle.copyWith(
        fontSize: baseSize.labelStyle.fontSize! * multiplier,
      ),
    );
  }

  _BaseNavigationSize _getBaseSize() {
    switch (widget.size) {
      case MobileNavigationSize.small:
        return _BaseNavigationSize(
          padding: const EdgeInsets.all(8),
          itemPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          maxWidth: double.infinity,
          maxHeight: 60.0,
          iconSize: 16.0,
          iconLabelSpacing: 4.0,
          labelStyle: PandoraTypography.labelSmall,
        );
      case MobileNavigationSize.medium:
        return _BaseNavigationSize(
          padding: const EdgeInsets.all(12),
          itemPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          maxWidth: double.infinity,
          maxHeight: 80.0,
          iconSize: 20.0,
          iconLabelSpacing: 6.0,
          labelStyle: PandoraTypography.labelMedium,
        );
      case MobileNavigationSize.large:
        return _BaseNavigationSize(
          padding: const EdgeInsets.all(16),
          itemPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          maxWidth: double.infinity,
          maxHeight: 100.0,
          iconSize: 24.0,
          iconLabelSpacing: 8.0,
          labelStyle: PandoraTypography.labelLarge,
        );
      case MobileNavigationSize.extraLarge:
        return _BaseNavigationSize(
          padding: const EdgeInsets.all(20),
          itemPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          maxWidth: double.infinity,
          maxHeight: 120.0,
          iconSize: 28.0,
          iconLabelSpacing: 10.0,
          labelStyle: PandoraTypography.titleSmall,
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
      case MobileNavigationSize.small:
        return 8.0;
      case MobileNavigationSize.medium:
        return 12.0;
      case MobileNavigationSize.large:
        return 16.0;
      case MobileNavigationSize.extraLarge:
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
      case MobileNavigationVariant.elevated:
        return 2.0;
      case MobileNavigationVariant.filled:
        return 0.0;
      case MobileNavigationVariant.primary:
      case MobileNavigationVariant.secondary:
        return 1.0;
    }
  }
}

/// Mobile Navigation Item
class MobileNavigationItem {
  const MobileNavigationItem({
    required this.icon,
    this.label,
    this.tooltip,
    this.badge,
    this.enabled = true,
  });

  final IconData icon;
  final String? label;
  final String? tooltip;
  final String? badge;
  final bool enabled;
}

// Enums
enum MobileNavigationType {
  bottom,
  top,
  side,
  tab,
}

enum MobileNavigationVariant {
  elevated,
  filled,
  primary,
  secondary,
}

enum MobileNavigationSize {
  small,
  medium,
  large,
  extraLarge,
}

enum MobileNavigationState {
  enabled,
  disabled,
  loading,
  error,
}

// Helper classes
class _BaseNavigationSize {
  final EdgeInsets padding;
  final EdgeInsets itemPadding;
  final double maxWidth;
  final double maxHeight;
  final double iconSize;
  final double iconLabelSpacing;
  final TextStyle labelStyle;

  const _BaseNavigationSize({
    required this.padding,
    required this.itemPadding,
    required this.maxWidth,
    required this.maxHeight,
    required this.iconSize,
    required this.iconLabelSpacing,
    required this.labelStyle,
  });
}

class NavigationColors {
  const NavigationColors({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.selectedColor,
    required this.unselectedColor,
    this.borderColor,
    this.hoverColor,
    this.focusColor,
    this.splashColor,
    this.disabledColor,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final Color selectedColor;
  final Color unselectedColor;
  final Color? borderColor;
  final Color? hoverColor;
  final Color? focusColor;
  final Color? splashColor;
  final Color? disabledColor;
}

class NavigationDimensions {
  const NavigationDimensions({
    required this.padding,
    required this.itemPadding,
    required this.maxWidth,
    required this.maxHeight,
    required this.iconSize,
    required this.iconLabelSpacing,
    required this.labelStyle,
  });

  final EdgeInsets padding;
  final EdgeInsets itemPadding;
  final double maxWidth;
  final double maxHeight;
  final double iconSize;
  final double iconLabelSpacing;
  final TextStyle labelStyle;
}
