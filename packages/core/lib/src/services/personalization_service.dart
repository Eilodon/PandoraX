/// Personalization Service for Phase 5 Advanced UX
/// 
/// This service provides intelligent personalization features including
/// user preference learning, smart recommendations, and adaptive UI.
library personalization_service;

import 'package:flutter/material.dart';
import 'package:core/core.dart';

/// Personalization service for intelligent user experience
class PersonalizationService {
  static PersonalizationService? _instance;
  static PersonalizationService get instance => _instance ??= PersonalizationService._();
  
  PersonalizationService._();
  
  final LoggingService _logger = LoggingService.instance;
  
  // ============================================================================
  // USER PREFERENCE LEARNING
  // ============================================================================
  
  /// Learn from user behavior
  void learnFromUserBehavior(String action, Map<String, dynamic> context) {
    try {
      _logger.debug('Learning from user behavior: $action with context: $context');
      
      // Store behavior data
      _storeBehaviorData(action, context);
      
      // Update user preferences
      _updateUserPreferences(action, context);
      
      // Update user profile
      _updateUserProfile(action, context);
    } catch (e) {
      _logger.warning('Failed to learn from user behavior: $e');
    }
  }
  
  /// Store behavior data for analysis
  void _storeBehaviorData(String action, Map<String, dynamic> context) {
    // In a real implementation, you would store this in a database
    final behaviorData = {
      'action': action,
      'context': context,
      'timestamp': DateTime.now().toIso8601String(),
      'session_id': context['session_id'] ?? 'unknown',
      'user_id': context['user_id'] ?? 'anonymous',
    };
    
    _logger.debug('Stored behavior data: $behaviorData');
  }
  
  /// Update user preferences based on behavior
  void _updateUserPreferences(String action, Map<String, dynamic> context) {
    final preferences = _getUserPreferences();
    
    switch (action) {
      case 'theme_toggle':
        preferences['theme_preference'] = context['new_theme'];
        break;
      case 'font_size_change':
        preferences['font_size_preference'] = context['new_font_size'];
        break;
      case 'notification_toggle':
        preferences['notification_preference'] = context['enabled'];
        break;
      case 'ai_assist_usage':
        preferences['ai_assist_preference'] = context['usage_frequency'];
        break;
      case 'note_category_creation':
        preferences['preferred_categories'] = _updatePreferredCategories(
          preferences['preferred_categories'] ?? [],
          context['category'],
        );
        break;
      case 'note_tag_usage':
        preferences['preferred_tags'] = _updatePreferredTags(
          preferences['preferred_tags'] ?? [],
          context['tags'],
        );
        break;
      case 'search_query':
        preferences['search_patterns'] = _updateSearchPatterns(
          preferences['search_patterns'] ?? [],
          context['query'],
        );
        break;
      case 'note_creation_time':
        preferences['active_hours'] = _updateActiveHours(
          preferences['active_hours'] ?? [],
          DateTime.now().hour,
        );
        break;
      case 'note_length':
        preferences['preferred_note_length'] = _updatePreferredNoteLength(
          preferences['preferred_note_length'] ?? 0,
          context['note_length'],
        );
        break;
    }
    
    _saveUserPreferences(preferences);
  }
  
  /// Update user profile based on behavior
  void _updateUserProfile(String action, Map<String, dynamic> context) {
    final profile = _getUserProfile();
    
    switch (action) {
      case 'note_creation':
        profile['total_notes'] = (profile['total_notes'] ?? 0) + 1;
        profile['last_activity'] = DateTime.now().toIso8601String();
        break;
      case 'note_edit':
        profile['total_edits'] = (profile['total_edits'] ?? 0) + 1;
        profile['last_activity'] = DateTime.now().toIso8601String();
        break;
      case 'note_deletion':
        profile['total_deletions'] = (profile['total_deletions'] ?? 0) + 1;
        break;
      case 'search_usage':
        profile['total_searches'] = (profile['total_searches'] ?? 0) + 1;
        break;
      case 'ai_assist_usage':
        profile['ai_usage_count'] = (profile['ai_usage_count'] ?? 0) + 1;
        break;
    }
    
    _saveUserProfile(profile);
  }
  
  /// Update preferred categories
  List<String> _updatePreferredCategories(List<String> current, String newCategory) {
    final updated = List<String>.from(current);
    if (!updated.contains(newCategory)) {
      updated.add(newCategory);
    }
    return updated.take(10).toList(); // Keep only top 10
  }
  
  /// Update preferred tags
  List<String> _updatePreferredTags(List<String> current, List<String> newTags) {
    final updated = List<String>.from(current);
    for (final tag in newTags) {
      if (!updated.contains(tag)) {
        updated.add(tag);
      }
    }
    return updated.take(20).toList(); // Keep only top 20
  }
  
  /// Update search patterns
  List<String> _updateSearchPatterns(List<String> current, String newQuery) {
    final updated = List<String>.from(current);
    if (!updated.contains(newQuery)) {
      updated.add(newQuery);
    }
    return updated.take(50).toList(); // Keep only top 50
  }
  
  /// Update active hours
  List<int> _updateActiveHours(List<int> current, int hour) {
    final updated = List<int>.from(current);
    if (!updated.contains(hour)) {
      updated.add(hour);
    }
    return updated.take(24).toList(); // Keep all hours
  }
  
  /// Update preferred note length
  int _updatePreferredNoteLength(int current, int newLength) {
    // Calculate running average
    return ((current + newLength) / 2).round();
  }
  
  // ============================================================================
  // SMART RECOMMENDATIONS
  // ============================================================================
  
  /// Get personalized recommendations
  List<String> getRecommendations(String userId, String context) {
    try {
      final userPreferences = _getUserPreferences();
      final userProfile = _getUserProfile();
      
      switch (context) {
        case 'note_categories':
          return _getCategoryRecommendations(userPreferences);
        case 'note_tags':
          return _getTagRecommendations(userPreferences);
        case 'search_suggestions':
          return _getSearchRecommendations(userPreferences);
        case 'ai_suggestions':
          return _getAIRecommendations(userProfile);
        case 'feature_suggestions':
          return _getFeatureRecommendations(userProfile);
        default:
          return [];
      }
    } catch (e) {
      _logger.warning('Failed to get recommendations: $e');
      return [];
    }
  }
  
  /// Get category recommendations
  List<String> _getCategoryRecommendations(Map<String, dynamic> preferences) {
    final preferredCategories = preferences['preferred_categories'] as List<String>? ?? [];
    final allCategories = ['Work', 'Personal', 'Ideas', 'Tasks', 'Shopping', 'Recipes', 'Travel', 'Health'];
    
    // Return preferred categories first, then others
    final recommendations = <String>[];
    recommendations.addAll(preferredCategories);
    recommendations.addAll(allCategories.where((cat) => !preferredCategories.contains(cat)));
    
    return recommendations.take(5).toList();
  }
  
  /// Get tag recommendations
  List<String> _getTagRecommendations(Map<String, dynamic> preferences) {
    final preferredTags = preferences['preferred_tags'] as List<String>? ?? [];
    final commonTags = ['important', 'urgent', 'work', 'personal', 'idea', 'todo', 'meeting', 'project'];
    
    // Return preferred tags first, then common tags
    final recommendations = <String>[];
    recommendations.addAll(preferredTags);
    recommendations.addAll(commonTags.where((tag) => !preferredTags.contains(tag)));
    
    return recommendations.take(10).toList();
  }
  
  /// Get search recommendations
  List<String> _getSearchRecommendations(Map<String, dynamic> preferences) {
    final searchPatterns = preferences['search_patterns'] as List<String>? ?? [];
    return searchPatterns.take(5).toList();
  }
  
  /// Get AI recommendations
  List<String> _getAIRecommendations(Map<String, dynamic> profile) {
    final aiUsageCount = profile['ai_usage_count'] as int? ?? 0;
    
    if (aiUsageCount < 5) {
      return [
        'Try AI-powered note summaries',
        'Use AI to generate note titles',
        'Get AI suggestions for note tags',
        'Ask AI to improve your writing',
      ];
    } else if (aiUsageCount < 20) {
      return [
        'Use AI for note categorization',
        'Get AI-powered search suggestions',
        'Try AI-generated note templates',
        'Use AI for content organization',
      ];
    } else {
      return [
        'Advanced AI note analysis',
        'AI-powered content insights',
        'Smart note recommendations',
        'AI-driven productivity tips',
      ];
    }
  }
  
  /// Get feature recommendations
  List<String> _getFeatureRecommendations(Map<String, dynamic> profile) {
    final totalNotes = profile['total_notes'] as int? ?? 0;
    final totalSearches = profile['total_searches'] as int? ?? 0;
    final aiUsageCount = profile['ai_usage_count'] as int? ?? 0;
    
    final recommendations = <String>[];
    
    if (totalNotes > 10 && totalSearches == 0) {
      recommendations.add('Try the search feature to find your notes quickly');
    }
    
    if (totalNotes > 5 && aiUsageCount == 0) {
      recommendations.add('Enable AI assistance for smarter note management');
    }
    
    if (totalNotes > 20) {
      recommendations.add('Organize your notes with categories and tags');
    }
    
    if (totalNotes > 50) {
      recommendations.add('Use note templates for faster note creation');
    }
    
    return recommendations.take(3).toList();
  }
  
  // ============================================================================
  // ADAPTIVE UI
  // ============================================================================
  
  /// Get adaptive UI configuration
  Map<String, dynamic> getAdaptiveUIConfig(String userId) {
    try {
      final userPreferences = _getUserPreferences();
      final userProfile = _getUserProfile();
      
      return {
        'theme': _getAdaptiveTheme(userPreferences),
        'font_size': _getAdaptiveFontSize(userPreferences),
        'layout': _getAdaptiveLayout(userProfile),
        'features': _getAdaptiveFeatures(userProfile),
        'notifications': _getAdaptiveNotifications(userPreferences),
        'ai_assist': _getAdaptiveAIAssist(userProfile),
      };
    } catch (e) {
      _logger.warning('Failed to get adaptive UI config: $e');
      return _getDefaultUIConfig();
    }
  }
  
  /// Get adaptive theme
  String _getAdaptiveTheme(Map<String, dynamic> preferences) {
    final themePreference = preferences['theme_preference'] as String?;
    if (themePreference != null) return themePreference;
    
    // Default to system theme
    return 'system';
  }
  
  /// Get adaptive font size
  String _getAdaptiveFontSize(Map<String, dynamic> preferences) {
    final fontSizePreference = preferences['font_size_preference'] as String?;
    if (fontSizePreference != null) return fontSizePreference;
    
    // Default to medium
    return 'medium';
  }
  
  /// Get adaptive layout
  Map<String, dynamic> _getAdaptiveLayout(Map<String, dynamic> profile) {
    final totalNotes = profile['total_notes'] as int? ?? 0;
    
    if (totalNotes < 10) {
      return {
        'show_categories': false,
        'show_tags': false,
        'show_search': false,
        'compact_mode': false,
      };
    } else if (totalNotes < 50) {
      return {
        'show_categories': true,
        'show_tags': false,
        'show_search': true,
        'compact_mode': false,
      };
    } else {
      return {
        'show_categories': true,
        'show_tags': true,
        'show_search': true,
        'compact_mode': true,
      };
    }
  }
  
  /// Get adaptive features
  Map<String, dynamic> _getAdaptiveFeatures(Map<String, dynamic> profile) {
    final totalNotes = profile['total_notes'] as int? ?? 0;
    final aiUsageCount = profile['ai_usage_count'] as int? ?? 0;
    
    return {
      'ai_assist': aiUsageCount > 0,
      'templates': totalNotes > 20,
      'export': totalNotes > 10,
      'sync': totalNotes > 5,
      'backup': totalNotes > 15,
      'analytics': totalNotes > 30,
    };
  }
  
  /// Get adaptive notifications
  Map<String, dynamic> _getAdaptiveNotifications(Map<String, dynamic> preferences) {
    final notificationPreference = preferences['notification_preference'] as bool? ?? true;
    final activeHours = preferences['active_hours'] as List<int>? ?? [];
    
    return {
      'enabled': notificationPreference,
      'quiet_hours': _getQuietHours(activeHours),
      'reminder_frequency': _getReminderFrequency(activeHours),
      'priority_level': _getPriorityLevel(activeHours),
    };
  }
  
  /// Get adaptive AI assist
  Map<String, dynamic> _getAdaptiveAIAssist(Map<String, dynamic> profile) {
    final aiUsageCount = profile['ai_usage_count'] as int? ?? 0;
    
    if (aiUsageCount < 5) {
      return {
        'enabled': true,
        'suggestions': true,
        'auto_complete': false,
        'smart_categorization': false,
        'advanced_features': false,
      };
    } else if (aiUsageCount < 20) {
      return {
        'enabled': true,
        'suggestions': true,
        'auto_complete': true,
        'smart_categorization': true,
        'advanced_features': false,
      };
    } else {
      return {
        'enabled': true,
        'suggestions': true,
        'auto_complete': true,
        'smart_categorization': true,
        'advanced_features': true,
      };
    }
  }
  
  /// Get quiet hours based on active hours
  List<int> _getQuietHours(List<int> activeHours) {
    if (activeHours.isEmpty) return [22, 8]; // Default: 10 PM to 8 AM
    
    final sortedHours = List<int>.from(activeHours)..sort();
    final firstActive = sortedHours.first;
    final lastActive = sortedHours.last;
    
    return [lastActive + 2, firstActive - 2];
  }
  
  /// Get reminder frequency based on active hours
  String _getReminderFrequency(List<int> activeHours) {
    if (activeHours.length < 5) return 'low';
    if (activeHours.length < 15) return 'medium';
    return 'high';
  }
  
  /// Get priority level based on active hours
  String _getPriorityLevel(List<int> activeHours) {
    if (activeHours.length < 5) return 'low';
    if (activeHours.length < 15) return 'medium';
    return 'high';
  }
  
  // ============================================================================
  // DATA MANAGEMENT
  // ============================================================================
  
  /// Get user preferences
  Map<String, dynamic> _getUserPreferences() {
    // In a real implementation, you would load from database
    return {
      'theme_preference': 'system',
      'font_size_preference': 'medium',
      'notification_preference': true,
      'ai_assist_preference': 'medium',
      'preferred_categories': [],
      'preferred_tags': [],
      'search_patterns': [],
      'active_hours': [],
      'preferred_note_length': 0,
    };
  }
  
  /// Save user preferences
  void _saveUserPreferences(Map<String, dynamic> preferences) {
    // In a real implementation, you would save to database
    _logger.debug('Saved user preferences: $preferences');
  }
  
  /// Get user profile
  Map<String, dynamic> _getUserProfile() {
    // In a real implementation, you would load from database
    return {
      'total_notes': 0,
      'total_edits': 0,
      'total_deletions': 0,
      'total_searches': 0,
      'ai_usage_count': 0,
      'last_activity': DateTime.now().toIso8601String(),
    };
  }
  
  /// Save user profile
  void _saveUserProfile(Map<String, dynamic> profile) {
    // In a real implementation, you would save to database
    _logger.debug('Saved user profile: $profile');
  }
  
  /// Get default UI config
  Map<String, dynamic> _getDefaultUIConfig() {
    return {
      'theme': 'system',
      'font_size': 'medium',
      'layout': {
        'show_categories': false,
        'show_tags': false,
        'show_search': false,
        'compact_mode': false,
      },
      'features': {
        'ai_assist': false,
        'templates': false,
        'export': false,
        'sync': false,
        'backup': false,
        'analytics': false,
      },
      'notifications': {
        'enabled': true,
        'quiet_hours': [22, 8],
        'reminder_frequency': 'low',
        'priority_level': 'low',
      },
      'ai_assist': {
        'enabled': false,
        'suggestions': false,
        'auto_complete': false,
        'smart_categorization': false,
        'advanced_features': false,
      },
    };
  }
  
  // ============================================================================
  // ANALYTICS
  // ============================================================================
  
  /// Get personalization analytics
  Map<String, dynamic> getPersonalizationAnalytics() {
    try {
      final preferences = _getUserPreferences();
      final profile = _getUserProfile();
      
      return {
        'total_learned_preferences': preferences.length,
        'most_used_categories': preferences['preferred_categories'] ?? [],
        'most_used_tags': preferences['preferred_tags'] ?? [],
        'active_hours': preferences['active_hours'] ?? [],
        'total_notes': profile['total_notes'] ?? 0,
        'ai_usage_count': profile['ai_usage_count'] ?? 0,
        'personalization_score': _calculatePersonalizationScore(preferences, profile),
        'recommendation_accuracy': _calculateRecommendationAccuracy(),
      };
    } catch (e) {
      _logger.warning('Failed to get personalization analytics: $e');
      return {};
    }
  }
  
  /// Calculate personalization score
  double _calculatePersonalizationScore(Map<String, dynamic> preferences, Map<String, dynamic> profile) {
    double score = 0.0;
    
    // Preference learning score (0-40 points)
    final preferenceCount = preferences.length;
    score += (preferenceCount / 10) * 40;
    
    // Usage pattern score (0-30 points)
    final totalNotes = profile['total_notes'] as int? ?? 0;
    score += (totalNotes / 100) * 30;
    
    // AI usage score (0-20 points)
    final aiUsageCount = profile['ai_usage_count'] as int? ?? 0;
    score += (aiUsageCount / 50) * 20;
    
    // Activity score (0-10 points)
    final activeHours = preferences['active_hours'] as List<int>? ?? [];
    score += (activeHours.length / 24) * 10;
    
    return score.clamp(0.0, 100.0);
  }
  
  /// Calculate recommendation accuracy
  double _calculateRecommendationAccuracy() {
    // In a real implementation, you would calculate based on user feedback
    return 85.0; // Placeholder value
  }
}
