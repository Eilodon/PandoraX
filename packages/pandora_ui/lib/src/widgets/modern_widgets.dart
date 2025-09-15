/// Modern Flutter widgets using latest patterns and best practices
/// 
/// This file demonstrates modern Flutter widget patterns
/// for better performance and maintainability
library modern_widgets;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/modern_dart_utils.dart';

/// Modern button widget with enhanced features
class ModernButton extends StatefulWidget {
  const ModernButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.variant = const PrimaryButton(),
    this.size = const MediumButton(),
    this.isLoading = false,
    this.disabled = false,
    this.icon,
    this.iconPosition = IconPosition.start,
    this.fullWidth = false,
    this.borderRadius,
    this.elevation,
    this.padding,
    this.margin,
    this.style,
    this.tooltip,
    this.semanticLabel,
    this.autofocus = false,
    this.focusNode,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final ModernButtonVariant variant;
  final ModernButtonSize size;
  final bool isLoading;
  final bool disabled;
  final Widget? icon;
  final IconPosition iconPosition;
  final bool fullWidth;
  final BorderRadius? borderRadius;
  final double? elevation;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final ButtonStyle? style;
  final String? tooltip;
  final String? semanticLabel;
  final bool autofocus;
  final FocusNode? focusNode;

  @override
  State<ModernButton> createState() => _ModernButtonState();
}

class _ModernButtonState extends State<ModernButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.onPressed != null && !widget.disabled && !widget.isLoading) {
      setState(() => _isPressed = true);
      _animationController.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (_isPressed) {
      setState(() => _isPressed = false);
      _animationController.reverse();
    }
  }

  void _handleTapCancel() {
    if (_isPressed) {
      setState(() => _isPressed = false);
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEnabled = widget.onPressed != null && !widget.disabled && !widget.isLoading;
    
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: _handleTapDown,
            onTapUp: _handleTapUp,
            onTapCancel: _handleTapCancel,
            onTap: isEnabled ? widget.onPressed : null,
            child: Container(
              width: widget.fullWidth ? double.infinity : null,
              padding: widget.padding ?? _getDefaultPadding(),
              margin: widget.margin,
              decoration: BoxDecoration(
                color: _getBackgroundColor(theme, isEnabled),
                borderRadius: widget.borderRadius ?? _getDefaultBorderRadius(),
                boxShadow: _getBoxShadow(theme, isEnabled),
                border: _getBorder(theme, isEnabled),
              ),
              child: Row(
                mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.icon != null && widget.iconPosition == IconPosition.start)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: widget.icon!,
                    ),
                  if (widget.isLoading)
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  else
                    widget.child,
                  if (widget.icon != null && widget.iconPosition == IconPosition.end)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: widget.icon!,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  EdgeInsets _getDefaultPadding() {
    return switch (widget.size) {
      SmallButton() => const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      MediumButton() => const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      LargeButton() => const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    };
  }

  BorderRadius _getDefaultBorderRadius() {
    return switch (widget.size) {
      SmallButton() => BorderRadius.circular(6),
      MediumButton() => BorderRadius.circular(8),
      LargeButton() => BorderRadius.circular(12),
    };
  }

  Color _getBackgroundColor(ThemeData theme, bool isEnabled) {
    if (!isEnabled) return theme.disabledColor;
    
    return switch (widget.variant) {
      PrimaryButton() => theme.primaryColor,
      SecondaryButton() => theme.colorScheme.secondary,
      OutlineButton() => Colors.transparent,
      TextButton() => Colors.transparent,
    };
  }

  List<BoxShadow> _getBoxShadow(ThemeData theme, bool isEnabled) {
    if (!isEnabled || widget.elevation == 0) return [];
    
    return [
      BoxShadow(
        color: theme.shadowColor.withOpacity(0.2),
        blurRadius: widget.elevation ?? 4,
        offset: const Offset(0, 2),
      ),
    ];
  }

  Border? _getBorder(ThemeData theme, bool isEnabled) {
    if (widget.variant is! OutlineButton) return null;
    
    return Border.all(
      color: isEnabled ? theme.primaryColor : theme.disabledColor,
      width: 1,
    );
  }
}

/// Modern button variants using sealed classes
sealed class ModernButtonVariant {
  const ModernButtonVariant();
}

final class PrimaryButton extends ModernButtonVariant {
  const PrimaryButton();
}

final class SecondaryButton extends ModernButtonVariant {
  const SecondaryButton();
}

final class OutlineButton extends ModernButtonVariant {
  const OutlineButton();
}

final class TextButton extends ModernButtonVariant {
  const TextButton();
}

/// Modern button sizes using sealed classes
sealed class ModernButtonSize {
  const ModernButtonSize();
}

final class SmallButton extends ModernButtonSize {
  const SmallButton();
}

final class MediumButton extends ModernButtonSize {
  const MediumButton();
}

final class LargeButton extends ModernButtonSize {
  const LargeButton();
}

/// Icon position enum
enum IconPosition { start, end }

/// Modern card widget with enhanced features
class ModernCard extends StatelessWidget {
  const ModernCard({
    super.key,
    required this.child,
    this.elevation = 2,
    this.borderRadius,
    this.padding,
    this.margin,
    this.color,
    this.shadowColor,
    this.border,
    this.clipBehavior = Clip.none,
    this.semanticContainer = true,
  });

  final Widget child;
  final double elevation;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;
  final Color? shadowColor;
  final Border? border;
  final Clip clipBehavior;
  final bool semanticContainer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? theme.cardColor,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        border: border,
        boxShadow: elevation > 0 ? [
          BoxShadow(
            color: (shadowColor ?? theme.shadowColor).withOpacity(0.1),
            blurRadius: elevation * 2,
            offset: Offset(0, elevation),
          ),
        ] : null,
      ),
      clipBehavior: clipBehavior,
      child: semanticContainer
          ? Semantics(
              container: true,
              child: Padding(
                padding: padding ?? const EdgeInsets.all(16),
                child: child,
              ),
            )
          : Padding(
              padding: padding ?? const EdgeInsets.all(16),
              child: child,
            ),
    );
  }
}

/// Modern input field widget with enhanced features
class ModernInputField extends StatefulWidget {
  const ModernInputField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.decoration,
    this.style,
    this.focusNode,
    this.autofocus = false,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final bool enabled;
  final bool readOnly;
  final int? maxLines;
  final int? maxLength;
  final InputDecoration? decoration;
  final TextStyle? style;
  final FocusNode? focusNode;
  final bool autofocus;

  @override
  State<ModernInputField> createState() => _ModernInputFieldState();
}

class _ModernInputFieldState extends State<ModernInputField>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _focusAnimation;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _focusAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleFocusChange(bool hasFocus) {
    setState(() => _isFocused = hasFocus);
    if (hasFocus) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return AnimatedBuilder(
      animation: _focusAnimation,
      builder: (context, child) {
        return TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          onTap: () => _handleFocusChange(true),
          onTapOutside: (_) => _handleFocusChange(false),
          decoration: widget.decoration ?? InputDecoration(
            hintText: widget.hintText,
            labelText: widget.labelText,
            helperText: widget.helperText,
            errorText: widget.errorText,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: theme.dividerColor,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: theme.dividerColor,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: theme.primaryColor,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: theme.colorScheme.error,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: theme.colorScheme.error,
                width: 2,
              ),
            ),
            filled: true,
            fillColor: widget.enabled 
                ? theme.colorScheme.surface 
                : theme.disabledColor.withOpacity(0.1),
          ),
          style: widget.style ?? theme.textTheme.bodyLarge,
        );
      },
    );
  }
}
