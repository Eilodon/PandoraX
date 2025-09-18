import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Service for managing beta testing and user feedback
class BetaTestingService {
  static final BetaTestingService _instance = BetaTestingService._internal();
  factory BetaTestingService() => _instance;
  BetaTestingService._internal();

  SharedPreferences? _prefs;
  PackageInfo? _packageInfo;
  final Connectivity _connectivity = Connectivity();
  bool _isInitialized = false;

  // Beta testing configuration
  final List<BetaFeature> _betaFeatures = [
    BetaFeature(
      id: 'ai_chat_advanced',
      name: 'Advanced AI Chat',
      description: 'Enhanced AI conversation capabilities',
      isEnabled: false,
      feedbackRequired: true,
    ),
    BetaFeature(
      id: 'voice_commands',
      name: 'Voice Commands',
      description: 'Control the app with voice commands',
      isEnabled: false,
      feedbackRequired: true,
    ),
    BetaFeature(
      id: 'smart_categorization',
      name: 'Smart Categorization',
      description: 'Automatic note categorization',
      isEnabled: false,
      feedbackRequired: true,
    ),
    BetaFeature(
      id: 'collaborative_notes',
      name: 'Collaborative Notes',
      description: 'Share and collaborate on notes',
      isEnabled: false,
      feedbackRequired: true,
    ),
    BetaFeature(
      id: 'advanced_analytics',
      name: 'Advanced Analytics',
      description: 'Detailed usage analytics',
      isEnabled: false,
      feedbackRequired: false,
    ),
  ];

  final List<FeedbackItem> _feedbackQueue = [];

  /// Initialize the beta testing service
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      _prefs = await SharedPreferences.getInstance();
      _packageInfo = await PackageInfo.fromPlatform();
      await _loadBetaTestingState();
      _isInitialized = true;
    } catch (e) {
      throw BetaTestingException('Failed to initialize beta testing: $e');
    }
  }

  /// Load beta testing state from preferences
  Future<void> _loadBetaTestingState() async {
    if (_prefs == null) return;

    for (int i = 0; i < _betaFeatures.length; i++) {
      final feature = _betaFeatures[i];
      final isEnabled = _prefs!.getBool('beta_feature_${feature.id}') ?? false;
      _betaFeatures[i] = feature.copyWith(isEnabled: isEnabled);
    }
  }

  /// Check if user is enrolled in beta testing
  bool isBetaTester() {
    if (!_isInitialized) return false;
    return _prefs?.getBool('is_beta_tester') ?? false;
  }

  /// Enroll user in beta testing
  Future<void> enrollInBeta() async {
    if (!_isInitialized) return;

    try {
      await _prefs?.setBool('is_beta_tester', true);
      await _prefs?.setString('beta_enrollment_date', DateTime.now().toIso8601String());
      await _prefs?.setString('beta_version', _packageInfo?.version ?? '1.0.0');
    } catch (e) {
      throw BetaTestingException('Failed to enroll in beta: $e');
    }
  }

  /// Unenroll user from beta testing
  Future<void> unenrollFromBeta() async {
    if (!_isInitialized) return;

    try {
      await _prefs?.setBool('is_beta_tester', false);
      await _prefs?.remove('beta_enrollment_date');
      await _prefs?.remove('beta_version');
    } catch (e) {
      throw BetaTestingException('Failed to unenroll from beta: $e');
    }
  }

  /// Get all beta features
  List<BetaFeature> getBetaFeatures() {
    return List.from(_betaFeatures);
  }

  /// Get enabled beta features
  List<BetaFeature> getEnabledBetaFeatures() {
    return _betaFeatures.where((feature) => feature.isEnabled).toList();
  }

  /// Check if beta feature is enabled
  bool isBetaFeatureEnabled(String featureId) {
    if (!_isInitialized) return false;
    
    final feature = _betaFeatures.firstWhere(
      (feature) => feature.id == featureId,
      orElse: () => BetaFeature(
        id: featureId,
        name: '',
        description: '',
        isEnabled: false,
        feedbackRequired: false,
      ),
    );
    
    return feature.isEnabled;
  }

  /// Enable beta feature
  Future<void> enableBetaFeature(String featureId) async {
    if (!_isInitialized) return;

    try {
      final featureIndex = _betaFeatures.indexWhere((feature) => feature.id == featureId);
      if (featureIndex == -1) return;

      _betaFeatures[featureIndex] = _betaFeatures[featureIndex].copyWith(isEnabled: true);
      await _prefs?.setBool('beta_feature_$featureId', true);
    } catch (e) {
      throw BetaTestingException('Failed to enable beta feature $featureId: $e');
    }
  }

  /// Disable beta feature
  Future<void> disableBetaFeature(String featureId) async {
    if (!_isInitialized) return;

    try {
      final featureIndex = _betaFeatures.indexWhere((feature) => feature.id == featureId);
      if (featureIndex == -1) return;

      _betaFeatures[featureIndex] = _betaFeatures[featureIndex].copyWith(isEnabled: false);
      await _prefs?.setBool('beta_feature_$featureId', false);
    } catch (e) {
      throw BetaTestingException('Failed to disable beta feature $featureId: $e');
    }
  }

  /// Submit feedback for beta feature
  Future<void> submitFeedback(String featureId, String feedback, {int rating = 0}) async {
    if (!_isInitialized) return;

    try {
      final feedbackItem = FeedbackItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        featureId: featureId,
        feedback: feedback,
        rating: rating,
        timestamp: DateTime.now(),
        isSubmitted: false,
      );

      _feedbackQueue.add(feedbackItem);
      await _saveFeedbackQueue();
    } catch (e) {
      throw BetaTestingException('Failed to submit feedback: $e');
    }
  }

  /// Submit bug report
  Future<void> submitBugReport(String title, String description, String stepsToReproduce) async {
    if (!_isInitialized) return;

    try {
      final bugReport = BugReport(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description: description,
        stepsToReproduce: stepsToReproduce,
        timestamp: DateTime.now(),
        isSubmitted: false,
        appVersion: _packageInfo?.version ?? '1.0.0',
        buildNumber: _packageInfo?.buildNumber ?? '1',
      );

      await _prefs?.setString('bug_report_${bugReport.id}', jsonEncode(bugReport.toMap()));
    } catch (e) {
      throw BetaTestingException('Failed to submit bug report: $e');
    }
  }

  /// Get pending feedback
  List<FeedbackItem> getPendingFeedback() {
    return _feedbackQueue.where((item) => !item.isSubmitted).toList();
  }

  /// Submit all pending feedback
  Future<void> submitAllPendingFeedback() async {
    if (!_isInitialized) return;

    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        throw BetaTestingException('No internet connection');
      }

      for (final feedback in _feedbackQueue) {
        if (!feedback.isSubmitted) {
          await _submitFeedbackToServer(feedback);
          feedback.isSubmitted = true;
        }
      }

      await _saveFeedbackQueue();
    } catch (e) {
      throw BetaTestingException('Failed to submit pending feedback: $e');
    }
  }

  /// Submit feedback to server
  Future<void> _submitFeedbackToServer(FeedbackItem feedback) async {
    // In a real implementation, this would send feedback to your server
    await Future.delayed(const Duration(seconds: 1));
    print('📝 Feedback submitted: ${feedback.feedback}');
  }

  /// Save feedback queue to preferences
  Future<void> _saveFeedbackQueue() async {
    if (_prefs == null) return;

    final feedbackJson = _feedbackQueue.map((item) => item.toMap()).toList();
    await _prefs?.setString('feedback_queue', jsonEncode(feedbackJson));
  }

  /// Load feedback queue from preferences
  Future<void> _loadFeedbackQueue() async {
    if (_prefs == null) return;

    final feedbackJsonString = _prefs?.getString('feedback_queue');
    if (feedbackJsonString != null) {
      final feedbackJson = jsonDecode(feedbackJsonString) as List;
      _feedbackQueue.clear();
      _feedbackQueue.addAll(
        feedbackJson.map((item) => FeedbackItem.fromMap(item)).toList(),
      );
    }
  }

  /// Get beta testing statistics
  BetaTestingStatistics getStatistics() {
    if (!_isInitialized) {
      return BetaTestingStatistics(
        isBetaTester: false,
        enrollmentDate: null,
        totalFeatures: 0,
        enabledFeatures: 0,
        pendingFeedback: 0,
        totalFeedback: 0,
      );
    }

    final enabledFeatures = _betaFeatures.where((feature) => feature.isEnabled).length;
    final pendingFeedback = _feedbackQueue.where((item) => !item.isSubmitted).length;
    final enrollmentDateString = _prefs?.getString('beta_enrollment_date');
    final enrollmentDate = enrollmentDateString != null 
        ? DateTime.parse(enrollmentDateString) 
        : null;

    return BetaTestingStatistics(
      isBetaTester: isBetaTester(),
      enrollmentDate: enrollmentDate,
      totalFeatures: _betaFeatures.length,
      enabledFeatures: enabledFeatures,
      pendingFeedback: pendingFeedback,
      totalFeedback: _feedbackQueue.length,
    );
  }

  /// Get beta testing insights
  BetaTestingInsights getInsights() {
    if (!_isInitialized) {
      return BetaTestingInsights(
        mostUsedFeature: null,
        averageRating: 0.0,
        totalFeedback: 0,
        commonIssues: [],
      );
    }

    final submittedFeedback = _feedbackQueue.where((item) => item.isSubmitted).toList();
    final averageRating = submittedFeedback.isNotEmpty
        ? submittedFeedback.map((item) => item.rating).reduce((a, b) => a + b) / submittedFeedback.length
        : 0.0;

    // Find most used feature (simplified)
    final featureUsage = <String, int>{};
    for (final feedback in submittedFeedback) {
      featureUsage[feedback.featureId] = (featureUsage[feedback.featureId] ?? 0) + 1;
    }
    final mostUsedFeature = featureUsage.isNotEmpty
        ? featureUsage.entries.reduce((a, b) => a.value > b.value ? a : b).key
        : null;

    return BetaTestingInsights(
      mostUsedFeature: mostUsedFeature,
      averageRating: averageRating,
      totalFeedback: submittedFeedback.length,
      commonIssues: [], // Would be populated from server data
    );
  }

  /// Check if feedback is required for feature
  bool isFeedbackRequired(String featureId) {
    final feature = _betaFeatures.firstWhere(
      (feature) => feature.id == featureId,
      orElse: () => BetaFeature(
        id: featureId,
        name: '',
        description: '',
        isEnabled: false,
        feedbackRequired: false,
      ),
    );
    
    return feature.feedbackRequired;
  }

  /// Dispose resources
  void dispose() {
    _isInitialized = false;
  }
}

/// Beta feature model
class BetaFeature {
  final String id;
  final String name;
  final String description;
  final bool isEnabled;
  final bool feedbackRequired;

  BetaFeature({
    required this.id,
    required this.name,
    required this.description,
    required this.isEnabled,
    required this.feedbackRequired,
  });

  BetaFeature copyWith({
    String? id,
    String? name,
    String? description,
    bool? isEnabled,
    bool? feedbackRequired,
  }) {
    return BetaFeature(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      isEnabled: isEnabled ?? this.isEnabled,
      feedbackRequired: feedbackRequired ?? this.feedbackRequired,
    );
  }

  @override
  String toString() {
    return 'BetaFeature(id: $id, name: $name, isEnabled: $isEnabled)';
  }
}

/// Feedback item model
class FeedbackItem {
  final String id;
  final String featureId;
  final String feedback;
  final int rating;
  final DateTime timestamp;
  bool isSubmitted;

  FeedbackItem({
    required this.id,
    required this.featureId,
    required this.feedback,
    required this.rating,
    required this.timestamp,
    required this.isSubmitted,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'featureId': featureId,
      'feedback': feedback,
      'rating': rating,
      'timestamp': timestamp.toIso8601String(),
      'isSubmitted': isSubmitted,
    };
  }

  factory FeedbackItem.fromMap(Map<String, dynamic> map) {
    return FeedbackItem(
      id: map['id'],
      featureId: map['featureId'],
      feedback: map['feedback'],
      rating: map['rating'],
      timestamp: DateTime.parse(map['timestamp']),
      isSubmitted: map['isSubmitted'],
    );
  }
}

/// Bug report model
class BugReport {
  final String id;
  final String title;
  final String description;
  final String stepsToReproduce;
  final DateTime timestamp;
  final bool isSubmitted;
  final String appVersion;
  final String buildNumber;

  BugReport({
    required this.id,
    required this.title,
    required this.description,
    required this.stepsToReproduce,
    required this.timestamp,
    required this.isSubmitted,
    required this.appVersion,
    required this.buildNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'stepsToReproduce': stepsToReproduce,
      'timestamp': timestamp.toIso8601String(),
      'isSubmitted': isSubmitted,
      'appVersion': appVersion,
      'buildNumber': buildNumber,
    };
  }
}

/// Beta testing statistics
class BetaTestingStatistics {
  final bool isBetaTester;
  final DateTime? enrollmentDate;
  final int totalFeatures;
  final int enabledFeatures;
  final int pendingFeedback;
  final int totalFeedback;

  BetaTestingStatistics({
    required this.isBetaTester,
    required this.enrollmentDate,
    required this.totalFeatures,
    required this.enabledFeatures,
    required this.pendingFeedback,
    required this.totalFeedback,
  });

  @override
  String toString() {
    return 'BetaTestingStatistics(isBetaTester: $isBetaTester, enabledFeatures: $enabledFeatures/$totalFeatures)';
  }
}

/// Beta testing insights
class BetaTestingInsights {
  final String? mostUsedFeature;
  final double averageRating;
  final int totalFeedback;
  final List<String> commonIssues;

  BetaTestingInsights({
    required this.mostUsedFeature,
    required this.averageRating,
    required this.totalFeedback,
    required this.commonIssues,
  });

  @override
  String toString() {
    return 'BetaTestingInsights(mostUsed: $mostUsedFeature, rating: ${averageRating.toStringAsFixed(1)})';
  }
}

/// Beta testing exception
class BetaTestingException implements Exception {
  final String message;
  BetaTestingException(this.message);

  @override
  String toString() => 'BetaTestingException: $message';
}
