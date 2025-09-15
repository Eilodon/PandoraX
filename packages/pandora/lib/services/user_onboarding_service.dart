import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Service for managing user onboarding flow and tutorials
class UserOnboardingService {
  static final UserOnboardingService _instance = UserOnboardingService._internal();
  factory UserOnboardingService() => _instance;
  UserOnboardingService._internal();

  SharedPreferences? _prefs;
  PackageInfo? _packageInfo;
  bool _isInitialized = false;

  // Onboarding steps
  final List<OnboardingStep> _onboardingSteps = [
    OnboardingStep(
      id: 'welcome',
      title: 'Welcome to Pandora Notes',
      description: 'Your AI-powered note-taking companion',
      icon: '🎉',
      isCompleted: false,
    ),
    OnboardingStep(
      id: 'ai_features',
      title: 'AI-Powered Intelligence',
      description: 'Smart suggestions and content enhancement',
      icon: '🤖',
      isCompleted: false,
    ),
    OnboardingStep(
      id: 'voice_notes',
      title: 'Voice Notes',
      description: 'Create notes with your voice',
      icon: '🎤',
      isCompleted: false,
    ),
    OnboardingStep(
      id: 'cloud_sync',
      title: 'Cloud Sync',
      description: 'Access your notes anywhere',
      icon: '☁️',
      isCompleted: false,
    ),
    OnboardingStep(
      id: 'notifications',
      title: 'Smart Notifications',
      description: 'Never miss important reminders',
      icon: '🔔',
      isCompleted: false,
    ),
    OnboardingStep(
      id: 'privacy',
      title: 'Privacy & Security',
      description: 'Your data is encrypted and secure',
      icon: '🛡️',
      isCompleted: false,
    ),
  ];

  /// Initialize the onboarding service
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      _prefs = await SharedPreferences.getInstance();
      _packageInfo = await PackageInfo.fromPlatform();
      await _loadOnboardingState();
      _isInitialized = true;
    } catch (e) {
      throw OnboardingException('Failed to initialize onboarding: $e');
    }
  }

  /// Load onboarding state from preferences
  Future<void> _loadOnboardingState() async {
    if (_prefs == null) return;

    for (int i = 0; i < _onboardingSteps.length; i++) {
      final step = _onboardingSteps[i];
      final isCompleted = _prefs!.getBool('onboarding_${step.id}') ?? false;
      _onboardingSteps[i] = step.copyWith(isCompleted: isCompleted);
    }
  }

  /// Check if user has completed onboarding
  bool isOnboardingCompleted() {
    if (!_isInitialized) return false;
    return _onboardingSteps.every((step) => step.isCompleted);
  }

  /// Check if this is the first app launch
  bool isFirstLaunch() {
    if (!_isInitialized) return true;
    return _prefs?.getBool('is_first_launch') ?? true;
  }

  /// Get current onboarding step
  OnboardingStep? getCurrentStep() {
    if (!_isInitialized) return null;
    
    final incompleteStep = _onboardingSteps.firstWhere(
      (step) => !step.isCompleted,
      orElse: () => _onboardingSteps.last,
    );
    
    return incompleteStep;
  }

  /// Get all onboarding steps
  List<OnboardingStep> getAllSteps() {
    return List.from(_onboardingSteps);
  }

  /// Complete a specific onboarding step
  Future<void> completeStep(String stepId) async {
    if (!_isInitialized) return;

    try {
      final stepIndex = _onboardingSteps.indexWhere((step) => step.id == stepId);
      if (stepIndex == -1) return;

      _onboardingSteps[stepIndex] = _onboardingSteps[stepIndex].copyWith(isCompleted: true);
      await _prefs?.setBool('onboarding_$stepId', true);
      
      // Mark first launch as completed
      if (stepId == 'welcome') {
        await _prefs?.setBool('is_first_launch', false);
      }
    } catch (e) {
      throw OnboardingException('Failed to complete step $stepId: $e');
    }
  }

  /// Skip onboarding
  Future<void> skipOnboarding() async {
    if (!_isInitialized) return;

    try {
      for (final step in _onboardingSteps) {
        await _prefs?.setBool('onboarding_${step.id}', true);
      }
      await _prefs?.setBool('is_first_launch', false);
      await _prefs?.setBool('onboarding_skipped', true);
    } catch (e) {
      throw OnboardingException('Failed to skip onboarding: $e');
    }
  }

  /// Reset onboarding
  Future<void> resetOnboarding() async {
    if (!_isInitialized) return;

    try {
      for (final step in _onboardingSteps) {
        await _prefs?.setBool('onboarding_${step.id}', false);
      }
      await _prefs?.setBool('onboarding_skipped', false);
    } catch (e) {
      throw OnboardingException('Failed to reset onboarding: $e');
    }
  }

  /// Get onboarding progress percentage
  double getProgressPercentage() {
    if (!_isInitialized) return 0.0;
    
    final completedSteps = _onboardingSteps.where((step) => step.isCompleted).length;
    return completedSteps / _onboardingSteps.length;
  }

  /// Get next step after current one
  OnboardingStep? getNextStep() {
    if (!_isInitialized) return null;
    
    final currentStep = getCurrentStep();
    if (currentStep == null) return null;
    
    final currentIndex = _onboardingSteps.indexOf(currentStep);
    if (currentIndex == -1 || currentIndex >= _onboardingSteps.length - 1) {
      return null;
    }
    
    return _onboardingSteps[currentIndex + 1];
  }

  /// Get previous step before current one
  OnboardingStep? getPreviousStep() {
    if (!_isInitialized) return null;
    
    final currentStep = getCurrentStep();
    if (currentStep == null) return null;
    
    final currentIndex = _onboardingSteps.indexOf(currentStep);
    if (currentIndex <= 0) return null;
    
    return _onboardingSteps[currentIndex - 1];
  }

  /// Check if step is completed
  bool isStepCompleted(String stepId) {
    if (!_isInitialized) return false;
    
    final step = _onboardingSteps.firstWhere(
      (step) => step.id == stepId,
      orElse: () => OnboardingStep(
        id: stepId,
        title: '',
        description: '',
        icon: '',
        isCompleted: false,
      ),
    );
    
    return step.isCompleted;
  }

  /// Get onboarding statistics
  OnboardingStatistics getStatistics() {
    if (!_isInitialized) {
      return OnboardingStatistics(
        totalSteps: 0,
        completedSteps: 0,
        progressPercentage: 0.0,
        isCompleted: false,
        isFirstLaunch: true,
        isSkipped: false,
      );
    }

    final completedSteps = _onboardingSteps.where((step) => step.isCompleted).length;
    final isSkipped = _prefs?.getBool('onboarding_skipped') ?? false;
    
    return OnboardingStatistics(
      totalSteps: _onboardingSteps.length,
      completedSteps: completedSteps,
      progressPercentage: getProgressPercentage(),
      isCompleted: isOnboardingCompleted(),
      isFirstLaunch: isFirstLaunch(),
      isSkipped: isSkipped,
    );
  }

  /// Show onboarding if needed
  bool shouldShowOnboarding() {
    if (!_isInitialized) return true;
    return !isOnboardingCompleted() && !isFirstLaunch();
  }

  /// Get onboarding completion date
  DateTime? getCompletionDate() {
    if (!_isInitialized) return null;
    
    final completionDateString = _prefs?.getString('onboarding_completion_date');
    if (completionDateString != null) {
      return DateTime.parse(completionDateString);
    }
    return null;
  }

  /// Set onboarding completion date
  Future<void> setCompletionDate() async {
    if (!_isInitialized) return;
    
    await _prefs?.setString(
      'onboarding_completion_date',
      DateTime.now().toIso8601String(),
    );
  }

  /// Get onboarding version (for tracking changes)
  String getOnboardingVersion() {
    return _packageInfo?.version ?? '1.0.0';
  }

  /// Check if onboarding needs update
  bool needsOnboardingUpdate() {
    if (!_isInitialized) return false;
    
    final lastOnboardingVersion = _prefs?.getString('last_onboarding_version');
    final currentVersion = getOnboardingVersion();
    
    return lastOnboardingVersion != currentVersion;
  }

  /// Update onboarding version
  Future<void> updateOnboardingVersion() async {
    if (!_isInitialized) return;
    
    await _prefs?.setString('last_onboarding_version', getOnboardingVersion());
  }

  /// Dispose resources
  void dispose() {
    _isInitialized = false;
  }
}

/// Onboarding step model
class OnboardingStep {
  final String id;
  final String title;
  final String description;
  final String icon;
  final bool isCompleted;

  OnboardingStep({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.isCompleted,
  });

  OnboardingStep copyWith({
    String? id,
    String? title,
    String? description,
    String? icon,
    bool? isCompleted,
  }) {
    return OnboardingStep(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  String toString() {
    return 'OnboardingStep(id: $id, title: $title, isCompleted: $isCompleted)';
  }
}

/// Onboarding statistics
class OnboardingStatistics {
  final int totalSteps;
  final int completedSteps;
  final double progressPercentage;
  final bool isCompleted;
  final bool isFirstLaunch;
  final bool isSkipped;

  OnboardingStatistics({
    required this.totalSteps,
    required this.completedSteps,
    required this.progressPercentage,
    required this.isCompleted,
    required this.isFirstLaunch,
    required this.isSkipped,
  });

  @override
  String toString() {
    return 'OnboardingStatistics(completed: $completedSteps/$totalSteps, progress: ${(progressPercentage * 100).toStringAsFixed(1)}%)';
  }
}

/// Onboarding exception
class OnboardingException implements Exception {
  final String message;
  OnboardingException(this.message);

  @override
  String toString() => 'OnboardingException: $message';
}
