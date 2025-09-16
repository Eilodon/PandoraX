import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logger/logger.dart';

import '../models/device_info.dart';
import '../models/optimization_config.dart';
import '../models/performance_profile.dart';
import 'battery_optimizer.dart';
import 'memory_optimizer.dart';
import 'network_optimizer.dart';
import '../features/offline_manager.dart';
import '../features/gesture_manager.dart';
import '../features/adaptive_ui.dart';
import '../features/power_manager.dart';

/// Main mobile optimization service
class MobileOptimizer {
  static final MobileOptimizer _instance = MobileOptimizer._internal();
  factory MobileOptimizer() => _instance;
  MobileOptimizer._internal();

  static final Logger _logger = Logger();
  
  // Core services
  late BatteryOptimizer _batteryOptimizer;
  late MemoryOptimizer _memoryOptimizer;
  late NetworkOptimizer _networkOptimizer;
  late OfflineManager _offlineManager;
  late GestureManager _gestureManager;
  late AdaptiveUI _adaptiveUI;
  late PowerManager _powerManager;
  
  // Device information
  DeviceInfo? _deviceInfo;
  OptimizationConfig? _config;
  PerformanceProfile? _performanceProfile;
  
  // State
  bool _isInitialized = false;
  bool _isOptimized = false;
  
  // Streams
  final StreamController<OptimizationEvent> _eventController = 
      StreamController.broadcast();
  final StreamController<PerformanceProfile> _profileController = 
      StreamController.broadcast();

  /// Initialize mobile optimization
  Future<void> initialize({
    OptimizationConfig? config,
  }) async {
    if (_isInitialized) return;

    _logger.i('Initializing Mobile Optimizer...');
    
    try {
      // Initialize core services
      _batteryOptimizer = BatteryOptimizer();
      _memoryOptimizer = MemoryOptimizer();
      _networkOptimizer = NetworkOptimizer();
      _offlineManager = OfflineManager();
      _gestureManager = GestureManager();
      _adaptiveUI = AdaptiveUI();
      _powerManager = PowerManager();
      
      // Get device information
      _deviceInfo = await _getDeviceInfo();
      
      // Set configuration
      _config = config ?? OptimizationConfig.defaultConfig();
      
      // Create performance profile
      _performanceProfile = await _createPerformanceProfile();
      
      // Initialize services
      await _initializeServices();
      
      _isInitialized = true;
      _logger.i('Mobile Optimizer initialized successfully');
      
    } catch (e) {
      _logger.e('Failed to initialize Mobile Optimizer: $e');
      rethrow;
    }
  }

  /// Initialize all optimization services
  Future<void> _initializeServices() async {
    // Initialize battery optimization
    await _batteryOptimizer.initialize();
    
    // Initialize memory optimization
    await _memoryOptimizer.initialize();
    
    // Initialize network optimization
    await _networkOptimizer.initialize();
    
    // Initialize offline manager
    await _offlineManager.initialize();
    
    // Initialize gesture manager
    await _gestureManager.initialize();
    
    // Initialize adaptive UI
    await _adaptiveUI.initialize();
    
    // Initialize power manager
    await _powerManager.initialize();
  }

  /// Get device information
  Future<DeviceInfo> _getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final packageInfo = await PackageInfo.fromPlatform();
    
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      return DeviceInfo.android(
        model: androidInfo.model,
        brand: androidInfo.brand,
        version: androidInfo.version.release,
        sdkInt: androidInfo.version.sdkInt,
        appVersion: packageInfo.version,
        buildNumber: packageInfo.buildNumber,
      );
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      return DeviceInfo.ios(
        model: iosInfo.model,
        name: iosInfo.name,
        systemName: iosInfo.systemName,
        systemVersion: iosInfo.systemVersion,
        appVersion: packageInfo.version,
        buildNumber: packageInfo.buildNumber,
      );
    } else {
      return DeviceInfo.unknown(
        appVersion: packageInfo.version,
        buildNumber: packageInfo.buildNumber,
      );
    }
  }

  /// Create performance profile based on device capabilities
  Future<PerformanceProfile> _createPerformanceProfile() async {
    if (_deviceInfo == null) {
      throw StateError('Device info not available');
    }
    
    // Determine performance tier based on device capabilities
    PerformanceTier tier = PerformanceTier.low;
    
    if (_deviceInfo is AndroidDeviceInfo) {
      final androidInfo = _deviceInfo as AndroidDeviceInfo;
      if (androidInfo.version.sdkInt >= 30 && 
          androidInfo.totalMemory != null && 
          androidInfo.totalMemory! > 4 * 1024 * 1024 * 1024) {
        tier = PerformanceTier.high;
      } else if (androidInfo.version.sdkInt >= 26) {
        tier = PerformanceTier.medium;
      }
    } else if (_deviceInfo is IOSDeviceInfo) {
      final iosInfo = _deviceInfo as IOSDeviceInfo;
      if (iosInfo.systemVersion.compareTo('14.0') >= 0) {
        tier = PerformanceTier.high;
      } else if (iosInfo.systemVersion.compareTo('12.0') >= 0) {
        tier = PerformanceTier.medium;
      }
    }
    
    return PerformanceProfile(
      tier: tier,
      deviceInfo: _deviceInfo!,
      config: _config!,
      timestamp: DateTime.now(),
    );
  }

  /// Apply mobile optimizations
  Future<void> optimize() async {
    if (!_isInitialized) {
      throw StateError('Mobile Optimizer not initialized');
    }
    
    if (_isOptimized) return;

    _logger.i('Applying mobile optimizations...');
    
    try {
      // Apply battery optimizations
      await _batteryOptimizer.optimize();
      
      // Apply memory optimizations
      await _memoryOptimizer.optimize();
      
      // Apply network optimizations
      await _networkOptimizer.optimize();
      
      // Enable offline mode
      await _offlineManager.enableOfflineMode();
      
      // Enable gesture recognition
      await _gestureManager.enableGestures();
      
      // Apply adaptive UI
      await _adaptiveUI.applyAdaptiveUI();
      
      // Apply power management
      await _powerManager.optimizePowerUsage();
      
      _isOptimized = true;
      _eventController.add(OptimizationEvent.optimized);
      _logger.i('Mobile optimizations applied successfully');
      
    } catch (e) {
      _logger.e('Failed to apply mobile optimizations: $e');
      _eventController.add(OptimizationEvent.failed(e.toString()));
      rethrow;
    }
  }

  /// Enable offline-first mode
  Future<void> enableOfflineMode() async {
    await _offlineManager.enableOfflineMode();
    _eventController.add(OptimizationEvent.offlineEnabled);
  }

  /// Disable offline mode
  Future<void> disableOfflineMode() async {
    await _offlineManager.disableOfflineMode();
    _eventController.add(OptimizationEvent.offlineDisabled);
  }

  /// Enable advanced gestures
  Future<void> enableAdvancedGestures() async {
    await _gestureManager.enableAdvancedGestures();
    _eventController.add(OptimizationEvent.gesturesEnabled);
  }

  /// Apply adaptive UI based on device capabilities
  Future<void> applyAdaptiveUI() async {
    await _adaptiveUI.applyAdaptiveUI();
    _eventController.add(OptimizationEvent.adaptiveUIApplied);
  }

  /// Optimize for battery life
  Future<void> optimizeBattery() async {
    await _batteryOptimizer.optimize();
    _eventController.add(OptimizationEvent.batteryOptimized);
  }

  /// Optimize memory usage
  Future<void> optimizeMemory() async {
    await _memoryOptimizer.optimize();
    _eventController.add(OptimizationEvent.memoryOptimized);
  }

  /// Get current performance profile
  PerformanceProfile? get performanceProfile => _performanceProfile;

  /// Get device information
  DeviceInfo? get deviceInfo => _deviceInfo;

  /// Get optimization configuration
  OptimizationConfig? get config => _config;

  /// Check if optimizations are applied
  bool get isOptimized => _isOptimized;

  /// Get event stream
  Stream<OptimizationEvent> get eventStream => _eventController.stream;

  /// Get profile stream
  Stream<PerformanceProfile> get profileStream => _profileController.stream;

  /// Dispose resources
  void dispose() {
    _eventController.close();
    _profileController.close();
    _batteryOptimizer.dispose();
    _memoryOptimizer.dispose();
    _networkOptimizer.dispose();
    _offlineManager.dispose();
    _gestureManager.dispose();
    _adaptiveUI.dispose();
    _powerManager.dispose();
  }
}

/// Optimization events
enum OptimizationEvent {
  optimized,
  failed,
  offlineEnabled,
  offlineDisabled,
  gesturesEnabled,
  adaptiveUIApplied,
  batteryOptimized,
  memoryOptimized,
}
