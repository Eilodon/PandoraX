// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReminderImpl _$$ReminderImplFromJson(Map<String, dynamic> json) =>
    _$ReminderImpl(
      id: json['id'] as String,
      noteId: json['noteId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      scheduledTime: DateTime.parse(json['scheduledTime'] as String),
      type: ReminderType.fromJson(json['type'] as Map<String, dynamic>),
      status: ReminderStatus.fromJson(json['status'] as Map<String, dynamic>),
      repeatDays: (json['repeatDays'] as List<dynamic>)
          .map((e) => ReminderRepeat.fromJson(e as Map<String, dynamic>))
          .toList(),
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      soundPath: json['soundPath'] as String?,
      vibrationPattern: (json['vibrationPattern'] as num?)?.toInt(),
      isSilent: json['isSilent'] as bool?,
      customMessage: json['customMessage'] as String?,
    );

Map<String, dynamic> _$$ReminderImplToJson(_$ReminderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'noteId': instance.noteId,
      'title': instance.title,
      'description': instance.description,
      'scheduledTime': instance.scheduledTime.toIso8601String(),
      'type': instance.type,
      'status': instance.status,
      'repeatDays': instance.repeatDays,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'soundPath': instance.soundPath,
      'vibrationPattern': instance.vibrationPattern,
      'isSilent': instance.isSilent,
      'customMessage': instance.customMessage,
    };

_$AlarmReminderImpl _$$AlarmReminderImplFromJson(Map<String, dynamic> json) =>
    _$AlarmReminderImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AlarmReminderImplToJson(_$AlarmReminderImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$NotificationReminderImpl _$$NotificationReminderImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationReminderImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$NotificationReminderImplToJson(
        _$NotificationReminderImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$EmailReminderImpl _$$EmailReminderImplFromJson(Map<String, dynamic> json) =>
    _$EmailReminderImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$EmailReminderImplToJson(_$EmailReminderImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$SmsReminderImpl _$$SmsReminderImplFromJson(Map<String, dynamic> json) =>
    _$SmsReminderImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SmsReminderImplToJson(_$SmsReminderImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$PendingReminderImpl _$$PendingReminderImplFromJson(
        Map<String, dynamic> json) =>
    _$PendingReminderImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$PendingReminderImplToJson(
        _$PendingReminderImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$TriggeredReminderImpl _$$TriggeredReminderImplFromJson(
        Map<String, dynamic> json) =>
    _$TriggeredReminderImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$TriggeredReminderImplToJson(
        _$TriggeredReminderImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$CancelledReminderImpl _$$CancelledReminderImplFromJson(
        Map<String, dynamic> json) =>
    _$CancelledReminderImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$CancelledReminderImplToJson(
        _$CancelledReminderImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$CompletedReminderImpl _$$CompletedReminderImplFromJson(
        Map<String, dynamic> json) =>
    _$CompletedReminderImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$CompletedReminderImplToJson(
        _$CompletedReminderImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$DailyRepeatImpl _$$DailyRepeatImplFromJson(Map<String, dynamic> json) =>
    _$DailyRepeatImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DailyRepeatImplToJson(_$DailyRepeatImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$WeeklyRepeatImpl _$$WeeklyRepeatImplFromJson(Map<String, dynamic> json) =>
    _$WeeklyRepeatImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$WeeklyRepeatImplToJson(_$WeeklyRepeatImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$MonthlyRepeatImpl _$$MonthlyRepeatImplFromJson(Map<String, dynamic> json) =>
    _$MonthlyRepeatImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$MonthlyRepeatImplToJson(_$MonthlyRepeatImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$YearlyRepeatImpl _$$YearlyRepeatImplFromJson(Map<String, dynamic> json) =>
    _$YearlyRepeatImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$YearlyRepeatImplToJson(_$YearlyRepeatImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$CustomRepeatImpl _$$CustomRepeatImplFromJson(Map<String, dynamic> json) =>
    _$CustomRepeatImpl(
      daysOfWeek: (json['daysOfWeek'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$CustomRepeatImplToJson(_$CustomRepeatImpl instance) =>
    <String, dynamic>{
      'daysOfWeek': instance.daysOfWeek,
      'runtimeType': instance.$type,
    };

_$ReminderNotificationSettingsImpl _$$ReminderNotificationSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$ReminderNotificationSettingsImpl(
      enableSound: json['enableSound'] as bool,
      enableVibration: json['enableVibration'] as bool,
      enableLight: json['enableLight'] as bool,
      soundPath: json['soundPath'] as String,
      vibrationPattern: (json['vibrationPattern'] as num).toInt(),
      ledColor: (json['ledColor'] as num).toInt(),
      priority: (json['priority'] as num).toInt(),
      showOnLockScreen: json['showOnLockScreen'] as bool,
      showBadge: json['showBadge'] as bool,
    );

Map<String, dynamic> _$$ReminderNotificationSettingsImplToJson(
        _$ReminderNotificationSettingsImpl instance) =>
    <String, dynamic>{
      'enableSound': instance.enableSound,
      'enableVibration': instance.enableVibration,
      'enableLight': instance.enableLight,
      'soundPath': instance.soundPath,
      'vibrationPattern': instance.vibrationPattern,
      'ledColor': instance.ledColor,
      'priority': instance.priority,
      'showOnLockScreen': instance.showOnLockScreen,
      'showBadge': instance.showBadge,
    };
