# Pandora 4 UI Design System

> **"Thân Tâm Hợp Nhất"** - A comprehensive Flutter UI component library that embodies the philosophy of "Body and Mind as One" - where design tokens, components, and theming work in perfect harmony.

## 🎨 Philosophy

Pandora 4 UI follows the ancient wisdom of "Thân Tâm Hợp Nhất" (Body and Mind as One), creating a design system where:

- **Thân (Body)**: Design tokens form the physical foundation
- **Tâm (Mind)**: Typography and intellectual elements guide the user experience
- **Hợp (Harmony)**: Spacing and rhythm create visual balance
- **Nhất (Unity)**: Components work together as a cohesive whole

## 🚀 Features

- **Comprehensive Design Tokens**: Colors, typography, spacing, borders, and shadows
- **Reusable Components**: Buttons, cards, text fields, containers, and more
- **Theme System**: Light and dark themes with Material 3 support
- **Accessibility First**: Built with accessibility in mind
- **Performance Optimized**: Efficient widgets with smooth animations
- **Responsive Design**: Adapts to different screen sizes
- **Type Safe**: Full TypeScript-like type safety with Dart

## 📦 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  pandora_ui:
    path: ../pandora_ui
```

Then run:

```bash
flutter pub get
```

## 🎯 Quick Start

### 1. Import the Package

```dart
import 'package:pandora_ui/pandora_ui.dart';
```

### 2. Apply the Theme

```dart
MaterialApp(
  title: 'My App',
  theme: PandoraTheme.light(),
  darkTheme: PandoraTheme.dark(),
  themeMode: ThemeMode.system,
  home: MyHomePage(),
)
```

### 3. Use Components

```dart
// Button
PandoraButton(
  onPressed: () => print('Button pressed'),
  child: Text('Click me'),
)

// Card
PandoraCard(
  onTap: () => print('Card tapped'),
  child: Text('Card content'),
)

// Text Field
PandoraTextField(
  label: 'Email',
  hint: 'Enter your email',
  prefixIcon: Icon(Icons.email),
)

// Container
PandoraContainer(
  variant: PandoraContainerVariant.elevated,
  child: Text('Container content'),
)

// Snackbar
PandoraSnackbar.show(
  context,
  message: 'Hello from Pandora!',
  variant: PandoraSnackbarVariant.success,
)
```

## 🎨 Design Tokens

### Colors

```dart
// Primary colors
PandoraColors.primary500
PandoraColors.primary600
PandoraColors.primary700

// Semantic colors
PandoraColors.success500
PandoraColors.warning500
PandoraColors.error500
PandoraColors.info500

// Neutral colors
PandoraColors.neutral100
PandoraColors.neutral500
PandoraColors.neutral900
```

### Typography

```dart
// Display styles
PandoraTypography.displayLarge
PandoraTypography.displayMedium
PandoraTypography.displaySmall

// Headline styles
PandoraTypography.headlineLarge
PandoraTypography.headlineMedium
PandoraTypography.headlineSmall

// Body styles
PandoraTypography.bodyLarge
PandoraTypography.bodyMedium
PandoraTypography.bodySmall
```

### Spacing

```dart
// Spacing scale
PandoraSpacing.space4    // 4px
PandoraSpacing.space8    // 8px
PandoraSpacing.space16   // 16px
PandoraSpacing.space24   // 24px
PandoraSpacing.space32   // 32px

// Semantic spacing
PandoraSpacing.spacingXs
PandoraSpacing.spacingSm
PandoraSpacing.spacingMd
PandoraSpacing.spacingLg
PandoraSpacing.spacingXl
```

## 🧩 Components

### Buttons

```dart
// Variants
PandoraButton(
  variant: PandoraButtonVariant.primary,
  child: Text('Primary'),
)

PandoraButton(
  variant: PandoraButtonVariant.secondary,
  child: Text('Secondary'),
)

PandoraButton(
  variant: PandoraButtonVariant.ghost,
  child: Text('Ghost'),
)

// Sizes
PandoraButton(
  size: PandoraButtonSize.sm,
  child: Text('Small'),
)

PandoraButton(
  size: PandoraButtonSize.lg,
  child: Text('Large'),
)

// States
PandoraButton(
  state: PandoraButtonState.loading,
  child: Text('Loading'),
)

PandoraButton(
  state: PandoraButtonState.success,
  child: Text('Success'),
)

// With icons
PandoraButton(
  icon: Icon(Icons.add),
  child: Text('Add'),
)

PandoraButton(
  icon: Icon(Icons.save),
  iconPosition: IconPosition.end,
  child: Text('Save'),
)
```

### Cards

```dart
// Variants
PandoraCard(
  variant: PandoraCardVariant.elevated,
  child: Text('Elevated Card'),
)

PandoraCard(
  variant: PandoraCardVariant.outlined,
  child: Text('Outlined Card'),
)

PandoraCard(
  variant: PandoraCardVariant.filled,
  child: Text('Filled Card'),
)

// Sizes
PandoraCard(
  size: PandoraCardSize.sm,
  child: Text('Small Card'),
)

PandoraCard(
  size: PandoraCardSize.lg,
  child: Text('Large Card'),
)

// Interactive
PandoraCard(
  onTap: () => print('Card tapped'),
  child: Text('Tappable Card'),
)
```

### Text Fields

```dart
// Variants
PandoraTextField(
  variant: PandoraTextFieldVariant.outlined,
  label: 'Outlined Field',
)

PandoraTextField(
  variant: PandoraTextFieldVariant.filled,
  label: 'Filled Field',
)

PandoraTextField(
  variant: PandoraTextFieldVariant.underlined,
  label: 'Underlined Field',
)

// Sizes
PandoraTextField(
  size: PandoraTextFieldSize.sm,
  label: 'Small Field',
)

PandoraTextField(
  size: PandoraTextFieldSize.lg,
  label: 'Large Field',
)

// States
PandoraTextField(
  state: PandoraTextFieldState.error,
  label: 'Error Field',
  errorText: 'This field is required',
)

PandoraTextField(
  state: PandoraTextFieldState.success,
  label: 'Success Field',
)

// With icons
PandoraTextField(
  label: 'Email',
  prefixIcon: Icon(Icons.email),
)

PandoraTextField(
  label: 'Password',
  prefixIcon: Icon(Icons.lock),
  suffixIcon: Icon(Icons.visibility),
  obscureText: true,
)
```

### Containers

```dart
// Variants
PandoraContainer(
  variant: PandoraContainerVariant.elevated,
  child: Text('Elevated Container'),
)

PandoraContainer(
  variant: PandoraContainerVariant.outlined,
  child: Text('Outlined Container'),
)

PandoraContainer(
  variant: PandoraContainerVariant.filled,
  child: Text('Filled Container'),
)

// Sizes
PandoraContainer(
  size: PandoraContainerSize.sm,
  child: Text('Small Container'),
)

PandoraContainer(
  size: PandoraContainerSize.lg,
  child: Text('Large Container'),
)

// With gradient
PandoraContainer(
  gradient: LinearGradient(
    colors: [PandoraColors.primary500, PandoraColors.secondary500],
  ),
  child: Text('Gradient Container'),
)
```

### Snackbars

```dart
// Variants
PandoraSnackbar.show(
  context,
  message: 'Info message',
  variant: PandoraSnackbarVariant.info,
)

PandoraSnackbar.show(
  context,
  message: 'Success message',
  variant: PandoraSnackbarVariant.success,
)

PandoraSnackbar.show(
  context,
  message: 'Warning message',
  variant: PandoraSnackbarVariant.warning,
)

PandoraSnackbar.show(
  context,
  message: 'Error message',
  variant: PandoraSnackbarVariant.error,
)

// With action
PandoraSnackbar.show(
  context,
  message: 'Message with action',
  actionLabel: 'Undo',
  onAction: () => print('Action pressed'),
)

// With close icon
PandoraSnackbar.show(
  context,
  message: 'Message with close',
  showCloseIcon: true,
)
```

## 🎨 Theming

### Light Theme

```dart
MaterialApp(
  theme: PandoraTheme.light(),
  home: MyApp(),
)
```

### Dark Theme

```dart
MaterialApp(
  darkTheme: PandoraTheme.dark(),
  home: MyApp(),
)
```

### System Theme

```dart
MaterialApp(
  theme: PandoraTheme.light(),
  darkTheme: PandoraTheme.dark(),
  themeMode: ThemeMode.system,
  home: MyApp(),
)
```

## 🔧 Customization

### Custom Colors

```dart
PandoraButton(
  backgroundColor: Colors.purple,
  foregroundColor: Colors.white,
  child: Text('Custom Button'),
)
```

### Custom Spacing

```dart
PandoraContainer(
  padding: EdgeInsets.all(24),
  margin: EdgeInsets.symmetric(horizontal: 16),
  child: Text('Custom Spacing'),
)
```

### Custom Border Radius

```dart
PandoraCard(
  borderRadius: BorderRadius.circular(20),
  child: Text('Rounded Card'),
)
```

## 📱 Responsive Design

```dart
// Responsive spacing
double responsiveSpacing = PandoraSpacing.getResponsiveSpacing(
  MediaQuery.of(context).size.width,
  16.0,
);

// Responsive components
Widget responsiveButton = PandoraHelpers.responsive(
  screenWidth: MediaQuery.of(context).size.width,
  mobile: PandoraButton(
    size: PandoraButtonSize.sm,
    child: Text('Mobile'),
  ),
  tablet: PandoraButton(
    size: PandoraButtonSize.md,
    child: Text('Tablet'),
  ),
  desktop: PandoraButton(
    size: PandoraButtonSize.lg,
    child: Text('Desktop'),
  ),
);
```

## 🎯 Best Practices

1. **Use Semantic Colors**: Prefer semantic color names over hardcoded values
2. **Consistent Spacing**: Use the spacing scale for consistent layouts
3. **Accessibility**: Always provide semantic labels and tooltips
4. **Responsive Design**: Test on different screen sizes
5. **Theme Consistency**: Use the theme system for consistent styling
6. **Performance**: Use const constructors where possible
7. **Type Safety**: Leverage the type system for better code quality

## 🐛 Troubleshooting

### Common Issues

1. **Theme not applied**: Make sure to wrap your app with `MaterialApp` and set the theme
2. **Colors not showing**: Check if you're using the correct color tokens
3. **Spacing issues**: Use the spacing scale instead of hardcoded values
4. **Component not rendering**: Check if all required parameters are provided

### Debug Mode

Enable debug mode to see helpful information:

```dart
MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: PandoraTheme.light(),
  home: MyApp(),
)
```

## 📚 Examples

Check out the demo screen in the main app to see all components in action:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => PandoraDemoScreen(),
  ),
);
```

## 🤝 Contributing

We welcome contributions! Please see our contributing guidelines for more information.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Material Design team for the design principles
- The community for feedback and contributions

---

**"Thân Tâm Hợp Nhất"** - May your UI be as harmonious as the balance between body and mind.