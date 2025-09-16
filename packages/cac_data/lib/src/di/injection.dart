import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:cac_core/cac_core.dart';
import '../datasources/isar_memory_datasource.dart';
import '../datasources/vector_search_datasource.dart';
import '../repositories/memory_repository_impl.dart';
import '../services/event_bus_service_impl.dart';
import '../services/isar_write_queue_service.dart';
import '../services/nightly_analysis_service.dart';

part 'injection.config.dart';

@InjectableInit()
Future<void> configureDependencies() async {
  final getIt = GetIt.instance;
  
  // Initialize datasources
  final isarDatasource = IsarMemoryDatasource();
  await isarDatasource.initialize();
  getIt.registerSingleton<IsarMemoryDatasource>(isarDatasource);
  
  // Register other dependencies
  getIt.init();
}
