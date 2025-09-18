// file: packages/pandora_ui/lib/src/tokens_demo.dart
import 'package:flutter/material.dart';
import 'tokens.dart';

/// Demo widget showcasing all Pandora 4 Design Tokens
/// 
/// This widget demonstrates the "Luyện Kim" (Metal Refining) phase
/// where design tokens are encoded and ready for use.
class TokensDemo extends StatelessWidget {
  const TokensDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Pandora 4 - Design Tokens'),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.onSurface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('🎨 Color Palette', _buildColorPalette()),
            const SizedBox(height: 24),
            _buildSection('📏 Spacing System', _buildSpacingDemo()),
            const SizedBox(height: 24),
            _buildSection('🔲 Border Radius', _buildRadiusDemo()),
            const SizedBox(height: 24),
            _buildSection('📝 Typography', _buildTypographyDemo()),
            const SizedBox(height: 24),
            _buildSection('🔒 Security Cues', _buildSecurityCues()),
            const SizedBox(height: 24),
            _buildSection('⚡ Elevation', _buildElevationDemo()),
            const SizedBox(height: 24),
            _buildSection('🎯 Opacity States', _buildOpacityDemo()),
            const SizedBox(height: 24),
            _buildSection('⏱️ Duration', _buildDurationDemo()),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: PTokens.typography.title,
        ),
        const SizedBox(height: 12),
        content,
      ],
    );
  }

  Widget _buildColorPalette() {
    final colors = [
      ('Primary', AppColors.primary),
      ('Accent', AppColors.accent),
      ('Background', AppColors.background),
      ('Surface', AppColors.surface),
      ('On Primary', AppColors.onPrimary),
      ('On Surface', AppColors.onSurface),
      ('On Surface Variant', AppColors.onSurfaceVariant),
      ('Error', AppColors.error),
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: colors.map((color) => _buildColorSwatch(color.$1, color.$2)).toList(),
    );
  }

  Widget _buildColorSwatch(String name, Color color) {
    return Container(
      width: 100,
      height: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: PTokens.radius.card,
        border: Border.all(color: AppColors.onSurface.withValues(alpha: 0.2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: AppColors.surface.withValues(alpha: 0.9),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Text(
              name,
              style: PTokens.typography.label.copyWith(
                color: AppColors.onSurface,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpacingDemo() {
    final spacings = [
      ('XS', PTokens.spacingXs),
      ('SM', PTokens.spacingSm),
      ('MD', PTokens.spacingMd),
      ('LG', PTokens.spacingLg),
      ('XL', PTokens.spacingXl),
    ];

    return Column(
      children: spacings.map((spacing) => _buildSpacingItem(spacing.$1, spacing.$2)).toList(),
    );
  }

  Widget _buildSpacingItem(String name, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(name, style: PTokens.typography.label),
          ),
          const SizedBox(width: 16),
          Container(
            width: value,
            height: 20,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: PTokens.radius.chip,
            ),
          ),
          const SizedBox(width: 12),
          Text('${value.toInt()}px', style: PTokens.typography.body),
        ],
      ),
    );
  }

  Widget _buildRadiusDemo() {
    return Row(
      children: [
        _buildRadiusItem('Chip', PTokens.radius.chip),
        const SizedBox(width: 16),
        _buildRadiusItem('Card', PTokens.radius.card),
      ],
    );
  }

  Widget _buildRadiusItem(String name, BorderRadius radius) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: radius,
          ),
        ),
        const SizedBox(height: 8),
        Text(name, style: PTokens.typography.label),
      ],
    );
  }

  Widget _buildTypographyDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Title Style', style: PTokens.typography.title),
        const SizedBox(height: 8),
        Text('Label Style', style: PTokens.typography.label),
        const SizedBox(height: 8),
        Text('Body Style', style: PTokens.typography.body),
      ],
    );
  }

  Widget _buildSecurityCues() {
    final securityColors = [
      ('On Device', AppColors.secureOnDevice),
      ('Hybrid', AppColors.secureHybrid),
      ('Cloud', AppColors.secureCloud),
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: securityColors.map((color) => _buildSecurityCue(color.$1, color.$2)).toList(),
    );
  }

  Widget _buildSecurityCue(String name, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: PTokens.radius.chip,
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(name, style: PTokens.typography.label.copyWith(color: color)),
        ],
      ),
    );
  }

  Widget _buildElevationDemo() {
    return Row(
      children: [
        _buildElevationItem('Chip', PTokens.elevation.chip),
        const SizedBox(width: 16),
        _buildElevationItem('Card', PTokens.elevation.card),
      ],
    );
  }

  Widget _buildElevationItem(String name, double elevation) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: PTokens.radius.card,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: elevation * 2,
                offset: Offset(0, elevation),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(name, style: PTokens.typography.label),
        Text('${elevation.toInt()}dp', style: PTokens.typography.body),
      ],
    );
  }

  Widget _buildOpacityDemo() {
    return Column(
      children: [
        _buildOpacityItem('Armed', PTokens.opacity.armed),
        const SizedBox(height: 8),
        _buildOpacityItem('Disabled', PTokens.opacity.disabled),
      ],
    );
  }

  Widget _buildOpacityItem(String name, double opacity) {
    return Row(
      children: [
        Text(name, style: PTokens.typography.label),
        const SizedBox(width: 16),
        Container(
          width: 100,
          height: 20,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: opacity),
            borderRadius: PTokens.radius.chip,
          ),
        ),
        const SizedBox(width: 12),
        Text('${(opacity * 100).toInt()}%', style: PTokens.typography.body),
      ],
    );
  }

  Widget _buildDurationDemo() {
    return Column(
      children: [
        _buildDurationItem('Short', PTokens.duration.short),
        const SizedBox(height: 8),
        _buildDurationItem('Medium', PTokens.duration.medium),
      ],
    );
  }

  Widget _buildDurationItem(String name, Duration duration) {
    return Row(
      children: [
        Text(name, style: PTokens.typography.label),
        const SizedBox(width: 16),
        Text('${duration.inMilliseconds}ms', style: PTokens.typography.body),
      ],
    );
  }
}
