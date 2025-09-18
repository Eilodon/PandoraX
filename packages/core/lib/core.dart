/// Core Package for Phase 4 Architecture
/// 
/// This package contains core functionality shared across the entire application.
/// It provides a clean separation of concerns and simplified architecture.
library core;

// ============================================================================
// DESIGN SYSTEM
// ============================================================================
// Core design system components and tokens

/// Design tokens for consistent styling
export 'src/design_system/design_tokens.dart';

/// Theme management
export 'src/design_system/theme_manager.dart';

/// Color system
export 'src/design_system/color_system.dart';

/// Typography system
export 'src/design_system/typography_system.dart';

/// Spacing system
export 'src/design_system/spacing_system.dart';

// ============================================================================
// STATE MANAGEMENT
// ============================================================================
// Simplified state management utilities

/// State management utilities
export 'src/state_management/state_utils.dart';

/// State persistence
export 'src/state_management/state_persistence.dart';

/// State validation
export 'src/state_management/state_validation.dart';

// ============================================================================
// UTILITIES
// ============================================================================
// Common utilities and helpers

/// Common utilities
export 'src/utils/common_utils.dart';

/// Date and time utilities
export 'src/utils/date_utils.dart';

/// String utilities
export 'src/utils/string_utils.dart';

/// Validation utilities
export 'src/utils/validation_utils.dart';

/// File utilities
export 'src/utils/file_utils.dart';

// ============================================================================
// SERVICES
// ============================================================================
// Core services for the application

/// Logging service
export 'src/services/logging_service.dart';

/// Error handling service
export 'src/services/error_handling_service.dart';

/// Configuration service
export 'src/services/configuration_service.dart';

/// Storage service
export 'src/services/storage_service.dart';

// ============================================================================
// PHASE 5 ADVANCED UX SERVICES
// ============================================================================
// Advanced UX services for Phase 5

/// Micro-interaction service with haptic feedback and sound effects
export 'src/services/micro_interaction_service.dart';

/// Advanced animation service with staggered and morphing animations
export 'src/services/advanced_animation_service.dart';

/// Smart UX service with predictive loading and contextual help
export 'src/services/smart_ux_service.dart';

/// Personalization service with user preference learning
export 'src/services/personalization_service.dart';

/// Gesture system for advanced touch interactions
export 'src/services/gesture_system.dart';

// ============================================================================
// PHASE 6 ANALYTICS & OPTIMIZATION SERVICES
// ============================================================================
// Analytics and optimization services for Phase 6

/// Advanced analytics service with comprehensive data collection
export 'src/services/analytics_service.dart';

/// A/B testing service for feature experimentation
export 'src/services/ab_testing_service.dart';

/// Performance monitoring service with real-time metrics
export 'src/services/performance_monitoring_service.dart';

/// User journey mapping service for flow analysis
export 'src/services/user_journey_service.dart';

/// Optimization engine with intelligent recommendations
export 'src/services/optimization_engine.dart';

// ============================================================================
// CONSTANTS
// ============================================================================
// Application constants

/// App constants
export 'src/constants/app_constants.dart';

/// API constants
export 'src/constants/api_constants.dart';

/// UI constants
export 'src/constants/ui_constants.dart';

// ============================================================================
// EXTENSIONS
// ============================================================================
// Dart extensions for enhanced functionality

/// Common extensions
export 'src/extensions/common_extensions.dart';

/// Widget extensions
export 'src/extensions/widget_extensions.dart';

/// String extensions
export 'src/extensions/string_extensions.dart';

/// DateTime extensions
export 'src/extensions/datetime_extensions.dart';

// ============================================================================
// PHASE 5 ANIMATION COMPONENTS
// ============================================================================
// Advanced animation components for Phase 5

/// Animation components with performance optimization
export 'src/components/animation_components.dart';

// ============================================================================
// PHASE 6 ANALYTICS COMPONENTS
// ============================================================================
// Analytics and optimization components for Phase 6

/// Analytics dashboard with comprehensive insights
export 'src/components/analytics_dashboard.dart';

// ============================================================================
// CAC INTEGRATION SERVICES
// ============================================================================
// Services that extend CAC capabilities

/// Computer Vision service for image analysis (CAC extension)
export 'src/services/computer_vision_service.dart';

/// Predictive Analytics service for forecasting (CAC extension)
export 'src/services/predictive_analytics_service.dart';
