import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Pandora 4 Focus Management Service
/// 
/// Provides comprehensive focus management for keyboard navigation
/// and accessibility support
class FocusManagementService {
  // Private constructor to prevent instantiation
  FocusManagementService._();

  static final Map<String, FocusNode> _focusNodes = {};
  static final List<FocusableItem> _focusOrder = [];
  static int _currentFocusIndex = 0;

  /// Register a focusable item
  static void registerFocusable({
    required String id,
    required FocusNode focusNode,
    required int order,
    String? group,
    bool canFocus = true,
  }) {
    _focusNodes[id] = focusNode;
    
    // Remove existing item with same id
    _focusOrder.removeWhere((item) => item.id == id);
    
    // Add new item
    _focusOrder.add(FocusableItem(
      id: id,
      focusNode: focusNode,
      order: order,
      group: group,
      canFocus: canFocus,
    ));
    
    // Sort by order
    _focusOrder.sort((a, b) => a.order.compareTo(b.order));
  }

  /// Unregister a focusable item
  static void unregisterFocusable(String id) {
    _focusNodes.remove(id);
    _focusOrder.removeWhere((item) => item.id == id);
  }

  /// Move focus to next item
  static bool moveToNext() {
    if (_focusOrder.isEmpty) return false;
    
    int nextIndex = _currentFocusIndex + 1;
    
    // Find next focusable item
    while (nextIndex < _focusOrder.length) {
      final item = _focusOrder[nextIndex];
      if (item.canFocus) {
        _setFocus(item);
        return true;
      }
      nextIndex++;
    }
    
    // Wrap around to beginning
    nextIndex = 0;
    while (nextIndex < _currentFocusIndex) {
      final item = _focusOrder[nextIndex];
      if (item.canFocus) {
        _setFocus(item);
        return true;
      }
      nextIndex++;
    }
    
    return false;
  }

  /// Move focus to previous item
  static bool moveToPrevious() {
    if (_focusOrder.isEmpty) return false;
    
    int prevIndex = _currentFocusIndex - 1;
    
    // Find previous focusable item
    while (prevIndex >= 0) {
      final item = _focusOrder[prevIndex];
      if (item.canFocus) {
        _setFocus(item);
        return true;
      }
      prevIndex--;
    }
    
    // Wrap around to end
    prevIndex = _focusOrder.length - 1;
    while (prevIndex > _currentFocusIndex) {
      final item = _focusOrder[prevIndex];
      if (item.canFocus) {
        _setFocus(item);
        return true;
      }
      prevIndex--;
    }
    
    return false;
  }

  /// Move focus to first item
  static bool moveToFirst() {
    if (_focusOrder.isEmpty) return false;
    
    for (int i = 0; i < _focusOrder.length; i++) {
      final item = _focusOrder[i];
      if (item.canFocus) {
        _setFocus(item);
        return true;
      }
    }
    
    return false;
  }

  /// Move focus to last item
  static bool moveToLast() {
    if (_focusOrder.isEmpty) return false;
    
    for (int i = _focusOrder.length - 1; i >= 0; i--) {
      final item = _focusOrder[i];
      if (item.canFocus) {
        _setFocus(item);
        return true;
      }
    }
    
    return false;
  }

  /// Move focus to specific item
  static bool moveToItem(String id) {
    final item = _focusOrder.firstWhere(
      (item) => item.id == id,
      orElse: () => throw StateError('Item with id $id not found'),
    );
    
    if (item.canFocus) {
      _setFocus(item);
      return true;
    }
    
    return false;
  }

  /// Move focus within a group
  static bool moveToNextInGroup(String group) {
    final groupItems = _focusOrder.where((item) => item.group == group).toList();
    if (groupItems.isEmpty) return false;
    
    final currentItem = _getCurrentItem();
    if (currentItem == null || currentItem.group != group) {
      // Move to first item in group
      final firstItem = groupItems.first;
      if (firstItem.canFocus) {
        _setFocus(firstItem);
        return true;
      }
    } else {
      // Find next item in group
      final currentIndex = groupItems.indexOf(currentItem);
      for (int i = currentIndex + 1; i < groupItems.length; i++) {
        final item = groupItems[i];
        if (item.canFocus) {
          _setFocus(item);
          return true;
        }
      }
    }
    
    return false;
  }

  /// Move focus to previous item in group
  static bool moveToPreviousInGroup(String group) {
    final groupItems = _focusOrder.where((item) => item.group == group).toList();
    if (groupItems.isEmpty) return false;
    
    final currentItem = _getCurrentItem();
    if (currentItem == null || currentItem.group != group) {
      // Move to last item in group
      final lastItem = groupItems.last;
      if (lastItem.canFocus) {
        _setFocus(lastItem);
        return true;
      }
    } else {
      // Find previous item in group
      final currentIndex = groupItems.indexOf(currentItem);
      for (int i = currentIndex - 1; i >= 0; i--) {
        final item = groupItems[i];
        if (item.canFocus) {
          _setFocus(item);
          return true;
        }
      }
    }
    
    return false;
  }

  /// Set focus to specific item
  static void _setFocus(FocusableItem item) {
    // Unfocus current item
    final currentItem = _getCurrentItem();
    if (currentItem != null) {
      currentItem.focusNode.unfocus();
    }
    
    // Focus new item
    item.focusNode.requestFocus();
    _currentFocusIndex = _focusOrder.indexOf(item);
  }

  /// Get current focused item
  static FocusableItem? _getCurrentItem() {
    if (_currentFocusIndex >= 0 && _currentFocusIndex < _focusOrder.length) {
      return _focusOrder[_currentFocusIndex];
    }
    return null;
  }

  /// Get current focused item
  static FocusableItem? getCurrentItem() {
    return _getCurrentItem();
  }

  /// Check if item is currently focused
  static bool isItemFocused(String id) {
    final currentItem = _getCurrentItem();
    return currentItem?.id == id;
  }

  /// Enable/disable focus for item
  static void setItemFocusable(String id, bool canFocus) {
    final item = _focusOrder.firstWhere(
      (item) => item.id == id,
      orElse: () => throw StateError('Item with id $id not found'),
    );
    
    final index = _focusOrder.indexOf(item);
    _focusOrder[index] = item.copyWith(canFocus: canFocus);
  }

  /// Clear all focus
  static void clearFocus() {
    for (final item in _focusOrder) {
      item.focusNode.unfocus();
    }
    _currentFocusIndex = 0;
  }

  /// Get focus order
  static List<FocusableItem> getFocusOrder() {
    return List.unmodifiable(_focusOrder);
  }

  /// Get focusable items in group
  static List<FocusableItem> getGroupItems(String group) {
    return _focusOrder.where((item) => item.group == group).toList();
  }

  /// Handle keyboard navigation
  static bool handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.tab:
          if (HardwareKeyboard.instance.isShiftPressed) {
            return moveToPrevious();
          } else {
            return moveToNext();
          }
        case LogicalKeyboardKey.arrowDown:
          return moveToNext();
        case LogicalKeyboardKey.arrowUp:
          return moveToPrevious();
        case LogicalKeyboardKey.home:
          return moveToFirst();
        case LogicalKeyboardKey.end:
          return moveToLast();
        case LogicalKeyboardKey.enter:
        case LogicalKeyboardKey.space:
          final currentItem = _getCurrentItem();
          if (currentItem != null) {
            // Trigger action on current item
            return true;
          }
          break;
      }
    }
    return false;
  }

  /// Create focusable widget
  static Widget createFocusable({
    required String id,
    required Widget child,
    required int order,
    String? group,
    bool autofocus = false,
    VoidCallback? onFocusChange,
    VoidCallback? onActivate,
  }) {
    final focusNode = FocusNode();
    
    return Focus(
      key: ValueKey(id),
      focusNode: focusNode,
      autofocus: autofocus,
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          _currentFocusIndex = _focusOrder.indexWhere((item) => item.id == id);
        }
        onFocusChange?.call();
      },
      child: KeyboardListener(
        onKeyEvent: (event) {
          if (handleKeyEvent(event)) {
            onActivate?.call();
          }
        },
        child: GestureDetector(
          onTap: () {
            focusNode.requestFocus();
            onActivate?.call();
          },
          child: child,
        ),
      ),
    );
  }

  /// Dispose all focus nodes
  static void dispose() {
    for (final node in _focusNodes.values) {
      node.dispose();
    }
    _focusNodes.clear();
    _focusOrder.clear();
    _currentFocusIndex = 0;
  }
}

/// Focusable item data class
class FocusableItem {
  final String id;
  final FocusNode focusNode;
  final int order;
  final String? group;
  final bool canFocus;

  const FocusableItem({
    required this.id,
    required this.focusNode,
    required this.order,
    this.group,
    this.canFocus = true,
  });

  FocusableItem copyWith({
    String? id,
    FocusNode? focusNode,
    int? order,
    String? group,
    bool? canFocus,
  }) {
    return FocusableItem(
      id: id ?? this.id,
      focusNode: focusNode ?? this.focusNode,
      order: order ?? this.order,
      group: group ?? this.group,
      canFocus: canFocus ?? this.canFocus,
    );
  }
}

/// Focus management extensions
extension FocusManagementExtensions on Widget {
  /// Make widget focusable with focus management
  Widget withFocusManagement({
    required String id,
    required int order,
    String? group,
    bool autofocus = false,
    VoidCallback? onFocusChange,
    VoidCallback? onActivate,
  }) {
    return FocusManagementService.createFocusable(
      id: id,
      child: this,
      order: order,
      group: group,
      autofocus: autofocus,
      onFocusChange: onFocusChange,
      onActivate: onActivate,
    );
  }
}
