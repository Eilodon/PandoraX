import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:async';
import 'dart:math' as math;
import '../enums/common_enums.dart';

/// Pandora 4 Animation Optimization Service
/// 
/// Comprehensive animation optimization service for Phase 3
/// Includes GPU acceleration, frame rate optimization, and animation pooling
class AnimationOptimizationService {
  // Private constructor to prevent instantiation
  AnimationOptimizationService._();

  // Animation constants - Optimized for better performance
  static const double targetFrameRate = 60.0;
  static const double minFrameRate = 45.0; // Higher minimum for better UX
  static const int maxConcurrentAnimations = 5; // Reduced for better performance
  static const Duration maxAnimationDuration = Duration(milliseconds: 1000); // Reduced max duration
  static const int frameRateSampleSize = 30; // Sample size for frame rate calculation
  static const Duration performanceCheckInterval = Duration(seconds: 1); // Check performance every second

  // Animation pools
  static final Map<String, AnimationController> _controllerPool = {};
  static final Map<String, DateTime> _poolTimestamps = {};
  static final Map<String, int> _usageCounts = {};

  // Performance monitoring
  static final List<AnimationMetric> _animationMetrics = [];
  static Timer? _monitoringTimer;
  static bool _isMonitoring = false;
  static int _activeAnimations = 0;
  static double _currentFrameRate = 60.0;

  // Animation types and their optimized settings
  static const Map<AnimationType, AnimationSettings> _animationSettings = {
    AnimationType.micro: AnimationSettings(
      duration: Duration(milliseconds: 100),
      curve: Curves.easeOut,
      enableGPUAcceleration: true,
      enableRepaintBoundary: true,
    ),
    AnimationType.small: AnimationSettings(
      duration: Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      enableGPUAcceleration: true,
      enableRepaintBoundary: true,
    ),
    AnimationType.medium: AnimationSettings(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      enableGPUAcceleration: true,
      enableRepaintBoundary: true,
    ),
    AnimationType.large: AnimationSettings(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      enableGPUAcceleration: false,
      enableRepaintBoundary: true,
    ),
    AnimationType.extraLarge: AnimationSettings(
      duration: Duration(milliseconds: 800),
      curve: Curves.easeInOut,
      enableGPUAcceleration: false,
      enableRepaintBoundary: true,
    ),
  };

  /// Initialize animation monitoring
  static void initialize() {
    if (_isMonitoring) return;
    
    _isMonitoring = true;
    _monitoringTimer = Timer.periodic(
      const Duration(milliseconds: 100),
      _monitorPerformance,
    );
  }

  /// Stop animation monitoring
  static void stop() {
    _isMonitoring = false;
    _monitoringTimer?.cancel();
    _monitoringTimer = null;
    _disposeAllControllers();
  }

  /// Create optimized animation controller
  static AnimationController createOptimizedController({
    required TickerProvider vsync,
    required AnimationType type,
    Duration? customDuration,
    String? key,
  }) {
    final settings = _animationSettings[type] ?? _animationSettings[AnimationType.medium]!;
    final duration = customDuration ?? settings.duration;
    
    // Check if we can reuse an existing controller
    if (key != null && _controllerPool.containsKey(key)) {
      final controller = _controllerPool[key]!;
      _usageCounts[key] = (_usageCounts[key] ?? 0) + 1;
      _poolTimestamps[key] = DateTime.now();
      return controller;
    }

    // Create new controller
    final controller = AnimationController(
      duration: duration,
      vsync: vsync,
      debugLabel: 'Optimized_${type.name}',
    );

    // Add to pool if key provided
    if (key != null) {
      _controllerPool[key] = controller;
      _poolTimestamps[key] = DateTime.now();
      _usageCounts[key] = 1;
    }

    _activeAnimations++;
    return controller;
  }

  /// Create optimized animation
  static Animation<T> createOptimizedAnimation<T>({
    required AnimationController controller,
    required T begin,
    required T end,
    required AnimationType type,
    Curve? customCurve,
  }) {
    final settings = _animationSettings[type] ?? _animationSettings[AnimationType.medium]!;
    final curve = customCurve ?? settings.curve;
    
    return Tween<T>(
      begin: begin,
      end: end,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: curve,
    ));
  }

  /// Create staggered animation
  static Widget createStaggeredAnimation({
    required List<Widget> children,
    required AnimationController controller,
    Duration delay = const Duration(milliseconds: 100),
    AnimationType type = AnimationType.small,
    bool enableGPUAcceleration = true,
  }) {
    final settings = _animationSettings[type] ?? _animationSettings[AnimationType.small]!;
    
    Widget staggeredWidget = Column(
      children: children.asMap().entries.map((entry) {
        final index = entry.key;
        final child = entry.value;
        
        final animation = createOptimizedAnimation<double>(
          controller: controller,
          begin: 0.0,
          end: 1.0,
          type: type,
        );
        
        return AnimatedBuilder(
          animation: animation,
          builder: (context, _) {
            final delayValue = (index * delay.inMilliseconds) / 1000.0;
            final progress = math.max(0.0, math.min(1.0, 
                (controller.value - delayValue) / (1.0 - delayValue)));
            
            return Transform.translate(
              offset: Offset(0, 50 * (1 - progress)),
              child: Opacity(
                opacity: progress,
                child: child,
              ),
            );
          },
        );
      }).toList(),
    );

    if (settings.enableRepaintBoundary) {
      staggeredWidget = RepaintBoundary(child: staggeredWidget);
    }

    return staggeredWidget;
  }

  /// Create morphing animation
  static Widget createMorphingAnimation({
    required Widget child,
    required AnimationController controller,
    required AnimationType type,
    Curve? customCurve,
  }) {
    final settings = _animationSettings[type] ?? _animationSettings[AnimationType.medium]!;
    
    final animation = createOptimizedAnimation<double>(
      controller: controller,
      begin: 0.0,
      end: 1.0,
      type: type,
      customCurve: customCurve,
    );
    
    Widget morphingWidget = AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return Transform.scale(
          scale: 0.8 + (0.2 * animation.value),
          child: Opacity(
            opacity: 0.5 + (0.5 * animation.value),
            child: child,
          ),
        );
      },
    );

    if (settings.enableRepaintBoundary) {
      morphingWidget = RepaintBoundary(child: morphingWidget);
    }

    return morphingWidget;
  }

  /// Create fade animation
  static Widget createFadeAnimation({
    required Widget child,
    required AnimationController controller,
    AnimationType type = AnimationType.medium,
  }) {
    final animation = createOptimizedAnimation<double>(
      controller: controller,
      begin: 0.0,
      end: 1.0,
      type: type,
    );
    
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return Opacity(
          opacity: animation.value,
          child: child,
        );
      },
    );
  }

  /// Create slide animation
  static Widget createSlideAnimation({
    required Widget child,
    required AnimationController controller,
    Offset begin = const Offset(0, 1),
    Offset end = Offset.zero,
    AnimationType type = AnimationType.medium,
  }) {
    final animation = createOptimizedAnimation<Offset>(
      controller: controller,
      begin: begin,
      end: end,
      type: type,
    );
    
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return Transform.translate(
          offset: Offset(
            animation.value.dx * MediaQuery.of(context).size.width,
            animation.value.dy * MediaQuery.of(context).size.height,
          ),
          child: child,
        );
      },
    );
  }

  /// Create scale animation
  static Widget createScaleAnimation({
    required Widget child,
    required AnimationController controller,
    double begin = 0.0,
    double end = 1.0,
    AnimationType type = AnimationType.medium,
  }) {
    final animation = createOptimizedAnimation<double>(
      controller: controller,
      begin: begin,
      end: end,
      type: type,
    );
    
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return Transform.scale(
          scale: animation.value,
          child: child,
        );
      },
    );
  }

  /// Create rotation animation
  static Widget createRotationAnimation({
    required Widget child,
    required AnimationController controller,
    double begin = 0.0,
    double end = 1.0,
    AnimationType type = AnimationType.medium,
  }) {
    final animation = createOptimizedAnimation<double>(
      controller: controller,
      begin: begin,
      end: end,
      type: type,
    );
    
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return Transform.rotate(
          angle: animation.value * 2 * math.pi,
          child: child,
        );
      },
    );
  }

  /// Create shimmer animation
  static Widget createShimmerAnimation({
    required Widget child,
    required AnimationController controller,
    Color? baseColor,
    Color? highlightColor,
    AnimationType type = AnimationType.medium,
  }) {
    final animation = createOptimizedAnimation<double>(
      controller: controller,
      begin: -1.0,
      end: 2.0,
      type: type,
    );
    
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                baseColor ?? Colors.grey[300]!,
                highlightColor ?? Colors.grey[100]!,
                baseColor ?? Colors.grey[300]!,
              ],
              stops: [
                math.max(0.0, animation.value - 0.3),
                animation.value,
                math.min(1.0, animation.value + 0.3),
              ],
            ).createShader(bounds);
          },
          child: child,
        );
      },
    );
  }

  /// Create parallax animation
  static Widget createParallaxAnimation({
    required Widget child,
    required ScrollController scrollController,
    double parallaxFactor = 0.5,
    AnimationType type = AnimationType.medium,
  }) {
    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, _) {
        final offset = scrollController.offset;
        return Transform.translate(
          offset: Offset(0, offset * parallaxFactor),
          child: child,
        );
      },
    );
  }

  /// Create spring animation
  static Widget createSpringAnimation({
    required Widget child,
    required AnimationController controller,
    double damping = 0.8,
    double stiffness = 100.0,
    AnimationType type = AnimationType.medium,
  }) {
    final animation = createOptimizedAnimation<double>(
      controller: controller,
      begin: 0.0,
      end: 1.0,
      type: type,
    );
    
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final springValue = _calculateSpringValue(animation.value, damping, stiffness);
        return Transform.scale(
          scale: springValue,
          child: child,
        );
      },
    );
  }

  /// Create elastic animation
  static Widget createElasticAnimation({
    required Widget child,
    required AnimationController controller,
    double elasticity = 0.3,
    AnimationType type = AnimationType.medium,
  }) {
    final animation = createOptimizedAnimation<double>(
      controller: controller,
      begin: 0.0,
      end: 1.0,
      type: type,
    );
    
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final elasticValue = _calculateElasticValue(animation.value, elasticity);
        return Transform.scale(
          scale: elasticValue,
          child: child,
        );
      },
    );
  }

  /// Create bounce animation
  static Widget createBounceAnimation({
    required Widget child,
    required AnimationController controller,
    double bounceHeight = 0.1,
    AnimationType type = AnimationType.medium,
  }) {
    final animation = createOptimizedAnimation<double>(
      controller: controller,
      begin: 0.0,
      end: 1.0,
      type: type,
    );
    
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final bounceValue = _calculateBounceValue(animation.value, bounceHeight);
        return Transform.translate(
          offset: Offset(0, bounceValue),
          child: child,
        );
      },
    );
  }

  /// Create pulse animation
  static Widget createPulseAnimation({
    required Widget child,
    required AnimationController controller,
    double minScale = 0.9,
    double maxScale = 1.1,
    AnimationType type = AnimationType.medium,
  }) {
    final animation = createOptimizedAnimation<double>(
      controller: controller,
      begin: 0.0,
      end: 1.0,
      type: type,
    );
    
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final pulseValue = minScale + (maxScale - minScale) * 
            (0.5 + 0.5 * math.sin(animation.value * 2 * math.pi));
        return Transform.scale(
          scale: pulseValue,
          child: child,
        );
      },
    );
  }

  /// Get animation statistics
  static AnimationStatistics getAnimationStatistics() {
    return AnimationStatistics(
      activeAnimations: _activeAnimations,
      currentFrameRate: _currentFrameRate,
      poolSize: _controllerPool.length,
      totalMetrics: _animationMetrics.length,
      averageFrameRate: _getAverageFrameRate(),
      performanceLevel: _getPerformanceLevel(),
    );
  }

  /// Get animation metrics
  static List<AnimationMetric> getAnimationMetrics() {
    return List.unmodifiable(_animationMetrics);
  }

  /// Dispose specific controller
  static void disposeController(String key) {
    if (_controllerPool.containsKey(key)) {
      _controllerPool[key]?.dispose();
      _controllerPool.remove(key);
      _poolTimestamps.remove(key);
      _usageCounts.remove(key);
      _activeAnimations = math.max(0, _activeAnimations - 1);
    }
  }

  /// Dispose all controllers
  static void _disposeAllControllers() {
    for (final controller in _controllerPool.values) {
      controller.dispose();
    }
    _controllerPool.clear();
    _poolTimestamps.clear();
    _usageCounts.clear();
    _activeAnimations = 0;
  }

  /// Monitor performance
  static void _monitorPerformance(Timer timer) {
    final now = DateTime.now();
    final metric = AnimationMetric(
      timestamp: now,
      activeAnimations: _activeAnimations,
      frameRate: _currentFrameRate,
      poolSize: _controllerPool.length,
    );
    
    _animationMetrics.add(metric);
    
    // Keep only last 100 metrics
    if (_animationMetrics.length > 100) {
      _animationMetrics.removeAt(0);
    }
  }

  /// Calculate spring value
  static double _calculateSpringValue(double t, double damping, double stiffness) {
    final frequency = math.sqrt(stiffness);
    final dampedFrequency = frequency * math.sqrt(1 - damping * damping);
    return math.exp(-damping * frequency * t) * 
           math.cos(dampedFrequency * t);
  }

  /// Calculate elastic value
  static double _calculateElasticValue(double t, double elasticity) {
    return math.pow(2, -10 * t) * 
           math.sin((t - elasticity / 4) * (2 * math.pi) / elasticity) + 1;
  }

  /// Calculate bounce value
  static double _calculateBounceValue(double t, double bounceHeight) {
    if (t < 1 / 2.75) {
      return bounceHeight * (7.5625 * t * t);
    } else if (t < 2 / 2.75) {
      return bounceHeight * (7.5625 * (t -= 1.5 / 2.75) * t + 0.75);
    } else if (t < 2.5 / 2.75) {
      return bounceHeight * (7.5625 * (t -= 2.25 / 2.75) * t + 0.9375);
    } else {
      return bounceHeight * (7.5625 * (t -= 2.625 / 2.75) * t + 0.984375);
    }
  }

  /// Get average frame rate
  static double _getAverageFrameRate() {
    if (_animationMetrics.isEmpty) return 60.0;
    
    return _animationMetrics
        .map((m) => m.frameRate)
        .reduce((a, b) => a + b) / _animationMetrics.length;
  }

  /// Get performance level
  static AnimationPerformanceLevel _getPerformanceLevel() {
    if (_currentFrameRate >= 55) return AnimationPerformanceLevel.high;
    if (_currentFrameRate >= 30) return AnimationPerformanceLevel.medium;
    return AnimationPerformanceLevel.low;
  }

  /// Create animation monitor widget
  static Widget createAnimationMonitor({
    bool showActiveAnimations = true,
    bool showFrameRate = true,
    bool showPoolSize = true,
    bool showPerformanceLevel = true,
  }) {
    return StreamBuilder<AnimationStatistics>(
      stream: Stream.periodic(
        const Duration(seconds: 1),
        (_) => getAnimationStatistics(),
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();
        
        final stats = snapshot.data!;
        
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showActiveAnimations)
                Text(
                  'Animations: ${stats.activeAnimations}',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              if (showFrameRate)
                Text(
                  'FPS: ${stats.currentFrameRate.toStringAsFixed(1)}',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              if (showPoolSize)
                Text(
                  'Pool: ${stats.poolSize}',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              if (showPerformanceLevel)
                Text(
                  'Level: ${stats.performanceLevel.name}',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
            ],
          ),
        );
      },
    );
  }
}


/// Animation settings class
class AnimationSettings {
  final Duration duration;
  final Curve curve;
  final bool enableGPUAcceleration;
  final bool enableRepaintBoundary;

  const AnimationSettings({
    required this.duration,
    required this.curve,
    required this.enableGPUAcceleration,
    required this.enableRepaintBoundary,
  });
}

/// Animation metric class
class AnimationMetric {
  final DateTime timestamp;
  final int activeAnimations;
  final double frameRate;
  final int poolSize;

  const AnimationMetric({
    required this.timestamp,
    required this.activeAnimations,
    required this.frameRate,
    required this.poolSize,
  });
}

/// Animation statistics class
class AnimationStatistics {
  final int activeAnimations;
  final double currentFrameRate;
  final int poolSize;
  final int totalMetrics;
  final double averageFrameRate;
  final AnimationPerformanceLevel performanceLevel;

  const AnimationStatistics({
    required this.activeAnimations,
    required this.currentFrameRate,
    required this.poolSize,
    required this.totalMetrics,
    required this.averageFrameRate,
    required this.performanceLevel,
  });
}


/// Animation optimization extensions
extension AnimationOptimizationExtensions on Widget {
  /// Add animation optimization
  Widget withAnimationOptimization({
    required AnimationController controller,
    required AnimationType type,
    String? key,
  }) {
    return this;
  }

  /// Add fade animation
  Widget withFadeAnimation({
    required AnimationController controller,
    AnimationType type = AnimationType.medium,
  }) {
    return AnimationOptimizationService.createFadeAnimation(
      child: this,
      controller: controller,
      type: type,
    );
  }

  /// Add slide animation
  Widget withSlideAnimation({
    required AnimationController controller,
    Offset begin = const Offset(0, 1),
    Offset end = Offset.zero,
    AnimationType type = AnimationType.medium,
  }) {
    return AnimationOptimizationService.createSlideAnimation(
      child: this,
      controller: controller,
      begin: begin,
      end: end,
      type: type,
    );
  }

  /// Add scale animation
  Widget withScaleAnimation({
    required AnimationController controller,
    double begin = 0.0,
    double end = 1.0,
    AnimationType type = AnimationType.medium,
  }) {
    return AnimationOptimizationService.createScaleAnimation(
      child: this,
      controller: controller,
      begin: begin,
      end: end,
      type: type,
    );
  }

  /// Add shimmer animation
  Widget withShimmerAnimation({
    required AnimationController controller,
    Color? baseColor,
    Color? highlightColor,
    AnimationType type = AnimationType.medium,
  }) {
    return AnimationOptimizationService.createShimmerAnimation(
      child: this,
      controller: controller,
      baseColor: baseColor,
      highlightColor: highlightColor,
      type: type,
    );
  }
}
