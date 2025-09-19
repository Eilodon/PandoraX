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
    AppLogger.info('🔔 Initializing ReminderService...');
    
    // Initialize timezone
    tz.initializeTimeZones();
    
    // Request notification permission
    await _requestNotificationPermission();
    
    // Initialize notifications
    await _initializeNotifications();
    
    // Start checking for due reminders
    _startReminderCheck();
    
    AppLogger.success('✅ ReminderService initialized');
  }

  /// Request notification permission
  Future<void> _requestNotificationPermission() async {
    final status = await Permission.notification.request();
    if (status.isDenied) {
      AppLogger.warning('⚠️ Notification permission denied');
    }
  }

  /// Initialize local notifications
  Future<void> _initializeNotifications() async {
    AppLogger.info('🔔 Initializing notifications...');
    
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    
    await _notifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
    
    AppLogger.info('✅ Notifications initialized successfully');
  }

  /// Handle notification tap
  void _onNotificationTapped(NotificationResponse response) {
    AppLogger.info('🔔 Notification tapped: ${response.payload ?? 'N/A'}');
    // Handle notification tap logic here
  }

  /// Start checking for due reminders
  void _startReminderCheck() {
    _checkTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _checkDueReminders();
    });
  }

  /// Check for due reminders
  void _checkDueReminders() {
    final now = DateTime.now();
    for (final reminder in _reminders) {
      if (_isReminderDue(reminder, now)) {
        _triggerReminder(reminder);
      }
    }
  }

  /// Check if a reminder is due
  bool _isReminderDue(Reminder reminder, DateTime now) {
    return reminder.isActive && 
           reminder.scheduledTime.isBefore(now) && 
           reminder.status == const ReminderStatus.pending();
  }

  /// Trigger a reminder
  void _triggerReminder(Reminder reminder) {
    AppLogger.info('🔔 Triggering reminder: ${reminder.title}');
    _showNotification(reminder);
    _updateReminderStatus(reminder, const ReminderStatus.triggered());
  }

  /// Show notification for reminder
  Future<void> _showNotification(Reminder reminder) async {
    AppLogger.info('🔔 Showing notification for reminder: ${reminder.title}');
    
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'reminder_channel',
      'Reminders',
      channelDescription: 'Notifications for reminders and notes',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );
    
    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    
    await _notifications.show(
      reminder.id.hashCode,
      reminder.title,
      reminder.description ?? 'Reminder triggered',
      notificationDetails,
      payload: reminder.id,
    );
  }

  /// Update reminder status
  void _updateReminderStatus(Reminder reminder, ReminderStatus status) {
    final index = _reminders.indexWhere((r) => r.id == reminder.id);
    if (index != -1) {
      _reminders[index] = reminder.copyWith(
        status: status,
        updatedAt: DateTime.now(),
      );
    }
  }

  /// Add a new reminder
  Future<void> addReminder(Reminder reminder) async {
    _reminders.add(reminder);
    AppLogger.info('➕ Added reminder: ${reminder.title}');
    
    // Schedule notification if reminder is active
    if (reminder.isActive) {
      await _scheduleNotification(reminder);
    }
  }

  /// Schedule notification for reminder
  Future<void> _scheduleNotification(Reminder reminder) async {
    AppLogger.info('🔔 Scheduling notification for reminder: ${reminder.title}');
    
    if (reminder.scheduledTime.isAfter(DateTime.now())) {
      await _notifications.zonedSchedule(
        reminder.id.hashCode,
        reminder.title,
        reminder.description ?? 'Reminder triggered',
        tz.TZDateTime.from(reminder.scheduledTime, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'reminder_channel',
            'Reminders',
            channelDescription: 'Notifications for reminders and notes',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: reminder.id,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  /// Remove a reminder
  Future<void> removeReminder(String reminderId) async {
    _reminders.removeWhere((r) => r.id == reminderId);
    await _notifications.cancel(reminderId.hashCode);
    AppLogger.info('➖ Removed reminder: $reminderId');
  }

  /// Get all reminders
  List<Reminder> getReminders() {
    return List.unmodifiable(_reminders);
  }

  /// Get reminders for a specific note
  List<Reminder> getRemindersForNote(String noteId) {
    return _reminders.where((r) => r.noteId == noteId).toList();
  }

  /// Get reminders for a specific date
  List<Reminder> getRemindersForDate(DateTime date) {
    return _reminders.where((r) => _isReminderScheduledFor(r, date)).toList();
  }

  /// Check if a reminder is scheduled for a specific date
  bool _isReminderScheduledFor(Reminder reminder, DateTime date) {
    return reminder.isActive && 
           reminder.scheduledTime.year == date.year &&
           reminder.scheduledTime.month == date.month &&
           reminder.scheduledTime.day == date.day;
  }

  /// Create a new reminder
  Future<void> createReminder(Reminder reminder) async {
    await addReminder(reminder);
  }

  /// Update an existing reminder
  Future<void> updateReminder(Reminder reminder) async {
    final index = _reminders.indexWhere((r) => r.id == reminder.id);
    if (index != -1) {
      _reminders[index] = reminder;
      AppLogger.info('✏️ Updated reminder: ${reminder.title}');
      
      // Reschedule notification if reminder is active
      if (reminder.isActive) {
        await _notifications.cancel(reminder.id.hashCode);
        await _scheduleNotification(reminder);
      }
    }
  }

  /// Dispose resources
  void dispose() {
    _checkTimer?.cancel();
    _checkTimer = null;
  }
}
