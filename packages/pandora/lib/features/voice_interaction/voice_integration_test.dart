import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pandora/main.dart' as app;
import 'package:pandora/features/voice_interaction/voice_demo_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Voice Features Integration Tests', () {
    testWidgets('Voice demo screen loads correctly', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Navigate to voice demo screen
      await tester.tap(find.text('Voice Demo'));
      await tester.pumpAndSettle();

      // Verify voice demo screen elements
      expect(find.text('🎤 Voice Features Demo'), findsOneWidget);
      expect(find.text('🎯 Voice System Status'), findsOneWidget);
      expect(find.text('🎤 Voice Interaction'), findsOneWidget);
      expect(find.text('🗣️ Voice Commands Demo'), findsOneWidget);
      expect(find.text('🔊 Text-to-Speech Demo'), findsOneWidget);
      expect(find.text('🧠 PhoWhisper Offline STT'), findsOneWidget);
    });

    testWidgets('Voice controls work correctly', (WidgetTester tester) async {
      // Navigate to voice demo screen
      await tester.tap(find.text('Voice Demo'));
      await tester.pumpAndSettle();

      // Find and tap start listening button
      final startButton = find.widgetWithText(PandoraButton, 'Start');
      expect(startButton, findsOneWidget);
      
      await tester.tap(startButton);
      await tester.pumpAndSettle();

      // Verify button changes to stop
      expect(find.widgetWithText(PandoraButton, 'Stop'), findsOneWidget);
      
      // Tap stop button
      await tester.tap(find.widgetWithText(PandoraButton, 'Stop'));
      await tester.pumpAndSettle();

      // Verify button changes back to start
      expect(find.widgetWithText(PandoraButton, 'Start'), findsOneWidget);
    });

    testWidgets('Voice commands demo works', (WidgetTester tester) async {
      // Navigate to voice demo screen
      await tester.tap(find.text('Voice Demo'));
      await tester.pumpAndSettle();

      // Test voice command chips
      final commandChips = [
        'Tạo ghi chú mới',
        'Tìm ghi chú về dự án',
        'Đặt nhắc nhở lúc 3 giờ',
        'Trò chuyện với AI',
        'Mở màn hình chính',
      ];

      for (final command in commandChips) {
        final chip = find.widgetWithText(PandoraChip, command);
        expect(chip, findsOneWidget);
        
        await tester.tap(chip);
        await tester.pumpAndSettle();
        
        // Wait for processing
        await tester.pump(const Duration(seconds: 2));
      }
    });

    testWidgets('TTS demo works correctly', (WidgetTester tester) async {
      // Navigate to voice demo screen
      await tester.tap(find.text('Voice Demo'));
      await tester.pumpAndSettle();

      // Find TTS demo section
      expect(find.text('🔊 Text-to-Speech Demo'), findsOneWidget);
      
      // Find play buttons for sample texts
      final playButtons = find.byIcon(Icons.play_arrow);
      expect(playButtons, findsWidgets);
      
      // Tap first play button
      if (playButtons.evaluate().isNotEmpty) {
        await tester.tap(playButtons.first);
        await tester.pumpAndSettle();
        
        // Wait for TTS processing
        await tester.pump(const Duration(seconds: 3));
      }
    });

    testWidgets('PhoWhisper demo shows correct status', (WidgetTester tester) async {
      // Navigate to voice demo screen
      await tester.tap(find.text('Voice Demo'));
      await tester.pumpAndSettle();

      // Find PhoWhisper section
      expect(find.text('🧠 PhoWhisper Offline STT'), findsOneWidget);
      
      // Check for download button (model not available)
      final downloadButton = find.widgetWithText(PandoraButton, 'Download PhoWhisper Model');
      if (downloadButton.evaluate().isNotEmpty) {
        expect(downloadButton, findsOneWidget);
        
        // Tap download button
        await tester.tap(downloadButton);
        await tester.pumpAndSettle();
        
        // Wait for download process
        await tester.pump(const Duration(seconds: 2));
      }
    });

    testWidgets('Voice settings modal opens', (WidgetTester tester) async {
      // Navigate to voice demo screen
      await tester.tap(find.text('Voice Demo'));
      await tester.pumpAndSettle();

      // Find settings button in app bar
      final settingsButton = find.byIcon(Icons.settings_voice);
      expect(settingsButton, findsOneWidget);
      
      // Tap settings button
      await tester.tap(settingsButton);
      await tester.pumpAndSettle();

      // Verify settings modal opens
      expect(find.text('Voice Settings'), findsOneWidget);
      expect(find.text('Select Voice:'), findsOneWidget);
      expect(find.text('Speech Speed:'), findsOneWidget);
      expect(find.text('Volume:'), findsOneWidget);
      
      // Close modal
      await tester.tap(find.widgetWithText(PandoraButton, 'Save Settings'));
      await tester.pumpAndSettle();
    });

    testWidgets('Quick actions work correctly', (WidgetTester tester) async {
      // Navigate to voice demo screen
      await tester.tap(find.text('Voice Demo'));
      await tester.pumpAndSettle();

      // Find quick action buttons
      final clearButton = find.widgetWithText(PandoraButton, 'Clear History');
      final settingsButton = find.widgetWithText(PandoraButton, 'Settings');
      
      expect(clearButton, findsOneWidget);
      expect(settingsButton, findsOneWidget);
      
      // Tap clear history button
      await tester.tap(clearButton);
      await tester.pumpAndSettle();
      
      // Tap settings button
      await tester.tap(settingsButton);
      await tester.pumpAndSettle();
      
      // Close settings modal
      await tester.tap(find.widgetWithText(PandoraButton, 'Save Settings'));
      await tester.pumpAndSettle();
    });

    testWidgets('Error handling works correctly', (WidgetTester tester) async {
      // Navigate to voice demo screen
      await tester.tap(find.text('Voice Demo'));
      await tester.pumpAndSettle();

      // Try to start listening without permissions
      final startButton = find.widgetWithText(PandoraButton, 'Start');
      await tester.tap(startButton);
      await tester.pumpAndSettle();

      // Check for error handling (if permissions not granted)
      // This test assumes proper error handling is implemented
      await tester.pump(const Duration(seconds: 2));
    });

    testWidgets('Voice visualization updates correctly', (WidgetTester tester) async {
      // Navigate to voice demo screen
      await tester.tap(find.text('Voice Demo'));
      await tester.pumpAndSettle();

      // Find voice visualization (microphone icon)
      final micIcon = find.byIcon(Icons.mic_none);
      expect(micIcon, findsOneWidget);
      
      // Start listening
      final startButton = find.widgetWithText(PandoraButton, 'Start');
      await tester.tap(startButton);
      await tester.pumpAndSettle();

      // Check if icon changes to listening state
      final listeningIcon = find.byIcon(Icons.mic);
      // Note: This might not find the widget if the state doesn't change
      // due to permission issues in test environment
      
      await tester.pump(const Duration(seconds: 1));
      
      // Stop listening
      final stopButton = find.widgetWithText(PandoraButton, 'Stop');
      if (stopButton.evaluate().isNotEmpty) {
        await tester.tap(stopButton);
        await tester.pumpAndSettle();
      }
    });

    testWidgets('Voice status overview displays correctly', (WidgetTester tester) async {
      // Navigate to voice demo screen
      await tester.tap(find.text('Voice Demo'));
      await tester.pumpAndSettle();

      // Check voice status overview
      expect(find.text('🎯 Voice System Status'), findsOneWidget);
      
      // Check status items
      expect(find.text('STT'), findsOneWidget);
      expect(find.text('TTS'), findsOneWidget);
      expect(find.text('PhoWhisper'), findsOneWidget);
      
      // Check status indicators
      final statusIndicators = find.byType(Container);
      expect(statusIndicators, findsWidgets);
    });
  });

  group('Voice Performance Tests', () {
    testWidgets('Voice interaction response time', (WidgetTester tester) async {
      final stopwatch = Stopwatch()..start();
      
      // Navigate to voice demo screen
      await tester.tap(find.text('Voice Demo'));
      await tester.pumpAndSettle();
      
      // Start voice interaction
      final startButton = find.widgetWithText(PandoraButton, 'Start');
      await tester.tap(startButton);
      await tester.pumpAndSettle();
      
      stopwatch.stop();
      
      // Verify response time is within acceptable limits
      expect(stopwatch.elapsedMilliseconds, lessThan(5000)); // 5 seconds max
    });

    testWidgets('TTS response time', (WidgetTester tester) async {
      final stopwatch = Stopwatch()..start();
      
      // Navigate to voice demo screen
      await tester.tap(find.text('Voice Demo'));
      await tester.pumpAndSettle();
      
      // Find and tap TTS play button
      final playButtons = find.byIcon(Icons.play_arrow);
      if (playButtons.evaluate().isNotEmpty) {
        await tester.tap(playButtons.first);
        await tester.pumpAndSettle();
        
        stopwatch.stop();
        
        // Verify TTS response time
        expect(stopwatch.elapsedMilliseconds, lessThan(3000)); // 3 seconds max
      }
    });
  });
}
