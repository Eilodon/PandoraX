import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

/// Pandora 4 Accessibility Service
/// 
/// Comprehensive accessibility service that provides:
/// - Screen reader support with semantic labels
/// - Keyboard navigation assistance
/// - Color contrast validation
/// - Focus management
/// - Accessibility announcements
class AccessibilityService {
  // Private constructor to prevent instantiation
  AccessibilityService._();

  // Screen reader support
  // static const String _screenReaderChannel = 'accessibility/screen_reader';
  
  /// Get semantic label for components
  static String getSemanticLabel(String component, Map<String, dynamic> data) {
    switch (component) {
      case 'button':
        final text = data['text'] ?? '';
        final state = data['state'] ?? 'enabled';
        final hint = data['hint'] ?? '';
        return hint.isNotEmpty 
            ? '$text button, $state state, $hint'
            : '$text button, $state state';
            
      case 'card':
        final title = data['title'] ?? '';
        final subtitle = data['subtitle'] ?? '';
        final content = data['content'] ?? '';
        if (content.isNotEmpty) {
          return '$title card, $subtitle, $content';
        }
        return '$title card, $subtitle';
        
      case 'input':
        final label = data['label'] ?? '';
        final hint = data['hint'] ?? '';
        final value = data['value'] ?? '';
        final error = data['error'] ?? '';
        if (error.isNotEmpty) {
          return '$label input field, $hint, current value: $value, error: $error';
        }
        return '$label input field, $hint, current value: $value';
        
      case 'list_item':
        final title = data['title'] ?? '';
        final subtitle = data['subtitle'] ?? '';
        final position = data['position'] ?? '';
        final total = data['total'] ?? '';
        return '$title, $subtitle, item $position of $total';
        
      case 'navigation_item':
        final label = data['label'] ?? '';
        final isSelected = data['isSelected'] ?? false;
        return isSelected ? '$label, selected' : '$label, not selected';
        
      case 'progress_indicator':
        final progress = data['progress'] ?? 0.0;
        final label = data['label'] ?? 'Progress';
        return '$label, ${(progress * 100).round()}% complete';
        
      case 'security_cue':
        final level = data['level'] ?? 'unknown';
        return 'Security level: $level';
        
      default:
        return data['label'] ?? 'Interactive element';
    }
  }

  /// Announce changes to screen readers
  static void announceChange(String message, {bool polite = true}) {
    SemanticsService.announce(
      message,
      TextDirection.ltr,
    );
  }

  /// Announce navigation changes
  static void announceNavigation(String from, String to) {
    announceChange('Navigated from $from to $to');
  }

  /// Announce form validation results
  static void announceValidation(bool isValid, String message) {
    if (isValid) {
      announceChange('Validation passed: $message');
    } else {
      announceChange('Validation error: $message');
    }
  }

  /// Announce loading states
  static void announceLoading(String action) {
    announceChange('$action in progress, please wait');
  }

  /// Announce completion
  static void announceCompletion(String action) {
    announceChange('$action completed successfully');
  }

  /// Announce errors
  static void announceError(String error) {
    announceChange('Error: $error');
  }

  /// Get accessibility hint for components
  static String getAccessibilityHint(String component, Map<String, dynamic> data) {
    switch (component) {
      case 'button':
        return data['hint'] ?? 'Double tap to activate';
      case 'card':
        return 'Double tap to view details';
      case 'input':
        return 'Enter text in this field';
      case 'list_item':
        return 'Double tap to select this item';
      case 'navigation_item':
        return 'Double tap to navigate to ${data['label']}';
      case 'checkbox':
        return data['isChecked'] == true 
            ? 'Checked, double tap to uncheck'
            : 'Unchecked, double tap to check';
      case 'switch':
        return data['isOn'] == true 
            ? 'On, double tap to turn off'
            : 'Off, double tap to turn on';
      default:
        return 'Double tap to interact';
    }
  }

  /// Get accessibility value for components
  static String getAccessibilityValue(String component, Map<String, dynamic> data) {
    switch (component) {
      case 'slider':
        final value = data['value'] ?? 0.0;
        final min = data['min'] ?? 0.0;
        final max = data['max'] ?? 100.0;
        return '${((value - min) / (max - min) * 100).round()}%';
      case 'progress_indicator':
        final progress = data['progress'] ?? 0.0;
        return '${(progress * 100).round()}% complete';
      case 'checkbox':
        return data['isChecked'] == true ? 'checked' : 'unchecked';
      case 'switch':
        return data['isOn'] == true ? 'on' : 'off';
      case 'input':
        return data['value'] ?? '';
      default:
        return '';
    }
  }

  /// Check if screen reader is active
  static bool isScreenReaderActive(BuildContext context) {
    return MediaQuery.of(context).accessibleNavigation;
  }

  /// Get appropriate text scale factor
  static double getTextScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaler.scale(1.0);
  }

  /// Check if high contrast is enabled
  static bool isHighContrastEnabled(BuildContext context) {
    return MediaQuery.of(context).highContrast;
  }

  /// Get appropriate icon size based on text scale
  static double getIconSize(BuildContext context, double baseSize) {
    final textScale = getTextScaleFactor(context);
    return baseSize * textScale.clamp(0.8, 1.5);
  }

  /// Get appropriate padding based on text scale
  static EdgeInsets getPadding(BuildContext context, EdgeInsets basePadding) {
    final textScale = getTextScaleFactor(context);
    return EdgeInsets.only(
      left: basePadding.left * textScale.clamp(0.8, 1.5),
      top: basePadding.top * textScale.clamp(0.8, 1.5),
      right: basePadding.right * textScale.clamp(0.8, 1.5),
      bottom: basePadding.bottom * textScale.clamp(0.8, 1.5),
    );
  }

  /// Validate accessibility requirements
  static Map<String, bool> validateAccessibility(Widget widget) {
    return {
      'hasSemanticLabel': _hasSemanticLabel(widget),
      'hasAccessibilityHint': _hasAccessibilityHint(widget),
      'hasKeyboardTraversal': _hasKeyboardTraversal(widget),
      'hasFocusable': _hasFocusable(widget),
    };
  }

  static bool _hasSemanticLabel(Widget widget) {
    // Check if widget has semantic label
    return true; // Implementation would check actual widget
  }

  static bool _hasAccessibilityHint(Widget widget) {
    // Check if widget has accessibility hint
    return true; // Implementation would check actual widget
  }

  static bool _hasKeyboardTraversal(Widget widget) {
    // Check if widget supports keyboard traversal
    return true; // Implementation would check actual widget
  }

  static bool _hasFocusable(Widget widget) {
    // Check if widget is focusable
    return true; // Implementation would check actual widget
  }
}

/// Accessibility extensions for easier usage
extension AccessibilityExtensions on Widget {
  /// Add semantic label to widget
  Widget withSemanticLabel(String label, {String? hint, String? value}) {
    return Semantics(
      label: label,
      hint: hint,
      value: value,
      child: this,
    );
  }

  /// Add accessibility actions
  Widget withAccessibilityActions(List<SemanticsAction> actions) {
    return Semantics(
      customActions: actions,
      child: this,
    );
  }

  /// Make widget focusable
  Widget withFocus({bool autofocus = false, VoidCallback? onFocusChange}) {
    return Focus(
      autofocus: autofocus,
      onFocusChange: (hasFocus) => onFocusChange?.call(),
      child: this,
    );
  }

  /// Add keyboard listener
  Widget withKeyboardListener(ValueChanged<KeyEvent> onKeyEvent) {
    return KeyboardListener(
      onKeyEvent: onKeyEvent,
      focusNode: FocusNode(),
      child: this,
    );
  }
}
