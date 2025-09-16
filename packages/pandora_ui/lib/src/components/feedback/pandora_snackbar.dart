import 'package:flutter/material.dart';
import '../../tokens/color_tokens.dart';
import '../../tokens/typography_tokens.dart';
import '../../tokens/spacing_tokens.dart';
import '../../tokens/border_tokens.dart';

/// Pandora 4 Snackbar
/// 
/// A comprehensive snackbar component that embodies the "Thân Tâm Hợp Nhất" philosophy.
/// This snackbar adapts to different feedback types while maintaining visual consistency.
enum PandoraSnackbarVariant {
  info,
  success,
  warning,
  error,
}

enum PandoraSnackbarSize {
  sm,
  md,
  lg,
}

class PandoraSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
    PandoraSnackbarVariant variant = PandoraSnackbarVariant.info,
    PandoraSnackbarSize size = PandoraSnackbarSize.md,
    Duration duration = const Duration(seconds: 4),
    SnackBarAction? action,
    Color? backgroundColor,
    Color? textColor,
    Color? actionColor,
    Widget? icon,
    EdgeInsets? padding,
    EdgeInsets? margin,
    BorderRadius? borderRadius,
    double? elevation,
    Color? shadowColor,
    double? width,
    double? height,
    Alignment? alignment,
    String? semanticLabel,
    bool? showCloseIcon,
    Color? closeIconColor,
    VoidCallback? onVisible,
  }) {
    final colors = _getColors(context, variant);
    final dimensions = _getDimensions(size);
    final borderRadiusValue = borderRadius ?? _getBorderRadius(size);

    final snackBar = SnackBar(
      content: _buildContent(
        context: context,
        message: message,
        actionLabel: actionLabel,
        onAction: onAction,
        variant: variant,
        size: size,
        colors: colors,
        dimensions: dimensions,
        icon: icon,
        showCloseIcon: showCloseIcon,
        closeIconColor: closeIconColor,
      ),
      backgroundColor: backgroundColor ?? colors.backgroundColor,
      duration: duration,
      action: action,
      padding: padding ?? dimensions.padding,
      margin: margin,
      width: width,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadiusValue,
      ),
      elevation: elevation ?? _getElevation(),
      onVisible: onVisible,
      clipBehavior: Clip.none,
      dismissDirection: DismissDirection.horizontal,
      animation: CurvedAnimation(
        parent: kAlwaysCompleteAnimation,
        curve: Curves.easeInOut,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Widget _buildContent({
    required BuildContext context,
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
    required PandoraSnackbarVariant variant,
    required PandoraSnackbarSize size,
    required SnackbarColors colors,
    required SnackbarDimensions dimensions,
    Widget? icon,
    bool? showCloseIcon,
    Color? closeIconColor,
  }) {
    final children = <Widget>[];

    if (icon != null) {
      children.add(
        Padding(
          padding: const EdgeInsets.only(right: PandoraSpacing.space8),
          child: icon,
        ),
      );
    }

    children.add(
      Expanded(
        child: Text(
          message,
          style: dimensions.textStyle.copyWith(color: colors.textColor),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );

    if (actionLabel != null && onAction != null) {
      children.add(
        Padding(
          padding: const EdgeInsets.only(left: PandoraSpacing.space8),
          child: TextButton(
            onPressed: onAction,
            style: TextButton.styleFrom(
              foregroundColor: colors.actionColor,
              padding: const EdgeInsets.symmetric(
                horizontal: PandoraSpacing.space8,
                vertical: PandoraSpacing.space4,
              ),
            ),
            child: Text(actionLabel),
          ),
        ),
      );
    }

    if (showCloseIcon == true) {
      children.add(
        Padding(
          padding: const EdgeInsets.only(left: PandoraSpacing.space8),
          child: IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
            icon: Icon(
              Icons.close,
              color: closeIconColor ?? colors.textColor,
              size: dimensions.iconSize,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 24,
              minHeight: 24,
            ),
          ),
        ),
      );
    }

    return Row(
      children: children,
    );
  }

  static SnackbarColors _getColors(BuildContext context, PandoraSnackbarVariant variant) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    switch (variant) {
      case PandoraSnackbarVariant.info:
        return SnackbarColors(
          backgroundColor: isDark ? PandoraColors.info800 : PandoraColors.info500,
          textColor: PandoraColors.white,
          actionColor: isDark ? PandoraColors.info200 : PandoraColors.info100,
          shadowColor: PandoraColors.shadowColor,
        );
      case PandoraSnackbarVariant.success:
        return SnackbarColors(
          backgroundColor: isDark ? PandoraColors.success800 : PandoraColors.success500,
          textColor: PandoraColors.white,
          actionColor: isDark ? PandoraColors.success200 : PandoraColors.success100,
          shadowColor: PandoraColors.shadowColor,
        );
      case PandoraSnackbarVariant.warning:
        return SnackbarColors(
          backgroundColor: isDark ? PandoraColors.warning800 : PandoraColors.warning500,
          textColor: PandoraColors.white,
          actionColor: isDark ? PandoraColors.warning200 : PandoraColors.warning100,
          shadowColor: PandoraColors.shadowColor,
        );
      case PandoraSnackbarVariant.error:
        return SnackbarColors(
          backgroundColor: isDark ? PandoraColors.error800 : PandoraColors.error500,
          textColor: PandoraColors.white,
          actionColor: isDark ? PandoraColors.error200 : PandoraColors.error100,
          shadowColor: PandoraColors.shadowColor,
        );
    }
  }

  static SnackbarDimensions _getDimensions(PandoraSnackbarSize size) {
    switch (size) {
      case PandoraSnackbarSize.sm:
        return SnackbarDimensions(
          padding: const EdgeInsets.all(PandoraSpacing.space12),
          textStyle: PandoraTypography.bodySmall,
          iconSize: 16.0,
        );
      case PandoraSnackbarSize.md:
        return SnackbarDimensions(
          padding: const EdgeInsets.all(PandoraSpacing.space16),
          textStyle: PandoraTypography.bodyMedium,
          iconSize: 20.0,
        );
      case PandoraSnackbarSize.lg:
        return SnackbarDimensions(
          padding: const EdgeInsets.all(PandoraSpacing.space20),
          textStyle: PandoraTypography.bodyLarge,
          iconSize: 24.0,
        );
    }
  }

  static BorderRadius _getBorderRadius(PandoraSnackbarSize size) {
    switch (size) {
      case PandoraSnackbarSize.sm:
        return PandoraBorders.borderRadiusSm;
      case PandoraSnackbarSize.md:
        return PandoraBorders.borderRadiusMd;
      case PandoraSnackbarSize.lg:
        return PandoraBorders.borderRadiusLg;
    }
  }

  static double _getElevation() {
    return 4.0;
  }
}

class SnackbarColors {
  const SnackbarColors({
    required this.backgroundColor,
    required this.textColor,
    required this.actionColor,
    required this.shadowColor,
  });

  final Color backgroundColor;
  final Color textColor;
  final Color actionColor;
  final Color shadowColor;
}

class SnackbarDimensions {
  const SnackbarDimensions({
    required this.padding,
    required this.textStyle,
    required this.iconSize,
  });

  final EdgeInsets padding;
  final TextStyle textStyle;
  final double iconSize;
}
