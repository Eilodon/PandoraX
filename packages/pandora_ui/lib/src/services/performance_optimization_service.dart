import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:async';
import 'dart:math' as math;
import '../enums/common_enums.dart';

/// Pandora 4 Performance Optimization Service
/// 
/// Comprehensive performance optimization service for Phase 3
/// Includes animation optimization, memory management, and rendering optimization
class PerformanceOptimizationService {
  // Private constructor to prevent instantiation
  PerformanceOptimizationService._();

  // Performance constants - Optimized for better performance
  static const int maxWidgetsPerScreen = 50; // Reduced for better performance
  static const int maxAnimationDuration = 300; // Reduced for snappier feel
  static const int maxCacheSize = 100; // Increased for better caching
  static const double targetFrameRate = 60.0;
  static const int memoryWarningThreshold = 80; // MB - More conservative
  static const int maxConcurrentAnimations = 3; // Limit concurrent animations
  static const int debounceDelay = 16; // ~60fps debounce

  // Animation optimization - Optimized for better performance
  static const Map<AnimationType, Duration> optimizedDurations = {
    AnimationType.micro: Duration(milliseconds: 80), // Faster micro animations
    AnimationType.small: Duration(milliseconds: 150), // Snappier small animations
    AnimationType.medium: Duration(milliseconds: 250), // Balanced medium animations
    AnimationType.large: Duration(milliseconds: 350), // Reduced large animations
    AnimationType.extraLarge: Duration(milliseconds: 500), // Significantly reduced
  };

  // Memory management
  static final Map<String, Widget> _widgetCache = {};
  static final Map<String, DateTime> _cacheTimestamps = {};
  static final Map<String, int> _accessCounts = {};

  // Performance monitoring
  static final List<PerformanceMetric> _performanceMetrics = [];
  static Timer? _performanceTimer;
  static bool _isMonitoring = false;

  /// Initialize performance monitoring
  static void initializePerformanceMonitoring() {
    if (_isMonitoring) return;
    
    _isMonitoring = true;
    _performanceTimer = Timer.periodic(
      const Duration(seconds: 1),
      _collectPerformanceMetrics,
    );
  }

  /// Stop performance monitoring
  static void stopPerformanceMonitoring() {
    _isMonitoring = false;
    _performanceTimer?.cancel();
    _performanceTimer = null;
  }

  /// Get optimized animation duration
  static Duration getOptimizedDuration(
    AnimationType type, {
    PerformanceLevel? level,
  }) {
    final effectiveLevel = level ?? _getCurrentPerformanceLevel();
    final baseDuration = optimizedDurations[type] ?? const Duration(milliseconds: 300);
    
    switch (effectiveLevel) {
      case PerformanceLevel.high:
        return Duration(milliseconds: (baseDuration.inMilliseconds * 0.8).round());
      case PerformanceLevel.medium:
        return baseDuration;
      case PerformanceLevel.low:
        return Duration(milliseconds: (baseDuration.inMilliseconds * 1.2).round());
    }
  }

  /// Get optimized animation curve
  static Curve getOptimizedCurve(AnimationType type) {
    switch (type) {
      case AnimationType.micro:
        return Curves.easeOut;
      case AnimationType.small:
        return Curves.easeOutCubic;
      case AnimationType.medium:
        return Curves.easeInOutCubic;
      case AnimationType.large:
        return Curves.easeInOut;
      case AnimationType.extraLarge:
        return Curves.easeInOut;
    }
  }

  /// Create optimized animation controller
  static AnimationController createOptimizedController(
    TickerProvider vsync, {
    required AnimationType type,
    PerformanceLevel? level,
  }) {
    final duration = getOptimizedDuration(type, level: level);
    return AnimationController(
      duration: duration,
      vsync: vsync,
      debugLabel: 'Optimized_${type.name}',
    );
  }

  /// Create optimized animation
  static Animation<T> createOptimizedAnimation<T>({
    required AnimationController controller,
    required T begin,
    required T end,
    required AnimationType type,
    Curve? customCurve,
  }) {
    return Tween<T>(
      begin: begin,
      end: end,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: customCurve ?? getOptimizedCurve(type),
    ));
  }

  /// Create repaint boundary for complex widgets
  static Widget createRepaintBoundary({
    required Widget child,
    String? key,
  }) {
    return RepaintBoundary(
      key: key != null ? Key('repaint_$key') : null,
      child: child,
    );
  }

  /// Create lazy loading widget
  static Widget createLazyWidget({
    required Widget child,
    required bool isVisible,
    Duration? delay,
  }) {
    if (isVisible) {
      return child;
    }
    
    return FutureBuilder<bool>(
      future: Future.delayed(delay ?? const Duration(milliseconds: 100), () => true),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data == true) {
          return child;
        }
        return const SizedBox.shrink();
      },
    );
  }

  /// Create virtualized list
  static Widget createVirtualizedList({
    required List<Widget> children,
    required double itemHeight,
    required double viewportHeight,
    ScrollController? controller,
  }) {
    return ListView.builder(
      controller: controller,
      itemCount: children.length,
      itemExtent: itemHeight,
      cacheExtent: viewportHeight * 0.5, // Cache 50% of viewport
      itemBuilder: (context, index) {
        return RepaintBoundary(
          child: children[index],
        );
      },
    );
  }

  /// Create cached widget
  static Widget createCachedWidget({
    required String key,
    required Widget Function() builder,
    Duration? cacheDuration,
  }) {
    final now = DateTime.now();
    final cacheKey = 'cached_$key';
    
    // Check if widget is in cache and not expired
    if (_widgetCache.containsKey(cacheKey) && 
        _cacheTimestamps.containsKey(cacheKey)) {
      final cacheTime = _cacheTimestamps[cacheKey]!;
      final duration = cacheDuration ?? const Duration(minutes: 5);
      
      if (now.difference(cacheTime) < duration) {
        _accessCounts[cacheKey] = (_accessCounts[cacheKey] ?? 0) + 1;
        return _widgetCache[cacheKey]!;
      }
    }
    
    // Create new widget and cache it
    final widget = builder();
    _widgetCache[cacheKey] = widget;
    _cacheTimestamps[cacheKey] = now;
    _accessCounts[cacheKey] = 1;
    
    // Clean up old cache entries if needed
    _cleanupCache();
    
    return widget;
  }

  /// Create memory-efficient image
  static Widget createOptimizedImage({
    required String imagePath,
    required double width,
    required double height,
    BoxFit fit = BoxFit.cover,
    bool enableCaching = true,
  }) {
    if (enableCaching) {
      return createCachedWidget(
        key: 'image_${imagePath}_${width}_${height}',
        builder: () => Image.asset(
          imagePath,
          width: width,
          height: height,
          fit: fit,
          cacheWidth: width.toInt(),
          cacheHeight: height.toInt(),
        ),
      );
    }
    
    return Image.asset(
      imagePath,
      width: width,
      height: height,
      fit: fit,
      cacheWidth: width.toInt(),
      cacheHeight: height.toInt(),
    );
  }

  /// Create optimized container
  static Widget createOptimizedContainer({
    required Widget child,
    Color? color,
    EdgeInsets? padding,
    EdgeInsets? margin,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
    bool enableRepaintBoundary = true,
  }) {
    Widget container = Container(
      color: color,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: boxShadow,
      ),
      child: child,
    );
    
    if (enableRepaintBoundary) {
      container = RepaintBoundary(child: container);
    }
    
    return container;
  }

  /// Create staggered animation
  static Widget createStaggeredAnimation({
    required List<Widget> children,
    required AnimationController controller,
    Duration delay = const Duration(milliseconds: 100),
    AnimationType type = AnimationType.small,
  }) {
    return Column(
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
  }

  /// Create morphing animation
  static Widget createMorphingAnimation({
    required Widget child,
    required AnimationController controller,
    required AnimationType type,
    Curve? customCurve,
  }) {
    final animation = createOptimizedAnimation<double>(
      controller: controller,
      begin: 0.0,
      end: 1.0,
      type: type,
      customCurve: customCurve,
    );
    
    return AnimatedBuilder(
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
  }

  /// Create parallax effect
  static Widget createParallaxEffect({
    required Widget child,
    required ScrollController scrollController,
    double parallaxFactor = 0.5,
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

  /// Create shimmer effect
  static Widget createShimmerEffect({
    required Widget child,
    required AnimationController controller,
    Color? baseColor,
    Color? highlightColor,
  }) {
    final animation = createOptimizedAnimation<double>(
      controller: controller,
      begin: -1.0,
      end: 2.0,
      type: AnimationType.medium,
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

  /// Get current performance level
  static PerformanceLevel _getCurrentPerformanceLevel() {
    // This would be determined based on device capabilities
    // For now, return medium as default
    return PerformanceLevel.medium;
  }

  /// Clean up cache
  static void _cleanupCache() {
    if (_widgetCache.length <= maxCacheSize) return;
    
    // Remove least recently used items
    final sortedKeys = _cacheTimestamps.keys.toList()
      ..sort((a, b) => _cacheTimestamps[a]!.compareTo(_cacheTimestamps[b]!));
    
    final itemsToRemove = sortedKeys.take(_widgetCache.length - maxCacheSize);
    for (final key in itemsToRemove) {
      _widgetCache.remove(key);
      _cacheTimestamps.remove(key);
      _accessCounts.remove(key);
    }
  }

  /// Collect performance metrics
  static void _collectPerformanceMetrics(Timer timer) {
    final now = DateTime.now();
    final metric = PerformanceMetric(
      timestamp: now,
      memoryUsage: _getMemoryUsage(),
      frameRate: _getFrameRate(),
      cacheSize: _widgetCache.length,
      cacheHitRate: _getCacheHitRate(),
    );
    
    _performanceMetrics.add(metric);
    
    // Keep only last 100 metrics
    if (_performanceMetrics.length > 100) {
      _performanceMetrics.removeAt(0);
    }
  }

  /// Get memory usage (simplified)
  static double _getMemoryUsage() {
    // This would be implemented with actual memory monitoring
    return 50.0; // MB
  }

  /// Get frame rate (simplified)
  static double _getFrameRate() {
    // This would be implemented with actual frame rate monitoring
    return 60.0; // FPS
  }

  /// Get cache hit rate
  static double _getCacheHitRate() {
    if (_accessCounts.isEmpty) return 0.0;
    
    final totalAccesses = _accessCounts.values.fold(0, (a, b) => a + b);
    final cacheHits = _widgetCache.length;
    
    return cacheHits / totalAccesses;
  }

  /// Get performance metrics
  static List<PerformanceMetric> getPerformanceMetrics() {
    return List.unmodifiable(_performanceMetrics);
  }

  /// Get performance summary
  static PerformanceSummary getPerformanceSummary() {
    if (_performanceMetrics.isEmpty) {
      return PerformanceSummary(
        averageMemoryUsage: 0.0,
        averageFrameRate: 0.0,
        cacheHitRate: 0.0,
        totalCacheSize: 0,
        performanceLevel: PerformanceLevel.medium,
      );
    }
    
    final avgMemory = _performanceMetrics
        .map((m) => m.memoryUsage)
        .reduce((a, b) => a + b) / _performanceMetrics.length;
    
    final avgFrameRate = _performanceMetrics
        .map((m) => m.frameRate)
        .reduce((a, b) => a + b) / _performanceMetrics.length;
    
    return PerformanceSummary(
      averageMemoryUsage: avgMemory,
      averageFrameRate: avgFrameRate,
      cacheHitRate: _getCacheHitRate(),
      totalCacheSize: _widgetCache.length,
      performanceLevel: _getCurrentPerformanceLevel(),
    );
  }

  /// Clear all caches
  static void clearAllCaches() {
    _widgetCache.clear();
    _cacheTimestamps.clear();
    _accessCounts.clear();
  }

  /// Optimize widget tree
  static Widget optimizeWidgetTree(Widget widget) {
    return RepaintBoundary(
      child: widget,
    );
  }

  /// Create performance monitor widget
  static Widget createPerformanceMonitor({
    bool showMetrics = true,
    bool showFPS = true,
    bool showMemory = true,
    bool showCache = true,
  }) {
    return StreamBuilder<PerformanceSummary>(
      stream: Stream.periodic(
        const Duration(seconds: 1),
        (_) => getPerformanceSummary(),
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();
        
        final summary = snapshot.data!;
        
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
              if (showFPS)
                Text(
                  'FPS: ${summary.averageFrameRate.toStringAsFixed(1)}',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              if (showMemory)
                Text(
                  'Memory: ${summary.averageMemoryUsage.toStringAsFixed(1)}MB',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              if (showCache)
                Text(
                  'Cache: ${summary.totalCacheSize}/${summary.cacheHitRate.toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              if (showMetrics)
                Text(
                  'Level: ${summary.performanceLevel.name}',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
            ],
          ),
        );
      },
    );
  }
}



/// Performance metric class
class PerformanceMetric {
  final DateTime timestamp;
  final double memoryUsage;
  final double frameRate;
  final int cacheSize;
  final double cacheHitRate;

  const PerformanceMetric({
    required this.timestamp,
    required this.memoryUsage,
    required this.frameRate,
    required this.cacheSize,
    required this.cacheHitRate,
  });
}

/// Performance summary class
class PerformanceSummary {
  final double averageMemoryUsage;
  final double averageFrameRate;
  final double cacheHitRate;
  final int totalCacheSize;
  final PerformanceLevel performanceLevel;

  const PerformanceSummary({
    required this.averageMemoryUsage,
    required this.averageFrameRate,
    required this.cacheHitRate,
    required this.totalCacheSize,
    required this.performanceLevel,
  });
}

/// Performance optimization extensions
extension PerformanceOptimizationExtensions on Widget {
  /// Optimize widget for performance
  Widget withPerformanceOptimization({
    bool enableRepaintBoundary = true,
    bool enableCaching = false,
    String? cacheKey,
    Duration? cacheDuration,
  }) {
    Widget optimized = this;
    
    if (enableRepaintBoundary) {
      optimized = RepaintBoundary(child: optimized);
    }
    
    if (enableCaching && cacheKey != null) {
      optimized = PerformanceOptimizationService.createCachedWidget(
        key: cacheKey,
        builder: () => this,
        cacheDuration: cacheDuration,
      );
    }
    
    return optimized;
  }

  /// Add shimmer effect
  Widget withShimmerEffect({
    required AnimationController controller,
    Color? baseColor,
    Color? highlightColor,
  }) {
    return PerformanceOptimizationService.createShimmerEffect(
      child: this,
      controller: controller,
      baseColor: baseColor,
      highlightColor: highlightColor,
    );
  }

  /// Add parallax effect
  Widget withParallaxEffect({
    required ScrollController scrollController,
    double parallaxFactor = 0.5,
  }) {
    return PerformanceOptimizationService.createParallaxEffect(
      child: this,
      scrollController: scrollController,
      parallaxFactor: parallaxFactor,
    );
  }
}
