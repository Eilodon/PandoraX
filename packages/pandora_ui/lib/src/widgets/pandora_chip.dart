import 'package:flutter/material.dart';
import '../tokens/color_tokens.dart';

/// Pandora 4 Chip Component
/// 
/// A versatile chip component for tags, categories, and status indicators.
enum PandoraChipVariant {
  filled,
  outlined,
  elevated,
}

class PandoraChip extends StatelessWidget {
  final String label;
  final PandoraChipVariant variant;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onTap;
  final VoidCallback? onDeleted;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;

  const PandoraChip({
    super.key,
    required this.label,
    this.variant = PandoraChipVariant.filled,
    this.backgroundColor,
    this.textColor,
    this.onTap,
    this.onDeleted,
    this.leading,
    this.trailing,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color bgColor = backgroundColor ?? _getBackgroundColor(isDark);
    Color txtColor = textColor ?? _getTextColor(isDark);

    Widget chip = Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 16),
        border: variant == PandoraChipVariant.outlined
            ? Border.all(color: PandoraColors.outline)
            : null,
        boxShadow: variant == PandoraChipVariant.elevated
            ? [
                BoxShadow(
                  color: PandoraColors.shadowColor,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              color: txtColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 4),
            trailing!,
          ],
        ],
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: chip,
      );
    }

    return chip;
  }

  Color _getBackgroundColor(bool isDark) {
    switch (variant) {
      case PandoraChipVariant.filled:
        return isDark ? PandoraColors.primary400 : PandoraColors.primary500;
      case PandoraChipVariant.outlined:
        return Colors.transparent;
      case PandoraChipVariant.elevated:
        return isDark ? PandoraColors.neutral800 : PandoraColors.surface;
    }
  }

  Color _getTextColor(bool isDark) {
    switch (variant) {
      case PandoraChipVariant.filled:
        return PandoraColors.white;
      case PandoraChipVariant.outlined:
        return isDark ? PandoraColors.primary400 : PandoraColors.primary500;
      case PandoraChipVariant.elevated:
        return isDark ? PandoraColors.neutral100 : PandoraColors.neutral900;
    }
  }
}