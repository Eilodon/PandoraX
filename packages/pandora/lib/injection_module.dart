import 'package:note_data/note_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:pandora/features/ai/application/ai_service.dart';
import 'package:pandora/config/app_config.dart';
import 'package:pandora/services/analytics_service.dart';
import 'package:pandora/services/performance_service.dart';
import 'package:pandora/services/encryption_service.dart';
import 'package:pandora/services/error_service.dart';

@module
abstract class InjectionModule {
  @singleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  @preResolve
  @singleton
  Future<Isar> get isar => IsarService().db;

  @singleton
  AiService get aiService {
    return AiService(AppConfig.apiKey);
  }

  @singleton
  AnalyticsService get analyticsService => AnalyticsService();

  @singleton
  PerformanceService get performanceService => PerformanceService();

  @singleton
  EncryptionService get encryptionService => EncryptionService();

  @singleton
  ErrorService get errorService => ErrorService();
}
