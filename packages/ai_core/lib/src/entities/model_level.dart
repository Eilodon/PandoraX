import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_level.freezed.dart';
part 'model_level.g.dart';

@freezed
class ModelLevel with _$ModelLevel {
  const factory ModelLevel({
    required String name,
    required int sizeBytes,
    required String modelId,
    required String description,
    required String version,
  }) = _ModelLevel;

  factory ModelLevel.fromJson(Map<String, dynamic> json) => _$ModelLevelFromJson(json);

  const ModelLevel._();

  static const ModelLevel tiny = ModelLevel(
    name: 'tiny',
    sizeBytes: 50 * 1024 * 1024, // 50MB
    modelId: 'phi-3-tiny',
    description: 'Basic tasks - Quick responses, simple summaries',
    version: '2025.01',
  );

  static const ModelLevel mini = ModelLevel(
    name: 'mini',
    sizeBytes: 200 * 1024 * 1024, // 200MB
    modelId: 'phi-3-mini',
    description: 'Intermediate tasks - Chat conversations, content enhancement',
    version: '2025.01',
  );

  static const ModelLevel full = ModelLevel(
    name: 'full',
    sizeBytes: 850 * 1024 * 1024, // 850MB
    modelId: 'phi-3-full',
    description: 'Advanced tasks - Complex reasoning, creative writing',
    version: '2025.01',
  );

  static const List<ModelLevel> all = [tiny, mini, full];

  String get key => '${modelId}_$version';
  
  String get displayName => name.toUpperCase();
  
  String get sizeDisplay {
    if (sizeBytes < 1024 * 1024) {
      return '${(sizeBytes / 1024).toStringAsFixed(0)} KB';
    } else {
      return '${(sizeBytes / (1024 * 1024)).toStringAsFixed(0)} MB';
    }
  }
}
