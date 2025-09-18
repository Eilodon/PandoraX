import 'dart:async';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ProductionMonitoringService {
  static final ProductionMonitoringService _instance = ProductionMonitoringService._internal();
  factory ProductionMonitoringService() => _instance;
  ProductionMonitoringService._internal();

  FirebaseAnalytics? _analytics;
  FirebaseCrashlytics? _crashlytics;
  Connectivity? _connectivity;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  Future<void> initialize() async {
    _analytics = FirebaseAnalytics.instance;
    _crashlytics = FirebaseCrashlytics.instance;
    _connectivity = Connectivity();
    
    await _setupConnectivityMonitoring();
  }

  Future<void> _setupConnectivityMonitoring() async {
    _connectivitySubscription = _connectivity!.onConnectivityChanged.listen(
      (List<ConnectivityResult> results) {
        _trackEvent('connectivity_changed', {
          'connection_type': results.toString(),
        });
      },
    );
  }

  void _trackEvent(String eventName, Map<String, Object> parameters) {
    _analytics?.logEvent(
      name: eventName,
      parameters: parameters,
    );
  }

  Future<void> trackUserAction(String action, Map<String, dynamic>? data) async {
    try {
      await _analytics?.logEvent(
        name: 'user_action',
        parameters: {
          'action': action,
          'data': data ?? {},
        },
      );
    } catch (e) {
      print('Error tracking user action: $e');
    }
  }

  Future<void> trackError(String error, StackTrace? stackTrace) async {
    try {
      await _crashlytics?.recordError(
        error,
        stackTrace,
        fatal: false,
      );
    } catch (e) {
      print('Error tracking error: $e');
    }
  }

  Future<void> trackPerformance(String operation, Duration duration) async {
    try {
      await _analytics?.logEvent(
        name: 'performance_metric',
        parameters: {
          'operation': operation,
          'duration_ms': duration.inMilliseconds,
        },
      );
    } catch (e) {
      print('Error tracking performance: $e');
    }
  }

  Future<void> trackAppStart() async {
    try {
      await _analytics?.logEvent(name: 'app_start');
    } catch (e) {
      print('Error tracking app start: $e');
    }
  }

  Future<void> trackAppStop() async {
    try {
      await _analytics?.logEvent(name: 'app_stop');
    } catch (e) {
      print('Error tracking app stop: $e');
    }
  }

  Future<void> dispose() async {
    await _connectivitySubscription?.cancel();
  }
}