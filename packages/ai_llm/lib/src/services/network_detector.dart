import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Network detection service
class NetworkDetector {
  final Connectivity _connectivity = Connectivity();
  final List<StreamSubscription> _subscriptions = [];
  
  // Network state
  bool _isConnected = false;
  NetworkType _networkType = NetworkType.none;
  int _signalStrength = 0;
  DateTime _lastCheck = DateTime.now();
  
  // Configuration
  final Duration _checkInterval;
  final Duration _timeout;
  final List<String> _testUrls;
  
  NetworkDetector({
    Duration checkInterval = const Duration(seconds: 30),
    Duration timeout = const Duration(seconds: 10),
    List<String>? testUrls,
  }) : _checkInterval = checkInterval,
       _timeout = timeout,
       _testUrls = testUrls ?? [
         'https://www.google.com',
         'https://www.cloudflare.com',
         'https://www.github.com',
       ];

  /// Initialize network monitoring
  Future<void> initialize() async {
    // Get initial connectivity status
    await _checkConnectivity();
    
    // Start monitoring connectivity changes
    _subscriptions.add(
      _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
        _handleConnectivityChange(result);
      }),
    );
    
    // Start periodic connectivity checks
    _startPeriodicChecks();
  }

  /// Get current connection status
  Future<bool> get isConnected async {
    // Return cached result if recent (within 5 seconds)
    if (DateTime.now().difference(_lastCheck).inSeconds < 5) {
      return _isConnected;
    }
    
    // Perform fresh check
    await _checkConnectivity();
    return _isConnected;
  }

  /// Get current network type
  NetworkType get networkType => _networkType;

  /// Get signal strength (0-100)
  int get signalStrength => _signalStrength;

  /// Get network quality score (0-100)
  Future<int> getNetworkQuality() async {
    if (!_isConnected) {
      return 0;
    }
    
    try {
      final latency = await _measureLatency();
      final bandwidth = await _measureBandwidth();
      
      // Calculate quality score based on latency and bandwidth
      int score = 100;
      
      // Latency penalty
      if (latency > 1000) {
        score -= 40; // High latency
      } else if (latency > 500) {
        score -= 20; // Medium latency
      } else if (latency > 200) {
        score -= 10; // Low latency
      }
      
      // Bandwidth penalty
      if (bandwidth < 1000) { // Less than 1 Mbps
        score -= 30; // Low bandwidth
      } else if (bandwidth < 5000) { // Less than 5 Mbps
        score -= 15; // Medium bandwidth
      }
      
      // Network type bonus
      switch (_networkType) {
        case NetworkType.wifi:
          score += 10;
          break;
        case NetworkType.mobile:
          score += 5;
          break;
        case NetworkType.ethernet:
          score += 15;
          break;
        case NetworkType.none:
          score = 0;
          break;
      }
      
      return score.clamp(0, 100);
    } catch (e) {
      return 50; // Default score if measurement fails
    }
  }

  /// Check if network is suitable for AI operations
  Future<bool> isSuitableForAI() async {
    if (!_isConnected) {
      return false;
    }
    
    final quality = await getNetworkQuality();
    return quality >= 30; // Minimum quality threshold
  }

  /// Get network statistics
  NetworkStatistics getStatistics() {
    return NetworkStatistics(
      isConnected: _isConnected,
      networkType: _networkType,
      signalStrength: _signalStrength,
      lastCheck: _lastCheck,
    );
  }

  /// Test connectivity to specific URL
  Future<bool> testConnectivity(String url) async {
    try {
      final uri = Uri.parse(url);
      final client = HttpClient();
      client.connectionTimeout = _timeout;
      
      final request = await client.getUrl(uri);
      final response = await request.close();
      
      client.close();
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  /// Dispose resources
  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    _subscriptions.clear();
  }

  // Private methods

  Future<void> _checkConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      await _handleConnectivityChange(result);
    } catch (e) {
      _isConnected = false;
      _networkType = NetworkType.none;
    }
  }

  Future<void> _handleConnectivityChange(ConnectivityResult result) async {
    _lastCheck = DateTime.now();
    
    switch (result) {
      case ConnectivityResult.wifi:
        _networkType = NetworkType.wifi;
        _isConnected = await _verifyConnection();
        _signalStrength = await _getWifiSignalStrength();
        break;
      case ConnectivityResult.mobile:
        _networkType = NetworkType.mobile;
        _isConnected = await _verifyConnection();
        _signalStrength = await _getMobileSignalStrength();
        break;
      case ConnectivityResult.ethernet:
        _networkType = NetworkType.ethernet;
        _isConnected = await _verifyConnection();
        _signalStrength = 100; // Ethernet is always strong
        break;
      case ConnectivityResult.none:
        _networkType = NetworkType.none;
        _isConnected = false;
        _signalStrength = 0;
        break;
      case ConnectivityResult.bluetooth:
        _networkType = NetworkType.bluetooth;
        _isConnected = await _verifyConnection();
        _signalStrength = 50; // Bluetooth is medium strength
        break;
      case ConnectivityResult.vpn:
        _networkType = NetworkType.vpn;
        _isConnected = await _verifyConnection();
        _signalStrength = 75; // VPN is usually good
        break;
      case ConnectivityResult.other:
        _networkType = NetworkType.other;
        _isConnected = await _verifyConnection();
        _signalStrength = 50; // Unknown strength
        break;
    }
  }

  Future<bool> _verifyConnection() async {
    // Test connectivity to multiple URLs
    for (final url in _testUrls) {
      if (await testConnectivity(url)) {
        return true;
      }
    }
    return false;
  }

  Future<int> _getWifiSignalStrength() async {
    // This would typically use platform-specific APIs
    // For now, return a mock value
    return 75; // Mock signal strength
  }

  Future<int> _getMobileSignalStrength() async {
    // This would typically use platform-specific APIs
    // For now, return a mock value
    return 60; // Mock signal strength
  }

  Future<int> _measureLatency() async {
    try {
      final stopwatch = Stopwatch()..start();
      await testConnectivity(_testUrls.first);
      stopwatch.stop();
      return stopwatch.elapsedMilliseconds;
    } catch (e) {
      return 1000; // High latency if test fails
    }
  }

  Future<int> _measureBandwidth() async {
    try {
      // This would typically download a test file and measure speed
      // For now, return a mock value based on network type
      switch (_networkType) {
        case NetworkType.wifi:
          return 10000; // 10 Mbps
        case NetworkType.mobile:
          return 5000; // 5 Mbps
        case NetworkType.ethernet:
          return 100000; // 100 Mbps
        default:
          return 1000; // 1 Mbps
      }
    } catch (e) {
      return 1000; // Default bandwidth
    }
  }

  void _startPeriodicChecks() {
    Timer.periodic(_checkInterval, (timer) async {
      await _checkConnectivity();
    });
  }
}

/// Network type enumeration
enum NetworkType {
  none,
  wifi,
  mobile,
  ethernet,
  bluetooth,
  vpn,
  other,
}

/// Network statistics
class NetworkStatistics {
  final bool isConnected;
  final NetworkType networkType;
  final int signalStrength;
  final DateTime lastCheck;

  const NetworkStatistics({
    required this.isConnected,
    required this.networkType,
    required this.signalStrength,
    required this.lastCheck,
  });

  @override
  String toString() {
    return 'NetworkStatistics(isConnected: $isConnected, networkType: $networkType, signalStrength: $signalStrength, lastCheck: $lastCheck)';
  }
}
