/// Advanced Animation Service for Phase 5 Advanced UX
/// 
/// This service provides sophisticated animation patterns including
/// staggered animations, morphing effects, and performance optimizations.
library advanced_animation_service;

import 'package:flutter/material.dart';
import 'package:core/core.dart';

/// Advanced animation service for sophisticated UX
class AdvancedAnimationService {
  static AdvancedAnimationService? _instance;
  static AdvancedAnimationService get instance => _instance ??= AdvancedAnimationService._();
  
  AdvancedAnimationService._();
  
  final LoggingService _logger = LoggingService.instance;
  
  // ============================================================================
  // STAGGERED ANIMATIONS
  // ============================================================================
  
  /// Create staggered list animation
  Widget createStaggeredList({
    required List<Widget> children,
    Duration delay = const Duration(milliseconds: 100),
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeOut,
    Offset offset = const Offset(0, 50),
    double opacityStart = 0.0,
    double opacityEnd = 1.0,
  }) {
    return Column(
      children: children.asMap().entries.map((entry) {
        final index = entry.key;
        final child = entry.value;
        
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(
            milliseconds: duration.inMilliseconds + (index * delay.inMilliseconds),
          ),
          curve: curve,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(
                offset.dx * (1 - value),
                offset.dy * (1 - value),
              ),
              child: Opacity(
                opacity: opacityStart + (opacityEnd - opacityStart) * value,
                child: child,
              ),
            );
          },
          child: child,
        );
      }).toList(),
    );
  }
  
  /// Create staggered grid animation
  Widget createStaggeredGrid({
    required List<Widget> children,
    required int crossAxisCount,
    Duration delay = const Duration(milliseconds: 100),
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeOut,
    Offset offset = const Offset(0, 50),
    double opacityStart = 0.0,
    double opacityEnd = 1.0,
  }) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: DesignTokens.spacing4,
        mainAxisSpacing: DesignTokens.spacing4,
      ),
      itemCount: children.length,
      itemBuilder: (context, index) {
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(
            milliseconds: duration.inMilliseconds + (index * delay.inMilliseconds),
          ),
          curve: curve,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(
                offset.dx * (1 - value),
                offset.dy * (1 - value),
              ),
              child: Opacity(
                opacity: opacityStart + (opacityEnd - opacityStart) * value,
                child: child,
              ),
            );
          },
          child: children[index],
        );
      },
    );
  }
  
  // ============================================================================
  // MORPHING ANIMATIONS
  // ============================================================================
  
  /// Create morphing button animation
  Widget createMorphingButton({
    required Widget child,
    required VoidCallback onTap,
    Duration duration = const Duration(milliseconds: 200),
    Curve curve = Curves.easeInOut,
    Color? morphColor,
    double? morphScale,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: duration,
        curve: curve,
        transform: Matrix4.identity()..scale(morphScale ?? 1.0),
        decoration: BoxDecoration(
          color: morphColor,
          borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
        ),
        child: child,
      ),
    );
  }
  
  /// Create morphing card animation
  Widget createMorphingCard({
    required Widget child,
    required VoidCallback onTap,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
    Color? morphColor,
    double? morphScale,
    BorderRadius? morphBorderRadius,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: duration,
        curve: curve,
        transform: Matrix4.identity()..scale(morphScale ?? 1.0),
        decoration: BoxDecoration(
          color: morphColor,
          borderRadius: morphBorderRadius ?? BorderRadius.circular(DesignTokens.radiusBase),
          boxShadow: morphScale != null && morphScale > 1.0
              ? DesignTokens.shadowLg
              : DesignTokens.shadowBase,
        ),
        child: child,
      ),
    );
  }
  
  /// Create morphing text animation
  Widget createMorphingText({
    required String text,
    required TextStyle style,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
    double? morphScale,
    Color? morphColor,
  }) {
    return AnimatedDefaultTextStyle(
      duration: duration,
      curve: curve,
      style: style.copyWith(
        fontSize: style.fontSize != null
            ? (style.fontSize! * (morphScale ?? 1.0))
            : null,
        color: morphColor ?? style.color,
      ),
      child: Text(text),
    );
  }
  
  // ============================================================================
  // SPRING ANIMATIONS
  // ============================================================================
  
  /// Create spring animation controller
  AnimationController createSpringController({
    required TickerProvider vsync,
    Duration duration = const Duration(milliseconds: 600),
  }) {
    return AnimationController(
      duration: duration,
      vsync: vsync,
    );
  }
  
  /// Create spring animation
  Animation<double> createSpringAnimation({
    required AnimationController controller,
    double begin = 0.0,
    double end = 1.0,
    Curve curve = Curves.elasticOut,
  }) {
    return Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(parent: controller, curve: curve),
    );
  }
  
  /// Create spring widget
  Widget createSpringWidget({
    required AnimationController controller,
    required Widget child,
    double begin = 0.0,
    double end = 1.0,
    Curve curve = Curves.elasticOut,
    Offset offset = const Offset(0, 0),
  }) {
    final animation = createSpringAnimation(
      controller: controller,
      begin: begin,
      end: end,
      curve: curve,
    );
    
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            offset.dx * (1 - animation.value),
            offset.dy * (1 - animation.value),
          ),
          child: Transform.scale(
            scale: animation.value,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
  
  // ============================================================================
  // PARALLAX ANIMATIONS
  // ============================================================================
  
  /// Create parallax scroll animation
  Widget createParallaxScroll({
    required Widget child,
    required ScrollController scrollController,
    double parallaxFactor = 0.5,
  }) {
    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, child) {
        final offset = scrollController.offset;
        return Transform.translate(
          offset: Offset(0, offset * parallaxFactor),
          child: child,
        );
      },
      child: child,
    );
  }
  
  /// Create parallax background
  Widget createParallaxBackground({
    required Widget background,
    required ScrollController scrollController,
    double parallaxFactor = 0.3,
  }) {
    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, child) {
        final offset = scrollController.offset;
        return Transform.translate(
          offset: Offset(0, offset * parallaxFactor),
          child: background,
        );
      },
    );
  }
  
  // ============================================================================
  // LOADING ANIMATIONS
  // ============================================================================
  
  /// Create shimmer loading animation
  Widget createShimmerLoading({
    required Widget child,
    Color? baseColor,
    Color? highlightColor,
    Duration duration = const Duration(milliseconds: 1500),
  }) {
    return _ShimmerLoading(
      baseColor: baseColor ?? DesignTokens.neutral200,
      highlightColor: highlightColor ?? DesignTokens.neutral100,
      duration: duration,
      child: child,
    );
  }
  
  /// Create pulse loading animation
  Widget createPulseLoading({
    required Widget child,
    Color? pulseColor,
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    return _PulseLoading(
      pulseColor: pulseColor ?? DesignTokens.primary,
      duration: duration,
      child: child,
    );
  }
  
  /// Create rotation loading animation
  Widget createRotationLoading({
    required Widget child,
    Duration duration = const Duration(milliseconds: 2000),
  }) {
    return _RotationLoading(
      duration: duration,
      child: child,
    );
  }
  
  // ============================================================================
  // GESTURE ANIMATIONS
  // ============================================================================
  
  /// Create drag animation
  Widget createDragAnimation({
    required Widget child,
    required VoidCallback onDragEnd,
    double maxDragDistance = 100.0,
    Color? dragColor,
  }) {
    return _DragAnimation(
      maxDragDistance: maxDragDistance,
      dragColor: dragColor ?? DesignTokens.primary,
      onDragEnd: onDragEnd,
      child: child,
    );
  }
  
  /// Create swipe animation
  Widget createSwipeAnimation({
    required Widget child,
    required VoidCallback onSwipeLeft,
    required VoidCallback onSwipeRight,
    double swipeThreshold = 50.0,
  }) {
    return _SwipeAnimation(
      swipeThreshold: swipeThreshold,
      onSwipeLeft: onSwipeLeft,
      onSwipeRight: onSwipeRight,
      child: child,
    );
  }
  
  /// Create pinch animation
  Widget createPinchAnimation({
    required Widget child,
    required VoidCallback onPinchIn,
    required VoidCallback onPinchOut,
    double pinchThreshold = 0.5,
  }) {
    return _PinchAnimation(
      pinchThreshold: pinchThreshold,
      onPinchIn: onPinchIn,
      onPinchOut: onPinchOut,
      child: child,
    );
  }
  
  // ============================================================================
  // PERFORMANCE OPTIMIZATION
  // ============================================================================
  
  /// Wrap widget with RepaintBoundary for performance
  Widget optimizePerformance(Widget child) {
    return RepaintBoundary(child: child);
  }
  
  /// Create lazy animation that only animates when needed
  Widget createLazyAnimation({
    required Widget child,
    required bool shouldAnimate,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    if (!shouldAnimate) return child;
    
    return AnimatedContainer(
      duration: duration,
      curve: curve,
      child: child,
    );
  }
  
  /// Create conditional animation
  Widget createConditionalAnimation({
    required Widget child,
    required bool condition,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
    Widget Function(Widget child)? builder,
  }) {
    if (!condition) return child;
    
    return AnimatedBuilder(
      animation: AlwaysStoppedAnimation(1.0),
      builder: (context, child) {
        return builder?.call(child ?? const SizedBox()) ?? child ?? const SizedBox();
      },
      child: child,
    );
  }
}

// ============================================================================
// PRIVATE ANIMATION WIDGETS
// ============================================================================

/// Shimmer loading animation widget
class _ShimmerLoading extends StatefulWidget {
  final Widget child;
  final Color baseColor;
  final Color highlightColor;
  final Duration duration;
  
  const _ShimmerLoading({
    required this.child,
    required this.baseColor,
    required this.highlightColor,
    required this.duration,
  });
  
  @override
  State<_ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<_ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
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
              ],
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }
}

/// Pulse loading animation widget
class _PulseLoading extends StatefulWidget {
  final Widget child;
  final Color pulseColor;
  final Duration duration;
  
  const _PulseLoading({
    required this.child,
    required this.pulseColor,
    required this.duration,
  });
  
  @override
  State<_PulseLoading> createState() => _PulseLoadingState();
}

class _PulseLoadingState extends State<_PulseLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat(reverse: true);
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: Container(
            decoration: BoxDecoration(
              color: widget.pulseColor.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: widget.child,
          ),
        );
      },
    );
  }
}

/// Rotation loading animation widget
class _RotationLoading extends StatefulWidget {
  final Widget child;
  final Duration duration;
  
  const _RotationLoading({
    required this.child,
    required this.duration,
  });
  
  @override
  State<_RotationLoading> createState() => _RotationLoadingState();
}

class _RotationLoadingState extends State<_RotationLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _controller.repeat();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * 3.14159,
          child: widget.child,
        );
      },
    );
  }
}

/// Drag animation widget
class _DragAnimation extends StatefulWidget {
  final Widget child;
  final double maxDragDistance;
  final Color dragColor;
  final VoidCallback onDragEnd;
  
  const _DragAnimation({
    required this.child,
    required this.maxDragDistance,
    required this.dragColor,
    required this.onDragEnd,
  });
  
  @override
  State<_DragAnimation> createState() => _DragAnimationState();
}

class _DragAnimationState extends State<_DragAnimation> {
  double _dragOffset = 0.0;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _dragOffset += details.delta.dx;
          _dragOffset = _dragOffset.clamp(-widget.maxDragDistance, widget.maxDragDistance);
        });
      },
      onPanEnd: (details) {
        if (_dragOffset.abs() > widget.maxDragDistance * 0.5) {
          widget.onDragEnd();
        }
        setState(() {
          _dragOffset = 0.0;
        });
      },
      child: Transform.translate(
        offset: Offset(_dragOffset, 0),
        child: Container(
          decoration: BoxDecoration(
            color: widget.dragColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

/// Swipe animation widget
class _SwipeAnimation extends StatefulWidget {
  final Widget child;
  final double swipeThreshold;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;
  
  const _SwipeAnimation({
    required this.child,
    required this.swipeThreshold,
    required this.onSwipeLeft,
    required this.onSwipeRight,
  });
  
  @override
  State<_SwipeAnimation> createState() => _SwipeAnimationState();
}

class _SwipeAnimationState extends State<_SwipeAnimation> {
  double _swipeOffset = 0.0;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _swipeOffset += details.delta.dx;
        });
      },
      onPanEnd: (details) {
        if (_swipeOffset > widget.swipeThreshold) {
          widget.onSwipeRight();
        } else if (_swipeOffset < -widget.swipeThreshold) {
          widget.onSwipeLeft();
        }
        setState(() {
          _swipeOffset = 0.0;
        });
      },
      child: Transform.translate(
        offset: Offset(_swipeOffset, 0),
        child: widget.child,
      ),
    );
  }
}

/// Pinch animation widget
class _PinchAnimation extends StatefulWidget {
  final Widget child;
  final double pinchThreshold;
  final VoidCallback onPinchIn;
  final VoidCallback onPinchOut;
  
  const _PinchAnimation({
    required this.child,
    required this.pinchThreshold,
    required this.onPinchIn,
    required this.onPinchOut,
  });
  
  @override
  State<_PinchAnimation> createState() => _PinchAnimationState();
}

class _PinchAnimationState extends State<_PinchAnimation> {
  double _scale = 1.0;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleUpdate: (details) {
        setState(() {
          _scale = details.scale;
        });
      },
      onScaleEnd: (details) {
        if (_scale < widget.pinchThreshold) {
          widget.onPinchIn();
        } else if (_scale > 1.0 + widget.pinchThreshold) {
          widget.onPinchOut();
        }
        setState(() {
          _scale = 1.0;
        });
      },
      child: Transform.scale(
        scale: _scale,
        child: widget.child,
      ),
    );
  }
}
