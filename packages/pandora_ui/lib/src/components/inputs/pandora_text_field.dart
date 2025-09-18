import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../tokens/color_tokens.dart';
import '../../tokens/typography_tokens.dart';
import '../../tokens/border_tokens.dart';
import '../../tokens/shadow_tokens.dart';

/// Pandora 4 Text Field
/// 
/// A comprehensive text input component that embodies the "Thân Tâm Hợp Nhất" philosophy.
/// This text field adapts to different input types while maintaining visual consistency.
enum PandoraTextFieldVariant {
  outlined,
  filled,
  underlined,
}

enum PandoraTextFieldSize {
  xs,
  sm,
  md,
  lg,
  xl,
}

enum PandoraTextFieldState {
  enabled,
  disabled,
  error,
  success,
  focused,
}

class PandoraTextField extends StatefulWidget {
  const PandoraTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.decoration,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.readOnly = false,
    this.toolbarOptions,
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
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection,
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
    this.variant = PandoraTextFieldVariant.outlined,
    this.size = PandoraTextFieldSize.md,
    this.state = PandoraTextFieldState.enabled,
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
    this.borderRadius,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.disabledBorderColor,
    this.fillColor,
    this.focusedFillColor,
    this.errorFillColor,
    this.disabledFillColor,
    this.labelColor,
    this.focusedLabelColor,
    this.errorLabelColor,
    this.disabledLabelColor,
    this.hintColor,
    this.focusedHintColor,
    this.errorHintColor,
    this.disabledHintColor,
    this.helperColor,
    this.focusedHelperColor,
    this.errorHelperColor,
    this.disabledHelperColor,
    this.selectionColor,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.minWidth,
    this.minHeight,
    this.maxWidth,
    this.maxHeight,
    this.alignment,
    this.semanticLabel,
    this.tooltip,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool readOnly;
  final ToolbarOptions? toolbarOptions;
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
  final bool expands;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool? enableInteractiveSelection;
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
  final PandoraTextFieldVariant variant;
  final PandoraTextFieldSize size;
  final PandoraTextFieldState state;
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
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? disabledBorderColor;
  final Color? fillColor;
  final Color? focusedFillColor;
  final Color? errorFillColor;
  final Color? disabledFillColor;
  final Color? labelColor;
  final Color? focusedLabelColor;
  final Color? errorLabelColor;
  final Color? disabledLabelColor;
  final Color? hintColor;
  final Color? focusedHintColor;
  final Color? errorHintColor;
  final Color? disabledHintColor;
  final Color? helperColor;
  final Color? focusedHelperColor;
  final Color? errorHelperColor;
  final Color? disabledHelperColor;
  final Color? selectionColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final double? minWidth;
  final double? minHeight;
  final double? maxWidth;
  final double? maxHeight;
  final Alignment? alignment;
  final String? semanticLabel;
  final String? tooltip;

  @override
  State<PandoraTextField> createState() => _PandoraTextFieldState._();
}

class _PandoraTextFieldState extends State<PandoraTextField>
    with SingleTickerProviderStateMixin {
  _PandoraTextFieldState._();
  
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _elevationAnimation = Tween<double>(
      begin: 0.0,
      end: 4.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    _animationController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
    if (_isFocused) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = _getColors(context);
    final dimensions = _getDimensions();
    final borderRadius = widget.borderRadius ?? _getBorderRadius();
    final isEnabled = widget.enabled ?? true;
    final isDisabled = !isEnabled;
    final isError = widget.state == PandoraTextFieldState.error;
    final isSuccess = widget.state == PandoraTextFieldState.success;

    Widget textField = _buildTextField(
      context: context,
      colors: colors,
      dimensions: dimensions,
      borderRadius: borderRadius,
      isEnabled: isEnabled,
      isDisabled: isDisabled,
      isError: isError,
      isSuccess: isSuccess,
    );

    if (widget.tooltip != null && isEnabled) {
      textField = Tooltip(
        message: widget.tooltip!,
        child: textField,
      );
    }

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
    required TextFieldColors colors,
    required TextFieldDimensions dimensions,
    required BorderRadius borderRadius,
    required bool isEnabled,
    required bool isDisabled,
    required bool isError,
    required bool isSuccess,
  }) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: widget.width,
            height: widget.height,
            constraints: BoxConstraints(
              minWidth: widget.minWidth ?? dimensions.minWidth ?? 0.0,
              minHeight: widget.minHeight ?? dimensions.minHeight ?? 0.0,
              maxWidth: widget.maxWidth ?? dimensions.maxWidth ?? double.infinity,
              maxHeight: widget.maxHeight ?? dimensions.maxHeight ?? double.infinity,
            ),
            decoration: BoxDecoration(
              color: colors.fillColor,
              borderRadius: borderRadius,
              border: colors.borderColor != null
                  ? Border.all(
                      color: colors.borderColor!,
                      width: 1.0,
                    )
                  : null,
              boxShadow: _isFocused && elevation > 0
                  ? PandoraShadows.getShadow('inputFocus').map((shadow) {
                      return shadow.copyWith(
                        blurRadius: shadow.blurRadius + _elevationAnimation.value,
                        offset: Offset(
                          shadow.offset.dx,
                          shadow.offset.dy + _elevationAnimation.value,
                        ),
                      );
                    }).toList()
                  : null,
            ),
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              decoration: _buildInputDecoration(
                colors: colors,
                dimensions: dimensions,
                borderRadius: borderRadius,
                isEnabled: isEnabled,
                isDisabled: isDisabled,
                isError: isError,
                isSuccess: isSuccess,
              ),
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              textCapitalization: widget.textCapitalization,
              style: widget.style ?? dimensions.textStyle,
              strutStyle: widget.strutStyle,
              textAlign: widget.textAlign,
              textAlignVertical: widget.textAlignVertical,
              textDirection: widget.textDirection,
              readOnly: widget.readOnly,
              toolbarOptions: widget.toolbarOptions,
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
              expands: widget.expands,
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
              cursorColor: widget.cursorColor ?? colors.cursorColor,
              keyboardAppearance: widget.keyboardAppearance,
              scrollPadding: widget.scrollPadding,
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
            ),
          ),
        );
      },
    );
  }

  InputDecoration _buildInputDecoration({
    required TextFieldColors colors,
    required TextFieldDimensions dimensions,
    required BorderRadius borderRadius,
    required bool isEnabled,
    required bool isDisabled,
    required bool isError,
    required bool isSuccess,
  }) {
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
      fillColor: colors.fillColor,
      border: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: colors.borderColor ?? Colors.transparent),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: colors.borderColor ?? Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: colors.focusedBorderColor ?? colors.borderColor ?? Colors.transparent,
          width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: colors.errorBorderColor ?? PandoraColors.error500),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: colors.errorBorderColor ?? PandoraColors.error500,
          width: 2.0,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: colors.disabledBorderColor ?? Colors.transparent),
      ),
      contentPadding: widget.padding ?? dimensions.padding,
      labelStyle: dimensions.labelStyle?.copyWith(color: colors.labelColor),
      hintStyle: dimensions.hintStyle?.copyWith(color: colors.hintColor),
      helperStyle: dimensions.helperStyle?.copyWith(color: colors.helperColor),
      errorStyle: dimensions.errorStyle?.copyWith(color: colors.errorColor),
      counterStyle: dimensions.counterStyle?.copyWith(color: colors.counterColor),
      prefixStyle: dimensions.prefixStyle?.copyWith(color: colors.prefixColor),
      suffixStyle: dimensions.suffixStyle?.copyWith(color: colors.suffixColor),
    );
  }

  TextFieldColors _getColors(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    switch (widget.variant) {
      case PandoraTextFieldVariant.outlined:
        return TextFieldColors(
          fillColor: widget.fillColor ?? 
              (isDark ? PandoraColors.neutral800 : PandoraColors.surfaceVariant),
          borderColor: widget.borderColor ?? 
              (isDark ? PandoraColors.neutral600 : PandoraColors.outline),
          focusedBorderColor: widget.focusedBorderColor ?? 
              (isDark ? PandoraColors.primary400 : PandoraColors.primary500),
          errorBorderColor: widget.errorBorderColor ?? 
              (isDark ? PandoraColors.error400 : PandoraColors.error500),
          disabledBorderColor: widget.disabledBorderColor ?? 
              (isDark ? PandoraColors.neutral600 : PandoraColors.neutral300),
          counterColor: isDark ? PandoraColors.neutral400 : PandoraColors.neutral600,
          prefixColor: isDark ? PandoraColors.neutral400 : PandoraColors.neutral600,
          suffixColor: isDark ? PandoraColors.neutral400 : PandoraColors.neutral600,
          labelColor: widget.labelColor ?? 
              (isDark ? PandoraColors.neutral300 : PandoraColors.neutral700),
          focusedLabelColor: widget.focusedLabelColor ?? 
              (isDark ? PandoraColors.primary400 : PandoraColors.primary500),
          errorLabelColor: widget.errorLabelColor ?? 
              (isDark ? PandoraColors.error400 : PandoraColors.error500),
          disabledLabelColor: widget.disabledLabelColor ?? 
              (isDark ? PandoraColors.neutral500 : PandoraColors.neutral400),
          hintColor: widget.hintColor ?? 
              (isDark ? PandoraColors.neutral400 : PandoraColors.neutral500),
          focusedHintColor: widget.focusedHintColor ?? 
              (isDark ? PandoraColors.neutral300 : PandoraColors.neutral600),
          errorHintColor: widget.errorHintColor ?? 
              (isDark ? PandoraColors.error400 : PandoraColors.error500),
          disabledHintColor: widget.disabledHintColor ?? 
              (isDark ? PandoraColors.neutral500 : PandoraColors.neutral400),
          helperColor: widget.helperColor ?? 
              (isDark ? PandoraColors.neutral400 : PandoraColors.neutral600),
          focusedHelperColor: widget.focusedHelperColor ?? 
              (isDark ? PandoraColors.neutral300 : PandoraColors.neutral700),
          errorHelperColor: widget.errorHelperColor ?? 
              (isDark ? PandoraColors.error400 : PandoraColors.error500),
          disabledHelperColor: widget.disabledHelperColor ?? 
              (isDark ? PandoraColors.neutral500 : PandoraColors.neutral400),
          cursorColor: widget.cursorColor ?? 
              (isDark ? PandoraColors.primary400 : PandoraColors.primary500),
          selectionColor: widget.selectionColor ?? 
              (isDark ? PandoraColors.primary400.withValues(alpha: 0.3) : PandoraColors.primary500.withValues(alpha: 0.3)),
          errorColor: widget.errorText != null ? 
              (isDark ? PandoraColors.error400 : PandoraColors.error500) : null,
        );
      case PandoraTextFieldVariant.filled:
        return TextFieldColors(
          fillColor: widget.fillColor ?? 
              (isDark ? PandoraColors.neutral700 : PandoraColors.surfaceContainer),
          borderColor: widget.borderColor ?? Colors.transparent,
          focusedBorderColor: widget.focusedBorderColor ?? 
              (isDark ? PandoraColors.primary400 : PandoraColors.primary500),
          errorBorderColor: widget.errorBorderColor ?? 
              (isDark ? PandoraColors.error400 : PandoraColors.error500),
          disabledBorderColor: widget.disabledBorderColor ?? Colors.transparent,
          counterColor: isDark ? PandoraColors.neutral400 : PandoraColors.neutral600,
          prefixColor: isDark ? PandoraColors.neutral400 : PandoraColors.neutral600,
          suffixColor: isDark ? PandoraColors.neutral400 : PandoraColors.neutral600,
          labelColor: widget.labelColor ?? 
              (isDark ? PandoraColors.neutral300 : PandoraColors.neutral700),
          focusedLabelColor: widget.focusedLabelColor ?? 
              (isDark ? PandoraColors.primary400 : PandoraColors.primary500),
          errorLabelColor: widget.errorLabelColor ?? 
              (isDark ? PandoraColors.error400 : PandoraColors.error500),
          disabledLabelColor: widget.disabledLabelColor ?? 
              (isDark ? PandoraColors.neutral500 : PandoraColors.neutral400),
          hintColor: widget.hintColor ?? 
              (isDark ? PandoraColors.neutral400 : PandoraColors.neutral500),
          focusedHintColor: widget.focusedHintColor ?? 
              (isDark ? PandoraColors.neutral300 : PandoraColors.neutral600),
          errorHintColor: widget.errorHintColor ?? 
              (isDark ? PandoraColors.error400 : PandoraColors.error500),
          disabledHintColor: widget.disabledHintColor ?? 
              (isDark ? PandoraColors.neutral500 : PandoraColors.neutral400),
          helperColor: widget.helperColor ?? 
              (isDark ? PandoraColors.neutral400 : PandoraColors.neutral600),
          focusedHelperColor: widget.focusedHelperColor ?? 
              (isDark ? PandoraColors.neutral300 : PandoraColors.neutral700),
          errorHelperColor: widget.errorHelperColor ?? 
              (isDark ? PandoraColors.error400 : PandoraColors.error500),
          disabledHelperColor: widget.disabledHelperColor ?? 
              (isDark ? PandoraColors.neutral500 : PandoraColors.neutral400),
          cursorColor: widget.cursorColor ?? 
              (isDark ? PandoraColors.primary400 : PandoraColors.primary500),
          selectionColor: widget.selectionColor ?? 
              (isDark ? PandoraColors.primary400.withValues(alpha: 0.3) : PandoraColors.primary500.withValues(alpha: 0.3)),
          errorColor: widget.errorText != null ? 
              (isDark ? PandoraColors.error400 : PandoraColors.error500) : null,
        );
      case PandoraTextFieldVariant.underlined:
        return TextFieldColors(
          fillColor: widget.fillColor ?? Colors.transparent,
          borderColor: widget.borderColor ?? 
              (isDark ? PandoraColors.neutral600 : PandoraColors.neutral300),
          focusedBorderColor: widget.focusedBorderColor ?? 
              (isDark ? PandoraColors.primary400 : PandoraColors.primary500),
          errorBorderColor: widget.errorBorderColor ?? 
              (isDark ? PandoraColors.error400 : PandoraColors.error500),
          disabledBorderColor: widget.disabledBorderColor ?? 
              (isDark ? PandoraColors.neutral600 : PandoraColors.neutral300),
          counterColor: isDark ? PandoraColors.neutral400 : PandoraColors.neutral600,
          prefixColor: isDark ? PandoraColors.neutral400 : PandoraColors.neutral600,
          suffixColor: isDark ? PandoraColors.neutral400 : PandoraColors.neutral600,
          labelColor: widget.labelColor ?? 
              (isDark ? PandoraColors.neutral300 : PandoraColors.neutral700),
          focusedLabelColor: widget.focusedLabelColor ?? 
              (isDark ? PandoraColors.primary400 : PandoraColors.primary500),
          errorLabelColor: widget.errorLabelColor ?? 
              (isDark ? PandoraColors.error400 : PandoraColors.error500),
          disabledLabelColor: widget.disabledLabelColor ?? 
              (isDark ? PandoraColors.neutral500 : PandoraColors.neutral400),
          hintColor: widget.hintColor ?? 
              (isDark ? PandoraColors.neutral400 : PandoraColors.neutral500),
          focusedHintColor: widget.focusedHintColor ?? 
              (isDark ? PandoraColors.neutral300 : PandoraColors.neutral600),
          errorHintColor: widget.errorHintColor ?? 
              (isDark ? PandoraColors.error400 : PandoraColors.error500),
          disabledHintColor: widget.disabledHintColor ?? 
              (isDark ? PandoraColors.neutral500 : PandoraColors.neutral400),
          helperColor: widget.helperColor ?? 
              (isDark ? PandoraColors.neutral400 : PandoraColors.neutral600),
          focusedHelperColor: widget.focusedHelperColor ?? 
              (isDark ? PandoraColors.neutral300 : PandoraColors.neutral700),
          errorHelperColor: widget.errorHelperColor ?? 
              (isDark ? PandoraColors.error400 : PandoraColors.error500),
          disabledHelperColor: widget.disabledHelperColor ?? 
              (isDark ? PandoraColors.neutral500 : PandoraColors.neutral400),
          cursorColor: widget.cursorColor ?? 
              (isDark ? PandoraColors.primary400 : PandoraColors.primary500),
          selectionColor: widget.selectionColor ?? 
              (isDark ? PandoraColors.primary400.withValues(alpha: 0.3) : PandoraColors.primary500.withValues(alpha: 0.3)),
          errorColor: widget.errorText != null ? 
              (isDark ? PandoraColors.error400 : PandoraColors.error500) : null,
        );
    }
  }

  TextFieldDimensions _getDimensions() {
    switch (widget.size) {
      case PandoraTextFieldSize.xs:
        return TextFieldDimensions(
          height: 32.0,
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          borderRadius: PandoraBorders.borderRadiusSm,
          minWidth: widget.minWidth,
          minHeight: widget.minHeight,
          maxWidth: widget.maxWidth,
          maxHeight: widget.maxHeight,
          textStyle: PandoraTypography.bodySmall,
          labelStyle: PandoraTypography.bodySmall,
          hintStyle: PandoraTypography.bodySmall,
          helperStyle: PandoraTypography.caption,
          errorStyle: PandoraTypography.caption,
          counterStyle: PandoraTypography.caption,
          prefixStyle: PandoraTypography.bodySmall,
          suffixStyle: PandoraTypography.bodySmall,
        );
      case PandoraTextFieldSize.sm:
        return TextFieldDimensions(
          height: 36.0,
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          borderRadius: PandoraBorders.borderRadiusSm,
          minWidth: widget.minWidth,
          minHeight: widget.minHeight,
          maxWidth: widget.maxWidth,
          maxHeight: widget.maxHeight,
          textStyle: PandoraTypography.bodyMedium,
          labelStyle: PandoraTypography.bodyMedium,
          hintStyle: PandoraTypography.bodyMedium,
          helperStyle: PandoraTypography.caption,
          errorStyle: PandoraTypography.caption,
          counterStyle: PandoraTypography.caption,
          prefixStyle: PandoraTypography.bodyMedium,
          suffixStyle: PandoraTypography.bodyMedium,
        );
      case PandoraTextFieldSize.md:
        return TextFieldDimensions(
          height: 40.0,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          borderRadius: PandoraBorders.borderRadiusMd,
          minWidth: widget.minWidth,
          minHeight: widget.minHeight,
          maxWidth: widget.maxWidth,
          maxHeight: widget.maxHeight,
          textStyle: PandoraTypography.bodyLarge,
          labelStyle: PandoraTypography.bodyLarge,
          hintStyle: PandoraTypography.bodyLarge,
          helperStyle: PandoraTypography.caption,
          errorStyle: PandoraTypography.caption,
          counterStyle: PandoraTypography.caption,
          prefixStyle: PandoraTypography.bodyLarge,
          suffixStyle: PandoraTypography.bodyLarge,
        );
      case PandoraTextFieldSize.lg:
        return TextFieldDimensions(
          height: 44.0,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          borderRadius: PandoraBorders.borderRadiusLg,
          minWidth: widget.minWidth,
          minHeight: widget.minHeight,
          maxWidth: widget.maxWidth,
          maxHeight: widget.maxHeight,
          textStyle: PandoraTypography.titleSmall,
          labelStyle: PandoraTypography.titleSmall,
          hintStyle: PandoraTypography.titleSmall,
          helperStyle: PandoraTypography.bodySmall,
          errorStyle: PandoraTypography.bodySmall,
          counterStyle: PandoraTypography.bodySmall,
          prefixStyle: PandoraTypography.titleSmall,
          suffixStyle: PandoraTypography.titleSmall,
        );
      case PandoraTextFieldSize.xl:
        return TextFieldDimensions(
          height: 48.0,
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          borderRadius: PandoraBorders.borderRadiusLg,
          minWidth: widget.minWidth,
          minHeight: widget.minHeight,
          maxWidth: widget.maxWidth,
          maxHeight: widget.maxHeight,
          textStyle: PandoraTypography.titleMedium,
          labelStyle: PandoraTypography.titleMedium,
          hintStyle: PandoraTypography.titleMedium,
          helperStyle: PandoraTypography.bodyMedium,
          errorStyle: PandoraTypography.bodyMedium,
          counterStyle: PandoraTypography.bodyMedium,
          prefixStyle: PandoraTypography.titleMedium,
          suffixStyle: PandoraTypography.titleMedium,
        );
    }
  }

  BorderRadius _getBorderRadius() {
    switch (widget.size) {
      case PandoraTextFieldSize.xs:
        return PandoraBorders.borderRadiusSm;
      case PandoraTextFieldSize.sm:
        return PandoraBorders.borderRadiusSm;
      case PandoraTextFieldSize.md:
        return PandoraBorders.borderRadiusMd;
      case PandoraTextFieldSize.lg:
        return PandoraBorders.borderRadiusLg;
      case PandoraTextFieldSize.xl:
        return PandoraBorders.borderRadiusLg;
    }
  }

  double get elevation {
    switch (widget.variant) {
      case PandoraTextFieldVariant.outlined:
        return 0.0;
      case PandoraTextFieldVariant.filled:
        return 0.0;
      case PandoraTextFieldVariant.underlined:
        return 0.0;
    }
  }
}

class TextFieldDimensions {
  const TextFieldDimensions({
    required this.height,
    required this.padding,
    required this.borderRadius,
    this.minWidth,
    this.minHeight,
    this.maxWidth,
    this.maxHeight,
    this.textStyle,
    this.labelStyle,
    this.hintStyle,
    this.helperStyle,
    this.errorStyle,
    this.counterStyle,
    this.prefixStyle,
    this.suffixStyle,
  });

  final double height;
  final EdgeInsets padding;
  final BorderRadius borderRadius;
  final double? minWidth;
  final double? minHeight;
  final double? maxWidth;
  final double? maxHeight;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? helperStyle;
  final TextStyle? errorStyle;
  final TextStyle? counterStyle;
  final TextStyle? prefixStyle;
  final TextStyle? suffixStyle;
}

class TextFieldColors {
  const TextFieldColors({
    required this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.disabledBorderColor,
    required this.labelColor,
    this.focusedLabelColor,
    this.errorLabelColor,
    this.disabledLabelColor,
    required this.hintColor,
    this.focusedHintColor,
    this.errorHintColor,
    this.disabledHintColor,
    required this.helperColor,
    this.focusedHelperColor,
    this.errorHelperColor,
    this.disabledHelperColor,
    required this.cursorColor,
    this.selectionColor,
    this.errorColor,
    required this.counterColor,
    required this.prefixColor,
    required this.suffixColor,
  });

  final Color fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? disabledBorderColor;
  final Color labelColor;
  final Color? focusedLabelColor;
  final Color? errorLabelColor;
  final Color? disabledLabelColor;
  final Color hintColor;
  final Color? focusedHintColor;
  final Color? errorHintColor;
  final Color? disabledHintColor;
  final Color helperColor;
  final Color? focusedHelperColor;
  final Color? errorHelperColor;
  final Color? disabledHelperColor;
  final Color cursorColor;
  final Color? selectionColor;
  final Color? errorColor;
  final Color counterColor;
  final Color prefixColor;
  final Color suffixColor;
}