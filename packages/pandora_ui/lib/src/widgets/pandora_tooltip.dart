import 'package:flutter/material.dart';
import '../tokens/color_tokens.dart';

/// Pandora 4 Tooltip Component
/// 
/// A contextual help tooltip for providing additional information.
enum PandoraTooltipPosition {
  top,
  bottom,
  left,
  right,
}

class PandoraTooltip extends StatelessWidget {
  final String message;
  final Widget child;
  final PandoraTooltipPosition position;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Duration showDuration;
  final Duration hideDuration;

  const PandoraTooltip({
    super.key,
    required this.message,
    required this.child,
    this.position = PandoraTooltipPosition.top,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.borderRadius,
    this.showDuration = const Duration(milliseconds: 500),
    this.hideDuration = const Duration(milliseconds: 200),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor = backgroundColor ?? 
        (isDark ? PandoraColors.neutral800 : PandoraColors.neutral900);
    final txtColor = textColor ?? 
        (isDark ? PandoraColors.neutral100 : PandoraColors.white);

    return Tooltip(
      message: message,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
      ),
      textStyle: TextStyle(
        color: txtColor,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      showDuration: showDuration,
      preferBelow: position == PandoraTooltipPosition.bottom,
      verticalOffset: _getVerticalOffset(),
      child: child,
    );
  }

  double _getVerticalOffset() {
    switch (position) {
      case PandoraTooltipPosition.top:
        return -8;
      case PandoraTooltipPosition.bottom:
        return 8;
      case PandoraTooltipPosition.left:
      case PandoraTooltipPosition.right:
        return 0;
    }
  }
}