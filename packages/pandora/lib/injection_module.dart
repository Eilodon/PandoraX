import 'package:injectable/injectable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:isar/isar.dart';
import 'package:note_data/src/datasources/local/isar_service.dart';
import 'config/environment.dart';
import 'services/production_encryption_service.dart';
import 'services/simple_validation_service.dart';
import 'services/production_error_service.dart';
import 'services/performance_optimization_service.dart';
import 'services/ui_optimization_service.dart';
import 'services/build_optimization_service.dart';

/// Injectable module for external dependencies
@module
abstract class InjectableModule {
  
  // Firebase Services
  
  @lazySingleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  
  @lazySingleton
  FirebaseMessaging get messaging => FirebaseMessaging.instance;
  
  @lazySingleton
  FirebaseAnalytics get analytics => FirebaseAnalytics.instance;
  
  @lazySingleton
  FirebaseCrashlytics get crashlytics => FirebaseCrashlytics.instance;

  // AI Services
  
  // Note: GenerativeModel is managed directly by AIService implementations
  // No need to register it separately in DI container

  // Speech Recognition
  
  @lazySingleton
  SpeechToText get speechToText => SpeechToText();

  // Local Storage
  
  @preResolve
  @lazySingleton
  Future<SharedPreferences> get sharedPreferences => SharedPreferences.getInstance();
  
  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  // Notifications
  
  @lazySingleton
  FlutterLocalNotificationsPlugin get localNotifications {
    final plugin = FlutterLocalNotificationsPlugin();
    
    // Initialize with platform settings
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    
    plugin.initialize(initSettings);
    return plugin;
  }

  // Network
  
  @lazySingleton
  Connectivity get connectivity => Connectivity();

  // Database (Isar will be configured in a separate service)
  
  @lazySingleton
  IsarService get isarService => IsarService();
  
  // Note: Isar instance will be created in IsarService
  // as it requires async initialization with schema
  
  // Security Services
  
  @lazySingleton
  ProductionEncryptionService get productionEncryptionService => ProductionEncryptionService();
  
  @lazySingleton
  SimpleValidationService get inputValidationService => SimpleValidationService();
  
  @lazySingleton
  UIOptimizationService get uiOptimizationService => UIOptimizationService();
  
  @lazySingleton
  BuildOptimizationService get buildOptimizationService => BuildOptimizationService();
  
  // Performance & Error Services (Initialized separately due to static nature)
  // PerformanceOptimizationService, ProductionErrorService are initialized in main.dart
}

// Environment constants are provided by injectable package automatically