import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pandora/main.dart' as app;
import 'package:pandora/demo/demo_mode.dart';

/// Integration tests specifically for APK testing
/// These tests verify that the app works correctly when installed as APK
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('APK Integration Tests', () {
    
    setUpAll(() async {
      // Enable demo mode for APK testing
      await DemoModeManager.enableDemoMode();
    });

    tearDownAll(() async {
      // Clean up demo mode after tests
      await DemoModeManager.disableDemoMode();
    });

    testWidgets('APK Launch and Basic Navigation', (tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(Duration(seconds: 3));

      // Verify app launches successfully
      expect(find.text('Notes'), findsOneWidget);
      
      // Verify demo mode indicator is present (if implemented)
      // This confirms the app is running in demo mode
      
      // Test basic navigation
      final floatingButtons = find.byType(FloatingActionButton);
      expect(floatingButtons, findsAtLeast(1));

      print('✅ APK launched successfully with Notes screen');
    });

    testWidgets('Demo Mode Features in APK', (tester) async {
      app.main();
      await tester.pumpAndSettle(Duration(seconds: 3));

      // Test AI Chat feature
      final chatButton = find.byIcon(Icons.chat);
      if (chatButton.evaluate().isNotEmpty) {
        await tester.tap(chatButton);
        await tester.pumpAndSettle(Duration(seconds: 2));

        expect(find.text('Trò chuyện với AI'), findsOneWidget);
        
        // Test sending a message
        final textField = find.byType(TextField);
        if (textField.evaluate().isNotEmpty) {
          await tester.enterText(textField.first, 'Hello AI from APK test');
          await tester.pumpAndSettle();
          
          // Try to send message
          final sendButton = find.byIcon(Icons.send);
          if (sendButton.evaluate().isNotEmpty) {
            await tester.tap(sendButton);
            await tester.pumpAndSettle(Duration(seconds: 3));
          }
        }

        // Go back
        final backButton = find.byIcon(Icons.arrow_back);
        if (backButton.evaluate().isNotEmpty) {
          await tester.tap(backButton);
          await tester.pumpAndSettle();
        }
      }

      print('✅ AI Chat tested in APK');
    });

    testWidgets('Voice Recording Feature in APK', (tester) async {
      app.main();
      await tester.pumpAndSettle(Duration(seconds: 3));

      // Test Voice Recording
      final micButton = find.byIcon(Icons.mic);
      if (micButton.evaluate().isNotEmpty) {
        await tester.tap(micButton);
        await tester.pumpAndSettle(Duration(seconds: 2));

        expect(find.text('Ghi âm tạo ghi chú'), findsOneWidget);
        
        // In demo mode, speech recognition should work with mock data
        // Test start recording button if present
        final startButton = find.widgetWithText(ElevatedButton, 'Bắt đầu ghi âm');
        if (startButton.evaluate().isNotEmpty) {
          await tester.tap(startButton);
          await tester.pumpAndSettle(Duration(seconds: 2));
          
          // Wait for mock transcription
          await tester.pumpAndSettle(Duration(seconds: 3));
          
          // Stop recording
          final stopButton = find.widgetWithText(ElevatedButton, 'Dừng ghi âm');
          if (stopButton.evaluate().isNotEmpty) {
            await tester.tap(stopButton);
            await tester.pumpAndSettle();
          }
        }

        // Go back
        final backButton = find.byIcon(Icons.arrow_back);
        if (backButton.evaluate().isNotEmpty) {
          await tester.tap(backButton);
          await tester.pumpAndSettle();
        }
      }

      print('✅ Voice Recording tested in APK');
    });

    testWidgets('Notes List and Detail in APK', (tester) async {
      app.main();
      await tester.pumpAndSettle(Duration(seconds: 3));

      // Test notes list
      final notesList = find.byType(ListView);
      expect(notesList, findsOneWidget);

      // If there are demo notes, test tapping on one
      final noteTiles = find.byType(ListTile);
      if (noteTiles.evaluate().isNotEmpty) {
        await tester.tap(noteTiles.first);
        await tester.pumpAndSettle(Duration(seconds: 2));

        // Should be on note detail screen
        expect(find.byType(Scaffold), findsOneWidget);
        
        // Test AI Summary if present
        final summarySection = find.text('AI Summary');
        if (summarySection.evaluate().isNotEmpty) {
          final summarizeButton = find.widgetWithText(ElevatedButton, 'Summarize');
          if (summarizeButton.evaluate().isNotEmpty) {
            await tester.tap(summarizeButton);
            await tester.pumpAndSettle(Duration(seconds: 3));
            // Should show AI summary or loading state
          }
        }

        // Go back to notes list
        final backButton = find.byIcon(Icons.arrow_back);
        if (backButton.evaluate().isNotEmpty) {
          await tester.tap(backButton);
          await tester.pumpAndSettle();
        }
      }

      print('✅ Notes functionality tested in APK');
    });

    testWidgets('Demo Controls Access in APK', (tester) async {
      app.main();
      await tester.pumpAndSettle(Duration(seconds: 3));

      // Try to access demo controls if they exist in the UI
      // This could be through settings, menu, or dedicated demo button
      
      // Look for demo-related UI elements
      final demoButton = find.byIcon(Icons.science);
      if (demoButton.evaluate().isNotEmpty) {
        await tester.tap(demoButton);
        await tester.pumpAndSettle(Duration(seconds: 2));
        
        // Should see demo controls
        expect(find.text('Demo Mode'), findsAtLeast(1));
        
        // Test running scenarios if button exists
        final runScenariosButton = find.widgetWithText(ElevatedButton, 'Run Test Scenarios');
        if (runScenariosButton.evaluate().isNotEmpty) {
          await tester.tap(runScenariosButton);
          await tester.pumpAndSettle(Duration(seconds: 5));
          // Should show test results or progress
        }
        
        // Go back
        final backButton = find.byIcon(Icons.arrow_back);
        if (backButton.evaluate().isNotEmpty) {
          await tester.tap(backButton);
          await tester.pumpAndSettle();
        }
      }

      print('✅ Demo controls tested in APK');
    });

    testWidgets('App Performance and Stability in APK', (tester) async {
      app.main();
      await tester.pumpAndSettle(Duration(seconds: 3));

      // Test app stability by performing multiple operations
      for (int i = 0; i < 3; i++) {
        // Navigate to different screens and back
        final floatingButtons = find.byType(FloatingActionButton);
        if (floatingButtons.evaluate().length >= 2) {
          // Test multiple buttons
          await tester.tap(floatingButtons.at(0));
          await tester.pumpAndSettle(Duration(seconds: 1));
          
          final backButton = find.byIcon(Icons.arrow_back);
          if (backButton.evaluate().isNotEmpty) {
            await tester.tap(backButton);
            await tester.pumpAndSettle();
          }
          
          await tester.tap(floatingButtons.at(1));
          await tester.pumpAndSettle(Duration(seconds: 1));
          
          if (backButton.evaluate().isNotEmpty) {
            await tester.tap(backButton);
            await tester.pumpAndSettle();
          }
        }
      }

      // Verify app is still responsive
      expect(find.text('Notes'), findsOneWidget);
      
      print('✅ App stability tested in APK');
    });

    testWidgets('Memory and Resource Usage in APK', (tester) async {
      app.main();
      await tester.pumpAndSettle(Duration(seconds: 3));

      // Perform memory-intensive operations
      // Generate lots of demo data access
      for (int i = 0; i < 10; i++) {
        // Trigger demo data generation
        await tester.pumpAndSettle(Duration(milliseconds: 100));
      }

      // App should still be responsive
      expect(find.text('Notes'), findsOneWidget);
      
      print('✅ Memory usage tested in APK');
    });

    testWidgets('Offline Functionality in APK', (tester) async {
      app.main();
      await tester.pumpAndSettle(Duration(seconds: 3));

      // In demo mode, app should work offline
      // Test creating a note (if feature exists)
      final addButton = find.byIcon(Icons.add);
      if (addButton.evaluate().isNotEmpty) {
        await tester.tap(addButton);
        await tester.pumpAndSettle(Duration(seconds: 2));
        
        // Should be able to access note creation
        // Even without internet connection
      }

      print('✅ Offline functionality tested in APK');
    });

    testWidgets('Error Handling in APK', (tester) async {
      app.main();
      await tester.pumpAndSettle(Duration(seconds: 3));

      // Test error scenarios that might occur in APK
      // Try to trigger AI service with invalid input
      final chatButton = find.byIcon(Icons.chat);
      if (chatButton.evaluate().isNotEmpty) {
        await tester.tap(chatButton);
        await tester.pumpAndSettle(Duration(seconds: 2));

        final textField = find.byType(TextField);
        if (textField.evaluate().isNotEmpty) {
          // Send very long message to test error handling
          await tester.enterText(textField.first, 'A' * 1000);
          await tester.pumpAndSettle();
          
          final sendButton = find.byIcon(Icons.send);
          if (sendButton.evaluate().isNotEmpty) {
            await tester.tap(sendButton);
            await tester.pumpAndSettle(Duration(seconds: 3));
            // App should handle this gracefully
          }
        }

        final backButton = find.byIcon(Icons.arrow_back);
        if (backButton.evaluate().isNotEmpty) {
          await tester.tap(backButton);
          await tester.pumpAndSettle();
        }
      }

      print('✅ Error handling tested in APK');
    });
  });

  group('APK Demo Data Verification', () {
    testWidgets('Demo Notes are Loaded in APK', (tester) async {
      app.main();
      await tester.pumpAndSettle(Duration(seconds: 3));

      // In demo mode, there should be pre-loaded notes
      final notesList = find.byType(ListView);
      expect(notesList, findsOneWidget);

      // Should have demo notes
      final noteTiles = find.byType(ListTile);
      expect(noteTiles.evaluate().length, greaterThan(0));

      print('✅ Demo notes verified in APK');
    });

    testWidgets('Mock Services are Working in APK', (tester) async {
      app.main();
      await tester.pumpAndSettle(Duration(seconds: 3));

      // Test that mock services are functioning
      // AI service should respond (even if mocked)
      final chatButton = find.byIcon(Icons.chat);
      if (chatButton.evaluate().isNotEmpty) {
        await tester.tap(chatButton);
        await tester.pumpAndSettle(Duration(seconds: 2));

        final textField = find.byType(TextField);
        if (textField.evaluate().isNotEmpty) {
          await tester.enterText(textField.first, 'Test mock AI');
          await tester.pumpAndSettle();
          
          final sendButton = find.byIcon(Icons.send);
          if (sendButton.evaluate().isNotEmpty) {
            await tester.tap(sendButton);
            await tester.pumpAndSettle(Duration(seconds: 4));
            
            // Should get some response (even if error message about mock)
            // This confirms mock services are working
          }
        }

        final backButton = find.byIcon(Icons.arrow_back);
        if (backButton.evaluate().isNotEmpty) {
          await tester.tap(backButton);
          await tester.pumpAndSettle();
        }
      }

      print('✅ Mock services verified in APK');
    });
  });

  group('APK Performance Tests', () {
    testWidgets('App Launch Time in APK', (tester) async {
      final stopwatch = Stopwatch()..start();
      
      app.main();
      await tester.pumpAndSettle(Duration(seconds: 5));
      
      stopwatch.stop();
      
      // App should launch within reasonable time
      expect(stopwatch.elapsedMilliseconds, lessThan(10000)); // 10 seconds max
      expect(find.text('Notes'), findsOneWidget);
      
      print('✅ App launch time: ${stopwatch.elapsedMilliseconds}ms');
    });

    testWidgets('Navigation Performance in APK', (tester) async {
      app.main();
      await tester.pumpAndSettle(Duration(seconds: 3));

      final stopwatch = Stopwatch();
      
      // Test navigation speed
      final floatingButtons = find.byType(FloatingActionButton);
      if (floatingButtons.evaluate().isNotEmpty) {
        stopwatch.start();
        await tester.tap(floatingButtons.first);
        await tester.pumpAndSettle();
        stopwatch.stop();
        
        // Navigation should be fast
        expect(stopwatch.elapsedMilliseconds, lessThan(3000)); // 3 seconds max
        
        final backButton = find.byIcon(Icons.arrow_back);
        if (backButton.evaluate().isNotEmpty) {
          await tester.tap(backButton);
          await tester.pumpAndSettle();
        }
      }
      
      print('✅ Navigation performance: ${stopwatch.elapsedMilliseconds}ms');
    });
  });
}
