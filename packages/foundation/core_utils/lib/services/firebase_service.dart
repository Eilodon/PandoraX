import 'dart:typed_data';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:core_utils/core_utils.dart';

/// Firebase service for authentication, database, and storage
class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  factory FirebaseService() => _instance;
  FirebaseService._internal();

  late FirebaseApp _app;
  late FirebaseAuth _auth;
  late FirebaseFirestore _firestore;
  late FirebaseStorage _storage;
  late FirebaseAnalytics _analytics;
  late FirebaseCrashlytics _crashlytics;
  
  bool _isInitialized = false;

  /// Initialize Firebase services
  Future<void> initialize() async {
    try {
      AppLogger.info('Initializing Firebase Service...');
      
      // Initialize Firebase Core
      _app = await Firebase.initializeApp();
      
      // Initialize Firebase services
      _auth = FirebaseAuth.instance;
      _firestore = FirebaseFirestore.instance;
      _storage = FirebaseStorage.instance;
      _analytics = FirebaseAnalytics.instance;
      _crashlytics = FirebaseCrashlytics.instance;
      
      // Configure Firestore settings
      _firestore.settings = const Settings(
        persistenceEnabled: true,
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
      );
      
      // Enable Crashlytics
      await _crashlytics.setCrashlyticsCollectionEnabled(true);
      
      _isInitialized = true;
      AppLogger.success('Firebase Service initialized successfully');
    } catch (e) {
      AppLogger.error('Failed to initialize Firebase Service', e);
      rethrow;
    }
  }

  /// Get current user
  User? get currentUser => _auth.currentUser;

  /// Check if user is authenticated
  bool get isAuthenticated => _auth.currentUser != null;

  /// Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      AppLogger.info('Signing in with email: $email');
      
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      AppLogger.success('User signed in successfully');
      return credential;
    } catch (e) {
      AppLogger.error('Failed to sign in', e);
      await _crashlytics.recordError(e, null);
      rethrow;
    }
  }

  /// Create user with email and password
  Future<UserCredential> createUserWithEmailAndPassword(String email, String password) async {
    try {
      AppLogger.info('Creating user with email: $email');
      
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      AppLogger.success('User created successfully');
      return credential;
    } catch (e) {
      AppLogger.error('Failed to create user', e);
      await _crashlytics.recordError(e, null);
      rethrow;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      AppLogger.info('User signed out successfully');
    } catch (e) {
      AppLogger.error('Failed to sign out', e);
      await _crashlytics.recordError(e, null);
    }
  }

  /// Get Firestore instance
  FirebaseFirestore get firestore => _firestore;

  /// Get Storage instance
  FirebaseStorage get storage => _storage;

  /// Get Analytics instance
  FirebaseAnalytics get analytics => _analytics;

  /// Get Crashlytics instance
  FirebaseCrashlytics get crashlytics => _crashlytics;

  /// Track custom event
  Future<void> trackEvent(String eventName, Map<String, dynamic> parameters) async {
    try {
      await _analytics.logEvent(
        name: eventName,
        parameters: parameters,
      );
      AppLogger.info('Event tracked: $eventName');
    } catch (e) {
      AppLogger.error('Failed to track event: $eventName', e);
    }
  }

  /// Set user properties
  Future<void> setUserProperties(Map<String, String> properties) async {
    try {
      for (final entry in properties.entries) {
        await _analytics.setUserProperty(
          name: entry.key,
          value: entry.value,
        );
      }
      AppLogger.info('User properties set successfully');
    } catch (e) {
      AppLogger.error('Failed to set user properties', e);
    }
  }

  /// Upload file to Firebase Storage
  Future<String> uploadFile(String path, List<int> data) async {
    try {
      AppLogger.info('Uploading file to path: $path');
      
      final ref = _storage.ref().child(path);
      final uploadTask = ref.putData(Uint8List.fromList(data));
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      
      AppLogger.success('File uploaded successfully: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      AppLogger.error('Failed to upload file', e);
      await _crashlytics.recordError(e, null);
      rethrow;
    }
  }

  /// Download file from Firebase Storage
  Future<List<int>> downloadFile(String path) async {
    try {
      AppLogger.info('Downloading file from path: $path');
      
      final ref = _storage.ref().child(path);
      final data = await ref.getData();
      
      if (data == null) {
        throw Exception('File not found');
      }
      
      AppLogger.success('File downloaded successfully');
      return data;
    } catch (e) {
      AppLogger.error('Failed to download file', e);
      await _crashlytics.recordError(e, null);
      rethrow;
    }
  }

  /// Delete file from Firebase Storage
  Future<void> deleteFile(String path) async {
    try {
      AppLogger.info('Deleting file from path: $path');
      
      final ref = _storage.ref().child(path);
      await ref.delete();
      
      AppLogger.success('File deleted successfully');
    } catch (e) {
      AppLogger.error('Failed to delete file', e);
      await _crashlytics.recordError(e, null);
    }
  }

  /// Check if service is initialized
  bool get isInitialized => _isInitialized;

  /// Dispose resources
  void dispose() {
    _isInitialized = false;
  }
}
