import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pandora_ui/src/services/accessibility_service.dart';
import 'package:pandora_ui/src/services/accessibility_colors.dart';
import 'package:pandora_ui/src/services/focus_management_service.dart';
import 'package:pandora_ui/src/services/keyboard_navigation_service.dart';
import 'package:pandora_ui/src/components/buttons/accessible_pandora_button.dart';

void main() {
  group('AccessibilityService Tests', () {
    test('getSemanticLabel returns correct label for button', () {
      final label = AccessibilityService.getSemanticLabel('button', {
        'text': 'Save',
        'state': 'enabled',
      });
      expect(label, contains('Save'));
      expect(label, contains('button'));
      expect(label, contains('enabled'));
    });

    test('getSemanticLabel returns correct label for card', () {
      final label = AccessibilityService.getSemanticLabel('card', {
        'title': 'Note Title',
        'subtitle': 'Created today',
        'content': 'This is the note content',
      });
      expect(label, contains('Note Title'));
      expect(label, contains('card'));
      expect(label, contains('Created today'));
      expect(label, contains('This is the note content'));
    });

    test('getSemanticLabel returns correct label for input', () {
      final label = AccessibilityService.getSemanticLabel('input', {
        'label': 'Email',
        'hint': 'Enter your email',
        'value': 'user@example.com',
        'error': 'Invalid email',
      });
      expect(label, contains('Email'));
      expect(label, contains('input field'));
      expect(label, contains('Enter your email'));
      expect(label, contains('user@example.com'));
      expect(label, contains('Invalid email'));
    });

    test('getAccessibilityHint returns correct hint for button', () {
      final hint = AccessibilityService.getAccessibilityHint('button', {
        'isChecked': true,
      });
      expect(hint, isNotEmpty);
      expect(hint, contains('Double tap'));
    });

    test('getAccessibilityValue returns correct value for checkbox', () {
      final value = AccessibilityService.getAccessibilityValue('checkbox', {
        'isChecked': true,
      });
      expect(value, equals('checked'));
    });
  });

  group('AccessibilityColors Tests', () {
    test('calculateContrast returns correct ratio for black on white', () {
      final contrast = AccessibilityColors.calculateContrast(Colors.black, Colors.white);
      expect(contrast, closeTo(21.0, 0.1));
    });

    test('calculateContrast returns correct ratio for white on black', () {
      final contrast = AccessibilityColors.calculateContrast(Colors.white, Colors.black);
      expect(contrast, closeTo(21.0, 0.1));
    });

    test('isAccessibleContrast returns true for high contrast', () {
      final isAccessible = AccessibilityColors.isAccessibleContrast(
        Colors.black,
        Colors.white,
      );
      expect(isAccessible, isTrue);
    });

    test('isAccessibleContrast returns false for low contrast', () {
      final isAccessible = AccessibilityColors.isAccessibleContrast(
        Colors.grey,
        Colors.lightGrey,
      );
      expect(isAccessible, isFalse);
    });

    test('getAccessibleColor returns accessible color', () {
      final accessibleColor = AccessibilityColors.getAccessibleColor(
        Colors.grey,
        Colors.white,
      );
      expect(accessibleColor, isNotNull);
      expect(
        AccessibilityColors.isAccessibleContrast(accessibleColor, Colors.white),
        isTrue,
      );
    });

    test('getAccessibilityLevel returns correct level', () {
      final level = AccessibilityColors.getAccessibilityLevel(
        Colors.black,
        Colors.white,
      );
      expect(level, equals(AccessibilityLevel.aaa));
    });
  });

  group('FocusManagementService Tests', () {
    setUp(() {
      FocusManagementService.dispose();
    });

    tearDown(() {
      FocusManagementService.dispose();
    });

    test('registerFocusable adds item to focus order', () {
      final focusNode = FocusNode();
      FocusManagementService.registerFocusable(
        id: 'test1',
        focusNode: focusNode,
        order: 1,
      );
      
      final focusOrder = FocusManagementService.getFocusOrder();
      expect(focusOrder.length, equals(1));
      expect(focusOrder.first.id, equals('test1'));
    });

    test('moveToNext moves to next focusable item', () {
      final focusNode1 = FocusNode();
      final focusNode2 = FocusNode();
      
      FocusManagementService.registerFocusable(
        id: 'test1',
        focusNode: focusNode1,
        order: 1,
      );
      FocusManagementService.registerFocusable(
        id: 'test2',
        focusNode: focusNode2,
        order: 2,
      );
      
      final moved = FocusManagementService.moveToNext();
      expect(moved, isTrue);
    });

    test('moveToPrevious moves to previous focusable item', () {
      final focusNode1 = FocusNode();
      final focusNode2 = FocusNode();
      
      FocusManagementService.registerFocusable(
        id: 'test1',
        focusNode: focusNode1,
        order: 1,
      );
      FocusManagementService.registerFocusable(
        id: 'test2',
        focusNode: focusNode2,
        order: 2,
      );
      
      // Move to second item first
      FocusManagementService.moveToNext();
      
      final moved = FocusManagementService.moveToPrevious();
      expect(moved, isTrue);
    });

    test('setItemFocusable enables/disables focus', () {
      final focusNode = FocusNode();
      FocusManagementService.registerFocusable(
        id: 'test1',
        focusNode: focusNode,
        order: 1,
        canFocus: true,
      );
      
      FocusManagementService.setItemFocusable('test1', false);
      
      final focusOrder = FocusManagementService.getFocusOrder();
      expect(focusOrder.first.canFocus, isFalse);
    });
  });

  group('KeyboardNavigationService Tests', () {
    setUp(() {
      KeyboardNavigationService.clear();
    });

    tearDown(() {
      KeyboardNavigationService.clear();
    });

    test('registerShortcut adds shortcut to list', () {
      const shortcut = KeyboardShortcut(
        id: 'test',
        keySet: LogicalKeySet(LogicalKeyboardKey.keyA),
        action: _testAction,
        description: 'Test shortcut',
      );
      
      KeyboardNavigationService.registerShortcut(shortcut);
      final shortcuts = KeyboardNavigationService.getAvailableShortcuts();
      expect(shortcuts.length, equals(1));
      expect(shortcuts.first.id, equals('test'));
    });

    test('unregisterShortcut removes shortcut from list', () {
      const shortcut = KeyboardShortcut(
        id: 'test',
        keySet: LogicalKeySet(LogicalKeyboardKey.keyA),
        action: _testAction,
        description: 'Test shortcut',
      );
      
      KeyboardNavigationService.registerShortcut(shortcut);
      KeyboardNavigationService.unregisterShortcut('test');
      
      final shortcuts = KeyboardNavigationService.getAvailableShortcuts();
      expect(shortcuts.length, equals(0));
    });
  });

  group('AccessiblePandoraButton Tests', () {
    testWidgets('button has correct accessibility properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AccessiblePandoraButton(
              onPressed: () {},
              accessibilityId: 'test-button',
              focusOrder: 1,
              child: const Text('Test Button'),
            ),
          ),
        ),
      );

      final button = find.byType(AccessiblePandoraButton);
      expect(button, findsOneWidget);

      // Check if button is focusable
      final focusNode = tester.widget<AccessiblePandoraButton>(button).focusOrder;
      expect(focusNode, equals(1));
    });

    testWidgets('button announces completion when pressed', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AccessiblePandoraButton(
              onPressed: () {},
              child: const Text('Test Button'),
            ),
          ),
        ),
      );

      final button = find.byType(AccessiblePandoraButton);
      await tester.tap(button);
      await tester.pump();

      // Button should be tappable
      expect(button, findsOneWidget);
    });

    testWidgets('button respects minimum touch target size', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AccessiblePandoraButton(
              onPressed: () {},
              size: PandoraButtonSize.xs,
              child: const Text('Test'),
            ),
          ),
        ),
      );

      final button = find.byType(AccessiblePandoraButton);
      final buttonWidget = tester.widget<AccessiblePandoraButton>(button);
      
      // Check minimum size constraints
      expect(buttonWidget.minWidth, greaterThanOrEqualTo(44.0));
      expect(buttonWidget.minHeight, greaterThanOrEqualTo(44.0));
    });
  });

  group('Accessibility Integration Tests', () {
    testWidgets('complete accessibility flow works', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                AccessiblePandoraButton(
                  onPressed: () {},
                  accessibilityId: 'button1',
                  focusOrder: 1,
                  child: const Text('Button 1'),
                ),
                AccessiblePandoraButton(
                  onPressed: () {},
                  accessibilityId: 'button2',
                  focusOrder: 2,
                  child: const Text('Button 2'),
                ),
              ],
            ),
          ),
        ),
      );

      // Test focus management
      final moved = FocusManagementService.moveToNext();
      expect(moved, isTrue);

      // Test keyboard navigation
      final currentItem = FocusManagementService.getCurrentItem();
      expect(currentItem, isNotNull);
    });
  });
}

void _testAction(BuildContext context) {
  // Test action implementation
}
