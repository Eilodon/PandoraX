# Testing Guide

## Tổng quan

Dự án Notes App sử dụng kiến trúc monorepo với Melos và có hệ thống testing toàn diện bao gồm:

- **Unit Tests**: Test các class, function riêng lẻ
- **Widget Tests**: Test UI components
- **Integration Tests**: Test toàn bộ luồng người dùng
- **CI/CD**: GitHub Actions tự động chạy tests

## Cấu trúc Testing

```
packages/
├── alarm_data/
│   └── test/
│       └── note_repository_impl_test.dart
├── alarm_domain/
│   └── test/
│       └── (domain tests)
└── notes_app/
    ├── test/
    │   ├── features/
    │   │   ├── ai/
    │   │   │   ├── application/
    │   │   │   │   ├── ai_service_test.dart
    │   │   │   │   └── ai_chat/
    │   │   │   │       └── ai_chat_notifier_test.dart
    │   │   │   └── presentation/
    │   │   │       └── ai_chat_screen_test.dart
    │   │   └── notes/
    │   │       └── presentation/
    │   │           └── notes_page_test.dart
    │   └── widget_test.dart
    └── integration_test/
        └── app_test.dart
```

## Chạy Tests

### 1. Chạy tất cả tests
```bash
# Sử dụng Melos (khuyến nghị)
melos run test

# Hoặc chạy riêng lẻ
cd packages/notes_app
flutter test
```

### 2. Chạy tests với coverage
```bash
melos run test:coverage
```

### 3. Chạy integration tests
```bash
melos run integration:test
```

### 4. Chạy tests cho package cụ thể
```bash
cd packages/notes_app
flutter test

cd packages/alarm_data
flutter test
```

## Các loại Tests

### Unit Tests

#### Repository Tests
- **File**: `packages/alarm_data/test/note_repository_impl_test.dart`
- **Mục đích**: Test logic repository với mock Isar và Firestore
- **Coverage**: CRUD operations, sync logic, error handling

#### Service Tests
- **File**: `packages/notes_app/test/features/ai/application/ai_service_test.dart`
- **Mục đích**: Test AI service với mock Gemini API
- **Coverage**: API calls, error handling, input validation

#### StateNotifier Tests
- **File**: `packages/notes_app/test/features/ai/application/ai_chat/ai_chat_notifier_test.dart`
- **Mục đích**: Test state management logic
- **Coverage**: State transitions, business logic, error states

### Widget Tests

#### Screen Tests
- **File**: `packages/notes_app/test/features/notes/presentation/notes_page_test.dart`
- **Mục đích**: Test UI components và user interactions
- **Coverage**: Widget rendering, user input, navigation

#### AI Chat Screen Tests
- **File**: `packages/notes_app/test/features/ai/presentation/ai_chat_screen_test.dart`
- **Mục đích**: Test chat interface và AI interactions
- **Coverage**: Message display, loading states, error handling

### Integration Tests

#### End-to-End Tests
- **File**: `packages/notes_app/integration_test/app_test.dart`
- **Mục đích**: Test toàn bộ luồng người dùng
- **Coverage**: Navigation, feature interactions, app state

## Mock và Test Utilities

### Mock Classes
```dart
// Mock Isar
class MockIsar extends Mock implements Isar {}

// Mock Firestore
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

// Mock AI Service
class MockAiService extends Mock implements AiService {}
```

### Test Helpers
```dart
// Tạo test widget với providers
Widget createTestWidget() {
  return ProviderScope(
    overrides: [
      noteWatcherProvider.overrideWith((ref) => mockNotifier),
    ],
    child: const MaterialApp(
      home: NotesPage(),
    ),
  );
}
```

## CI/CD Pipeline

### GitHub Actions Workflow
- **File**: `.github/workflows/flutter.yml`
- **Triggers**: Push, Pull Request
- **Jobs**:
  - `test`: Chạy unit tests và widget tests
  - `build`: Build cho tất cả platforms
  - `security`: Security audit
  - `coverage`: Test coverage reporting
  - `release`: Tự động release

### Pre-commit Hooks
- **File**: `.pre-commit-config.yaml`
- **Hooks**:
  - Code formatting
  - Linting
  - Melos bootstrap
  - Analysis

## Best Practices

### 1. Test Naming
```dart
test('should return success when valid data is provided', () {
  // Test implementation
});

testWidgets('should display error message when API fails', (tester) async {
  // Widget test implementation
});
```

### 2. Arrange-Act-Assert Pattern
```dart
test('should save note to Isar', () async {
  // Arrange
  final note = Note(/*...*/);
  when(() => mockIsarCollection.putById(any())).thenAnswer((_) async => 1);
  
  // Act
  await repository.saveNote(note);
  
  // Assert
  verify(() => mockIsarCollection.putById(any())).called(1);
});
```

### 3. Mock Setup
```dart
setUp(() {
  mockService = MockService();
  when(() => mockService.method()).thenReturn(value);
});
```

### 4. Widget Test Helpers
```dart
Future<void> pumpAndSettle(WidgetTester tester) async {
  await tester.pump();
  await tester.pumpAndSettle();
}
```

## Coverage Goals

- **Unit Tests**: > 80%
- **Widget Tests**: > 70%
- **Integration Tests**: Critical user flows

## Debugging Tests

### 1. Chạy test cụ thể
```bash
flutter test test/features/ai/application/ai_service_test.dart
```

### 2. Debug mode
```bash
flutter test --debug
```

### 3. Verbose output
```bash
flutter test --verbose
```

### 4. Coverage report
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

## Troubleshooting

### Common Issues

1. **Mock not working**
   - Đảm bảo đã register fallback values
   - Kiểm tra mock setup trong setUp()

2. **Widget test fails**
   - Đảm bảo đã pump widget
   - Kiểm tra provider overrides

3. **Integration test timeout**
   - Tăng timeout duration
   - Kiểm tra async operations

### Debug Commands
```bash
# Clean và rebuild
melos run clean
melos bootstrap

# Chạy analysis
melos run analyze

# Format code
melos run format
```

## Contributing

Khi thêm tính năng mới:

1. Viết unit tests cho business logic
2. Viết widget tests cho UI components
3. Viết integration tests cho user flows
4. Đảm bảo coverage > 80%
5. Chạy `melos run test` trước khi commit

## Resources

- [Flutter Testing Guide](https://docs.flutter.dev/testing)
- [Mocktail Documentation](https://pub.dev/packages/mocktail)
- [Melos Documentation](https://melos.invertase.dev/)
- [GitHub Actions](https://docs.github.com/en/actions)
