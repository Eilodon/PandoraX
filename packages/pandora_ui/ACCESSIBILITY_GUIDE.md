# 🎯 **Pandora UI Accessibility Guide**

## 📖 **Overview**

Pandora UI provides comprehensive accessibility support following WCAG 2.1 AA standards, ensuring that all users can effectively use the application regardless of their abilities.

## 🎯 **Key Features**

### ✅ **Screen Reader Support**
- Semantic labels for all components
- Accessibility hints and values
- Contextual announcements
- Screen reader navigation

### ⌨️ **Keyboard Navigation**
- Full keyboard support
- Focus management
- Keyboard shortcuts
- Tab order management

### 🎨 **Visual Accessibility**
- Color contrast validation
- High contrast mode support
- Scalable text and icons
- Focus indicators

### 🔊 **Audio Feedback**
- Haptic feedback
- Audio announcements
- Sound cues for interactions

## 🚀 **Quick Start**

### 1. **Basic Button with Accessibility**

```dart
AccessiblePandoraButton(
  onPressed: () {
    // Button action
  },
  accessibilityId: 'save-button',
  focusOrder: 1,
  accessibilityLabel: 'Save document',
  accessibilityHint: 'Saves the current document',
  child: const Text('Save'),
)
```

### 2. **Form Field with Accessibility**

```dart
TextField(
  decoration: const InputDecoration(
    labelText: 'Email Address',
    hintText: 'Enter your email address',
  ),
  onChanged: (value) {
    AccessibilityService.announceChange('Email field updated');
  },
)
```

### 3. **Focus Management**

```dart
// Register focusable items
FocusManagementService.registerFocusable(
  id: 'button1',
  focusNode: focusNode,
  order: 1,
  group: 'main-navigation',
);

// Navigate programmatically
FocusManagementService.moveToNext();
FocusManagementService.moveToPrevious();
```

## 🎨 **Color Contrast**

### **Automatic Contrast Validation**

```dart
// Check if colors meet accessibility standards
final isAccessible = AccessibilityColors.isAccessibleContrast(
  foregroundColor,
  backgroundColor,
);

// Get accessible color automatically
final accessibleColor = AccessibilityColors.getAccessibleColor(
  desiredColor,
  backgroundColor,
);
```

### **High Contrast Mode**

```dart
// Check if high contrast is enabled
final isHighContrast = AccessibilityColors.shouldUseHighContrast(context);

// Use adaptive colors
final color = AccessibilityColors.getAdaptiveColor(
  context,
  normalColor,
  highContrastColor,
);
```

## ⌨️ **Keyboard Navigation**

### **Keyboard Shortcuts**

```dart
// Register custom shortcuts
KeyboardNavigationService.registerShortcut(
  const KeyboardShortcut(
    id: 'save',
    keySet: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyS),
    action: _saveAction,
    description: 'Save document',
  ),
);

// Use common shortcuts
for (final shortcut in CommonKeyboardShortcuts.shortcuts) {
  KeyboardNavigationService.registerShortcut(shortcut);
}
```

### **Focus Management**

```dart
// Create focusable widget
Widget createFocusableWidget() {
  return FocusManagementService.createFocusable(
    id: 'my-widget',
    child: MyWidget(),
    order: 1,
    group: 'main-content',
    onActivate: () {
      // Handle activation
    },
  );
}
```

## 🔊 **Screen Reader Support**

### **Semantic Labels**

```dart
// Automatic semantic labels
final label = AccessibilityService.getSemanticLabel('button', {
  'text': 'Save',
  'state': 'enabled',
});
// Returns: "Save button, enabled state"

// Custom accessibility properties
Semantics(
  label: 'Save document',
  hint: 'Double tap to save',
  value: 'Ready to save',
  button: true,
  child: MyButton(),
)
```

### **Announcements**

```dart
// Announce changes to screen readers
AccessibilityService.announceChange('Document saved successfully');
AccessibilityService.announceError('Failed to save document');
AccessibilityService.announceCompletion('Upload completed');
```

## 📱 **Mobile Accessibility**

### **Touch Targets**

```dart
// Minimum touch target size (44x44 points)
AccessiblePandoraButton(
  size: PandoraButtonSize.sm, // Automatically enforces minimum size
  child: const Text('Tap me'),
)
```

### **Haptic Feedback**

```dart
// Automatic haptic feedback on interaction
AccessiblePandoraButton(
  onPressed: () {
    // Haptic feedback is automatically provided
  },
  child: const Text('Button'),
)
```

## 🧪 **Testing Accessibility**

### **Automated Testing**

```dart
// Test accessibility properties
testWidgets('button has correct accessibility', (WidgetTester tester) async {
  await tester.pumpWidget(
    AccessiblePandoraButton(
      onPressed: () {},
      child: const Text('Test'),
    ),
  );

  // Verify accessibility properties
  final semantics = tester.getSemantics(find.byType(AccessiblePandoraButton));
  expect(semantics.label, contains('Test'));
  expect(semantics.hasFlag(SemanticsFlag.isButton), isTrue);
});
```

### **Manual Testing**

1. **Screen Reader Testing**
   - Enable TalkBack (Android) or VoiceOver (iOS)
   - Navigate through the app using gestures
   - Verify all content is announced correctly

2. **Keyboard Testing**
   - Use only keyboard navigation
   - Test Tab order and focus management
   - Verify all interactive elements are reachable

3. **Visual Testing**
   - Test with high contrast mode
   - Verify color contrast ratios
   - Test with different text scale factors

## 📊 **Accessibility Checklist**

### ✅ **Screen Reader Support**
- [ ] All interactive elements have semantic labels
- [ ] Form fields have proper labels and hints
- [ ] Status changes are announced
- [ ] Navigation is clear and logical

### ✅ **Keyboard Navigation**
- [ ] All interactive elements are keyboard accessible
- [ ] Tab order is logical and intuitive
- [ ] Focus indicators are visible
- [ ] Keyboard shortcuts are available

### ✅ **Visual Accessibility**
- [ ] Color contrast meets WCAG AA standards
- [ ] Text is scalable up to 200%
- [ ] Focus indicators are clearly visible
- [ ] High contrast mode is supported

### ✅ **Mobile Accessibility**
- [ ] Touch targets are at least 44x44 points
- [ ] Haptic feedback is provided
- [ ] Gestures are intuitive
- [ ] Orientation changes are handled

## 🎯 **Best Practices**

### **1. Semantic HTML**
- Use appropriate semantic elements
- Provide meaningful labels
- Include helpful hints and descriptions

### **2. Keyboard Navigation**
- Ensure logical tab order
- Provide keyboard shortcuts
- Handle focus management properly

### **3. Visual Design**
- Maintain sufficient color contrast
- Use clear focus indicators
- Support high contrast mode

### **4. Testing**
- Test with real assistive technologies
- Include accessibility in automated tests
- Regular accessibility audits

## 🔧 **Troubleshooting**

### **Common Issues**

1. **Screen reader not announcing changes**
   - Use `AccessibilityService.announceChange()`
   - Ensure proper semantic labels

2. **Keyboard navigation not working**
   - Check focus management setup
   - Verify tab order configuration

3. **Color contrast issues**
   - Use `AccessibilityColors.getAccessibleColor()`
   - Test with contrast checker tools

4. **Touch targets too small**
   - Use `AccessiblePandoraButton` with proper sizing
   - Ensure minimum 44x44 point targets

## 📚 **Resources**

- [WCAG 2.1 Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)
- [Flutter Accessibility](https://docs.flutter.dev/development/accessibility-and-localization/accessibility)
- [Material Design Accessibility](https://material.io/design/usability/accessibility.html)
- [iOS Accessibility](https://developer.apple.com/accessibility/)
- [Android Accessibility](https://developer.android.com/guide/topics/ui/accessibility)

## 🤝 **Contributing**

When contributing to accessibility features:

1. Follow WCAG 2.1 AA guidelines
2. Test with assistive technologies
3. Include accessibility tests
4. Update documentation
5. Consider diverse user needs

---

**Remember: Accessibility is not a feature, it's a fundamental requirement for inclusive design.**
