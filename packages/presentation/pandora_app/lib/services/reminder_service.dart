import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:core_utils/core_utils.dart';
import 'package:common_entities/common_entities.dart';

/// Service for managing reminders and notifications
class ReminderService {
  static final ReminderService _instance = ReminderService._internal();
  factory ReminderService() => _instance;
  ReminderService._internal();

  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();
  final List<Reminder> _reminders = [];
  Timer? _checkTimer;

  /// Initialize the reminder service
  Future<void> initialize() async {
    try {
      AppLogger.info('🔔 Initializing reminder service...');
      
      // Initialize timezone
      tz.initializeTimeZones();
      
      // Request notification permission
      await _requestNotificationPermission();
      
      // Initialize local notifications
      await _initializeNotifications();
      
      // Start checking for due reminders
      _startReminderChecker();
      
      AppLogger.success('✅ Reminder service initialized');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to initialize reminder service', e, stackTrace);
      rethrow;
    }
  }

  /// Request notification permission
  Future<void> _requestNotificationPermission() async {
    final status = await Permission.notification.request();
    if (status != PermissionStatus.granted) {
      AppLogger.warning('Notification permission not granted');
    }
  }

  /// Initialize local notifications
  Future<void> _initializeNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
  }

  /// Handle notification tap
  void _onNotificationTapped(NotificationResponse response) {
    AppLogger.info('🔔 Notification tapped: ${response.payload}');
    // Handle notification tap - could navigate to specific note
  }

  /// Start checking for due reminders
  void _startReminderChecker() {
    _checkTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _checkDueReminders();
    });
  }

  /// Check for due reminders
  Future<void> _checkDueReminders() async {
    final now = DateTime.now();
    for (final reminder in _reminders) {
      if (reminder.isActive && 
          reminder.status is PendingReminder &&
          reminder.scheduledTime.isBefore(now)) {
        await _triggerReminder(reminder);
      }
    }
  }

  /// Trigger a reminder
  Future<void> _triggerReminder(Reminder reminder) async {
    try {
      AppLogger.info('🔔 Triggering reminder: ${reminder.title}');
      
      // Show notification
      await _showNotification(reminder);
      
      // Update reminder status
      final updatedReminder = reminder.copyWith(
        status: const ReminderStatus.triggered(),
        updatedAt: DateTime.now(),
      );
      
      final index = _reminders.indexWhere((r) => r.id == reminder.id);
      if (index != -1) {
        _reminders[index] = updatedReminder;
      }
      
      // Handle repeat
      await _handleReminderRepeat(reminder);
      
    } catch (e, stackTrace) {
      AppLogger.error('Failed to trigger reminder', e, stackTrace);
    }
  }

  /// Show notification
  Future<void> _showNotification(Reminder reminder) async {
    const androidDetails = AndroidNotificationDetails(
      'pandora_reminders',
      'PandoraX Reminders',
      channelDescription: 'Reminders for your notes',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
      enableVibration: true,
      playSound: true,
    );
    
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      reminder.id.hashCode,
      reminder.title,
      reminder.description,
      details,
      payload: reminder.noteId,
    );
  }

  /// Handle reminder repeat
  Future<void> _handleReminderRepeat(Reminder reminder) async {
    if (reminder.repeatDays.isNotEmpty) {
      final nextTime = _calculateNextReminderTime(reminder);
      if (nextTime != null) {
        final updatedReminder = reminder.copyWith(
          scheduledTime: nextTime,
          status: const ReminderStatus.pending(),
          updatedAt: DateTime.now(),
        );
        
        final index = _reminders.indexWhere((r) => r.id == reminder.id);
        if (index != -1) {
          _reminders[index] = updatedReminder;
        }
      }
    }
  }

  /// Calculate next reminder time based on repeat settings
  DateTime? _calculateNextReminderTime(Reminder reminder) {
    final now = DateTime.now();
    final currentTime = reminder.scheduledTime;
    
    for (final repeat in reminder.repeatDays) {
      switch (repeat) {
        case DailyRepeat():
          return DateTime(
            now.year,
            now.month,
            now.day,
            currentTime.hour,
            currentTime.minute,
          ).add(const Duration(days: 1));
          
        case WeeklyRepeat():
          return DateTime(
            now.year,
            now.month,
            now.day,
            currentTime.hour,
            currentTime.minute,
          ).add(const Duration(days: 7));
          
        case MonthlyRepeat():
          return DateTime(
            now.year,
            now.month + 1,
            now.day,
            currentTime.hour,
            currentTime.minute,
          );
          
        case YearlyRepeat():
          return DateTime(
            now.year + 1,
            now.month,
            now.day,
            currentTime.hour,
            currentTime.minute,
          );
          
        case CustomRepeat():
          // Calculate next occurrence based on days of week
          final daysOfWeek = repeat.daysOfWeek;
          final currentDayOfWeek = now.weekday;
          
          for (int i = 1; i <= 7; i++) {
            final nextDay = (currentDayOfWeek + i - 1) % 7;
            if (daysOfWeek.contains(nextDay)) {
              return DateTime(
                now.year,
                now.month,
                now.day + i,
                currentTime.hour,
                currentTime.minute,
              );
            }
          }
          break;
      }
    }
    
    return null;
  }

  /// Create a new reminder
  Future<String> createReminder(Reminder reminder) async {
    try {
      AppLogger.info('🔔 Creating reminder: ${reminder.title}');
      
      final newReminder = reminder.copyWith(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      _reminders.add(newReminder);
      
      // Schedule notification
      await _scheduleNotification(newReminder);
      
      AppLogger.success('✅ Reminder created: ${newReminder.id}');
      return newReminder.id;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to create reminder', e, stackTrace);
      rethrow;
    }
  }

  /// Schedule notification
  Future<void> _scheduleNotification(Reminder reminder) async {
    const androidDetails = AndroidNotificationDetails(
      'pandora_reminders',
      'PandoraX Reminders',
      channelDescription: 'Reminders for your notes',
      importance: Importance.high,
      priority: Priority.high,
    );
    
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.zonedSchedule(
      reminder.id.hashCode,
      reminder.title,
      reminder.description,
      tz.TZDateTime.from(reminder.scheduledTime, tz.local),
      details,
      payload: reminder.noteId,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  /// Update a reminder
  Future<void> updateReminder(Reminder reminder) async {
    try {
      AppLogger.info('🔔 Updating reminder: ${reminder.id}');
      
      final index = _reminders.indexWhere((r) => r.id == reminder.id);
      if (index != -1) {
        _reminders[index] = reminder.copyWith(updatedAt: DateTime.now());
        
        // Cancel old notification and schedule new one
        await _notifications.cancel(reminder.id.hashCode);
        await _scheduleNotification(reminder);
        
        AppLogger.success('✅ Reminder updated: ${reminder.id}');
      }
    } catch (e, stackTrace) {
      AppLogger.error('Failed to update reminder', e, stackTrace);
      rethrow;
    }
  }

  /// Delete a reminder
  Future<void> deleteReminder(String reminderId) async {
    try {
      AppLogger.info('🔔 Deleting reminder: $reminderId');
      
      _reminders.removeWhere((r) => r.id == reminderId);
      await _notifications.cancel(reminderId.hashCode);
      
      AppLogger.success('✅ Reminder deleted: $reminderId');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to delete reminder', e, stackTrace);
      rethrow;
    }
  }

  /// Get all reminders
  List<Reminder> getAllReminders() {
    return List.from(_reminders);
  }

  /// Get reminders for a specific note
  List<Reminder> getRemindersForNote(String noteId) {
    return _reminders.where((r) => r.noteId == noteId).toList();
  }

  /// Get active reminders
  List<Reminder> getActiveReminders() {
    return _reminders.where((r) => r.isActive).toList();
  }

  /// Get upcoming reminders
  List<Reminder> getUpcomingReminders({int limit = 10}) {
    final now = DateTime.now();
    final upcoming = _reminders
        .where((r) => r.isActive && r.scheduledTime.isAfter(now))
        .toList();
    
    upcoming.sort((a, b) => a.scheduledTime.compareTo(b.scheduledTime));
    return upcoming.take(limit).toList();
  }

  /// Toggle reminder active status
  Future<void> toggleReminderActive(String reminderId) async {
    try {
      final index = _reminders.indexWhere((r) => r.id == reminderId);
      if (index != -1) {
        final reminder = _reminders[index];
        final updatedReminder = reminder.copyWith(
          isActive: !reminder.isActive,
          updatedAt: DateTime.now(),
        );
        
        _reminders[index] = updatedReminder;
        
        if (updatedReminder.isActive) {
          await _scheduleNotification(updatedReminder);
        } else {
          await _notifications.cancel(reminderId.hashCode);
        }
        
        AppLogger.success('✅ Reminder toggled: $reminderId');
      }
    } catch (e, stackTrace) {
      AppLogger.error('Failed to toggle reminder', e, stackTrace);
      rethrow;
    }
  }

  /// Dispose the service
  void dispose() {
    _checkTimer?.cancel();
    _notifications.cancelAll();
  }
}
