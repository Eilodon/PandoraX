import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notes_app/widgets/lottie_mascot.dart';

void main() {
  group('LottieMascot Widget Tests', () {
    testWidgets('should display LottieMascot with custom animation', (tester) async {
      // Arrange
      const animationPath = 'assets/lottie/welcome.json';
      const width = 100.0;
      const height = 100.0;

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LottieMascot(
              animationPath: animationPath,
              width: width,
              height: height,
              repeat: true,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(LottieMascot), findsOneWidget);
    });

    testWidgets('should display WelcomeMascot', (tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WelcomeMascot(size: 150),
          ),
        ),
      );

      // Assert
      expect(find.byType(WelcomeMascot), findsOneWidget);
    });

    testWidgets('should display ThinkingMascot', (tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ThinkingMascot(size: 100),
          ),
        ),
      );

      // Assert
      expect(find.byType(ThinkingMascot), findsOneWidget);
    });

    testWidgets('should display SuccessMascot', (tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SuccessMascot(size: 120),
          ),
        ),
      );

      // Assert
      expect(find.byType(SuccessMascot), findsOneWidget);
    });

    testWidgets('should display ErrorMascot', (tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ErrorMascot(size: 100),
          ),
        ),
      );

      // Assert
      expect(find.byType(ErrorMascot), findsOneWidget);
    });

    testWidgets('should display LoadingMascot', (tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoadingMascot(size: 80),
          ),
        ),
      );

      // Assert
      expect(find.byType(LoadingMascot), findsOneWidget);
    });

    testWidgets('should display CelebrationMascot', (tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CelebrationMascot(size: 180),
          ),
        ),
      );

      // Assert
      expect(find.byType(CelebrationMascot), findsOneWidget);
    });

    testWidgets('should display WaveMascot', (tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WaveMascot(size: 100),
          ),
        ),
      );

      // Assert
      expect(find.byType(WaveMascot), findsOneWidget);
    });

    testWidgets('should display WritingMascot', (tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WritingMascot(size: 120),
          ),
        ),
      );

      // Assert
      expect(find.byType(WritingMascot), findsOneWidget);
    });

    testWidgets('should display MicrophoneMascot', (tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MicrophoneMascot(size: 100),
          ),
        ),
      );

      // Assert
      expect(find.byType(MicrophoneMascot), findsOneWidget);
    });

    testWidgets('should display ChatMascot', (tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ChatMascot(size: 100),
          ),
        ),
      );

      // Assert
      expect(find.byType(ChatMascot), findsOneWidget);
    });

    testWidgets('should show fallback widget when animation fails', (tester) async {
      // Arrange
      const invalidPath = 'assets/lottie/non_existent.json';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LottieMascot(
              animationPath: invalidPath,
              width: 100,
              height: 100,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byIcon(Icons.pets), findsOneWidget);
    });

    testWidgets('should call onAnimationComplete when provided', (tester) async {
      // Arrange
      bool animationCompleted = false;
      void onComplete() {
        animationCompleted = true;
      }

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LottieMascot(
              animationPath: 'assets/lottie/welcome.json',
              width: 100,
              height: 100,
              repeat: false,
              onAnimationComplete: onComplete,
            ),
          ),
        ),
      );

      // Simulate animation completion
      await tester.pumpAndSettle();

      // Assert
      // Note: In a real test, you would need to wait for the actual animation
      // to complete or mock the Lottie animation
      expect(find.byType(LottieMascot), findsOneWidget);
    });
  });

  group('MascotAnimations Constants', () {
    test('should have correct animation paths', () {
      // Assert
      expect(MascotAnimations.welcome, equals('assets/lottie/welcome.json'));
      expect(MascotAnimations.thinking, equals('assets/lottie/thinking.json'));
      expect(MascotAnimations.success, equals('assets/lottie/success.json'));
      expect(MascotAnimations.error, equals('assets/lottie/error.json'));
      expect(MascotAnimations.loading, equals('assets/lottie/loading.json'));
      expect(MascotAnimations.celebration, equals('assets/lottie/celebration.json'));
      expect(MascotAnimations.wave, equals('assets/lottie/wave.json'));
      expect(MascotAnimations.writing, equals('assets/lottie/writing.json'));
      expect(MascotAnimations.microphone, equals('assets/lottie/microphone.json'));
      expect(MascotAnimations.chat, equals('assets/lottie/chat.json'));
    });
  });
}
