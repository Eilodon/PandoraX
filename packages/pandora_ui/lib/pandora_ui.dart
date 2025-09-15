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

/// Theme system demo with all Material components
// export 'src/theme_demo.dart';

/// Widget components demo with interactive examples
// export 'src/widgets_demo.dart';
