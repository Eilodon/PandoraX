// file: packages/pandora_ui/lib/src/widgets/pandora_chip.dart
import 'package:flutter/material.dart';
import 'package:pandora_ui/src/tokens.dart';

enum PandoraChipVariant {
  filled,
  outlined,
  elevated,
}

enum PandoraChipSize {
  small,
  medium,
  large,
}

class PandoraChip extends StatelessWidget {
  final String label;
  final PandoraChipVariant variant;
  final PandoraChipSize size;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final VoidCallback? onTap;
  final VoidCallback? onDeleted;
  final bool selected;
  final bool enabled;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final EdgeInsets? padding;

  const PandoraChip({
    super.key,
    required this.label,
    this.variant = PandoraChipVariant.filled,
    this.size = PandoraChipSize.medium,
    this.leadingIcon,
    this.trailingIcon,
    this.onTap,
    this.onDeleted,
    this.selected = false,
    this.enabled = true,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.padding,
  });

  Color get _backgroundColor {
    if (!enabled) {
      return AppColors.onSurfaceVariant.withOpacity(PTokens.opacity.disabled);
    }

    if (selected) {
      return backgroundColor ?? AppColors.primary;
    }

    switch (variant) {
      case PandoraChipVariant.filled:
        return backgroundColor ?? AppColors.surface;
      case PandoraChipVariant.outlined:
        return Colors.transparent;
      case PandoraChipVariant.elevated:
        return backgroundColor ?? AppColors.surface;
    }
  }

  Color get _foregroundColor {
    if (!enabled) {
      return AppColors.onSurfaceVariant.withOpacity(PTokens.opacity.disabled);
    }

    if (selected) {
      return foregroundColor ?? AppColors.onPrimary;
    }

    return foregroundColor ?? AppColors.onSurface;
  }

  Color get _borderColor {
    if (!enabled) {
      return AppColors.onSurfaceVariant.withOpacity(PTokens.opacity.disabled);
    }

    return borderColor ?? AppColors.onSurfaceVariant;
  }

  double get _fontSize {
    switch (size) {
      case PandoraChipSize.small:
        return 11;
      case PandoraChipSize.medium:
        return 12;
      case PandoraChipSize.large:
        return 14;
    }
  }

  double get _iconSize {
    switch (size) {
      case PandoraChipSize.small:
        return 14;
      case PandoraChipSize.medium:
        return 16;
      case PandoraChipSize.large:
        return 18;
    }
  }

  EdgeInsets get _padding {
    if (padding != null) return padding!;

    switch (size) {
      case PandoraChipSize.small:
        return const EdgeInsets.symmetric(
          horizontal: PTokens.spacingSm,
          vertical: PTokens.spacingXs,
        );
      case PandoraChipSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: PTokens.spacingMd,
          vertical: PTokens.spacingSm,
        );
      case PandoraChipSize.large:
        return const EdgeInsets.symmetric(
          horizontal: PTokens.spacingLg,
          vertical: PTokens.spacingMd,
        );
    }
  }

  List<BoxShadow> get _shadows {
    if (variant == PandoraChipVariant.elevated && enabled) {
      return [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final chip = Container(
      padding: _padding,
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: PTokens.radius.chip,
        border: variant == PandoraChipVariant.outlined
            ? Border.all(color: _borderColor, width: 1)
            : null,
        boxShadow: _shadows,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingIcon != null) ...[
            Icon(
              leadingIcon,
              color: _foregroundColor,
              size: _iconSize,
            ),
            const SizedBox(width: PTokens.spacingXs),
          ],
          Text(
            label,
            style: PTokens.typography.label.copyWith(
              color: _foregroundColor,
              fontSize: _fontSize,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
          if (trailingIcon != null) ...[
            const SizedBox(width: PTokens.spacingXs),
            Icon(
              trailingIcon,
              color: _foregroundColor,
              size: _iconSize,
            ),
          ],
        ],
      ),
    );

    if (onTap != null && enabled) {
      return GestureDetector(
        onTap: onTap,
        child: chip,
      );
    }

    if (onDeleted != null && enabled) {
      return Dismissible(
        key: Key(label),
        direction: DismissDirection.horizontal,
        onDismissed: (_) => onDeleted!(),
        child: chip,
      );
    }

    return chip;
  }
}
