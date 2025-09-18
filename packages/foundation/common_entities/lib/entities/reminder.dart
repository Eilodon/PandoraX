import 'package:freezed_annotation/freezed_annotation.dart';

part 'reminder.freezed.dart';
part 'reminder.g.dart';

/// Reminder entity for note notifications
@freezed
class Reminder with _$Reminder {
  const factory Reminder({
    required String id,
    required String noteId,
    required String title,
    required String description,
    required DateTime scheduledTime,
    required ReminderType type,
    required ReminderStatus status,
    required List<ReminderRepeat> repeatDays,
    required bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? soundPath,
    int? vibrationPattern,
    bool? isSilent,
    String? customMessage,
  }) = _Reminder;

  factory Reminder.fromJson(Map<String, dynamic> json) =>
      _$ReminderFromJson(json);
}

/// Reminder types
@freezed
class ReminderType with _$ReminderType {
  const factory ReminderType.alarm() = AlarmReminder;
  const factory ReminderType.notification() = NotificationReminder;
  const factory ReminderType.email() = EmailReminder;
  const factory ReminderType.sms() = SmsReminder;

  factory ReminderType.fromJson(Map<String, dynamic> json) =>
      _$ReminderTypeFromJson(json);
}

/// Reminder status
@freezed
class ReminderStatus with _$ReminderStatus {
  const factory ReminderStatus.pending() = PendingReminder;
  const factory ReminderStatus.triggered() = TriggeredReminder;
  const factory ReminderStatus.cancelled() = CancelledReminder;
  const factory ReminderStatus.completed() = CompletedReminder;

  factory ReminderStatus.fromJson(Map<String, dynamic> json) =>
      _$ReminderStatusFromJson(json);
}

/// Reminder repeat days
@freezed
class ReminderRepeat with _$ReminderRepeat {
  const factory ReminderRepeat.daily() = DailyRepeat;
  const factory ReminderRepeat.weekly() = WeeklyRepeat;
  const factory ReminderRepeat.monthly() = MonthlyRepeat;
  const factory ReminderRepeat.yearly() = YearlyRepeat;
  const factory ReminderRepeat.custom({
    required List<int> daysOfWeek,
  }) = CustomRepeat;

  factory ReminderRepeat.fromJson(Map<String, dynamic> json) =>
      _$ReminderRepeatFromJson(json);
}

/// Reminder notification settings
@freezed
class ReminderNotificationSettings with _$ReminderNotificationSettings {
  const factory ReminderNotificationSettings({
    required bool enableSound,
    required bool enableVibration,
    required bool enableLight,
    required String soundPath,
    required int vibrationPattern,
    required int ledColor,
    required int priority,
    required bool showOnLockScreen,
    required bool showBadge,
  }) = _ReminderNotificationSettings;

  factory ReminderNotificationSettings.fromJson(Map<String, dynamic> json) =>
      _$ReminderNotificationSettingsFromJson(json);
}
