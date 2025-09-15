import 'package:injectable/injectable.dart';

/// Analytics service for tracking user behavior and app performance
@injectable
class AnalyticsService {
  static const String _appName = 'Pandora Notes';
  
  /// Track screen view
  Future<void> trackScreenView(String screenName, {Map<String, dynamic>? parameters}) async {
    try {
      final eventData = {
        'screen_name': screenName,
        'app_name': _appName,
        'timestamp': DateTime.now().toIso8601String(),
        ...?parameters,
      };
      
      // TODO: Integrate with Firebase Analytics or other analytics service
      print('📊 Screen View: $screenName - $eventData');
    } catch (e) {
      print('❌ Analytics error: $e');
    }
  }
  
  /// Track user action
  Future<void> trackUserAction(String action, {Map<String, dynamic>? parameters}) async {
    try {
      final eventData = {
        'action': action,
        'app_name': _appName,
        'timestamp': DateTime.now().toIso8601String(),
        ...?parameters,
      };
      
      print('📊 User Action: $action - $eventData');
    } catch (e) {
      print('❌ Analytics error: $e');
    }
  }
  
  /// Track AI interaction
  Future<void> trackAiInteraction(String interactionType, {Map<String, dynamic>? parameters}) async {
    try {
      final eventData = {
        'interaction_type': interactionType,
        'app_name': _appName,
        'timestamp': DateTime.now().toIso8601String(),
        ...?parameters,
      };
      
      print('🤖 AI Interaction: $interactionType - $eventData');
    } catch (e) {
      print('❌ Analytics error: $e');
    }
  }
  
  /// Track voice recognition usage
  Future<void> trackVoiceRecognition(String event, {Map<String, dynamic>? parameters}) async {
    try {
      final eventData = {
        'event': event,
        'app_name': _appName,
        'timestamp': DateTime.now().toIso8601String(),
        ...?parameters,
      };
      
      print('🎤 Voice Recognition: $event - $eventData');
    } catch (e) {
      print('❌ Analytics error: $e');
    }
  }
  
  /// Track sync events
  Future<void> trackSyncEvent(String event, {Map<String, dynamic>? parameters}) async {
    try {
      final eventData = {
        'event': event,
        'app_name': _appName,
        'timestamp': DateTime.now().toIso8601String(),
        ...?parameters,
      };
      
      print('🔄 Sync Event: $event - $eventData');
    } catch (e) {
      print('❌ Analytics error: $e');
    }
  }
  
  /// Track error events
  Future<void> trackError(String error, String? stackTrace, {Map<String, dynamic>? parameters}) async {
    try {
      final eventData = {
        'error': error,
        'stack_trace': stackTrace,
        'app_name': _appName,
        'timestamp': DateTime.now().toIso8601String(),
        ...?parameters,
      };
      
      print('❌ Error: $error - $eventData');
    } catch (e) {
      print('❌ Analytics error: $e');
    }
  }
  
  /// Track performance metrics
  Future<void> trackPerformance(String metric, double value, {Map<String, dynamic>? parameters}) async {
    try {
      final eventData = {
        'metric': metric,
        'value': value,
        'app_name': _appName,
        'timestamp': DateTime.now().toIso8601String(),
        ...?parameters,
      };
      
      print('⚡ Performance: $metric = $value - $eventData');
    } catch (e) {
      print('❌ Analytics error: $e');
    }
  }
  
  /// Track note operations
  Future<void> trackNoteOperation(String operation, {Map<String, dynamic>? parameters}) async {
    try {
      final eventData = {
        'operation': operation,
        'app_name': _appName,
        'timestamp': DateTime.now().toIso8601String(),
        ...?parameters,
      };
      
      print('📝 Note Operation: $operation - $eventData');
    } catch (e) {
      print('❌ Analytics error: $e');
    }
  }
}
