# 🎨 PandoraX - Advanced Notes App

[![CI/CD](https://github.com/Eilodon/PandoraX/workflows/CI%2FCD%20Pipeline/badge.svg)](https://github.com/Eilodon/PandoraX/actions)
[![Code Coverage](https://codecov.io/gh/Eilodon/PandoraX/branch/main/graph/badge.svg)](https://codecov.io/gh/Eilodon/PandoraX)
[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Flutter](https://img.shields.io/badge/Flutter-3.24.0-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.5.0-blue.svg)](https://dart.dev)

## 🌟 About

PandoraX is a modern, beautiful notes application that embodies the philosophy of "Thân Tâm Hợp Nhất" (Body and Mind as One). Built with Flutter and featuring a comprehensive design system, PandoraX provides a seamless and intuitive note-taking experience with advanced AI integration, voice recognition, and cross-platform support.

## ✨ Features

- **🎨 Beautiful UI**: Powered by Pandora 4 UI Design System
- **📝 Note Management**: Create, edit, and organize your notes
- **🤖 AI Integration**: Smart features powered by Google Generative AI
- **🎤 Speech Recognition**: Voice-to-text capabilities with Vietnamese support
- **☁️ Cloud Sync**: Real-time synchronization with Firestore
- **📱 Offline Support**: Works seamlessly offline
- **🌐 Cross-Platform**: Available on Android, iOS, Web, Windows, macOS, and Linux
- **🔒 Data Encryption**: Secure encryption for sensitive data
- **📊 Performance Monitoring**: Built-in analytics and performance tracking
- **🛡️ Error Handling**: Comprehensive error management and user-friendly messages
- **🧪 Testing**: 80%+ test coverage with unit, widget, and integration tests
- **🚀 CI/CD**: Automated testing and deployment pipeline

## 🏗️ Architecture

This project follows a clean architecture pattern with:

- **Domain Layer**: Business logic and entities
- **Data Layer**: Data sources and repositories
- **Presentation Layer**: UI components and state management
- **Design System**: Pandora 4 UI components and theming

## 📦 Packages

- `pandora`: Main application
- `pandora_ui`: UI design system
- `note_domain`: Domain layer for notes
- `note_data`: Data layer implementation

## 🚀 Getting Started

### Prerequisites

- Flutter 3.24.0 or higher
- Dart 3.5.0 or higher
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Eilodon/PandoraX.git
   cd PandoraX
   ```

2. **Install dependencies**
   ```bash
   # Install Melos (if not already installed)
   dart pub global activate melos
   
   # Bootstrap the workspace
   melos bootstrap
   ```

3. **Configure environment**
   ```bash
   # Copy environment template
   cp packages/pandora/.env.example packages/pandora/.env
   
   # Add your Gemini API key to .env
   echo "GEMINI_API_KEY=your_api_key_here" >> packages/pandora/.env
   ```

4. **Run the application**
   ```bash
   # Run on your preferred platform
   melos run build:android
   melos run build:ios
   melos run build:web
   melos run build:windows
   melos run build:macos
   melos run build:linux
   ```

## 🛠️ Development

### Available Scripts

```bash
# Install dependencies
melos run get

# Run tests
melos run test

# Run tests with coverage
melos run test:coverage

# Analyze code
melos run analyze

# Format code
melos run format

# Lint code
melos run lint

# Run build_runner
melos run build_runner

# Clean workspace
melos run clean

# Security audit
melos run security
```

### Code Generation

The project uses several code generation tools:

- **Freezed**: For immutable data classes
- **Json Serializable**: For JSON serialization
- **Injectable**: For dependency injection
- **Isar Generator**: For database models

Run code generation:
```bash
melos run build_runner
```

## 🧪 Testing

The project has comprehensive testing coverage:

- **Unit Tests**: Test individual functions and classes
- **Widget Tests**: Test UI components
- **Integration Tests**: Test complete user flows

Run tests:
```bash
# Run all tests
melos run test

# Run tests with coverage
melos run test:coverage

# Run specific package tests
cd packages/pandora && flutter test
```

## 📊 Performance Monitoring

PandoraX includes built-in performance monitoring:

- **Analytics Service**: Tracks user behavior and app usage
- **Performance Service**: Monitors app performance metrics
- **Error Service**: Centralized error handling and reporting

## 🔒 Security

- **Data Encryption**: Sensitive data is encrypted using AES encryption
- **Secure Storage**: Local data is stored securely
- **API Security**: All API calls are secured and validated
- **Permission Management**: Proper permission handling for device features

## 🌐 Internationalization

The app supports multiple languages:
- English (en)
- Vietnamese (vi)

## 📱 Platform Support

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Google for the Gemini AI API
- The open-source community for various packages
- All contributors who helped make this project possible

## 📞 Support

If you have any questions or need help, please:

1. Check the [Issues](https://github.com/Eilodon/PandoraX/issues) page
2. Create a new issue if your problem isn't already reported
3. Join our [Discussions](https://github.com/Eilodon/PandoraX/discussions) for general questions

## 🎯 Roadmap

- [ ] Advanced AI features
- [ ] Collaborative editing
- [ ] Plugin system
- [ ] Advanced theming
- [ ] Mobile app stores release

---

Made with ❤️ by [Eilodon](https://github.com/Eilodon)