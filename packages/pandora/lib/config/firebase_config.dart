import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'environment.dart';

/// Firebase configuration for production
class FirebaseConfig {
  static FirebaseAnalytics? _analytics;
  static FirebaseCrashlytics? _crashlytics;
  static FirebaseMessaging? _messaging;

  /// Initialize Firebase services
  static Future<void> initialize() async {
    try {
      // Initialize Firebase with fallback options
      await Firebase.initializeApp(
        options: _getFirebaseOptions(),
      );

      // Initialize services
      await _initializeAnalytics();
      await _initializeCrashlytics();
      await _initializeMessaging();

      print('✅ Firebase initialized successfully');
    } catch (e) {
      print('❌ Firebase initialization failed: $e');
      if (kDebugMode) {
        throw Exception('Firebase initialization failed: $e');
      }
    }
  }

  /// Get Firebase options based on environment
  static FirebaseOptions? _getFirebaseOptions() {
    // For demo/development, use mock configuration
    if (Environment.current != EnvironmentType.production) {
      return const FirebaseOptions(
        apiKey: 'AIzaSyDemo_Firebase_API_Key_For_Development_Only',
        appId: '1:123456789012:android:abcdef123456789012345678',
        messagingSenderId: '123456789012',
        projectId: 'pandora-notes-demo',
        storageBucket: 'pandora-notes-demo.appspot.com',
      );
    }
    
    // In production, Firebase options will be loaded from google-services.json
    return null;
  }

  /// Initialize Firebase Analytics
  static Future<void> _initializeAnalytics() async {
    if (Environment.current != EnvironmentType.production) return;
    
    _analytics = FirebaseAnalytics.instance;
    await _analytics!.setAnalyticsCollectionEnabled(true);
    
    if (kDebugMode) {
      await _analytics!.setAnalyticsCollectionEnabled(false);
    }
  }

  /// Initialize Firebase Crashlytics
  static Future<void> _initializeCrashlytics() async {
    _crashlytics = FirebaseCrashlytics.instance;
    
    // Enable crash collection in production
    await _crashlytics!.setCrashlyticsCollectionEnabled(
      Environment.current == EnvironmentType.production,
    );

    // Set up crash reporting
    FlutterError.onError = _crashlytics!.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      _crashlytics!.recordError(error, stack, fatal: true);
      return true;
    };
  }

  /// Initialize Firebase Cloud Messaging
  static Future<void> _initializeMessaging() async {
    _messaging = FirebaseMessaging.instance;

    // Request permission for notifications
    NotificationSettings settings = await _messaging!.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('✅ User granted notification permission');
    } else {
      print('❌ User declined notification permission');
    }

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  /// Get Firebase Analytics instance
  static FirebaseAnalytics? get analytics => _analytics;

  /// Get Firebase Crashlytics instance
  static FirebaseCrashlytics? get crashlytics => _crashlytics;

  /// Get Firebase Messaging instance
  static FirebaseMessaging? get messaging => _messaging;

  /// Log analytics event
  static Future<void> logEvent(String name, Map<String, Object>? parameters) async {
    if (_analytics != null && Environment.current == EnvironmentType.production) {
      await _analytics!.logEvent(
        name: name,
        parameters: parameters,
      );
    }
  }

  /// Log user property
  static Future<void> setUserProperty(String name, String? value) async {
    if (_analytics != null && Environment.current == EnvironmentType.production) {
      await _analytics!.setUserProperty(
        name: name,
        value: value,
      );
    }
  }

  /// Record error to Crashlytics
  static void recordError(dynamic exception, StackTrace? stack, {bool fatal = false}) {
    if (_crashlytics != null) {
      _crashlytics!.recordError(exception, stack, fatal: fatal);
    }
  }

  /// Set user identifier for Crashlytics
  static Future<void> setUserId(String userId) async {
    if (_crashlytics != null) {
      await _crashlytics!.setUserIdentifier(userId);
    }
  }
}

/// Background message handler for FCM
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
}
