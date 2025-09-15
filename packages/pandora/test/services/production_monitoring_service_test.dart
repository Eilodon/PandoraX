import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:pandora/services/production_monitoring_service.dart';

import 'production_monitoring_service_test.mocks.dart';

@GenerateMocks([
  FirebaseAnalytics,
  FirebaseCrashlytics,
  PackageInfo,
  SharedPreferences,
  Connectivity,
])
void main() {
  group('ProductionMonitoringService', () {
    late ProductionMonitoringService service;
    late MockFirebaseAnalytics mockAnalytics;
    late MockFirebaseCrashlytics mockCrashlytics;
    late MockPackageInfo mockPackageInfo;
    late MockSharedPreferences mockPrefs;
    late MockConnectivity mockConnectivity;

    setUp(() {
      service = ProductionMonitoringService();
      mockAnalytics = MockFirebaseAnalytics();
      mockCrashlytics = MockFirebaseCrashlytics();
      mockPackageInfo = MockPackageInfo();
      mockPrefs = MockSharedPreferences();
      mockConnectivity = MockConnectivity();
    });

    group('Initialization', () {
      test('should initialize successfully', () async {
        // Arrange
        when(mockPackageInfo.version).thenReturn('1.0.0');
        when(mockPackageInfo.buildNumber).thenReturn('1');
        when(mockPackageInfo.appName).thenReturn('Pandora Notes');
        when(mockPackageInfo.packageName).thenReturn('com.pandora.notes');
        when(mockPrefs.getString('user_id')).thenReturn('user123');
        when(mockAnalytics.setAnalyticsCollectionEnabled(any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.setSessionTimeoutDuration(any))
            .thenAnswer((_) async => {});
        when(mockCrashlytics.setCrashlyticsCollectionEnabled(any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.setUserProperty(any, any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.setUserId(any))
            .thenAnswer((_) async => {});

        // Act
        await service.initialize();

        // Assert
        verify(mockAnalytics.setAnalyticsCollectionEnabled(true)).called(1);
        verify(mockCrashlytics.setCrashlyticsCollectionEnabled(true)).called(1);
        verify(mockAnalytics.setUserProperty(name: 'app_version', value: '1.0.0')).called(1);
        verify(mockAnalytics.setUserProperty(name: 'build_number', value: '1')).called(1);
        verify(mockAnalytics.setUserProperty(name: 'platform', value: any)).called(1);
      });

      test('should handle initialization error gracefully', () async {
        // Arrange
        when(mockPackageInfo.version).thenThrow(Exception('Package info error'));

        // Act & Assert
        expect(
          () => service.initialize(),
          throwsA(isA<ProductionMonitoringException>()),
        );
      });
    });

    group('Event Tracking', () {
      test('should track custom event successfully', () async {
        // Arrange
        when(mockPackageInfo.version).thenReturn('1.0.0');
        when(mockPackageInfo.buildNumber).thenReturn('1');
        when(mockPackageInfo.appName).thenReturn('Pandora Notes');
        when(mockPackageInfo.packageName).thenReturn('com.pandora.notes');
        when(mockPrefs.getString('user_id')).thenReturn('user123');
        when(mockAnalytics.setAnalyticsCollectionEnabled(any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.setSessionTimeoutDuration(any))
            .thenAnswer((_) async => {});
        when(mockCrashlytics.setCrashlyticsCollectionEnabled(any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.setUserProperty(any, any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.setUserId(any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.logEvent(name: any, parameters: any))
            .thenAnswer((_) async => {});

        // Act
        await service.initialize();
        await service.trackEvent('test_event', {'key': 'value'});

        // Assert
        verify(mockAnalytics.logEvent(
          name: 'test_event',
          parameters: {'key': 'value'},
        )).called(1);
      });

      test('should track user action', () async {
        // Arrange
        when(mockPackageInfo.version).thenReturn('1.0.0');
        when(mockPackageInfo.buildNumber).thenReturn('1');
        when(mockPackageInfo.appName).thenReturn('Pandora Notes');
        when(mockPackageInfo.packageName).thenReturn('com.pandora.notes');
        when(mockPrefs.getString('user_id')).thenReturn('user123');
        when(mockAnalytics.setAnalyticsCollectionEnabled(any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.setSessionTimeoutDuration(any))
            .thenAnswer((_) async => {});
        when(mockCrashlytics.setCrashlyticsCollectionEnabled(any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.setUserProperty(any, any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.setUserId(any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.logEvent(name: any, parameters: any))
            .thenAnswer((_) async => {});

        // Act
        await service.initialize();
        await service.trackUserAction('button_click', {'button': 'save'});

        // Assert
        verify(mockAnalytics.logEvent(
          name: 'user_action',
          parameters: {'action': 'button_click', 'button': 'save'},
        )).called(1);
      });

      test('should track screen view', () async {
        // Arrange
        when(mockPackageInfo.version).thenReturn('1.0.0');
        when(mockPackageInfo.buildNumber).thenReturn('1');
        when(mockPackageInfo.appName).thenReturn('Pandora Notes');
        when(mockPackageInfo.packageName).thenReturn('com.pandora.notes');
        when(mockPrefs.getString('user_id')).thenReturn('user123');
        when(mockAnalytics.setAnalyticsCollectionEnabled(any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.setSessionTimeoutDuration(any))
            .thenAnswer((_) async => {});
        when(mockCrashlytics.setCrashlyticsCollectionEnabled(any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.setUserProperty(any, any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.setUserId(any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.logEvent(name: any, parameters: any))
            .thenAnswer((_) async => {});

        // Act
        await service.initialize();
        await service.trackScreenView('home_screen', {'tab': 'notes'});

        // Assert
        verify(mockAnalytics.logEvent(
          name: 'screen_view',
          parameters: {'screen_name': 'home_screen', 'tab': 'notes'},
        )).called(1);
      });

      test('should track error', () async {
        // Arrange
        when(mockPackageInfo.version).thenReturn('1.0.0');
        when(mockPackageInfo.buildNumber).thenReturn('1');
        when(mockPackageInfo.appName).thenReturn('Pandora Notes');
        when(mockPackageInfo.packageName).thenReturn('com.pandora.notes');
        when(mockPrefs.getString('user_id')).thenReturn('user123');
        when(mockAnalytics.setAnalyticsCollectionEnabled(any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.setSessionTimeoutDuration(any))
            .thenAnswer((_) async => {});
        when(mockCrashlytics.setCrashlyticsCollectionEnabled(any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.setUserProperty(any, any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.setUserId(any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.logEvent(name: any, parameters: any))
            .thenAnswer((_) async => {});

        // Act
        await service.initialize();
        await service.trackError('network_error', 'Connection failed', {'url': 'api.example.com'});

        // Assert
        verify(mockAnalytics.logEvent(
          name: 'error',
          parameters: {
            'error_type': 'network_error',
            'error_message': 'Connection failed',
            'url': 'api.example.com'
          },
        )).called(1);
      });
    });

    group('Custom Metrics', () {
      test('should set and get custom metrics', () async {
        // Arrange
        when(mockPackageInfo.version).thenReturn('1.0.0');
        when(mockPackageInfo.buildNumber).thenReturn('1');
        when(mockPackageInfo.appName).thenReturn('Pandora Notes');
        when(mockPackageInfo.packageName).thenReturn('com.pandora.notes');
        when(mockPrefs.getString('user_id')).thenReturn('user123');
        when(mockAnalytics.setAnalyticsCollectionEnabled(any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.setSessionTimeoutDuration(any))
            .thenAnswer((_) async => {});
        when(mockCrashlytics.setCrashlyticsCollectionEnabled(any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.setUserProperty(any, any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.setUserId(any))
            .thenAnswer((_) async => {});

        // Act
        await service.initialize();
        service.setCustomMetric('test_metric', 42);
        final value = service.getCustomMetric('test_metric');

        // Assert
        expect(value, equals(42));
      });

      test('should return null for non-existent metric', () async {
        // Arrange
        when(mockPackageInfo.version).thenReturn('1.0.0');
        when(mockPackageInfo.buildNumber).thenReturn('1');
        when(mockPackageInfo.appName).thenReturn('Pandora Notes');
        when(mockPackageInfo.packageName).thenReturn('com.pandora.notes');
        when(mockPrefs.getString('user_id')).thenReturn('user123');
        when(mockAnalytics.setAnalyticsCollectionEnabled(any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.setSessionTimeoutDuration(any))
            .thenAnswer((_) async => {});
        when(mockCrashlytics.setCrashlyticsCollectionEnabled(any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.setUserProperty(any, any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.setUserId(any))
            .thenAnswer((_) async => {});

        // Act
        await service.initialize();
        final value = service.getCustomMetric('non_existent');

        // Assert
        expect(value, isNull);
      });
    });

    group('Dashboard Data', () {
      test('should get monitoring dashboard data', () async {
        // Arrange
        when(mockPackageInfo.version).thenReturn('1.0.0');
        when(mockPackageInfo.buildNumber).thenReturn('1');
        when(mockPackageInfo.appName).thenReturn('Pandora Notes');
        when(mockPackageInfo.packageName).thenReturn('com.pandora.notes');
        when(mockPrefs.getString('user_id')).thenReturn('user123');
        when(mockPrefs.getInt('error_count')).thenReturn(5);
        when(mockAnalytics.setAnalyticsCollectionEnabled(any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.setSessionTimeoutDuration(any))
            .thenAnswer((_) async => {});
        when(mockCrashlytics.setCrashlyticsCollectionEnabled(any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.setUserProperty(any, any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.setUserId(any))
            .thenAnswer((_) async => {});

        // Act
        await service.initialize();
        service.setCustomMetric('test_metric', 42);
        final dashboard = await service.getDashboardData();

        // Assert
        expect(dashboard.appVersion, equals('1.0.0'));
        expect(dashboard.buildNumber, equals('1'));
        expect(dashboard.platform, isA<String>());
        expect(dashboard.errorCount, equals(5));
        expect(dashboard.customMetrics['test_metric'], equals(42));
      });
    });

    group('Error Handling', () {
      test('should handle tracking error gracefully', () async {
        // Arrange
        when(mockPackageInfo.version).thenReturn('1.0.0');
        when(mockPackageInfo.buildNumber).thenReturn('1');
        when(mockPackageInfo.appName).thenReturn('Pandora Notes');
        when(mockPackageInfo.packageName).thenReturn('com.pandora.notes');
        when(mockPrefs.getString('user_id')).thenReturn('user123');
        when(mockAnalytics.setAnalyticsCollectionEnabled(any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.setSessionTimeoutDuration(any))
            .thenAnswer((_) async => {});
        when(mockCrashlytics.setCrashlyticsCollectionEnabled(any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.setUserProperty(any, any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.setUserId(any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.logEvent(name: any, parameters: any))
            .thenThrow(Exception('Analytics error'));

        // Act
        await service.initialize();
        await service.trackEvent('test_event', {'key': 'value'});

        // Assert
        // Should not throw exception
        expect(true, isTrue);
      });
    });

    group('Disposal', () {
      test('should dispose resources properly', () async {
        // Arrange
        when(mockPackageInfo.version).thenReturn('1.0.0');
        when(mockPackageInfo.buildNumber).thenReturn('1');
        when(mockPackageInfo.appName).thenReturn('Pandora Notes');
        when(mockPackageInfo.packageName).thenReturn('com.pandora.notes');
        when(mockPrefs.getString('user_id')).thenReturn('user123');
        when(mockAnalytics.setAnalyticsCollectionEnabled(any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.setSessionTimeoutDuration(any))
            .thenAnswer((_) async => {});
        when(mockCrashlytics.setCrashlyticsCollectionEnabled(any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.setUserProperty(any, any))
            .thenAnswer((_) async => {});
        when(mockAnalytics.setUserId(any))
            .thenAnswer((_) async => {});

        // Act
        await service.initialize();
        service.dispose();

        // Assert
        // Should not throw exception when disposed
        expect(true, isTrue);
      });
    });
  });
}
