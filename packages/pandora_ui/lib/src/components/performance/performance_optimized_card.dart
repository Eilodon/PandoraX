import 'package:flutter/material.dart';
import '../../services/performance_optimization_service.dart';
import '../../services/memory_management_service.dart';
import '../../services/animation_optimization_service.dart';
import '../../enums/common_enums.dart';
import '../../tokens/color_tokens.dart';
import '../../tokens/typography_tokens.dart';
import '../../tokens/spacing_tokens.dart';
import '../../tokens/shadow_tokens.dart';

/// Performance Optimized Pandora Card
/// 
/// High-performance card component with advanced optimization features
/// for Phase 3 performance optimization
class PerformanceOptimizedCard extends StatefulWidget {
  const PerformanceOptimizedCard({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.variant = PerformanceCardVariant.elevated,
    this.size = PerformanceCardSize.medium,
    this.state = PerformanceCardState.enabled,
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
    
    // Performance optimization properties
    this.enableCaching = true,
    this.cacheKey,
    this.cacheDuration,
    this.enableRepaintBoundary = true,
    this.enableLazyLoading = false,
    this.isVisible = true,
    this.lazyLoadingDelay,
    this.estimatedMemorySize,
    
    // Animation properties
    this.enableAnimations = true,
    this.animationType = AnimationType.medium,
    this.animationDuration,
    this.animationCurve,
    this.enableGPUAcceleration = true,
    
    // Memory optimization properties
    this.enableMemoryOptimization = true,
    this.memoryOptimizationLevel = MemoryOptimizationLevel.medium,
    
    // Accessibility properties
    this.accessibilityLabel,
    this.accessibilityHint,
    this.accessibilityValue,
    this.excludeSemantics = false,
  });

  final Widget child;
  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final PerformanceCardVariant variant;
  final PerformanceCardSize size;
  final PerformanceCardState state;
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
  
  // Performance optimization properties
  final bool enableCaching;
  final String? cacheKey;
  final Duration? cacheDuration;
  final bool enableRepaintBoundary;
  final bool enableLazyLoading;
  final bool isVisible;
  final Duration? lazyLoadingDelay;
  final int? estimatedMemorySize;
  
  // Animation properties
  final bool enableAnimations;
  final AnimationType animationType;
  final Duration? animationDuration;
  final Curve? animationCurve;
  final bool enableGPUAcceleration;
  
  // Memory optimization properties
  final bool enableMemoryOptimization;
  final MemoryOptimizationLevel memoryOptimizationLevel;
  
  // Accessibility properties
  final String? accessibilityLabel;
  final String? accessibilityHint;
  final String? accessibilityValue;
  final bool excludeSemantics;

  @override
  State<PerformanceOptimizedCard> createState() => _PerformanceOptimizedCardState();
}

class _PerformanceOptimizedCardState extends State<PerformanceOptimizedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  
  bool _isInitialized = false;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _isInitialized = true;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    if (!widget.enableAnimations) return;
    
    _animationController = AnimationOptimizationService.createOptimizedController(
      vsync: this,
      type: widget.animationType,
      customDuration: widget.animationDuration,
      key: widget.cacheKey,
    );
    
    _fadeAnimation = AnimationOptimizationService.createOptimizedAnimation<double>(
      controller: _animationController,
      begin: 0.0,
      end: 1.0,
      type: widget.animationType,
      customCurve: widget.animationCurve,
    );
    
    _scaleAnimation = AnimationOptimizationService.createOptimizedAnimation<double>(
      controller: _animationController,
      begin: 0.8,
      end: 1.0,
      type: widget.animationType,
      customCurve: widget.animationCurve,
    );
    
    _slideAnimation = AnimationOptimizationService.createOptimizedAnimation<Offset>(
      controller: _animationController,
      begin: const Offset(0, 0.3),
      end: Offset.zero,
      type: widget.animationType,
      customCurve: widget.animationCurve,
    );
  }

  void _startAnimation() {
    if (!widget.enableAnimations || _isAnimating) return;
    
    setState(() {
      _isAnimating = true;
    });
    
    _animationController.forward().then((_) {
      if (mounted) {
        setState(() {
          _isAnimating = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const SizedBox.shrink();
    }

    // Start animation if enabled
    if (widget.enableAnimations && !_isAnimating) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _startAnimation();
      });
    }

    Widget card = _buildCard();

    // Apply performance optimizations
    card = _applyPerformanceOptimizations(card);

    // Apply memory optimizations
    if (widget.enableMemoryOptimization) {
      card = _applyMemoryOptimizations(card);
    }

    // Apply lazy loading
    if (widget.enableLazyLoading) {
      card = _applyLazyLoading(card);
    }

    return card;
  }

  Widget _buildCard() {
    final isEnabled = widget.state == PerformanceCardState.enabled;
    final isDisabled = widget.state == PerformanceCardState.disabled;
    final isLoading = widget.state == PerformanceCardState.loading;
    final isError = widget.state == PerformanceCardState.error;

    final colors = _getColors(context);
    final dimensions = _getDimensions();
    final borderRadius = widget.borderRadius ?? _getBorderRadius();
    final elevation = widget.elevation ?? _getElevation();

    Widget card = Container(
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
          colors: colors,
          dimensions: dimensions,
          isLoading: isLoading,
          isError: isError,
        ),
      ),
    );

    // Add tap handling
    if (isEnabled && widget.onTap != null) {
      card = GestureDetector(
        onTap: widget.onTap,
        child: card,
      );
    }

    // Add animations
    if (widget.enableAnimations) {
      card = _buildAnimatedCard(card);
    }

    return card;
  }

  Widget _buildAnimatedCard(Widget card) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        return Transform.translate(
          offset: Offset(
            _slideAnimation.value.dx * MediaQuery.of(context).size.width,
            _slideAnimation.value.dy * MediaQuery.of(context).size.height,
          ),
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Opacity(
              opacity: _fadeAnimation.value,
              child: card,
            ),
          ),
        );
      },
    );
  }

  Widget _buildCardChild({
    required CardColors colors,
    required CardDimensions dimensions,
    required bool isLoading,
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

  Widget _applyPerformanceOptimizations(Widget card) {
    if (widget.enableRepaintBoundary) {
      card = PerformanceOptimizationService.createRepaintBoundary(
        child: card,
        key: widget.cacheKey,
      );
    }

    if (widget.enableCaching && widget.cacheKey != null) {
      card = PerformanceOptimizationService.createCachedWidget(
        key: widget.cacheKey!,
        builder: () => card,
        cacheDuration: widget.cacheDuration,
      );
    }

    return card;
  }

  Widget _applyMemoryOptimizations(Widget card) {
    return MemoryManagementService.createMemoryEfficientWidget(
      key: widget.cacheKey ?? 'performance_card_${widget.hashCode}',
      builder: () => card,
      estimatedMemorySize: widget.estimatedMemorySize,
      enableCaching: widget.enableCaching,
      cacheDuration: widget.cacheDuration,
    );
  }

  Widget _applyLazyLoading(Widget card) {
    return MemoryManagementService.createLazyWidget(
      key: widget.cacheKey ?? 'lazy_card_${widget.hashCode}',
      builder: () => card,
      isVisible: widget.isVisible,
      delay: widget.lazyLoadingDelay,
      estimatedMemorySize: widget.estimatedMemorySize,
    );
  }

  CardColors _getColors(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color baseBackgroundColor;
    Color baseForegroundColor;
    
    switch (widget.variant) {
      case PerformanceCardVariant.elevated:
        baseBackgroundColor = widget.backgroundColor ?? 
            (isDark ? PandoraColors.neutral800 : PandoraColors.white);
        baseForegroundColor = widget.foregroundColor ?? 
            (isDark ? PandoraColors.neutral100 : PandoraColors.neutral900);
        break;
      case PerformanceCardVariant.outlined:
        baseBackgroundColor = widget.backgroundColor ?? 
            (isDark ? PandoraColors.neutral800 : PandoraColors.white);
        baseForegroundColor = widget.foregroundColor ?? 
            (isDark ? PandoraColors.neutral100 : PandoraColors.neutral900);
        break;
      case PerformanceCardVariant.filled:
        baseBackgroundColor = widget.backgroundColor ?? 
            (isDark ? PandoraColors.neutral700 : PandoraColors.neutral100);
        baseForegroundColor = widget.foregroundColor ?? 
            (isDark ? PandoraColors.neutral100 : PandoraColors.neutral900);
        break;
      case PerformanceCardVariant.primary:
        baseBackgroundColor = widget.backgroundColor ?? 
            (isDark ? PandoraColors.primary400 : PandoraColors.primary500);
        baseForegroundColor = widget.foregroundColor ?? PandoraColors.white;
        break;
      case PerformanceCardVariant.secondary:
        baseBackgroundColor = widget.backgroundColor ?? 
            (isDark ? PandoraColors.secondary400 : PandoraColors.secondary500);
        baseForegroundColor = widget.foregroundColor ?? PandoraColors.white;
        break;
    }

    return CardColors(
      backgroundColor: baseBackgroundColor,
      foregroundColor: baseForegroundColor,
      borderColor: widget.borderColor,
      disabledColor: isDark ? PandoraColors.neutral600 : PandoraColors.neutral300,
    );
  }

  CardDimensions _getDimensions() {
    switch (widget.size) {
      case PerformanceCardSize.small:
        return CardDimensions(
          padding: const EdgeInsets.all(12),
          maxWidth: double.infinity,
          maxHeight: 120.0,
          iconSize: 16.0,
          titleStyle: PandoraTypography.labelLarge,
          subtitleStyle: PandoraTypography.bodySmall,
          contentStyle: PandoraTypography.bodySmall,
        );
      case PerformanceCardSize.medium:
        return CardDimensions(
          padding: const EdgeInsets.all(16),
          maxWidth: double.infinity,
          maxHeight: 160.0,
          iconSize: 20.0,
          titleStyle: PandoraTypography.titleSmall,
          subtitleStyle: PandoraTypography.bodyMedium,
          contentStyle: PandoraTypography.bodyMedium,
        );
      case PerformanceCardSize.large:
        return CardDimensions(
          padding: const EdgeInsets.all(20),
          maxWidth: double.infinity,
          maxHeight: 200.0,
          iconSize: 24.0,
          titleStyle: PandoraTypography.titleMedium,
          subtitleStyle: PandoraTypography.bodyLarge,
          contentStyle: PandoraTypography.bodyLarge,
        );
      case PerformanceCardSize.extraLarge:
        return CardDimensions(
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

  BorderRadius _getBorderRadius() {
    switch (widget.size) {
      case PerformanceCardSize.small:
        return BorderRadius.circular(8.0);
      case PerformanceCardSize.medium:
        return BorderRadius.circular(12.0);
      case PerformanceCardSize.large:
        return BorderRadius.circular(16.0);
      case PerformanceCardSize.extraLarge:
        return BorderRadius.circular(20.0);
    }
  }

  double _getElevation() {
    switch (widget.variant) {
      case PerformanceCardVariant.elevated:
        return 2.0;
      case PerformanceCardVariant.outlined:
      case PerformanceCardVariant.filled:
        return 0.0;
      case PerformanceCardVariant.primary:
      case PerformanceCardVariant.secondary:
        return 1.0;
    }
  }
}

// Enums
enum PerformanceCardVariant {
  elevated,
  outlined,
  filled,
  primary,
  secondary,
}

enum PerformanceCardSize {
  small,
  medium,
  large,
  extraLarge,
}

enum PerformanceCardState {
  enabled,
  disabled,
  loading,
  error,
}

enum MemoryOptimizationLevel {
  low,
  medium,
  high,
}

// Helper classes
class CardColors {
  const CardColors({
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderColor,
    this.disabledColor,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
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
