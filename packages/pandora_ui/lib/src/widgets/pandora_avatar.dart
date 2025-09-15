// file: packages/pandora_ui/lib/src/widgets/pandora_avatar.dart
import 'package:flutter/material.dart';
import 'package:pandora_ui/src/tokens.dart';

enum PandoraAvatarSize {
  small,
  medium,
  large,
  extraLarge,
}

class PandoraAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? initials;
  final IconData? icon;
  final PandoraAvatarSize size;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback? onTap;
  final bool showBorder;
  final Color? borderColor;
  final double? borderWidth;

  const PandoraAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.icon,
    this.size = PandoraAvatarSize.medium,
    this.backgroundColor,
    this.foregroundColor,
    this.onTap,
    this.showBorder = false,
    this.borderColor,
    this.borderWidth,
  }) : assert(
          imageUrl != null || initials != null || icon != null,
          'Either imageUrl, initials, or icon must be provided',
        );

  double get _size {
    switch (size) {
      case PandoraAvatarSize.small:
        return 32;
      case PandoraAvatarSize.medium:
        return 48;
      case PandoraAvatarSize.large:
        return 64;
      case PandoraAvatarSize.extraLarge:
        return 96;
    }
  }

  double get _fontSize {
    switch (size) {
      case PandoraAvatarSize.small:
        return 12;
      case PandoraAvatarSize.medium:
        return 16;
      case PandoraAvatarSize.large:
        return 20;
      case PandoraAvatarSize.extraLarge:
        return 24;
    }
  }

  double get _iconSize {
    switch (size) {
      case PandoraAvatarSize.small:
        return 16;
      case PandoraAvatarSize.medium:
        return 24;
      case PandoraAvatarSize.large:
        return 32;
      case PandoraAvatarSize.extraLarge:
        return 48;
    }
  }

  Color get _defaultBackgroundColor {
    return backgroundColor ?? AppColors.primary;
  }

  Color get _defaultForegroundColor {
    return foregroundColor ?? AppColors.onPrimary;
  }

  @override
  Widget build(BuildContext context) {
    final avatar = Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        color: _defaultBackgroundColor,
        shape: BoxShape.circle,
        border: showBorder
            ? Border.all(
                color: borderColor ?? AppColors.onSurfaceVariant,
                width: borderWidth ?? 2,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipOval(
        child: _buildContent(),
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: avatar,
      );
    }

    return avatar;
  }

  Widget _buildContent() {
    if (imageUrl != null) {
      return Image.network(
        imageUrl!,
        width: _size,
        height: _size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildFallback();
        },
      );
    }

    return _buildFallback();
  }

  Widget _buildFallback() {
    if (initials != null) {
      return Center(
        child: Text(
          initials!,
          style: PTokens.typography.title.copyWith(
            color: _defaultForegroundColor,
            fontSize: _fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    if (icon != null) {
      return Center(
        child: Icon(
          icon,
          color: _defaultForegroundColor,
          size: _iconSize,
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
