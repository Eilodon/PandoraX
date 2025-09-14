import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pandora/features/speech_recognition/application/speech_recognition_service.dart';
import 'package:pandora/features/speech_recognition/application/speech_recognition_notifier.dart';
import 'package:pandora/features/speech_recognition/application/speech_recognition_state.dart';

class MockSpeechRecognitionService extends Mock implements SpeechRecognitionService {}

void main() {
  group('SpeechRecognitionNotifier', () {
    late SpeechRecognitionNotifier notifier;
    late MockSpeechRecognitionService mockService;

    setUp(() {
      mockService = MockSpeechRecognitionService();
      notifier = SpeechRecognitionNotifier(mockService);
    });

    test('should initialize with default state', () {
      expect(notifier.state, equals(const SpeechRecognitionState()));
    });

    group('initialization', () {
      test('should set initialized state when service initializes successfully', () async {
        // Arrange
        when(() => mockService.initialize()).thenAnswer((_) async => true);
        when(() => mockService.recognizedTextStream).thenAnswer((_) => Stream.value(''));
        when(() => mockService.partialTextStream).thenAnswer((_) => Stream.value(''));
        when(() => mockService.isListeningStream).thenAnswer((_) => Stream.value(false));
        when(() => mockService.errorStream).thenAnswer((_) => Stream.value(''));

        // Act
        // Note: _initialize is called in constructor, so we just verify the state

        // Assert
        expect(notifier.state.isInitialized, isTrue);
        expect(notifier.state.hasError, isFalse);
        expect(notifier.state.errorMessage, isNull);
      });

      test('should set error state when service fails to initialize', () async {
        // Arrange
        when(() => mockService.initialize()).thenAnswer((_) async => false);

        // Act
        // Note: _initialize is called in constructor, so we just verify the state

        // Assert
        expect(notifier.state.isInitialized, isFalse);
        expect(notifier.state.hasError, isTrue);
        expect(notifier.state.errorMessage, contains('Không thể khởi tạo'));
      });
    });

    group('startListening', () {
      test('should start listening when initialized', () async {
        // Arrange
        notifier.state = notifier.state.copyWith(isInitialized: true);
        when(() => mockService.startListening()).thenAnswer((_) async {});

        // Act
        await notifier.startListening();

        // Assert
        verify(() => mockService.startListening()).called(1);
        expect(notifier.state.hasError, isFalse);
        expect(notifier.state.errorMessage, isNull);
      });

      test('should set error when not initialized', () async {
        // Arrange
        notifier.state = notifier.state.copyWith(isInitialized: false);

        // Act
        await notifier.startListening();

        // Assert
        expect(notifier.state.hasError, isTrue);
        expect(notifier.state.errorMessage, contains('chưa được khởi tạo'));
        verifyNever(() => mockService.startListening());
      });
    });

    group('stopListening', () {
      test('should stop listening', () async {
        // Arrange
        when(() => mockService.stopListening()).thenAnswer((_) async {});

        // Act
        await notifier.stopListening();

        // Assert
        verify(() => mockService.stopListening()).called(1);
      });
    });

    group('cancelListening', () {
      test('should cancel listening', () async {
        // Arrange
        when(() => mockService.cancelListening()).thenAnswer((_) async {});

        // Act
        await notifier.cancelListening();

        // Assert
        verify(() => mockService.cancelListening()).called(1);
      });
    });

    group('clearText', () {
      test('should clear recognized and partial text', () {
        // Arrange
        notifier.state = notifier.state.copyWith(
          recognizedText: 'Test text',
          partialText: 'Partial text',
        );

        // Act
        notifier.clearText();

        // Assert
        expect(notifier.state.recognizedText, isEmpty);
        expect(notifier.state.partialText, isEmpty);
      });
    });

    group('stream listeners', () {
      test('should update recognized text from stream', () async {
        // Arrange
        const testText = 'Recognized text';
        when(() => mockService.recognizedTextStream)
            .thenAnswer((_) => Stream.value(testText));
        when(() => mockService.partialTextStream)
            .thenAnswer((_) => Stream.value(''));
        when(() => mockService.isListeningStream)
            .thenAnswer((_) => Stream.value(false));
        when(() => mockService.errorStream)
            .thenAnswer((_) => Stream.value(''));

        // Act
        // Note: _initialize is called in constructor, so we just verify the state
        await Future.delayed(const Duration(milliseconds: 100));

        // Assert
        expect(notifier.state.recognizedText, equals(testText));
      });

      test('should update partial text from stream', () async {
        // Arrange
        const testText = 'Partial text';
        when(() => mockService.recognizedTextStream)
            .thenAnswer((_) => Stream.value(''));
        when(() => mockService.partialTextStream)
            .thenAnswer((_) => Stream.value(testText));
        when(() => mockService.isListeningStream)
            .thenAnswer((_) => Stream.value(false));
        when(() => mockService.errorStream)
            .thenAnswer((_) => Stream.value(''));

        // Act
        // Note: _initialize is called in constructor, so we just verify the state
        await Future.delayed(const Duration(milliseconds: 100));

        // Assert
        expect(notifier.state.partialText, equals(testText));
      });

      test('should update listening state from stream', () async {
        // Arrange
        when(() => mockService.recognizedTextStream)
            .thenAnswer((_) => Stream.value(''));
        when(() => mockService.partialTextStream)
            .thenAnswer((_) => Stream.value(''));
        when(() => mockService.isListeningStream)
            .thenAnswer((_) => Stream.value(true));
        when(() => mockService.errorStream)
            .thenAnswer((_) => Stream.value(''));

        // Act
        // Note: _initialize is called in constructor, so we just verify the state
        await Future.delayed(const Duration(milliseconds: 100));

        // Assert
        expect(notifier.state.isListening, isTrue);
      });

      test('should handle error from stream', () async {
        // Arrange
        const errorMessage = 'Test error';
        when(() => mockService.recognizedTextStream)
            .thenAnswer((_) => Stream.value(''));
        when(() => mockService.partialTextStream)
            .thenAnswer((_) => Stream.value(''));
        when(() => mockService.isListeningStream)
            .thenAnswer((_) => Stream.value(false));
        when(() => mockService.errorStream)
            .thenAnswer((_) => Stream.value(errorMessage));

        // Act
        // Note: _initialize is called in constructor, so we just verify the state
        await Future.delayed(const Duration(milliseconds: 100));

        // Assert
        expect(notifier.state.hasError, isTrue);
        expect(notifier.state.errorMessage, equals(errorMessage));
        expect(notifier.state.isListening, isFalse);
      });
    });
  });
}
