import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import '../../services/mobile_optimization_service.dart';
import '../../services/responsive_service.dart';
import '../../services/touch_optimization_service.dart';
import '../../services/accessibility_service.dart';
import '../../tokens/color_tokens.dart';
import '../../tokens/typography_tokens.dart';
import '../../tokens/spacing_tokens.dart';
import '../../tokens/border_tokens.dart';
import '../../tokens/shadow_tokens.dart';

/// Mobile-First Pandora Text Field
/// 
/// Enhanced text field component specifically designed for mobile-first development
/// with advanced responsive behavior, touch optimization, and mobile UX enhancements
class MobileFirstTextField extends StatefulWidget {
  const MobileFirstTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.decoration,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.readOnly = false,
    this.showCursor,
    this.autofocus = false,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled = true,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.selectionHeightStyle = BoxHeightStyle.tight,
    this.selectionWidthStyle = BoxWidthStyle.tight,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.onTap,
    this.onTapOutside,
    this.mouseCursor,
    this.buildCounter,
    this.scrollController,
    this.scrollPhysics,
    this.autofillHints,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.scribbleEnabled = true,
    this.canRequestFocus = true,
    this.spellCheckConfiguration,
    this.magnifierConfiguration,
    
    // Mobile-specific properties
    this.variant = MobileTextFieldVariant.outlined,
    this.size = MobileTextFieldSize.medium,
    this.state = MobileTextFieldState.enabled,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixText,
    this.suffixText,
    this.prefixWidget,
    this.suffixWidget,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.disabledBorderColor,
    this.hoverColor,
    this.focusColor,
    this.splashColor,
    this.disabledColor,
    this.borderRadius,
    this.elevation,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.maxWidth,
    this.maxHeight,
    this.alignment,
    
    // Mobile-specific behavior
    this.touchFeedback = true,
    this.hapticFeedback = true,
    this.rippleEffect = true,
    this.scaleOnPress = true,
    this.enableSwipeGestures = false,
    this.onSwipeLeft,
    this.onSwipeRight,
    this.onSwipeUp,
    this.onSwipeDown,
    this.enablePinchGestures = false,
    this.onPinch,
    this.enableDragGestures = false,
    this.onDrag,
    this.onDragStart,
    this.onDragEnd,
    
    // Accessibility properties
    this.accessibilityLabel,
    this.accessibilityHint,
    this.accessibilityValue,
    this.excludeSemantics = false,
    this.focusOrder,
    this.focusGroup,
    this.accessibilityId,
    
    // Responsive properties
    this.mobileSize,
    this.tabletSize,
    this.desktopSize,
    this.largeDesktopSize,
    this.breakpoint,
  });

  // Standard TextField properties
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool readOnly;
  final bool? showCursor;
  final bool autofocus;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final BoxHeightStyle selectionHeightStyle;
  final BoxWidthStyle selectionWidthStyle;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final DragStartBehavior dragStartBehavior;
  final bool enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final GestureTapCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final MouseCursor? mouseCursor;
  final InputCounterWidgetBuilder? buildCounter;
  final ScrollController? scrollController;
  final ScrollPhysics? scrollPhysics;
  final Iterable<String>? autofillHints;
  final Clip clipBehavior;
  final String? restorationId;
  final bool scribbleEnabled;
  final bool canRequestFocus;
  final SpellCheckConfiguration? spellCheckConfiguration;
  final TextMagnifierConfiguration? magnifierConfiguration;
  
  // Mobile-specific properties
  final MobileTextFieldVariant variant;
  final MobileTextFieldSize size;
  final MobileTextFieldState state;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? prefixText;
  final String? suffixText;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? disabledBorderColor;
  final Color? hoverColor;
  final Color? focusColor;
  final Color? splashColor;
  final Color? disabledColor;
  final BorderRadius? borderRadius;
  final double? elevation;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final double? maxWidth;
  final double? maxHeight;
  final Alignment? alignment;
  
  // Mobile-specific behavior
  final bool touchFeedback;
  final bool hapticFeedback;
  final bool rippleEffect;
  final bool scaleOnPress;
  final bool enableSwipeGestures;
  final VoidCallback? onSwipeLeft;
  final VoidCallback? onSwipeRight;
  final VoidCallback? onSwipeUp;
  final VoidCallback? onSwipeDown;
  final bool enablePinchGestures;
  final ValueChanged<double>? onPinch;
  final bool enableDragGestures;
  final ValueChanged<Offset>? onDrag;
  final VoidCallback? onDragStart;
  final VoidCallback? onDragEnd;
  
  // Accessibility properties
  final String? accessibilityLabel;
  final String? accessibilityHint;
  final String? accessibilityValue;
  final bool excludeSemantics;
  final int? focusOrder;
  final String? focusGroup;
  final String? accessibilityId;
  
  // Responsive properties
  final MobileSize? mobileSize;
  final MobileSize? tabletSize;
  final MobileSize? desktopSize;
  final MobileSize? largeDesktopSize;
  final MobileBreakpoint? breakpoint;

  @override
  State<MobileFirstTextField> createState() => _MobileFirstTextFieldState();
}

class _MobileFirstTextFieldState extends State<MobileFirstTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late FocusNode _focusNode;
  bool _isFocused = false;
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
      end: 0.98,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _focusNode.removeListener(_onFocusChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.state == MobileTextFieldState.enabled) {
      setState(() {
        _isPressed = true;
      });
      
      if (widget.scaleOnPress) {
        _animationController.forward();
      }
      
      if (widget.hapticFeedback) {
        MobileOptimizationService.triggerMobileHapticFeedback(
          MobileHapticType.light,
          breakpoint: widget.breakpoint,
        );
      }
    }
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    
    if (widget.scaleOnPress) {
      _animationController.reverse();
    }
  }

  void _handleTapCancel() {
    setState(() {
      _isPressed = false;
    });
    
    if (widget.scaleOnPress) {
      _animationController.reverse();
    }
  }

  void _handleTap() {
    if (widget.state == MobileTextFieldState.enabled) {
      if (widget.onTap != null) {
        widget.onTap!();
      }
      AccessibilityService.announceChange('Text field activated');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.state == MobileTextFieldState.enabled;
    final isDisabled = widget.state == MobileTextFieldState.disabled;
    final isLoading = widget.state == MobileTextFieldState.loading;
    final isError = widget.state == MobileTextFieldState.error;

    // Get responsive breakpoint
    final responsiveBreakpoint = widget.breakpoint ?? 
        MobileOptimizationService.getMobileBreakpoint(
          MediaQuery.of(context).size.width,
        );

    // Get responsive size
    final responsiveSize = _getResponsiveSize(responsiveBreakpoint);

    // Get accessibility properties
    final accessibilityLabel = _getAccessibilityLabel();
    final accessibilityHint = _getAccessibilityHint();
    final accessibilityValue = _getAccessibilityValue();

    Widget textField = _buildTextField(
      context: context,
      isEnabled: isEnabled,
      isDisabled: isDisabled,
      isLoading: isLoading,
      isError: isError,
      responsiveBreakpoint: responsiveBreakpoint,
      responsiveSize: responsiveSize,
    );

    // Add accessibility semantics
    if (!widget.excludeSemantics) {
      textField = Semantics(
        label: accessibilityLabel,
        hint: accessibilityHint,
        value: accessibilityValue,
        textField: true,
        enabled: isEnabled,
        focused: _isFocused,
        child: textField,
      );
    }

    // Add focus management
    textField = Focus(
      focusNode: _focusNode,
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocused = hasFocus;
        });
        if (hasFocus) {
          AccessibilityService.announceChange(accessibilityLabel);
        }
      },
      child: textField,
    );

    // Add margin
    if (widget.margin != null) {
      textField = Padding(
        padding: widget.margin!,
        child: textField,
      );
    }

    return textField;
  }

  Widget _buildTextField({
    required BuildContext context,
    required bool isEnabled,
    required bool isDisabled,
    required bool isLoading,
    required bool isError,
    required MobileBreakpoint responsiveBreakpoint,
    required MobileSize responsiveSize,
  }) {
    final colors = _getColors(context, responsiveBreakpoint);
    final dimensions = _getDimensions(responsiveBreakpoint, responsiveSize);
    final borderRadius = widget.borderRadius ?? _getBorderRadius(responsiveBreakpoint, responsiveSize);
    final elevation = widget.elevation ?? _getElevation(responsiveBreakpoint, responsiveSize);

    Widget textField = AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: child,
          ),
        );
      },
      child: _buildTextFieldContent(
        context: context,
        colors: colors,
        dimensions: dimensions,
        borderRadius: borderRadius,
        elevation: elevation,
        isEnabled: isEnabled,
        isDisabled: isDisabled,
        isLoading: isLoading,
        isError: isError,
        responsiveBreakpoint: responsiveBreakpoint,
        responsiveSize: responsiveSize,
      ),
    );

    if (isEnabled && !isLoading) {
      // Create gesture detector with all supported gestures
      final gestureDetector = GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: _handleTap,
        child: textField,
      );

      // Add swipe gestures
      if (widget.enableSwipeGestures) {
        textField = TouchOptimizationService.createSwipeDetector(
          child: gestureDetector,
          onSwipeLeft: widget.onSwipeLeft,
          onSwipeRight: widget.onSwipeRight,
          onSwipeUp: widget.onSwipeUp,
          onSwipeDown: widget.onSwipeDown,
        );
      }

      // Add pinch gestures
      if (widget.enablePinchGestures) {
        textField = TouchOptimizationService.createPinchDetector(
          child: textField,
          onPinch: widget.onPinch,
        );
      }

      // Add drag gestures
      if (widget.enableDragGestures) {
        textField = TouchOptimizationService.createDragDetector(
          child: textField,
          onDrag: widget.onDrag,
          onDragStart: widget.onDragStart,
          onDragEnd: widget.onDragEnd,
        );
      }

      // Add ripple effect
      if (widget.rippleEffect) {
        textField = Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _handleTap,
            borderRadius: borderRadius,
            splashColor: colors.splashColor,
            highlightColor: colors.hoverColor,
            child: textField,
          ),
        );
      }

      return textField;
    }

    return textField;
  }

  Widget _buildTextFieldContent({
    required BuildContext context,
    required TextFieldColors colors,
    required TextFieldDimensions dimensions,
    required BorderRadius borderRadius,
    required double elevation,
    required bool isEnabled,
    required bool isDisabled,
    required bool isLoading,
    required bool isError,
    required MobileBreakpoint responsiveBreakpoint,
    required MobileSize responsiveSize,
  }) {
    return Container(
      width: widget.width,
      height: widget.height,
      constraints: BoxConstraints(
        maxWidth: widget.maxWidth ?? dimensions.maxWidth,
        maxHeight: widget.maxHeight ?? dimensions.maxHeight,
      ),
      decoration: BoxDecoration(
        color: isDisabled ? colors.disabledColor : colors.backgroundColor,
        borderRadius: borderRadius,
        border: colors.borderColor != null
            ? Border.all(color: colors.borderColor!, width: 1.0)
            : null,
        boxShadow: elevation > 0 ? PandoraShadows.getShadow('textField') : null,
      ),
      child: Container(
        padding: widget.padding ?? dimensions.padding,
        alignment: widget.alignment ?? Alignment.center,
        child: _buildTextFieldChild(
          context: context,
          colors: colors,
          dimensions: dimensions,
          isLoading: isLoading,
          isError: isError,
          responsiveBreakpoint: responsiveBreakpoint,
          responsiveSize: responsiveSize,
        ),
      ),
    );
  }

  Widget _buildTextFieldChild({
    required BuildContext context,
    required TextFieldColors colors,
    required TextFieldDimensions dimensions,
    required bool isLoading,
    required bool isError,
    required MobileBreakpoint responsiveBreakpoint,
    required MobileSize responsiveSize,
  }) {
    if (isLoading) {
      return SizedBox(
        width: dimensions.iconSize,
        height: dimensions.iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation<Color>(colors.foregroundColor),
        ),
      );
    }

    if (isError) {
      return Icon(
        Icons.error,
        size: dimensions.iconSize,
        color: colors.foregroundColor,
      );
    }

    return TextField(
      controller: widget.controller,
      focusNode: _focusNode,
      decoration: _buildInputDecoration(colors, dimensions),
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      textDirection: widget.textDirection,
      readOnly: widget.readOnly,
      showCursor: widget.showCursor,
      autofocus: widget.autofocus,
      obscuringCharacter: widget.obscuringCharacter,
      obscureText: widget.obscureText,
      autocorrect: widget.autocorrect,
      smartDashesType: widget.smartDashesType,
      smartQuotesType: widget.smartQuotesType,
      enableSuggestions: widget.enableSuggestions,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      maxLengthEnforcement: widget.maxLengthEnforcement,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onSubmitted: widget.onSubmitted,
      onAppPrivateCommand: widget.onAppPrivateCommand,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      cursorWidth: widget.cursorWidth,
      cursorHeight: widget.cursorHeight,
      cursorRadius: widget.cursorRadius,
      cursorColor: widget.cursorColor,
      selectionHeightStyle: widget.selectionHeightStyle,
      selectionWidthStyle: widget.selectionWidthStyle,
      keyboardAppearance: widget.keyboardAppearance,
      scrollPadding: widget.scrollPadding,
      dragStartBehavior: widget.dragStartBehavior,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      selectionControls: widget.selectionControls,
      onTap: widget.onTap,
      onTapOutside: widget.onTapOutside,
      mouseCursor: widget.mouseCursor,
      buildCounter: widget.buildCounter,
      scrollController: widget.scrollController,
      scrollPhysics: widget.scrollPhysics,
      autofillHints: widget.autofillHints,
      clipBehavior: widget.clipBehavior,
      restorationId: widget.restorationId,
      scribbleEnabled: widget.scribbleEnabled,
      canRequestFocus: widget.canRequestFocus,
      spellCheckConfiguration: widget.spellCheckConfiguration,
      magnifierConfiguration: widget.magnifierConfiguration,
    );
  }

  InputDecoration _buildInputDecoration(TextFieldColors colors, TextFieldDimensions dimensions) {
    return InputDecoration(
      labelText: widget.label,
      hintText: widget.hint,
      helperText: widget.helperText,
      errorText: widget.errorText,
      prefixIcon: widget.prefixIcon,
      suffixIcon: widget.suffixIcon,
      prefixText: widget.prefixText,
      suffixText: widget.suffixText,
      prefix: widget.prefixWidget,
      suffix: widget.suffixWidget,
      filled: true,
      fillColor: colors.backgroundColor,
      labelStyle: dimensions.labelStyle.copyWith(color: colors.foregroundColor),
      hintStyle: dimensions.hintStyle.copyWith(color: colors.foregroundColor),
      helperStyle: dimensions.helperStyle.copyWith(color: colors.foregroundColor),
      errorStyle: dimensions.errorStyle.copyWith(color: colors.errorColor),
      prefixStyle: dimensions.prefixStyle.copyWith(color: colors.foregroundColor),
      suffixStyle: dimensions.suffixStyle.copyWith(color: colors.foregroundColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colors.borderColor ?? Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colors.borderColor ?? Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colors.focusedBorderColor ?? colors.borderColor ?? Colors.blue),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colors.errorBorderColor ?? Colors.red),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colors.disabledBorderColor ?? Colors.grey),
      ),
      contentPadding: dimensions.contentPadding,
    );
  }

  String _getAccessibilityLabel() {
    if (widget.accessibilityLabel != null) {
      return widget.accessibilityLabel!;
    }
    
    return AccessibilityService.getSemanticLabel('textField', {
      'label': widget.label ?? '',
      'state': widget.state.name,
    });
  }

  String _getAccessibilityHint() {
    if (widget.accessibilityHint != null) {
      return widget.accessibilityHint!;
    }
    
    String hint = AccessibilityService.getAccessibilityHint('textField', {
      'isEnabled': widget.state == MobileTextFieldState.enabled,
    });
    
    if (widget.hint != null) {
      hint += ', ${widget.hint}';
    }
    
    return hint;
  }

  String _getAccessibilityValue() {
    if (widget.accessibilityValue != null) {
      return widget.accessibilityValue!;
    }
    
    return AccessibilityService.getAccessibilityValue('textField', {
      'state': widget.state.name,
    });
  }

  MobileSize _getResponsiveSize(MobileBreakpoint breakpoint) {
    switch (breakpoint) {
      case MobileBreakpoint.mobile:
        return widget.mobileSize ?? MobileSize.regular;
      case MobileBreakpoint.tablet:
        return widget.tabletSize ?? MobileSize.comfortable;
      case MobileBreakpoint.desktop:
        return widget.desktopSize ?? MobileSize.spacious;
      case MobileBreakpoint.largeDesktop:
        return widget.largeDesktopSize ?? MobileSize.spacious;
    }
  }

  TextFieldColors _getColors(BuildContext context, MobileBreakpoint breakpoint) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Get base colors
    Color baseBackgroundColor;
    Color baseForegroundColor;
    
    switch (widget.variant) {
      case MobileTextFieldVariant.outlined:
        baseBackgroundColor = widget.backgroundColor ?? 
            (isDark ? PandoraColors.neutral800 : PandoraColors.white);
        baseForegroundColor = widget.foregroundColor ?? 
            (isDark ? PandoraColors.neutral100 : PandoraColors.neutral900);
        break;
      case MobileTextFieldVariant.filled:
        baseBackgroundColor = widget.backgroundColor ?? 
            (isDark ? PandoraColors.neutral700 : PandoraColors.neutral100);
        baseForegroundColor = widget.foregroundColor ?? 
            (isDark ? PandoraColors.neutral100 : PandoraColors.neutral900);
        break;
      case MobileTextFieldVariant.primary:
        baseBackgroundColor = widget.backgroundColor ?? 
            (isDark ? PandoraColors.primary400 : PandoraColors.primary500);
        baseForegroundColor = widget.foregroundColor ?? PandoraColors.white;
        break;
      case MobileTextFieldVariant.secondary:
        baseBackgroundColor = widget.backgroundColor ?? 
            (isDark ? PandoraColors.secondary400 : PandoraColors.secondary500);
        baseForegroundColor = widget.foregroundColor ?? PandoraColors.white;
        break;
    }

    return TextFieldColors(
      backgroundColor: baseBackgroundColor,
      foregroundColor: baseForegroundColor,
      borderColor: widget.borderColor,
      focusedBorderColor: widget.focusedBorderColor,
      errorBorderColor: widget.errorBorderColor,
      disabledBorderColor: widget.disabledBorderColor,
      hoverColor: widget.hoverColor,
      focusColor: widget.focusColor,
      splashColor: widget.splashColor,
      disabledColor: widget.disabledColor ?? 
          (isDark ? PandoraColors.neutral600 : PandoraColors.neutral300),
      errorColor: widget.errorText != null ? Colors.red : null,
    );
  }

  TextFieldDimensions _getDimensions(MobileBreakpoint breakpoint, MobileSize size) {
    final baseSize = _getBaseSize();
    final multiplier = _getSizeMultiplier(breakpoint, size);
    
    return TextFieldDimensions(
      padding: EdgeInsets.symmetric(
        horizontal: baseSize.padding.horizontal * multiplier,
        vertical: baseSize.padding.vertical * multiplier,
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: baseSize.contentPadding.horizontal * multiplier,
        vertical: baseSize.contentPadding.vertical * multiplier,
      ),
      maxWidth: baseSize.maxWidth,
      maxHeight: baseSize.maxHeight * multiplier,
      iconSize: baseSize.iconSize * multiplier,
      labelStyle: baseSize.labelStyle.copyWith(
        fontSize: baseSize.labelStyle.fontSize! * multiplier,
      ),
      hintStyle: baseSize.hintStyle.copyWith(
        fontSize: baseSize.hintStyle.fontSize! * multiplier,
      ),
      helperStyle: baseSize.helperStyle.copyWith(
        fontSize: baseSize.helperStyle.fontSize! * multiplier,
      ),
      errorStyle: baseSize.errorStyle.copyWith(
        fontSize: baseSize.errorStyle.fontSize! * multiplier,
      ),
      prefixStyle: baseSize.prefixStyle.copyWith(
        fontSize: baseSize.prefixStyle.fontSize! * multiplier,
      ),
      suffixStyle: baseSize.suffixStyle.copyWith(
        fontSize: baseSize.suffixStyle.fontSize! * multiplier,
      ),
    );
  }

  _BaseTextFieldSize _getBaseSize() {
    switch (widget.size) {
      case MobileTextFieldSize.small:
        return _BaseTextFieldSize(
          padding: const EdgeInsets.all(8),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          maxWidth: double.infinity,
          maxHeight: 40.0,
          iconSize: 16.0,
          labelStyle: PandoraTypography.labelSmall,
          hintStyle: PandoraTypography.bodySmall,
          helperStyle: PandoraTypography.bodySmall,
          errorStyle: PandoraTypography.bodySmall,
          prefixStyle: PandoraTypography.bodySmall,
          suffixStyle: PandoraTypography.bodySmall,
        );
      case MobileTextFieldSize.medium:
        return _BaseTextFieldSize(
          padding: const EdgeInsets.all(12),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          maxWidth: double.infinity,
          maxHeight: 48.0,
          iconSize: 20.0,
          labelStyle: PandoraTypography.labelMedium,
          hintStyle: PandoraTypography.bodyMedium,
          helperStyle: PandoraTypography.bodyMedium,
          errorStyle: PandoraTypography.bodyMedium,
          prefixStyle: PandoraTypography.bodyMedium,
          suffixStyle: PandoraTypography.bodyMedium,
        );
      case MobileTextFieldSize.large:
        return _BaseTextFieldSize(
          padding: const EdgeInsets.all(16),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          maxWidth: double.infinity,
          maxHeight: 56.0,
          iconSize: 24.0,
          labelStyle: PandoraTypography.labelLarge,
          hintStyle: PandoraTypography.bodyLarge,
          helperStyle: PandoraTypography.bodyLarge,
          errorStyle: PandoraTypography.bodyLarge,
          prefixStyle: PandoraTypography.bodyLarge,
          suffixStyle: PandoraTypography.bodyLarge,
        );
      case MobileTextFieldSize.extraLarge:
        return _BaseTextFieldSize(
          padding: const EdgeInsets.all(20),
          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          maxWidth: double.infinity,
          maxHeight: 64.0,
          iconSize: 28.0,
          labelStyle: PandoraTypography.titleSmall,
          hintStyle: PandoraTypography.headlineSmall,
          helperStyle: PandoraTypography.headlineSmall,
          errorStyle: PandoraTypography.headlineSmall,
          prefixStyle: PandoraTypography.headlineSmall,
          suffixStyle: PandoraTypography.headlineSmall,
        );
    }
  }

  double _getSizeMultiplier(MobileBreakpoint breakpoint, MobileSize size) {
    final sizeMultiplier = _getSizeMultiplierForSize(size);
    final breakpointMultiplier = _getBreakpointMultiplier(breakpoint);
    return sizeMultiplier * breakpointMultiplier;
  }

  double _getSizeMultiplierForSize(MobileSize size) {
    switch (size) {
      case MobileSize.compact:
        return 0.8;
      case MobileSize.regular:
        return 1.0;
      case MobileSize.comfortable:
        return 1.2;
      case MobileSize.spacious:
        return 1.4;
    }
  }

  double _getBreakpointMultiplier(MobileBreakpoint breakpoint) {
    switch (breakpoint) {
      case MobileBreakpoint.mobile:
        return 1.0; // Mobile is the base
      case MobileBreakpoint.tablet:
        return 1.1;
      case MobileBreakpoint.desktop:
        return 1.2;
      case MobileBreakpoint.largeDesktop:
        return 1.3;
    }
  }

  BorderRadius _getBorderRadius(MobileBreakpoint breakpoint, MobileSize size) {
    final baseRadius = _getBaseBorderRadius();
    return BorderRadius.circular(
      MobileOptimizationService.getMobileBorderRadius(
        baseRadius,
        breakpoint,
        size: size,
      ),
    );
  }

  double _getBaseBorderRadius() {
    switch (widget.size) {
      case MobileTextFieldSize.small:
        return 6.0;
      case MobileTextFieldSize.medium:
        return 8.0;
      case MobileTextFieldSize.large:
        return 12.0;
      case MobileTextFieldSize.extraLarge:
        return 16.0;
    }
  }

  double _getElevation(MobileBreakpoint breakpoint, MobileSize size) {
    final baseElevation = _getBaseElevation();
    return MobileOptimizationService.getMobileElevation(
      baseElevation,
      breakpoint,
      size: size,
    );
  }

  double _getBaseElevation() {
    switch (widget.variant) {
      case MobileTextFieldVariant.outlined:
        return 0.0;
      case MobileTextFieldVariant.filled:
        return 1.0;
      case MobileTextFieldVariant.primary:
      case MobileTextFieldVariant.secondary:
        return 2.0;
    }
  }
}

// Enums
enum MobileTextFieldVariant {
  outlined,
  filled,
  primary,
  secondary,
}

enum MobileTextFieldSize {
  small,
  medium,
  large,
  extraLarge,
}

enum MobileTextFieldState {
  enabled,
  disabled,
  loading,
  error,
}

// Helper classes
class _BaseTextFieldSize {
  final EdgeInsets padding;
  final EdgeInsets contentPadding;
  final double maxWidth;
  final double maxHeight;
  final double iconSize;
  final TextStyle labelStyle;
  final TextStyle hintStyle;
  final TextStyle helperStyle;
  final TextStyle errorStyle;
  final TextStyle prefixStyle;
  final TextStyle suffixStyle;

  const _BaseTextFieldSize({
    required this.padding,
    required this.contentPadding,
    required this.maxWidth,
    required this.maxHeight,
    required this.iconSize,
    required this.labelStyle,
    required this.hintStyle,
    required this.helperStyle,
    required this.errorStyle,
    required this.prefixStyle,
    required this.suffixStyle,
  });
}

class TextFieldColors {
  const TextFieldColors({
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.disabledBorderColor,
    this.hoverColor,
    this.focusColor,
    this.splashColor,
    this.disabledColor,
    this.errorColor,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? disabledBorderColor;
  final Color? hoverColor;
  final Color? focusColor;
  final Color? splashColor;
  final Color? disabledColor;
  final Color? errorColor;
}

class TextFieldDimensions {
  const TextFieldDimensions({
    required this.padding,
    required this.contentPadding,
    required this.maxWidth,
    required this.maxHeight,
    required this.iconSize,
    required this.labelStyle,
    required this.hintStyle,
    required this.helperStyle,
    required this.errorStyle,
    required this.prefixStyle,
    required this.suffixStyle,
  });

  final EdgeInsets padding;
  final EdgeInsets contentPadding;
  final double maxWidth;
  final double maxHeight;
  final double iconSize;
  final TextStyle labelStyle;
  final TextStyle hintStyle;
  final TextStyle helperStyle;
  final TextStyle errorStyle;
  final TextStyle prefixStyle;
  final TextStyle suffixStyle;
}
