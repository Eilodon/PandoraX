import 'dart:io';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Service for managing deployment configuration and environment settings
class DeploymentService {
  static final DeploymentService _instance = DeploymentService._internal();
  factory DeploymentService() => _instance;
  DeploymentService._internal();

  PackageInfo? _packageInfo;
  SharedPreferences? _prefs;
  final Connectivity _connectivity = Connectivity();
  
  DeploymentEnvironment _environment = DeploymentEnvironment.production;
  DeploymentConfig? _config;
  bool _isInitialized = false;

  /// Initialize the deployment service
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      _packageInfo = await PackageInfo.fromPlatform();
      _prefs = await SharedPreferences.getInstance();
      
      // Determine environment
      _environment = _determineEnvironment();
      
      // Load configuration
      _config = _loadConfiguration();
      
      // Setup environment-specific settings
      await _setupEnvironmentSettings();
      
      _isInitialized = true;
      print('🚀 Deployment service initialized: ${_environment.name}');
    } catch (e) {
      print('❌ Failed to initialize deployment service: $e');
      throw DeploymentException('Failed to initialize deployment: $e');
    }
  }

  /// Determine current deployment environment
  DeploymentEnvironment _determineEnvironment() {
    // Check environment variables
    const environment = String.fromEnvironment('ENVIRONMENT', defaultValue: 'production');
    
    switch (environment.toLowerCase()) {
      case 'development':
      case 'dev':
        return DeploymentEnvironment.development;
      case 'staging':
      case 'test':
        return DeploymentEnvironment.staging;
      case 'production':
      case 'prod':
        return DeploymentEnvironment.production;
      default:
        return DeploymentEnvironment.production;
    }
  }

  /// Load deployment configuration
  DeploymentConfig _loadConfiguration() {
    switch (_environment) {
      case DeploymentEnvironment.development:
        return _getDevelopmentConfig();
      case DeploymentEnvironment.staging:
        return _getStagingConfig();
      case DeploymentEnvironment.production:
        return _getProductionConfig();
    }
  }

  /// Get development configuration
  DeploymentConfig _getDevelopmentConfig() {
    return DeploymentConfig(
      environment: DeploymentEnvironment.development,
      apiBaseUrl: 'https://dev-api.pandora-notes.com',
      firebaseProjectId: 'pandora-notes-dev',
      analyticsEnabled: true,
      crashlyticsEnabled: true,
      loggingLevel: LoggingLevel.debug,
      debugMode: true,
      enableHotReload: true,
      enablePerformanceMonitoring: true,
      enableErrorReporting: true,
      enableAnalytics: true,
      enableCrashlytics: true,
      enableRemoteConfig: true,
      enableABTesting: false,
      enableBetaFeatures: true,
      enableDebugTools: true,
      enableTestData: true,
      enableMockServices: true,
      enableVerboseLogging: true,
      enableNetworkLogging: true,
      enableDatabaseLogging: true,
      enableServiceLogging: true,
    );
  }

  /// Get staging configuration
  DeploymentConfig _getStagingConfig() {
    return DeploymentConfig(
      environment: DeploymentEnvironment.staging,
      apiBaseUrl: 'https://staging-api.pandora-notes.com',
      firebaseProjectId: 'pandora-notes-staging',
      analyticsEnabled: true,
      crashlyticsEnabled: true,
      loggingLevel: LoggingLevel.info,
      debugMode: false,
      enableHotReload: false,
      enablePerformanceMonitoring: true,
      enableErrorReporting: true,
      enableAnalytics: true,
      enableCrashlytics: true,
      enableRemoteConfig: true,
      enableABTesting: true,
      enableBetaFeatures: true,
      enableDebugTools: false,
      enableTestData: false,
      enableMockServices: false,
      enableVerboseLogging: false,
      enableNetworkLogging: true,
      enableDatabaseLogging: false,
      enableServiceLogging: true,
    );
  }

  /// Get production configuration
  DeploymentConfig _getProductionConfig() {
    return DeploymentConfig(
      environment: DeploymentEnvironment.production,
      apiBaseUrl: 'https://api.pandora-notes.com',
      firebaseProjectId: 'pandora-notes-prod',
      analyticsEnabled: true,
      crashlyticsEnabled: true,
      loggingLevel: LoggingLevel.warning,
      debugMode: false,
      enableHotReload: false,
      enablePerformanceMonitoring: true,
      enableErrorReporting: true,
      enableAnalytics: true,
      enableCrashlytics: true,
      enableRemoteConfig: true,
      enableABTesting: true,
      enableBetaFeatures: false,
      enableDebugTools: false,
      enableTestData: false,
      enableMockServices: false,
      enableVerboseLogging: false,
      enableNetworkLogging: false,
      enableDatabaseLogging: false,
      enableServiceLogging: false,
    );
  }

  /// Setup environment-specific settings
  Future<void> _setupEnvironmentSettings() async {
    if (_config == null) return;

    // Set environment-specific preferences
    await _prefs?.setString('deployment_environment', _environment.name);
    await _prefs?.setString('api_base_url', _config!.apiBaseUrl);
    await _prefs?.setString('firebase_project_id', _config!.firebaseProjectId);
    await _prefs?.setBool('analytics_enabled', _config!.analyticsEnabled);
    await _prefs?.setBool('crashlytics_enabled', _config!.crashlyticsEnabled);
    await _prefs?.setString('logging_level', _config!.loggingLevel.name);
    await _prefs?.setBool('debug_mode', _config!.debugMode);
  }

  /// Get current deployment configuration
  DeploymentConfig getConfiguration() {
    if (!_isInitialized || _config == null) {
      throw DeploymentException('Service not initialized');
    }
    return _config!;
  }

  /// Get current environment
  DeploymentEnvironment getEnvironment() {
    return _environment;
  }

  /// Check if feature is enabled
  bool isFeatureEnabled(String featureName) {
    if (_config == null) return false;

    switch (featureName) {
      case 'analytics':
        return _config!.enableAnalytics;
      case 'crashlytics':
        return _config!.enableCrashlytics;
      case 'performance_monitoring':
        return _config!.enablePerformanceMonitoring;
      case 'error_reporting':
        return _config!.enableErrorReporting;
      case 'remote_config':
        return _config!.enableRemoteConfig;
      case 'ab_testing':
        return _config!.enableABTesting;
      case 'beta_features':
        return _config!.enableBetaFeatures;
      case 'debug_tools':
        return _config!.enableDebugTools;
      case 'test_data':
        return _config!.enableTestData;
      case 'mock_services':
        return _config!.enableMockServices;
      default:
        return false;
    }
  }

  /// Get API base URL
  String getApiBaseUrl() {
    return _config?.apiBaseUrl ?? 'https://api.pandora-notes.com';
  }

  /// Get Firebase project ID
  String getFirebaseProjectId() {
    return _config?.firebaseProjectId ?? 'pandora-notes-prod';
  }

  /// Check if debug mode is enabled
  bool isDebugMode() {
    return _config?.debugMode ?? false;
  }

  /// Check if analytics is enabled
  bool isAnalyticsEnabled() {
    return _config?.analyticsEnabled ?? false;
  }

  /// Check if crashlytics is enabled
  bool isCrashlyticsEnabled() {
    return _config?.crashlyticsEnabled ?? false;
  }

  /// Get logging level
  LoggingLevel getLoggingLevel() {
    return _config?.loggingLevel ?? LoggingLevel.warning;
  }

  /// Get deployment info
  DeploymentInfo getDeploymentInfo() {
    if (_packageInfo == null) {
      throw DeploymentException('Package info not available');
    }

    return DeploymentInfo(
      appName: _packageInfo!.appName,
      packageName: _packageInfo!.packageName,
      version: _packageInfo!.version,
      buildNumber: _packageInfo!.buildNumber,
      environment: _environment,
      platform: Platform.operatingSystem,
      isDebugMode: isDebugMode(),
      buildType: _getBuildType(),
      deploymentDate: _getDeploymentDate(),
    );
  }

  /// Get build type
  String _getBuildType() {
    if (isDebugMode()) return 'debug';
    return 'release';
  }

  /// Get deployment date
  DateTime _getDeploymentDate() {
    final installDate = _prefs?.getString('install_date');
    if (installDate != null) {
      return DateTime.parse(installDate);
    }
    return DateTime.now();
  }

  /// Check network connectivity
  Future<bool> isNetworkAvailable() async {
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      return connectivityResult != ConnectivityResult.none;
    } catch (e) {
      return false;
    }
  }

  /// Get environment-specific configuration value
  T getConfigValue<T>(String key, T defaultValue) {
    if (_config == null) return defaultValue;

    switch (key) {
      case 'api_base_url':
        return _config!.apiBaseUrl as T;
      case 'firebase_project_id':
        return _config!.firebaseProjectId as T;
      case 'analytics_enabled':
        return _config!.analyticsEnabled as T;
      case 'crashlytics_enabled':
        return _config!.crashlyticsEnabled as T;
      case 'debug_mode':
        return _config!.debugMode as T;
      case 'logging_level':
        return _config!.loggingLevel as T;
      default:
        return defaultValue;
    }
  }

  /// Update configuration at runtime
  Future<void> updateConfiguration(Map<String, dynamic> updates) async {
    if (_config == null) return;

    // Update configuration
    for (final entry in updates.entries) {
      switch (entry.key) {
        case 'analytics_enabled':
          _config = _config!.copyWith(analyticsEnabled: entry.value as bool);
          break;
        case 'crashlytics_enabled':
          _config = _config!.copyWith(crashlyticsEnabled: entry.value as bool);
          break;
        case 'debug_mode':
          _config = _config!.copyWith(debugMode: entry.value as bool);
          break;
        case 'logging_level':
          _config = _config!.copyWith(loggingLevel: entry.value as LoggingLevel);
          break;
      }
    }

    // Save to preferences
    await _setupEnvironmentSettings();
  }

  /// Dispose resources
  void dispose() {
    _isInitialized = false;
  }
}

/// Deployment environment enum
enum DeploymentEnvironment {
  development,
  staging,
  production,
}

/// Logging level enum
enum LoggingLevel {
  debug,
  info,
  warning,
  error,
}

/// Deployment configuration
class DeploymentConfig {
  final DeploymentEnvironment environment;
  final String apiBaseUrl;
  final String firebaseProjectId;
  final bool analyticsEnabled;
  final bool crashlyticsEnabled;
  final LoggingLevel loggingLevel;
  final bool debugMode;
  final bool enableHotReload;
  final bool enablePerformanceMonitoring;
  final bool enableErrorReporting;
  final bool enableAnalytics;
  final bool enableCrashlytics;
  final bool enableRemoteConfig;
  final bool enableABTesting;
  final bool enableBetaFeatures;
  final bool enableDebugTools;
  final bool enableTestData;
  final bool enableMockServices;
  final bool enableVerboseLogging;
  final bool enableNetworkLogging;
  final bool enableDatabaseLogging;
  final bool enableServiceLogging;

  DeploymentConfig({
    required this.environment,
    required this.apiBaseUrl,
    required this.firebaseProjectId,
    required this.analyticsEnabled,
    required this.crashlyticsEnabled,
    required this.loggingLevel,
    required this.debugMode,
    required this.enableHotReload,
    required this.enablePerformanceMonitoring,
    required this.enableErrorReporting,
    required this.enableAnalytics,
    required this.enableCrashlytics,
    required this.enableRemoteConfig,
    required this.enableABTesting,
    required this.enableBetaFeatures,
    required this.enableDebugTools,
    required this.enableTestData,
    required this.enableMockServices,
    required this.enableVerboseLogging,
    required this.enableNetworkLogging,
    required this.enableDatabaseLogging,
    required this.enableServiceLogging,
  });

  DeploymentConfig copyWith({
    DeploymentEnvironment? environment,
    String? apiBaseUrl,
    String? firebaseProjectId,
    bool? analyticsEnabled,
    bool? crashlyticsEnabled,
    LoggingLevel? loggingLevel,
    bool? debugMode,
    bool? enableHotReload,
    bool? enablePerformanceMonitoring,
    bool? enableErrorReporting,
    bool? enableAnalytics,
    bool? enableCrashlytics,
    bool? enableRemoteConfig,
    bool? enableABTesting,
    bool? enableBetaFeatures,
    bool? enableDebugTools,
    bool? enableTestData,
    bool? enableMockServices,
    bool? enableVerboseLogging,
    bool? enableNetworkLogging,
    bool? enableDatabaseLogging,
    bool? enableServiceLogging,
  }) {
    return DeploymentConfig(
      environment: environment ?? this.environment,
      apiBaseUrl: apiBaseUrl ?? this.apiBaseUrl,
      firebaseProjectId: firebaseProjectId ?? this.firebaseProjectId,
      analyticsEnabled: analyticsEnabled ?? this.analyticsEnabled,
      crashlyticsEnabled: crashlyticsEnabled ?? this.crashlyticsEnabled,
      loggingLevel: loggingLevel ?? this.loggingLevel,
      debugMode: debugMode ?? this.debugMode,
      enableHotReload: enableHotReload ?? this.enableHotReload,
      enablePerformanceMonitoring: enablePerformanceMonitoring ?? this.enablePerformanceMonitoring,
      enableErrorReporting: enableErrorReporting ?? this.enableErrorReporting,
      enableAnalytics: enableAnalytics ?? this.enableAnalytics,
      enableCrashlytics: enableCrashlytics ?? this.enableCrashlytics,
      enableRemoteConfig: enableRemoteConfig ?? this.enableRemoteConfig,
      enableABTesting: enableABTesting ?? this.enableABTesting,
      enableBetaFeatures: enableBetaFeatures ?? this.enableBetaFeatures,
      enableDebugTools: enableDebugTools ?? this.enableDebugTools,
      enableTestData: enableTestData ?? this.enableTestData,
      enableMockServices: enableMockServices ?? this.enableMockServices,
      enableVerboseLogging: enableVerboseLogging ?? this.enableVerboseLogging,
      enableNetworkLogging: enableNetworkLogging ?? this.enableNetworkLogging,
      enableDatabaseLogging: enableDatabaseLogging ?? this.enableDatabaseLogging,
      enableServiceLogging: enableServiceLogging ?? this.enableServiceLogging,
    );
  }

  @override
  String toString() {
    return 'DeploymentConfig(environment: ${environment.name}, apiBaseUrl: $apiBaseUrl, debugMode: $debugMode)';
  }
}

/// Deployment info
class DeploymentInfo {
  final String appName;
  final String packageName;
  final String version;
  final String buildNumber;
  final DeploymentEnvironment environment;
  final String platform;
  final bool isDebugMode;
  final String buildType;
  final DateTime deploymentDate;

  DeploymentInfo({
    required this.appName,
    required this.packageName,
    required this.version,
    required this.buildNumber,
    required this.environment,
    required this.platform,
    required this.isDebugMode,
    required this.buildType,
    required this.deploymentDate,
  });

  @override
  String toString() {
    return 'DeploymentInfo($appName $version, ${environment.name}, $platform)';
  }
}

/// Deployment exception
class DeploymentException implements Exception {
  final String message;
  DeploymentException(this.message);

  @override
  String toString() => 'DeploymentException: $message';
}
