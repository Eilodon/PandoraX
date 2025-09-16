import 'dart:io';
import 'package:flutter/foundation.dart';

class DeviceCapabilityDetector {
  static final DeviceCapabilityDetector _instance = DeviceCapabilityDetector._internal();
  factory DeviceCapabilityDetector() => _instance;
  DeviceCapabilityDetector._internal();

  Future<DeviceCapability> detectCapability() async {
    if (kIsWeb) {
      return _detectWebCapability();
    } else if (Platform.isAndroid) {
      return _detectAndroidCapability();
    } else if (Platform.isIOS) {
      return _detectIOSCapability();
    } else {
      return _detectDesktopCapability();
    }
  }

  DeviceCapability _detectWebCapability() {
    return DeviceCapability(
      maxMemoryGB: 4,
      availableStorageGB: 8,
      processingPower: ProcessingPower.medium,
      supportedModels: [ModelLevel.light, ModelLevel.medium],
    );
  }

  DeviceCapability _detectAndroidCapability() {
    // Mock Android capability detection
    return DeviceCapability(
      maxMemoryGB: 8,
      availableStorageGB: 16,
      processingPower: ProcessingPower.high,
      supportedModels: [ModelLevel.light, ModelLevel.medium, ModelLevel.heavy],
    );
  }

  DeviceCapability _detectIOSCapability() {
    // Mock iOS capability detection
    return DeviceCapability(
      maxMemoryGB: 6,
      availableStorageGB: 12,
      processingPower: ProcessingPower.high,
      supportedModels: [ModelLevel.light, ModelLevel.medium],
    );
  }

  DeviceCapability _detectDesktopCapability() {
    return DeviceCapability(
      maxMemoryGB: 16,
      availableStorageGB: 32,
      processingPower: ProcessingPower.high,
      supportedModels: [ModelLevel.light, ModelLevel.medium, ModelLevel.heavy],
    );
  }
}

class DeviceCapability {
  final int maxMemoryGB;
  final int availableStorageGB;
  final ProcessingPower processingPower;
  final List<ModelLevel> supportedModels;
  final int ramGB;
  final int storageGB;
  final int cpuCores;
  final bool hasGpu;
  final int maxModelSize;

  const DeviceCapability({
    required this.maxMemoryGB,
    required this.availableStorageGB,
    required this.processingPower,
    required this.supportedModels,
    this.ramGB = 4,
    this.storageGB = 8,
    this.cpuCores = 4,
    this.hasGpu = false,
    this.maxModelSize = 200000000,
  });
}

enum ProcessingPower { low, medium, high }

class ModelLevel {
  static const ModelLevel light = ModelLevel._('light');
  static const ModelLevel medium = ModelLevel._('medium');
  static const ModelLevel heavy = ModelLevel._('heavy');

  const ModelLevel._(this.value);
  final String value;

  static const List<ModelLevel> values = [light, medium, heavy];
  
  static List<ModelLevel> get values => [light, medium, heavy];

  IconData get icon {
    switch (this) {
      case light:
        return Icons.flash_on;
      case medium:
        return Icons.battery_6_bar;
      case heavy:
        return Icons.battery_full;
    }
  }

  Color get color {
    switch (this) {
      case light:
        return Colors.green;
      case medium:
        return Colors.orange;
      case heavy:
        return Colors.red;
    }
  }
}
