// file: packages/pandora_ui/lib/src/widgets/pandora_badge.dart
import 'package:flutter/material.dart';
import 'package:pandora_ui/src/tokens.dart';

enum PandoraBadgeVariant {
  primary,
  secondary,
  success,
  warning,
  error,
  info,
}

enum PandoraBadgeSize {
  small,
  medium,
  large,
}

class PandoraBadge extends StatelessWidget {
  final String text;
  final PandoraBadgeVariant variant;
  final PandoraBadgeSize size;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool enabled;

  const PandoraBadge({
    super.key,
    required this.text,
    this.variant = PandoraBadgeVariant.primary,
    this.size = PandoraBadgeSize.medium,
    this.icon,
    this.onTap,
    this.enabled = true,
  });

  Color get _backgroundColor {
    if (!enabled) {
      return AppColors.onSurfaceVariant.withValues(alpha: PTokens.opacity.disabled);
    }
    
    switch (variant) {
      case PandoraBadgeVariant.primary:
        return AppColors.primary;
      case PandoraBadgeVariant.secondary:
        return AppColors.accent;
      case PandoraBadgeVariant.success:
        return AppColors.secureOnDevice;
      case PandoraBadgeVariant.warning:
        return AppColors.warning500;
      case PandoraBadgeVariant.error:
        return AppColors.error;
      case PandoraBadgeVariant.info:
        return AppColors.secureHybrid;
    }
  }

  Color get _textColor {
    if (!enabled) {
      return AppColors.onSurfaceVariant.withValues(alpha: PTokens.opacity.disabled);
    }
    
    switch (variant) {
      case PandoraBadgeVariant.primary:
      case PandoraBadgeVariant.secondary:
      case PandoraBadgeVariant.success:
      case PandoraBadgeVariant.warning:
      case PandoraBadgeVariant.error:
      case PandoraBadgeVariant.info:
        return AppColors.onPrimary;
    }
  }

  double get _padding {
    switch (size) {
      case PandoraBadgeSize.small:
        return PTokens.spacingXs;
      case PandoraBadgeSize.medium:
        return PTokens.spacingSm;
      case PandoraBadgeSize.large:
        return PTokens.spacingMd;
    }
  }

  double get _fontSize {
    switch (size) {
      case PandoraBadgeSize.small:
        return 10;
      case PandoraBadgeSize.medium:
        return 12;
      case PandoraBadgeSize.large:
        return 14;
    }
  }

  double get _iconSize {
    switch (size) {
      case PandoraBadgeSize.small:
        return 12;
      case PandoraBadgeSize.medium:
        return 14;
      case PandoraBadgeSize.large:
        return 16;
    }
  }

  @override
  Widget build(BuildContext context) {
    final badge = Container(
      padding: EdgeInsets.symmetric(
        horizontal: _padding,
        vertical: _padding * 0.5,
      ),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: PTokens.radius.chip,
        border: Border.all(
          color: _backgroundColor,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: _textColor,
              size: _iconSize,
            ),
            const SizedBox(width: PTokens.spacingXs),
          ],
          Text(
            text,
            style: PTokens.typography.label.copyWith(
              color: _textColor,
              fontSize: _fontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );

    if (onTap != null && enabled) {
      return GestureDetector(
        onTap: onTap,
        child: badge,
      );
    }

    return badge;
  }
}
