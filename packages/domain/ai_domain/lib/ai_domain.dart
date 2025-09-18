/// AI domain package for PandoraX
///
/// This package contains all AI-related business logic and use cases
/// following Clean Architecture principles.
library ai_domain;

// Entities
export 'entities/ai_request.dart';
export 'entities/summarization_style.dart';
export 'entities/content_template.dart';
export 'entities/supported_language.dart';
export 'entities/voice_language.dart';
export 'entities/voice_command.dart';
export 'entities/sync_status.dart';
export 'entities/security_config.dart';
export 'entities/theme_config.dart';
export 'entities/performance_config.dart';
export 'entities/ml_config.dart';

// Repositories
export 'repositories/ai_repository.dart';

// Use cases
export 'use_cases/generate_text_use_case.dart';
export 'use_cases/summarize_text_use_case.dart';
export 'use_cases/chat_use_case.dart';
