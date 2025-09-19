# Legacy Services Archive

This folder contains archived service files that have been consolidated into unified services to eliminate duplication and improve maintainability.

## Archived Service Files:

### Sync Services:
- **sync_service.dart** - Development sync service with WorkManager
- **sync_service_production.dart** - Production sync service with Firestore
- **Consolidated into:** `lib/services/unified_sync_service.dart`

### Error Services:
- **error_service.dart** - Basic error handling service
- **production_error_service.dart** - Production error service with Crashlytics
- **error_recovery_service.dart** - Error recovery utilities
- **Consolidated into:** `lib/services/unified_error_service.dart`

### Performance Services:
- **performance_service.dart** - Basic performance monitoring
- **performance_optimization_service.dart** - Production performance optimization
- **performance_monitor.dart** - Performance monitoring utilities
- **Consolidated into:** `lib/services/unified_performance_service.dart`

## Why Consolidated:

These services were causing:
- **Duplication**: Multiple services with overlapping functionality
- **Confusion**: Unclear which service to use in different contexts
- **Maintenance overhead**: Multiple files to update for similar functionality
- **Build conflicts**: Potential dependency injection conflicts

## Benefits of Unified Services:

1. **Single Source of Truth**: One service per domain
2. **Environment Flexibility**: Supports both development and production modes
3. **Reduced Complexity**: Fewer files to maintain
4. **Better Testing**: Easier to test consolidated functionality
5. **Consistent API**: Unified interface across environments

## Migration Guide:

If you need to reference any specific implementation from these archived files:

1. **For Sync**: Use `UnifiedSyncService` with appropriate mode
2. **For Errors**: Use `UnifiedErrorService` with production flag
3. **For Performance**: Use `UnifiedPerformanceService` with production mode

The unified services provide all functionality from the original services with improved consistency and maintainability.