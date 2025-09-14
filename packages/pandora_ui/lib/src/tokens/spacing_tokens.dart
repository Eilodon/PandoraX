/// Pandora 4 Spacing Tokens
/// 
/// Represents the "Hợp" (Harmony) aspect of the design system.
/// These spacing values create rhythm and balance in our UI.
class PandoraSpacing {
  // Private constructor to prevent instantiation
  PandoraSpacing._();

  // Base spacing unit (4px)
  static const double baseUnit = 4.0;

  // Spacing Scale - Based on 4px grid system
  static const double space0 = 0.0;
  static const double space1 = baseUnit * 0.25; // 1px
  static const double space2 = baseUnit * 0.5;  // 2px
  static const double space3 = baseUnit * 0.75; // 3px
  static const double space4 = baseUnit * 1;    // 4px
  static const double space5 = baseUnit * 1.25; // 5px
  static const double space6 = baseUnit * 1.5;  // 6px
  static const double space8 = baseUnit * 2;    // 8px
  static const double space10 = baseUnit * 2.5; // 10px
  static const double space12 = baseUnit * 3;   // 12px
  static const double space16 = baseUnit * 4;   // 16px
  static const double space20 = baseUnit * 5;   // 20px
  static const double space24 = baseUnit * 6;   // 24px
  static const double space28 = baseUnit * 7;   // 28px
  static const double space32 = baseUnit * 8;   // 32px
  static const double space36 = baseUnit * 9;   // 36px
  static const double space40 = baseUnit * 10;  // 40px
  static const double space44 = baseUnit * 11;  // 44px
  static const double space48 = baseUnit * 12;  // 48px
  static const double space52 = baseUnit * 13;  // 52px
  static const double space56 = baseUnit * 14;  // 56px
  static const double space60 = baseUnit * 15;  // 60px
  static const double space64 = baseUnit * 16;  // 64px
  static const double space72 = baseUnit * 18;  // 72px
  static const double space80 = baseUnit * 20;  // 80px
  static const double space96 = baseUnit * 24;  // 96px
  static const double space112 = baseUnit * 28; // 112px
  static const double space128 = baseUnit * 32; // 128px
  static const double space144 = baseUnit * 36; // 144px
  static const double space160 = baseUnit * 40; // 160px
  static const double space176 = baseUnit * 44; // 176px
  static const double space192 = baseUnit * 48; // 192px
  static const double space208 = baseUnit * 52; // 208px
  static const double space224 = baseUnit * 56; // 224px
  static const double space240 = baseUnit * 60; // 240px
  static const double space256 = baseUnit * 64; // 256px
  static const double space288 = baseUnit * 72; // 288px
  static const double space320 = baseUnit * 80; // 320px
  static const double space384 = baseUnit * 96; // 384px
  static const double space448 = baseUnit * 112; // 448px
  static const double space512 = baseUnit * 128; // 512px

  // Semantic Spacing - For specific use cases
  static const double spacingXs = space4;      // 4px - Very tight spacing
  static const double spacingSm = space8;      // 8px - Tight spacing
  static const double spacingMd = space16;     // 16px - Medium spacing
  static const double spacingLg = space24;     // 24px - Loose spacing
  static const double spacingXl = space32;     // 32px - Very loose spacing
  static const double spacing2xl = space48;    // 48px - Extra loose spacing
  static const double spacing3xl = space64;    // 64px - Maximum spacing

  // Component Spacing - For specific components
  static const double buttonPadding = space12;     // Button internal padding
  static const double cardPadding = space16;       // Card internal padding
  static const double inputPadding = space12;      // Input field padding
  static const double sectionSpacing = space32;    // Space between sections
  static const double itemSpacing = space16;       // Space between list items
  static const double groupSpacing = space24;      // Space between groups

  // Layout Spacing - For page layout
  static const double pagePadding = space16;       // Page horizontal padding
  static const double containerPadding = space24;  // Container padding
  static const double headerSpacing = space32;     // Header spacing
  static const double footerSpacing = space32;     // Footer spacing

  // Border Radius - Related to spacing
  static const double radiusXs = space2;       // 2px - Very small radius
  static const double radiusSm = space4;       // 4px - Small radius
  static const double radiusMd = space6;       // 6px - Medium radius
  static const double radiusLg = space8;       // 8px - Large radius
  static const double radiusXl = space12;      // 12px - Very large radius
  static const double radius2xl = space16;     // 16px - Extra large radius
  static const double radius3xl = space24;     // 24px - Maximum radius
  static const double radiusFull = 9999.0;     // Full radius (circular)

  // Icon Sizes - Related to spacing
  static const double iconXs = space12;        // 12px - Extra small icon
  static const double iconSm = space16;        // 16px - Small icon
  static const double iconMd = space20;        // 20px - Medium icon
  static const double iconLg = space24;        // 24px - Large icon
  static const double iconXl = space32;        // 32px - Extra large icon
  static const double icon2xl = space40;       // 40px - Maximum icon

  // Avatar Sizes - Related to spacing
  static const double avatarXs = space24;      // 24px - Extra small avatar
  static const double avatarSm = space32;      // 32px - Small avatar
  static const double avatarMd = space40;      // 40px - Medium avatar
  static const double avatarLg = space48;      // 48px - Large avatar
  static const double avatarXl = space64;      // 64px - Extra large avatar
  static const double avatar2xl = space80;     // 80px - Maximum avatar

  /// Get spacing by semantic name
  static double getSpacing(String semanticName) {
    switch (semanticName) {
      case 'xs':
        return spacingXs;
      case 'sm':
        return spacingSm;
      case 'md':
        return spacingMd;
      case 'lg':
        return spacingLg;
      case 'xl':
        return spacingXl;
      case '2xl':
        return spacing2xl;
      case '3xl':
        return spacing3xl;
      default:
        return spacingMd;
    }
  }

  /// Get radius by semantic name
  static double getRadius(String semanticName) {
    switch (semanticName) {
      case 'xs':
        return radiusXs;
      case 'sm':
        return radiusSm;
      case 'md':
        return radiusMd;
      case 'lg':
        return radiusLg;
      case 'xl':
        return radiusXl;
      case '2xl':
        return radius2xl;
      case '3xl':
        return radius3xl;
      case 'full':
        return radiusFull;
      default:
        return radiusMd;
    }
  }

  /// Get icon size by semantic name
  static double getIconSize(String semanticName) {
    switch (semanticName) {
      case 'xs':
        return iconXs;
      case 'sm':
        return iconSm;
      case 'md':
        return iconMd;
      case 'lg':
        return iconLg;
      case 'xl':
        return iconXl;
      case '2xl':
        return icon2xl;
      default:
        return iconMd;
    }
  }

  /// Get avatar size by semantic name
  static double getAvatarSize(String semanticName) {
    switch (semanticName) {
      case 'xs':
        return avatarXs;
      case 'sm':
        return avatarSm;
      case 'md':
        return avatarMd;
      case 'lg':
        return avatarLg;
      case 'xl':
        return avatarXl;
      case '2xl':
        return avatar2xl;
      default:
        return avatarMd;
    }
  }

  /// Calculate responsive spacing based on screen width
  static double getResponsiveSpacing(double screenWidth, double baseSpacing) {
    if (screenWidth < 600) {
      return baseSpacing * 0.75; // Mobile: 75% of base
    } else if (screenWidth < 900) {
      return baseSpacing; // Tablet: 100% of base
    } else {
      return baseSpacing * 1.25; // Desktop: 125% of base
    }
  }

  /// Get spacing for specific component
  static double getComponentSpacing(String component, String property) {
    switch (component) {
      case 'button':
        switch (property) {
          case 'padding':
            return buttonPadding;
          case 'margin':
            return spacingSm;
          default:
            return buttonPadding;
        }
      case 'card':
        switch (property) {
          case 'padding':
            return cardPadding;
          case 'margin':
            return spacingMd;
          default:
            return cardPadding;
        }
      case 'input':
        switch (property) {
          case 'padding':
            return inputPadding;
          case 'margin':
            return spacingSm;
          default:
            return inputPadding;
        }
      default:
        return spacingMd;
    }
  }
}
