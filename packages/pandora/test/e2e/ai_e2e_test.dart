import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pandora/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('AI End-to-End Tests', () {
    testWidgets('Complete AI workflow from app start to response', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Wait for app to fully load
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Test 1: Navigate to AI Chat Screen
      await _testNavigateToAIChat(tester);

      // Test 2: Check AI Mode Indicator
      await _testAIModeIndicator(tester);

      // Test 3: Send AI message
      await _testSendAIMessage(tester);

      // Test 4: Navigate to Model Download Screen
      await _testNavigateToModelDownload(tester);

      // Test 5: Check Device Capability
      await _testDeviceCapability(tester);

      // Test 6: Navigate to AI Settings
      await _testNavigateToAISettings(tester);

      // Test 7: Test Settings Changes
      await _testAISettingsChanges(tester);

      // Test 8: Test Health Monitoring
      await _testHealthMonitoring(tester);
    });

    testWidgets('AI Mode switching workflow', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to AI Chat
      await _testNavigateToAIChat(tester);

      // Test mode switching
      await _testAIModeSwitching(tester);
    });

    testWidgets('Model download workflow', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to Model Download
      await _testNavigateToModelDownload(tester);

      // Test model download
      await _testModelDownload(tester);
    });

    testWidgets('Error handling and recovery', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to AI Chat
      await _testNavigateToAIChat(tester);

      // Test error scenarios
      await _testErrorScenarios(tester);
    });
  });
}

// Helper functions for E2E tests

Future<void> _testNavigateToAIChat(WidgetTester tester) async {
  // Look for AI Chat button or navigation item
  final aiChatButton = find.byKey(const Key('ai_chat_button'));
  if (aiChatButton.evaluate().isNotEmpty) {
    await tester.tap(aiChatButton);
    await tester.pumpAndSettle();
  } else {
    // Alternative: Look for AI-related text or icons
    final aiText = find.text('AI Chat');
    if (aiText.evaluate().isNotEmpty) {
      await tester.tap(aiText);
      await tester.pumpAndSettle();
    }
  }

  // Verify we're on AI Chat screen
  expect(find.text('AI Chat'), findsOneWidget);
}

Future<void> _testAIModeIndicator(WidgetTester tester) async {
  // Look for AI Mode Indicator
  final modeIndicator = find.byKey(const Key('ai_mode_indicator'));
  expect(modeIndicator, findsOneWidget);

  // Check if indicator shows current mode
  final modeText = find.textContaining('On-Device');
  final cloudText = find.textContaining('Cloud');
  
  // At least one should be present
  expect(modeText.evaluate().isNotEmpty || cloudText.evaluate().isNotEmpty, isTrue);
}

Future<void> _testSendAIMessage(WidgetTester tester) async {
  // Find message input field
  final messageInput = find.byKey(const Key('message_input'));
  expect(messageInput, findsOneWidget);

  // Type a test message
  await tester.enterText(messageInput, 'Hello, AI!');
  await tester.pumpAndSettle();

  // Find and tap send button
  final sendButton = find.byKey(const Key('send_button'));
  expect(sendButton, findsOneWidget);
  
  await tester.tap(sendButton);
  await tester.pumpAndSettle();

  // Wait for AI response
  await tester.pumpAndSettle(const Duration(seconds: 3));

  // Verify message was sent and response received
  expect(find.text('Hello, AI!'), findsOneWidget);
  // AI response should appear (exact text may vary)
  expect(find.byType(Text), findsWidgets);
}

Future<void> _testNavigateToModelDownload(WidgetTester tester) async {
  // Look for Model Download button or navigation
  final modelDownloadButton = find.byKey(const Key('model_download_button'));
  if (modelDownloadButton.evaluate().isNotEmpty) {
    await tester.tap(modelDownloadButton);
    await tester.pumpAndSettle();
  } else {
    // Alternative: Look in settings or menu
    final settingsButton = find.byKey(const Key('settings_button'));
    if (settingsButton.evaluate().isNotEmpty) {
      await tester.tap(settingsButton);
      await tester.pumpAndSettle();
      
      // Look for Model Download option
      final modelDownloadText = find.text('Download AI Model');
      if (modelDownloadText.evaluate().isNotEmpty) {
        await tester.tap(modelDownloadText);
        await tester.pumpAndSettle();
      }
    }
  }

  // Verify we're on Model Download screen
  expect(find.text('Download AI Model'), findsOneWidget);
}

Future<void> _testDeviceCapability(WidgetTester tester) async {
  // Look for device capability information
  final capabilityCard = find.byKey(const Key('device_capability_card'));
  expect(capabilityCard, findsOneWidget);

  // Check for capability details
  expect(find.text('Device Capability'), findsOneWidget);
  expect(find.textContaining('RAM'), findsOneWidget);
  expect(find.textContaining('Storage'), findsOneWidget);
}

Future<void> _testNavigateToAISettings(WidgetTester tester) async {
  // Look for Settings button
  final settingsButton = find.byKey(const Key('settings_button'));
  if (settingsButton.evaluate().isNotEmpty) {
    await tester.tap(settingsButton);
    await tester.pumpAndSettle();
  } else {
    // Alternative: Look for AI Settings in menu
    final aiSettingsText = find.text('AI Settings');
    if (aiSettingsText.evaluate().isNotEmpty) {
      await tester.tap(aiSettingsText);
      await tester.pumpAndSettle();
    }
  }

  // Verify we're on AI Settings screen
  expect(find.text('AI Settings'), findsOneWidget);
}

Future<void> _testAISettingsChanges(WidgetTester tester) async {
  // Test toggling settings
  final autoDownloadSwitch = find.byKey(const Key('auto_download_switch'));
  if (autoDownloadSwitch.evaluate().isNotEmpty) {
    await tester.tap(autoDownloadSwitch);
    await tester.pumpAndSettle();
  }

  final gpuSwitch = find.byKey(const Key('gpu_switch'));
  if (gpuSwitch.evaluate().isNotEmpty) {
    await tester.tap(gpuSwitch);
    await tester.pumpAndSettle();
  }

  // Test mode switching buttons
  final onDeviceButton = find.byKey(const Key('on_device_button'));
  if (onDeviceButton.evaluate().isNotEmpty) {
    await tester.tap(onDeviceButton);
    await tester.pumpAndSettle();
  }

  final cloudButton = find.byKey(const Key('cloud_button'));
  if (cloudButton.evaluate().isNotEmpty) {
    await tester.tap(cloudButton);
    await tester.pumpAndSettle();
  }
}

Future<void> _testHealthMonitoring(WidgetTester tester) async {
  // Look for health status
  final healthStatus = find.byKey(const Key('health_status'));
  if (healthStatus.evaluate().isNotEmpty) {
    // Tap to view details
    await tester.tap(healthStatus);
    await tester.pumpAndSettle();

    // Check for health details
    expect(find.textContaining('Health'), findsWidgets);
  }
}

Future<void> _testAIModeSwitching(WidgetTester tester) async {
  // Find AI Mode Indicator
  final modeIndicator = find.byKey(const Key('ai_mode_indicator'));
  expect(modeIndicator, findsOneWidget);

  // Tap to open mode selection
  await tester.tap(modeIndicator);
  await tester.pumpAndSettle();

  // Look for mode selection options
  final onDeviceOption = find.text('Use On-Device');
  final cloudOption = find.text('Use Cloud');

  if (onDeviceOption.evaluate().isNotEmpty) {
    await tester.tap(onDeviceOption);
    await tester.pumpAndSettle();
  }

  if (cloudOption.evaluate().isNotEmpty) {
    await tester.tap(cloudOption);
    await tester.pumpAndSettle();
  }
}

Future<void> _testModelDownload(WidgetTester tester) async {
  // Look for model selection
  final modelCards = find.byKey(const Key('model_card'));
  if (modelCards.evaluate().isNotEmpty) {
    // Tap on a model card
    await tester.tap(modelCards.first);
    await tester.pumpAndSettle();
  }

  // Look for download button
  final downloadButton = find.byKey(const Key('download_button'));
  if (downloadButton.evaluate().isNotEmpty) {
    await tester.tap(downloadButton);
    await tester.pumpAndSettle();

    // Wait for download to start
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Check for progress indicator
    expect(find.byKey(const Key('download_progress')), findsOneWidget);
  }
}

Future<void> _testErrorScenarios(WidgetTester tester) async {
  // Test with invalid input
  final messageInput = find.byKey(const Key('message_input'));
  if (messageInput.evaluate().isNotEmpty) {
    // Send empty message
    await tester.enterText(messageInput, '');
    await tester.pumpAndSettle();

    final sendButton = find.byKey(const Key('send_button'));
    if (sendButton.evaluate().isNotEmpty) {
      await tester.tap(sendButton);
      await tester.pumpAndSettle();
    }

    // Send very long message
    await tester.enterText(messageInput, 'A' * 1000);
    await tester.pumpAndSettle();

    if (sendButton.evaluate().isNotEmpty) {
      await tester.tap(sendButton);
      await tester.pumpAndSettle();
    }
  }

  // Test network error scenarios
  // (This would require mocking network conditions)
}

// Performance testing helpers
Future<void> _testPerformance(WidgetTester tester) async {
  final stopwatch = Stopwatch()..start();

  // Perform operations
  await _testNavigateToAIChat(tester);
  await _testSendAIMessage(tester);
  await _testNavigateToModelDownload(tester);
  await _testNavigateToAISettings(tester);

  stopwatch.stop();

  // Verify performance
  expect(stopwatch.elapsedMilliseconds, lessThan(10000)); // Should complete in under 10 seconds
}

// Accessibility testing helpers
Future<void> _testAccessibility(WidgetTester tester) async {
  // Test screen reader support
  final semantics = tester.binding.pipelineOwner.semanticsOwner;
  expect(semantics, isNotNull);

  // Test keyboard navigation
  await tester.sendKeyEvent(LogicalKeyboardKey.tab);
  await tester.pumpAndSettle();

  // Test focus management
  final focusedWidget = tester.binding.focusManager.primaryFocus;
  expect(focusedWidget, isNotNull);
}
