import 'package:flutter/material.dart';
import 'package:pandora_ui/pandora_ui.dart';

/// 🌅 Dynamic Background Widget
/// 
/// Layer 1 của Dashboard - Background thay đổi theo thời gian trong ngày
/// Tạo cảm giác sống động và gần gũi với người dùng
class DynamicBackground extends StatelessWidget {
  final TimeOfDay timeOfDay;
  final double animationValue;

  const DynamicBackground({
    super.key,
    required this.timeOfDay,
    required this.animationValue,
  });

  @override
  Widget build(BuildContext context) {
    final timePeriod = _getTimePeriod(timeOfDay);
    final gradient = _getGradientForTime(timePeriod);
    final decorations = _getDecorationsForTime(timePeriod);

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: gradient,
      ),
      child: Stack(
        children: [
          // Base gradient background
          _buildGradientBackground(gradient),
          
          // Animated decorations
          ...decorations.map((decoration) => decoration),
          
          // Overlay for depth
          _buildOverlay(timePeriod),
        ],
      ),
    );
  }

  /// Xác định thời kỳ trong ngày
  TimePeriod _getTimePeriod(TimeOfDay timeOfDay) {
    final hour = timeOfDay.hour;
    
    if (hour >= 5 && hour < 8) {
      return TimePeriod.sunrise;
    } else if (hour >= 8 && hour < 12) {
      return TimePeriod.morning;
    } else if (hour >= 12 && hour < 14) {
      return TimePeriod.noon;
    } else if (hour >= 14 && hour < 17) {
      return TimePeriod.afternoon;
    } else if (hour >= 17 && hour < 19) {
      return TimePeriod.sunset;
    } else if (hour >= 19 && hour < 22) {
      return TimePeriod.evening;
    } else {
      return TimePeriod.night;
    }
  }

  /// Lấy gradient theo thời gian
  LinearGradient _getGradientForTime(TimePeriod period) {
    switch (period) {
      case TimePeriod.sunrise:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFE5B4), // Soft orange
            Color(0xFFFFCC80), // Light orange
            Color(0xFFFFAB40), // Orange
          ],
          stops: [0.0, 0.5, 1.0],
        );
      
      case TimePeriod.morning:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF87CEEB), // Sky blue
            Color(0xFF98D8E8), // Light blue
            Color(0xFFB0E0E6), // Powder blue
          ],
          stops: [0.0, 0.6, 1.0],
        );
      
      case TimePeriod.noon:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF87CEEB), // Sky blue
            Color(0xFF87CEEB), // Sky blue
            Color(0xFFE0F6FF), // Very light blue
          ],
          stops: [0.0, 0.3, 1.0],
        );
      
      case TimePeriod.afternoon:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF87CEEB), // Sky blue
            Color(0xFFB0E0E6), // Powder blue
            Color(0xFFF0F8FF), // Alice blue
          ],
          stops: [0.0, 0.4, 1.0],
        );
      
      case TimePeriod.sunset:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFF8C42), // Orange
            Color(0xFFFF6B35), // Red orange
            Color(0xFF4A4A4A), // Dark gray
          ],
          stops: [0.0, 0.5, 1.0],
        );
      
      case TimePeriod.evening:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF2C3E50), // Dark blue gray
            Color(0xFF34495E), // Dark gray
            Color(0xFF2C3E50), // Dark blue gray
          ],
          stops: [0.0, 0.5, 1.0],
        );
      
      case TimePeriod.night:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1A1A2E), // Very dark blue
            Color(0xFF16213E), // Dark blue
            Color(0xFF0F3460), // Darker blue
          ],
          stops: [0.0, 0.5, 1.0],
        );
    }
  }

  /// Lấy decorations theo thời gian
  List<Widget> _getDecorationsForTime(TimePeriod period) {
    final decorations = <Widget>[];

    switch (period) {
      case TimePeriod.sunrise:
        decorations.addAll([
          _buildSun(0.3, 0.2, Colors.orange, 60),
          _buildClouds(0.1, 0.3, 0.8),
          _buildClouds(0.7, 0.1, 0.6),
        ]);
        break;
      
      case TimePeriod.morning:
        decorations.addAll([
          _buildSun(0.5, 0.1, Colors.yellow, 80),
          _buildClouds(0.2, 0.4, 0.7),
          _buildClouds(0.8, 0.2, 0.5),
          _buildBirds(0.1, 0.3),
        ]);
        break;
      
      case TimePeriod.noon:
        decorations.addAll([
          _buildSun(0.5, 0.05, Colors.yellow, 100),
          _buildClouds(0.3, 0.5, 0.6),
          _buildClouds(0.7, 0.3, 0.4),
        ]);
        break;
      
      case TimePeriod.afternoon:
        decorations.addAll([
          _buildSun(0.6, 0.15, Colors.orange, 70),
          _buildClouds(0.1, 0.6, 0.8),
          _buildClouds(0.9, 0.4, 0.6),
        ]);
        break;
      
      case TimePeriod.sunset:
        decorations.addAll([
          _buildSun(0.3, 0.2, Colors.red, 60),
          _buildClouds(0.1, 0.3, 0.9),
          _buildClouds(0.7, 0.1, 0.7),
          _buildMountains(0.0, 0.7),
        ]);
        break;
      
      case TimePeriod.evening:
        decorations.addAll([
          _buildMoon(0.2, 0.15, Colors.white, 40),
          _buildStars(0.1, 0.1, 3),
          _buildStars(0.8, 0.2, 2),
          _buildStars(0.3, 0.3, 4),
          _buildClouds(0.5, 0.4, 0.3),
        ]);
        break;
      
      case TimePeriod.night:
        decorations.addAll([
          _buildMoon(0.3, 0.1, Colors.white, 50),
          _buildStars(0.1, 0.05, 5),
          _buildStars(0.7, 0.1, 4),
          _buildStars(0.2, 0.3, 3),
          _buildStars(0.8, 0.4, 6),
          _buildStars(0.4, 0.2, 2),
        ]);
        break;
    }

    return decorations;
  }

  /// Build gradient background
  Widget _buildGradientBackground(LinearGradient gradient) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: gradient,
      ),
    );
  }

  /// Build sun
  Widget _buildSun(double left, double top, Color color, double size) {
    return Positioned(
      left: MediaQuery.of(context).size.width * left,
      top: MediaQuery.of(context).size.height * top,
      child: AnimatedContainer(
        duration: Duration(milliseconds: (2000 * animationValue).round()),
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: 0.8),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
      ),
    );
  }

  /// Build moon
  Widget _buildMoon(double left, double top, Color color, double size) {
    return Positioned(
      left: MediaQuery.of(context).size.width * left,
      top: MediaQuery.of(context).size.height * top,
      child: AnimatedContainer(
        duration: Duration(milliseconds: (3000 * animationValue).round()),
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: 0.9),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.2),
              blurRadius: 15,
              spreadRadius: 3,
            ),
          ],
        ),
      ),
    );
  }

  /// Build clouds
  Widget _buildClouds(double left, double top, double opacity) {
    return Positioned(
      left: MediaQuery.of(context).size.width * left,
      top: MediaQuery.of(context).size.height * top,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: (4000 * animationValue).round()),
        opacity: opacity,
        child: Container(
          width: 80,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              // Cloud parts
              Positioned(
                left: 10,
                top: 10,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                left: 25,
                top: 5,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                left: 45,
                top: 10,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build stars
  Widget _buildStars(double left, double top, int count) {
    return Positioned(
      left: MediaQuery.of(context).size.width * left,
      top: MediaQuery.of(context).size.height * top,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: (5000 * animationValue).round()),
        opacity: 0.8,
        child: Column(
          children: List.generate(count, (index) {
            return Padding(
              padding: EdgeInsets.only(bottom: index * 15.0),
              child: Container(
                width: 3,
                height: 3,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  /// Build birds
  Widget _buildBirds(double left, double top) {
    return Positioned(
      left: MediaQuery.of(context).size.width * left,
      top: MediaQuery.of(context).size.height * top,
      child: AnimatedContainer(
        duration: Duration(milliseconds: (6000 * animationValue).round()),
        child: const Icon(
          Icons.flight,
          color: Colors.brown,
          size: 20,
        ),
      ),
    );
  }

  /// Build mountains
  Widget _buildMountains(double left, double top) {
    return Positioned(
      left: MediaQuery.of(context).size.width * left,
      top: MediaQuery.of(context).size.height * top,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: (7000 * animationValue).round()),
        opacity: 0.6,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: const BoxDecoration(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  /// Build overlay for depth
  Widget _buildOverlay(TimePeriod period) {
    Color overlayColor;
    double opacity;

    switch (period) {
      case TimePeriod.sunrise:
        overlayColor = Colors.orange;
        opacity = 0.1;
        break;
      case TimePeriod.morning:
        overlayColor = Colors.blue;
        opacity = 0.05;
        break;
      case TimePeriod.noon:
        overlayColor = Colors.yellow;
        opacity = 0.08;
        break;
      case TimePeriod.afternoon:
        overlayColor = Colors.orange;
        opacity = 0.06;
        break;
      case TimePeriod.sunset:
        overlayColor = Colors.red;
        opacity = 0.15;
        break;
      case TimePeriod.evening:
        overlayColor = Colors.purple;
        opacity = 0.2;
        break;
      case TimePeriod.night:
        overlayColor = Colors.indigo;
        opacity = 0.3;
        break;
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            overlayColor.withValues(alpha: opacity),
            overlayColor.withValues(alpha: opacity * 0.5),
            Colors.transparent,
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
    );
  }
}

/// Time periods for background
enum TimePeriod {
  sunrise,
  morning,
  noon,
  afternoon,
  sunset,
  evening,
  night,
}
