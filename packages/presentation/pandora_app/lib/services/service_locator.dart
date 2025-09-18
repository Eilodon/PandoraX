import 'package:get_it/get_it.dart';
import 'package:note_domain/note_domain.dart';
import 'package:note_data/note_data.dart';
import 'package:core_utils/core_utils.dart';
import 'ai_service.dart';
import 'voice_service.dart';
import 'export_import_service.dart';

/// Service locator for dependency injection
final GetIt serviceLocator = GetIt.instance;

/// Initialize all services
Future<void> initializeServices() async {
  try {
    AppLogger.info('🔧 Initializing services...');

    // Initialize core services
    await _initializeCoreServices();
    
    // Initialize data services
    await _initializeDataServices();
    
    // Initialize domain services
    await _initializeDomainServices();

    AppLogger.success('✅ All services initialized successfully');
  } catch (e, stackTrace) {
    AppLogger.error('❌ Failed to initialize services', e, stackTrace);
    rethrow;
  }
}

/// Initialize core services
Future<void> _initializeCoreServices() async {
  // Logger service
  serviceLocator.registerSingleton<AppLogger>(AppLogger());
  
  // Database service
  serviceLocator.registerSingleton<DatabaseService>(DatabaseService.instance);
  
  AppLogger.info('✅ Core services initialized');
}

/// Initialize data services
Future<void> _initializeDataServices() async {
  // Note local data source
  final noteLocalDataSource = NoteLocalDataSource();
  await noteLocalDataSource.initialize();
  serviceLocator.registerSingleton<NoteLocalDataSource>(noteLocalDataSource);
  
  // Note repository implementation
  serviceLocator.registerSingleton<NoteRepository>(
    NoteRepositoryImpl(noteLocalDataSource),
  );
  
  AppLogger.info('✅ Data services initialized');
}

/// Initialize domain services
Future<void> _initializeDomainServices() async {
  // AI Service
  final aiService = AIService();
  await aiService.initialize();
  serviceLocator.registerSingleton<AIService>(aiService);
  
  // Voice Service
  final voiceService = VoiceService();
  await voiceService.initialize();
  serviceLocator.registerSingleton<VoiceService>(voiceService);
  
  // Export/Import Service
  serviceLocator.registerSingleton<ExportImportService>(ExportImportService());
  
  // Note use cases - TODO: Implement when use cases are available
  // serviceLocator.registerSingleton<CreateNoteUseCase>(
  //   CreateNoteUseCase(serviceLocator<NoteRepository>()),
  // );
  
  AppLogger.info('✅ Domain services initialized');
}

/// Database service for managing Isar instances
class DatabaseService {
  static DatabaseService? _instance;
  
  DatabaseService._();
  
  static DatabaseService get instance {
    _instance ??= DatabaseService._();
    return _instance!;
  }
  
  /// Initialize database
  Future<void> initialize() async {
    try {
      AppLogger.info('🗄️ Initializing database...');
      // Database initialization will be handled by individual data sources
      AppLogger.success('✅ Database initialized');
    } catch (e, stackTrace) {
      AppLogger.error('❌ Failed to initialize database', e, stackTrace);
      rethrow;
    }
  }
}
