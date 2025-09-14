// file: packages/pandora_ui/lib/src/widgets/pandora_progress_bar.dart
import 'package:flutter/material.dart';
import 'package:pandora_ui/src/tokens.dart';

enum PandoraProgressBarVariant {
  linear,
  circular,
}

enum PandoraProgressBarSize {
  small,
  medium,
  large,
}

class PandoraProgressBar extends StatelessWidget {
  final double value;
  final PandoraProgressBarVariant variant;
  final PandoraProgressBarSize size;
  final Color? backgroundColor;
  final Color? valueColor;
  final String? label;
  final TextStyle? labelStyle;
  final bool showPercentage;
  final double? strokeWidth;
  final double? height;

  const PandoraProgressBar({
    super.key,
    required this.value,
    this.variant = PandoraProgressBarVariant.linear,
    this.size = PandoraProgressBarSize.medium,
    this.backgroundColor,
    this.valueColor,
    this.label,
    this.labelStyle,
    this.showPercentage = false,
    this.strokeWidth,
    this.height,
  }) : assert(value >= 0.0 && value <= 1.0, 'Value must be between 0.0 and 1.0');

  Color get _defaultBackgroundColor {
    return backgroundColor ?? AppColors.onSurfaceVariant.withOpacity(0.3);
  }

  Color get _defaultValueColor {
    return valueColor ?? AppColors.primary;
  }

  double get _defaultHeight {
    if (height != null) return height!;
    
    switch (size) {
      case PandoraProgressBarSize.small:
        return 4;
      case PandoraProgressBarSize.medium:
        return 6;
      case PandoraProgressBarSize.large:
        return 8;
    }
  }

  double get _defaultStrokeWidth {
    if (strokeWidth != null) return strokeWidth!;
    
    switch (size) {
      case PandoraProgressBarSize.small:
        return 3;
      case PandoraProgressBarSize.medium:
        return 4;
      case PandoraProgressBarSize.large:
        return 6;
    }
  }

  double get _circularSize {
    switch (size) {
      case PandoraProgressBarSize.small:
        return 32;
      case PandoraProgressBarSize.medium:
        return 48;
      case PandoraProgressBarSize.large:
        return 64;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (variant == PandoraProgressBarVariant.circular) {
      return _buildCircularProgress();
    }

    return _buildLinearProgress();
  }

  Widget _buildLinearProgress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null || showPercentage) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (label != null)
                Text(
                  label!,
                  style: labelStyle ?? PTokens.typography.label,
                ),
              if (showPercentage)
                Text(
                  '${(value * 100).round()}%',
                  style: labelStyle ?? PTokens.typography.label,
                ),
            ],
          ),
          const SizedBox(height: PTokens.spacingSm),
        ],
        Container(
          height: _defaultHeight,
          decoration: BoxDecoration(
            color: _defaultBackgroundColor,
            borderRadius: PTokens.radius.chip,
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: value,
            child: Container(
              decoration: BoxDecoration(
                color: _defaultValueColor,
                borderRadius: PTokens.radius.chip,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCircularProgress() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: _circularSize,
          height: _circularSize,
          child: Stack(
            children: [
              CircularProgressIndicator(
                value: value,
                strokeWidth: _defaultStrokeWidth,
                backgroundColor: _defaultBackgroundColor,
                valueColor: AlwaysStoppedAnimation<Color>(_defaultValueColor),
              ),
              if (showPercentage)
                Center(
                  child: Text(
                    '${(value * 100).round()}%',
                    style: PTokens.typography.label.copyWith(
                      fontSize: _circularSize * 0.2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (label != null) ...[
          const SizedBox(height: PTokens.spacingSm),
          Text(
            label!,
            style: labelStyle ?? PTokens.typography.label,
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
