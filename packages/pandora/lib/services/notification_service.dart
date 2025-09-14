import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // Khởi tạo timezone
    tz.initializeTimeZones();
    
    // Cấu hình cho Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Cấu hình cho iOS
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

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Yêu cầu quyền thông báo
    await _requestPermissions();
  }

  static Future<void> _requestPermissions() async {
    if (Platform.isAndroid) {
      final status = await Permission.notification.request();
      if (status != PermissionStatus.granted) {
        throw Exception('Cần quyền thông báo để gửi nhắc nhở');
      }
    }
  }

  static void _onNotificationTapped(NotificationResponse response) {
    // Xử lý khi người dùng nhấn vào thông báo
    print('Thông báo được nhấn: ${response.payload}');
  }

  /// Lập lịch thông báo cho ghi chú
  static Future<void> scheduleNoteReminder({
    required int noteId,
    required String title,
    required String content,
    required DateTime reminderTime,
  }) async {
    try {
      await _notificationsPlugin.zonedSchedule(
        noteId,
        'Nhắc nhở: $title',
        content,
        tz.TZDateTime.from(reminderTime, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'note_reminders',
            'Nhắc nhở ghi chú',
            channelDescription: 'Thông báo nhắc nhở cho các ghi chú',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
            sound: RawResourceAndroidNotificationSound('notification_sound'),
          ),
          iOS: DarwinNotificationDetails(
            sound: 'notification_sound.wav',
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: 'note_$noteId',
      );
    } catch (e) {
      throw Exception('Lỗi khi lập lịch thông báo: $e');
    }
  }

  /// Hủy thông báo cho ghi chú
  static Future<void> cancelNoteReminder(int noteId) async {
    await _notificationsPlugin.cancel(noteId);
  }

  /// Hủy tất cả thông báo
  static Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }

  /// Lấy danh sách thông báo đang chờ
  static Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _notificationsPlugin.pendingNotificationRequests();
  }

  /// Kiểm tra xem thông báo có được bật không
  static Future<bool> areNotificationsEnabled() async {
    if (Platform.isAndroid) {
      final status = await Permission.notification.status;
      return status == PermissionStatus.granted;
    }
    return true; // iOS tự động xử lý quyền
  }

  /// Mở cài đặt thông báo
  static Future<void> openNotificationSettings() async {
    await openAppSettings();
  }
}
