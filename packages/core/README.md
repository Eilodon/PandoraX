# 🏗️ **Core Package - Phase 4 Architecture**

## 📋 **Overview**

Core package cung cấp các chức năng cơ bản và utilities được chia sẻ trong toàn bộ ứng dụng Jarvis. Package này được thiết kế theo kiến trúc Phase 4 với sự đơn giản hóa và tách biệt rõ ràng các trách nhiệm.

---

## 🎯 **Features**

### 🎨 **Design System**
- **Design Tokens**: Colors, typography, spacing, borders, shadows
- **Theme Manager**: Light/dark theme với Material 3 support
- **Color System**: Semantic colors với accessibility support
- **Typography System**: Inter font với hierarchy rõ ràng
- **Spacing System**: 4px grid system cho consistency

### 🛠️ **Utilities**
- **Common Utils**: String, list, map, validation utilities
- **Date Utils**: Date/time manipulation và formatting
- **String Utils**: Text processing và validation
- **Validation Utils**: Email, phone, URL, UUID validation
- **File Utils**: File path và extension utilities

### 🔧 **Services**
- **Logging Service**: Centralized logging với Logger
- **Error Handling**: Error management và reporting
- **Configuration**: App configuration management
- **Storage**: Local storage utilities

### 📊 **Constants**
- **App Constants**: Application-wide constants
- **API Constants**: API endpoints và configuration
- **UI Constants**: UI-related constants
- **Security Constants**: Security và encryption settings

---

## 🚀 **Quick Start**

### **Installation**

```yaml
dependencies:
  core:
    path: ../core
```

### **Usage**

```dart
import 'package:core/core.dart';

// Design Tokens
Container(
  padding: EdgeInsets.all(DesignTokens.spacing4),
  decoration: BoxDecoration(
    color: DesignTokens.primary,
    borderRadius: BorderRadius.circular(DesignTokens.radiusBase),
  ),
)

// Theme Manager
final themeManager = ThemeManager.instance;
themeManager.toggleTheme();

// Common Utils
final id = CommonUtils.generateId();
final isValid = CommonUtils.isValidEmail('user@example.com');

// Logging
LoggingService.instance.info('App started');
```

---

## 📁 **Package Structure**

```
lib/
├── core.dart                    # Main export file
└── src/
    ├── design_system/
    │   ├── design_tokens.dart   # Design tokens
    │   └── theme_manager.dart   # Theme management
    ├── constants/
    │   └── app_constants.dart   # App constants
    ├── services/
    │   └── logging_service.dart # Logging service
    ├── utils/
    │   └── common_utils.dart    # Common utilities
    └── demos/
        └── architecture_demo.dart # Architecture demo
```

---

## 🎨 **Design System**

### **Colors**
```dart
// Primary colors
DesignTokens.primary
DesignTokens.primaryLight
DesignTokens.primaryDark

// Semantic colors
DesignTokens.success
DesignTokens.warning
DesignTokens.error
DesignTokens.info

// Neutral colors
DesignTokens.neutral50
DesignTokens.neutral100
// ... up to neutral900
```

### **Typography**
```dart
// Font families
DesignTokens.fontFamily        // Inter
DesignTokens.fontFamilyMono    // JetBrains Mono

// Font sizes
DesignTokens.fontSizeXs        // 12px
DesignTokens.fontSizeSm        // 14px
DesignTokens.fontSizeBase      // 16px
// ... up to fontSize5Xl (48px)

// Font weights
DesignTokens.fontWeightLight   // 300
DesignTokens.fontWeightRegular // 400
DesignTokens.fontWeightMedium  // 500
// ... up to fontWeightBold (700)
```

### **Spacing**
```dart
// 4px grid system
DesignTokens.spacing0          // 0px
DesignTokens.spacing1          // 4px
DesignTokens.spacing2          // 8px
DesignTokens.spacing4          // 16px
// ... up to spacing32 (128px)
```

### **Borders**
```dart
// Border radius
DesignTokens.radiusNone        // 0px
DesignTokens.radiusSm          // 4px
DesignTokens.radiusBase        // 8px
// ... up to radiusFull (9999px)

// Border widths
DesignTokens.borderWidth0      // 0px
DesignTokens.borderWidth1      // 1px
DesignTokens.borderWidth2      // 2px
DesignTokens.borderWidth4      // 4px
```

### **Shadows**
```dart
// Shadow levels
DesignTokens.shadowSm          // Small shadow
DesignTokens.shadowBase        // Base shadow
DesignTokens.shadowMd          // Medium shadow
DesignTokens.shadowLg          // Large shadow
DesignTokens.shadowXl          // Extra large shadow
```

---

## 🎭 **Theme Management**

### **Theme Manager**
```dart
final themeManager = ThemeManager.instance;

// Get current theme
final theme = themeManager.currentTheme;
final colorScheme = themeManager.currentColorScheme;

// Toggle theme
themeManager.toggleTheme();

// Set specific theme
themeManager.setThemeMode(true); // Dark mode
themeManager.setThemeMode(false); // Light mode
```

### **Theme Usage**
```dart
MaterialApp(
  theme: themeManager.lightTheme,
  darkTheme: themeManager.darkTheme,
  themeMode: themeManager.isDarkMode ? ThemeMode.dark : ThemeMode.light,
  home: MyHomePage(),
)
```

---

## 🛠️ **Utilities**

### **Common Utils**
```dart
// ID generation
final id = CommonUtils.generateId();
final shortId = CommonUtils.generateShortId();

// String utilities
final capitalized = CommonUtils.capitalize('hello world');
final truncated = CommonUtils.truncate('Long text...', 10);

// Validation
final isValidEmail = CommonUtils.isValidEmail('user@example.com');
final isValidPhone = CommonUtils.isValidPhoneNumber('+1234567890');
final isValidUrl = CommonUtils.isValidUrl('https://example.com');

// List utilities
final unique = CommonUtils.removeDuplicates([1, 2, 2, 3]);
final grouped = CommonUtils.groupBy(users, (user) => user.department);
final filtered = CommonUtils.filter(notes, (note) => note.isFavorite);

// Math utilities
final clamped = CommonUtils.clamp(15, 10, 20); // 15
final percentage = CommonUtils.calculatePercentage(25, 100); // 25.0
```

---

## 🔧 **Services**

### **Logging Service**
```dart
final logger = LoggingService.instance;

// Initialize (usually in main.dart)
logger.initialize();

// Log messages
logger.debug('Debug message');
logger.info('Info message');
logger.warning('Warning message');
logger.error('Error message', error, stackTrace);
logger.fatal('Fatal message', error, stackTrace);
```

---

## 📊 **Constants**

### **App Constants**
```dart
// App information
AppConstants.appName           // 'Jarvis Notes'
AppConstants.appVersion        // '1.0.0'
AppConstants.appDescription    // 'Smart notes app with AI integration'

// Database
AppConstants.databaseName      // 'jarvis_notes.db'
AppConstants.databaseVersion   // 1

// API
AppConstants.baseApiUrl        // 'https://api.jarvis-notes.com'
AppConstants.apiTimeoutSeconds // 30

// UI
AppConstants.defaultAnimationDurationMs // 300
AppConstants.defaultPageSize            // 20

// Validation
AppConstants.minPasswordLength // 8
AppConstants.maxPasswordLength // 128
AppConstants.minNoteTitleLength // 1
AppConstants.maxNoteTitleLength // 200

// Files
AppConstants.maxFileSizeBytes    // 10MB
AppConstants.allowedImageFormats // ['jpg', 'jpeg', 'png', ...]
```

---

## 🎯 **Best Practices**

### **Design Tokens**
- ✅ Sử dụng design tokens thay vì hardcode values
- ✅ Sử dụng semantic naming (primary, secondary, success, etc.)
- ✅ Sử dụng spacing system cho consistency
- ✅ Sử dụng typography hierarchy

### **Theme Management**
- ✅ Sử dụng ThemeManager.instance thay vì tạo instance mới
- ✅ Sử dụng currentTheme và currentColorScheme
- ✅ Toggle theme thông qua ThemeManager
- ✅ Sử dụng Material 3 components

### **Utilities**
- ✅ Sử dụng CommonUtils cho common operations
- ✅ Validate input trước khi xử lý
- ✅ Sử dụng type-safe methods
- ✅ Handle null values properly

### **Logging**
- ✅ Initialize LoggingService trong main.dart
- ✅ Sử dụng appropriate log levels
- ✅ Include error và stack trace khi cần
- ✅ Log important user actions

---

## 🧪 **Testing**

### **Unit Tests**
```dart
// Test design tokens
test('Design tokens should have valid values', () {
  expect(DesignTokens.primary, isA<Color>());
  expect(DesignTokens.fontSizeBase, equals(16.0));
  expect(DesignTokens.spacing4, equals(16.0));
});

// Test common utils
test('CommonUtils should generate valid IDs', () {
  final id = CommonUtils.generateId();
  expect(id, isNotEmpty);
  expect(CommonUtils.isValidUuid(id), isTrue);
});

// Test theme manager
test('ThemeManager should toggle theme', () {
  final themeManager = ThemeManager.instance;
  final initialMode = themeManager.isDarkMode;
  themeManager.toggleTheme();
  expect(themeManager.isDarkMode, equals(!initialMode));
});
```

---

## 📈 **Performance**

### **Optimization Tips**
- ✅ Sử dụng const constructors khi có thể
- ✅ Cache expensive calculations
- ✅ Sử dụng lazy loading cho heavy operations
- ✅ Minimize rebuilds với proper state management

### **Memory Management**
- ✅ Dispose resources properly
- ✅ Sử dụng weak references khi cần
- ✅ Avoid memory leaks với proper cleanup
- ✅ Monitor memory usage trong development

---

## 🔄 **Migration Guide**

### **From Phase 3 to Phase 4**
1. **Update imports**: Thay đổi imports để sử dụng Core package
2. **Replace hardcoded values**: Sử dụng Design Tokens
3. **Update theme usage**: Sử dụng ThemeManager
4. **Replace utilities**: Sử dụng CommonUtils
5. **Update logging**: Sử dụng LoggingService

### **Breaking Changes**
- ❌ Không có breaking changes trong Phase 4
- ✅ Backward compatible với Phase 3
- ✅ Gradual migration được hỗ trợ

---

## 🤝 **Contributing**

### **Guidelines**
1. **Follow naming conventions**: camelCase cho methods, PascalCase cho classes
2. **Add documentation**: Document tất cả public APIs
3. **Write tests**: Unit tests cho tất cả utilities
4. **Update examples**: Update usage examples khi thay đổi APIs

### **Code Style**
- ✅ Sử dụng Dart formatter
- ✅ Follow Flutter conventions
- ✅ Use meaningful variable names
- ✅ Add comments cho complex logic

---

## 📚 **Resources**

### **Documentation**
- [Flutter Documentation](https://flutter.dev/docs)
- [Material Design 3](https://m3.material.io/)
- [Riverpod Documentation](https://riverpod.dev/)
- [GetIt Documentation](https://pub.dev/packages/get_it)

### **Design Resources**
- [Material Design Tokens](https://m3.material.io/foundations/design-tokens)
- [Inter Font](https://rsms.me/inter/)
- [Color Accessibility](https://webaim.org/resources/contrastchecker/)

---

## 🎉 **Conclusion**

Core package cung cấp nền tảng vững chắc cho Phase 4 Architecture với:

- 🎨 **Comprehensive Design System**: Tokens, themes, components
- 🛠️ **Rich Utilities**: Validation, manipulation, formatting
- 🔧 **Essential Services**: Logging, configuration, storage
- 📊 **Complete Constants**: App-wide configuration values

Package này giúp đảm bảo consistency, maintainability và scalability cho toàn bộ ứng dụng Jarvis.

---

**Core Package Status: ✅ READY FOR PRODUCTION**
**Phase 4 Architecture: ✅ COMPLETED**
