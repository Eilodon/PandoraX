import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pandora_ui/pandora_ui.dart';
import '../../mascot/presentation/lottie_mascot.dart';
import '../../mascot/providers/mascot_providers.dart';
import '../presentation/dashboard_screen.dart';

/// 🏠 Mascot Environment Widget
/// 
/// Khu vực "nhà" của Mascot với các đồ vật tương tác
/// Người dùng có thể mở khóa và trang trí môi trường
class MascotEnvironment extends ConsumerStatefulWidget {
  final MascotState mascotState;
  final VoidCallback onMascotTap;

  const MascotEnvironment({
    super.key,
    required this.mascotState,
    required this.onMascotTap,
  });

  @override
  ConsumerState<MascotEnvironment> createState() => _MascotEnvironmentState();
}

class _MascotEnvironmentState extends ConsumerState<MascotEnvironment>
    with TickerProviderStateMixin {
  late AnimationController _environmentAnimationController;
  late AnimationController _interactionAnimationController;
  
  late Animation<double> _environmentAnimation;
  late Animation<double> _interactionAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    // Environment animation - slow, ambient
    _environmentAnimationController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );
    
    // Interaction animation - quick, responsive
    _interactionAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _environmentAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _environmentAnimationController,
      curve: Curves.easeInOut,
    ));

    _interactionAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _interactionAnimationController,
      curve: Curves.elasticOut,
    ));
  }

  void _startAnimations() {
    _environmentAnimationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _environmentAnimationController.dispose();
    _interactionAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          // Environment decorations
          _buildEnvironmentDecorations(),
          
          // Interactive objects
          _buildInteractiveObjects(),
          
          // Mascot at center
          _buildMascotCenter(),
          
          // Environment particles
          _buildEnvironmentParticles(),
        ],
      ),
    );
  }

  /// Build environment decorations
  Widget _buildEnvironmentDecorations() {
    return AnimatedBuilder(
      animation: _environmentAnimation,
      builder: (context, child) {
        return Stack(
          children: [
            // Trees/Plants
            _buildTrees(),
            
            // Flowers
            _buildFlowers(),
            
            // Rocks/Stones
            _buildRocks(),
            
            // Path/Ground
            _buildGround(),
          ],
        );
      },
    );
  }

  /// Build trees around the environment
  Widget _buildTrees() {
    return Stack(
      children: [
        // Left side trees
        Positioned(
          left: 20,
          top: MediaQuery.of(context).size.height * 0.3,
          child: _buildTree(0.8, Colors.green),
        ),
        Positioned(
          left: 40,
          top: MediaQuery.of(context).size.height * 0.4,
          child: _buildTree(0.6, Colors.green.shade700),
        ),
        
        // Right side trees
        Positioned(
          right: 20,
          top: MediaQuery.of(context).size.height * 0.25,
          child: _buildTree(0.7, Colors.green.shade600),
        ),
        Positioned(
          right: 50,
          top: MediaQuery.of(context).size.height * 0.35,
          child: _buildTree(0.9, Colors.green.shade800),
        ),
      ],
    );
  }

  /// Build individual tree
  Widget _buildTree(double scale, Color color) {
    return Transform.scale(
      scale: scale,
      child: AnimatedBuilder(
        animation: _environmentAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(
              0,
              (2 * _environmentAnimation.value - 1) * 2,
            ),
            child: Container(
              width: 40,
              height: 60,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.8),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
              child: Stack(
                children: [
                  // Tree trunk
                  Positioned(
                    bottom: 0,
                    left: 15,
                    child: Container(
                      width: 10,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.brown.shade600,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  // Tree leaves
                  Positioned(
                    top: 5,
                    left: 5,
                    child: Container(
                      width: 30,
                      height: 35,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Build flowers around the environment
  Widget _buildFlowers() {
    return Stack(
      children: [
        // Bottom flowers
        Positioned(
          left: 60,
          bottom: MediaQuery.of(context).size.height * 0.1,
          child: _buildFlower(Colors.pink, 0.8),
        ),
        Positioned(
          left: 100,
          bottom: MediaQuery.of(context).size.height * 0.15,
          child: _buildFlower(Colors.purple, 0.6),
        ),
        Positioned(
          left: 150,
          bottom: MediaQuery.of(context).size.height * 0.12,
          child: _buildFlower(Colors.yellow, 0.7),
        ),
        Positioned(
          right: 80,
          bottom: MediaQuery.of(context).size.height * 0.08,
          child: _buildFlower(Colors.red, 0.9),
        ),
        Positioned(
          right: 120,
          bottom: MediaQuery.of(context).size.height * 0.13,
          child: _buildFlower(Colors.blue, 0.5),
        ),
      ],
    );
  }

  /// Build individual flower
  Widget _buildFlower(Color color, double scale) {
    return Transform.scale(
      scale: scale,
      child: AnimatedBuilder(
        animation: _environmentAnimation,
        builder: (context, child) {
          return Transform.rotate(
            angle: (2 * _environmentAnimation.value - 1) * 0.1,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.8),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Build rocks/stones
  Widget _buildRocks() {
    return Stack(
      children: [
        Positioned(
          left: 80,
          bottom: MediaQuery.of(context).size.height * 0.2,
          child: _buildRock(Colors.grey.shade600, 0.7),
        ),
        Positioned(
          right: 100,
          bottom: MediaQuery.of(context).size.height * 0.18,
          child: _buildRock(Colors.grey.shade500, 0.5),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width * 0.5,
          bottom: MediaQuery.of(context).size.height * 0.15,
          child: _buildRock(Colors.grey.shade700, 0.6),
        ),
      ],
    );
  }

  /// Build individual rock
  Widget _buildRock(Color color, double scale) {
    return Transform.scale(
      scale: scale,
      child: Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  /// Build ground/path
  Widget _buildGround() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green.shade100.withValues(alpha: 0.3),
              Colors.green.shade200.withValues(alpha: 0.5),
              Colors.green.shade300.withValues(alpha: 0.7),
            ],
          ),
        ),
      ),
    );
  }

  /// Build interactive objects
  Widget _buildInteractiveObjects() {
    return Stack(
      children: [
        // Unlocked objects
        ...widget.mascotState.unlockedObjects.map((object) => 
          _buildInteractiveObject(object)
        ),
        
        // Locked objects (with lock icon)
        ...widget.mascotState.lockedObjects.map((object) => 
          _buildLockedObject(object)
        ),
      ],
    );
  }

  /// Build interactive object
  Widget _buildInteractiveObject(EnvironmentObject object) {
    return Positioned(
      left: object.position.dx,
      top: object.position.dy,
      child: GestureDetector(
        onTap: () => _handleObjectTap(object),
        child: AnimatedBuilder(
          animation: _environmentAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: 1.0 + (0.05 * _environmentAnimation.value),
              child: Container(
                width: object.size,
                height: object.size,
                decoration: BoxDecoration(
                  color: object.color.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(object.size / 2),
                  boxShadow: [
                    BoxShadow(
                      color: object.color.withValues(alpha: 0.3),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(
                  object.icon,
                  color: Colors.white,
                  size: object.size * 0.6,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Build locked object
  Widget _buildLockedObject(EnvironmentObject object) {
    return Positioned(
      left: object.position.dx,
      top: object.position.dy,
      child: GestureDetector(
        onTap: () => _handleLockedObjectTap(object),
        child: Container(
          width: object.size,
          height: object.size,
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(object.size / 2),
            border: Border.all(
              color: Colors.grey.shade400,
              width: 2,
            ),
          ),
          child: Stack(
            children: [
              Icon(
                object.icon,
                color: Colors.grey.shade400,
                size: object.size * 0.4,
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.lock,
                    color: Colors.white,
                    size: 8,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build mascot at center
  Widget _buildMascotCenter() {
    return Center(
      child: GestureDetector(
        onTap: () {
          _interactionAnimationController.forward().then((_) {
            _interactionAnimationController.reverse();
          });
          widget.onMascotTap();
        },
        child: AnimatedBuilder(
          animation: _interactionAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _interactionAnimation.value,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: PandoraColors.primary200.withValues(alpha: 0.5),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const LottieMascot(
                  size: 120,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Build environment particles
  Widget _buildEnvironmentParticles() {
    return AnimatedBuilder(
      animation: _environmentAnimation,
      builder: (context, child) {
        return Stack(
          children: [
            // Floating particles
            _buildFloatingParticles(),
            
            // Sparkles around mascot
            _buildSparkles(),
          ],
        );
      },
    );
  }

  /// Build floating particles
  Widget _buildFloatingParticles() {
    return Stack(
      children: List.generate(8, (index) {
        final progress = (_environmentAnimation.value + (index * 0.125)) % 1.0;
        final left = MediaQuery.of(context).size.width * (0.1 + (index * 0.1));
        final top = MediaQuery.of(context).size.height * (0.2 + progress * 0.6);
        
        return Positioned(
          left: left,
          top: top,
          child: Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.6),
              shape: BoxShape.circle,
            ),
          ),
        );
      }),
    );
  }

  /// Build sparkles around mascot
  Widget _buildSparkles() {
    return Stack(
      children: List.generate(6, (index) {
        final angle = (index * 60.0) * (3.14159 / 180.0);
        final radius = 80.0;
        final centerX = MediaQuery.of(context).size.width / 2;
        final centerY = MediaQuery.of(context).size.height / 2;
        
        final x = centerX + radius * (1.0 + 0.2 * _environmentAnimation.value) * 
                  (angle.cos());
        final y = centerY + radius * (1.0 + 0.2 * _environmentAnimation.value) * 
                  (angle.sin());
        
        return Positioned(
          left: x - 6,
          top: y - 6,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.yellow.withValues(alpha: 0.8),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.star,
              color: Colors.white,
              size: 8,
            ),
          ),
        );
      }),
    );
  }

  /// Handle object tap
  void _handleObjectTap(EnvironmentObject object) {
    // Show object interaction
    PandoraSnackbar.show(
      context,
      message: 'Interacting with ${object.name}...',
      variant: PandoraSnackbarVariant.info,
    );
    
    // Trigger mascot reaction
    widget.onMascotTap();
  }

  /// Handle locked object tap
  void _handleLockedObjectTap(EnvironmentObject object) {
    // Show unlock requirement
    PandoraSnackbar.show(
      context,
      message: 'Unlock ${object.name} by completing quests!',
      variant: PandoraSnackbarVariant.warning,
    );
  }
}

/// Environment object model
class EnvironmentObject {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final Offset position;
  final double size;
  final bool isUnlocked;

  const EnvironmentObject({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.position,
    required this.size,
    this.isUnlocked = false,
  });
}

/// Extension for MascotState
extension MascotStateEnvironment on MascotState {
  List<EnvironmentObject> get unlockedObjects {
    return [
      const EnvironmentObject(
        id: 'flower_pot',
        name: 'Flower Pot',
        icon: Icons.local_florist,
        color: Colors.pink,
        position: Offset(50, 200),
        size: 30,
        isUnlocked: true,
      ),
      const EnvironmentObject(
        id: 'toy_ball',
        name: 'Toy Ball',
        icon: Icons.sports_soccer,
        color: Colors.blue,
        position: Offset(300, 180),
        size: 25,
        isUnlocked: true,
      ),
    ];
  }

  List<EnvironmentObject> get lockedObjects {
    return [
      const EnvironmentObject(
        id: 'fountain',
        name: 'Fountain',
        icon: Icons.water_drop,
        color: Colors.cyan,
        position: Offset(150, 150),
        size: 40,
        isUnlocked: false,
      ),
      const EnvironmentObject(
        id: 'garden_bench',
        name: 'Garden Bench',
        icon: Icons.chair,
        color: Colors.brown,
        position: Offset(80, 220),
        size: 35,
        isUnlocked: false,
      ),
    ];
  }
}
