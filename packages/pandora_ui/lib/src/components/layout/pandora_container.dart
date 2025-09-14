import 'package:flutter/material.dart';
import '../../tokens/color_tokens.dart';
import '../../tokens/spacing_tokens.dart';
import '../../tokens/border_tokens.dart';
import '../../tokens/shadow_tokens.dart';
import '../../utils/pandora_extensions.dart';

/// Pandora 4 Container
/// 
/// A versatile container component that embodies the "Thân Tâm Hợp Nhất" philosophy.
/// This container adapts to different layout needs while maintaining visual consistency.
enum PandoraContainerVariant {
  elevated,
  outlined,
  filled,
  flat,
}

enum PandoraContainerSize {
  xs,
  sm,
  md,
  lg,
  xl,
}

class PandoraContainer extends StatefulWidget {
  const PandoraContainer({
    super.key,
    required this.child,
    this.variant = PandoraContainerVariant.elevated,
    this.size = PandoraContainerSize.md,
    this.onTap,
    this.onLongPress,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.minWidth,
    this.minHeight,
    this.maxWidth,
    this.maxHeight,
    this.borderRadius,
    this.elevation,
    this.shadowColor,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.hoverColor,
    this.splashColor,
    this.alignment,
    this.semanticLabel,
    this.tooltip,
    this.clipBehavior = Clip.none,
    this.behavior = HitTestBehavior.opaque,
    this.gradient,
    this.image,
    this.imageFit = BoxFit.cover,
    this.imageAlignment = Alignment.center,
    this.imageRepeat = ImageRepeat.noRepeat,
    this.imageColor,
    this.imageColorBlendMode,
    this.imageFilter,
    this.imageScale,
    this.imageOpacity,
    this.imageFilterQuality = FilterQuality.low,
    this.imageSemanticLabel,
    this.imageExcludeFromSemantics = false,
    this.imageIsAntiAlias = false,
    this.imageMatchTextDirection = false,
    this.imageGaplessPlayback = false,
    this.imageFilterQualityOverride,
    this.imageErrorBuilder,
    this.imageFrameBuilder,
    this.imageLoadingBuilder,
    this.imageSemanticLabelBuilder,
    this.imageFilterQualityOverrideForPlatform,
  });

  final Widget child;
  final PandoraContainerVariant variant;
  final PandoraContainerSize size;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final double? minWidth;
  final double? minHeight;
  final double? maxWidth;
  final double? maxHeight;
  final BorderRadius? borderRadius;
  final double? elevation;
  final Color? shadowColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final Color? hoverColor;
  final Color? splashColor;
  final Alignment? alignment;
  final String? semanticLabel;
  final String? tooltip;
  final Clip clipBehavior;
  final HitTestBehavior behavior;
  final Gradient? gradient;
  final DecorationImage? image;
  final BoxFit imageFit;
  final Alignment imageAlignment;
  final ImageRepeat imageRepeat;
  final Color? imageColor;
  final BlendMode? imageColorBlendMode;
  final ColorFilter? imageFilter;
  final double? imageScale;
  final double? imageOpacity;
  final FilterQuality imageFilterQuality;
  final String? imageSemanticLabel;
  final bool imageExcludeFromSemantics;
  final bool imageIsAntiAlias;
  final bool imageMatchTextDirection;
  final bool imageGaplessPlayback;
  final FilterQuality? imageFilterQualityOverride;
  final ImageErrorWidgetBuilder? imageErrorBuilder;
  final ImageFrameBuilder? imageFrameBuilder;
  final ImageLoadingBuilder? imageLoadingBuilder;
  final ImageSemanticLabelBuilder? imageSemanticLabelBuilder;
  final FilterQuality? imageFilterQualityOverrideForPlatform;

  @override
  State<PandoraContainer> createState() => _PandoraContainerState();
}

class _PandoraContainerState extends State<PandoraContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _elevationAnimation = Tween<double>(
      begin: 0.0,
      end: 8.0,
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
    if (widget.onTap != null) {
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
    final colors = _getColors(context);
    final dimensions = _getDimensions();
    final borderRadius = widget.borderRadius ?? _getBorderRadius();
    final elevation = widget.elevation ?? _getElevation();

    Widget container = _buildContainer(
      context: context,
      colors: colors,
      dimensions: dimensions,
      borderRadius: borderRadius,
      elevation: elevation,
    );

    if (widget.tooltip != null && widget.onTap != null) {
      container = Tooltip(
        message: widget.tooltip!,
        child: container,
      );
    }

    if (widget.margin != null) {
      container = Padding(
        padding: widget.margin!,
        child: container,
      );
    }

    return container;
  }

  Widget _buildContainer({
    required BuildContext context,
    required ContainerColors colors,
    required ContainerDimensions dimensions,
    required BorderRadius borderRadius,
    required double elevation,
  }) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: widget.width,
            height: widget.height,
            constraints: BoxConstraints(
              minWidth: widget.minWidth ?? dimensions.minWidth,
              minHeight: widget.minHeight ?? dimensions.minHeight,
              maxWidth: widget.maxWidth ?? dimensions.maxWidth,
              maxHeight: widget.maxHeight ?? dimensions.maxHeight,
            ),
            decoration: BoxDecoration(
              color: colors.backgroundColor,
              borderRadius: borderRadius,
              border: colors.borderColor != null
                  ? Border.all(
                      color: colors.borderColor!,
                      width: widget.borderWidth ?? 1.0,
                    )
                  : null,
              boxShadow: elevation > 0
                  ? PandoraShadows.getShadow('card').map((shadow) {
                      return shadow.copyWith(
                        blurRadius: shadow.blurRadius + _elevationAnimation.value,
                        offset: Offset(
                          shadow.offset.dx,
                          shadow.offset.dy + _elevationAnimation.value,
                        ),
                      );
                    }).toList()
                  : null,
              gradient: widget.gradient,
              image: widget.image,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onTap,
                onLongPress: widget.onLongPress,
                borderRadius: borderRadius,
                splashColor: colors.splashColor,
                highlightColor: colors.hoverColor,
                behavior: widget.behavior,
                child: Container(
                  padding: widget.padding ?? dimensions.padding,
                  alignment: widget.alignment ?? Alignment.center,
                  child: DefaultTextStyle(
                    style: dimensions.textStyle,
                    child: widget.child,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  ContainerColors _getColors(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    switch (widget.variant) {
      case PandoraContainerVariant.elevated:
        return ContainerColors(
          backgroundColor: widget.backgroundColor ?? 
              (isDark ? PandoraColors.neutral800 : PandoraColors.surface),
          borderColor: widget.borderColor,
          hoverColor: widget.hoverColor ?? 
              (isDark ? PandoraColors.neutral700 : PandoraColors.neutral100),
          splashColor: widget.splashColor ?? 
              (isDark ? PandoraColors.neutral600 : PandoraColors.neutral200),
        );
      case PandoraContainerVariant.outlined:
        return ContainerColors(
          backgroundColor: widget.backgroundColor ?? 
              (isDark ? PandoraColors.neutral800 : PandoraColors.surface),
          borderColor: widget.borderColor ?? 
              (isDark ? PandoraColors.neutral600 : PandoraColors.outline),
          hoverColor: widget.hoverColor ?? 
              (isDark ? PandoraColors.neutral700 : PandoraColors.neutral100),
          splashColor: widget.splashColor ?? 
              (isDark ? PandoraColors.neutral600 : PandoraColors.neutral200),
        );
      case PandoraContainerVariant.filled:
        return ContainerColors(
          backgroundColor: widget.backgroundColor ?? 
              (isDark ? PandoraColors.neutral700 : PandoraColors.surfaceVariant),
          borderColor: widget.borderColor,
          hoverColor: widget.hoverColor ?? 
              (isDark ? PandoraColors.neutral600 : PandoraColors.neutral200),
          splashColor: widget.splashColor ?? 
              (isDark ? PandoraColors.neutral500 : PandoraColors.neutral300),
        );
      case PandoraContainerVariant.flat:
        return ContainerColors(
          backgroundColor: widget.backgroundColor ?? Colors.transparent,
          borderColor: widget.borderColor,
          hoverColor: widget.hoverColor ?? 
              (isDark ? PandoraColors.neutral700 : PandoraColors.neutral100),
          splashColor: widget.splashColor ?? 
              (isDark ? PandoraColors.neutral600 : PandoraColors.neutral200),
        );
    }
  }

  ContainerDimensions _getDimensions() {
    switch (widget.size) {
      case PandoraContainerSize.xs:
        return ContainerDimensions(
          padding: const EdgeInsets.all(PandoraSpacing.space8),
          minWidth: 80.0,
          minHeight: 60.0,
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          textStyle: PandoraTypography.bodySmall,
        );
      case PandoraContainerSize.sm:
        return ContainerDimensions(
          padding: const EdgeInsets.all(PandoraSpacing.space12),
          minWidth: 120.0,
          minHeight: 80.0,
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          textStyle: PandoraTypography.bodyMedium,
        );
      case PandoraContainerSize.md:
        return ContainerDimensions(
          padding: const EdgeInsets.all(PandoraSpacing.space16),
          minWidth: 160.0,
          minHeight: 100.0,
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          textStyle: PandoraTypography.bodyLarge,
        );
      case PandoraContainerSize.lg:
        return ContainerDimensions(
          padding: const EdgeInsets.all(PandoraSpacing.space20),
          minWidth: 200.0,
          minHeight: 120.0,
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          textStyle: PandoraTypography.titleSmall,
        );
      case PandoraContainerSize.xl:
        return ContainerDimensions(
          padding: const EdgeInsets.all(PandoraSpacing.space24),
          minWidth: 240.0,
          minHeight: 140.0,
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          textStyle: PandoraTypography.titleMedium,
        );
    }
  }

  BorderRadius _getBorderRadius() {
    switch (widget.size) {
      case PandoraContainerSize.xs:
        return PandoraBorders.borderRadiusSm;
      case PandoraContainerSize.sm:
        return PandoraBorders.borderRadiusMd;
      case PandoraContainerSize.md:
        return PandoraBorders.borderRadiusLg;
      case PandoraContainerSize.lg:
        return PandoraBorders.borderRadiusXl;
      case PandoraContainerSize.xl:
        return PandoraBorders.borderRadius2xl;
    }
  }

  double _getElevation() {
    switch (widget.variant) {
      case PandoraContainerVariant.elevated:
        return 4.0;
      case PandoraContainerVariant.outlined:
      case PandoraContainerVariant.filled:
        return 0.0;
      case PandoraContainerVariant.flat:
        return 0.0;
    }
  }
}

class ContainerColors {
  const ContainerColors({
    required this.backgroundColor,
    this.borderColor,
    this.hoverColor,
    this.splashColor,
  });

  final Color backgroundColor;
  final Color? borderColor;
  final Color? hoverColor;
  final Color? splashColor;
}

class ContainerDimensions {
  const ContainerDimensions({
    required this.padding,
    required this.minWidth,
    required this.minHeight,
    required this.maxWidth,
    required this.maxHeight,
    required this.textStyle,
  });

  final EdgeInsets padding;
  final double minWidth;
  final double minHeight;
  final double maxWidth;
  final double maxHeight;
  final TextStyle textStyle;
}
