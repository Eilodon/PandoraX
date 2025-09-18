/// Animation Components for Phase 5 Advanced UX
/// 
/// This file provides pre-built animation components with performance
/// optimization and advanced animation patterns.
library animation_components;

import 'package:flutter/material.dart';
import 'package:core/core.dart';

/// Animated button with advanced effects
class AnimatedButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Duration duration;
  final Curve curve;
  final double scaleOnPress;
  final Color? pressColor;
  final Color? hoverColor;
  final bool enableHapticFeedback;
  final bool enableSoundFeedback;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? shadows;
  
  const AnimatedButton({
    super.key,
    required this.child,
    this.onPressed,
    this.duration = const Duration(milliseconds: 150),
    this.curve = Curves.easeInOut,
    this.scaleOnPress = 0.95,
    this.pressColor,
    this.hoverColor,
    this.enableHapticFeedback = true,
    this.enableSoundFeedback = true,
    this.borderRadius,
    this.shadows,
  });
  
  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;
  
  bool _isPressed = false;
  bool _isHovered = false;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.scaleOnPress,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
    _colorAnimation = ColorTween(
      begin: widget.pressColor,
      end: widget.hoverColor,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTapDown: (_) => _onPress(true),
        onTapUp: (_) => _onPress(false),
        onTapCancel: () => _onPress(false),
        onTap: widget.onPressed,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                decoration: BoxDecoration(
                  color: _colorAnimation.value,
                  borderRadius: widget.borderRadius ?? BorderRadius.circular(DesignTokens.radiusBase),
                  boxShadow: widget.shadows ?? DesignTokens.shadowBase,
                ),
                child: child,
              ),
            );
          },
          child: widget.child,
        ),
      ),
    );
  }
  
  void _onPress(bool pressed) {
    if (pressed) {
      _controller.forward();
      if (widget.enableHapticFeedback) {
        MicroInteractionService.instance.selectionClick();
      }
      if (widget.enableSoundFeedback) {
        MicroInteractionService.instance.playClickSound();
      }
    } else {
      _controller.reverse();
    }
    setState(() {
      _isPressed = pressed;
    });
  }
  
  void _onHover(bool hovered) {
    setState(() {
      _isHovered = hovered;
    });
  }
}

/// Animated card with morphing effects
class AnimatedCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Duration duration;
  final Curve curve;
  final double scaleOnHover;
  final double scaleOnPress;
  final Color? hoverColor;
  final Color? pressColor;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? shadows;
  final bool enableHapticFeedback;
  final bool enableSoundFeedback;
  
  const AnimatedCard({
    super.key,
    required this.child,
    this.onTap,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
    this.scaleOnHover = 1.02,
    this.scaleOnPress = 0.98,
    this.hoverColor,
    this.pressColor,
    this.borderRadius,
    this.shadows,
    this.enableHapticFeedback = true,
    this.enableSoundFeedback = true,
  });
  
  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;
  late Animation<List<BoxShadow>?> _shadowAnimation;
  
  bool _isHovered = false;
  bool _isPressed = false;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.scaleOnHover,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
    _colorAnimation = ColorTween(
      begin: widget.hoverColor,
      end: widget.pressColor,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
    _shadowAnimation = Tween<List<BoxShadow>?>(
      begin: widget.shadows ?? DesignTokens.shadowBase,
      end: DesignTokens.shadowLg,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTapDown: (_) => _onPress(true),
        onTapUp: (_) => _onPress(false),
        onTapCancel: () => _onPress(false),
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                decoration: BoxDecoration(
                  color: _colorAnimation.value,
                  borderRadius: widget.borderRadius ?? BorderRadius.circular(DesignTokens.radiusBase),
                  boxShadow: _shadowAnimation.value,
                ),
                child: child,
              ),
            );
          },
          child: widget.child,
        ),
      ),
    );
  }
  
  void _onHover(bool hovered) {
    if (hovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() {
      _isHovered = hovered;
    });
  }
  
  void _onPress(bool pressed) {
    if (pressed) {
      if (widget.enableHapticFeedback) {
        MicroInteractionService.instance.mediumImpact();
      }
      if (widget.enableSoundFeedback) {
        MicroInteractionService.instance.playClickSound();
      }
    }
    setState(() {
      _isPressed = pressed;
    });
  }
}

/// Animated list with staggered animations
class AnimatedList extends StatefulWidget {
  final List<Widget> children;
  final Duration delay;
  final Duration duration;
  final Curve curve;
  final Offset offset;
  final double opacityStart;
  final double opacityEnd;
  final bool enableHapticFeedback;
  final bool enableSoundFeedback;
  
  const AnimatedList({
    super.key,
    required this.children,
    this.delay = const Duration(milliseconds: 100),
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeOut,
    this.offset = const Offset(0, 50),
    this.opacityStart = 0.0,
    this.opacityEnd = 1.0,
    this.enableHapticFeedback = true,
    this.enableSoundFeedback = true,
  });
  
  @override
  State<AnimatedList> createState() => _AnimatedListState();
}

class _AnimatedListState extends State<AnimatedList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.children.asMap().entries.map((entry) {
        final index = entry.key;
        final child = entry.value;
        
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(
            milliseconds: widget.duration.inMilliseconds + (index * widget.delay.inMilliseconds),
          ),
          curve: widget.curve,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(
                widget.offset.dx * (1 - value),
                widget.offset.dy * (1 - value),
              ),
              child: Opacity(
                opacity: widget.opacityStart + (widget.opacityEnd - widget.opacityStart) * value,
                child: child,
              ),
            );
          },
          child: child,
        );
      }).toList(),
    );
  }
}

/// Animated text with morphing effects
class AnimatedText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration duration;
  final Curve curve;
  final double scaleOnHover;
  final Color? hoverColor;
  final bool enableHapticFeedback;
  final bool enableSoundFeedback;
  
  const AnimatedText({
    super.key,
    required this.text,
    this.style,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
    this.scaleOnHover = 1.05,
    this.hoverColor,
    this.enableHapticFeedback = true,
    this.enableSoundFeedback = true,
  });
  
  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;
  
  bool _isHovered = false;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.scaleOnHover,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
    _colorAnimation = ColorTween(
      begin: widget.style?.color,
      end: widget.hoverColor,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTap: () {
          if (widget.enableHapticFeedback) {
            MicroInteractionService.instance.selectionClick();
          }
          if (widget.enableSoundFeedback) {
            MicroInteractionService.instance.playClickSound();
          }
        },
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Text(
                widget.text,
                style: widget.style?.copyWith(
                  color: _colorAnimation.value,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  
  void _onHover(bool hovered) {
    if (hovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() {
      _isHovered = hovered;
    });
  }
}

/// Animated container with morphing effects
class AnimatedContainer extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final double scaleOnHover;
  final double scaleOnPress;
  final Color? hoverColor;
  final Color? pressColor;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? shadows;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool enableHapticFeedback;
  final bool enableSoundFeedback;
  
  const AnimatedContainer({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
    this.scaleOnHover = 1.02,
    this.scaleOnPress = 0.98,
    this.hoverColor,
    this.pressColor,
    this.borderRadius,
    this.shadows,
    this.padding,
    this.margin,
    this.enableHapticFeedback = true,
    this.enableSoundFeedback = true,
  });
  
  @override
  State<AnimatedContainer> createState() => _AnimatedContainerState();
}

class _AnimatedContainerState extends State<AnimatedContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;
  late Animation<BorderRadius?> _borderRadiusAnimation;
  late Animation<List<BoxShadow>?> _shadowAnimation;
  
  bool _isHovered = false;
  bool _isPressed = false;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.scaleOnHover,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
    _colorAnimation = ColorTween(
      begin: widget.hoverColor,
      end: widget.pressColor,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
    _borderRadiusAnimation = Tween<BorderRadius?>(
      begin: widget.borderRadius,
      end: widget.borderRadius,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
    _shadowAnimation = Tween<List<BoxShadow>?>(
      begin: widget.shadows ?? DesignTokens.shadowBase,
      end: DesignTokens.shadowLg,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTapDown: (_) => _onPress(true),
        onTapUp: (_) => _onPress(false),
        onTapCancel: () => _onPress(false),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                padding: widget.padding,
                margin: widget.margin,
                decoration: BoxDecoration(
                  color: _colorAnimation.value,
                  borderRadius: _borderRadiusAnimation.value,
                  boxShadow: _shadowAnimation.value,
                ),
                child: child,
              ),
            );
          },
          child: widget.child,
        ),
      ),
    );
  }
  
  void _onHover(bool hovered) {
    if (hovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() {
      _isHovered = hovered;
    });
  }
  
  void _onPress(bool pressed) {
    if (pressed) {
      if (widget.enableHapticFeedback) {
        MicroInteractionService.instance.mediumImpact();
      }
      if (widget.enableSoundFeedback) {
        MicroInteractionService.instance.playClickSound();
      }
    }
    setState(() {
      _isPressed = pressed;
    });
  }
}

/// Animated icon with rotation effects
class AnimatedIcon extends StatefulWidget {
  final IconData icon;
  final double? size;
  final Color? color;
  final Duration duration;
  final Curve curve;
  final double rotationAngle;
  final double scaleOnHover;
  final Color? hoverColor;
  final bool enableHapticFeedback;
  final bool enableSoundFeedback;
  
  const AnimatedIcon({
    super.key,
    required this.icon,
    this.size,
    this.color,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
    this.rotationAngle = 0.0,
    this.scaleOnHover = 1.1,
    this.hoverColor,
    this.enableHapticFeedback = true,
    this.enableSoundFeedback = true,
  });
  
  @override
  State<AnimatedIcon> createState() => _AnimatedIconState();
}

class _AnimatedIconState extends State<AnimatedIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<Color?> _colorAnimation;
  
  bool _isHovered = false;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.scaleOnHover,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: widget.rotationAngle,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
    _colorAnimation = ColorTween(
      begin: widget.color,
      end: widget.hoverColor,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTap: () {
          if (widget.enableHapticFeedback) {
            MicroInteractionService.instance.selectionClick();
          }
          if (widget.enableSoundFeedback) {
            MicroInteractionService.instance.playClickSound();
          }
        },
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Transform.rotate(
                angle: _rotationAnimation.value,
                child: Icon(
                  widget.icon,
                  size: widget.size,
                  color: _colorAnimation.value,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  
  void _onHover(bool hovered) {
    if (hovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() {
      _isHovered = hovered;
    });
  }
}

/// Animated progress indicator
class AnimatedProgressIndicator extends StatefulWidget {
  final double value;
  final Color? backgroundColor;
  final Color? valueColor;
  final Duration duration;
  final Curve curve;
  final double strokeWidth;
  final bool enableHapticFeedback;
  final bool enableSoundFeedback;
  
  const AnimatedProgressIndicator({
    super.key,
    required this.value,
    this.backgroundColor,
    this.valueColor,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.strokeWidth = 4.0,
    this.enableHapticFeedback = true,
    this.enableSoundFeedback = true,
  });
  
  @override
  State<AnimatedProgressIndicator> createState() => _AnimatedProgressIndicatorState();
}

class _AnimatedProgressIndicatorState extends State<AnimatedProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _valueAnimation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _valueAnimation = Tween<double>(
      begin: 0.0,
      end: widget.value,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
    _controller.forward();
  }
  
  @override
  void didUpdateWidget(AnimatedProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _valueAnimation = Tween<double>(
        begin: oldWidget.value,
        end: widget.value,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ));
      _controller.forward(from: 0.0);
    }
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _valueAnimation,
      builder: (context, child) {
        return CircularProgressIndicator(
          value: _valueAnimation.value,
          backgroundColor: widget.backgroundColor,
          valueColor: AlwaysStoppedAnimation<Color>(
            widget.valueColor ?? DesignTokens.primary,
          ),
          strokeWidth: widget.strokeWidth,
        );
      },
    );
  }
}
