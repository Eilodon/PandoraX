import 'dart:io';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'model_level.dart';

part 'model_session.freezed.dart';
part 'model_session.g.dart';

@freezed
class ModelSession with _$ModelSession {
  const factory ModelSession({
    required String key,
    required String filePath,
    required ModelLevel level,
    required bool pinned,
    required DateTime lastAccess,
    String? version,
    Map<String, dynamic>? metadata,
  }) = _ModelSession;

  factory ModelSession.fromJson(Map<String, dynamic> json) => _$ModelSessionFromJson(json);

  const ModelSession._();

  File get file => File(filePath);
  
  int get fileSize => file.lengthSync();
  
  String get fileSizeDisplay {
    final bytes = fileSize;
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(0)} KB';
    } else {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(0)} MB';
    }
  }
  
  bool get isExpired {
    final now = DateTime.now();
    final daysSinceAccess = now.difference(lastAccess).inDays;
    return daysSinceAccess > 30; // Expire after 30 days
  }
}
