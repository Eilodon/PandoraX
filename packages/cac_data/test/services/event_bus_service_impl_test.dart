import 'package:flutter_test/flutter_test.dart';
import 'package:cac_core/cac_core.dart';
import 'package:cac_data/cac_data.dart';

void main() {
  group('EventBusServiceImpl', () {
    late EventBusServiceImpl eventBus;

    setUp(() {
      eventBus = EventBusServiceImpl();
    });

    tearDown(() {
      eventBus.dispose();
    });

    group('publishEvent', () {
      test('should publish event to stream', () async {
        // Arrange
        final event = CacEvent.noteCreated(
          noteId: 'test-id',
          content: 'test content',
          timestamp: DateTime.now(),
        );

        // Act
        eventBus.publishEvent(event);

        // Assert
        await expectLater(
          eventBus.eventStream.first,
          equals(event),
        );
      });
    });

    group('eventsOfType', () {
      test('should filter events by type', () async {
        // Arrange
        final noteEvent = CacEvent.noteCreated(
          noteId: 'test-id',
          content: 'test content',
          timestamp: DateTime.now(),
        );
        final userEvent = CacEvent.userTyped(
          text: 'test text',
          appId: 'test-app',
          timestamp: DateTime.now(),
        );

        // Act
        eventBus.publishEvent(noteEvent);
        eventBus.publishEvent(userEvent);

        // Assert
        await expectLater(
          eventBus.eventsOfType<CacEvent.noteCreated>().first,
          equals(noteEvent),
        );
      });
    });

    group('eventStream', () {
      test('should emit all events', () async {
        // Arrange
        final events = [
          CacEvent.noteCreated(
            noteId: 'test-id-1',
            content: 'test content 1',
            timestamp: DateTime.now(),
          ),
          CacEvent.noteCreated(
            noteId: 'test-id-2',
            content: 'test content 2',
            timestamp: DateTime.now(),
          ),
        ];

        // Act & Assert
        for (final event in events) {
          eventBus.publishEvent(event);
          await expectLater(
            eventBus.eventStream.first,
            equals(event),
          );
        }
      });
    });
  });
}
