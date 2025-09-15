import 'package:flutter/material.dart';
import '../tokens/color_tokens.dart';
import '../tokens.dart';

/// Pandora 4 Security Level Enum
/// 
/// Represents different security levels for data processing.
enum SecurityLevel {
  onDevice,
  hybrid,
  cloud,
}

/// Pandora 4 Security Cue Component
/// 
/// A visual indicator showing the security level of data processing.
class SecurityCue extends StatelessWidget {
  final SecurityLevel level;
  final double size;
  final bool showLabel;

  const SecurityCue({
    super.key,
    required this.level,
    this.size = 16,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final color = _getColorForLevel(level);
    final label = _getLabelForLevel(level);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: isDark ? PandoraColors.neutral600 : PandoraColors.neutral300,
              width: 1,
            ),
          ),
          child: Icon(
            _getIconForLevel(level),
            size: size * 0.6,
            color: PandoraColors.white,
          ),
        ),
        if (showLabel) ...[
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: isDark ? PandoraColors.neutral300 : PandoraColors.neutral600,
            ),
          ),
        ],
      ],
    );
  }

  Color _getColorForLevel(SecurityLevel level) {
    switch (level) {
      case SecurityLevel.onDevice:
        return AppColors.secureOnDevice;
      case SecurityLevel.hybrid:
        return AppColors.secureHybrid;
      case SecurityLevel.cloud:
        return AppColors.secureCloud;
    }
  }

  String _getLabelForLevel(SecurityLevel level) {
    switch (level) {
      case SecurityLevel.onDevice:
        return 'On Device';
      case SecurityLevel.hybrid:
        return 'Hybrid';
      case SecurityLevel.cloud:
        return 'Cloud';
    }
  }

  IconData _getIconForLevel(SecurityLevel level) {
    switch (level) {
      case SecurityLevel.onDevice:
        return Icons.phone_android;
      case SecurityLevel.hybrid:
        return Icons.sync;
      case SecurityLevel.cloud:
        return Icons.cloud;
    }
  }
}