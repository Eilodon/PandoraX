// file: packages/pandora_ui/lib/src/widgets/result_card.dart
import 'package:flutter/material.dart';
import 'package:pandora_ui/src/tokens.dart';
import 'package:pandora_ui/src/widgets/security_cue.dart';

class ResultCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isLoading;
  final SecurityCue? securityCue;
  final VoidCallback? onCancel; // Cho phép hủy streaming
  final VoidCallback? onTap;

  const ResultCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.isLoading = false,
    this.securityCue,
    this.onCancel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const ShimmerResultCard();
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: PTokens.spacingSm),
      shape: RoundedRectangleBorder(borderRadius: PTokens.radius.card),
      elevation: PTokens.elevation.card,
      child: InkWell(
        onTap: onTap,
        borderRadius: PTokens.radius.card,
        child: Padding(
          padding: const EdgeInsets.all(PTokens.spacingLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: PTokens.typography.title, maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: PTokens.spacingXs),
              Text(subtitle, style: PTokens.typography.body, maxLines: 2, overflow: TextOverflow.ellipsis),
              if (securityCue != null) ...[
                const SizedBox(height: PTokens.spacingMd),
                securityCue!,
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class ShimmerResultCard extends StatefulWidget {
  const ShimmerResultCard({super.key});

  @override
  State<ShimmerResultCard> createState() => _ShimmerResultCardState();
}

class _ShimmerResultCardState extends State<ShimmerResultCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: PTokens.spacingSm),
      shape: RoundedRectangleBorder(borderRadius: PTokens.radius.card),
      elevation: PTokens.elevation.card,
      child: Padding(
        padding: const EdgeInsets.all(PTokens.spacingLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildShimmerLine(width: 200, height: 20),
            const SizedBox(height: PTokens.spacingSm),
            _buildShimmerLine(width: double.infinity, height: 16),
            const SizedBox(height: PTokens.spacingXs),
            _buildShimmerLine(width: 150, height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerLine({required double width, required double height}) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: PTokens.radius.chip,
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                AppColors.onSurfaceVariant.withOpacity(0.3),
                AppColors.onSurfaceVariant.withOpacity(0.1),
                AppColors.onSurfaceVariant.withOpacity(0.3),
              ],
              stops: [
                _animation.value - 0.3,
                _animation.value,
                _animation.value + 0.3,
              ].map((stop) => stop.clamp(0.0, 1.0)).toList(),
            ),
          ),
        );
      },
    );
  }
}
