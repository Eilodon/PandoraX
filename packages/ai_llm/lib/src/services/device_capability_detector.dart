import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import '../services/ai_router_service.dart';

/// Device capability detection service
class DeviceCapabilityDetector {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  DeviceCapability? _cachedCapability;
  DateTime? _lastDetection;

  /// Get device capability with caching
  Future<DeviceCapability> getCapability() async {
    // Return cached result if recent (within 5 minutes)
    if (_cachedCapability != null && 
        _lastDetection != null && 
        DateTime.now().difference(_lastDetection!).inMinutes < 5) {
      return _cachedCapability!;
    }

    try {
      final capability = await _detectCapability();
      _cachedCapability = capability;
      _lastDetection = DateTime.now();
      return capability;
    } catch (e) {
      // Return default capability if detection fails
      return _getDefaultCapability();
    }
  }

  /// Force refresh device capability
  Future<DeviceCapability> refreshCapability() async {
    _cachedCapability = null;
    _lastDetection = null;
    return await getCapability();
  }

  /// Get detailed device information
  Future<DetailedDeviceInfo> getDetailedInfo() async {
    try {
      if (Platform.isAndroid) {
        return await _getAndroidInfo();
      } else if (Platform.isIOS) {
        return await _getIOSInfo();
      } else if (Platform.isWindows) {
        return await _getWindowsInfo();
      } else if (Platform.isMacOS) {
        return await _getMacOSInfo();
      } else if (Platform.isLinux) {
        return await _getLinuxInfo();
      } else {
        return _getUnknownInfo();
      }
    } catch (e) {
      return _getUnknownInfo();
    }
  }

  /// Check if device can handle a specific model
  Future<bool> canHandleModel(ModelLevel level) async {
    final capability = await getCapability();
    return level.sizeBytes <= capability.maxModelSize;
  }

  /// Get recommended model levels for this device
  Future<List<ModelLevel>> getRecommendedModelLevels() async {
    final capability = await getCapability();
    final recommendations = <ModelLevel>[];
    
    if (capability.ramGB >= 6 && capability.storageGB >= 5) {
      recommendations.addAll([ModelLevel.full, ModelLevel.mini, ModelLevel.tiny]);
    } else if (capability.ramGB >= 4 && capability.storageGB >= 2) {
      recommendations.addAll([ModelLevel.mini, ModelLevel.tiny]);
    } else {
      recommendations.add(ModelLevel.tiny);
    }
    
    return recommendations;
  }

  /// Get device performance score (0-100)
  Future<int> getPerformanceScore() async {
    final capability = await getCapability();
    int score = 0;
    
    // RAM score (0-40 points)
    if (capability.ramGB >= 8) {
      score += 40;
    } else if (capability.ramGB >= 6) {
      score += 30;
    } else if (capability.ramGB >= 4) {
      score += 20;
    } else if (capability.ramGB >= 2) {
      score += 10;
    }
    
    // Storage score (0-20 points)
    if (capability.storageGB >= 10) {
      score += 20;
    } else if (capability.storageGB >= 5) {
      score += 15;
    } else if (capability.storageGB >= 2) {
      score += 10;
    } else if (capability.storageGB >= 1) {
      score += 5;
    }
    
    // CPU score (0-20 points)
    if (capability.cpuCores >= 8) {
      score += 20;
    } else if (capability.cpuCores >= 4) {
      score += 15;
    } else if (capability.cpuCores >= 2) {
      score += 10;
    } else {
      score += 5;
    }
    
    // GPU score (0-20 points)
    if (capability.hasGpu) {
      score += 20;
    } else {
      score += 5;
    }
    
    return score.clamp(0, 100);
  }

  // Private methods

  Future<DeviceCapability> _detectCapability() async {
    if (Platform.isAndroid) {
      return await _detectAndroidCapability();
    } else if (Platform.isIOS) {
      return await _detectIOSCapability();
    } else if (Platform.isWindows) {
      return await _detectWindowsCapability();
    } else if (Platform.isMacOS) {
      return await _detectMacOSCapability();
    } else if (Platform.isLinux) {
      return await _detectLinuxCapability();
    } else {
      return _getDefaultCapability();
    }
  }

  Future<DeviceCapability> _detectAndroidCapability() async {
    final androidInfo = await _deviceInfo.androidInfo;
    
    // Parse RAM from system properties
    final ramGB = _parseRamFromAndroid(androidInfo);
    
    // Get storage space
    final storageGB = await _getStorageSpace();
    
    // Get CPU cores
    final cpuCores = androidInfo.systemFeatures.contains('android.hardware.cpu') 
        ? Platform.numberOfProcessors 
        : 2;
    
    // Check for GPU
    final hasGpu = androidInfo.systemFeatures.contains('android.hardware.opengles.aep');
    
    // Calculate max model size (conservative estimate)
    final maxModelSize = _calculateMaxModelSize(ramGB, storageGB, hasGpu);
    
    return DeviceCapability(
      ramGB: ramGB,
      storageGB: storageGB,
      cpuCores: cpuCores,
      hasGpu: hasGpu,
      maxModelSize: maxModelSize,
    );
  }

  Future<DeviceCapability> _detectIOSCapability() async {
    final iosInfo = await _deviceInfo.iosInfo;
    
    // Parse RAM from device model
    final ramGB = _parseRamFromIOS(iosInfo);
    
    // Get storage space
    final storageGB = await _getStorageSpace();
    
    // Get CPU cores
    final cpuCores = Platform.numberOfProcessors;
    
    // iOS devices generally have GPU
    final hasGpu = true;
    
    // Calculate max model size
    final maxModelSize = _calculateMaxModelSize(ramGB, storageGB, hasGpu);
    
    return DeviceCapability(
      ramGB: ramGB,
      storageGB: storageGB,
      cpuCores: cpuCores,
      hasGpu: hasGpu,
      maxModelSize: maxModelSize,
    );
  }

  Future<DeviceCapability> _detectWindowsCapability() async {
    final windowsInfo = await _deviceInfo.windowsInfo;
    
    // Parse RAM from system memory
    final ramGB = _parseRamFromWindows(windowsInfo);
    
    // Get storage space
    final storageGB = await _getStorageSpace();
    
    // Get CPU cores
    final cpuCores = Platform.numberOfProcessors;
    
    // Assume GPU available on Windows
    final hasGpu = true;
    
    // Calculate max model size
    final maxModelSize = _calculateMaxModelSize(ramGB, storageGB, hasGpu);
    
    return DeviceCapability(
      ramGB: ramGB,
      storageGB: storageGB,
      cpuCores: cpuCores,
      hasGpu: hasGpu,
      maxModelSize: maxModelSize,
    );
  }

  Future<DeviceCapability> _detectMacOSCapability() async {
    final macosInfo = await _deviceInfo.macOSInfo;
    
    // Parse RAM from system memory
    final ramGB = _parseRamFromMacOS(macosInfo);
    
    // Get storage space
    final storageGB = await _getStorageSpace();
    
    // Get CPU cores
    final cpuCores = Platform.numberOfProcessors;
    
    // MacOS generally has GPU
    final hasGpu = true;
    
    // Calculate max model size
    final maxModelSize = _calculateMaxModelSize(ramGB, storageGB, hasGpu);
    
    return DeviceCapability(
      ramGB: ramGB,
      storageGB: storageGB,
      cpuCores: cpuCores,
      hasGpu: hasGpu,
      maxModelSize: maxModelSize,
    );
  }

  Future<DeviceCapability> _detectLinuxCapability() async {
    // Linux detection is more complex, use system info
    final ramGB = _parseRamFromLinux();
    final storageGB = await _getStorageSpace();
    final cpuCores = Platform.numberOfProcessors;
    final hasGpu = _detectGpuOnLinux();
    
    final maxModelSize = _calculateMaxModelSize(ramGB, storageGB, hasGpu);
    
    return DeviceCapability(
      ramGB: ramGB,
      storageGB: storageGB,
      cpuCores: cpuCores,
      hasGpu: hasGpu,
      maxModelSize: maxModelSize,
    );
  }

  int _parseRamFromAndroid(dynamic androidInfo) {
    // This would parse RAM from Android system properties
    // For now, return estimated values based on device model
    return 4; // Default estimate
  }

  int _parseRamFromIOS(dynamic iosInfo) {
    // Parse RAM based on iOS device model
    // This would need device-specific mapping
    return 4; // Default estimate
  }

  int _parseRamFromWindows(dynamic windowsInfo) {
    // Parse RAM from Windows system info
    return 8; // Default estimate
  }

  int _parseRamFromMacOS(dynamic macosInfo) {
    // Parse RAM from macOS system info
    return 8; // Default estimate
  }

  int _parseRamFromLinux() {
    // Parse RAM from /proc/meminfo
    return 8; // Default estimate
  }

  Future<int> _getStorageSpace() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      // This would get actual available space
      // For now, return estimated value
      return 10; // 10GB default
    } catch (e) {
      return 5; // Fallback
    }
  }

  bool _detectGpuOnLinux() {
    // This would check for GPU drivers and capabilities
    return true; // Default assumption
  }

  int _calculateMaxModelSize(int ramGB, int storageGB, bool hasGpu) {
    // Conservative calculation based on available resources
    final ramBytes = ramGB * 1024 * 1024 * 1024;
    final storageBytes = storageGB * 1024 * 1024 * 1024;
    
    // Use 50% of available RAM or 20% of storage, whichever is smaller
    final ramLimit = (ramBytes * 0.5).round();
    final storageLimit = (storageBytes * 0.2).round();
    
    return ramLimit < storageLimit ? ramLimit : storageLimit;
  }

  DeviceCapability _getDefaultCapability() {
    return DeviceCapability(
      ramGB: 4,
      storageGB: 8,
      cpuCores: 4,
      hasGpu: false,
      maxModelSize: 200 * 1024 * 1024, // 200MB
    );
  }

  Future<DetailedDeviceInfo> _getAndroidInfo() async {
    final androidInfo = await _deviceInfo.androidInfo;
    return DetailedDeviceInfo(
      platform: 'Android',
      model: androidInfo.model,
      manufacturer: androidInfo.manufacturer,
      version: androidInfo.version.release,
      architecture: androidInfo.supportedAbis.join(', '),
      features: androidInfo.systemFeatures,
    );
  }

  Future<DetailedDeviceInfo> _getIOSInfo() async {
    final iosInfo = await _deviceInfo.iosInfo;
    return DetailedDeviceInfo(
      platform: 'iOS',
      model: iosInfo.model,
      manufacturer: 'Apple',
      version: iosInfo.systemVersion,
      architecture: iosInfo.utsname.machine,
      features: [],
    );
  }

  Future<DetailedDeviceInfo> _getWindowsInfo() async {
    final windowsInfo = await _deviceInfo.windowsInfo;
    return DetailedDeviceInfo(
      platform: 'Windows',
      model: windowsInfo.computerName,
      manufacturer: 'Microsoft',
      version: windowsInfo.displayVersion,
      architecture: windowsInfo.systemMemoryInMegabytes.toString(),
      features: [],
    );
  }

  Future<DetailedDeviceInfo> _getMacOSInfo() async {
    final macosInfo = await _deviceInfo.macOSInfo;
    return DetailedDeviceInfo(
      platform: 'macOS',
      model: macosInfo.model,
      manufacturer: 'Apple',
      version: macosInfo.osRelease,
      architecture: macosInfo.arch,
      features: [],
    );
  }

  Future<DetailedDeviceInfo> _getLinuxInfo() async {
    return DetailedDeviceInfo(
      platform: 'Linux',
      model: 'Unknown',
      manufacturer: 'Unknown',
      version: 'Unknown',
      architecture: Platform.operatingSystem,
      features: [],
    );
  }

  DetailedDeviceInfo _getUnknownInfo() {
    return DetailedDeviceInfo(
      platform: 'Unknown',
      model: 'Unknown',
      manufacturer: 'Unknown',
      version: 'Unknown',
      architecture: 'Unknown',
      features: [],
    );
  }
}

/// Detailed device information
class DetailedDeviceInfo {
  final String platform;
  final String model;
  final String manufacturer;
  final String version;
  final String architecture;
  final List<String> features;

  const DetailedDeviceInfo({
    required this.platform,
    required this.model,
    required this.manufacturer,
    required this.version,
    required this.architecture,
    required this.features,
  });

  @override
  String toString() {
    return 'DetailedDeviceInfo(platform: $platform, model: $model, manufacturer: $manufacturer, version: $version, architecture: $architecture)';
  }
}
