import 'package:flutter/material.dart';
import '../services/responsive_service.dart';
import '../services/touch_optimization_service.dart';
import '../services/accessibility_service.dart';

/// Mobile Navigation System
/// 
/// Comprehensive navigation patterns optimized for mobile devices
class MobileNavigation extends StatefulWidget {
  const MobileNavigation({
    super.key,
    required this.items,
    this.currentIndex = 0,
    this.onTap,
    this.type = MobileNavigationType.bottomBar,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.iconSize = 24.0,
    this.selectedFontSize = 12.0,
    this.unselectedFontSize = 12.0,
    this.elevation = 8.0,
    this.showLabels = true,
    this.showSelectedLabels = true,
    this.showUnselectedLabels = false,
  });

  final List<MobileNavigationItem> items;
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final MobileNavigationType type;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double iconSize;
  final double selectedFontSize;
  final double unselectedFontSize;
  final double elevation;
  final bool showLabels;
  final bool showSelectedLabels;
  final bool showUnselectedLabels;

  @override
  State<MobileNavigation> createState() => _MobileNavigationState();
}

class _MobileNavigationState extends State<MobileNavigation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsiveSize = ResponsiveService.getResponsiveSizeFromContext(context);
    
    switch (widget.type) {
      case MobileNavigationType.bottomBar:
        return _buildBottomNavigationBar(responsiveSize);
      case MobileNavigationType.drawer:
        return _buildDrawer(responsiveSize);
      case MobileNavigationType.tabBar:
        return _buildTabBar(responsiveSize);
      case MobileNavigationType.floating:
        return _buildFloatingNavigation(responsiveSize);
    }
  }

  Widget _buildBottomNavigationBar(ResponsiveSize responsiveSize) {
    final responsiveIconSize = ResponsiveService.getResponsiveIconSize(
      widget.iconSize,
      responsiveSize,
    );
    final responsiveFontSize = ResponsiveService.getResponsiveFontSize(
      widget.selectedFontSize,
      responsiveSize,
    );

    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: (index) {
        _handleTap(index);
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: widget.backgroundColor,
      selectedItemColor: widget.selectedItemColor,
      unselectedItemColor: widget.unselectedItemColor,
      iconSize: responsiveIconSize,
      selectedFontSize: responsiveFontSize,
      unselectedFontSize: responsiveFontSize * 0.9,
      elevation: widget.elevation,
      showSelectedLabels: widget.showSelectedLabels,
      showUnselectedLabels: widget.showUnselectedLabels,
      items: widget.items.map((item) => BottomNavigationBarItem(
        icon: _buildIcon(item, false, responsiveSize),
        activeIcon: _buildIcon(item, true, responsiveSize),
        label: widget.showLabels ? item.label : null,
      )).toList(),
    );
  }

  Widget _buildDrawer(ResponsiveSize responsiveSize) {
    return Drawer(
      backgroundColor: widget.backgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildDrawerHeader(responsiveSize),
          ...widget.items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isSelected = index == widget.currentIndex;
            
            return ListTile(
              leading: _buildIcon(item, isSelected, responsiveSize),
              title: Text(
                item.label,
                style: TextStyle(
                  color: isSelected ? widget.selectedItemColor : widget.unselectedItemColor,
                  fontSize: ResponsiveService.getResponsiveFontSize(
                    isSelected ? widget.selectedFontSize : widget.unselectedFontSize,
                    responsiveSize,
                  ),
                ),
              ),
              selected: isSelected,
              onTap: () => _handleTap(index),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTabBar(ResponsiveSize responsiveSize) {
    return TabBar(
      controller: TabController(
        length: widget.items.length,
        initialIndex: widget.currentIndex,
        vsync: this,
      ),
      onTap: (index) => _handleTap(index),
      labelColor: widget.selectedItemColor,
      unselectedLabelColor: widget.unselectedItemColor,
      labelStyle: TextStyle(
        fontSize: ResponsiveService.getResponsiveFontSize(
          widget.selectedFontSize,
          responsiveSize,
        ),
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: ResponsiveService.getResponsiveFontSize(
          widget.unselectedFontSize,
          responsiveSize,
        ),
      ),
      indicatorColor: widget.selectedItemColor,
      tabs: widget.items.map((item) => Tab(
        icon: _buildIcon(item, false, responsiveSize),
        text: widget.showLabels ? item.label : null,
      )).toList(),
    );
  }

  Widget _buildFloatingNavigation(ResponsiveSize responsiveSize) {
    return Positioned(
      bottom: 16,
      left: 16,
      right: 16,
      child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha:(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: widget.items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isSelected = index == widget.currentIndex;
            
            return Expanded(
              child: _buildFloatingItem(item, isSelected, index, responsiveSize),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildFloatingItem(
    MobileNavigationItem item,
    bool isSelected,
    int index,
    ResponsiveSize responsiveSize,
  ) {
    return TouchOptimizationService.createTouchOptimized(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: isSelected ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: _buildIcon(item, isSelected, responsiveSize),
            ),
            if (widget.showLabels) ...[
              const SizedBox(height: 4),
              Text(
                item.label,
                style: TextStyle(
                  color: isSelected ? widget.selectedItemColor : widget.unselectedItemColor,
                  fontSize: ResponsiveService.getResponsiveFontSize(
                    isSelected ? widget.selectedFontSize : widget.unselectedFontSize,
                    responsiveSize,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
      onTap: () => _handleTap(index),
      hapticPattern: 'light',
    );
  }

  Widget _buildIcon(MobileNavigationItem item, bool isSelected, ResponsiveSize responsiveSize) {
    final iconSize = ResponsiveService.getResponsiveIconSize(
      widget.iconSize,
      responsiveSize,
    );
    
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: Icon(
        isSelected ? item.activeIcon : item.icon,
        key: ValueKey(isSelected),
        size: iconSize,
        color: isSelected ? widget.selectedItemColor : widget.unselectedItemColor,
      ),
    );
  }

  Widget _buildDrawerHeader(ResponsiveSize responsiveSize) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: widget.selectedItemColor?.withValues(alpha:(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.menu,
            size: ResponsiveService.getResponsiveIconSize(32, responsiveSize),
            color: widget.selectedItemColor,
          ),
          const SizedBox(height: 16),
          Text(
            'Navigation',
            style: TextStyle(
              fontSize: ResponsiveService.getResponsiveFontSize(24, responsiveSize),
              fontWeight: FontWeight.bold,
              color: widget.selectedItemColor,
            ),
          ),
        ],
      ),
    );
  }

  void _handleTap(int index) {
    if (index != widget.currentIndex) {
      _animationController.forward().then((_) {
        _animationController.reverse();
      });
      
      widget.onTap?.call(index);
      AccessibilityService.announceChange('Navigated to ${widget.items[index].label}');
    }
  }
}

/// Mobile Navigation Item
class MobileNavigationItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String? tooltip;
  final String? accessibilityLabel;
  final String? accessibilityHint;

  const MobileNavigationItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    this.tooltip,
    this.accessibilityLabel,
    this.accessibilityHint,
  });
}

/// Mobile Navigation Type
enum MobileNavigationType {
  bottomBar,
  drawer,
  tabBar,
  floating,
}

/// Mobile App Bar
class MobileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MobileAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.centerTitle,
    this.toolbarHeight,
    this.bottom,
    this.flexibleSpace,
    this.titleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.automaticallyImplyLeading = true,
    this.primary = true,
    this.excludeHeaderSemantics = false,
    this.titleTextStyle,
    this.toolbarTextStyle,
    this.iconTheme,
    this.actionsIconTheme,
    this.systemOverlayStyle,
    this.shadowColor,
    this.surfaceTintColor,
    this.scrolledUnderElevation,
    this.notificationPredicate = defaultScrollNotificationPredicate,
    this.shape,
    this.leadingWidth,
    this.backButtonText,
    this.titleTextStyle,
    this.toolbarTextStyle,
    this.iconTheme,
    this.actionsIconTheme,
    this.systemOverlayStyle,
    this.shadowColor,
    this.surfaceTintColor,
    this.scrolledUnderElevation,
    this.notificationPredicate = defaultScrollNotificationPredicate,
    this.shape,
    this.leadingWidth,
    this.backButtonText,
  });

  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final bool? centerTitle;
  final double? toolbarHeight;
  final PreferredSizeWidget? bottom;
  final Widget? flexibleSpace;
  final double? titleSpacing;
  final double toolbarOpacity;
  final double bottomOpacity;
  final bool automaticallyImplyLeading;
  final bool primary;
  final bool excludeHeaderSemantics;
  final TextStyle? titleTextStyle;
  final TextStyle? toolbarTextStyle;
  final IconThemeData? iconTheme;
  final IconThemeData? actionsIconTheme;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final double? scrolledUnderElevation;
  final ScrollNotificationPredicate notificationPredicate;
  final ShapeBorder? shape;
  final double? leadingWidth;
  final String? backButtonText;

  @override
  Widget build(BuildContext context) {
    final responsiveSize = ResponsiveService.getResponsiveSizeFromContext(context);
    final responsiveToolbarHeight = ResponsiveService.getResponsiveSpacing(
      toolbarHeight ?? kToolbarHeight,
      responsiveSize,
    );

    return AppBar(
      title: title,
      actions: actions,
      leading: leading,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: elevation,
      centerTitle: centerTitle,
      toolbarHeight: responsiveToolbarHeight,
      bottom: bottom,
      flexibleSpace: flexibleSpace,
      titleSpacing: titleSpacing,
      toolbarOpacity: toolbarOpacity,
      bottomOpacity: bottomOpacity,
      automaticallyImplyLeading: automaticallyImplyLeading,
      primary: primary,
      excludeHeaderSemantics: excludeHeaderSemantics,
      titleTextStyle: titleTextStyle,
      toolbarTextStyle: toolbarTextStyle,
      iconTheme: iconTheme,
      actionsIconTheme: actionsIconTheme,
      systemOverlayStyle: systemOverlayStyle,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      scrolledUnderElevation: scrolledUnderElevation,
      notificationPredicate: notificationPredicate,
      shape: shape,
      leadingWidth: leadingWidth,
      backButtonText: backButtonText,
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(toolbarHeight ?? kToolbarHeight);
  }
}

/// Mobile Drawer
class MobileDrawer extends StatelessWidget {
  const MobileDrawer({
    super.key,
    this.child,
    this.backgroundColor,
    this.elevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.width,
    this.semanticLabel,
  });

  final Widget? child;
  final Color? backgroundColor;
  final double? elevation;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final double? width;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final responsiveSize = ResponsiveService.getResponsiveSizeFromContext(context);
    final responsiveWidth = ResponsiveService.getResponsiveSpacing(
      width ?? 304.0,
      responsiveSize,
    );

    return Drawer(
      backgroundColor: backgroundColor,
      elevation: elevation,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      width: responsiveWidth,
      semanticLabel: semanticLabel,
      child: child,
    );
  }
}

/// Mobile Navigation Extensions
extension MobileNavigationExtensions on Widget {
  /// Wrap widget with mobile navigation
  Widget withMobileNavigation({
    required List<MobileNavigationItem> items,
    int currentIndex = 0,
    ValueChanged<int>? onTap,
    MobileNavigationType type = MobileNavigationType.bottomBar,
    Color? backgroundColor,
    Color? selectedItemColor,
    Color? unselectedItemColor,
    double iconSize = 24.0,
    double selectedFontSize = 12.0,
    double unselectedFontSize = 12.0,
    double elevation = 8.0,
    bool showLabels = true,
    bool showSelectedLabels = true,
    bool showUnselectedLabels = false,
  }) {
    return Scaffold(
      body: this,
      bottomNavigationBar: type == MobileNavigationType.bottomBar
          ? MobileNavigation(
              items: items,
              currentIndex: currentIndex,
              onTap: onTap,
              type: type,
              backgroundColor: backgroundColor,
              selectedItemColor: selectedItemColor,
              unselectedItemColor: unselectedItemColor,
              iconSize: iconSize,
              selectedFontSize: selectedFontSize,
              unselectedFontSize: unselectedFontSize,
              elevation: elevation,
              showLabels: showLabels,
              showSelectedLabels: showSelectedLabels,
              showUnselectedLabels: showUnselectedLabels,
            )
          : null,
      drawer: type == MobileNavigationType.drawer
          ? MobileDrawer(
              child: MobileNavigation(
                items: items,
                currentIndex: currentIndex,
                onTap: onTap,
                type: type,
                backgroundColor: backgroundColor,
                selectedItemColor: selectedItemColor,
                unselectedItemColor: unselectedItemColor,
                iconSize: iconSize,
                selectedFontSize: selectedFontSize,
                unselectedFontSize: unselectedFontSize,
                elevation: elevation,
                showLabels: showLabels,
                showSelectedLabels: showSelectedLabels,
                showUnselectedLabels: showUnselectedLabels,
              ),
            )
          : null,
    );
  }
}
