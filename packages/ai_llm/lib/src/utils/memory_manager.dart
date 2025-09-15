import 'dart:async';
import 'dart:collection';
import 'dart:isolate';
import 'package:flutter/foundation.dart';

/// Memory manager for AI system
class MemoryManager {
  static final MemoryManager _instance = MemoryManager._internal();
  factory MemoryManager() => _instance;
  MemoryManager._internal();

  // Memory tracking
  final Map<String, MemoryAllocation> _allocations = {};
  final Queue<MemoryEvent> _memoryEvents = Queue<MemoryEvent>();
  Timer? _cleanupTimer;
  Timer? _gcTimer;

  // Configuration
  static const int _maxMemoryMB = 500; // 500MB limit
  static const int _maxAllocations = 1000;
  static const Duration _cleanupInterval = Duration(minutes: 2);
  static const Duration _gcInterval = Duration(minutes: 5);

  /// Initialize memory management
  void initialize() {
    _cleanupTimer = Timer.periodic(_cleanupInterval, (_) => _cleanupMemory());
    _gcTimer = Timer.periodic(_gcInterval, (_) => _forceGarbageCollection());
  }

  /// Dispose resources
  void dispose() {
    _cleanupTimer?.cancel();
    _gcTimer?.cancel();
    _clearAllAllocations();
  }

  /// Allocate memory for a resource
  MemoryAllocation allocate(String resourceId, int sizeBytes, {String? category}) {
    final allocation = MemoryAllocation(
      resourceId: resourceId,
      sizeBytes: sizeBytes,
      category: category ?? 'general',
      timestamp: DateTime.now(),
    );

    _allocations[resourceId] = allocation;
    _recordMemoryEvent('allocate', sizeBytes, resourceId);

    // Check memory limit
    _checkMemoryLimit();

    return allocation;
  }

  /// Deallocate memory for a resource
  void deallocate(String resourceId) {
    final allocation = _allocations.remove(resourceId);
    if (allocation != null) {
      _recordMemoryEvent('deallocate', allocation.sizeBytes, resourceId);
    }
  }

  /// Get memory usage statistics
  MemoryStats getMemoryStats() {
    final totalAllocated = _allocations.values
        .map((a) => a.sizeBytes)
        .fold(0, (a, b) => a + b);

    final categoryStats = <String, int>{};
    for (final allocation in _allocations.values) {
      categoryStats[allocation.category] = 
          (categoryStats[allocation.category] ?? 0) + allocation.sizeBytes;
    }

    return MemoryStats(
      totalAllocatedBytes: totalAllocated,
      totalAllocatedMB: totalAllocated / (1024 * 1024),
      allocationCount: _allocations.length,
      categoryStats: categoryStats,
      memoryLimitMB: _maxMemoryMB,
      memoryUsagePercent: (totalAllocated / (1024 * 1024)) / _maxMemoryMB * 100,
    );
  }

  /// Get memory usage by category
  Map<String, int> getMemoryByCategory() {
    final categoryStats = <String, int>{};
    for (final allocation in _allocations.values) {
      categoryStats[allocation.category] = 
          (categoryStats[allocation.category] ?? 0) + allocation.sizeBytes;
    }
    return categoryStats;
  }

  /// Check if memory limit is exceeded
  bool isMemoryLimitExceeded() {
    final stats = getMemoryStats();
    return stats.memoryUsagePercent > 90; // 90% threshold
  }

  /// Get memory recommendations
  List<String> getMemoryRecommendations() {
    final recommendations = <String>[];
    final stats = getMemoryStats();

    if (stats.memoryUsagePercent > 80) {
      recommendations.add('Memory usage is high (${stats.memoryUsagePercent.toStringAsFixed(1)}%). Consider freeing up resources.');
    }

    if (stats.allocationCount > _maxAllocations * 0.8) {
      recommendations.add('Too many allocations (${stats.allocationCount}). Consider consolidating resources.');
    }

    // Check for large allocations
    final largeAllocations = _allocations.values
        .where((a) => a.sizeBytes > 50 * 1024 * 1024) // 50MB
        .toList();

    if (largeAllocations.isNotEmpty) {
      recommendations.add('Large allocations detected. Consider splitting or optimizing: ${largeAllocations.map((a) => a.resourceId).join(', ')}');
    }

    // Check for old allocations
    final oldAllocations = _allocations.values
        .where((a) => DateTime.now().difference(a.timestamp).inMinutes > 30)
        .toList();

    if (oldAllocations.isNotEmpty) {
      recommendations.add('Old allocations detected. Consider cleaning up: ${oldAllocations.map((a) => a.resourceId).join(', ')}');
    }

    return recommendations;
  }

  /// Force garbage collection
  void forceGarbageCollection() {
    _forceGarbageCollection();
  }

  /// Clear all allocations
  void clearAllAllocations() {
    _clearAllAllocations();
  }

  /// Get memory events
  List<MemoryEvent> getMemoryEvents({int? limit}) {
    final events = _memoryEvents.toList();
    if (limit != null && events.length > limit) {
      return events.sublist(events.length - limit);
    }
    return events;
  }

  /// Export memory data
  Map<String, dynamic> exportMemoryData() {
    return {
      'allocations': _allocations.map((key, value) => MapEntry(key, value.toJson())),
      'events': _memoryEvents.map((e) => e.toJson()).toList(),
      'stats': getMemoryStats().toJson(),
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  // Private methods

  void _recordMemoryEvent(String action, int sizeBytes, String resourceId) {
    final event = MemoryEvent(
      action: action,
      sizeBytes: sizeBytes,
      resourceId: resourceId,
      timestamp: DateTime.now(),
    );

    _memoryEvents.add(event);

    // Limit event queue size
    if (_memoryEvents.length > 1000) {
      _memoryEvents.removeFirst();
    }
  }

  void _checkMemoryLimit() {
    if (isMemoryLimitExceeded()) {
      if (kDebugMode) {
        print('Memory limit exceeded! Current usage: ${getMemoryStats().memoryUsagePercent.toStringAsFixed(1)}%');
      }
      _cleanupMemory();
    }
  }

  void _cleanupMemory() {
    final stats = getMemoryStats();
    
    if (stats.memoryUsagePercent > 80) {
      // Clean up old allocations
      final cutoff = DateTime.now().subtract(const Duration(minutes: 10));
      final oldAllocations = _allocations.entries
          .where((e) => e.value.timestamp.isBefore(cutoff))
          .map((e) => e.key)
          .toList();

      for (final resourceId in oldAllocations) {
        deallocate(resourceId);
      }

      // Clean up large allocations if still over limit
      if (isMemoryLimitExceeded()) {
        final largeAllocations = _allocations.entries
            .where((e) => e.value.sizeBytes > 10 * 1024 * 1024) // 10MB
            .toList()
          ..sort((a, b) => b.value.sizeBytes.compareTo(a.value.sizeBytes));

        for (final entry in largeAllocations.take(3)) {
          deallocate(entry.key);
        }
      }
    }
  }

  void _forceGarbageCollection() {
    // Force garbage collection
    if (kDebugMode) {
      print('Forcing garbage collection...');
    }
    
    // This is a placeholder - actual GC would depend on the platform
    // In a real implementation, you might call platform-specific GC methods
  }

  void _clearAllAllocations() {
    _allocations.clear();
    _memoryEvents.clear();
  }
}

/// Memory allocation tracking
class MemoryAllocation {
  final String resourceId;
  final int sizeBytes;
  final String category;
  final DateTime timestamp;

  const MemoryAllocation({
    required this.resourceId,
    required this.sizeBytes,
    required this.category,
    required this.timestamp,
  });

  double get sizeMB => sizeBytes / (1024 * 1024);

  Map<String, dynamic> toJson() {
    return {
      'resource_id': resourceId,
      'size_bytes': sizeBytes,
      'size_mb': sizeMB,
      'category': category,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

/// Memory event for tracking
class MemoryEvent {
  final String action;
  final int sizeBytes;
  final String resourceId;
  final DateTime timestamp;

  const MemoryEvent({
    required this.action,
    required this.sizeBytes,
    required this.resourceId,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'action': action,
      'size_bytes': sizeBytes,
      'size_mb': sizeBytes / (1024 * 1024),
      'resource_id': resourceId,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

/// Memory statistics
class MemoryStats {
  final int totalAllocatedBytes;
  final double totalAllocatedMB;
  final int allocationCount;
  final Map<String, int> categoryStats;
  final int memoryLimitMB;
  final double memoryUsagePercent;

  const MemoryStats({
    required this.totalAllocatedBytes,
    required this.totalAllocatedMB,
    required this.allocationCount,
    required this.categoryStats,
    required this.memoryLimitMB,
    required this.memoryUsagePercent,
  });

  Map<String, dynamic> toJson() {
    return {
      'total_allocated_bytes': totalAllocatedBytes,
      'total_allocated_mb': totalAllocatedMB,
      'allocation_count': allocationCount,
      'category_stats': categoryStats,
      'memory_limit_mb': memoryLimitMB,
      'memory_usage_percent': memoryUsagePercent,
    };
  }
}

/// Memory pool for efficient allocation
class MemoryPool {
  final String category;
  final int maxSizeBytes;
  final Queue<MemoryAllocation> _pool = Queue<MemoryAllocation>();
  int _currentSize = 0;

  MemoryPool({
    required this.category,
    required this.maxSizeBytes,
  });

  /// Allocate from pool
  MemoryAllocation? allocate(int sizeBytes) {
    if (_currentSize + sizeBytes > maxSizeBytes) {
      return null; // Pool is full
    }

    final allocation = MemoryAllocation(
      resourceId: '${category}_${DateTime.now().millisecondsSinceEpoch}',
      sizeBytes: sizeBytes,
      category: category,
      timestamp: DateTime.now(),
    );

    _pool.add(allocation);
    _currentSize += sizeBytes;

    return allocation;
  }

  /// Deallocate from pool
  void deallocate(String resourceId) {
    final allocation = _pool.firstWhere(
      (a) => a.resourceId == resourceId,
      orElse: () => throw ArgumentError('Allocation not found: $resourceId'),
    );

    _pool.remove(allocation);
    _currentSize -= allocation.sizeBytes;
  }

  /// Get pool statistics
  Map<String, dynamic> getStats() {
    return {
      'category': category,
      'current_size_bytes': _currentSize,
      'current_size_mb': _currentSize / (1024 * 1024),
      'max_size_bytes': maxSizeBytes,
      'max_size_mb': maxSizeBytes / (1024 * 1024),
      'usage_percent': (_currentSize / maxSizeBytes) * 100,
      'allocation_count': _pool.length,
    };
  }
}
