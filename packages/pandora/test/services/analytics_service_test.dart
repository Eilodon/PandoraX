import 'package:flutter_test/flutter_test.dart';
import 'package:pandora/services/analytics_service.dart';

void main() {
  group('AnalyticsService', () {
    late AnalyticsService analyticsService;

    setUp(() {
      analyticsService = AnalyticsService();
    });

    group('trackScreenView', () {
      test('should track screen view without parameters', () async {
        // Act
        await analyticsService.trackScreenView('test_screen');

        // Assert
        // Since this is a mock implementation, we just verify it doesn't throw
        expect(() => analyticsService.trackScreenView('test_screen'), returnsNormally);
      });

      test('should track screen view with parameters', () async {
        // Arrange
        const screenName = 'test_screen';
        final parameters = {'user_id': '123', 'action': 'view'};

        // Act
        await analyticsService.trackScreenView(screenName, parameters: parameters);

        // Assert
        expect(() => analyticsService.trackScreenView(screenName, parameters: parameters), returnsNormally);
      });
    });

    group('trackUserAction', () {
      test('should track user action', () async {
        // Act
        await analyticsService.trackUserAction('button_click');

        // Assert
        expect(() => analyticsService.trackUserAction('button_click'), returnsNormally);
      });

      test('should track user action with parameters', () async {
        // Arrange
        const action = 'note_created';
        final parameters = {'note_id': '123', 'title': 'Test Note'};

        // Act
        await analyticsService.trackUserAction(action, parameters: parameters);

        // Assert
        expect(() => analyticsService.trackUserAction(action, parameters: parameters), returnsNormally);
      });
    });

    group('trackAiInteraction', () {
      test('should track AI interaction', () async {
        // Act
        await analyticsService.trackAiInteraction('chat_message');

        // Assert
        expect(() => analyticsService.trackAiInteraction('chat_message'), returnsNormally);
      });

      test('should track AI interaction with parameters', () async {
        // Arrange
        const interactionType = 'summarize';
        final parameters = {'note_id': '123', 'success': true};

        // Act
        await analyticsService.trackAiInteraction(interactionType, parameters: parameters);

        // Assert
        expect(() => analyticsService.trackAiInteraction(interactionType, parameters: parameters), returnsNormally);
      });
    });

    group('trackVoiceRecognition', () {
      test('should track voice recognition event', () async {
        // Act
        await analyticsService.trackVoiceRecognition('start_listening');

        // Assert
        expect(() => analyticsService.trackVoiceRecognition('start_listening'), returnsNormally);
      });

      test('should track voice recognition with parameters', () async {
        // Arrange
        const event = 'recognition_complete';
        final parameters = {'duration': 5.0, 'success': true, 'language': 'vi'};

        // Act
        await analyticsService.trackVoiceRecognition(event, parameters: parameters);

        // Assert
        expect(() => analyticsService.trackVoiceRecognition(event, parameters: parameters), returnsNormally);
      });
    });

    group('trackSyncEvent', () {
      test('should track sync event', () async {
        // Act
        await analyticsService.trackSyncEvent('sync_started');

        // Assert
        expect(() => analyticsService.trackSyncEvent('sync_started'), returnsNormally);
      });

      test('should track sync event with parameters', () async {
        // Arrange
        const event = 'sync_completed';
        final parameters = {'notes_synced': 10, 'duration': 2.5};

        // Act
        await analyticsService.trackSyncEvent(event, parameters: parameters);

        // Assert
        expect(() => analyticsService.trackSyncEvent(event, parameters: parameters), returnsNormally);
      });
    });

    group('trackError', () {
      test('should track error', () async {
        // Act
        await analyticsService.trackError('Test error', 'Stack trace');

        // Assert
        expect(() => analyticsService.trackError('Test error', 'Stack trace'), returnsNormally);
      });

      test('should track error with parameters', () async {
        // Arrange
        const error = 'API Error';
        const stackTrace = 'Stack trace';
        final parameters = {'context': 'ai_service', 'severity': 'high'};

        // Act
        await analyticsService.trackError(error, stackTrace, parameters: parameters);

        // Assert
        expect(() => analyticsService.trackError(error, stackTrace, parameters: parameters), returnsNormally);
      });
    });

    group('trackPerformance', () {
      test('should track performance metric', () async {
        // Act
        await analyticsService.trackPerformance('app_startup', 1.5);

        // Assert
        expect(() => analyticsService.trackPerformance('app_startup', 1.5), returnsNormally);
      });

      test('should track performance with parameters', () async {
        // Arrange
        const metric = 'api_response_time';
        const value = 0.8;
        final parameters = {'endpoint': '/notes', 'method': 'GET'};

        // Act
        await analyticsService.trackPerformance(metric, value, parameters: parameters);

        // Assert
        expect(() => analyticsService.trackPerformance(metric, value, parameters: parameters), returnsNormally);
      });
    });

    group('trackNoteOperation', () {
      test('should track note operation', () async {
        // Act
        await analyticsService.trackNoteOperation('create');

        // Assert
        expect(() => analyticsService.trackNoteOperation('create'), returnsNormally);
      });

      test('should track note operation with parameters', () async {
        // Arrange
        const operation = 'update';
        final parameters = {'note_id': '123', 'has_ai_summary': true};

        // Act
        await analyticsService.trackNoteOperation(operation, parameters: parameters);

        // Assert
        expect(() => analyticsService.trackNoteOperation(operation, parameters: parameters), returnsNormally);
      });
    });
  });
}
