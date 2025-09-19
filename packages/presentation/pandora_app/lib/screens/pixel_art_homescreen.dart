import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:design_tokens/design_tokens.dart';
import 'package:lottie/lottie.dart';
import 'package:common_entities/common_entities.dart';
import '../providers/note_provider_v2.dart';
import '../widgets/note_editor_dialog.dart';
import '../services/simple_navigation_service.dart';
import 'enhanced_notes_screen.dart';
import 'ai_chat_screen.dart';
import 'voice_screen.dart';
import 'settings_screen.dart';

class PixelArtHomeScreen extends ConsumerStatefulWidget {
  const PixelArtHomeScreen({super.key});

  @override
  ConsumerState<PixelArtHomeScreen> createState() => _PixelArtHomeScreenState();
}

class _PixelArtHomeScreenState extends ConsumerState<PixelArtHomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _mascotController;
  late AnimationController _floatingController;
  late Animation<double> _floatingAnimation;

  @override
  void initState() {
    super.initState();
    _mascotController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    
    _floatingController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _floatingAnimation = Tween<double>(
      begin: -10.0,
      end: 10.0,
    ).animate(CurvedAnimation(
      parent: _floatingController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _mascotController.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noteState = ref.watch(noteProvider);
    final noteNotifier = ref.read(noteProvider.notifier);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6B46C1), // Purple
              Color(0xFF8B5CF6), // Light Purple
              Color(0xFFA855F7), // Pink Purple
              Color(0xFFEC4899), // Pink
            ],
            stops: [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                '../../notes_app/assets/Background/c4589ce6e32cf24bf15026f16c93ce94.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF6B46C1), // Purple
                          Color(0xFF8B5CF6), // Light Purple
                          Color(0xFFA855F7), // Pink Purple
                          Color(0xFFEC4899), // Pink
                        ],
                        stops: [0.0, 0.3, 0.7, 1.0],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Main Content with SafeArea
            SafeArea(
              child: Stack(
                children: [
                  // Pixel Art Background Elements
                  _buildPixelArtBackground(),
                  
                  // Main Content
                  Column(
                    children: [
                      // Header with pixel art style
                      _buildPixelHeader(),
                      
                      // Main content area with mascot
                      Expanded(
                        child: _buildMainContent(noteState, noteNotifier),
                      ),
                      
                      // Bottom navigation with pixel style
                      _buildPixelBottomNav(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPixelArtBackground() {
    return Positioned.fill(
      child: CustomPaint(
        painter: PixelArtBackgroundPainter(),
        child: Container(),
      ),
    );
  }

  Widget _buildPixelHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // Pixel art logo
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.auto_awesome,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          
          // Title with pixel art style
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PandoraX',
                style: PandoraTextStyles.headlineMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    const Shadow(
                      color: Colors.black26,
                      offset: Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              Text(
                'Your AI-powered note-taking assistant',
                style: PandoraTextStyles.bodyMedium.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                  shadows: [
                    const Shadow(
                      color: Colors.black26,
                      offset: Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const Spacer(),
          
          // Settings button with pixel style
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsScreen()),
                );
              },
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(NoteState noteState, NoteNotifier noteNotifier) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Lottie Mascot
          AnimatedBuilder(
            animation: _floatingAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _floatingAnimation.value),
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Lottie.asset(
                    '../../notes_app/assets/lottie/welcome.json',
                    controller: _mascotController,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.pets,
                          size: 80,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
          
          const SizedBox(height: 30),
          
          // Welcome text with pixel art style
          Text(
            'Welcome to PandoraX!',
            style: PandoraTextStyles.headlineSmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [
                const Shadow(
                  color: Colors.black26,
                  offset: Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          Text(
            'Start creating your first note',
            style: PandoraTextStyles.bodyLarge.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
              shadows: [
                const Shadow(
                  color: Colors.black26,
                  offset: Offset(1, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 40),
          
          // Quick action buttons with pixel art style
          _buildQuickActionButtons(noteNotifier),
        ],
      ),
    );
  }

  Widget _buildQuickActionButtons(NoteNotifier noteNotifier) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildPixelButton(
          icon: Icons.note_add,
          label: 'New Note',
          onTap: () => _showCreateNoteDialog(noteNotifier),
        ),
        _buildPixelButton(
          icon: Icons.voice_over_off,
          label: 'Voice Note',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const VoiceScreen()),
            );
          },
        ),
        _buildPixelButton(
          icon: Icons.smart_toy,
          label: 'AI Assistant',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AIChatScreen()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPixelButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.4),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: PandoraTextStyles.bodySmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPixelBottomNav() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.home, 'Home', true),
          _buildNavItem(Icons.note, 'Notes', false),
          _buildNavItem(Icons.smart_toy, 'AI', false),
          _buildNavItem(Icons.mic, 'Voice', false),
          _buildNavItem(Icons.settings, 'Settings', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          switch (label) {
            case 'Home':
              // Already on home screen
              break;
            case 'Notes':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EnhancedNotesScreen()),
              );
              break;
            case 'AI':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AIChatScreen()),
              );
              break;
            case 'Voice':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const VoiceScreen()),
              );
              break;
            case 'Settings':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
              break;
          }
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.7),
                size: 20,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: PandoraTextStyles.bodySmall.copyWith(
                  color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.7),
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCreateNoteDialog(NoteNotifier noteNotifier) {
    showDialog(
      context: context,
      builder: (context) => NoteEditorDialog(
        onSave: (note) {
          noteNotifier.createNote(note);
        },
      ),
    );
  }
}

class PixelArtBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    // Draw pixel art elements
    _drawPixelStars(canvas, size, paint);
    _drawPixelClouds(canvas, size, paint);
    _drawPixelBuildings(canvas, size, paint);
  }

  void _drawPixelStars(Canvas canvas, Size size, Paint paint) {
    final starPositions = [
      Offset(size.width * 0.1, size.height * 0.2),
      Offset(size.width * 0.9, size.height * 0.15),
      Offset(size.width * 0.2, size.height * 0.8),
      Offset(size.width * 0.8, size.height * 0.7),
      Offset(size.width * 0.5, size.height * 0.1),
    ];

    for (final position in starPositions) {
      canvas.drawRect(
        Rect.fromCenter(center: position, width: 4, height: 4),
        paint,
      );
    }
  }

  void _drawPixelClouds(Canvas canvas, Size size, Paint paint) {
    // Cloud 1
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.1, size.height * 0.3, 40, 8),
      paint,
    );
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.15, size.height * 0.25, 30, 8),
      paint,
    );
    
    // Cloud 2
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.7, size.height * 0.4, 35, 8),
      paint,
    );
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.75, size.height * 0.35, 25, 8),
      paint,
    );
  }

  void _drawPixelBuildings(Canvas canvas, Size size, Paint paint) {
    // Building silhouettes at bottom
    final buildingHeights = [60.0, 40.0, 80.0, 50.0, 70.0, 45.0];
    final buildingWidth = size.width / buildingHeights.length;
    
    for (int i = 0; i < buildingHeights.length; i++) {
      canvas.drawRect(
        Rect.fromLTWH(
          i * buildingWidth,
          size.height - buildingHeights[i],
          buildingWidth,
          buildingHeights[i],
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
