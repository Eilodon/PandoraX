/// Core utilities package for PandoraX
///
/// This package contains all the core utilities, services, and helpers
/// used across the entire application.
library core_utils;

// Services
export 'services/logger.dart';
export 'services/dependency_injection.dart';
export 'services/encryption_service.dart';
export 'services/analytics_service.dart';
export 'services/firebase_service.dart';
export 'services/security_service.dart';

// Re-export common dependencies
export 'package:get_it/get_it.dart';
export 'package:logger/logger.dart';
export 'package:shared_preferences/shared_preferences.dart';
export 'package:path_provider/path_provider.dart';
export 'package:connectivity_plus/connectivity_plus.dart';
export 'package:device_info_plus/device_info_plus.dart';
export 'package:permission_handler/permission_handler.dart';
export 'package:crypto/crypto.dart';
export 'package:encrypt/encrypt.dart';
export 'package:intl/intl.dart';
export 'package:uuid/uuid.dart';
