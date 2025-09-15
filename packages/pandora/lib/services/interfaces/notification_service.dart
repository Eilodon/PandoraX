/// Abstract interface for notification services
abstract class NotificationService {
  /// Initialize the notification service
  Future<bool> initialize();

  /// Check if notifications are enabled
  Future<bool> get isEnabled;

  /// Request notification permissions
  Future<bool> requestPermission();

  /// Show immediate notification
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
    String? channelId,
    String? icon,
  });

  /// Schedule notification for specific time
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
    String? channelId,
    String? icon,
  });

  /// Schedule repeating notification
  Future<void> scheduleRepeatingNotification({
    required int id,
    required String title,
    required String body,
    required Duration repeatInterval,
    String? payload,
    String? channelId,
    String? icon,
  });

  /// Cancel specific notification
  Future<void> cancelNotification(int id);

  /// Cancel all notifications
  Future<void> cancelAllNotifications();

  /// Get pending notifications
  Future<List<Map<String, dynamic>>> getPendingNotifications();

  /// Create notification channel (Android)
  Future<void> createNotificationChannel({
    required String channelId,
    required String channelName,
    required String channelDescription,
    String? importance,
  });

  /// Stream of notification tap events
  Stream<String?> get onNotificationTap;

  /// Stream of notification received events
  Stream<Map<String, dynamic>> get onNotificationReceived;

  /// Dispose resources
  void dispose();
}
