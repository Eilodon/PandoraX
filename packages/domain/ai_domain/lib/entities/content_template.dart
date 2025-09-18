import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_template.freezed.dart';
part 'content_template.g.dart';

/// Content template for AI generation
@freezed
class ContentTemplate with _$ContentTemplate {
  const factory ContentTemplate({
    required String id,
    required String name,
    required String description,
    required String prompt,
    required Map<String, dynamic> parameters,
    required String category,
    @Default(false) bool isBuiltIn,
    @Default(0) int usageCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ContentTemplate;

  const ContentTemplate._();

  factory ContentTemplate.fromJson(Map<String, dynamic> json) =>
      _$ContentTemplateFromJson(json);

  /// Get display name for UI
  String get displayName => name;

  /// Get icon for UI based on category
  String get icon {
    switch (category.toLowerCase()) {
      case 'business':
        return '💼';
      case 'academic':
        return '📚';
      case 'creative':
        return '🎨';
      case 'technical':
        return '⚙️';
      case 'personal':
        return '👤';
      case 'professional':
        return '💼';
      default:
        return '📝';
    }
  }

  /// Check if template is custom
  bool get isCustom => !isBuiltIn;

  /// Get formatted prompt with parameters
  String getFormattedPrompt(Map<String, dynamic>? values) {
    String formattedPrompt = prompt;
    
    if (values != null) {
      values.forEach((key, value) {
        formattedPrompt = formattedPrompt.replaceAll('{{$key}}', value.toString());
      });
    }
    
    return formattedPrompt;
  }

  /// Get required parameters
  List<String> get requiredParameters {
    final regex = RegExp(r'\{\{(\w+)\}\}');
    final matches = regex.allMatches(prompt);
    return matches.map((match) => match.group(1)!).toList();
  }

  /// Check if all required parameters are provided
  bool hasAllRequiredParameters(Map<String, dynamic>? values) {
    if (values == null) return false;
    
    final required = requiredParameters;
    return required.every((param) => values.containsKey(param));
  }
}

/// Predefined content templates
class ContentTemplates {
  static const ContentTemplate meetingNotes = ContentTemplate(
    id: 'meeting_notes',
    name: 'Meeting Notes',
    description: 'Template for taking structured meeting notes',
    prompt: 'Create meeting notes for: {{topic}}\n\nAttendees: {{attendees}}\n\nKey Points:\n- \n- \n- \n\nAction Items:\n- \n- \n- \n\nNext Meeting: {{nextMeeting}}',
    parameters: {
      'topic': 'string',
      'attendees': 'string',
      'nextMeeting': 'string',
    },
    category: 'business',
    isBuiltIn: true,
  );

  static const ContentTemplate projectPlan = ContentTemplate(
    id: 'project_plan',
    name: 'Project Plan',
    description: 'Template for creating project plans',
    prompt: 'Create a project plan for: {{projectName}}\n\nObjective: {{objective}}\n\nTimeline: {{timeline}}\n\nResources needed:\n- \n- \n- \n\nMilestones:\n- \n- \n- \n\nRisks and Mitigation:\n- \n- \n- ',
    parameters: {
      'projectName': 'string',
      'objective': 'string',
      'timeline': 'string',
    },
    category: 'business',
    isBuiltIn: true,
  );

  static const ContentTemplate journalEntry = ContentTemplate(
    id: 'journal_entry',
    name: 'Journal Entry',
    description: 'Template for personal journal entries',
    prompt: 'Create a journal entry for {{date}}:\n\nToday I:\n- \n- \n- \n\nI learned:\n- \n- \n- \n\nI\'m grateful for:\n- \n- \n- \n\nTomorrow I want to:\n- \n- \n- ',
    parameters: {
      'date': 'string',
    },
    category: 'personal',
    isBuiltIn: true,
  );

  static const ContentTemplate codeDocumentation = ContentTemplate(
    id: 'code_documentation',
    name: 'Code Documentation',
    description: 'Template for documenting code',
    prompt: 'Create documentation for the following code:\n\nFunction: {{functionName}}\n\nPurpose: {{purpose}}\n\nParameters:\n- {{param1}}: \n- {{param2}}: \n\nReturns: \n\nExample usage:\n```\n{{example}}\n```',
    parameters: {
      'functionName': 'string',
      'purpose': 'string',
      'param1': 'string',
      'param2': 'string',
      'example': 'string',
    },
    category: 'technical',
    isBuiltIn: true,
  );

  static const ContentTemplate creativeWriting = ContentTemplate(
    id: 'creative_writing',
    name: 'Creative Writing',
    description: 'Template for creative writing prompts',
    prompt: 'Write a {{genre}} story about {{theme}}:\n\nCharacters:\n- {{character1}}: \n- {{character2}}: \n\nSetting: {{setting}}\n\nPlot: {{plot}}\n\nBegin the story:',
    parameters: {
      'genre': 'string',
      'theme': 'string',
      'character1': 'string',
      'character2': 'string',
      'setting': 'string',
      'plot': 'string',
    },
    category: 'creative',
    isBuiltIn: true,
  );

  /// Get all built-in templates
  static List<ContentTemplate> get all => [
    meetingNotes,
    projectPlan,
    journalEntry,
    codeDocumentation,
    creativeWriting,
  ];

  /// Get templates by category
  static List<ContentTemplate> getByCategory(String category) {
    return all.where((template) => 
      template.category.toLowerCase() == category.toLowerCase()
    ).toList();
  }

  /// Get template by ID
  static ContentTemplate? getById(String id) {
    try {
      return all.firstWhere((template) => template.id == id);
    } catch (e) {
      return null;
    }
  }
}
