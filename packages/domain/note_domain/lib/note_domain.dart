/// Note domain package for PandoraX
///
/// This package contains all note-related business logic and use cases
/// following Clean Architecture principles.
library note_domain;

// Repositories
export 'repositories/note_repository.dart';

// Use cases
export 'use_cases/create_note_use_case.dart';
export 'use_cases/search_notes_use_case.dart';
export 'use_cases/update_note_use_case.dart';
