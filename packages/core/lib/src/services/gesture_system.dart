/// Gesture System for Phase 5 Advanced UX
/// 
/// This service provides advanced gesture recognition and handling
/// for enhanced touch interactions and user experience.
library gesture_system;

import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:pandora_ui/pandora_ui.dart';

/// Gesture system for advanced touch interactions
class GestureSystem {
  static GestureSystem? _instance;
  static GestureSystem get instance => _instance ??= GestureSystem._();
  
  GestureSystem._();
  
  final LoggingService _logger = LoggingService.instance;
  final MicroInteractionService _microInteraction = MicroInteractionService.instance;
  
  // ============================================================================
  // SWIPE GESTURES
  // ============================================================================
  
  /// Create swipe gesture detector
  Widget createSwipeGesture({
    required Widget child,
    VoidCallback? onSwipeLeft,
    VoidCallback? onSwipeRight,
    VoidCallback? onSwipeUp,
    VoidCallback? onSwipeDown,
    double swipeThreshold = 50.0,
    double velocityThreshold = 300.0,
    bool enableHapticFeedback = true,
    bool enableSoundFeedback = true,
  }) {
    return _SwipeGestureDetector(
      onSwipeLeft: onSwipeLeft,
      onSwipeRight: onSwipeRight,
      onSwipeUp: onSwipeUp,
      onSwipeDown: onSwipeDown,
      swipeThreshold: swipeThreshold,
      velocityThreshold: velocityThreshold,
      enableHapticFeedback: enableHapticFeedback,
      enableSoundFeedback: enableSoundFeedback,
      child: child,
    );
  }
  
  /// Create horizontal swipe gesture
  Widget createHorizontalSwipe({
    required Widget child,
    VoidCallback? onSwipeLeft,
    VoidCallback? onSwipeRight,
    double swipeThreshold = 50.0,
    double velocityThreshold = 300.0,
  }) {
    return createSwipeGesture(
      child: child,
      onSwipeLeft: onSwipeLeft,
      onSwipeRight: onSwipeRight,
      swipeThreshold: swipeThreshold,
      velocityThreshold: velocityThreshold,
    );
  }
  
  /// Create vertical swipe gesture
  Widget createVerticalSwipe({
    required Widget child,
    VoidCallback? onSwipeUp,
    VoidCallback? onSwipeDown,
    double swipeThreshold = 50.0,
    double velocityThreshold = 300.0,
  }) {
    return createSwipeGesture(
      child: child,
      onSwipeUp: onSwipeUp,
      onSwipeDown: onSwipeDown,
      swipeThreshold: swipeThreshold,
      velocityThreshold: velocityThreshold,
    );
  }
  
  // ============================================================================
  // PINCH GESTURES
  // ============================================================================
  
  /// Create pinch gesture detector
  Widget createPinchGesture({
    required Widget child,
    VoidCallback? onPinchIn,
    VoidCallback? onPinchOut,
    double pinchThreshold = 0.5,
    bool enableHapticFeedback = true,
    bool enableSoundFeedback = true,
  }) {
    return _PinchGestureDetector(
      onPinchIn: onPinchIn,
      onPinchOut: onPinchOut,
      pinchThreshold: pinchThreshold,
      enableHapticFeedback: enableHapticFeedback,
      enableSoundFeedback: enableSoundFeedback,
      child: child,
    );
  }
  
  /// Create zoom gesture detector
  Widget createZoomGesture({
    required Widget child,
    VoidCallback? onZoomIn,
    VoidCallback? onZoomOut,
    double zoomThreshold = 1.2,
  }) {
    return createPinchGesture(
      child: child,
      onPinchIn: onZoomIn,
      onPinchOut: onZoomOut,
      pinchThreshold: zoomThreshold,
    );
  }
  
  // ============================================================================
  // LONG PRESS GESTURES
  // ============================================================================
  
  /// Create long press gesture detector
  Widget createLongPressGesture({
    required Widget child,
    VoidCallback? onLongPress,
    VoidCallback? onLongPressStart,
    VoidCallback? onLongPressEnd,
    Duration longPressDuration = const Duration(milliseconds: 500),
    bool enableHapticFeedback = true,
    bool enableSoundFeedback = true,
  }) {
    return _LongPressGestureDetector(
      onLongPress: onLongPress,
      onLongPressStart: onLongPressStart,
      onLongPressEnd: onLongPressEnd,
      longPressDuration: longPressDuration,
      enableHapticFeedback: enableHapticFeedback,
      enableSoundFeedback: enableSoundFeedback,
      child: child,
    );
  }
  
  /// Create context menu gesture
  Widget createContextMenuGesture({
    required Widget child,
    required Widget Function(BuildContext) contextMenuBuilder,
    Duration longPressDuration = const Duration(milliseconds: 500),
  }) {
    return _ContextMenuGestureDetector(
      contextMenuBuilder: contextMenuBuilder,
      longPressDuration: longPressDuration,
      child: child,
    );
  }
  
  // ============================================================================
  // DRAG GESTURES
  // ============================================================================
  
  /// Create drag gesture detector
  Widget createDragGesture({
    required Widget child,
    VoidCallback? onDragStart,
    VoidCallback? onDragUpdate,
    VoidCallback? onDragEnd,
    double dragThreshold = 10.0,
    bool enableHapticFeedback = true,
    bool enableSoundFeedback = true,
  }) {
    return _DragGestureDetector(
      onDragStart: onDragStart,
      onDragUpdate: onDragUpdate,
      onDragEnd: onDragEnd,
      dragThreshold: dragThreshold,
      enableHapticFeedback: enableHapticFeedback,
      enableSoundFeedback: enableSoundFeedback,
      child: child,
    );
  }
  
  /// Create sortable list gesture
  Widget createSortableListGesture({
    required Widget child,
    required VoidCallback onReorder,
    double dragThreshold = 20.0,
  }) {
    return _SortableListGestureDetector(
      onReorder: onReorder,
      dragThreshold: dragThreshold,
      child: child,
    );
  }
  
  // ============================================================================
  // DOUBLE TAP GESTURES
  // ============================================================================
  
  /// Create double tap gesture detector
  Widget createDoubleTapGesture({
    required Widget child,
    VoidCallback? onDoubleTap,
    Duration doubleTapTimeout = const Duration(milliseconds: 300),
    bool enableHapticFeedback = true,
    bool enableSoundFeedback = true,
  }) {
    return _DoubleTapGestureDetector(
      onDoubleTap: onDoubleTap,
      doubleTapTimeout: doubleTapTimeout,
      enableHapticFeedback: enableHapticFeedback,
      enableSoundFeedback: enableSoundFeedback,
      child: child,
    );
  }
  
  /// Create zoom on double tap gesture
  Widget createZoomOnDoubleTapGesture({
    required Widget child,
    VoidCallback? onZoomIn,
    VoidCallback? onZoomOut,
    bool isZoomed = false,
  }) {
    return createDoubleTapGesture(
      child: child,
      onDoubleTap: isZoomed ? onZoomOut : onZoomIn,
    );
  }
  
  // ============================================================================
  // MULTI-FINGER GESTURES
  // ============================================================================
  
  /// Create multi-finger gesture detector
  Widget createMultiFingerGesture({
    required Widget child,
    VoidCallback? onTwoFingerTap,
    VoidCallback? onThreeFingerTap,
    VoidCallback? onFourFingerTap,
    VoidCallback? onFiveFingerTap,
    Duration tapTimeout = const Duration(milliseconds: 200),
  }) {
    return _MultiFingerGestureDetector(
      onTwoFingerTap: onTwoFingerTap,
      onThreeFingerTap: onThreeFingerTap,
      onFourFingerTap: onFourFingerTap,
      onFiveFingerTap: onFiveFingerTap,
      tapTimeout: tapTimeout,
      child: child,
    );
  }
  
  // ============================================================================
  // GESTURE COMBINATIONS
  // ============================================================================
  
  /// Create combined gesture detector
  Widget createCombinedGesture({
    required Widget child,
    VoidCallback? onTap,
    VoidCallback? onDoubleTap,
    VoidCallback? onLongPress,
    VoidCallback? onSwipeLeft,
    VoidCallback? onSwipeRight,
    VoidCallback? onSwipeUp,
    VoidCallback? onSwipeDown,
    VoidCallback? onPinchIn,
    VoidCallback? onPinchOut,
    bool enableHapticFeedback = true,
    bool enableSoundFeedback = true,
  }) {
    return _CombinedGestureDetector(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      onSwipeLeft: onSwipeLeft,
      onSwipeRight: onSwipeRight,
      onSwipeUp: onSwipeUp,
      onSwipeDown: onSwipeDown,
      onPinchIn: onPinchIn,
      onPinchOut: onPinchOut,
      enableHapticFeedback: enableHapticFeedback,
      enableSoundFeedback: enableSoundFeedback,
      child: child,
    );
  }
  
  // ============================================================================
  // GESTURE ANALYTICS
  // ============================================================================
  
  /// Track gesture usage
  void trackGestureUsage(String gestureType, Map<String, dynamic> context) {
    try {
      _logger.debug('Tracking gesture usage: $gestureType with context: $context');
      
      // Store gesture analytics
      _storeGestureAnalytics(gestureType, context);
      
      // Update gesture preferences
      _updateGesturePreferences(gestureType, context);
    } catch (e) {
      _logger.warning('Failed to track gesture usage: $e');
    }
  }
  
  /// Store gesture analytics
  void _storeGestureAnalytics(String gestureType, Map<String, dynamic> context) {
    // In a real implementation, you would store this in a database
    _logger.debug('Stored gesture analytics: $gestureType');
  }
  
  /// Update gesture preferences
  void _updateGesturePreferences(String gestureType, Map<String, dynamic> context) {
    // In a real implementation, you would update user preferences
    _logger.debug('Updated gesture preferences: $gestureType');
  }
  
  /// Get gesture analytics
  Map<String, dynamic> getGestureAnalytics() {
    try {
      // In a real implementation, you would load from database
      return {
        'total_gestures': 0,
        'most_used_gesture': 'tap',
        'gesture_frequency': {},
        'gesture_success_rate': 95.0,
        'gesture_preferences': {},
      };
    } catch (e) {
      _logger.warning('Failed to get gesture analytics: $e');
      return {};
    }
  }
  
  // ============================================================================
  // GESTURE CONFIGURATION
  // ============================================================================
  
  /// Enable/disable gesture feedback
  bool _gestureFeedbackEnabled = true;
  bool get gestureFeedbackEnabled => _gestureFeedbackEnabled;
  
  void setGestureFeedbackEnabled(bool enabled) {
    _gestureFeedbackEnabled = enabled;
    _logger.info('Gesture feedback ${enabled ? 'enabled' : 'disabled'}');
  }
  
  /// Enable/disable specific gesture type
  void setGestureEnabled(String gestureType, bool enabled) {
    _logger.info('Gesture $gestureType ${enabled ? 'enabled' : 'disabled'}');
  }
  
  /// Get gesture configuration
  Map<String, dynamic> getGestureConfiguration() {
    return {
      'feedback_enabled': _gestureFeedbackEnabled,
      'swipe_threshold': 50.0,
      'pinch_threshold': 0.5,
      'long_press_duration': 500,
      'double_tap_timeout': 300,
      'drag_threshold': 10.0,
    };
  }
}

// ============================================================================
// PRIVATE GESTURE DETECTORS
// ============================================================================

/// Swipe gesture detector
class _SwipeGestureDetector extends StatefulWidget {
  final Widget child;
  final VoidCallback? onSwipeLeft;
  final VoidCallback? onSwipeRight;
  final VoidCallback? onSwipeUp;
  final VoidCallback? onSwipeDown;
  final double swipeThreshold;
  final double velocityThreshold;
  final bool enableHapticFeedback;
  final bool enableSoundFeedback;
  
  const _SwipeGestureDetector({
    required this.child,
    this.onSwipeLeft,
    this.onSwipeRight,
    this.onSwipeUp,
    this.onSwipeDown,
    required this.swipeThreshold,
    required this.velocityThreshold,
    required this.enableHapticFeedback,
    required this.enableSoundFeedback,
  });
  
  @override
  State<_SwipeGestureDetector> createState() => _SwipeGestureDetectorState();
}

class _SwipeGestureDetectorState extends State<_SwipeGestureDetector> {
  Offset? _startPosition;
  Offset? _endPosition;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        _startPosition = details.globalPosition;
      },
      onPanUpdate: (details) {
        _endPosition = details.globalPosition;
      },
      onPanEnd: (details) {
        if (_startPosition != null && _endPosition != null) {
          _handleSwipe(details.velocity);
        }
        _startPosition = null;
        _endPosition = null;
      },
      child: widget.child,
    );
  }
  
  void _handleSwipe(Velocity velocity) {
    final delta = _endPosition! - _startPosition!;
    final distance = delta.distance;
    final speed = velocity.pixelsPerSecond.distance;
    
    if (distance < widget.swipeThreshold || speed < widget.velocityThreshold) {
      return;
    }
    
    final direction = _getSwipeDirection(delta);
    
    switch (direction) {
      case SwipeDirection.left:
        if (widget.onSwipeLeft != null) {
          _triggerFeedback();
          widget.onSwipeLeft!();
        }
        break;
      case SwipeDirection.right:
        if (widget.onSwipeRight != null) {
          _triggerFeedback();
          widget.onSwipeRight!();
        }
        break;
      case SwipeDirection.up:
        if (widget.onSwipeUp != null) {
          _triggerFeedback();
          widget.onSwipeUp!();
        }
        break;
      case SwipeDirection.down:
        if (widget.onSwipeDown != null) {
          _triggerFeedback();
          widget.onSwipeDown!();
        }
        break;
    }
  }
  
  SwipeDirection _getSwipeDirection(Offset delta) {
    if (delta.dx.abs() > delta.dy.abs()) {
      return delta.dx > 0 ? SwipeDirection.right : SwipeDirection.left;
    } else {
      return delta.dy > 0 ? SwipeDirection.down : SwipeDirection.up;
    }
  }
  
  void _triggerFeedback() {
    if (widget.enableHapticFeedback) {
      MicroInteractionService.instance.lightImpact();
    }
    if (widget.enableSoundFeedback) {
      MicroInteractionService.instance.playSwipeSound();
    }
  }
}


/// Pinch gesture detector
class _PinchGestureDetector extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPinchIn;
  final VoidCallback? onPinchOut;
  final double pinchThreshold;
  final bool enableHapticFeedback;
  final bool enableSoundFeedback;
  
  const _PinchGestureDetector({
    required this.child,
    this.onPinchIn,
    this.onPinchOut,
    required this.pinchThreshold,
    required this.enableHapticFeedback,
    required this.enableSoundFeedback,
  });
  
  @override
  State<_PinchGestureDetector> createState() => _PinchGestureDetectorState();
}

class _PinchGestureDetectorState extends State<_PinchGestureDetector> {
  double _initialScale = 1.0;
  double _currentScale = 1.0;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: (details) {
        _initialScale = _currentScale;
      },
      onScaleUpdate: (details) {
        setState(() {
          _currentScale = _initialScale * details.scale;
        });
      },
      onScaleEnd: (details) {
        _handlePinch();
        _currentScale = 1.0;
      },
      child: Transform.scale(
        scale: _currentScale,
        child: widget.child,
      ),
    );
  }
  
  void _handlePinch() {
    if (_currentScale < 1.0 - widget.pinchThreshold) {
      if (widget.onPinchIn != null) {
        _triggerFeedback();
        widget.onPinchIn!();
      }
    } else if (_currentScale > 1.0 + widget.pinchThreshold) {
      if (widget.onPinchOut != null) {
        _triggerFeedback();
        widget.onPinchOut!();
      }
    }
  }
  
  void _triggerFeedback() {
    if (widget.enableHapticFeedback) {
      MicroInteractionService.instance.mediumImpact();
    }
    if (widget.enableSoundFeedback) {
      MicroInteractionService.instance.playClickSound();
    }
  }
}

/// Long press gesture detector
class _LongPressGestureDetector extends StatefulWidget {
  final Widget child;
  final VoidCallback? onLongPress;
  final VoidCallback? onLongPressStart;
  final VoidCallback? onLongPressEnd;
  final Duration longPressDuration;
  final bool enableHapticFeedback;
  final bool enableSoundFeedback;
  
  const _LongPressGestureDetector({
    required this.child,
    this.onLongPress,
    this.onLongPressStart,
    this.onLongPressEnd,
    required this.longPressDuration,
    required this.enableHapticFeedback,
    required this.enableSoundFeedback,
  });
  
  @override
  State<_LongPressGestureDetector> createState() => _LongPressGestureDetectorState();
}

class _LongPressGestureDetectorState extends State<_LongPressGestureDetector> {
  bool _isLongPressing = false;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (details) {
        setState(() {
          _isLongPressing = true;
        });
        widget.onLongPressStart?.call();
        _triggerFeedback();
      },
      onLongPress: () {
        widget.onLongPress?.call();
      },
      onLongPressEnd: (details) {
        setState(() {
          _isLongPressing = false;
        });
        widget.onLongPressEnd?.call();
      },
      child: widget.child,
    );
  }
  
  void _triggerFeedback() {
    if (widget.enableHapticFeedback) {
      MicroInteractionService.instance.heavyImpact();
    }
    if (widget.enableSoundFeedback) {
      MicroInteractionService.instance.playNotificationSound();
    }
  }
}

/// Context menu gesture detector
class _ContextMenuGestureDetector extends StatefulWidget {
  final Widget child;
  final Widget Function(BuildContext) contextMenuBuilder;
  final Duration longPressDuration;
  
  const _ContextMenuGestureDetector({
    required this.child,
    required this.contextMenuBuilder,
    required this.longPressDuration,
  });
  
  @override
  State<_ContextMenuGestureDetector> createState() => _ContextMenuGestureDetectorState();
}

class _ContextMenuGestureDetectorState extends State<_ContextMenuGestureDetector> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        _showContextMenu(context);
      },
      child: widget.child,
    );
  }
  
  void _showContextMenu(BuildContext context) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: Material(
          color: Colors.transparent,
          child: widget.contextMenuBuilder(context),
        ),
      ),
    );
    
    overlay.insert(overlayEntry);
    
    // Auto-dismiss after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}

/// Drag gesture detector
class _DragGestureDetector extends StatefulWidget {
  final Widget child;
  final VoidCallback? onDragStart;
  final VoidCallback? onDragUpdate;
  final VoidCallback? onDragEnd;
  final double dragThreshold;
  final bool enableHapticFeedback;
  final bool enableSoundFeedback;
  
  const _DragGestureDetector({
    required this.child,
    this.onDragStart,
    this.onDragUpdate,
    this.onDragEnd,
    required this.dragThreshold,
    required this.enableHapticFeedback,
    required this.enableSoundFeedback,
  });
  
  @override
  State<_DragGestureDetector> createState() => _DragGestureDetectorState();
}

class _DragGestureDetectorState extends State<_DragGestureDetector> {
  bool _isDragging = false;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        widget.onDragStart?.call();
      },
      onPanUpdate: (details) {
        if (!_isDragging && details.delta.distance > widget.dragThreshold) {
          setState(() {
            _isDragging = true;
          });
          _triggerFeedback();
        }
        if (_isDragging) {
          widget.onDragUpdate?.call();
        }
      },
      onPanEnd: (details) {
        if (_isDragging) {
          setState(() {
            _isDragging = false;
          });
          widget.onDragEnd?.call();
        }
      },
      child: widget.child,
    );
  }
  
  void _triggerFeedback() {
    if (widget.enableHapticFeedback) {
      MicroInteractionService.instance.mediumImpact();
    }
    if (widget.enableSoundFeedback) {
      MicroInteractionService.instance.playClickSound();
    }
  }
}

/// Sortable list gesture detector
class _SortableListGestureDetector extends StatefulWidget {
  final Widget child;
  final VoidCallback onReorder;
  final double dragThreshold;
  
  const _SortableListGestureDetector({
    required this.child,
    required this.onReorder,
    required this.dragThreshold,
  });
  
  @override
  State<_SortableListGestureDetector> createState() => _SortableListGestureDetectorState();
}

class _SortableListGestureDetectorState extends State<_SortableListGestureDetector> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        // Start drag operation
      },
      onPanUpdate: (details) {
        // Update drag position
      },
      onPanEnd: (details) {
        // End drag operation and reorder
        widget.onReorder();
      },
      child: widget.child,
    );
  }
}

/// Double tap gesture detector
class _DoubleTapGestureDetector extends StatefulWidget {
  final Widget child;
  final VoidCallback? onDoubleTap;
  final Duration doubleTapTimeout;
  final bool enableHapticFeedback;
  final bool enableSoundFeedback;
  
  const _DoubleTapGestureDetector({
    required this.child,
    this.onDoubleTap,
    required this.doubleTapTimeout,
    required this.enableHapticFeedback,
    required this.enableSoundFeedback,
  });
  
  @override
  State<_DoubleTapGestureDetector> createState() => _DoubleTapGestureDetectorState();
}

class _DoubleTapGestureDetectorState extends State<_DoubleTapGestureDetector> {
  int _tapCount = 0;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _tapCount++;
        if (_tapCount == 2) {
          _handleDoubleTap();
          _tapCount = 0;
        } else {
          Future.delayed(widget.doubleTapTimeout, () {
            if (mounted) {
              setState(() {
                _tapCount = 0;
              });
            }
          });
        }
      },
      child: widget.child,
    );
  }
  
  void _handleDoubleTap() {
    widget.onDoubleTap?.call();
    _triggerFeedback();
  }
  
  void _triggerFeedback() {
    if (widget.enableHapticFeedback) {
      MicroInteractionService.instance.mediumImpact();
    }
    if (widget.enableSoundFeedback) {
      MicroInteractionService.instance.playClickSound();
    }
  }
}

/// Multi-finger gesture detector
class _MultiFingerGestureDetector extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTwoFingerTap;
  final VoidCallback? onThreeFingerTap;
  final VoidCallback? onFourFingerTap;
  final VoidCallback? onFiveFingerTap;
  final Duration tapTimeout;
  
  const _MultiFingerGestureDetector({
    required this.child,
    this.onTwoFingerTap,
    this.onThreeFingerTap,
    this.onFourFingerTap,
    this.onFiveFingerTap,
    required this.tapTimeout,
  });
  
  @override
  State<_MultiFingerGestureDetector> createState() => _MultiFingerGestureDetectorState();
}

class _MultiFingerGestureDetectorState extends State<_MultiFingerGestureDetector> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        final fingerCount = details.localPosition.distance;
        _handleMultiFingerTap(fingerCount);
      },
      child: widget.child,
    );
  }
  
  void _handleMultiFingerTap(double fingerCount) {
    switch (fingerCount.round()) {
      case 2:
        widget.onTwoFingerTap?.call();
        break;
      case 3:
        widget.onThreeFingerTap?.call();
        break;
      case 4:
        widget.onFourFingerTap?.call();
        break;
      case 5:
        widget.onFiveFingerTap?.call();
        break;
    }
  }
}

/// Combined gesture detector
class _CombinedGestureDetector extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onSwipeLeft;
  final VoidCallback? onSwipeRight;
  final VoidCallback? onSwipeUp;
  final VoidCallback? onSwipeDown;
  final VoidCallback? onPinchIn;
  final VoidCallback? onPinchOut;
  final bool enableHapticFeedback;
  final bool enableSoundFeedback;
  
  const _CombinedGestureDetector({
    required this.child,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onSwipeLeft,
    this.onSwipeRight,
    this.onSwipeUp,
    this.onSwipeDown,
    this.onPinchIn,
    this.onPinchOut,
    required this.enableHapticFeedback,
    required this.enableSoundFeedback,
  });
  
  @override
  State<_CombinedGestureDetector> createState() => _CombinedGestureDetectorState();
}

class _CombinedGestureDetectorState extends State<_CombinedGestureDetector> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onDoubleTap: widget.onDoubleTap,
      onLongPress: widget.onLongPress,
      onPanStart: (details) {
        // Handle swipe gestures
      },
      onPanUpdate: (details) {
        // Handle swipe gestures
      },
      onPanEnd: (details) {
        // Handle swipe gestures
      },
      onScaleStart: (details) {
        // Handle pinch gestures
      },
      onScaleUpdate: (details) {
        // Handle pinch gestures
      },
      onScaleEnd: (details) {
        // Handle pinch gestures
      },
      child: widget.child,
    );
  }
}
