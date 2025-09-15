import 'dart:io';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Service for managing app releases, versioning, and deployment
class ReleaseManagementService {
  static final ReleaseManagementService _instance = ReleaseManagementService._internal();
  factory ReleaseManagementService() => _instance;
  ReleaseManagementService._internal();

  PackageInfo? _packageInfo;
  SharedPreferences? _prefs;
  final Connectivity _connectivity = Connectivity();

  /// Initialize the release management service
  Future<void> initialize() async {
    try {
      _packageInfo = await PackageInfo.fromPlatform();
      _prefs = await SharedPreferences.getInstance();
      await _initializeReleaseData();
    } catch (e) {
      throw ReleaseManagementException('Failed to initialize release management: $e');
    }
  }

  /// Initialize release data and check for updates
  Future<void> _initializeReleaseData() async {
    if (_packageInfo == null) return;

    final currentVersion = _packageInfo!.version;
    final buildNumber = _packageInfo!.buildNumber;
    final lastKnownVersion = _prefs?.getString('last_known_version') ?? '0.0.0';
    final lastKnownBuild = _prefs?.getInt('last_known_build') ?? 0;

    // Check if this is a new version
    if (currentVersion != lastKnownVersion || buildNumber != lastKnownBuild) {
      await _handleNewVersion(currentVersion, buildNumber);
    }

    // Store current version info
    await _prefs?.setString('last_known_version', currentVersion);
    await _prefs?.setInt('last_known_build', buildNumber);
    await _prefs?.setString('app_name', _packageInfo!.appName);
    await _prefs?.setString('package_name', _packageInfo!.packageName);
  }

  /// Handle new version installation
  Future<void> _handleNewVersion(String version, int buildNumber) async {
    final installDate = DateTime.now().toIso8601String();
    await _prefs?.setString('install_date', installDate);
    await _prefs?.setString('version_install_date_$version', installDate);
    
    // Log version upgrade
    print('🚀 New version installed: $version ($buildNumber)');
    
    // Check if this is a major version upgrade
    final lastVersion = _prefs?.getString('last_known_version') ?? '0.0.0';
    if (_isMajorVersionUpgrade(lastVersion, version)) {
      await _handleMajorVersionUpgrade(version);
    }
  }

  /// Check if this is a major version upgrade
  bool _isMajorVersionUpgrade(String oldVersion, String newVersion) {
    try {
      final oldParts = oldVersion.split('.').map(int.parse).toList();
      final newParts = newVersion.split('.').map(int.parse).toList();
      
      return newParts[0] > oldParts[0] || 
             (newParts[0] == oldParts[0] && newParts[1] > oldParts[1]);
    } catch (e) {
      return false;
    }
  }

  /// Handle major version upgrade
  Future<void> _handleMajorVersionUpgrade(String version) async {
    // Clear old data if needed
    await _prefs?.setBool('major_upgrade_$version', true);
    
    // Show upgrade notification
    print('🎉 Major version upgrade to $version detected!');
  }

  /// Get current app version information
  AppVersionInfo getCurrentVersion() {
    if (_packageInfo == null) {
      throw ReleaseManagementException('Service not initialized');
    }

    return AppVersionInfo(
      version: _packageInfo!.version,
      buildNumber: _packageInfo!.buildNumber,
      appName: _packageInfo!.appName,
      packageName: _packageInfo!.packageName,
      installDate: _prefs?.getString('install_date'),
      lastUpdateDate: _prefs?.getString('version_install_date_${_packageInfo!.version}'),
    );
  }

  /// Check for app updates
  Future<UpdateCheckResult> checkForUpdates() async {
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return UpdateCheckResult(
          hasUpdate: false,
          isOnline: false,
          error: 'No internet connection',
        );
      }

      // In a real implementation, you would check with your update server
      // For now, we'll simulate the check
      final currentVersion = _packageInfo?.version ?? '1.0.0';
      final latestVersion = await _fetchLatestVersion();
      
      final hasUpdate = _compareVersions(currentVersion, latestVersion) < 0;
      
      return UpdateCheckResult(
        hasUpdate: hasUpdate,
        isOnline: true,
        currentVersion: currentVersion,
        latestVersion: latestVersion,
        updateUrl: hasUpdate ? _getUpdateUrl() : null,
      );
    } catch (e) {
      return UpdateCheckResult(
        hasUpdate: false,
        isOnline: true,
        error: 'Failed to check for updates: $e',
      );
    }
  }

  /// Fetch latest version from server
  Future<String> _fetchLatestVersion() async {
    // Simulate API call - in real implementation, call your update server
    await Future.delayed(const Duration(seconds: 1));
    return '1.0.1'; // Simulated latest version
  }

  /// Compare two version strings
  int _compareVersions(String version1, String version2) {
    final v1Parts = version1.split('.').map(int.parse).toList();
    final v2Parts = version2.split('.').map(int.parse).toList();
    
    for (int i = 0; i < 3; i++) {
      final v1Part = i < v1Parts.length ? v1Parts[i] : 0;
      final v2Part = i < v2Parts.length ? v2Parts[i] : 0;
      
      if (v1Part < v2Part) return -1;
      if (v1Part > v2Part) return 1;
    }
    
    return 0;
  }

  /// Get update URL
  String _getUpdateUrl() {
    if (Platform.isAndroid) {
      return 'https://play.google.com/store/apps/details?id=com.pandora.notes';
    } else if (Platform.isIOS) {
      return 'https://apps.apple.com/app/pandora-notes/id123456789';
    }
    return 'https://pandora-notes.com/download';
  }

  /// Get release notes for current version
  Future<String> getReleaseNotes() async {
    final version = _packageInfo?.version ?? '1.0.0';
    return _getReleaseNotesForVersion(version);
  }

  /// Get release notes for specific version
  String _getReleaseNotesForVersion(String version) {
    // In a real implementation, fetch from server
    return '''
## What's New in Version $version

### 🚀 New Features
- Enhanced AI chat experience
- Improved voice recognition
- Better cloud sync performance
- New notification system

### 🐛 Bug Fixes
- Fixed app crashes on startup
- Improved memory usage
- Better offline handling
- UI/UX improvements

### 🔧 Technical Improvements
- Performance optimizations
- Security enhancements
- Better error handling
- Updated dependencies
''';
  }

  /// Get app statistics
  Future<AppStatistics> getAppStatistics() async {
    final installDate = _prefs?.getString('install_date');
    final currentVersion = _packageInfo?.version ?? '1.0.0';
    final buildNumber = _packageInfo?.buildNumber ?? '1';
    
    return AppStatistics(
      installDate: installDate != null ? DateTime.parse(installDate) : null,
      currentVersion: currentVersion,
      buildNumber: buildNumber,
      totalSessions: _prefs?.getInt('total_sessions') ?? 0,
      lastSessionDate: _prefs?.getString('last_session_date'),
      isFirstLaunch: _prefs?.getBool('is_first_launch') ?? true,
    );
  }

  /// Record app session
  Future<void> recordSession() async {
    final currentSessions = _prefs?.getInt('total_sessions') ?? 0;
    await _prefs?.setInt('total_sessions', currentSessions + 1);
    await _prefs?.setString('last_session_date', DateTime.now().toIso8601String());
    await _prefs?.setBool('is_first_launch', false);
  }

  /// Get deployment configuration
  DeploymentConfig getDeploymentConfig() {
    return DeploymentConfig(
      environment: _getEnvironment(),
      buildType: _getBuildType(),
      isDebugMode: _isDebugMode(),
      isReleaseMode: _isReleaseMode(),
      isProfileMode: _isProfileMode(),
    );
  }

  /// Get current environment
  String _getEnvironment() {
    const environment = String.fromEnvironment('ENVIRONMENT', defaultValue: 'production');
    return environment;
  }

  /// Get build type
  String _getBuildType() {
    if (_isDebugMode()) return 'debug';
    if (_isProfileMode()) return 'profile';
    if (_isReleaseMode()) return 'release';
    return 'unknown';
  }

  /// Check if in debug mode
  bool _isDebugMode() {
    return bool.fromEnvironment('dart.vm.product') == false;
  }

  /// Check if in release mode
  bool _isReleaseMode() {
    return bool.fromEnvironment('dart.vm.product') == true;
  }

  /// Check if in profile mode
  bool _isProfileMode() {
    return !_isDebugMode() && !_isReleaseMode();
  }

  /// Dispose resources
  void dispose() {
    // Cleanup if needed
  }
}

/// App version information
class AppVersionInfo {
  final String version;
  final String buildNumber;
  final String appName;
  final String packageName;
  final String? installDate;
  final String? lastUpdateDate;

  AppVersionInfo({
    required this.version,
    required this.buildNumber,
    required this.appName,
    required this.packageName,
    this.installDate,
    this.lastUpdateDate,
  });

  @override
  String toString() {
    return 'AppVersionInfo(version: $version, buildNumber: $buildNumber, appName: $appName)';
  }
}

/// Update check result
class UpdateCheckResult {
  final bool hasUpdate;
  final bool isOnline;
  final String? currentVersion;
  final String? latestVersion;
  final String? updateUrl;
  final String? error;

  UpdateCheckResult({
    required this.hasUpdate,
    required this.isOnline,
    this.currentVersion,
    this.latestVersion,
    this.updateUrl,
    this.error,
  });

  @override
  String toString() {
    return 'UpdateCheckResult(hasUpdate: $hasUpdate, isOnline: $isOnline, error: $error)';
  }
}

/// App statistics
class AppStatistics {
  final DateTime? installDate;
  final String currentVersion;
  final String buildNumber;
  final int totalSessions;
  final String? lastSessionDate;
  final bool isFirstLaunch;

  AppStatistics({
    this.installDate,
    required this.currentVersion,
    required this.buildNumber,
    required this.totalSessions,
    this.lastSessionDate,
    required this.isFirstLaunch,
  });

  @override
  String toString() {
    return 'AppStatistics(version: $currentVersion, sessions: $totalSessions, firstLaunch: $isFirstLaunch)';
  }
}

/// Deployment configuration
class DeploymentConfig {
  final String environment;
  final String buildType;
  final bool isDebugMode;
  final bool isReleaseMode;
  final bool isProfileMode;

  DeploymentConfig({
    required this.environment,
    required this.buildType,
    required this.isDebugMode,
    required this.isReleaseMode,
    required this.isProfileMode,
  });

  @override
  String toString() {
    return 'DeploymentConfig(environment: $environment, buildType: $buildType)';
  }
}

/// Release management exception
class ReleaseManagementException implements Exception {
  final String message;
  ReleaseManagementException(this.message);

  @override
  String toString() => 'ReleaseManagementException: $message';
}
