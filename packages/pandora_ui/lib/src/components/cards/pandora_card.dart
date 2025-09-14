import 'package:flutter/material.dart';
import '../../tokens/color_tokens.dart';
import '../../tokens/spacing_tokens.dart';
import '../../tokens/border_tokens.dart';
import '../../tokens/shadow_tokens.dart';
import '../../utils/pandora_extensions.dart';

/// Pandora 4 Card
/// 
/// A versatile card component that embodies the "Thân Tâm Hợp Nhất" philosophy.
/// This card adapts to different content types while maintaining visual consistency.
enum PandoraCardVariant {
  elevated,
  outlined,
  filled,
  flat,
}

enum PandoraCardSize {
  xs,
  sm,
  md,
  lg,
  xl,
}

class PandoraCard extends StatefulWidget {
  const PandoraCard({
    super.key,
    required this.child,
    this.variant = PandoraCardVariant.elevated,
    this.size = PandoraCardSize.md,
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
  });

  final Widget child;
  final PandoraCardVariant variant;
  final PandoraCardSize size;
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

  @override
  State<PandoraCard> createState() => _PandoraCardState();
}

class _PandoraCardState extends State<PandoraCard>
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

    Widget card = _buildCard(
      context: context,
      colors: colors,
      dimensions: dimensions,
      borderRadius: borderRadius,
      elevation: elevation,
    );

    if (widget.tooltip != null && widget.onTap != null) {
      card = Tooltip(
        message: widget.tooltip!,
        child: card,
      );
    }

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
    required CardColors colors,
    required CardDimensions dimensions,
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

  CardColors _getColors(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    switch (widget.variant) {
      case PandoraCardVariant.elevated:
        return CardColors(
          backgroundColor: widget.backgroundColor ?? 
              (isDark ? PandoraColors.neutral800 : PandoraColors.surface),
          borderColor: widget.borderColor,
          hoverColor: widget.hoverColor ?? 
              (isDark ? PandoraColors.neutral700 : PandoraColors.neutral100),
          splashColor: widget.splashColor ?? 
              (isDark ? PandoraColors.neutral600 : PandoraColors.neutral200),
        );
      case PandoraCardVariant.outlined:
        return CardColors(
          backgroundColor: widget.backgroundColor ?? 
              (isDark ? PandoraColors.neutral800 : PandoraColors.surface),
          borderColor: widget.borderColor ?? 
              (isDark ? PandoraColors.neutral600 : PandoraColors.outline),
          hoverColor: widget.hoverColor ?? 
              (isDark ? PandoraColors.neutral700 : PandoraColors.neutral100),
          splashColor: widget.splashColor ?? 
              (isDark ? PandoraColors.neutral600 : PandoraColors.neutral200),
        );
      case PandoraCardVariant.filled:
        return CardColors(
          backgroundColor: widget.backgroundColor ?? 
              (isDark ? PandoraColors.neutral700 : PandoraColors.surfaceVariant),
          borderColor: widget.borderColor,
          hoverColor: widget.hoverColor ?? 
              (isDark ? PandoraColors.neutral600 : PandoraColors.neutral200),
          splashColor: widget.splashColor ?? 
              (isDark ? PandoraColors.neutral500 : PandoraColors.neutral300),
        );
      case PandoraCardVariant.flat:
        return CardColors(
          backgroundColor: widget.backgroundColor ?? Colors.transparent,
          borderColor: widget.borderColor,
          hoverColor: widget.hoverColor ?? 
              (isDark ? PandoraColors.neutral700 : PandoraColors.neutral100),
          splashColor: widget.splashColor ?? 
              (isDark ? PandoraColors.neutral600 : PandoraColors.neutral200),
        );
    }
  }

  CardDimensions _getDimensions() {
    switch (widget.size) {
      case PandoraCardSize.xs:
        return CardDimensions(
          padding: const EdgeInsets.all(PandoraSpacing.space8),
          minWidth: 120.0,
          minHeight: 80.0,
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          textStyle: PandoraTypography.bodySmall,
        );
      case PandoraCardSize.sm:
        return CardDimensions(
          padding: const EdgeInsets.all(PandoraSpacing.space12),
          minWidth: 160.0,
          minHeight: 100.0,
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          textStyle: PandoraTypography.bodyMedium,
        );
      case PandoraCardSize.md:
        return CardDimensions(
          padding: const EdgeInsets.all(PandoraSpacing.space16),
          minWidth: 200.0,
          minHeight: 120.0,
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          textStyle: PandoraTypography.bodyLarge,
        );
      case PandoraCardSize.lg:
        return CardDimensions(
          padding: const EdgeInsets.all(PandoraSpacing.space20),
          minWidth: 240.0,
          minHeight: 140.0,
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          textStyle: PandoraTypography.titleSmall,
        );
      case PandoraCardSize.xl:
        return CardDimensions(
          padding: const EdgeInsets.all(PandoraSpacing.space24),
          minWidth: 280.0,
          minHeight: 160.0,
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          textStyle: PandoraTypography.titleMedium,
        );
    }
  }

  BorderRadius _getBorderRadius() {
    switch (widget.size) {
      case PandoraCardSize.xs:
        return PandoraBorders.borderRadiusSm;
      case PandoraCardSize.sm:
        return PandoraBorders.borderRadiusMd;
      case PandoraCardSize.md:
        return PandoraBorders.borderRadiusLg;
      case PandoraCardSize.lg:
        return PandoraBorders.borderRadiusXl;
      case PandoraCardSize.xl:
        return PandoraBorders.borderRadius2xl;
    }
  }

  double _getElevation() {
    switch (widget.variant) {
      case PandoraCardVariant.elevated:
        return 4.0;
      case PandoraCardVariant.outlined:
      case PandoraCardVariant.filled:
        return 0.0;
      case PandoraCardVariant.flat:
        return 0.0;
    }
  }
}

class CardColors {
  const CardColors({
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

class CardDimensions {
  const CardDimensions({
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
