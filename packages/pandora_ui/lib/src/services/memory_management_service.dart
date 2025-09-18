import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:collection';
import 'dart:math' as math;

/// Pandora 4 Memory Management Service
/// 
/// Comprehensive memory management service for Phase 3
/// Includes widget caching, memory monitoring, and garbage collection optimization
class MemoryManagementService {
  // Private constructor to prevent instantiation
  MemoryManagementService._();

  // Memory management constants - Optimized for better performance
  static const int maxCacheSize = 150; // Increased for better caching
  static const int maxMemoryUsage = 150; // MB - More conservative
  static const Duration cacheExpirationTime = Duration(minutes: 5); // Shorter expiration
  static const Duration cleanupInterval = Duration(minutes: 2); // More frequent cleanup
  static const int maxMemoryHistory = 50; // Limit memory history size
  static const double memoryThreshold = 0.8; // 80% memory usage threshold

  // Memory pools
  static final Map<String, Widget> _widgetPool = {};
  static final Map<String, DateTime> _poolTimestamps = {};
  static final Map<String, int> _accessCounts = {};
  static final Map<String, int> _memorySizes = {};

  // Memory monitoring
  static final Queue<MemorySnapshot> _memoryHistory = Queue<MemorySnapshot>();
  static Timer? _cleanupTimer;
  static bool _isMonitoring = false;

  // Memory usage tracking
  static int _currentMemoryUsage = 0;
  static int _peakMemoryUsage = 0;
  static int _totalAllocations = 0;
  static int _totalDeallocations = 0;

  /// Initialize memory management
  static void initialize() {
    if (_isMonitoring) return;
    
    _isMonitoring = true;
    _cleanupTimer = Timer.periodic(cleanupInterval, _performCleanup);
    _currentMemoryUsage = 0;
    _peakMemoryUsage = 0;
    _totalAllocations = 0;
    _totalDeallocations = 0;
  }

  /// Stop memory management
  static void stop() {
    _isMonitoring = false;
    _cleanupTimer?.cancel();
    _cleanupTimer = null;
    clearAllPools();
  }

  /// Create memory-efficient widget
  static Widget createMemoryEfficientWidget({
    required String key,
    required Widget Function() builder,
    int? estimatedMemorySize,
    bool enableCaching = true,
    Duration? cacheDuration,
  }) {
    if (!enableCaching) {
      return builder();
    }

    final effectiveKey = 'memory_$key';
    final now = DateTime.now();
    final effectiveDuration = cacheDuration ?? cacheExpirationTime;

    // Check if widget exists in pool and is not expired
    if (_widgetPool.containsKey(effectiveKey) && 
        _poolTimestamps.containsKey(effectiveKey)) {
      final cacheTime = _poolTimestamps[effectiveKey]!;
      
      if (now.difference(cacheTime) < effectiveDuration) {
        _accessCounts[effectiveKey] = (_accessCounts[effectiveKey] ?? 0) + 1;
        return _widgetPool[effectiveKey]!;
      }
    }

    // Create new widget
    final widget = builder();
    final memorySize = estimatedMemorySize ?? _estimateWidgetMemorySize(widget);
    
    // Check memory constraints
    if (_currentMemoryUsage + memorySize > maxMemoryUsage * 1024 * 1024) {
      _performEmergencyCleanup();
    }

    // Add to pool
    _widgetPool[effectiveKey] = widget;
    _poolTimestamps[effectiveKey] = now;
    _accessCounts[effectiveKey] = 1;
    _memorySizes[effectiveKey] = memorySize;
    
    _currentMemoryUsage += memorySize;
    _totalAllocations++;
    _peakMemoryUsage = math.max(_peakMemoryUsage, _currentMemoryUsage);

    // Record memory snapshot
    _recordMemorySnapshot();

    return widget;
  }

  /// Create lazy loading widget with memory optimization
  static Widget createLazyWidget({
    required String key,
    required Widget Function() builder,
    required bool isVisible,
    Duration? delay,
    int? estimatedMemorySize,
  }) {
    if (isVisible) {
      return createMemoryEfficientWidget(
        key: key,
        builder: builder,
        estimatedMemorySize: estimatedMemorySize,
      );
    }

    return FutureBuilder<bool>(
      future: Future.delayed(delay ?? const Duration(milliseconds: 100), () => true),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data == true) {
          return createMemoryEfficientWidget(
            key: key,
            builder: builder,
            estimatedMemorySize: estimatedMemorySize,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  /// Create virtualized widget list
  static Widget createVirtualizedList({
    required List<Widget> children,
    required double itemHeight,
    required double viewportHeight,
    ScrollController? controller,
    String? cacheKey,
  }) {
    return ListView.builder(
      controller: controller,
      itemCount: children.length,
      itemExtent: itemHeight,
      cacheExtent: viewportHeight * 0.5,
      itemBuilder: (context, index) {
        final itemKey = '${cacheKey ?? 'virtualized'}_$index';
        return createMemoryEfficientWidget(
          key: itemKey,
          builder: () => children[index],
          estimatedMemorySize: _estimateWidgetMemorySize(children[index]),
        );
      },
    );
  }

  /// Create image with memory optimization
  static Widget createOptimizedImage({
    required String imagePath,
    required double width,
    required double height,
    BoxFit fit = BoxFit.cover,
    String? cacheKey,
    bool enableCaching = true,
  }) {
    final key = cacheKey ?? 'image_${imagePath}_${width}_${height}';
    final estimatedSize = (width * height * 4).toInt(); // RGBA bytes

    return createMemoryEfficientWidget(
      key: key,
      builder: () => Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: fit,
        cacheWidth: width.toInt(),
        cacheHeight: height.toInt(),
      ),
      estimatedMemorySize: estimatedSize,
      enableCaching: enableCaching,
    );
  }

  /// Create text with memory optimization
  static Widget createOptimizedText({
    required String text,
    TextStyle? style,
    String? cacheKey,
    bool enableCaching = true,
  }) {
    final key = cacheKey ?? 'text_${text.hashCode}';
    final estimatedSize = text.length * 2; // UTF-16 bytes

    return createMemoryEfficientWidget(
      key: key,
      builder: () => Text(text, style: style),
      estimatedMemorySize: estimatedSize,
      enableCaching: enableCaching,
    );
  }

  /// Create container with memory optimization
  static Widget createOptimizedContainer({
    required Widget child,
    Color? color,
    EdgeInsets? padding,
    EdgeInsets? margin,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
    String? cacheKey,
    bool enableCaching = true,
  }) {
    final key = cacheKey ?? 'container_${child.runtimeType}';
    final estimatedSize = _estimateWidgetMemorySize(child);

    return createMemoryEfficientWidget(
      key: key,
      builder: () => Container(
        color: color,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          boxShadow: boxShadow,
        ),
        child: child,
      ),
      estimatedMemorySize: estimatedSize,
      enableCaching: enableCaching,
    );
  }

  /// Create button with memory optimization
  static Widget createOptimizedButton({
    required Widget child,
    VoidCallback? onPressed,
    String? cacheKey,
    bool enableCaching = true,
  }) {
    final key = cacheKey ?? 'button_${child.runtimeType}';
    final estimatedSize = _estimateWidgetMemorySize(child);

    return createMemoryEfficientWidget(
      key: key,
      builder: () => ElevatedButton(
        onPressed: onPressed,
        child: child,
      ),
      estimatedMemorySize: estimatedSize,
      enableCaching: enableCaching,
    );
  }

  /// Create card with memory optimization
  static Widget createOptimizedCard({
    required Widget child,
    Color? color,
    double? elevation,
    String? cacheKey,
    bool enableCaching = true,
  }) {
    final key = cacheKey ?? 'card_${child.runtimeType}';
    final estimatedSize = _estimateWidgetMemorySize(child);

    return createMemoryEfficientWidget(
      key: key,
      builder: () => Card(
        color: color,
        elevation: elevation,
        child: child,
      ),
      estimatedMemorySize: estimatedSize,
      enableCaching: enableCaching,
    );
  }

  /// Get memory usage statistics
  static MemoryStatistics getMemoryStatistics() {
    return MemoryStatistics(
      currentUsage: _currentMemoryUsage,
      peakUsage: _peakMemoryUsage,
      totalAllocations: _totalAllocations,
      totalDeallocations: _totalDeallocations,
      poolSize: _widgetPool.length,
      averageMemoryPerWidget: _widgetPool.isNotEmpty 
          ? _currentMemoryUsage / _widgetPool.length 
          : 0,
      cacheHitRate: _getCacheHitRate(),
      memoryEfficiency: _getMemoryEfficiency(),
    );
  }

  /// Get memory history
  static List<MemorySnapshot> getMemoryHistory() {
    return List.unmodifiable(_memoryHistory);
  }

  /// Clear specific widget from pool
  static void clearWidget(String key) {
    final effectiveKey = 'memory_$key';
    
    if (_widgetPool.containsKey(effectiveKey)) {
      final memorySize = _memorySizes[effectiveKey] ?? 0;
      _currentMemoryUsage -= memorySize;
      _totalDeallocations++;
      
      _widgetPool.remove(effectiveKey);
      _poolTimestamps.remove(effectiveKey);
      _accessCounts.remove(effectiveKey);
      _memorySizes.remove(effectiveKey);
    }
  }

  /// Clear all pools
  static void clearAllPools() {
    _widgetPool.clear();
    _poolTimestamps.clear();
    _accessCounts.clear();
    _memorySizes.clear();
    _currentMemoryUsage = 0;
    _totalDeallocations += _totalAllocations;
    _totalAllocations = 0;
  }

  /// Perform cleanup
  static void _performCleanup(Timer timer) {
    final now = DateTime.now();
    final keysToRemove = <String>[];

    // Find expired widgets
    for (final entry in _poolTimestamps.entries) {
      if (now.difference(entry.value) > cacheExpirationTime) {
        keysToRemove.add(entry.key);
      }
    }

    // Remove expired widgets
    for (final key in keysToRemove) {
      clearWidget(key);
    }

    // If still over limit, remove least recently used
    if (_widgetPool.length > maxCacheSize) {
      final sortedKeys = _poolTimestamps.keys.toList()
        ..sort((a, b) => _poolTimestamps[a]!.compareTo(_poolTimestamps[b]!));
      
      final excessCount = _widgetPool.length - maxCacheSize;
      for (int i = 0; i < excessCount; i++) {
        clearWidget(sortedKeys[i]);
      }
    }

    _recordMemorySnapshot();
  }

  /// Perform emergency cleanup
  static void _performEmergencyCleanup() {
    // Remove least recently used widgets until memory is under limit
    final sortedKeys = _poolTimestamps.keys.toList()
      ..sort((a, b) => _poolTimestamps[a]!.compareTo(_poolTimestamps[b]!));
    
    for (final key in sortedKeys) {
      clearWidget(key);
      if (_currentMemoryUsage < maxMemoryUsage * 1024 * 1024 * 0.8) {
        break;
      }
    }
  }

  /// Estimate widget memory size
  static int _estimateWidgetMemorySize(Widget widget) {
    // This is a simplified estimation
    // In a real implementation, you'd need more sophisticated analysis
    if (widget is Text) {
      return (widget.data?.length ?? 0) * 2; // UTF-16 bytes
    } else if (widget is Image) {
      return 1000; // Estimated image memory
    } else if (widget is Container) {
      return 500; // Estimated container memory
    } else if (widget is Card) {
      return 800; // Estimated card memory
    } else if (widget is ElevatedButton || widget is TextButton || widget is OutlinedButton) {
      return 300; // Estimated button memory
    }
    
    return 200; // Default estimation
  }

  /// Record memory snapshot
  static void _recordMemorySnapshot() {
    final snapshot = MemorySnapshot(
      timestamp: DateTime.now(),
      currentUsage: _currentMemoryUsage,
      peakUsage: _peakMemoryUsage,
      poolSize: _widgetPool.length,
      totalAllocations: _totalAllocations,
      totalDeallocations: _totalDeallocations,
    );
    
    _memoryHistory.add(snapshot);
    
    // Keep only last 100 snapshots
    if (_memoryHistory.length > 100) {
      _memoryHistory.removeFirst();
    }
  }

  /// Get cache hit rate
  static double _getCacheHitRate() {
    if (_accessCounts.isEmpty) return 0.0;
    
    final totalAccesses = _accessCounts.values.fold(0, (a, b) => a + b);
    final cacheHits = _widgetPool.length;
    
    return cacheHits / totalAccesses;
  }

  /// Get memory efficiency
  static double _getMemoryEfficiency() {
    if (_totalAllocations == 0) return 1.0;
    
    return _totalDeallocations / _totalAllocations;
  }

  /// Create memory monitor widget
  static Widget createMemoryMonitor({
    bool showCurrentUsage = true,
    bool showPeakUsage = true,
    bool showPoolSize = true,
    bool showEfficiency = true,
  }) {
    return StreamBuilder<MemoryStatistics>(
      stream: Stream.periodic(
        const Duration(seconds: 1),
        (_) => getMemoryStatistics(),
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
              if (showCurrentUsage)
                Text(
                  'Memory: ${(stats.currentUsage / 1024 / 1024).toStringAsFixed(1)}MB',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              if (showPeakUsage)
                Text(
                  'Peak: ${(stats.peakUsage / 1024 / 1024).toStringAsFixed(1)}MB',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              if (showPoolSize)
                Text(
                  'Pool: ${stats.poolSize}',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              if (showEfficiency)
                Text(
                  'Efficiency: ${(stats.memoryEfficiency * 100).toStringAsFixed(1)}%',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
            ],
          ),
        );
      },
    );
  }
}

/// Memory statistics class
class MemoryStatistics {
  final int currentUsage;
  final int peakUsage;
  final int totalAllocations;
  final int totalDeallocations;
  final int poolSize;
  final double averageMemoryPerWidget;
  final double cacheHitRate;
  final double memoryEfficiency;

  const MemoryStatistics({
    required this.currentUsage,
    required this.peakUsage,
    required this.totalAllocations,
    required this.totalDeallocations,
    required this.poolSize,
    required this.averageMemoryPerWidget,
    required this.cacheHitRate,
    required this.memoryEfficiency,
  });
}

/// Memory snapshot class
class MemorySnapshot {
  final DateTime timestamp;
  final int currentUsage;
  final int peakUsage;
  final int poolSize;
  final int totalAllocations;
  final int totalDeallocations;

  const MemorySnapshot({
    required this.timestamp,
    required this.currentUsage,
    required this.peakUsage,
    required this.poolSize,
    required this.totalAllocations,
    required this.totalDeallocations,
  });
}

/// Memory management extensions
extension MemoryManagementExtensions on Widget {
  /// Add memory optimization
  Widget withMemoryOptimization({
    String? cacheKey,
    int? estimatedMemorySize,
    bool enableCaching = true,
    Duration? cacheDuration,
  }) {
    if (!enableCaching) return this;
    
    final key = cacheKey ?? 'widget_${runtimeType}';
    return MemoryManagementService.createMemoryEfficientWidget(
      key: key,
      builder: () => this,
      estimatedMemorySize: estimatedMemorySize,
      enableCaching: enableCaching,
      cacheDuration: cacheDuration,
    );
  }

  /// Add lazy loading with memory optimization
  Widget withLazyLoading({
    required String key,
    required bool isVisible,
    Duration? delay,
    int? estimatedMemorySize,
  }) {
    return MemoryManagementService.createLazyWidget(
      key: key,
      builder: () => this,
      isVisible: isVisible,
      delay: delay,
      estimatedMemorySize: estimatedMemorySize,
    );
  }
}
