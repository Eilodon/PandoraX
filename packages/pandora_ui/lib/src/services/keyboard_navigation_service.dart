import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'accessibility_service.dart';
import 'focus_management_service.dart';

/// Pandora 4 Keyboard Navigation Service
/// 
/// Provides comprehensive keyboard navigation support for accessibility
class KeyboardNavigationService {
  // Private constructor to prevent instantiation
  KeyboardNavigationService._();

  static final Map<String, KeyboardNavigationHandler> _handlers = {};
  static final List<KeyboardShortcut> _shortcuts = [];

  /// Register a keyboard navigation handler
  static void registerHandler(String id, KeyboardNavigationHandler handler) {
    _handlers[id] = handler;
  }

  /// Unregister a keyboard navigation handler
  static void unregisterHandler(String id) {
    _handlers.remove(id);
  }

  /// Register a keyboard shortcut
  static void registerShortcut(KeyboardShortcut shortcut) {
    _shortcuts.add(shortcut);
  }

  /// Unregister a keyboard shortcut
  static void unregisterShortcut(String id) {
    _shortcuts.removeWhere((shortcut) => shortcut.id == id);
  }

  /// Handle keyboard events
  static bool handleKeyEvent(KeyEvent event, BuildContext context) {
    if (event is KeyDownEvent) {
      // Handle global shortcuts first
      for (final shortcut in _shortcuts) {
        if (shortcut.matches(event)) {
          shortcut.action(context);
          return true;
        }
      }

      // Handle focus management
      if (FocusManagementService.handleKeyEvent(event)) {
        return true;
      }

      // Handle specific navigation patterns
      return _handleNavigationKey(event, context);
    }
    return false;
  }

  /// Handle navigation-specific keys
  static bool _handleNavigationKey(KeyDownEvent event, BuildContext context) {
    switch (event.logicalKey) {
      case LogicalKeyboardKey.escape:
        return _handleEscape(context);
      case LogicalKeyboardKey.enter:
        return _handleEnter(context);
      case LogicalKeyboardKey.space:
        return _handleSpace(context);
      case LogicalKeyboardKey.arrowLeft:
        return _handleArrowLeft(context);
      case LogicalKeyboardKey.arrowRight:
        return _handleArrowRight(context);
      case LogicalKeyboardKey.arrowUp:
        return _handleArrowUp(context);
      case LogicalKeyboardKey.arrowDown:
        return _handleArrowDown(context);
      case LogicalKeyboardKey.tab:
        return _handleTab(context);
      case LogicalKeyboardKey.f6:
        return _handleF6(context);
      case LogicalKeyboardKey.f10:
        return _handleF10(context);
      default:
        return false;
    }
  }

  /// Handle Escape key
  static bool _handleEscape(BuildContext context) {
    // Close modals, dialogs, or return to previous screen
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
      AccessibilityService.announceChange('Dialog closed');
      return true;
    }
    return false;
  }

  /// Handle Enter key
  static bool _handleEnter(BuildContext context) {
    final currentItem = FocusManagementService.getCurrentItem();
    if (currentItem != null) {
      // Trigger action on current focused item
      AccessibilityService.announceChange('Activated');
      return true;
    }
    return false;
  }

  /// Handle Space key
  static bool _handleSpace(BuildContext context) {
    final currentItem = FocusManagementService.getCurrentItem();
    if (currentItem != null) {
      // Toggle or activate current focused item
      AccessibilityService.announceChange('Toggled');
      return true;
    }
    return false;
  }

  /// Handle Left Arrow key
  static bool _handleArrowLeft(BuildContext context) {
    // Move to previous item in horizontal layout
    return FocusManagementService.moveToPrevious();
  }

  /// Handle Right Arrow key
  static bool _handleArrowRight(BuildContext context) {
    // Move to next item in horizontal layout
    return FocusManagementService.moveToNext();
  }

  /// Handle Up Arrow key
  static bool _handleArrowUp(BuildContext context) {
    // Move to previous item in vertical layout
    return FocusManagementService.moveToPrevious();
  }

  /// Handle Down Arrow key
  static bool _handleArrowDown(BuildContext context) {
    // Move to next item in vertical layout
    return FocusManagementService.moveToNext();
  }

  /// Handle Tab key
  static bool _handleTab(BuildContext context) {
    if (HardwareKeyboard.instance.isShiftPressed) {
      return FocusManagementService.moveToPrevious();
    } else {
      return FocusManagementService.moveToNext();
    }
  }

  /// Handle F6 key (cycle through major sections)
  static bool _handleF6(BuildContext context) {
    // Cycle through major sections of the app
    AccessibilityService.announceChange('Cycling through sections');
    return true;
  }

  /// Handle F10 key (activate menu bar)
  static bool _handleF10(BuildContext context) {
    // Activate menu bar or main navigation
    AccessibilityService.announceChange('Menu bar activated');
    return true;
  }

  /// Create keyboard navigation wrapper
  static Widget wrapWithKeyboardNavigation({
    required Widget child,
    required String id,
    KeyboardNavigationHandler? handler,
  }) {
    if (handler != null) {
      registerHandler(id, handler);
    }

    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: (event) {
        // Handle key event without context dependency
        // handleKeyEvent(event, null);
      },
      child: child,
    );
  }

  /// Get available keyboard shortcuts
  static List<KeyboardShortcut> getAvailableShortcuts() {
    return List.unmodifiable(_shortcuts);
  }

  /// Clear all handlers and shortcuts
  static void clear() {
    _handlers.clear();
    _shortcuts.clear();
  }
}

/// Keyboard navigation handler
abstract class KeyboardNavigationHandler {
  bool handleKeyEvent(KeyEvent event, BuildContext context);
}

/// Keyboard shortcut definition
class KeyboardShortcut {
  final String id;
  final LogicalKeySet keySet;
  final VoidCallback Function(BuildContext) action;
  final String description;

  const KeyboardShortcut({
    required this.id,
    required this.keySet,
    required this.action,
    required this.description,
  });

  bool matches(KeyEvent event) {
    return keySet.accepts(event, HardwareKeyboard.instance);
  }
}

/// Common keyboard shortcuts
class CommonKeyboardShortcuts {
  static final List<KeyboardShortcut> shortcuts = [
    KeyboardShortcut(
      id: 'help',
      keySet: LogicalKeySet(LogicalKeyboardKey.f1),
      action: _showHelp,
      description: 'Show help',
    ),
    KeyboardShortcut(
      id: 'search',
      keySet: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyF),
      action: _openSearch,
      description: 'Open search',
    ),
    KeyboardShortcut(
      id: 'settings',
      keySet: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.comma),
      action: _openSettings,
      description: 'Open settings',
    ),
    KeyboardShortcut(
      id: 'new',
      keySet: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyN),
      action: _createNew,
      description: 'Create new item',
    ),
    KeyboardShortcut(
      id: 'save',
      keySet: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyS),
      action: _save,
      description: 'Save current item',
    ),
    KeyboardShortcut(
      id: 'undo',
      keySet: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyZ),
      action: _undo,
      description: 'Undo last action',
    ),
    KeyboardShortcut(
      id: 'redo',
      keySet: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyY),
      action: _redo,
      description: 'Redo last action',
    ),
  ];

  static VoidCallback _showHelp(BuildContext context) {
    return () {
      AccessibilityService.announceChange('Help opened');
      // Implementation for showing help
    };
  }

  static VoidCallback _openSearch(BuildContext context) {
    return () {
      AccessibilityService.announceChange('Search opened');
      // Implementation for opening search
    };
  }

  static VoidCallback _openSettings(BuildContext context) {
    return () {
      AccessibilityService.announceChange('Settings opened');
      // Implementation for opening settings
    };
  }

  static VoidCallback _createNew(BuildContext context) {
    return () {
      AccessibilityService.announceChange('Creating new item');
      // Implementation for creating new item
    };
  }

  static VoidCallback _save(BuildContext context) {
    return () {
      AccessibilityService.announceChange('Saving item');
      // Implementation for saving
    };
  }

  static VoidCallback _undo(BuildContext context) {
    return () {
      AccessibilityService.announceChange('Undoing last action');
      // Implementation for undo
    };
  }

  static VoidCallback _redo(BuildContext context) {
    return () {
      AccessibilityService.announceChange('Redoing last action');
      // Implementation for redo
    };
  }
}

/// Keyboard navigation extensions
extension KeyboardNavigationExtensions on Widget {
  /// Add keyboard navigation support
  Widget withKeyboardNavigation({
    required String id,
    KeyboardNavigationHandler? handler,
  }) {
    return KeyboardNavigationService.wrapWithKeyboardNavigation(
      child: this,
      id: id,
      handler: handler,
    );
  }
}
