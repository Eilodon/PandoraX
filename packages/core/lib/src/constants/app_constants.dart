/// App Constants for Phase 4 Architecture
/// 
/// This file contains application-wide constants for consistent
/// configuration and behavior across the entire application.
library app_constants;

/// Application constants
class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();

  // ============================================================================
  // APP INFORMATION
  // ============================================================================
  
  /// App name
  static const String appName = 'Jarvis Notes';
  
  /// App version
  static const String appVersion = '1.0.0';
  
  /// App build number
  static const String appBuildNumber = '1';
  
  /// App description
  static const String appDescription = 'Smart notes app with AI integration';
  
  /// App author
  static const String appAuthor = 'Jarvis Team';
  
  /// App website
  static const String appWebsite = 'https://jarvis-notes.com';
  
  /// App support email
  static const String appSupportEmail = 'support@jarvis-notes.com';
  
  // ============================================================================
  // DATABASE
  // ============================================================================
  
  /// Database name
  static const String databaseName = 'jarvis_notes.db';
  
  /// Database version
  static const int databaseVersion = 1;
  
  /// Notes table name
  static const String notesTableName = 'notes';
  
  /// Users table name
  static const String usersTableName = 'users';
  
  /// Settings table name
  static const String settingsTableName = 'settings';
  
  /// Sync status table name
  static const String syncStatusTableName = 'sync_status';
  
  // ============================================================================
  // STORAGE KEYS
  // ============================================================================
  
  /// User preferences key
  static const String userPreferencesKey = 'user_preferences';
  
  /// Theme mode key
  static const String themeModeKey = 'theme_mode';
  
  /// Language key
  static const String languageKey = 'language';
  
  /// First launch key
  static const String firstLaunchKey = 'first_launch';
  
  /// Last sync key
  static const String lastSyncKey = 'last_sync';
  
  /// User ID key
  static const String userIdKey = 'user_id';
  
  /// Auth token key
  static const String authTokenKey = 'auth_token';
  
  /// Refresh token key
  static const String refreshTokenKey = 'refresh_token';
  
  /// Device ID key
  static const String deviceIdKey = 'device_id';
  
  /// App settings key
  static const String appSettingsKey = 'app_settings';
  
  /// AI settings key
  static const String aiSettingsKey = 'ai_settings';
  
  /// Notification settings key
  static const String notificationSettingsKey = 'notification_settings';
  
  /// Privacy settings key
  static const String privacySettingsKey = 'privacy_settings';
  
  // ============================================================================
  // API
  // ============================================================================
  
  /// Base API URL
  static const String baseApiUrl = 'https://api.jarvis-notes.com';
  
  /// API version
  static const String apiVersion = 'v1';
  
  /// API timeout duration in seconds
  static const int apiTimeoutSeconds = 30;
  
  /// API retry attempts
  static const int apiRetryAttempts = 3;
  
  /// API retry delay in milliseconds
  static const int apiRetryDelayMs = 1000;
  
  /// Notes endpoint
  static const String notesEndpoint = '/notes';
  
  /// Users endpoint
  static const String usersEndpoint = '/users';
  
  /// Auth endpoint
  static const String authEndpoint = '/auth';
  
  /// Sync endpoint
  static const String syncEndpoint = '/sync';
  
  /// AI endpoint
  static const String aiEndpoint = '/ai';
  
  /// Upload endpoint
  static const String uploadEndpoint = '/upload';
  
  /// Download endpoint
  static const String downloadEndpoint = '/download';
  
  // ============================================================================
  // UI
  // ============================================================================
  
  /// Default animation duration in milliseconds
  static const int defaultAnimationDurationMs = 300;
  
  /// Fast animation duration in milliseconds
  static const int fastAnimationDurationMs = 150;
  
  /// Slow animation duration in milliseconds
  static const int slowAnimationDurationMs = 500;
  
  /// Very slow animation duration in milliseconds
  static const int verySlowAnimationDurationMs = 1000;
  
  /// Default page size for pagination
  static const int defaultPageSize = 20;
  
  /// Maximum page size for pagination
  static const int maxPageSize = 100;
  
  /// Minimum page size for pagination
  static const int minPageSize = 5;
  
  /// Default search debounce delay in milliseconds
  static const int searchDebounceDelayMs = 500;
  
  /// Default pull-to-refresh threshold
  static const double pullToRefreshThreshold = 80.0;
  
  /// Default infinite scroll threshold
  static const double infiniteScrollThreshold = 200.0;
  
  /// Default snackbar duration in milliseconds
  static const int snackbarDurationMs = 4000;
  
  /// Default dialog animation duration in milliseconds
  static const int dialogAnimationDurationMs = 250;
  
  /// Default bottom sheet animation duration in milliseconds
  static const int bottomSheetAnimationDurationMs = 300;
  
  /// Default modal animation duration in milliseconds
  static const int modalAnimationDurationMs = 400;
  
  // ============================================================================
  // VALIDATION
  // ============================================================================
  
  /// Minimum password length
  static const int minPasswordLength = 8;
  
  /// Maximum password length
  static const int maxPasswordLength = 128;
  
  /// Minimum username length
  static const int minUsernameLength = 3;
  
  /// Maximum username length
  static const int maxUsernameLength = 50;
  
  /// Minimum note title length
  static const int minNoteTitleLength = 1;
  
  /// Maximum note title length
  static const int maxNoteTitleLength = 200;
  
  /// Minimum note content length
  static const int minNoteContentLength = 0;
  
  /// Maximum note content length
  static const int maxNoteContentLength = 100000;
  
  /// Maximum note tags count
  static const int maxNoteTagsCount = 10;
  
  /// Maximum note tag length
  static const int maxNoteTagLength = 50;
  
  /// Maximum note category length
  static const int maxNoteCategoryLength = 100;
  
  /// Maximum note description length
  static const int maxNoteDescriptionLength = 500;
  
  // ============================================================================
  // FILES
  // ============================================================================
  
  /// Maximum file size in bytes (10MB)
  static const int maxFileSizeBytes = 10 * 1024 * 1024;
  
  /// Maximum image size in bytes (5MB)
  static const int maxImageSizeBytes = 5 * 1024 * 1024;
  
  /// Maximum video size in bytes (50MB)
  static const int maxVideoSizeBytes = 50 * 1024 * 1024;
  
  /// Maximum audio size in bytes (20MB)
  static const int maxAudioSizeBytes = 20 * 1024 * 1024;
  
  /// Maximum document size in bytes (25MB)
  static const int maxDocumentSizeBytes = 25 * 1024 * 1024;
  
  /// Allowed image formats
  static const List<String> allowedImageFormats = [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'webp',
    'bmp',
    'tiff',
    'svg',
  ];
  
  /// Allowed video formats
  static const List<String> allowedVideoFormats = [
    'mp4',
    'avi',
    'mov',
    'wmv',
    'flv',
    'webm',
    'mkv',
    '3gp',
  ];
  
  /// Allowed audio formats
  static const List<String> allowedAudioFormats = [
    'mp3',
    'wav',
    'aac',
    'flac',
    'ogg',
    'wma',
    'm4a',
    'opus',
  ];
  
  /// Allowed document formats
  static const List<String> allowedDocumentFormats = [
    'pdf',
    'doc',
    'docx',
    'xls',
    'xlsx',
    'ppt',
    'pptx',
    'txt',
    'rtf',
    'odt',
    'ods',
    'odp',
  ];
  
  // ============================================================================
  // CACHING
  // ============================================================================
  
  /// Default cache duration in hours
  static const int defaultCacheDurationHours = 24;
  
  /// Long cache duration in hours
  static const int longCacheDurationHours = 168; // 1 week
  
  /// Short cache duration in hours
  static const int shortCacheDurationHours = 1;
  
  /// Maximum cache size in MB
  static const int maxCacheSizeMB = 100;
  
  /// Cache cleanup interval in hours
  static const int cacheCleanupIntervalHours = 24;
  
  // ============================================================================
  // SYNC
  // ============================================================================
  
  /// Default sync interval in minutes
  static const int defaultSyncIntervalMinutes = 15;
  
  /// Fast sync interval in minutes
  static const int fastSyncIntervalMinutes = 5;
  
  /// Slow sync interval in minutes
  static const int slowSyncIntervalMinutes = 60;
  
  /// Maximum sync retry attempts
  static const int maxSyncRetryAttempts = 5;
  
  /// Sync retry delay in milliseconds
  static const int syncRetryDelayMs = 2000;
  
  /// Maximum sync batch size
  static const int maxSyncBatchSize = 50;
  
  /// Sync timeout in seconds
  static const int syncTimeoutSeconds = 60;
  
  // ============================================================================
  // AI
  // ============================================================================
  
  /// AI model name
  static const String aiModelName = 'gpt-3.5-turbo';
  
  /// AI max tokens
  static const int aiMaxTokens = 2000;
  
  /// AI temperature
  static const double aiTemperature = 0.7;
  
  /// AI top p
  static const double aiTopP = 0.9;
  
  /// AI frequency penalty
  static const double aiFrequencyPenalty = 0.0;
  
  /// AI presence penalty
  static const double aiPresencePenalty = 0.0;
  
  /// AI timeout in seconds
  static const int aiTimeoutSeconds = 30;
  
  /// AI retry attempts
  static const int aiRetryAttempts = 3;
  
  /// AI retry delay in milliseconds
  static const int aiRetryDelayMs = 1000;
  
  // ============================================================================
  // NOTIFICATIONS
  // ============================================================================
  
  /// Default notification channel ID
  static const String defaultNotificationChannelId = 'default';
  
  /// Default notification channel name
  static const String defaultNotificationChannelName = 'Default Notifications';
  
  /// Default notification channel description
  static const String defaultNotificationChannelDescription = 'Default notification channel for the app';
  
  /// Sync notification channel ID
  static const String syncNotificationChannelId = 'sync';
  
  /// Sync notification channel name
  static const String syncNotificationChannelName = 'Sync Notifications';
  
  /// Sync notification channel description
  static const String syncNotificationChannelDescription = 'Notifications for sync operations';
  
  /// AI notification channel ID
  static const String aiNotificationChannelId = 'ai';
  
  /// AI notification channel name
  static const String aiNotificationChannelName = 'AI Notifications';
  
  /// AI notification channel description
  static const String aiNotificationChannelDescription = 'Notifications for AI operations';
  
  // ============================================================================
  // SECURITY
  // ============================================================================
  
  /// Minimum PIN length
  static const int minPinLength = 4;
  
  /// Maximum PIN length
  static const int maxPinLength = 8;
  
  /// Maximum failed login attempts
  static const int maxFailedLoginAttempts = 5;
  
  /// Account lockout duration in minutes
  static const int accountLockoutDurationMinutes = 15;
  
  /// Session timeout in minutes
  static const int sessionTimeoutMinutes = 30;
  
  /// Token refresh threshold in minutes
  static const int tokenRefreshThresholdMinutes = 5;
  
  /// Encryption key length
  static const int encryptionKeyLength = 32;
  
  /// Salt length
  static const int saltLength = 16;
  
  /// Hash iterations
  static const int hashIterations = 10000;
  
  // ============================================================================
  // ANALYTICS
  // ============================================================================
  
  /// Analytics enabled by default
  static const bool analyticsEnabledByDefault = true;
  
  /// Crash reporting enabled by default
  static const bool crashReportingEnabledByDefault = true;
  
  /// Performance monitoring enabled by default
  static const bool performanceMonitoringEnabledByDefault = true;
  
  /// User behavior tracking enabled by default
  static const bool userBehaviorTrackingEnabledByDefault = true;
  
  /// A/B testing enabled by default
  static const bool abTestingEnabledByDefault = false;
  
  /// Analytics batch size
  static const int analyticsBatchSize = 50;
  
  /// Analytics flush interval in seconds
  static const int analyticsFlushIntervalSeconds = 30;
  
  /// Analytics max queue size
  static const int analyticsMaxQueueSize = 1000;
  
  // ============================================================================
  // DEBUGGING
  // ============================================================================
  
  /// Debug mode enabled by default
  static const bool debugModeEnabledByDefault = false;
  
  /// Log level
  static const String logLevel = 'INFO';
  
  /// Maximum log file size in MB
  static const int maxLogFileSizeMB = 10;
  
  /// Maximum log files count
  static const int maxLogFilesCount = 5;
  
  /// Log rotation interval in hours
  static const int logRotationIntervalHours = 24;
  
  /// Performance profiling enabled by default
  static const bool performanceProfilingEnabledByDefault = false;
  
  /// Memory profiling enabled by default
  static const bool memoryProfilingEnabledByDefault = false;
  
  /// Network profiling enabled by default
  static const bool networkProfilingEnabledByDefault = false;
}
