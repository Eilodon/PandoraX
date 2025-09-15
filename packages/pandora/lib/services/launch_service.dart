import 'dart:async';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// Service for managing app launch, marketing, and user acquisition
class LaunchService {
  static final LaunchService _instance = LaunchService._internal();
  factory LaunchService() => _instance;
  LaunchService._internal();

  SharedPreferences? _prefs;
  PackageInfo? _packageInfo;
  final Connectivity _connectivity = Connectivity();
  bool _isInitialized = false;

  // Launch configuration
  final Map<String, LaunchCampaign> _campaigns = {
    'early_access': LaunchCampaign(
      id: 'early_access',
      name: 'Early Access',
      description: 'Exclusive early access to new features',
      isActive: true,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 30)),
    ),
    'referral_program': LaunchCampaign(
      id: 'referral_program',
      name: 'Referral Program',
      description: 'Invite friends and earn rewards',
      isActive: true,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 60)),
    ),
    'social_media': LaunchCampaign(
      id: 'social_media',
      name: 'Social Media Campaign',
      description: 'Follow us on social media for updates',
      isActive: true,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 90)),
    ),
  };

  final List<LaunchEvent> _launchEvents = [];

  /// Initialize the launch service
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      _prefs = await SharedPreferences.getInstance();
      _packageInfo = await PackageInfo.fromPlatform();
      await _loadLaunchState();
      _isInitialized = true;
    } catch (e) {
      throw LaunchException('Failed to initialize launch service: $e');
    }
  }

  /// Load launch state from preferences
  Future<void> _loadLaunchState() async {
    if (_prefs == null) return;

    // Load launch events
    final eventsJson = _prefs?.getString('launch_events');
    if (eventsJson != null) {
      // Parse and load events
    }
  }

  /// Check if app is in launch phase
  bool isInLaunchPhase() {
    if (!_isInitialized) return false;
    return _prefs?.getBool('is_in_launch_phase') ?? true;
  }

  /// Set launch phase status
  Future<void> setLaunchPhaseStatus(bool isInLaunchPhase) async {
    if (!_isInitialized) return;

    try {
      await _prefs?.setBool('is_in_launch_phase', isInLaunchPhase);
    } catch (e) {
      throw LaunchException('Failed to set launch phase status: $e');
    }
  }

  /// Get active campaigns
  List<LaunchCampaign> getActiveCampaigns() {
    final now = DateTime.now();
    return _campaigns.values.where((campaign) => 
      campaign.isActive && 
      campaign.startDate.isBefore(now) && 
      campaign.endDate.isAfter(now)
    ).toList();
  }

  /// Get campaign by ID
  LaunchCampaign? getCampaign(String campaignId) {
    return _campaigns[campaignId];
  }

  /// Track launch event
  Future<void> trackLaunchEvent(String eventType, {Map<String, dynamic>? parameters}) async {
    if (!_isInitialized) return;

    try {
      final event = LaunchEvent(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: eventType,
        parameters: parameters ?? {},
        timestamp: DateTime.now(),
        appVersion: _packageInfo?.version ?? '1.0.0',
        platform: Platform.operatingSystem,
      );

      _launchEvents.add(event);
      await _saveLaunchEvents();
    } catch (e) {
      throw LaunchException('Failed to track launch event: $e');
    }
  }

  /// Track user acquisition
  Future<void> trackUserAcquisition(String source, {String? campaign}) async {
    await trackLaunchEvent('user_acquisition', {
      'source': source,
      'campaign': campaign,
    });
  }

  /// Track feature usage
  Future<void> trackFeatureUsage(String featureName, {Map<String, dynamic>? parameters}) async {
    await trackLaunchEvent('feature_usage', {
      'feature': featureName,
      ...?parameters,
    });
  }

  /// Track user engagement
  Future<void> trackUserEngagement(String engagementType, {Map<String, dynamic>? parameters}) async {
    await trackLaunchEvent('user_engagement', {
      'engagement_type': engagementType,
      ...?parameters,
    });
  }

  /// Track conversion
  Future<void> trackConversion(String conversionType, {Map<String, dynamic>? parameters}) async {
    await trackLaunchEvent('conversion', {
      'conversion_type': conversionType,
      ...?parameters,
    });
  }

  /// Open app store for rating
  Future<void> openAppStoreForRating() async {
    try {
      String url;
      if (Platform.isAndroid) {
        url = 'https://play.google.com/store/apps/details?id=com.pandora.notes';
      } else if (Platform.isIOS) {
        url = 'https://apps.apple.com/app/pandora-notes/id123456789';
      } else {
        url = 'https://pandora-notes.com/download';
      }

      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      throw LaunchException('Failed to open app store: $e');
    }
  }

  /// Open social media
  Future<void> openSocialMedia(String platform) async {
    try {
      String url;
      switch (platform.toLowerCase()) {
        case 'twitter':
          url = 'https://twitter.com/pandora_notes';
          break;
        case 'facebook':
          url = 'https://facebook.com/pandora.notes';
          break;
        case 'instagram':
          url = 'https://instagram.com/pandora_notes';
          break;
        case 'linkedin':
          url = 'https://linkedin.com/company/pandora-notes';
          break;
        case 'youtube':
          url = 'https://youtube.com/@pandora_notes';
          break;
        default:
          url = 'https://pandora-notes.com';
      }

      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      throw LaunchException('Failed to open social media: $e');
    }
  }

  /// Open website
  Future<void> openWebsite({String? path}) async {
    try {
      final url = 'https://pandora-notes.com${path ?? ''}';
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      throw LaunchException('Failed to open website: $e');
    }
  }

  /// Open support
  Future<void> openSupport() async {
    try {
      final url = 'https://pandora-notes.com/support';
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      throw LaunchException('Failed to open support: $e');
    }
  }

  /// Open privacy policy
  Future<void> openPrivacyPolicy() async {
    try {
      final url = 'https://pandora-notes.com/privacy';
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      throw LaunchException('Failed to open privacy policy: $e');
    }
  }

  /// Open terms of service
  Future<void> openTermsOfService() async {
    try {
      final url = 'https://pandora-notes.com/terms';
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      throw LaunchException('Failed to open terms of service: $e');
    }
  }

  /// Share app
  Future<void> shareApp() async {
    try {
      final text = 'Check out Pandora Notes - AI-powered note-taking app! '
          'Download now: https://pandora-notes.com/download';
      
      // In a real implementation, use share_plus package
      print('📱 Share text: $text');
    } catch (e) {
      throw LaunchException('Failed to share app: $e');
    }
  }

  /// Get launch statistics
  LaunchStatistics getStatistics() {
    if (!_isInitialized) {
      return LaunchStatistics(
        totalEvents: 0,
        userAcquisitions: 0,
        featureUsages: 0,
        conversions: 0,
        activeCampaigns: 0,
      );
    }

    final userAcquisitions = _launchEvents.where((event) => event.type == 'user_acquisition').length;
    final featureUsages = _launchEvents.where((event) => event.type == 'feature_usage').length;
    final conversions = _launchEvents.where((event) => event.type == 'conversion').length;
    final activeCampaigns = getActiveCampaigns().length;

    return LaunchStatistics(
      totalEvents: _launchEvents.length,
      userAcquisitions: userAcquisitions,
      featureUsages: featureUsages,
      conversions: conversions,
      activeCampaigns: activeCampaigns,
    );
  }

  /// Get launch insights
  LaunchInsights getInsights() {
    if (!_isInitialized) {
      return LaunchInsights(
        topAcquisitionSource: null,
        topFeature: null,
        conversionRate: 0.0,
        engagementRate: 0.0,
      );
    }

    // Calculate top acquisition source
    final acquisitionEvents = _launchEvents.where((event) => event.type == 'user_acquisition').toList();
    final sourceCounts = <String, int>{};
    for (final event in acquisitionEvents) {
      final source = event.parameters['source'] as String? ?? 'unknown';
      sourceCounts[source] = (sourceCounts[source] ?? 0) + 1;
    }
    final topAcquisitionSource = sourceCounts.isNotEmpty
        ? sourceCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key
        : null;

    // Calculate top feature
    final featureEvents = _launchEvents.where((event) => event.type == 'feature_usage').toList();
    final featureCounts = <String, int>{};
    for (final event in featureEvents) {
      final feature = event.parameters['feature'] as String? ?? 'unknown';
      featureCounts[feature] = (featureCounts[feature] ?? 0) + 1;
    }
    final topFeature = featureCounts.isNotEmpty
        ? featureCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key
        : null;

    // Calculate conversion rate
    final totalUsers = acquisitionEvents.length;
    final conversions = _launchEvents.where((event) => event.type == 'conversion').length;
    final conversionRate = totalUsers > 0 ? conversions / totalUsers : 0.0;

    // Calculate engagement rate (simplified)
    final engagementEvents = _launchEvents.where((event) => event.type == 'user_engagement').length;
    final engagementRate = totalUsers > 0 ? engagementEvents / totalUsers : 0.0;

    return LaunchInsights(
      topAcquisitionSource: topAcquisitionSource,
      topFeature: topFeature,
      conversionRate: conversionRate,
      engagementRate: engagementRate,
    );
  }

  /// Save launch events to preferences
  Future<void> _saveLaunchEvents() async {
    if (_prefs == null) return;

    final eventsJson = _launchEvents.map((event) => event.toMap()).toList();
    await _prefs?.setString('launch_events', jsonEncode(eventsJson));
  }

  /// Load launch events from preferences
  Future<void> _loadLaunchEvents() async {
    if (_prefs == null) return;

    final eventsJsonString = _prefs?.getString('launch_events');
    if (eventsJsonString != null) {
      final eventsJson = jsonDecode(eventsJsonString) as List;
      _launchEvents.clear();
      _launchEvents.addAll(
        eventsJson.map((event) => LaunchEvent.fromMap(event)).toList(),
      );
    }
  }

  /// Dispose resources
  void dispose() {
    _isInitialized = false;
  }
}

/// Launch campaign model
class LaunchCampaign {
  final String id;
  final String name;
  final String description;
  final bool isActive;
  final DateTime startDate;
  final DateTime endDate;

  LaunchCampaign({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
    required this.startDate,
    required this.endDate,
  });

  @override
  String toString() {
    return 'LaunchCampaign(id: $id, name: $name, isActive: $isActive)';
  }
}

/// Launch event model
class LaunchEvent {
  final String id;
  final String type;
  final Map<String, dynamic> parameters;
  final DateTime timestamp;
  final String appVersion;
  final String platform;

  LaunchEvent({
    required this.id,
    required this.type,
    required this.parameters,
    required this.timestamp,
    required this.appVersion,
    required this.platform,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'parameters': parameters,
      'timestamp': timestamp.toIso8601String(),
      'appVersion': appVersion,
      'platform': platform,
    };
  }

  factory LaunchEvent.fromMap(Map<String, dynamic> map) {
    return LaunchEvent(
      id: map['id'],
      type: map['type'],
      parameters: Map<String, dynamic>.from(map['parameters']),
      timestamp: DateTime.parse(map['timestamp']),
      appVersion: map['appVersion'],
      platform: map['platform'],
    );
  }
}

/// Launch statistics
class LaunchStatistics {
  final int totalEvents;
  final int userAcquisitions;
  final int featureUsages;
  final int conversions;
  final int activeCampaigns;

  LaunchStatistics({
    required this.totalEvents,
    required this.userAcquisitions,
    required this.featureUsages,
    required this.conversions,
    required this.activeCampaigns,
  });

  @override
  String toString() {
    return 'LaunchStatistics(events: $totalEvents, acquisitions: $userAcquisitions, conversions: $conversions)';
  }
}

/// Launch insights
class LaunchInsights {
  final String? topAcquisitionSource;
  final String? topFeature;
  final double conversionRate;
  final double engagementRate;

  LaunchInsights({
    required this.topAcquisitionSource,
    required this.topFeature,
    required this.conversionRate,
    required this.engagementRate,
  });

  @override
  String toString() {
    return 'LaunchInsights(topSource: $topAcquisitionSource, topFeature: $topFeature, conversion: ${(conversionRate * 100).toStringAsFixed(1)}%)';
  }
}

/// Launch exception
class LaunchException implements Exception {
  final String message;
  LaunchException(this.message);

  @override
  String toString() => 'LaunchException: $message';
}
