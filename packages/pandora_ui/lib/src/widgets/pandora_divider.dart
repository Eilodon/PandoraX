// file: packages/pandora_ui/lib/src/widgets/pandora_divider.dart
import 'package:flutter/material.dart';
import 'package:pandora_ui/src/tokens.dart';

enum PandoraDividerType {
  horizontal,
  vertical,
}

enum PandoraDividerVariant {
  solid,
  dashed,
  dotted,
}

class PandoraDivider extends StatelessWidget {
  final PandoraDividerType type;
  final PandoraDividerVariant variant;
  final Color? color;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final String? text;
  final TextStyle? textStyle;
  final EdgeInsets? padding;

  const PandoraDivider({
    super.key,
    this.type = PandoraDividerType.horizontal,
    this.variant = PandoraDividerVariant.solid,
    this.color,
    this.thickness,
    this.indent,
    this.endIndent,
    this.text,
    this.textStyle,
    this.padding,
  });

  Color get _defaultColor {
    return color ?? AppColors.onSurfaceVariant;
  }

  double get _defaultThickness {
    return thickness ?? 1.0;
  }

  @override
  Widget build(BuildContext context) {
    if (text != null) {
      return _buildDividerWithText();
    }

    return _buildSimpleDivider();
  }

  Widget _buildDividerWithText() {
    if (type == PandoraDividerType.vertical) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildLine(),
          Padding(
            padding: padding ?? const EdgeInsets.symmetric(vertical: PTokens.spacingSm),
            child: Text(
              text!,
              style: textStyle ?? PTokens.typography.label.copyWith(
                color: _defaultColor,
              ),
            ),
          ),
          _buildLine(),
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: _buildLine()),
        Padding(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: PTokens.spacingMd),
          child: Text(
            text!,
            style: textStyle ?? PTokens.typography.label.copyWith(
              color: _defaultColor,
            ),
          ),
        ),
        Expanded(child: _buildLine()),
      ],
    );
  }

  Widget _buildSimpleDivider() {
    if (type == PandoraDividerType.vertical) {
      return Container(
        width: _defaultThickness,
        height: double.infinity,
        color: _defaultColor,
        margin: EdgeInsets.only(
          left: indent ?? 0,
          right: endIndent ?? 0,
        ),
      );
    }

    return Container(
      height: _defaultThickness,
      width: double.infinity,
      color: _defaultColor,
      margin: EdgeInsets.only(
        left: indent ?? 0,
        right: endIndent ?? 0,
      ),
    );
  }

  Widget _buildLine() {
    if (variant == PandoraDividerVariant.solid) {
      return Container(
        height: type == PandoraDividerType.horizontal ? _defaultThickness : null,
        width: type == PandoraDividerType.vertical ? _defaultThickness : null,
        color: _defaultColor,
      );
    }

    // For dashed and dotted variants, we'll use a simple solid line
    // In a real implementation, you might want to use CustomPainter
    return Container(
      height: type == PandoraDividerType.horizontal ? _defaultThickness : null,
      width: type == PandoraDividerType.vertical ? _defaultThickness : null,
      color: _defaultColor,
    );
  }
}
