/// Pandora 4 UI Design System
/// 
/// A comprehensive Flutter UI component library that embodies the philosophy
/// of "Thân Tâm Hợp Nhất" (Body and Mind as One) - where design tokens,
/// components, and theming work in perfect harmony.
/// 
/// ## Features
/// 
/// ### 🎨 Design System
/// - **Design Tokens**: Colors, typography, spacing, borders, shadows
/// - **Theme System**: Light and dark themes with Material 3 support
/// - **Consistent API**: Unified naming and parameter patterns
/// 
/// ### 🧩 Components
/// - **Core Components**: Buttons, cards, inputs, containers, snackbars
/// - **Widget Components**: Badges, avatars, chips, progress bars, tooltips
/// - **Specialized Components**: Security cues, result cards with shimmer
/// 
/// ### 🎭 Interactive Features
/// - **Loading States**: Shimmer animations and progress indicators
/// - **Security Integration**: Visual security level indicators
/// - **Accessibility**: Screen reader support and keyboard navigation
/// - **Performance**: Optimized rendering and memory management
/// 
/// ## Quick Start
/// 
/// ```dart
/// import 'package:pandora_ui/pandora_ui.dart';
/// 
/// // Use in your app
/// MaterialApp(
///   theme: createPandoraLightTheme(),
///   darkTheme: createPandoraTheme(),
///   home: MyHomePage(),
/// )
/// 
/// // Use components
/// ResultCard(
///   title: 'AI Summary',
///   subtitle: 'Generated content...',
///   securityCue: SecurityCue(level: SecurityLevel.onDevice),
/// )
/// ```
/// 
/// ## Philosophy
/// 
/// **Thân (Body)**: Physical foundation through consistent design tokens
/// **Tâm (Mind)**: Mental harmony through intuitive user interactions  
/// **Hợp Nhất (Unity)**: Perfect integration of all system components
library pandora_ui;

// ============================================================================
// COMMON ENUMS
// ============================================================================
// Shared enums used across all components for consistency

/// Common enums for consistent component behavior
export 'src/enums/common_enums.dart';

// ============================================================================
// MODERN UTILITIES
// ============================================================================
// Modern Dart utilities using latest language features

/// Modern Dart utilities with sealed classes and pattern matching
export 'src/utils/modern_dart_utils.dart';

// ============================================================================
// MODERN WIDGETS
// ============================================================================
// Modern Flutter widgets using latest patterns

/// Modern Flutter widgets with enhanced features
export 'src/widgets/modern_widgets.dart';

// ============================================================================
// DESIGN TOKENS
// ============================================================================
// Core design tokens for consistent styling across all components

/// Individual token files for granular access
export 'src/tokens/color_tokens.dart';

/// Main design tokens file with unified token system (legacy support)
export 'src/tokens.dart';
export 'src/tokens/typography_tokens.dart';
export 'src/tokens/spacing_tokens.dart';
export 'src/tokens/border_tokens.dart';
export 'src/tokens/shadow_tokens.dart';

// ============================================================================
// THEMING SYSTEM
// ============================================================================
// Comprehensive theming with light/dark mode support

/// Main theme file with createPandoraTheme() and createPandoraLightTheme()
export 'src/theme.dart';

/// Individual theme files for specific implementations
// export 'src/themes/pandora_theme.dart';
// export 'src/themes/light_theme.dart';
// export 'src/themes/dark_theme.dart';

// ============================================================================
// CORE COMPONENTS
// ============================================================================
// Essential UI building blocks following Material Design principles

/// Button components with multiple variants and sizes
export 'src/components/buttons/pandora_button.dart';

/// Card components for content display
export 'src/components/cards/pandora_card.dart';

/// Input components for user data entry
export 'src/components/inputs/pandora_text_field.dart';

/// Layout components for structure and spacing
export 'src/components/layout/pandora_container.dart';

/// Feedback components for user notifications
export 'src/components/feedback/pandora_snackbar.dart';

// ============================================================================
// WIDGET COMPONENTS
// ============================================================================
// Specialized widgets for advanced UI patterns

/// All widget components exported through widgets.dart
export 'src/widgets/widgets.dart';

/// Individual widget exports for direct access:
/// - SecurityCue: Security level indicators
/// - PandoraBadge: Status and category badges
/// - PandoraAvatar: User profile avatars
/// - PandoraDivider: Content separators
/// - PandoraChip: Interactive chips and tags
/// - PandoraProgressBar: Progress indicators
/// - PandoraTooltip: Contextual help tooltips
/// - ResultCard: Dynamic result display with loading states

// ============================================================================
// ACCESSIBILITY SERVICES
// ============================================================================
// Comprehensive accessibility support for inclusive design

/// Accessibility service with screen reader support
export 'src/services/accessibility_service.dart';

/// Accessibility colors with contrast validation
export 'src/services/accessibility_colors.dart';

/// Focus management for keyboard navigation
export 'src/services/focus_management_service.dart';

/// Keyboard navigation service
export 'src/services/keyboard_navigation_service.dart';

// ============================================================================
// RESPONSIVE SERVICES
// ============================================================================
// Advanced responsive design system for mobile-first development

/// Responsive service with breakpoint management
export 'src/services/responsive_service.dart';

/// Touch optimization service for mobile devices
export 'src/services/touch_optimization_service.dart';

/// Mobile optimization service for Phase 2 features
export 'src/services/mobile_optimization_service.dart';

// ============================================================================
// PERFORMANCE OPTIMIZATION SERVICES
// ============================================================================
// Advanced performance optimization services for Phase 3

/// Performance optimization service with animation and memory management
export 'src/services/performance_optimization_service.dart';

/// Memory management service with caching and optimization
export 'src/services/memory_management_service.dart';

/// Animation optimization service with GPU acceleration
export 'src/services/animation_optimization_service.dart';

// ============================================================================
// ACCESSIBLE COMPONENTS
// ============================================================================
// Enhanced components with full accessibility support

/// Accessible button component
export 'src/components/buttons/accessible_pandora_button.dart';

// ============================================================================
// MOBILE-FIRST COMPONENTS
// ============================================================================
// Advanced mobile-first components for Phase 2 development

/// Mobile-first card component with responsive behavior
export 'src/components/mobile/mobile_first_card.dart';

/// Mobile-first text field with touch optimization
export 'src/components/mobile/mobile_first_text_field.dart';

/// Mobile-first navigation with gesture support
export 'src/components/mobile/mobile_first_navigation.dart';

/// Mobile-optimized button component
export 'src/components/mobile/mobile_pandora_button.dart';

// ============================================================================
// PERFORMANCE OPTIMIZED COMPONENTS
// ============================================================================
// High-performance components for Phase 3 optimization

/// Performance optimized card component with advanced optimization
export 'src/components/performance/performance_optimized_card.dart';

// ============================================================================
// UTILITIES
// ============================================================================
// Helper functions and extensions for enhanced development experience

/// Context extensions for easy theme access
export 'src/utils/pandora_extensions.dart';

/// Helper functions for common operations
export 'src/utils/pandora_helpers.dart';

// ============================================================================
// DEMO SYSTEM
// ============================================================================
// Interactive demos and showcases for all components

/// Design tokens showcase with visual examples
export 'src/tokens_demo.dart';

/// Mobile-first demo showcasing Phase 2 features
export 'src/demos/mobile_first_demo.dart';

/// Performance optimization demo showcasing Phase 3 features
export 'src/demos/performance_optimization_demo.dart';

/// Theme system demo with all Material components
// export 'src/theme_demo.dart';

/// Widget components demo with interactive examples
// export 'src/widgets_demo.dart';
