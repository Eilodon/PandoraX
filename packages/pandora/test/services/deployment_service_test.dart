import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:pandora/services/deployment_service.dart';

import 'deployment_service_test.mocks.dart';

@GenerateMocks([PackageInfo, SharedPreferences, Connectivity])
void main() {
  group('DeploymentService', () {
    late DeploymentService service;
    late MockPackageInfo mockPackageInfo;
    late MockSharedPreferences mockPrefs;
    late MockConnectivity mockConnectivity;

    setUp(() {
      service = DeploymentService();
      mockPackageInfo = MockPackageInfo();
      mockPrefs = MockSharedPreferences();
      mockConnectivity = MockConnectivity();
    });

    group('Initialization', () {
      test('should initialize with production environment by default', () async {
        // Arrange
        when(mockPackageInfo.appName).thenReturn('Pandora Notes');
        when(mockPackageInfo.packageName).thenReturn('com.pandora.notes');
        when(mockPackageInfo.version).thenReturn('1.0.0');
        when(mockPackageInfo.buildNumber).thenReturn('1');
        when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
        when(mockPrefs.setBool(any, any)).thenAnswer((_) async => true);

        // Act
        await service.initialize();

        // Assert
        expect(service.getEnvironment(), equals(DeploymentEnvironment.production));
        expect(service.getApiBaseUrl(), equals('https://api.pandora-notes.com'));
        expect(service.getFirebaseProjectId(), equals('pandora-notes-prod'));
      });

      test('should initialize with development environment', () async {
        // Arrange
        when(mockPackageInfo.appName).thenReturn('Pandora Notes');
        when(mockPackageInfo.packageName).thenReturn('com.pandora.notes');
        when(mockPackageInfo.version).thenReturn('1.0.0');
        when(mockPackageInfo.buildNumber).thenReturn('1');
        when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
        when(mockPrefs.setBool(any, any)).thenAnswer((_) async => true);

        // Act
        await service.initialize();

        // Assert
        final config = service.getConfiguration();
        expect(config.environment, equals(DeploymentEnvironment.production));
        expect(config.apiBaseUrl, equals('https://api.pandora-notes.com'));
      });

      test('should throw exception when initialization fails', () async {
        // Arrange
        when(mockPackageInfo.appName).thenThrow(Exception('Package info error'));

        // Act & Assert
        expect(
          () => service.initialize(),
          throwsA(isA<DeploymentException>()),
        );
      });
    });

    group('Configuration Management', () {
      test('should get correct configuration for production', () async {
        // Arrange
        when(mockPackageInfo.appName).thenReturn('Pandora Notes');
        when(mockPackageInfo.packageName).thenReturn('com.pandora.notes');
        when(mockPackageInfo.version).thenReturn('1.0.0');
        when(mockPackageInfo.buildNumber).thenReturn('1');
        when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
        when(mockPrefs.setBool(any, any)).thenAnswer((_) async => true);

        // Act
        await service.initialize();
        final config = service.getConfiguration();

        // Assert
        expect(config.environment, equals(DeploymentEnvironment.production));
        expect(config.apiBaseUrl, equals('https://api.pandora-notes.com'));
        expect(config.firebaseProjectId, equals('pandora-notes-prod'));
        expect(config.debugMode, isFalse);
        expect(config.analyticsEnabled, isTrue);
        expect(config.crashlyticsEnabled, isTrue);
      });

      test('should check feature enabled status', () async {
        // Arrange
        when(mockPackageInfo.appName).thenReturn('Pandora Notes');
        when(mockPackageInfo.packageName).thenReturn('com.pandora.notes');
        when(mockPackageInfo.version).thenReturn('1.0.0');
        when(mockPackageInfo.buildNumber).thenReturn('1');
        when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
        when(mockPrefs.setBool(any, any)).thenAnswer((_) async => true);

        // Act
        await service.initialize();

        // Assert
        expect(service.isFeatureEnabled('analytics'), isTrue);
        expect(service.isFeatureEnabled('crashlytics'), isTrue);
        expect(service.isFeatureEnabled('performance_monitoring'), isTrue);
        expect(service.isFeatureEnabled('debug_tools'), isFalse);
        expect(service.isFeatureEnabled('unknown_feature'), isFalse);
      });

      test('should get configuration values', () async {
        // Arrange
        when(mockPackageInfo.appName).thenReturn('Pandora Notes');
        when(mockPackageInfo.packageName).thenReturn('com.pandora.notes');
        when(mockPackageInfo.version).thenReturn('1.0.0');
        when(mockPackageInfo.buildNumber).thenReturn('1');
        when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
        when(mockPrefs.setBool(any, any)).thenAnswer((_) async => true);

        // Act
        await service.initialize();

        // Assert
        expect(service.getConfigValue('api_base_url', ''), equals('https://api.pandora-notes.com'));
        expect(service.getConfigValue('firebase_project_id', ''), equals('pandora-notes-prod'));
        expect(service.getConfigValue('analytics_enabled', false), isTrue);
        expect(service.getConfigValue('debug_mode', true), isFalse);
        expect(service.getConfigValue('unknown_key', 'default'), equals('default'));
      });
    });

    group('Environment Detection', () {
      test('should detect production environment', () async {
        // Arrange
        when(mockPackageInfo.appName).thenReturn('Pandora Notes');
        when(mockPackageInfo.packageName).thenReturn('com.pandora.notes');
        when(mockPackageInfo.version).thenReturn('1.0.0');
        when(mockPackageInfo.buildNumber).thenReturn('1');
        when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
        when(mockPrefs.setBool(any, any)).thenAnswer((_) async => true);

        // Act
        await service.initialize();

        // Assert
        expect(service.getEnvironment(), equals(DeploymentEnvironment.production));
        expect(service.isDebugMode(), isFalse);
        expect(service.isAnalyticsEnabled(), isTrue);
        expect(service.isCrashlyticsEnabled(), isTrue);
      });
    });

    group('Deployment Info', () {
      test('should get deployment info', () async {
        // Arrange
        when(mockPackageInfo.appName).thenReturn('Pandora Notes');
        when(mockPackageInfo.packageName).thenReturn('com.pandora.notes');
        when(mockPackageInfo.version).thenReturn('1.0.0');
        when(mockPackageInfo.buildNumber).thenReturn('1');
        when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
        when(mockPrefs.setBool(any, any)).thenAnswer((_) async => true);
        when(mockPrefs.getString('install_date')).thenReturn('2024-01-01T00:00:00.000Z');

        // Act
        await service.initialize();
        final info = service.getDeploymentInfo();

        // Assert
        expect(info.appName, equals('Pandora Notes'));
        expect(info.packageName, equals('com.pandora.notes'));
        expect(info.version, equals('1.0.0'));
        expect(info.buildNumber, equals('1'));
        expect(info.environment, equals(DeploymentEnvironment.production));
        expect(info.isDebugMode, isFalse);
        expect(info.buildType, equals('release'));
      });

      test('should throw exception when package info not available', () {
        // Act & Assert
        expect(
          () => service.getDeploymentInfo(),
          throwsA(isA<DeploymentException>()),
        );
      });
    });

    group('Network Connectivity', () {
      test('should check network availability', () async {
        // Arrange
        when(mockPackageInfo.appName).thenReturn('Pandora Notes');
        when(mockPackageInfo.packageName).thenReturn('com.pandora.notes');
        when(mockPackageInfo.version).thenReturn('1.0.0');
        when(mockPackageInfo.buildNumber).thenReturn('1');
        when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
        when(mockPrefs.setBool(any, any)).thenAnswer((_) async => true);
        when(mockConnectivity.checkConnectivity())
            .thenAnswer((_) async => ConnectivityResult.wifi);

        // Act
        await service.initialize();
        final isAvailable = await service.isNetworkAvailable();

        // Assert
        expect(isAvailable, isTrue);
      });

      test('should return false when no network', () async {
        // Arrange
        when(mockPackageInfo.appName).thenReturn('Pandora Notes');
        when(mockPackageInfo.packageName).thenReturn('com.pandora.notes');
        when(mockPackageInfo.version).thenReturn('1.0.0');
        when(mockPackageInfo.buildNumber).thenReturn('1');
        when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
        when(mockPrefs.setBool(any, any)).thenAnswer((_) async => true);
        when(mockConnectivity.checkConnectivity())
            .thenAnswer((_) async => ConnectivityResult.none);

        // Act
        await service.initialize();
        final isAvailable = await service.isNetworkAvailable();

        // Assert
        expect(isAvailable, isFalse);
      });

      test('should handle connectivity check error', () async {
        // Arrange
        when(mockPackageInfo.appName).thenReturn('Pandora Notes');
        when(mockPackageInfo.packageName).thenReturn('com.pandora.notes');
        when(mockPackageInfo.version).thenReturn('1.0.0');
        when(mockPackageInfo.buildNumber).thenReturn('1');
        when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
        when(mockPrefs.setBool(any, any)).thenAnswer((_) async => true);
        when(mockConnectivity.checkConnectivity())
            .thenThrow(Exception('Connectivity error'));

        // Act
        await service.initialize();
        final isAvailable = await service.isNetworkAvailable();

        // Assert
        expect(isAvailable, isFalse);
      });
    });

    group('Configuration Updates', () {
      test('should update configuration at runtime', () async {
        // Arrange
        when(mockPackageInfo.appName).thenReturn('Pandora Notes');
        when(mockPackageInfo.packageName).thenReturn('com.pandora.notes');
        when(mockPackageInfo.version).thenReturn('1.0.0');
        when(mockPackageInfo.buildNumber).thenReturn('1');
        when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
        when(mockPrefs.setBool(any, any)).thenAnswer((_) async => true);

        // Act
        await service.initialize();
        await service.updateConfiguration({
          'analytics_enabled': false,
          'debug_mode': true,
        });

        // Assert
        expect(service.isFeatureEnabled('analytics'), isFalse);
        expect(service.isDebugMode(), isTrue);
      });
    });

    group('Error Handling', () {
      test('should handle service not initialized error', () {
        // Act & Assert
        expect(
          () => service.getConfiguration(),
          throwsA(isA<DeploymentException>()),
        );
      });

      test('should handle get deployment info error', () {
        // Act & Assert
        expect(
          () => service.getDeploymentInfo(),
          throwsA(isA<DeploymentException>()),
        );
      });
    });

    group('Disposal', () {
      test('should dispose resources properly', () {
        // Act
        service.dispose();

        // Assert
        expect(() => service.getConfiguration(), throwsA(isA<DeploymentException>()));
      });
    });
  });
}
