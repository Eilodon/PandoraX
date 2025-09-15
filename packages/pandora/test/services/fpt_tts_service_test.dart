import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import 'package:pandora/services/fpt_tts_service.dart';
import 'package:pandora/config/voice_config.dart';

class MockHttpClient extends Mock implements http.Client {}
class MockAudioPlayer extends Mock implements AudioPlayer {}

void main() {
  group('FptTtsService', () {
    late FptTtsService ttsService;
    late MockHttpClient mockHttpClient;
    late MockAudioPlayer mockAudioPlayer;

    setUp(() {
      mockHttpClient = MockHttpClient();
      mockAudioPlayer = MockAudioPlayer();
      ttsService = FptTtsService();
    });

    group('textToSpeech', () {
      test('should return audio bytes when API call succeeds', () async {
        // Mock successful HTTP response
        final mockAudioBytes = [1, 2, 3, 4, 5]; // Mock audio data
        final mockResponse = http.Response.bytes(mockAudioBytes, 200);
        
        when(() => mockHttpClient.post(
          Uri.parse(VoiceConfig.fptTtsUrl),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        )).thenAnswer((_) async => mockResponse);

        final result = await ttsService.textToSpeech('Hello world');
        
        expect(result, isNotNull);
        expect(result!.length, equals(mockAudioBytes.length));
        
        verify(() => mockHttpClient.post(
          Uri.parse(VoiceConfig.fptTtsUrl),
          headers: {
            'api-key': VoiceConfig.fptApiKey,
            'voice': VoiceConfig.defaultVoice,
            'speed': VoiceConfig.defaultSpeed.toString(),
            'format': VoiceConfig.audioFormat,
          },
          body: 'Hello world',
        )).called(1);
      });

      test('should throw exception when API call fails', () async {
        // Mock failed HTTP response
        final mockResponse = http.Response('Error', 400);
        
        when(() => mockHttpClient.post(
          Uri.parse(VoiceConfig.fptTtsUrl),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        )).thenAnswer((_) async => mockResponse);

        expect(
          () => ttsService.textToSpeech('Hello world'),
          throwsA(isA<Exception>()),
        );
      });

      test('should use custom voice when provided', () async {
        const customVoice = 'linhsan';
        final mockResponse = http.Response.bytes([1, 2, 3], 200);
        
        when(() => mockHttpClient.post(
          Uri.parse(VoiceConfig.fptTtsUrl),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        )).thenAnswer((_) async => mockResponse);

        await ttsService.textToSpeech('Hello', voice: customVoice);
        
        verify(() => mockHttpClient.post(
          Uri.parse(VoiceConfig.fptTtsUrl),
          headers: {
            'api-key': VoiceConfig.fptApiKey,
            'voice': customVoice,
            'speed': VoiceConfig.defaultSpeed.toString(),
            'format': VoiceConfig.audioFormat,
          },
          body: 'Hello',
        )).called(1);
      });
    });

    group('textToSpeechFile', () {
      test('should create audio file successfully', () async {
        final mockAudioBytes = [1, 2, 3, 4, 5];
        final mockResponse = http.Response.bytes(mockAudioBytes, 200);
        
        when(() => mockHttpClient.post(
          Uri.parse(VoiceConfig.fptTtsUrl),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        )).thenAnswer((_) async => mockResponse);

        final result = await ttsService.textToSpeechFile(
          'Hello world',
          fileName: 'test_audio.mp3',
        );
        
        expect(result, isNotNull);
        expect(result, endsWith('test_audio.mp3'));
      });

      test('should use default filename when not provided', () async {
        final mockAudioBytes = [1, 2, 3, 4, 5];
        final mockResponse = http.Response.bytes(mockAudioBytes, 200);
        
        when(() => mockHttpClient.post(
          Uri.parse(VoiceConfig.fptTtsUrl),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        )).thenAnswer((_) async => mockResponse);

        final result = await ttsService.textToSpeechFile('Hello world');
        
        expect(result, isNotNull);
        expect(result, startsWith('tts_'));
        expect(result, endsWith('.mp3'));
      });
    });

    group('speakText', () {
      test('should play audio successfully', () async {
        final mockAudioBytes = [1, 2, 3, 4, 5];
        final mockResponse = http.Response.bytes(mockAudioBytes, 200);
        
        when(() => mockHttpClient.post(
          Uri.parse(VoiceConfig.fptTtsUrl),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        )).thenAnswer((_) async => mockResponse);

        when(() => mockAudioPlayer.play(any()))
            .thenAnswer((_) async {});
        
        when(() => mockAudioPlayer.onPlayerComplete)
            .thenAnswer((_) => Stream.empty());

        await ttsService.speakText('Hello world');
        
        verify(() => mockAudioPlayer.play(any())).called(1);
      });

      test('should call onComplete callback when audio finishes', () async {
        final mockAudioBytes = [1, 2, 3, 4, 5];
        final mockResponse = http.Response.bytes(mockAudioBytes, 200);
        bool onCompleteCalled = false;
        
        when(() => mockHttpClient.post(
          Uri.parse(VoiceConfig.fptTtsUrl),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        )).thenAnswer((_) async => mockResponse);

        when(() => mockAudioPlayer.play(any()))
            .thenAnswer((_) async {});
        
        when(() => mockAudioPlayer.onPlayerComplete)
            .thenAnswer((_) => Stream.value(PlayerState.completed));

        await ttsService.speakText(
          'Hello world',
          onComplete: () => onCompleteCalled = true,
        );
        
        // Wait for completion
        await Future.delayed(const Duration(milliseconds: 100));
        
        expect(onCompleteCalled, isTrue);
      });

      test('should call onError callback when error occurs', () async {
        const errorMessage = 'Network error';
        bool onErrorCalled = false;
        
        when(() => mockHttpClient.post(
          Uri.parse(VoiceConfig.fptTtsUrl),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        )).thenThrow(Exception(errorMessage));

        await ttsService.speakText(
          'Hello world',
          onError: (error) {
            onErrorCalled = true;
            expect(error, contains(errorMessage));
          },
        );
        
        expect(onErrorCalled, isTrue);
      });
    });

    group('getAvailableVoices', () {
      test('should return list of available voices', () {
        final voices = ttsService.getAvailableVoices();
        
        expect(voices, isNotEmpty);
        expect(voices.length, equals(VoiceConfig.vietnameseVoices.length));
        
        for (final voice in voices) {
          expect(voice, containsPair('id', isA<String>()));
          expect(voice, containsPair('name', isA<String>()));
          expect(voice, containsPair('language', 'vi-VN'));
        }
      });
    });

    group('isValidVoice', () {
      test('should return true for valid voice IDs', () {
        for (final voiceId in VoiceConfig.vietnameseVoices.keys) {
          expect(ttsService.isValidVoice(voiceId), isTrue);
        }
      });

      test('should return false for invalid voice IDs', () {
        const invalidVoices = ['invalid', 'unknown', 'test'];
        
        for (final voiceId in invalidVoices) {
          expect(ttsService.isValidVoice(voiceId), isFalse);
        }
      });
    });

    group('getVoiceInfo', () {
      test('should return voice info for valid voice ID', () {
        const voiceId = 'banmai';
        final voiceInfo = ttsService.getVoiceInfo(voiceId);
        
        expect(voiceInfo, isNotNull);
        expect(voiceInfo!['id'], equals(voiceId));
        expect(voiceInfo['name'], equals(VoiceConfig.vietnameseVoices[voiceId]));
        expect(voiceInfo['language'], equals('vi-VN'));
        expect(voiceInfo['gender'], isA<String>());
        expect(voiceInfo['region'], isA<String>());
      });

      test('should return null for invalid voice ID', () {
        const invalidVoiceId = 'invalid';
        final voiceInfo = ttsService.getVoiceInfo(invalidVoiceId);
        
        expect(voiceInfo, isNull);
      });
    });

    group('audio control methods', () {
      test('should stop speaking', () async {
        when(() => mockAudioPlayer.stop())
            .thenAnswer((_) async {});

        await ttsService.stopSpeaking();
        
        verify(() => mockAudioPlayer.stop()).called(1);
      });

      test('should pause speaking', () async {
        when(() => mockAudioPlayer.pause())
            .thenAnswer((_) async {});

        await ttsService.pauseSpeaking();
        
        verify(() => mockAudioPlayer.pause()).called(1);
      });

      test('should resume speaking', () async {
        when(() => mockAudioPlayer.resume())
            .thenAnswer((_) async {});

        await ttsService.resumeSpeaking();
        
        verify(() => mockAudioPlayer.resume()).called(1);
      });

      test('should set playback speed', () async {
        const speed = 1.5;
        when(() => mockAudioPlayer.setPlaybackSpeed(speed))
            .thenAnswer((_) async {});

        await ttsService.setPlaybackSpeed(speed);
        
        verify(() => mockAudioPlayer.setPlaybackSpeed(speed)).called(1);
      });

      test('should set volume', () async {
        const volume = 0.8;
        when(() => mockAudioPlayer.setVolume(volume))
            .thenAnswer((_) async {});

        await ttsService.setVolume(volume);
        
        verify(() => mockAudioPlayer.setVolume(volume)).called(1);
      });
    });

    tearDown(() {
      ttsService.dispose();
    });
  });
}
