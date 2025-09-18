import 'package:flutter/material.dart';
import '../tokens/color_tokens.dart';
import 'security_cue.dart';

/// Pandora 4 Result Card Component
/// 
/// A specialized card for displaying AI-generated results with security indicators.
class ResultCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? content;
  final SecurityCue? securityCue;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isLoading;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;

  const ResultCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.content,
    this.securityCue,
    this.leading,
    this.trailing,
    this.onTap,
    this.isLoading = false,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
      ),
      color: isDark ? PandoraColors.neutral800 : PandoraColors.surface,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (leading != null) ...[
                    leading!,
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: isDark ? PandoraColors.neutral100 : PandoraColors.neutral900,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: isDark ? PandoraColors.neutral300 : PandoraColors.neutral600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (securityCue != null) ...[
                    const SizedBox(width: 8),
                    securityCue!,
                  ],
                  if (trailing != null) ...[
                    const SizedBox(width: 8),
                    trailing!,
                  ],
                ],
              ),
              if (content != null) ...[
                const SizedBox(height: 12),
                Text(
                  content!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isDark ? PandoraColors.neutral200 : PandoraColors.neutral700,
                  ),
                ),
              ],
              if (isLoading) ...[
                const SizedBox(height: 12),
                const LinearProgressIndicator(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Shimmer version of ResultCard for loading states
class ShimmerResultCard extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;

  const ShimmerResultCard({
    super.key,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
      ),
      color: isDark ? PandoraColors.neutral800 : PandoraColors.surface,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isDark ? PandoraColors.neutral700 : PandoraColors.neutral300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 16,
                        decoration: BoxDecoration(
                          color: isDark ? PandoraColors.neutral700 : PandoraColors.neutral300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 200,
                        height: 12,
                        decoration: BoxDecoration(
                          color: isDark ? PandoraColors.neutral700 : PandoraColors.neutral300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 12,
              decoration: BoxDecoration(
                color: isDark ? PandoraColors.neutral700 : PandoraColors.neutral300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 150,
              height: 12,
              decoration: BoxDecoration(
                color: isDark ? PandoraColors.neutral700 : PandoraColors.neutral300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}