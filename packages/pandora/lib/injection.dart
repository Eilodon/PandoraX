import 'package:get_it/get_it.dart';
import 'package:note_domain/note_domain.dart';
import 'package:note_data/src/repositories/note_repository_impl.dart';
import 'package:note_data/src/datasources/local/isar_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pandora/features/ai/application/ai_service.dart';
import 'package:pandora/features/speech_recognition/application/speech_recognition_service.dart';
import 'package:pandora/services/interfaces/ai_service.dart';
import 'package:pandora/services/implementations/ai_service_impl.dart';
import 'package:pandora/services/voice_interaction_service.dart';
import 'package:pandora/services/voice_commands_service.dart';
import 'package:pandora/services/fpt_tts_service.dart';
import 'package:pandora/services/pho_whisper_service.dart';

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
    getIt.registerLazySingleton<AiService>(
      () => AiService('AIzaSyDemo_Google_Generative_AI_Key_For_Development_Only'),
    );
    
    // Register AIService interface with implementation
    getIt.registerLazySingleton<AIService>(
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
    
    print('✅ Dependencies configured successfully');
  } catch (e) {
    print('❌ Failed to configure dependencies: $e');
    rethrow;
  }
}
