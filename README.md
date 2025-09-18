# 🎨 PandoraX - Advanced AI-Powered Notes App

[![CI/CD](https://github.com/Eilodon/PandoraX/workflows/CI/CD%20Pipeline/badge.svg)](https://github.com/Eilodon/PandoraX/actions)
[![Code Coverage](https://codecov.io/gh/Eilodon/PandoraX/branch/main/graph/badge.svg)](https://codecov.io/gh/Eilodon/PandoraX)
[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-3.24.0-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.5.0-blue.svg)](https://dart.dev)

## 🌟 About

PandoraX is a modern, beautiful notes application that embodies the philosophy of "Thân Tâm Hợp Nhất" (Body and Mind as One). Built with Flutter and featuring a comprehensive design system, PandoraX provides a seamless and intuitive note-taking experience with advanced AI integration, voice recognition, cloud synchronization, and cross-platform support.

## ✨ Features

### 🎨 **Beautiful UI & UX**
- **Pandora Design System**: Comprehensive design tokens and components
- **Material Design 3**: Modern, adaptive UI following Material Design principles
- **Dark/Light Theme**: Seamless theme switching with system preference support
- **Responsive Design**: Optimized for all screen sizes and orientations
- **Smooth Animations**: Lottie animations and micro-interactions

### 📝 **Advanced Note Management**
- **Rich Text Editing**: Full-featured text editor with formatting options
- **Smart Organization**: Categories, tags, and priority-based organization
- **Search & Filter**: Powerful search with filters by category, tags, and date
- **Pin & Archive**: Pin important notes and archive completed ones
- **Templates**: Pre-built note templates for common use cases

### 🤖 **AI-Powered Features**
- **Google Generative AI**: Powered by Gemini Pro for intelligent assistance
- **Smart Summarization**: Automatically summarize long notes
- **Content Generation**: AI-assisted content creation and suggestions
- **Smart Categorization**: Automatic categorization of notes
- **Intelligent Search**: AI-enhanced search with semantic understanding

### 🎤 **Voice Features**
- **Speech-to-Text**: Convert voice to text with Vietnamese support
- **Text-to-Speech**: Read notes aloud with natural voice
- **Voice Commands**: Control the app using voice commands
- **Multi-language Support**: Support for multiple languages

### ☁️ **Cloud Synchronization**
- **Firebase Integration**: Real-time synchronization with Firestore
- **Offline Support**: Full functionality without internet connection
- **Conflict Resolution**: Smart conflict resolution for simultaneous edits
- **Cross-Device Sync**: Access your notes from any device

### 🔒 **Security & Privacy**
- **End-to-End Encryption**: AES-256 encryption for sensitive data
- **Biometric Authentication**: Fingerprint and face recognition support
- **Secure Storage**: Encrypted local storage for sensitive information
- **Privacy First**: No data collection without explicit consent

### 📊 **Analytics & Performance**
- **Performance Monitoring**: Real-time performance metrics
- **Usage Analytics**: Understand your note-taking patterns
- **Error Tracking**: Comprehensive error reporting and crash analytics
- **Optimization**: Continuous performance optimization

## 🏗️ Architecture

This project follows Clean Architecture principles with a clear separation of concerns:

```
packages/
├── foundation/           # Core utilities and shared components
│   ├── common_entities/  # Shared data models and entities
│   ├── core_utils/       # Core services and utilities
│   └── design_tokens/    # Design system tokens
├── domain/              # Business logic layer
│   ├── ai_domain/       # AI-related business logic
│   └── note_domain/     # Note-related business logic
├── data/                # Data layer
│   ├── ai_data/         # AI data sources and repositories
│   └── note_data/       # Note data sources and repositories
└── presentation/        # UI layer
    ├── pandora_app/     # Main application
    ├── pandora_ui/      # UI component library
    └── shared_widgets/  # Shared UI components
```

## 📦 Packages

- **`pandora_app`**: Main Flutter application
- **`pandora_ui`**: UI design system and components
- **`common_entities`**: Shared data models and entities
- **`core_utils`**: Core services and utilities
- **`design_tokens`**: Design system tokens (colors, typography, spacing)
- **`ai_domain`**: AI business logic and use cases
- **`ai_data`**: AI data sources and repositories
- **`note_domain`**: Note business logic and use cases
- **`note_data`**: Note data sources and repositories

## 🚀 Getting Started

### Prerequisites

- **Flutter**: 3.24.0 or higher
- **Dart**: 3.5.0 or higher
- **Android Studio** / **VS Code** with Flutter extensions
- **Git**: For version control
- **Melos**: For monorepo management

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Eilodon/PandoraX.git
   cd PandoraX
   ```

2. **Install Melos** (if not already installed)
   ```bash
   dart pub global activate melos
   ```

3. **Bootstrap the workspace**
   ```bash
   melos bootstrap
   ```

4. **Configure environment**
   ```bash
   # Copy environment template
   cp packages/presentation/pandora_app/.env.example packages/presentation/pandora_app/.env
   
   # Add your API keys to .env
   echo "GEMINI_API_KEY=your_gemini_api_key_here" >> packages/presentation/pandora_app/.env
   echo "FIREBASE_PROJECT_ID=your_firebase_project_id" >> packages/presentation/pandora_app/.env
   ```

5. **Run the application**
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
- **Coverage**: 80%+ test coverage

Run tests:
```bash
# Run all tests
melos run test

# Run tests with coverage
melos run test:coverage

# Run specific package tests
cd packages/pandora_app && flutter test
```

## 📊 Performance Monitoring

PandoraX includes built-in performance monitoring:

- **Analytics Service**: Tracks user behavior and app usage
- **Performance Service**: Monitors app performance metrics
- **Error Service**: Centralized error handling and reporting
- **Firebase Analytics**: Integration with Firebase Analytics

## 🔒 Security

- **Data Encryption**: Sensitive data is encrypted using AES-256 encryption
- **Secure Storage**: Local data is stored securely with encryption
- **API Security**: All API calls are secured and validated
- **Permission Management**: Proper permission handling for device features
- **Biometric Authentication**: Support for fingerprint and face recognition

## 🌐 Internationalization

The app supports multiple languages:

- **English** (en)
- **Vietnamese** (vi)
- **More languages coming soon**

## 📱 Platform Support

- ✅ **Android** (API 21+)
- ✅ **iOS** (iOS 11.0+)
- ✅ **Web** (Chrome, Firefox, Safari, Edge)
- ✅ **Windows** (Windows 10+)
- ✅ **macOS** (macOS 10.14+)
- ✅ **Linux** (Ubuntu 18.04+)

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

- **Flutter team** for the amazing framework
- **Google** for the Gemini AI API
- **Firebase team** for the backend services
- **The open-source community** for various packages
- **All contributors** who helped make this project possible

## 📞 Support

If you have any questions or need help, please:

1. Check the [Issues](https://github.com/Eilodon/PandoraX/issues) page
2. Create a new issue if your problem isn't already reported
3. Join our [Discussions](https://github.com/Eilodon/PandoraX/discussions) for general questions

## 🎯 Roadmap

### Phase 1: Foundation ✅
- [x] Clean Architecture setup
- [x] Design system implementation
- [x] Basic note management
- [x] CI/CD pipeline

### Phase 2: AI Integration ✅
- [x] Google Generative AI integration
- [x] Voice recognition and synthesis
- [x] Performance monitoring
- [x] Analytics service

### Phase 3: Cloud & Security ✅
- [x] Firebase integration
- [x] Cloud synchronization
- [x] Enhanced security features
- [x] Data encryption

### Phase 4: Polish & Optimization ✅
- [x] Comprehensive documentation
- [x] Performance optimization
- [x] Advanced features
- [x] Final testing

### Future Releases
- [ ] Advanced AI features
- [ ] Collaborative editing
- [ ] Plugin system
- [ ] Mobile app stores release
- [ ] Enterprise features

---

**Made with ❤️ by Eilodon**

*PandoraX - Where your thoughts meet technology*
