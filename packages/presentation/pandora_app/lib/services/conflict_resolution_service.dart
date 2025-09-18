import 'package:ai_domain/ai_domain.dart';
import 'package:core_utils/core_utils.dart';

/// Service for resolving sync conflicts
class ConflictResolutionService {
  static final ConflictResolutionService _instance = ConflictResolutionService._internal();
  factory ConflictResolutionService() => _instance;
  ConflictResolutionService._internal();

  bool _isInitialized = false;
  final Map<String, ConflictResolutionStrategy> _strategies = {};
  final List<SyncConflict> _resolvedConflicts = [];

  /// Initialize conflict resolution service
  Future<bool> initialize() async {
    try {
      AppLogger.info('Initializing Conflict Resolution Service...');
      
      // Set up default strategies
      _setupDefaultStrategies();
      
      _isInitialized = true;
      AppLogger.success('Conflict Resolution Service initialized successfully');
      return true;
    } catch (e) {
      AppLogger.error('Failed to initialize Conflict Resolution Service', e);
      return false;
    }
  }

  /// Set up default conflict resolution strategies
  void _setupDefaultStrategies() {
    _strategies['note'] = ConflictResolutionStrategy.newestWins;
    _strategies['voice_note'] = ConflictResolutionStrategy.newestWins;
    _strategies['ai_data'] = ConflictResolutionStrategy.merge;
    _strategies['settings'] = ConflictResolutionStrategy.localWins;
    _strategies['user_data'] = ConflictResolutionStrategy.remoteWins;
    
    AppLogger.info('Default conflict resolution strategies configured');
  }

  /// Resolve conflict automatically
  Future<ConflictResolutionResult> resolveConflict(SyncConflict conflict) async {
    if (!_isInitialized) {
      return ConflictResolutionResult.error('Service not initialized');
    }

    try {
      AppLogger.info('Resolving conflict: ${conflict.id}');
      
      final strategy = _strategies[conflict.entityType] ?? ConflictResolutionStrategy.newestWins;
      final resolution = await _applyResolutionStrategy(conflict, strategy);
      
      if (resolution.success) {
        _resolvedConflicts.add(conflict.copyWith(resolution: resolution.resolution));
        AppLogger.success('Conflict resolved: ${conflict.id}');
      }
      
      return resolution;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to resolve conflict: ${conflict.id}', e, stackTrace);
      return ConflictResolutionResult.error('Failed to resolve conflict: $e');
    }
  }

  /// Apply resolution strategy
  Future<ConflictResolutionResult> _applyResolutionStrategy(
    SyncConflict conflict,
    ConflictResolutionStrategy strategy,
  ) async {
    switch (strategy) {
      case ConflictResolutionStrategy.localWins:
        return _resolveLocalWins(conflict);
      case ConflictResolutionStrategy.remoteWins:
        return _resolveRemoteWins(conflict);
      case ConflictResolutionStrategy.newestWins:
        return _resolveNewestWins(conflict);
      case ConflictResolutionStrategy.merge:
        return _resolveMerge(conflict);
      case ConflictResolutionStrategy.manual:
        return _resolveManual(conflict);
    }
  }

  /// Resolve conflict by choosing local version
  Future<ConflictResolutionResult> _resolveLocalWins(SyncConflict conflict) async {
    try {
      AppLogger.info('Resolving conflict using local wins strategy: ${conflict.id}');
      
      final resolution = {
        'strategy': 'local_wins',
        'chosen_version': 'local',
        'data': conflict.localData,
        'timestamp': conflict.localModified.toIso8601String(),
      };
      
      return ConflictResolutionResult.success(
        conflictId: conflict.id,
        resolution: jsonEncode(resolution),
        message: 'Conflict resolved using local version',
      );
    } catch (e) {
      AppLogger.error('Failed to resolve conflict with local wins strategy', e);
      return ConflictResolutionResult.error('Failed to resolve with local wins: $e');
    }
  }

  /// Resolve conflict by choosing remote version
  Future<ConflictResolutionResult> _resolveRemoteWins(SyncConflict conflict) async {
    try {
      AppLogger.info('Resolving conflict using remote wins strategy: ${conflict.id}');
      
      final resolution = {
        'strategy': 'remote_wins',
        'chosen_version': 'remote',
        'data': conflict.remoteData,
        'timestamp': conflict.remoteModified.toIso8601String(),
      };
      
      return ConflictResolutionResult.success(
        conflictId: conflict.id,
        resolution: jsonEncode(resolution),
        message: 'Conflict resolved using remote version',
      );
    } catch (e) {
      AppLogger.error('Failed to resolve conflict with remote wins strategy', e);
      return ConflictResolutionResult.error('Failed to resolve with remote wins: $e');
    }
  }

  /// Resolve conflict by choosing newest version
  Future<ConflictResolutionResult> _resolveNewestWins(SyncConflict conflict) async {
    try {
      AppLogger.info('Resolving conflict using newest wins strategy: ${conflict.id}');
      
      final isLocalNewer = conflict.localModified.isAfter(conflict.remoteModified);
      final chosenData = isLocalNewer ? conflict.localData : conflict.remoteData;
      final chosenTimestamp = isLocalNewer ? conflict.localModified : conflict.remoteModified;
      final chosenVersion = isLocalNewer ? 'local' : 'remote';
      
      final resolution = {
        'strategy': 'newest_wins',
        'chosen_version': chosenVersion,
        'data': chosenData,
        'timestamp': chosenTimestamp.toIso8601String(),
        'local_timestamp': conflict.localModified.toIso8601String(),
        'remote_timestamp': conflict.remoteModified.toIso8601String(),
      };
      
      return ConflictResolutionResult.success(
        conflictId: conflict.id,
        resolution: jsonEncode(resolution),
        message: 'Conflict resolved using newest version ($chosenVersion)',
      );
    } catch (e) {
      AppLogger.error('Failed to resolve conflict with newest wins strategy', e);
      return ConflictResolutionResult.error('Failed to resolve with newest wins: $e');
    }
  }

  /// Resolve conflict by merging data
  Future<ConflictResolutionResult> _resolveMerge(SyncConflict conflict) async {
    try {
      AppLogger.info('Resolving conflict using merge strategy: ${conflict.id}');
      
      final mergedData = await _mergeData(conflict.localData, conflict.remoteData);
      
      final resolution = {
        'strategy': 'merge',
        'chosen_version': 'merged',
        'data': mergedData,
        'timestamp': DateTime.now().toIso8601String(),
        'local_timestamp': conflict.localModified.toIso8601String(),
        'remote_timestamp': conflict.remoteModified.toIso8601String(),
        'merge_notes': 'Data merged from both local and remote versions',
      };
      
      return ConflictResolutionResult.success(
        conflictId: conflict.id,
        resolution: jsonEncode(resolution),
        message: 'Conflict resolved by merging data',
      );
    } catch (e) {
      AppLogger.error('Failed to resolve conflict with merge strategy', e);
      return ConflictResolutionResult.error('Failed to resolve with merge: $e');
    }
  }

  /// Resolve conflict manually (requires user intervention)
  Future<ConflictResolutionResult> _resolveManual(SyncConflict conflict) async {
    try {
      AppLogger.info('Resolving conflict using manual strategy: ${conflict.id}');
      
      // For manual resolution, we return a special result that indicates
      // the conflict needs user intervention
      return ConflictResolutionResult.manual(
        conflictId: conflict.id,
        message: 'Conflict requires manual resolution',
        localData: conflict.localData,
        remoteData: conflict.remoteData,
      );
    } catch (e) {
      AppLogger.error('Failed to resolve conflict with manual strategy', e);
      return ConflictResolutionResult.error('Failed to resolve with manual: $e');
    }
  }

  /// Merge data from local and remote versions
  Future<Map<String, dynamic>> _mergeData(
    Map<String, dynamic> localData,
    Map<String, dynamic> remoteData,
  ) async {
    try {
      final mergedData = <String, dynamic>{};
      
      // Get all unique keys
      final allKeys = {...localData.keys, ...remoteData.keys};
      
      for (final key in allKeys) {
        final localValue = localData[key];
        final remoteValue = remoteData[key];
        
        if (localValue == null) {
          // Only exists in remote
          mergedData[key] = remoteValue;
        } else if (remoteValue == null) {
          // Only exists in local
          mergedData[key] = localValue;
        } else if (localValue == remoteValue) {
          // Same value in both
          mergedData[key] = localValue;
        } else if (localValue is Map && remoteValue is Map) {
          // Both are maps, merge recursively
          mergedData[key] = await _mergeData(
            Map<String, dynamic>.from(localValue),
            Map<String, dynamic>.from(remoteValue),
          );
        } else if (localValue is List && remoteValue is List) {
          // Both are lists, merge them
          final mergedList = <dynamic>[...localValue, ...remoteValue];
          mergedData[key] = mergedList.toSet().toList(); // Remove duplicates
        } else {
          // Different values, use the newer one based on timestamp
          // For now, use local value as default
          mergedData[key] = localValue;
        }
      }
      
      return mergedData;
    } catch (e) {
      AppLogger.error('Failed to merge data', e);
      return localData; // Fallback to local data
    }
  }

  /// Resolve conflict manually with user choice
  Future<ConflictResolutionResult> resolveConflictManually(
    String conflictId,
    String userChoice,
    Map<String, dynamic>? customData,
  ) async {
    try {
      AppLogger.info('Resolving conflict manually: $conflictId with choice: $userChoice');
      
      final resolution = {
        'strategy': 'manual',
        'user_choice': userChoice,
        'timestamp': DateTime.now().toIso8601String(),
        'custom_data': customData,
      };
      
      return ConflictResolutionResult.success(
        conflictId: conflictId,
        resolution: jsonEncode(resolution),
        message: 'Conflict resolved manually with user choice: $userChoice',
      );
    } catch (e) {
      AppLogger.error('Failed to resolve conflict manually', e);
      return ConflictResolutionResult.error('Failed to resolve manually: $e');
    }
  }

  /// Set resolution strategy for entity type
  void setStrategy(String entityType, ConflictResolutionStrategy strategy) {
    _strategies[entityType] = strategy;
    AppLogger.info('Resolution strategy set for $entityType: $strategy');
  }

  /// Get resolution strategy for entity type
  ConflictResolutionStrategy getStrategy(String entityType) {
    return _strategies[entityType] ?? ConflictResolutionStrategy.newestWins;
  }

  /// Get all strategies
  Map<String, ConflictResolutionStrategy> get strategies => Map.unmodifiable(_strategies);

  /// Get resolved conflicts
  List<SyncConflict> get resolvedConflicts => List.unmodifiable(_resolvedConflicts);

  /// Clear resolved conflicts
  void clearResolvedConflicts() {
    _resolvedConflicts.clear();
    AppLogger.info('Resolved conflicts cleared');
  }

  /// Analyze conflict patterns
  ConflictAnalysis analyzeConflicts(List<SyncConflict> conflicts) {
    try {
      AppLogger.info('Analyzing conflict patterns...');
      
      final analysis = ConflictAnalysis(
        totalConflicts: conflicts.length,
        conflictsByType: _groupConflictsByType(conflicts),
        conflictsBySeverity: _groupConflictsBySeverity(conflicts),
        mostCommonType: _getMostCommonConflictType(conflicts),
        averageResolutionTime: _calculateAverageResolutionTime(conflicts),
        recommendations: _generateRecommendations(conflicts),
      );
      
      AppLogger.success('Conflict analysis completed');
      return analysis;
    } catch (e) {
      AppLogger.error('Failed to analyze conflicts', e);
      return ConflictAnalysis.empty();
    }
  }

  /// Group conflicts by type
  Map<ConflictType, int> _groupConflictsByType(List<SyncConflict> conflicts) {
    final groups = <ConflictType, int>{};
    for (final conflict in conflicts) {
      groups[conflict.type] = (groups[conflict.type] ?? 0) + 1;
    }
    return groups;
  }

  /// Group conflicts by severity
  Map<ConflictSeverity, int> _groupConflictsBySeverity(List<SyncConflict> conflicts) {
    final groups = <ConflictSeverity, int>{};
    for (final conflict in conflicts) {
      groups[conflict.severity] = (groups[conflict.severity] ?? 0) + 1;
    }
    return groups;
  }

  /// Get most common conflict type
  ConflictType _getMostCommonConflictType(List<SyncConflict> conflicts) {
    final typeCounts = _groupConflictsByType(conflicts);
    if (typeCounts.isEmpty) return ConflictType.contentModified;
    
    return typeCounts.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  /// Calculate average resolution time
  Duration _calculateAverageResolutionTime(List<SyncConflict> conflicts) {
    final resolvedConflicts = conflicts.where((c) => c.isResolved).toList();
    if (resolvedConflicts.isEmpty) return Duration.zero;
    
    // For now, return a simulated average
    return const Duration(minutes: 5);
  }

  /// Generate recommendations
  List<String> _generateRecommendations(List<SyncConflict> conflicts) {
    final recommendations = <String>[];
    
    final typeCounts = _groupConflictsByType(conflicts);
    
    if (typeCounts[ConflictType.contentModified] != null && 
        typeCounts[ConflictType.contentModified]! > 5) {
      recommendations.add('Consider implementing real-time collaboration to reduce content conflicts');
    }
    
    if (typeCounts[ConflictType.networkError] != null && 
        typeCounts[ConflictType.networkError]! > 3) {
      recommendations.add('Improve network error handling and retry mechanisms');
    }
    
    if (typeCounts[ConflictType.permissionDenied] != null && 
        typeCounts[ConflictType.permissionDenied]! > 0) {
      recommendations.add('Review and update user permissions');
    }
    
    if (recommendations.isEmpty) {
      recommendations.add('Conflict resolution is working well');
    }
    
    return recommendations;
  }

  /// Check if service is initialized
  bool get isInitialized => _isInitialized;

  /// Dispose service
  Future<void> dispose() async {
    _strategies.clear();
    _resolvedConflicts.clear();
    _isInitialized = false;
    AppLogger.info('Conflict Resolution Service disposed');
  }
}

/// Conflict resolution result
class ConflictResolutionResult {
  final bool success;
  final String conflictId;
  final String? resolution;
  final String message;
  final Map<String, dynamic>? localData;
  final Map<String, dynamic>? remoteData;
  final bool requiresManual;

  const ConflictResolutionResult._({
    required this.success,
    required this.conflictId,
    this.resolution,
    required this.message,
    this.localData,
    this.remoteData,
    this.requiresManual = false,
  });

  factory ConflictResolutionResult.success({
    required String conflictId,
    required String resolution,
    required String message,
  }) {
    return ConflictResolutionResult._(
      success: true,
      conflictId: conflictId,
      resolution: resolution,
      message: message,
    );
  }

  factory ConflictResolutionResult.error(String message) {
    return ConflictResolutionResult._(
      success: false,
      conflictId: '',
      message: message,
    );
  }

  factory ConflictResolutionResult.manual({
    required String conflictId,
    required String message,
    required Map<String, dynamic> localData,
    required Map<String, dynamic> remoteData,
  }) {
    return ConflictResolutionResult._(
      success: false,
      conflictId: conflictId,
      message: message,
      localData: localData,
      remoteData: remoteData,
      requiresManual: true,
    );
  }
}

/// Conflict analysis result
class ConflictAnalysis {
  final int totalConflicts;
  final Map<ConflictType, int> conflictsByType;
  final Map<ConflictSeverity, int> conflictsBySeverity;
  final ConflictType mostCommonType;
  final Duration averageResolutionTime;
  final List<String> recommendations;

  const ConflictAnalysis({
    required this.totalConflicts,
    required this.conflictsByType,
    required this.conflictsBySeverity,
    required this.mostCommonType,
    required this.averageResolutionTime,
    required this.recommendations,
  });

  factory ConflictAnalysis.empty() {
    return const ConflictAnalysis(
      totalConflicts: 0,
      conflictsByType: {},
      conflictsBySeverity: {},
      mostCommonType: ConflictType.contentModified,
      averageResolutionTime: Duration.zero,
      recommendations: [],
    );
  }
}
