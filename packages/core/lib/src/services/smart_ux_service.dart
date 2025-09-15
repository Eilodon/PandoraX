/// Smart UX Service for Phase 5 Advanced UX
/// 
/// This service provides intelligent UX features including predictive loading,
/// contextual help, smart defaults, and user behavior analysis.
library smart_ux_service;

import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:pandora_ui/pandora_ui.dart';

/// Smart UX service for intelligent user experience
class SmartUXService {
  static SmartUXService? _instance;
  static SmartUXService get instance => _instance ??= SmartUXService._();
  
  SmartUXService._();
  
  final LoggingService _logger = LoggingService.instance;
  
  // ============================================================================
  // PREDICTIVE LOADING
  // ============================================================================
  
  /// Preload next screen based on current context
  void preloadNextScreen(String currentScreen) {
    try {
      _logger.debug('Preloading next screen from: $currentScreen');
      
      // Predict likely next screens based on current screen
      final nextScreens = _predictNextScreens(currentScreen);
      
      for (final screen in nextScreens) {
        _preloadScreen(screen);
      }
    } catch (e) {
      _logger.warning('Failed to preload next screen: $e');
    }
  }
  
  /// Predict next screens based on current screen
  List<String> _predictNextScreens(String currentScreen) {
    final predictions = <String>[];
    
    switch (currentScreen) {
      case 'welcome':
        predictions.addAll(['notes_list', 'settings', 'profile']);
        break;
      case 'notes_list':
        predictions.addAll(['note_detail', 'note_edit', 'search']);
        break;
      case 'note_detail':
        predictions.addAll(['note_edit', 'notes_list', 'share']);
        break;
      case 'note_edit':
        predictions.addAll(['note_detail', 'notes_list', 'ai_assist']);
        break;
      case 'settings':
        predictions.addAll(['profile', 'notifications', 'privacy']);
        break;
      case 'profile':
        predictions.addAll(['settings', 'account', 'preferences']);
        break;
      default:
        predictions.addAll(['notes_list', 'settings']);
    }
    
    return predictions;
  }
  
  /// Preload specific screen
  void _preloadScreen(String screen) {
    _logger.debug('Preloading screen: $screen');
    // In a real implementation, you would preload screen data, widgets, etc.
  }
  
  /// Preload data based on user behavior
  void preloadData(String dataType, Map<String, dynamic> context) {
    try {
      _logger.debug('Preloading data: $dataType with context: $context');
      
      switch (dataType) {
        case 'notes':
          _preloadNotes(context);
          break;
        case 'user_profile':
          _preloadUserProfile(context);
          break;
        case 'settings':
          _preloadSettings(context);
          break;
        case 'ai_suggestions':
          _preloadAISuggestions(context);
          break;
        default:
          _logger.warning('Unknown data type for preloading: $dataType');
      }
    } catch (e) {
      _logger.warning('Failed to preload data: $e');
    }
  }
  
  /// Preload notes data
  void _preloadNotes(Map<String, dynamic> context) {
    // Preload recent notes, favorite notes, etc.
    _logger.debug('Preloading notes data');
  }
  
  /// Preload user profile data
  void _preloadUserProfile(Map<String, dynamic> context) {
    // Preload user preferences, settings, etc.
    _logger.debug('Preloading user profile data');
  }
  
  /// Preload settings data
  void _preloadSettings(Map<String, dynamic> context) {
    // Preload app settings, theme preferences, etc.
    _logger.debug('Preloading settings data');
  }
  
  /// Preload AI suggestions
  void _preloadAISuggestions(Map<String, dynamic> context) {
    // Preload AI-generated suggestions, recommendations, etc.
    _logger.debug('Preloading AI suggestions data');
  }
  
  // ============================================================================
  // CONTEXTUAL HELP
  // ============================================================================
  
  /// Create contextual help widget
  Widget createContextualHelp({
    required String helpText,
    required Widget child,
    String? title,
    Duration delay = const Duration(seconds: 2),
    bool showOnHover = true,
    bool showOnTap = true,
  }) {
    return _ContextualHelp(
      helpText: helpText,
      title: title,
      delay: delay,
      showOnHover: showOnHover,
      showOnTap: showOnTap,
      child: child,
    );
  }
  
  /// Show contextual help for specific feature
  void showFeatureHelp(String feature, BuildContext context) {
    try {
      final helpText = _getFeatureHelpText(feature);
      if (helpText != null) {
        _showHelpDialog(context, feature, helpText);
      }
    } catch (e) {
      _logger.warning('Failed to show feature help: $e');
    }
  }
  
  /// Get help text for specific feature
  String? _getFeatureHelpText(String feature) {
    final helpTexts = {
      'notes_list': 'Tap on a note to view it, long press for options, or swipe to delete.',
      'note_edit': 'Use the toolbar to format text, add images, or get AI assistance.',
      'search': 'Type to search through your notes. Use filters to narrow down results.',
      'settings': 'Customize your app experience, manage notifications, and privacy settings.',
      'ai_assist': 'Get AI-powered suggestions for your notes, including summaries and tags.',
      'sync': 'Your notes are automatically synced across devices. Tap to force sync.',
      'theme': 'Switch between light and dark themes, or let the app follow system settings.',
      'notifications': 'Manage how and when you receive notifications about your notes.',
    };
    
    return helpTexts[feature];
  }
  
  /// Show help dialog
  void _showHelpDialog(BuildContext context, String feature, String helpText) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Help: ${feature.replaceAll('_', ' ').toUpperCase()}'),
        content: Text(helpText),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }
  
  /// Show contextual tooltip
  void showContextualTooltip({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
    TooltipPosition position = TooltipPosition.auto,
  }) {
    try {
      final overlay = Overlay.of(context);
      final overlayEntry = OverlayEntry(
        builder: (context) => _ContextualTooltip(
          message: message,
          position: position,
          onDismiss: () => overlayEntry.remove(),
        ),
      );
      
      overlay.insert(overlayEntry);
      
      Future.delayed(duration, () {
        overlayEntry.remove();
      });
    } catch (e) {
      _logger.warning('Failed to show contextual tooltip: $e');
    }
  }
  
  // ============================================================================
  // SMART DEFAULTS
  // ============================================================================
  
  /// Get smart default value for a setting
  T getSmartDefault<T>(String settingKey, T fallback) {
    try {
      final smartDefaults = _getSmartDefaults();
      return smartDefaults[settingKey] as T? ?? fallback;
    } catch (e) {
      _logger.warning('Failed to get smart default for $settingKey: $e');
      return fallback;
    }
  }
  
  /// Get smart defaults based on user behavior and context
  Map<String, dynamic> _getSmartDefaults() {
    return {
      'theme_mode': 'system', // Follow system theme
      'font_size': 'medium', // Medium font size for readability
      'auto_save': true, // Auto-save notes
      'sync_enabled': true, // Enable sync by default
      'notifications_enabled': true, // Enable notifications
      'ai_assist_enabled': true, // Enable AI assistance
      'haptic_feedback': true, // Enable haptic feedback
      'sound_effects': true, // Enable sound effects
      'auto_backup': true, // Enable auto backup
      'privacy_mode': false, // Disable privacy mode by default
      'dark_mode': 'system', // Follow system dark mode
      'language': 'en', // English by default
      'timezone': 'system', // Follow system timezone
      'date_format': 'system', // Follow system date format
      'time_format': 'system', // Follow system time format
    };
  }
  
  /// Get smart suggestion based on context
  String? getSmartSuggestion(String context, Map<String, dynamic> data) {
    try {
      switch (context) {
        case 'note_title':
          return _suggestNoteTitle(data);
        case 'note_category':
          return _suggestNoteCategory(data);
        case 'note_tags':
          return _suggestNoteTags(data);
        case 'search_query':
          return _suggestSearchQuery(data);
        default:
          return null;
      }
    } catch (e) {
      _logger.warning('Failed to get smart suggestion for $context: $e');
      return null;
    }
  }
  
  /// Suggest note title based on content
  String? _suggestNoteTitle(Map<String, dynamic> data) {
    final content = data['content'] as String? ?? '';
    if (content.isEmpty) return null;
    
    // Extract first line or first sentence as title
    final firstLine = content.split('\n').first.trim();
    if (firstLine.length > 50) {
      return '${firstLine.substring(0, 47)}...';
    }
    return firstLine;
  }
  
  /// Suggest note category based on content
  String? _suggestNoteCategory(Map<String, dynamic> data) {
    final content = data['content'] as String? ?? '';
    if (content.isEmpty) return null;
    
    // Simple keyword-based category suggestion
    final lowerContent = content.toLowerCase();
    
    if (lowerContent.contains('meeting') || lowerContent.contains('agenda')) {
      return 'Work';
    } else if (lowerContent.contains('grocery') || lowerContent.contains('shopping')) {
      return 'Shopping';
    } else if (lowerContent.contains('idea') || lowerContent.contains('creative')) {
      return 'Ideas';
    } else if (lowerContent.contains('todo') || lowerContent.contains('task')) {
      return 'Tasks';
    } else if (lowerContent.contains('recipe') || lowerContent.contains('cooking')) {
      return 'Recipes';
    }
    
    return 'General';
  }
  
  /// Suggest note tags based on content
  String? _suggestNoteTags(Map<String, dynamic> data) {
    final content = data['content'] as String? ?? '';
    if (content.isEmpty) return null;
    
    // Simple keyword-based tag suggestion
    final lowerContent = content.toLowerCase();
    final tags = <String>[];
    
    if (lowerContent.contains('important') || lowerContent.contains('urgent')) {
      tags.add('important');
    }
    if (lowerContent.contains('work') || lowerContent.contains('office')) {
      tags.add('work');
    }
    if (lowerContent.contains('personal') || lowerContent.contains('private')) {
      tags.add('personal');
    }
    if (lowerContent.contains('idea') || lowerContent.contains('creative')) {
      tags.add('ideas');
    }
    if (lowerContent.contains('todo') || lowerContent.contains('task')) {
      tags.add('tasks');
    }
    
    return tags.isNotEmpty ? tags.join(', ') : null;
  }
  
  /// Suggest search query based on context
  String? _suggestSearchQuery(Map<String, dynamic> data) {
    final recentSearches = data['recent_searches'] as List<String>? ?? [];
    if (recentSearches.isEmpty) return null;
    
    // Return most recent search
    return recentSearches.first;
  }
  
  // ============================================================================
  // USER BEHAVIOR ANALYSIS
  // ============================================================================
  
  /// Track user behavior
  void trackUserBehavior(String action, Map<String, dynamic> context) {
    try {
      _logger.debug('Tracking user behavior: $action with context: $context');
      
      // Store behavior data for analysis
      _storeBehaviorData(action, context);
      
      // Update user preferences based on behavior
      _updateUserPreferences(action, context);
    } catch (e) {
      _logger.warning('Failed to track user behavior: $e');
    }
  }
  
  /// Store behavior data
  void _storeBehaviorData(String action, Map<String, dynamic> context) {
    // In a real implementation, you would store this in a database
    _logger.debug('Storing behavior data: $action');
  }
  
  /// Update user preferences based on behavior
  void _updateUserPreferences(String action, Map<String, dynamic> context) {
    // In a real implementation, you would update user preferences
    _logger.debug('Updating user preferences based on: $action');
  }
  
  /// Get user behavior insights
  Map<String, dynamic> getUserBehaviorInsights() {
    try {
      // In a real implementation, you would analyze stored behavior data
      return {
        'most_used_features': ['notes_list', 'note_edit', 'search'],
        'preferred_theme': 'dark',
        'active_hours': [9, 10, 11, 14, 15, 16, 20, 21],
        'favorite_categories': ['Work', 'Ideas', 'Tasks'],
        'average_note_length': 150,
        'sync_frequency': 'high',
      };
    } catch (e) {
      _logger.warning('Failed to get user behavior insights: $e');
      return {};
    }
  }
  
  // ============================================================================
  // ADAPTIVE UI
  // ============================================================================
  
  /// Get adaptive widget based on user preferences
  Widget getAdaptiveWidget(String widgetType, Map<String, dynamic> context) {
    try {
      final userPreferences = getUserBehaviorInsights();
      
      switch (widgetType) {
        case 'button':
          return _getAdaptiveButton(context, userPreferences);
        case 'card':
          return _getAdaptiveCard(context, userPreferences);
        case 'input':
          return _getAdaptiveInput(context, userPreferences);
        case 'list':
          return _getAdaptiveList(context, userPreferences);
        default:
          return const SizedBox();
      }
    } catch (e) {
      _logger.warning('Failed to get adaptive widget: $e');
      return const SizedBox();
    }
  }
  
  /// Get adaptive button
  Widget _getAdaptiveButton(Map<String, dynamic> context, Map<String, dynamic> preferences) {
    final preferredTheme = preferences['preferred_theme'] as String? ?? 'light';
    final isDark = preferredTheme == 'dark';
    
    return ElevatedButton(
      onPressed: context['onPressed'] as VoidCallback?,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDark ? DesignTokens.primaryLight : DesignTokens.primary,
        foregroundColor: isDark ? DesignTokens.neutral900 : Colors.white,
      ),
      child: Text(context['text'] as String? ?? 'Button'),
    );
  }
  
  /// Get adaptive card
  Widget _getAdaptiveCard(Map<String, dynamic> context, Map<String, dynamic> preferences) {
    final preferredTheme = preferences['preferred_theme'] as String? ?? 'light';
    final isDark = preferredTheme == 'dark';
    
    return Card(
      color: isDark ? DesignTokens.surfaceDark : DesignTokens.surfaceLight,
      child: Padding(
        padding: const EdgeInsets.all(DesignTokens.spacing4),
        child: Text(context['content'] as String? ?? 'Card content'),
      ),
    );
  }
  
  /// Get adaptive input
  Widget _getAdaptiveInput(Map<String, dynamic> context, Map<String, dynamic> preferences) {
    final preferredTheme = preferences['preferred_theme'] as String? ?? 'light';
    final isDark = preferredTheme == 'dark';
    
    return TextField(
      decoration: InputDecoration(
        hintText: context['hint'] as String? ?? 'Enter text',
        filled: true,
        fillColor: isDark ? DesignTokens.neutral800 : DesignTokens.neutral50,
      ),
    );
  }
  
  /// Get adaptive list
  Widget _getAdaptiveList(Map<String, dynamic> context, Map<String, dynamic> preferences) {
    final items = context['items'] as List<Widget>? ?? [];
    final preferredTheme = preferences['preferred_theme'] as String? ?? 'light';
    final isDark = preferredTheme == 'dark';
    
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Container(
          color: isDark ? DesignTokens.surfaceDark : DesignTokens.surfaceLight,
          child: items[index],
        );
      },
    );
  }
}

// ============================================================================
// PRIVATE WIDGETS
// ============================================================================

/// Contextual help widget
class _ContextualHelp extends StatefulWidget {
  final Widget child;
  final String helpText;
  final String? title;
  final Duration delay;
  final bool showOnHover;
  final bool showOnTap;
  
  const _ContextualHelp({
    required this.child,
    required this.helpText,
    this.title,
    required this.delay,
    required this.showOnHover,
    required this.showOnTap,
  });
  
  @override
  State<_ContextualHelp> createState() => _ContextualHelpState();
}

class _ContextualHelpState extends State<_ContextualHelp> {
  bool _showHelp = false;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.showOnTap ? _toggleHelp : null,
      child: MouseRegion(
        onEnter: widget.showOnHover ? (_) => _showHelpAfterDelay() : null,
        onExit: widget.showOnHover ? (_) => _hideHelp() : null,
        child: Stack(
          children: [
            widget.child,
            if (_showHelp)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(DesignTokens.spacing2),
                  decoration: BoxDecoration(
                    color: DesignTokens.neutral800,
                    borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
                  ),
                  child: Text(
                    widget.helpText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: DesignTokens.fontSizeSm,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
  
  void _showHelpAfterDelay() {
    Future.delayed(widget.delay, () {
      if (mounted) {
        setState(() {
          _showHelp = true;
        });
      }
    });
  }
  
  void _hideHelp() {
    if (mounted) {
      setState(() {
        _showHelp = false;
      });
    }
  }
  
  void _toggleHelp() {
    setState(() {
      _showHelp = !_showHelp;
    });
  }
}

/// Contextual tooltip widget
class _ContextualTooltip extends StatelessWidget {
  final String message;
  final TooltipPosition position;
  final VoidCallback onDismiss;
  
  const _ContextualTooltip({
    required this.message,
    required this.position,
    required this.onDismiss,
  });
  
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: position == TooltipPosition.top ? 50 : null,
      bottom: position == TooltipPosition.bottom ? 50 : null,
      left: 20,
      right: 20,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(DesignTokens.spacing4),
          decoration: BoxDecoration(
            color: DesignTokens.neutral800,
            borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
            boxShadow: DesignTokens.shadowLg,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: DesignTokens.fontSizeSm,
                  ),
                ),
              ),
              IconButton(
                onPressed: onDismiss,
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

