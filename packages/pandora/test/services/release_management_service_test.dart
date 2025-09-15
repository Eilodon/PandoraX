import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:pandora/services/release_management_service.dart';

import 'release_management_service_test.mocks.dart';

@GenerateMocks([PackageInfo, SharedPreferences, Connectivity])
void main() {
  group('ReleaseManagementService', () {
    late ReleaseManagementService service;
    late MockPackageInfo mockPackageInfo;
    late MockSharedPreferences mockPrefs;
    late MockConnectivity mockConnectivity;

    setUp(() {
      service = ReleaseManagementService();
      mockPackageInfo = MockPackageInfo();
      mockPrefs = MockSharedPreferences();
      mockConnectivity = MockConnectivity();
    });

    group('Initialization', () {
      test('should initialize successfully with valid data', () async {
        // Arrange
        when(mockPackageInfo.version).thenReturn('1.0.0');
        when(mockPackageInfo.buildNumber).thenReturn('1');
        when(mockPackageInfo.appName).thenReturn('Pandora Notes');
        when(mockPackageInfo.packageName).thenReturn('com.pandora.notes');
        when(mockPrefs.getString('last_known_version')).thenReturn('0.9.0');
        when(mockPrefs.getInt('last_known_build')).thenReturn(0);
        when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
        when(mockPrefs.setInt(any, any)).thenAnswer((_) async => true);

        // Act
        await service.initialize();

        // Assert
        expect(service.getCurrentVersion().version, equals('1.0.0'));
        expect(service.getCurrentVersion().buildNumber, equals('1'));
      });

      test('should throw exception when initialization fails', () async {
        // Arrange
        when(mockPackageInfo.version).thenThrow(Exception('Package info error'));

        // Act & Assert
        expect(
          () => service.initialize(),
          throwsA(isA<ReleaseManagementException>()),
        );
      });
    });

    group('Version Management', () {
      test('should detect major version upgrade', () async {
        // Arrange
        when(mockPackageInfo.version).thenReturn('2.0.0');
        when(mockPackageInfo.buildNumber).thenReturn('1');
        when(mockPackageInfo.appName).thenReturn('Pandora Notes');
        when(mockPackageInfo.packageName).thenReturn('com.pandora.notes');
        when(mockPrefs.getString('last_known_version')).thenReturn('1.9.0');
        when(mockPrefs.getInt('last_known_build')).thenReturn(0);
        when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
        when(mockPrefs.setInt(any, any)).thenAnswer((_) async => true);
        when(mockPrefs.setBool(any, any)).thenAnswer((_) async => true);

        // Act
        await service.initialize();

        // Assert
        verify(mockPrefs.setBool('major_upgrade_2.0.0', true)).called(1);
      });

      test('should not detect major version upgrade for patch version', () async {
        // Arrange
        when(mockPackageInfo.version).thenReturn('1.0.1');
        when(mockPackageInfo.buildNumber).thenReturn('1');
        when(mockPackageInfo.appName).thenReturn('Pandora Notes');
        when(mockPackageInfo.packageName).thenReturn('com.pandora.notes');
        when(mockPrefs.getString('last_known_version')).thenReturn('1.0.0');
        when(mockPrefs.getInt('last_known_build')).thenReturn(0);
        when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
        when(mockPrefs.setInt(any, any)).thenAnswer((_) async => true);

        // Act
        await service.initialize();

        // Assert
        verifyNever(mockPrefs.setBool(any, any));
      });
    });

    group('Update Checking', () {
      test('should check for updates successfully', () async {
        // Arrange
        when(mockPackageInfo.version).thenReturn('1.0.0');
        when(mockPackageInfo.buildNumber).thenReturn('1');
        when(mockPackageInfo.appName).thenReturn('Pandora Notes');
        when(mockPackageInfo.packageName).thenReturn('com.pandora.notes');
        when(mockPrefs.getString('last_known_version')).thenReturn('1.0.0');
        when(mockPrefs.getInt('last_known_build')).thenReturn(1);
        when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
        when(mockPrefs.setInt(any, any)).thenAnswer((_) async => true);
        when(mockConnectivity.checkConnectivity())
            .thenAnswer((_) async => ConnectivityResult.wifi);

        // Act
        await service.initialize();
        final result = await service.checkForUpdates();

        // Assert
        expect(result.isOnline, isTrue);
        expect(result.hasUpdate, isA<bool>());
      });

      test('should handle offline update check', () async {
        // Arrange
        when(mockPackageInfo.version).thenReturn('1.0.0');
        when(mockPackageInfo.buildNumber).thenReturn('1');
        when(mockPackageInfo.appName).thenReturn('Pandora Notes');
        when(mockPackageInfo.packageName).thenReturn('com.pandora.notes');
        when(mockPrefs.getString('last_known_version')).thenReturn('1.0.0');
        when(mockPrefs.getInt('last_known_build')).thenReturn(1);
        when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
        when(mockPrefs.setInt(any, any)).thenAnswer((_) async => true);
        when(mockConnectivity.checkConnectivity())
            .thenAnswer((_) async => ConnectivityResult.none);

        // Act
        await service.initialize();
        final result = await service.checkForUpdates();

        // Assert
        expect(result.isOnline, isFalse);
        expect(result.hasUpdate, isFalse);
        expect(result.error, equals('No internet connection'));
      });
    });

    group('Release Notes', () {
      test('should get release notes for current version', () async {
        // Arrange
        when(mockPackageInfo.version).thenReturn('1.0.0');
        when(mockPackageInfo.buildNumber).thenReturn('1');
        when(mockPackageInfo.appName).thenReturn('Pandora Notes');
        when(mockPackageInfo.packageName).thenReturn('com.pandora.notes');
        when(mockPrefs.getString('last_known_version')).thenReturn('1.0.0');
        when(mockPrefs.getInt('last_known_build')).thenReturn(1);
        when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
        when(mockPrefs.setInt(any, any)).thenAnswer((_) async => true);

        // Act
        await service.initialize();
        final releaseNotes = await service.getReleaseNotes();

        // Assert
        expect(releaseNotes, isA<String>());
        expect(releaseNotes, contains('1.0.0'));
      });
    });

    group('App Statistics', () {
      test('should get app statistics', () async {
        // Arrange
        when(mockPackageInfo.version).thenReturn('1.0.0');
        when(mockPackageInfo.buildNumber).thenReturn('1');
        when(mockPackageInfo.appName).thenReturn('Pandora Notes');
        when(mockPackageInfo.packageName).thenReturn('com.pandora.notes');
        when(mockPrefs.getString('last_known_version')).thenReturn('1.0.0');
        when(mockPrefs.getInt('last_known_build')).thenReturn(1);
        when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
        when(mockPrefs.setInt(any, any)).thenAnswer((_) async => true);
        when(mockPrefs.getString('install_date')).thenReturn('2024-01-01T00:00:00.000Z');
        when(mockPrefs.getInt('total_sessions')).thenReturn(10);
        when(mockPrefs.getString('last_session_date')).thenReturn('2024-01-01T12:00:00.000Z');
        when(mockPrefs.getBool('is_first_launch')).thenReturn(false);

        // Act
        await service.initialize();
        final stats = await service.getAppStatistics();

        // Assert
        expect(stats.currentVersion, equals('1.0.0'));
        expect(stats.buildNumber, equals('1'));
        expect(stats.totalSessions, equals(10));
        expect(stats.isFirstLaunch, isFalse);
      });
    });

    group('Session Recording', () {
      test('should record app session', () async {
        // Arrange
        when(mockPackageInfo.version).thenReturn('1.0.0');
        when(mockPackageInfo.buildNumber).thenReturn('1');
        when(mockPackageInfo.appName).thenReturn('Pandora Notes');
        when(mockPackageInfo.packageName).thenReturn('com.pandora.notes');
        when(mockPrefs.getString('last_known_version')).thenReturn('1.0.0');
        when(mockPrefs.getInt('last_known_build')).thenReturn(1);
        when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
        when(mockPrefs.setInt(any, any)).thenAnswer((_) async => true);
        when(mockPrefs.getInt('total_sessions')).thenReturn(5);
        when(mockPrefs.setInt('total_sessions', 6)).thenAnswer((_) async => true);
        when(mockPrefs.setString('last_session_date', any)).thenAnswer((_) async => true);
        when(mockPrefs.setBool('is_first_launch', false)).thenAnswer((_) async => true);

        // Act
        await service.initialize();
        await service.recordSession();

        // Assert
        verify(mockPrefs.setInt('total_sessions', 6)).called(1);
        verify(mockPrefs.setString('last_session_date', any)).called(1);
        verify(mockPrefs.setBool('is_first_launch', false)).called(1);
      });
    });

    group('Deployment Configuration', () {
      test('should get deployment configuration', () async {
        // Arrange
        when(mockPackageInfo.version).thenReturn('1.0.0');
        when(mockPackageInfo.buildNumber).thenReturn('1');
        when(mockPackageInfo.appName).thenReturn('Pandora Notes');
        when(mockPackageInfo.packageName).thenReturn('com.pandora.notes');
        when(mockPrefs.getString('last_known_version')).thenReturn('1.0.0');
        when(mockPrefs.getInt('last_known_build')).thenReturn(1);
        when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
        when(mockPrefs.setInt(any, any)).thenAnswer((_) async => true);

        // Act
        await service.initialize();
        final config = service.getDeploymentConfig();

        // Assert
        expect(config.environment, isA<String>());
        expect(config.buildType, isA<String>());
        expect(config.isDebugMode, isA<bool>());
        expect(config.isReleaseMode, isA<bool>());
      });
    });

    group('Error Handling', () {
      test('should handle service not initialized error', () {
        // Act & Assert
        expect(
          () => service.getCurrentVersion(),
          throwsA(isA<ReleaseManagementException>()),
        );
      });

      test('should handle update check error', () async {
        // Arrange
        when(mockPackageInfo.version).thenReturn('1.0.0');
        when(mockPackageInfo.buildNumber).thenReturn('1');
        when(mockPackageInfo.appName).thenReturn('Pandora Notes');
        when(mockPackageInfo.packageName).thenReturn('com.pandora.notes');
        when(mockPrefs.getString('last_known_version')).thenReturn('1.0.0');
        when(mockPrefs.getInt('last_known_build')).thenReturn(1);
        when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
        when(mockPrefs.setInt(any, any)).thenAnswer((_) async => true);
        when(mockConnectivity.checkConnectivity())
            .thenThrow(Exception('Connectivity error'));

        // Act
        await service.initialize();
        final result = await service.checkForUpdates();

        // Assert
        expect(result.error, contains('Failed to check for updates'));
      });
    });

    group('Disposal', () {
      test('should dispose resources properly', () {
        // Act
        service.dispose();

        // Assert
        expect(() => service.getCurrentVersion(), throwsA(isA<ReleaseManagementException>()));
      });
    });
  });
}
