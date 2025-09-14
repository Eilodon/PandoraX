// file: packages/pandora_ui/lib/src/widgets/pandora_tooltip.dart
import 'package:flutter/material.dart';
import 'package:pandora_ui/src/tokens.dart';

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
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final double? margin;
  final bool showArrow;
  final Duration? showDuration;
  final Duration? hideDuration;
  final Duration? waitDuration;

  const PandoraTooltip({
    super.key,
    required this.message,
    required this.child,
    this.position = PandoraTooltipPosition.top,
    this.backgroundColor,
    this.textColor,
    this.textStyle,
    this.padding,
    this.margin,
    this.showArrow = true,
    this.showDuration,
    this.hideDuration,
    this.waitDuration,
  });

  Color get _defaultBackgroundColor {
    return backgroundColor ?? AppColors.surface;
  }

  Color get _defaultTextColor {
    return textColor ?? AppColors.onSurface;
  }

  EdgeInsets get _defaultPadding {
    return padding ?? const EdgeInsets.symmetric(
      horizontal: PTokens.spacingMd,
      vertical: PTokens.spacingSm,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      decoration: BoxDecoration(
        color: _defaultBackgroundColor,
        borderRadius: PTokens.radius.card,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      textStyle: textStyle ?? PTokens.typography.body.copyWith(
        color: _defaultTextColor,
      ),
      padding: _defaultPadding,
      margin: EdgeInsets.all(margin ?? PTokens.spacingSm),
      showDuration: showDuration ?? const Duration(seconds: 2),
      hideDuration: hideDuration ?? const Duration(milliseconds: 200),
      waitDuration: waitDuration ?? const Duration(milliseconds: 500),
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
