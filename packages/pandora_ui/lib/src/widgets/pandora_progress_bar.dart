import 'package:flutter/material.dart';
import '../tokens/color_tokens.dart';

/// Pandora 4 Progress Bar Component
/// 
/// A versatile progress indicator for loading states and task completion.
enum PandoraProgressBarVariant {
  linear,
  circular,
}

class PandoraProgressBar extends StatelessWidget {
  final double value;
  final PandoraProgressBarVariant variant;
  final Color? backgroundColor;
  final Color? valueColor;
  final double? strokeWidth;
  final double? height;
  final String? label;
  final TextStyle? labelStyle;

  const PandoraProgressBar({
    super.key,
    required this.value,
    this.variant = PandoraProgressBarVariant.linear,
    this.backgroundColor,
    this.valueColor,
    this.strokeWidth,
    this.height,
    this.label,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor = backgroundColor ?? 
        (isDark ? PandoraColors.neutral700 : PandoraColors.neutral200);
    final valColor = valueColor ?? 
        (isDark ? PandoraColors.primary400 : PandoraColors.primary500);

    switch (variant) {
      case PandoraProgressBarVariant.linear:
        return _buildLinearProgress(bgColor, valColor);
      case PandoraProgressBarVariant.circular:
        return _buildCircularProgress(bgColor, valColor);
    }
  }

  Widget _buildLinearProgress(Color bgColor, Color valColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: labelStyle ?? const TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 4),
        ],
        Container(
          height: height ?? 8,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: value.clamp(0.0, 1.0),
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(valColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCircularProgress(Color bgColor, Color valColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: labelStyle ?? const TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 8),
        ],
        SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(
            value: value.clamp(0.0, 1.0),
            backgroundColor: bgColor,
            valueColor: AlwaysStoppedAnimation<Color>(valColor),
            strokeWidth: strokeWidth ?? 3,
          ),
        ),
      ],
    );
  }
}