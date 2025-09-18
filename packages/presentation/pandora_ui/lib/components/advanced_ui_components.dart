import 'package:flutter/material.dart';
import 'package:ai_domain/ai_domain.dart';
import 'package:core_utils/core_utils.dart';

/// Advanced UI Components for PandoraX
class AdvancedUIComponents {
  /// Create animated button
  static Widget animatedButton({
    required String text,
    required VoidCallback onPressed,
    IconData? icon,
    Color? backgroundColor,
    Color? textColor,
    double? width,
    double? height,
    double? borderRadius,
    double? elevation,
    Duration? animationDuration,
    Curve? animationCurve,
    bool enableHapticFeedback = true,
    bool enableSoundEffects = true,
  }) {
    return AnimatedButton(
      text: text,
      onPressed: onPressed,
      icon: icon,
      backgroundColor: backgroundColor,
      textColor: textColor,
      width: width,
      height: height,
      borderRadius: borderRadius,
      elevation: elevation,
      animationDuration: animationDuration,
      animationCurve: animationCurve,
      enableHapticFeedback: enableHapticFeedback,
      enableSoundEffects: enableSoundEffects,
    );
  }

  /// Create smart card
  static Widget smartCard({
    required Widget child,
    String? title,
    String? subtitle,
    Widget? leading,
    Widget? trailing,
    VoidCallback? onTap,
    Color? backgroundColor,
    double? elevation,
    double? borderRadius,
    EdgeInsets? padding,
    EdgeInsets? margin,
    bool enableHover = true,
    bool enableRipple = true,
  }) {
    return SmartCard(
      child: child,
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: trailing,
      onTap: onTap,
      backgroundColor: backgroundColor,
      elevation: elevation,
      borderRadius: borderRadius,
      padding: padding,
      margin: margin,
      enableHover: enableHover,
      enableRipple: enableRipple,
    );
  }

  /// Create progress indicator
  static Widget progressIndicator({
    required double value,
    String? label,
    Color? color,
    Color? backgroundColor,
    double? height,
    double? borderRadius,
    bool showPercentage = true,
    bool enableAnimation = true,
  }) {
    return ProgressIndicator(
      value: value,
      label: label,
      color: color,
      backgroundColor: backgroundColor,
      height: height,
      borderRadius: borderRadius,
      showPercentage: showPercentage,
      enableAnimation: enableAnimation,
    );
  }

  /// Create loading overlay
  static Widget loadingOverlay({
    required bool isLoading,
    required Widget child,
    String? message,
    Color? backgroundColor,
    Color? indicatorColor,
    double? opacity,
  }) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: child,
      message: message,
      backgroundColor: backgroundColor,
      indicatorColor: indicatorColor,
      opacity: opacity,
    );
  }

  /// Create toast notification
  static void showToast({
    required BuildContext context,
    required String message,
    ToastType type = ToastType.info,
    Duration duration = const Duration(seconds: 3),
    ToastPosition position = ToastPosition.bottom,
    bool enableHapticFeedback = true,
  }) {
    ToastNotification.show(
      context: context,
      message: message,
      type: type,
      duration: duration,
      position: position,
      enableHapticFeedback: enableHapticFeedback,
    );
  }

  /// Create confirmation dialog
  static Future<bool?> showConfirmationDialog({
    required BuildContext context,
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    Color? confirmColor,
    Color? cancelColor,
    bool enableHapticFeedback = true,
  }) {
    return ConfirmationDialog.show(
      context: context,
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
      confirmColor: confirmColor,
      cancelColor: cancelColor,
      enableHapticFeedback: enableHapticFeedback,
    );
  }

  /// Create input field
  static Widget inputField({
    required String label,
    String? hint,
    String? value,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? errorText,
    String? helperText,
    int? maxLines,
    int? maxLength,
    bool enabled = true,
    bool readOnly = false,
    Color? fillColor,
    Color? borderColor,
    double? borderRadius,
    EdgeInsets? contentPadding,
    bool enableHapticFeedback = true,
  }) {
    return InputField(
      label: label,
      hint: hint,
      value: value,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      keyboardType: keyboardType,
      obscureText: obscureText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      errorText: errorText,
      helperText: helperText,
      maxLines: maxLines,
      maxLength: maxLength,
      enabled: enabled,
      readOnly: readOnly,
      fillColor: fillColor,
      borderColor: borderColor,
      borderRadius: borderRadius,
      contentPadding: contentPadding,
      enableHapticFeedback: enableHapticFeedback,
    );
  }

  /// Create search bar
  static Widget searchBar({
    required String hint,
    String? value,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    VoidCallback? onClear,
    Widget? leading,
    Widget? trailing,
    bool enabled = true,
    bool enableHapticFeedback = true,
  }) {
    return SearchBar(
      hint: hint,
      value: value,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onClear: onClear,
      leading: leading,
      trailing: trailing,
      enabled: enabled,
      enableHapticFeedback: enableHapticFeedback,
    );
  }

  /// Create bottom sheet
  static Future<T?> showBottomSheet<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool enableDrag = true,
    bool enableDismiss = true,
    Color? backgroundColor,
    double? borderRadius,
    double? maxHeight,
    bool enableHapticFeedback = true,
  }) {
    return BottomSheet.show<T>(
      context: context,
      child: child,
      title: title,
      enableDrag: enableDrag,
      enableDismiss: enableDismiss,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      maxHeight: maxHeight,
      enableHapticFeedback: enableHapticFeedback,
    );
  }

  /// Create tab bar
  static Widget tabBar({
    required List<TabItem> tabs,
    required int selectedIndex,
    required ValueChanged<int> onTap,
    TabBarStyle style = TabBarStyle.standard,
    Color? backgroundColor,
    Color? selectedColor,
    Color? unselectedColor,
    double? height,
    bool enableHapticFeedback = true,
  }) {
    return TabBar(
      tabs: tabs,
      selectedIndex: selectedIndex,
      onTap: onTap,
      style: style,
      backgroundColor: backgroundColor,
      selectedColor: selectedColor,
      unselectedColor: unselectedColor,
      height: height,
      enableHapticFeedback: enableHapticFeedback,
    );
  }

  /// Create floating action button
  static Widget floatingActionButton({
    required VoidCallback onPressed,
    Widget? child,
    String? tooltip,
    Color? backgroundColor,
    Color? foregroundColor,
    double? elevation,
    double? size,
    bool enableHapticFeedback = true,
    bool enableSoundEffects = true,
  }) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: child,
      tooltip: tooltip,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: elevation,
      size: size,
      enableHapticFeedback: enableHapticFeedback,
      enableSoundEffects: enableSoundEffects,
    );
  }
}

/// Animated Button Widget
class AnimatedButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? elevation;
  final Duration? animationDuration;
  final Curve? animationCurve;
  final bool enableHapticFeedback;
  final bool enableSoundEffects;

  const AnimatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.borderRadius,
    this.elevation,
    this.animationDuration,
    this.animationCurve,
    this.enableHapticFeedback = true,
    this.enableSoundEffects = true,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration ?? const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: widget.animationCurve ?? Curves.easeInOut,
    ));
    
    _elevationAnimation = Tween<double>(
      begin: widget.elevation ?? 2.0,
      end: (widget.elevation ?? 2.0) * 0.5,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: widget.animationCurve ?? Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _animationController.forward();
        if (widget.enableHapticFeedback) {
          // TODO: Add haptic feedback
        }
      },
      onTapUp: (_) {
        _animationController.reverse();
        widget.onPressed();
        if (widget.enableSoundEffects) {
          // TODO: Add sound effect
        }
      },
      onTapCancel: () {
        _animationController.reverse();
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: widget.width,
              height: widget.height ?? 48.0,
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? 8.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: _elevationAnimation.value,
                    offset: Offset(0, _elevationAnimation.value),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: widget.onPressed,
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? 8.0,
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.icon != null) ...[
                          Icon(
                            widget.icon,
                            color: widget.textColor ?? Colors.white,
                            size: 20.0,
                          ),
                          const SizedBox(width: 8.0),
                        ],
                        Text(
                          widget.text,
                          style: TextStyle(
                            color: widget.textColor ?? Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Smart Card Widget
class SmartCard extends StatelessWidget {
  final Widget child;
  final String? title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final double? elevation;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool enableHover;
  final bool enableRipple;

  const SmartCard({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.backgroundColor,
    this.elevation,
    this.borderRadius,
    this.padding,
    this.margin,
    this.enableHover = true,
    this.enableRipple = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(8.0),
      child: Material(
        color: backgroundColor ?? Theme.of(context).cardColor,
        elevation: elevation ?? 2.0,
        borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
          child: Container(
            padding: padding ?? const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null || subtitle != null || leading != null || trailing != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      children: [
                        if (leading != null) ...[
                          leading!,
                          const SizedBox(width: 12.0),
                        ],
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (title != null)
                                Text(
                                  title!,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              if (subtitle != null)
                                Text(
                                  subtitle!,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).textTheme.bodySmall?.color,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if (trailing != null) trailing!,
                      ],
                    ),
                  ),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Progress Indicator Widget
class ProgressIndicator extends StatefulWidget {
  final double value;
  final String? label;
  final Color? color;
  final Color? backgroundColor;
  final double? height;
  final double? borderRadius;
  final bool showPercentage;
  final bool enableAnimation;

  const ProgressIndicator({
    super.key,
    required this.value,
    this.label,
    this.color,
    this.backgroundColor,
    this.height,
    this.borderRadius,
    this.showPercentage = true,
    this.enableAnimation = true,
  });

  @override
  State<ProgressIndicator> createState() => _ProgressIndicatorState();
}

class _ProgressIndicatorState extends State<ProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _animation = Tween<double>(
      begin: 0.0,
      end: widget.value,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    if (widget.enableAnimation) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(ProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _animation = Tween<double>(
        begin: _animation.value,
        end: widget.value,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ));
      
      if (widget.enableAnimation) {
        _animationController.forward(from: 0.0);
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.label!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        Row(
          children: [
            Expanded(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Container(
                    height: widget.height ?? 8.0,
                    decoration: BoxDecoration(
                      color: widget.backgroundColor ?? 
                          Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(
                        widget.borderRadius ?? 4.0,
                      ),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: _animation.value,
                      child: Container(
                        decoration: BoxDecoration(
                          color: widget.color ?? Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius ?? 4.0,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (widget.showPercentage)
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  '${(widget.value * 100).toInt()}%',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

/// Loading Overlay Widget
class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String? message;
  final Color? backgroundColor;
  final Color? indicatorColor;
  final double? opacity;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.message,
    this.backgroundColor,
    this.indicatorColor,
    this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: (backgroundColor ?? Colors.black).withOpacity(
              opacity ?? 0.5,
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    color: indicatorColor ?? Theme.of(context).primaryColor,
                  ),
                  if (message != null) ...[
                    const SizedBox(height: 16.0),
                    Text(
                      message!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ),
      ],
    );
  }
}

/// Toast Notification
class ToastNotification {
  static void show({
    required BuildContext context,
    required String message,
    ToastType type = ToastType.info,
    Duration duration = const Duration(seconds: 3),
    ToastPosition position = ToastPosition.bottom,
    bool enableHapticFeedback = true,
  }) {
    // TODO: Implement toast notification
    AppLogger.info('Toast notification: $message');
  }
}

/// Confirmation Dialog
class ConfirmationDialog {
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    Color? confirmColor,
    Color? cancelColor,
    bool enableHapticFeedback = true,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelText ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: confirmColor,
            ),
            child: Text(confirmText ?? 'Confirm'),
          ),
        ],
      ),
    );
  }
}

/// Input Field Widget
class InputField extends StatelessWidget {
  final String label;
  final String? hint;
  final String? value;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? errorText;
  final String? helperText;
  final int? maxLines;
  final int? maxLength;
  final bool enabled;
  final bool readOnly;
  final Color? fillColor;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsets? contentPadding;
  final bool enableHapticFeedback;

  const InputField({
    super.key,
    required this.label,
    this.hint,
    this.value,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.errorText,
    this.helperText,
    this.maxLines,
    this.maxLength,
    this.enabled = true,
    this.readOnly = false,
    this.fillColor,
    this.borderColor,
    this.borderRadius,
    this.contentPadding,
    this.enableHapticFeedback = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8.0),
        TextField(
          controller: TextEditingController(text: value),
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          keyboardType: keyboardType,
          obscureText: obscureText,
          maxLines: maxLines,
          maxLength: maxLength,
          enabled: enabled,
          readOnly: readOnly,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            errorText: errorText,
            helperText: helperText,
            filled: true,
            fillColor: fillColor ?? Theme.of(context).colorScheme.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
              borderSide: BorderSide(
                color: borderColor ?? Theme.of(context).colorScheme.outline,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
              borderSide: BorderSide(
                color: borderColor ?? Theme.of(context).colorScheme.outline,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2.0,
              ),
            ),
            contentPadding: contentPadding ?? const EdgeInsets.all(16.0),
          ),
        ),
      ],
    );
  }
}

/// Search Bar Widget
class SearchBar extends StatelessWidget {
  final String hint;
  final String? value;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final Widget? leading;
  final Widget? trailing;
  final bool enabled;
  final bool enableHapticFeedback;

  const SearchBar({
    super.key,
    required this.hint,
    this.value,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.leading,
    this.trailing,
    this.enabled = true,
    this.enableHapticFeedback = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
      child: TextField(
        controller: TextEditingController(text: value),
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        enabled: enabled,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: leading ?? const Icon(Icons.search),
          suffixIcon: value != null && value!.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: onClear,
                )
              : trailing,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 12.0,
          ),
        ),
      ),
    );
  }
}

/// Bottom Sheet Widget
class BottomSheet {
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool enableDrag = true,
    bool enableDismiss = true,
    Color? backgroundColor,
    double? borderRadius,
    double? maxHeight,
    bool enableHapticFeedback = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      enableDrag: enableDrag,
      isDismissible: enableDismiss,
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(borderRadius ?? 16.0),
        ),
      ),
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: maxHeight ?? MediaQuery.of(context).size.height * 0.9,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (enableDrag)
              Container(
                width: 40.0,
                height: 4.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
            if (title != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            Flexible(child: child),
          ],
        ),
      ),
    );
  }
}

/// Tab Bar Widget
class TabBar extends StatelessWidget {
  final List<TabItem> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final TabBarStyle style;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? unselectedColor;
  final double? height;
  final bool enableHapticFeedback;

  const TabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTap,
    this.style = TabBarStyle.standard,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.height,
    this.enableHapticFeedback = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 48.0,
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = index == selectedIndex;
          
          return Expanded(
            child: GestureDetector(
              onTap: () {
                if (enableHapticFeedback) {
                  // TODO: Add haptic feedback
                }
                onTap(index);
              },
              child: Container(
                height: height ?? 48.0,
                decoration: BoxDecoration(
                  color: isSelected
                      ? (selectedColor ?? Theme.of(context).primaryColor)
                          .withOpacity(0.1)
                      : Colors.transparent,
                  border: isSelected
                      ? Border(
                          bottom: BorderSide(
                            color: selectedColor ?? Theme.of(context).primaryColor,
                            width: 2.0,
                          ),
                        )
                      : null,
                ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (tab.icon != null) ...[
                        Icon(
                          tab.icon,
                          size: 20.0,
                          color: isSelected
                              ? (selectedColor ?? Theme.of(context).primaryColor)
                              : (unselectedColor ?? Theme.of(context).colorScheme.onSurfaceVariant),
                        ),
                        const SizedBox(width: 8.0),
                      ],
                      Text(
                        tab.text,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isSelected
                              ? (selectedColor ?? Theme.of(context).primaryColor)
                              : (unselectedColor ?? Theme.of(context).colorScheme.onSurfaceVariant),
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// Floating Action Button Widget
class FloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget? child;
  final String? tooltip;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final double? size;
  final bool enableHapticFeedback;
  final bool enableSoundEffects;

  const FloatingActionButton({
    super.key,
    required this.onPressed,
    this.child,
    this.tooltip,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.size,
    this.enableHapticFeedback = true,
    this.enableSoundEffects = true,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? Theme.of(context).primaryColor,
      elevation: elevation ?? 6.0,
      borderRadius: BorderRadius.circular((size ?? 56.0) / 2),
      child: InkWell(
        onTap: () {
          if (enableHapticFeedback) {
            // TODO: Add haptic feedback
          }
          if (enableSoundEffects) {
            // TODO: Add sound effect
          }
          onPressed();
        },
        borderRadius: BorderRadius.circular((size ?? 56.0) / 2),
        child: Container(
          width: size ?? 56.0,
          height: size ?? 56.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular((size ?? 56.0) / 2),
          ),
          child: Center(
            child: child ?? Icon(
              Icons.add,
              color: foregroundColor ?? Colors.white,
              size: 24.0,
            ),
          ),
        ),
      ),
    );
  }
}

/// Tab Item
class TabItem {
  final String text;
  final IconData? icon;
  final Widget? customWidget;

  const TabItem({
    required this.text,
    this.icon,
    this.customWidget,
  });
}

/// Toast Types
enum ToastType {
  info,
  success,
  warning,
  error,
}

/// Toast Positions
enum ToastPosition {
  top,
  center,
  bottom,
}

/// Tab Bar Styles
enum TabBarStyle {
  standard,
  filled,
  outlined,
  minimal,
}
