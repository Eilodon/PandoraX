import 'package:flutter/material.dart';
import '../services/responsive_service.dart';
import '../services/touch_optimization_service.dart';

/// Responsive Layout System
/// 
/// Comprehensive layout system for mobile-first responsive design
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.largeDesktop,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.safeArea = true,
    this.scrollable = false,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  final Widget? largeDesktop;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final bool safeArea;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final responsiveSize = ResponsiveService.getResponsiveSizeFromContext(context);
    
    Widget content = _getContentForSize(responsiveSize);
    
    // Apply padding
    if (padding != null) {
      final responsivePadding = ResponsiveService.getResponsivePadding(
        padding!,
        responsiveSize,
      );
      content = Padding(
        padding: responsivePadding,
        child: content,
      );
    }
    
    // Apply margin
    if (margin != null) {
      final responsiveMargin = ResponsiveService.getResponsiveMargin(
        margin!,
        responsiveSize,
      );
      content = Container(
        margin: responsiveMargin,
        child: content,
      );
    }
    
    // Apply background color
    if (backgroundColor != null) {
      content = Container(
        color: backgroundColor,
        child: content,
      );
    }
    
    // Make scrollable if needed
    if (scrollable) {
      content = SingleChildScrollView(
        child: content,
      );
    }
    
    // Apply safe area
    if (safeArea) {
      final safeAreaPadding = ResponsiveService.getResponsiveSafeAreaPadding(
        context,
        responsiveSize,
      );
      content = Padding(
        padding: safeAreaPadding,
        child: content,
      );
    }
    
    return content;
  }

  Widget _getContentForSize(ResponsiveSize size) {
    switch (size) {
      case ResponsiveSize.mobile:
        return mobile;
      case ResponsiveSize.tablet:
        return tablet ?? mobile;
      case ResponsiveSize.desktop:
        return desktop ?? tablet ?? mobile;
      case ResponsiveSize.largeDesktop:
        return largeDesktop ?? desktop ?? tablet ?? mobile;
    }
  }
}

/// Responsive Grid Layout
class ResponsiveGrid extends StatelessWidget {
  const ResponsiveGrid({
    super.key,
    required this.children,
    this.mobileColumns = 1,
    this.tabletColumns = 2,
    this.desktopColumns = 3,
    this.largeDesktopColumns = 4,
    this.spacing = 16.0,
    this.runSpacing = 16.0,
    this.padding,
    this.margin,
  });

  final List<Widget> children;
  final int mobileColumns;
  final int tabletColumns;
  final int desktopColumns;
  final int largeDesktopColumns;
  final double spacing;
  final double runSpacing;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    final responsiveSize = ResponsiveService.getResponsiveSizeFromContext(context);
    final columns = _getColumnsForSize(responsiveSize);
    final responsiveSpacing = ResponsiveService.getResponsiveSpacing(
      spacing,
      responsiveSize,
    );
    final responsiveRunSpacing = ResponsiveService.getResponsiveSpacing(
      runSpacing,
      responsiveSize,
    );

    Widget grid = _buildGrid(columns, responsiveSpacing, responsiveRunSpacing);

    // Apply padding
    if (padding != null) {
      final responsivePadding = ResponsiveService.getResponsivePadding(
        padding!,
        responsiveSize,
      );
      grid = Padding(
        padding: responsivePadding,
        child: grid,
      );
    }

    // Apply margin
    if (margin != null) {
      final responsiveMargin = ResponsiveService.getResponsiveMargin(
        margin!,
        responsiveSize,
      );
      grid = Container(
        margin: responsiveMargin,
        child: grid,
      );
    }

    return grid;
  }

  int _getColumnsForSize(ResponsiveSize size) {
    switch (size) {
      case ResponsiveSize.mobile:
        return mobileColumns;
      case ResponsiveSize.tablet:
        return tabletColumns;
      case ResponsiveSize.desktop:
        return desktopColumns;
      case ResponsiveSize.largeDesktop:
        return largeDesktopColumns;
    }
  }

  Widget _buildGrid(int columns, double spacing, double runSpacing) {
    if (columns == 1) {
      return Column(
        children: children.map((child) => Padding(
          padding: EdgeInsets.only(bottom: runSpacing),
          child: child,
        )).toList(),
      );
    }

    return Wrap(
      spacing: spacing,
      runSpacing: runSpacing,
      children: children.map((child) => SizedBox(
        width: (1 / columns) * 100 - spacing,
        child: child,
      )).toList(),
    );
  }
}

/// Responsive Container
class ResponsiveContainer extends StatelessWidget {
  const ResponsiveContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.maxWidth,
    this.maxHeight,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.border,
    this.boxShadow,
    this.alignment,
  });

  final Widget child;
  final double? width;
  final double? height;
  final double? maxWidth;
  final double? maxHeight;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    final responsiveSize = ResponsiveService.getResponsiveSizeFromContext(context);
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Calculate responsive width
    double? responsiveWidth = width;
    if (width != null) {
      responsiveWidth = ResponsiveService.getResponsiveSpacing(width!, responsiveSize);
    } else if (maxWidth != null) {
      responsiveWidth = ResponsiveService.getResponsiveContainerWidth(
        screenWidth,
        responsiveSize,
      );
    }

    // Calculate responsive height
    double? responsiveHeight = height;
    if (height != null) {
      responsiveHeight = ResponsiveService.getResponsiveSpacing(height!, responsiveSize);
    }

    // Calculate responsive max width
    double? responsiveMaxWidth = maxWidth;
    if (maxWidth != null) {
      responsiveMaxWidth = ResponsiveService.getResponsiveMaxWidth(responsiveSize);
    }

    // Calculate responsive padding
    EdgeInsets? responsivePadding = padding;
    if (padding != null) {
      responsivePadding = ResponsiveService.getResponsivePadding(
        padding!,
        responsiveSize,
      );
    }

    // Calculate responsive margin
    EdgeInsets? responsiveMargin = margin;
    if (margin != null) {
      responsiveMargin = ResponsiveService.getResponsiveMargin(
        margin!,
        responsiveSize,
      );
    }

    // Calculate responsive border radius
    BorderRadius? responsiveBorderRadius = borderRadius;
    if (borderRadius != null) {
      final radius = ResponsiveService.getResponsiveBorderRadius(
        borderRadius!.topLeft.x,
        responsiveSize,
      );
      responsiveBorderRadius = BorderRadius.circular(radius);
    }

    return Container(
      width: responsiveWidth,
      height: responsiveHeight,
      constraints: BoxConstraints(
        maxWidth: responsiveMaxWidth ?? double.infinity,
        maxHeight: maxHeight ?? double.infinity,
      ),
      padding: responsivePadding,
      margin: responsiveMargin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: responsiveBorderRadius,
        border: border,
        boxShadow: boxShadow,
      ),
      alignment: alignment,
      child: child,
    );
  }
}

/// Responsive Row
class ResponsiveRow extends StatelessWidget {
  const ResponsiveRow({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.spacing = 8.0,
    this.wrapOnMobile = true,
    this.padding,
    this.margin,
  });

  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final double spacing;
  final bool wrapOnMobile;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    final responsiveSize = ResponsiveService.getResponsiveSizeFromContext(context);
    final responsiveSpacing = ResponsiveService.getResponsiveSpacing(
      spacing,
      responsiveSize,
    );

    Widget row = _buildRow(responsiveSize, responsiveSpacing);

    // Apply padding
    if (padding != null) {
      final responsivePadding = ResponsiveService.getResponsivePadding(
        padding!,
        responsiveSize,
      );
      row = Padding(
        padding: responsivePadding,
        child: row,
      );
    }

    // Apply margin
    if (margin != null) {
      final responsiveMargin = ResponsiveService.getResponsiveMargin(
        margin!,
        responsiveSize,
      );
      row = Container(
        margin: responsiveMargin,
        child: row,
      );
    }

    return row;
  }

  Widget _buildRow(ResponsiveSize size, double spacing) {
    if (ResponsiveService.isMobile(size) && wrapOnMobile) {
      return Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: children,
      );
    }

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: children.map((child) => Padding(
        padding: EdgeInsets.only(right: spacing),
        child: child,
      )).toList(),
    );
  }
}

/// Responsive Column
class ResponsiveColumn extends StatelessWidget {
  const ResponsiveColumn({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.spacing = 8.0,
    this.padding,
    this.margin,
  });

  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final double spacing;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    final responsiveSize = ResponsiveService.getResponsiveSizeFromContext(context);
    final responsiveSpacing = ResponsiveService.getResponsiveSpacing(
      spacing,
      responsiveSize,
    );

    Widget column = Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: children.map((child) => Padding(
        padding: EdgeInsets.only(bottom: responsiveSpacing),
        child: child,
      )).toList(),
    );

    // Apply padding
    if (padding != null) {
      final responsivePadding = ResponsiveService.getResponsivePadding(
        padding!,
        responsiveSize,
      );
      column = Padding(
        padding: responsivePadding,
        child: column,
      );
    }

    // Apply margin
    if (margin != null) {
      final responsiveMargin = ResponsiveService.getResponsiveMargin(
        margin!,
        responsiveSize,
      );
      column = Container(
        margin: responsiveMargin,
        child: column,
      );
    }

    return column;
  }
}

/// Responsive Stack
class ResponsiveStack extends StatelessWidget {
  const ResponsiveStack({
    super.key,
    required this.children,
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.fit = StackFit.loose,
    this.clipBehavior = Clip.hardEdge,
    this.padding,
    this.margin,
  });

  final List<Widget> children;
  final AlignmentGeometry alignment;
  final TextDirection? textDirection;
  final StackFit fit;
  final Clip clipBehavior;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    final responsiveSize = ResponsiveService.getResponsiveSizeFromContext(context);

    Widget stack = Stack(
      alignment: alignment,
      textDirection: textDirection,
      fit: fit,
      clipBehavior: clipBehavior,
      children: children,
    );

    // Apply padding
    if (padding != null) {
      final responsivePadding = ResponsiveService.getResponsivePadding(
        padding!,
        responsiveSize,
      );
      stack = Padding(
        padding: responsivePadding,
        child: stack,
      );
    }

    // Apply margin
    if (margin != null) {
      final responsiveMargin = ResponsiveService.getResponsiveMargin(
        margin!,
        responsiveSize,
      );
      stack = Container(
        margin: responsiveMargin,
        child: stack,
      );
    }

    return stack;
  }
}

/// Responsive Aspect Ratio
class ResponsiveAspectRatio extends StatelessWidget {
  const ResponsiveAspectRatio({
    super.key,
    required this.child,
    this.mobileAspectRatio,
    this.tabletAspectRatio,
    this.desktopAspectRatio,
    this.largeDesktopAspectRatio,
  });

  final Widget child;
  final double? mobileAspectRatio;
  final double? tabletAspectRatio;
  final double? desktopAspectRatio;
  final double? largeDesktopAspectRatio;

  @override
  Widget build(BuildContext context) {
    final responsiveSize = ResponsiveService.getResponsiveSizeFromContext(context);
    final aspectRatio = _getAspectRatioForSize(responsiveSize);

    return AspectRatio(
      aspectRatio: aspectRatio,
      child: child,
    );
  }

  double _getAspectRatioForSize(ResponsiveSize size) {
    switch (size) {
      case ResponsiveSize.mobile:
        return mobileAspectRatio ?? ResponsiveService.getResponsiveAspectRatio(size);
      case ResponsiveSize.tablet:
        return tabletAspectRatio ?? ResponsiveService.getResponsiveAspectRatio(size);
      case ResponsiveSize.desktop:
        return desktopAspectRatio ?? ResponsiveService.getResponsiveAspectRatio(size);
      case ResponsiveSize.largeDesktop:
        return largeDesktopAspectRatio ?? ResponsiveService.getResponsiveAspectRatio(size);
    }
  }
}

/// Responsive Layout Extensions
extension ResponsiveLayoutExtensions on Widget {
  /// Wrap widget with responsive layout
  Widget responsiveLayout({
    Widget? mobile,
    Widget? tablet,
    Widget? desktop,
    Widget? largeDesktop,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Color? backgroundColor,
    bool safeArea = true,
    bool scrollable = false,
  }) {
    return ResponsiveLayout(
      mobile: mobile ?? this,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      safeArea: safeArea,
      scrollable: scrollable,
    );
  }

  /// Wrap widget with responsive container
  Widget responsiveContainer({
    double? width,
    double? height,
    double? maxWidth,
    double? maxHeight,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    Border? border,
    List<BoxShadow>? boxShadow,
    Alignment? alignment,
  }) {
    return ResponsiveContainer(
      child: this,
      width: width,
      height: height,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      border: border,
      boxShadow: boxShadow,
      alignment: alignment,
    );
  }
}
