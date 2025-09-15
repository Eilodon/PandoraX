import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pandora/services/voice_interaction_service.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class MockSpeechToText extends Mock implements SpeechToText {}
class MockAudioPlayer extends Mock implements AudioPlayer {}
class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('VoiceInteractionService', () {
    late VoiceInteractionService voiceService;
    late MockSpeechToText mockSpeechToText;
    late MockAudioPlayer mockAudioPlayer;

    setUp(() {
      mockSpeechToText = MockSpeechToText();
      mockAudioPlayer = MockAudioPlayer();
      voiceService = VoiceInteractionService();
    });

    group('initialize', () {
      test('should return true when initialization succeeds', () async {
        // Mock permission granted
        when(() => Permission.microphone.request())
            .thenAnswer((_) async => PermissionStatus.granted);
        
        // Mock speech to text initialization
        when(() => mockSpeechToText.initialize(
          onError: any(named: 'onError'),
          onStatus: any(named: 'onStatus'),
        )).thenAnswer((_) async => true);

        final result = await voiceService.initialize();
        
        expect(result, isTrue);
        expect(voiceService.isInitialized, isTrue);
      });

      test('should return false when microphone permission denied', () async {
        // Mock permission denied
        when(() => Permission.microphone.request())
            .thenAnswer((_) async => PermissionStatus.denied);

        final result = await voiceService.initialize();
        
        expect(result, isFalse);
        expect(voiceService.isInitialized, isFalse);
      });

      test('should return false when speech to text not available', () async {
        // Mock permission granted
        when(() => Permission.microphone.request())
            .thenAnswer((_) async => PermissionStatus.granted);
        
        // Mock speech to text not available
        when(() => mockSpeechToText.initialize(
          onError: any(named: 'onError'),
          onStatus: any(named: 'onStatus'),
        )).thenAnswer((_) async => false);

        final result = await voiceService.initialize();
        
        expect(result, isFalse);
        expect(voiceService.isInitialized, isFalse);
      });
    });

    group('startListening', () {
      test('should start listening when initialized', () async {
        // Initialize service
        when(() => Permission.microphone.request())
            .thenAnswer((_) async => PermissionStatus.granted);
        when(() => mockSpeechToText.initialize(
          onError: any(named: 'onError'),
          onStatus: any(named: 'onStatus'),
        )).thenAnswer((_) async => true);
        
        await voiceService.initialize();

        // Mock listen method
        when(() => mockSpeechToText.listen(
          onResult: any(named: 'onResult'),
          listenFor: any(named: 'listenFor'),
          pauseFor: any(named: 'pauseFor'),
          partialResults: any(named: 'partialResults'),
          localeId: any(named: 'localeId'),
          onSoundLevelChange: any(named: 'onSoundLevelChange'),
        )).thenAnswer((_) async {});

        await voiceService.startListening();
        
        verify(() => mockSpeechToText.listen(
          onResult: any(named: 'onResult'),
          listenFor: any(named: 'listenFor'),
          pauseFor: any(named: 'pauseFor'),
          partialResults: true,
          localeId: 'vi_VN',
          onSoundLevelChange: any(named: 'onSoundLevelChange'),
        )).called(1);
      });

      test('should not start listening when not initialized', () async {
        await voiceService.startListening();
        
        verifyNever(() => mockSpeechToText.listen(
          onResult: any(named: 'onResult'),
          listenFor: any(named: 'listenFor'),
          pauseFor: any(named: 'pauseFor'),
          partialResults: any(named: 'partialResults'),
          localeId: any(named: 'localeId'),
          onSoundLevelChange: any(named: 'onSoundLevelChange'),
        ));
      });
    });

    group('stopListening', () {
      test('should stop listening', () async {
        when(() => mockSpeechToText.stop())
            .thenAnswer((_) async {});

        await voiceService.stopListening();
        
        verify(() => mockSpeechToText.stop()).called(1);
      });
    });

    group('speakText', () {
      test('should speak text when internet available', () async {
        // Mock internet connection
        when(() => voiceService._hasInternetConnection())
            .thenAnswer((_) async => true);
        
        // Mock HTTP response
        final mockResponse = http.Response('audio_data', 200);
        when(() => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        )).thenAnswer((_) async => mockResponse);

        await voiceService.speakText('Hello world');
        
        verify(() => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: 'Hello world',
        )).called(1);
      });

      test('should use system TTS when internet not available', () async {
        // Mock no internet connection
        when(() => voiceService._hasInternetConnection())
            .thenAnswer((_) async => false);

        await voiceService.speakText('Hello world');
        
        // Should call system TTS fallback
        verify(() => voiceService._speakWithSystemTts('Hello world'))
            .called(1);
      });
    });

    group('processVoiceCommand', () {
      test('should process voice command successfully', () async {
        const command = 'Tạo ghi chú mới';
        const expectedResponse = 'Tôi đã nghe bạn nói: $command';
        
        // Mock AI service response
        when(() => voiceService.processVoiceCommand(command))
            .thenAnswer((_) async {});

        await voiceService.processVoiceCommand(command);
        
        verify(() => voiceService.processVoiceCommand(command)).called(1);
      });
    });

    tearDown(() {
      voiceService.dispose();
    });
  });
}
