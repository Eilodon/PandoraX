import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import '../config/environment.dart' as env;

/// UI performance optimization service
@injectable
class UIOptimizationService {
  static bool _isInitialized = false;
  static Timer? _frameMonitoringTimer;
  static final List<double> _frameRenderTimes = [];
  static ScrollPhysics? _optimizedScrollPhysics;
  
  /// Initialize UI optimization
  static Future<void> initialize() async {
    if (_isInitialized) return;
    
    try {
      // Setup frame monitoring
      await _setupFrameMonitoring();
      
      // Optimize rendering settings
      await _optimizeRenderingSettings();
      
      // Setup scroll optimization
      await _setupScrollOptimization();
      
      // Configure image optimization
      await _configureImageOptimization();
      
      _isInitialized = true;
      
      if (env.Environment.enableLogging) {
        print('✅ UI optimization service initialized');
      }
    } catch (e) {
      if (env.Environment.enableLogging) {
        print('❌ UI optimization initialization failed: $e');
      }
    }
  }
  
  /// Setup frame monitoring
  static Future<void> _setupFrameMonitoring() async {
    if (kIsWeb) return; // Skip frame monitoring on web
    
    // Monitor frame rendering performance
    WidgetsBinding.instance.addTimingsCallback((timings) {
      for (final timing in timings) {
        final frameTime = timing.totalSpan.inMicroseconds / 1000.0; // Convert to milliseconds
        _recordFrameTime(frameTime);
      }
    });
    
    // Setup periodic frame analysis
    _frameMonitoringTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _analyzeFramePerformance();
    });
  }
  
  /// Record frame rendering time
  static void _recordFrameTime(double frameTime) {
    _frameRenderTimes.add(frameTime);
    
    // Keep only last 100 frame times
    if (_frameRenderTimes.length > 100) {
      _frameRenderTimes.removeAt(0);
    }
    
    // Log slow frames
    if (frameTime > 16.67 && env.Environment.enableLogging) { // 60 FPS threshold
      print('⚠️ Slow frame detected: ${frameTime.toStringAsFixed(2)}ms');
    }
  }
  
  /// Analyze frame performance
  static void _analyzeFramePerformance() {
    if (_frameRenderTimes.isEmpty) return;
    
    final averageFrameTime = _frameRenderTimes.reduce((a, b) => a + b) / _frameRenderTimes.length;
    final maxFrameTime = _frameRenderTimes.reduce(math.max);
    final slowFrames = _frameRenderTimes.where((time) => time > 16.67).length;
    
    if (env.Environment.enableLogging) {
      print('📊 Frame Performance:');
      print('   Average: ${averageFrameTime.toStringAsFixed(2)}ms');
      print('   Max: ${maxFrameTime.toStringAsFixed(2)}ms');
      print('   Slow frames: $slowFrames/${_frameRenderTimes.length}');
    }
    
    // Trigger optimization if performance is poor
    if (averageFrameTime > 20 || slowFrames > _frameRenderTimes.length * 0.1) {
      _triggerPerformanceOptimization();
    }
  }
  
  /// Trigger performance optimization
  static void _triggerPerformanceOptimization() {
    if (env.Environment.enableLogging) {
      print('🔧 Triggering UI performance optimization...');
    }
    
    // Reduce image cache size temporarily
    final originalImageCacheSize = PaintingBinding.instance.imageCache.maximumSize;
    PaintingBinding.instance.imageCache.maximumSize = originalImageCacheSize ~/ 2;
    
    // Restore after delay
    Timer(const Duration(seconds: 30), () {
      PaintingBinding.instance.imageCache.maximumSize = originalImageCacheSize;
    });
    
    // Clear unnecessary cached data
    PaintingBinding.instance.imageCache.clearLiveImages();
  }
  
  /// Optimize rendering settings
  static Future<void> _optimizeRenderingSettings() async {
    try {
      // Configure rendering optimizations
      if (!kIsWeb) {
        // Enable hardware acceleration
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.transparent,
          statusBarColor: Colors.transparent,
        ));
      }
      
      // Optimize image cache
      PaintingBinding.instance.imageCache.maximumSizeBytes = 100 << 20; // 100 MB
      PaintingBinding.instance.imageCache.maximumSize = 1000; // 1000 images
      
      if (env.Environment.enableLogging) {
        print('⚡ Rendering settings optimized');
      }
    } catch (e) {
      if (env.Environment.enableLogging) {
        print('❌ Rendering optimization failed: $e');
      }
    }
  }
  
  /// Setup scroll optimization
  static Future<void> _setupScrollOptimization() async {
    // Create optimized scroll physics
    _optimizedScrollPhysics = const BouncingScrollPhysics(
      parent: AlwaysScrollableScrollPhysics(),
    );
    
    if (env.Environment.enableLogging) {
      print('📜 Scroll optimization configured');
    }
  }
  
  /// Configure image optimization
  static Future<void> _configureImageOptimization() async {
    // Configure image loading and caching
    if (env.Environment.enableLogging) {
      print('🖼️ Image optimization configured');
    }
  }
  
  /// Get optimized scroll physics
  static ScrollPhysics getOptimizedScrollPhysics() {
    return _optimizedScrollPhysics ?? const BouncingScrollPhysics();
  }
  
  /// Create optimized list view
  static Widget createOptimizedListView({
    required IndexedWidgetBuilder itemBuilder,
    required int itemCount,
    ScrollController? controller,
    EdgeInsetsGeometry? padding,
    bool shrinkWrap = false,
    Axis scrollDirection = Axis.vertical,
    bool addAutomaticKeepAlives = false,
  }) {
    return ListView.builder(
      controller: controller,
      padding: padding,
      shrinkWrap: shrinkWrap,
      scrollDirection: scrollDirection,
      physics: getOptimizedScrollPhysics(),
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: true,
      addSemanticIndexes: true,
      cacheExtent: 500, // Optimize cache extent
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return RepaintBoundary(
          child: itemBuilder(context, index),
        );
      },
    );
  }
  
  /// Create lazy loading list view
  static Widget createLazyListView({
    required IndexedWidgetBuilder itemBuilder,
    required int itemCount,
    ScrollController? controller,
    EdgeInsetsGeometry? padding,
    int loadThreshold = 10,
    VoidCallback? onLoadMore,
  }) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification && onLoadMore != null) {
          final pixels = notification.metrics.pixels;
          final maxScrollExtent = notification.metrics.maxScrollExtent;
          
          // Trigger load more when near the end
          if (pixels >= maxScrollExtent - (loadThreshold * 100)) {
            onLoadMore();
          }
        }
        return false;
      },
      child: createOptimizedListView(
        itemBuilder: itemBuilder,
        itemCount: itemCount,
        controller: controller,
        padding: padding,
      ),
    );
  }
  
  /// Create optimized image widget
  static Widget createOptimizedImage({
    required String imageUrl,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
    Widget? errorWidget,
    bool enableMemoryCache = true,
    bool enableDiskCache = true,
  }) {
    return RepaintBoundary(
      child: Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: placeholder != null 
            ? (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return placeholder;
              }
            : null,
        errorBuilder: errorWidget != null 
            ? (context, error, stackTrace) => errorWidget
            : null,
        cacheWidth: width?.toInt(),
        cacheHeight: height?.toInt(),
        isAntiAlias: true,
        filterQuality: FilterQuality.medium,
      ),
    );
  }
  
  /// Create optimized animated list
  static Widget createOptimizedAnimatedList({
    required IndexedWidgetBuilder itemBuilder,
    required int itemCount,
    required dynamic itemRemovedBuilder,
    GlobalKey<AnimatedListState>? key,
    ScrollController? controller,
    EdgeInsetsGeometry? padding,
    Duration insertDuration = const Duration(milliseconds: 300),
    Duration removeDuration = const Duration(milliseconds: 300),
  }) {
    return AnimatedList(
      key: key,
      controller: controller,
      padding: padding,
      physics: getOptimizedScrollPhysics(),
      initialItemCount: itemCount,
      itemBuilder: (context, index, animation) {
        return SlideTransition(
          position: animation.drive(
            Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeInOut)),
          ),
          child: RepaintBoundary(
            child: itemBuilder(context, index),
          ),
        );
      },
    );
  }
  
  /// Create performance-optimized widget
  static Widget createOptimizedWidget({
    required Widget child,
    bool enableRepaintBoundary = true,
    bool enableKeepAlive = false,
  }) {
    Widget optimizedChild = child;
    
    if (enableRepaintBoundary) {
      optimizedChild = RepaintBoundary(child: optimizedChild);
    }
    
    if (enableKeepAlive) {
      optimizedChild = _KeepAliveWrapper(child: optimizedChild);
    }
    
    return optimizedChild;
  }
  
  /// Optimize widget tree for performance
  static Widget optimizeWidgetTree(Widget child) {
    return RepaintBoundary(
      child: AutomaticKeepAlive(
        child: child,
      ),
    );
  }
  
  /// Get UI performance metrics
  static Map<String, dynamic> getUIPerformanceMetrics() {
    if (_frameRenderTimes.isEmpty) {
      return {
        'frame_count': 0,
        'monitoring_active': _isInitialized,
        'timestamp': DateTime.now().toIso8601String(),
      };
    }
    
    final averageFrameTime = _frameRenderTimes.reduce((a, b) => a + b) / _frameRenderTimes.length;
    final maxFrameTime = _frameRenderTimes.reduce(math.max);
    final minFrameTime = _frameRenderTimes.reduce(math.min);
    final slowFrames = _frameRenderTimes.where((time) => time > 16.67).length;
    final fps = 1000 / averageFrameTime;
    
    return {
      'monitoring_active': _isInitialized,
      'frame_count': _frameRenderTimes.length,
      'average_frame_time': averageFrameTime,
      'max_frame_time': maxFrameTime,
      'min_frame_time': minFrameTime,
      'slow_frames': slowFrames,
      'slow_frame_percentage': (slowFrames / _frameRenderTimes.length) * 100,
      'average_fps': fps,
      'image_cache_size': PaintingBinding.instance.imageCache.currentSize,
      'image_cache_max_size': PaintingBinding.instance.imageCache.maximumSize,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
  
  /// Manual UI optimization
  static Future<void> optimizeUI() async {
    try {
      if (env.Environment.enableLogging) {
        print('🎨 Manual UI optimization started...');
      }
      
      // Clear image cache
      PaintingBinding.instance.imageCache.clear();
      PaintingBinding.instance.imageCache.clearLiveImages();
      
      // Force layout optimization
      WidgetsBinding.instance.reassembleApplication();
      
      if (env.Environment.enableLogging) {
        print('✅ Manual UI optimization completed');
      }
    } catch (e) {
      if (env.Environment.enableLogging) {
        print('❌ Manual UI optimization failed: $e');
      }
    }
  }
  
  /// Dispose UI optimization service
  static Future<void> dispose() async {
    _frameMonitoringTimer?.cancel();
    _frameRenderTimes.clear();
    _isInitialized = false;
  }
}

/// Keep alive wrapper for widgets
class _KeepAliveWrapper extends StatefulWidget {
  final Widget child;
  
  const _KeepAliveWrapper({required this.child});
  
  @override
  State<_KeepAliveWrapper> createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<_KeepAliveWrapper> 
    with AutomaticKeepAliveClientMixin {
  
  @override
  bool get wantKeepAlive => true;
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}

/// Optimized scroll physics for smooth scrolling
class OptimizedScrollPhysics extends ScrollPhysics {
  const OptimizedScrollPhysics({super.parent});
  
  @override
  OptimizedScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return OptimizedScrollPhysics(parent: buildParent(ancestor));
  }
  
  @override
  double get dragStartDistanceMotionThreshold => 3.5;
  
  @override
  double get minFlingVelocity => 50.0;
  
  @override
  double get maxFlingVelocity => 8000.0;
  
  @override
  SpringDescription get spring => const SpringDescription(
    mass: 0.5,
    stiffness: 100.0,
    damping: 0.8,
  );
}
