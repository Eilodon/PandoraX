import 'package:get_it/get_it.dart';
import 'package:note_domain/note_domain.dart';
import 'package:note_data/src/repositories/note_repository_impl.dart';
import 'package:note_data/src/datasources/local/isar_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pandora/features/ai/application/ai_service.dart' as ai_feature;
import 'package:pandora/features/speech_recognition/application/speech_recognition_service.dart';
import 'package:pandora/services/interfaces/ai_service.dart' as ai_service;
import 'package:pandora/services/implementations/ai_service_impl.dart';
import 'package:pandora/services/voice_interaction_service.dart';
import 'package:pandora/services/voice_commands_service.dart';
import 'package:pandora/services/fpt_tts_service.dart';
import 'package:pandora/services/pho_whisper_service.dart';
// AI Core packages
import 'package:ai_core/ai_core.dart';
import 'package:ai_llm/ai_llm.dart';
import 'package:ai_llm/src/datasources/adaptive_health_monitor.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  try {
    // Register IsarService
    getIt.registerLazySingleton<IsarService>(() => IsarService());
    
    // Register FirebaseFirestore
    getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
    
    // Register NoteRepository
    getIt.registerLazySingleton<NoteRepository>(
      () => NoteRepositoryImpl(
        getIt<IsarService>(),
        getIt<FirebaseFirestore>(),
      ),
    );
    
    // Register AiService with demo API key
    getIt.registerLazySingleton<ai_feature.AiService>(
      () => ai_feature.AiService('AIzaSyDemo_Google_Generative_AI_Key_For_Development_Only'),
    );
    
    // Register AIService interface with implementation
    getIt.registerLazySingleton<ai_service.AIService>(
      () => AIServiceImpl(),
    );
    
    // Register SpeechRecognitionService
    getIt.registerLazySingleton<SpeechRecognitionService>(
      () => SpeechRecognitionService(),
    );
    
    // Register Voice Services
    getIt.registerLazySingleton<VoiceInteractionService>(
      () => VoiceInteractionService(),
    );
    
    getIt.registerLazySingleton<VoiceCommandsService>(
      () => VoiceCommandsService('AIzaSyDemo_Google_Generative_AI_Key_For_Development_Only'),
    );
    
    getIt.registerLazySingleton<FptTtsService>(
      () => FptTtsService(),
    );
    
    getIt.registerLazySingleton<PhoWhisperService>(
      () => PhoWhisperService(),
    );
    
    // Register AI Core services - temporarily disable ModelStorageRepository
    // getIt.registerLazySingleton<ModelStorageRepository>(
    //   () => ModelStorageRepositoryImpl(
    //     isar: getIt<IsarService>().db,
    //     cacheDir: '/tmp/ai_models', // Will be updated with proper path
    //     maxBytes: 1024 * 1024 * 1024, // 1GB
    //   ),
    // );
    
    // Temporarily disable AI services due to dependency issues
    // getIt.registerLazySingleton<OnDeviceModelService>(
    //   () => OnDeviceModelService(
    //     getIt<ModelStorageRepository>(),
    //     _createHealthMonitor(),
    //   ),
    // );
    
    // getIt.registerLazySingleton<AIRepository>(
    //   () => AIRepositoryImpl(
    //     getIt<OnDeviceModelService>(),
    //     getIt<ai_service.AIService>(),
    //   ),
    // );
    
    // Register Use Cases - temporarily disabled
    // getIt.registerLazySingleton<GetChatResponse>(
    //   () => GetChatResponse(getIt<AIRepository>()),
    // );
    
    // getIt.registerLazySingleton<SummarizeNote>(
    //   () => SummarizeNote(getIt<AIRepository>()),
    // );
    
    // getIt.registerLazySingleton<DownloadModel>(
    //   () => DownloadModel(getIt<ModelStorageRepository>()),
    // );
    
    print('✅ Dependencies configured successfully');
  } catch (e) {
    print('❌ Failed to configure dependencies: $e');
    rethrow;
  }
}

HealthMonitor _createHealthMonitor() {
  // Simple implementation for now
  return _SimpleHealthMonitor();
}

class _SimpleHealthMonitor implements HealthMonitor {
  @override
  void record(bool success, int latencyMs) {
    // Simple implementation - just log
    print('Health: success=$success, latency=${latencyMs}ms');
  }

  @override
  HealthSnapshot snapshot() {
    return HealthSnapshot(
      successRate: 1.0,
      p50LatencyMs: 100,
      p95LatencyMs: 200,
      totalSamples: 1,
      isHealthy: true,
    );
  }

  @override
  void clear() {
    // Simple implementation - do nothing
  }

  @override
  bool get isHealthy => true;
}
