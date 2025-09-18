import 'package:freezed_annotation/freezed_annotation.dart';

part 'summarization_style.freezed.dart';
part 'summarization_style.g.dart';

/// Enum for different summarization styles
@freezed
class SummarizationStyle with _$SummarizationStyle {
  const factory SummarizationStyle.bulletPoints() = BulletPoints;
  const factory SummarizationStyle.executiveSummary() = ExecutiveSummary;
  const factory SummarizationStyle.detailedAnalysis() = DetailedAnalysis;
  const factory SummarizationStyle.custom({
    required String customPrompt,
  }) = Custom;

  factory SummarizationStyle.fromJson(Map<String, dynamic> json) =>
      _$SummarizationStyleFromJson(json);
}

/// Extension for SummarizationStyle utilities
extension SummarizationStyleExtension on SummarizationStyle {
  /// Get display name for UI
  String get displayName {
    return when(
      bulletPoints: () => 'Bullet Points',
      executiveSummary: () => 'Executive Summary',
      detailedAnalysis: () => 'Detailed Analysis',
      custom: (customPrompt) => 'Custom Style',
    );
  }
  
  /// Get description for UI
  String get description {
    return when(
      bulletPoints: () => 'Summarize in bullet points format',
      executiveSummary: () => 'Create an executive summary',
      detailedAnalysis: () => 'Provide detailed analysis',
      custom: (customPrompt) => 'Custom summarization style',
    );
  }
  
  /// Get prompt for AI generation
  String get prompt {
    return when(
      bulletPoints: () => 'Summarize the following text in bullet points format. Make it concise and easy to read:',
      executiveSummary: () => 'Create an executive summary of the following text. Focus on key points and main conclusions:',
      detailedAnalysis: () => 'Provide a detailed analysis of the following text. Include insights, patterns, and implications:',
      custom: (customPrompt) => customPrompt,
    );
  }
  
  /// Get icon for UI
  String get icon {
    return when(
      bulletPoints: () => '📝',
      executiveSummary: () => '📊',
      detailedAnalysis: () => '🔍',
      custom: (customPrompt) => '⚙️',
    );
  }
  
  /// Check if this is a custom style
  bool get isCustom {
    return when(
      bulletPoints: () => false,
      executiveSummary: () => false,
      detailedAnalysis: () => false,
      custom: (customPrompt) => true,
    );
  }
}

/// Predefined summarization styles for easy access
class SummarizationStyles {
  static const SummarizationStyle bulletPoints = SummarizationStyle.bulletPoints();
  static const SummarizationStyle executiveSummary = SummarizationStyle.executiveSummary();
  static const SummarizationStyle detailedAnalysis = SummarizationStyle.detailedAnalysis();
  
  /// Get all predefined styles
  static List<SummarizationStyle> get all => [
    bulletPoints,
    executiveSummary,
    detailedAnalysis,
  ];
  
  /// Get style by name
  static SummarizationStyle? getByName(String name) {
    switch (name.toLowerCase()) {
      case 'bulletpoints':
      case 'bullet_points':
        return bulletPoints;
      case 'executivesummary':
      case 'executive_summary':
        return executiveSummary;
      case 'detailedanalysis':
      case 'detailed_analysis':
        return detailedAnalysis;
      default:
        return null;
    }
  }
}
