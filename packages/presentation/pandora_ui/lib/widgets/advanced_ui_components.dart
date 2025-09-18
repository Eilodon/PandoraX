import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:design_tokens/design_tokens.dart';

/// Advanced UI components for enhanced user experience
class AdvancedUIComponents {
  /// Create animated loading indicator with custom styling
  static Widget animatedLoadingIndicator({
    required String message,
    Color? color,
    double size = 40.0,
    Duration duration = const Duration(seconds: 2),
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? PandoraColors.primary,
            ),
            strokeWidth: 3.0,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          message,
          style: PandoraTextStyles.bodyMedium.copyWith(
            color: PandoraColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// Create shimmer loading effect
  static Widget shimmerLoading({
    required Widget child,
    Duration duration = const Duration(milliseconds: 1500),
    Color? baseColor,
    Color? highlightColor,
  }) {
    return Shimmer(
      duration: duration,
      baseColor: baseColor ?? PandoraColors.surfaceVariant,
      highlightColor: highlightColor ?? PandoraColors.surface,
      child: child,
    );
  }

  /// Create gradient button with advanced styling
  static Widget gradientButton({
    required String text,
    required VoidCallback onPressed,
    Gradient? gradient,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    double? elevation,
    bool isLoading = false,
    Widget? icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient ?? PandoraGradients.primary,
        borderRadius: borderRadius ?? PandoraBorderRadius.medium,
        boxShadow: elevation != null
            ? [
                BoxShadow(
                  color: PandoraColors.primary.withOpacity(0.3),
                  blurRadius: elevation,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: borderRadius ?? PandoraBorderRadius.medium,
          child: Container(
            padding: padding ?? const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading) ...[
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        PandoraColors.onPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                ] else if (icon != null) ...[
                  icon,
                  const SizedBox(width: 8),
                ],
                Text(
                  text,
                  style: PandoraTextStyles.labelLarge.copyWith(
                    color: PandoraColors.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Create floating action button with advanced features
  static Widget advancedFAB({
    required VoidCallback onPressed,
    Widget? icon,
    String? tooltip,
    Color? backgroundColor,
    Color? foregroundColor,
    double? elevation,
    bool mini = false,
    bool extended = false,
    String? label,
  }) {
    if (extended && label != null) {
      return FloatingActionButton.extended(
        onPressed: onPressed,
        icon: icon ?? const Icon(Icons.add),
        label: Text(label),
        backgroundColor: backgroundColor ?? PandoraColors.primary,
        foregroundColor: foregroundColor ?? PandoraColors.onPrimary,
        elevation: elevation ?? 6.0,
        tooltip: tooltip,
      );
    }

    return FloatingActionButton(
      onPressed: onPressed,
      child: icon ?? const Icon(Icons.add),
      backgroundColor: backgroundColor ?? PandoraColors.primary,
      foregroundColor: foregroundColor ?? PandoraColors.onPrimary,
      elevation: elevation ?? 6.0,
      mini: mini,
      tooltip: tooltip,
    );
  }

  /// Create card with advanced styling and animations
  static Widget advancedCard({
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    double? elevation,
    BorderRadius? borderRadius,
    Border? border,
    List<BoxShadow>? boxShadow,
    VoidCallback? onTap,
    bool animated = true,
    Duration animationDuration = const Duration(milliseconds: 200),
  }) {
    Widget cardWidget = Container(
      padding: padding ?? const EdgeInsets.all(16),
      margin: margin ?? const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: backgroundColor ?? PandoraColors.surface,
        borderRadius: borderRadius ?? PandoraBorderRadius.medium,
        border: border,
        boxShadow: boxShadow ?? [
          BoxShadow(
            color: PandoraColors.shadow.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );

    if (onTap != null) {
      cardWidget = InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? PandoraBorderRadius.medium,
        child: cardWidget,
      );
    }

    if (animated) {
      return AnimatedContainer(
        duration: animationDuration,
        curve: Curves.easeInOut,
        child: cardWidget,
      );
    }

    return cardWidget;
  }

  /// Create input field with advanced features
  static Widget advancedInputField({
    required String label,
    String? hint,
    TextEditingController? controller,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    void Function()? onTap,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool obscureText = false,
    TextInputType? keyboardType,
    int? maxLines,
    int? maxLength,
    bool enabled = true,
    Color? fillColor,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? contentPadding,
    InputBorder? border,
    InputBorder? focusedBorder,
    InputBorder? errorBorder,
    InputBorder? enabledBorder,
    InputBorder? disabledBorder,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: fillColor ?? PandoraColors.surfaceVariant.withOpacity(0.5),
        contentPadding: contentPadding ?? const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: border ?? OutlineInputBorder(
          borderRadius: borderRadius ?? PandoraBorderRadius.medium,
          borderSide: BorderSide(color: PandoraColors.outline),
        ),
        focusedBorder: focusedBorder ?? OutlineInputBorder(
          borderRadius: borderRadius ?? PandoraBorderRadius.medium,
          borderSide: BorderSide(color: PandoraColors.primary, width: 2),
        ),
        errorBorder: errorBorder ?? OutlineInputBorder(
          borderRadius: borderRadius ?? PandoraBorderRadius.medium,
          borderSide: BorderSide(color: PandoraColors.error),
        ),
        enabledBorder: enabledBorder ?? OutlineInputBorder(
          borderRadius: borderRadius ?? PandoraBorderRadius.medium,
          borderSide: BorderSide(color: PandoraColors.outline),
        ),
        disabledBorder: disabledBorder ?? OutlineInputBorder(
          borderRadius: borderRadius ?? PandoraBorderRadius.medium,
          borderSide: BorderSide(color: PandoraColors.outline.withOpacity(0.5)),
        ),
      ),
    );
  }

  /// Create bottom sheet with advanced styling
  static Future<T?> showAdvancedBottomSheet<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool isDismissible = true,
    bool enableDrag = true,
    double? height,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor ?? PandoraColors.surface,
          borderRadius: borderRadius ?? const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          boxShadow: boxShadow ?? [
            BoxShadow(
              color: PandoraColors.shadow.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null) ...[
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: PandoraTextStyles.headlineSmall.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
            ],
            Flexible(child: child),
          ],
        ),
      ),
    );
  }

  /// Create dialog with advanced styling
  static Future<T?> showAdvancedDialog<T>({
    required BuildContext context,
    required String title,
    required String content,
    List<Widget>? actions,
    bool barrierDismissible = true,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    double? elevation,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AlertDialog(
        backgroundColor: backgroundColor ?? PandoraColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? PandoraBorderRadius.large,
        ),
        elevation: elevation ?? 8.0,
        title: Text(
          title,
          style: PandoraTextStyles.headlineSmall.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          content,
          style: PandoraTextStyles.bodyMedium,
        ),
        actions: actions ?? [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'OK',
              style: PandoraTextStyles.labelLarge.copyWith(
                color: PandoraColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Create snackbar with advanced styling
  static void showAdvancedSnackBar({
    required BuildContext context,
    required String message,
    Color? backgroundColor,
    Color? textColor,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    bool showCloseIcon = true,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Expanded(
              child: Text(
                message,
                style: PandoraTextStyles.bodyMedium.copyWith(
                  color: textColor ?? PandoraColors.onSurface,
                ),
              ),
            ),
            if (showCloseIcon)
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
                icon: const Icon(Icons.close, size: 20),
                color: textColor ?? PandoraColors.onSurface,
              ),
          ],
        ),
        backgroundColor: backgroundColor ?? PandoraColors.inverseSurface,
        duration: duration,
        action: action,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: PandoraBorderRadius.medium,
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  /// Create progress indicator with custom styling
  static Widget advancedProgressIndicator({
    required double value,
    String? label,
    Color? backgroundColor,
    Color? valueColor,
    double height = 8.0,
    BorderRadius? borderRadius,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label,
            style: PandoraTextStyles.bodySmall.copyWith(
              color: PandoraColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
        ],
        ClipRRect(
          borderRadius: borderRadius ?? PandoraBorderRadius.small,
          child: LinearProgressIndicator(
            value: value,
            backgroundColor: backgroundColor ?? PandoraColors.surfaceVariant,
            valueColor: AlwaysStoppedAnimation<Color>(
              valueColor ?? PandoraColors.primary,
            ),
            minHeight: height,
          ),
        ),
      ],
    );
  }

  /// Create chip with advanced styling
  static Widget advancedChip({
    required String label,
    Widget? avatar,
    Widget? deleteIcon,
    VoidCallback? onDeleted,
    VoidCallback? onTap,
    Color? backgroundColor,
    Color? textColor,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
    bool selected = false,
  }) {
    return FilterChip(
      label: Text(
        label,
        style: PandoraTextStyles.labelMedium.copyWith(
          color: textColor ?? (selected ? PandoraColors.onPrimary : PandoraColors.onSurface),
        ),
      ),
      avatar: avatar,
      deleteIcon: deleteIcon,
      onDeleted: onDeleted,
      onSelected: onTap != null ? (_) => onTap() : null,
      selected: selected,
      backgroundColor: backgroundColor ?? PandoraColors.surfaceVariant,
      selectedColor: PandoraColors.primary,
      checkmarkColor: PandoraColors.onPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? PandoraBorderRadius.medium,
      ),
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }

  /// Create divider with custom styling
  static Widget advancedDivider({
    double? height,
    double? thickness,
    Color? color,
    double? indent,
    double? endIndent,
  }) {
    return Divider(
      height: height ?? 1.0,
      thickness: thickness ?? 1.0,
      color: color ?? PandoraColors.outline,
      indent: indent ?? 0.0,
      endIndent: endIndent ?? 0.0,
    );
  }

  /// Create spacer with custom size
  static Widget advancedSpacer({
    double? width,
    double? height,
  }) {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}

/// Shimmer loading effect widget
class Shimmer extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Color baseColor;
  final Color highlightColor;

  const Shimmer({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1500),
    required this.baseColor,
    required this.highlightColor,
  });

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                widget.baseColor,
                widget.highlightColor,
                widget.baseColor,
              ],
              stops: [
                _animation.value - 0.3,
                _animation.value,
                _animation.value + 0.3,
              ].map((stop) => stop.clamp(0.0, 1.0)).toList(),
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }
}
