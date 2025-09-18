import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/decoration_system.dart';
import '../services/mascot_thought_bubbles.dart';
import '../services/mascot_service.dart';
import '../services/mascot_enums.dart';
import 'living_mascot_widget.dart';
import 'package:pandora_ui/pandora_ui.dart';

/// Mascot Environment Widget
/// 
/// The main widget that contains the mascot and its interactive environment
class MascotEnvironmentWidget extends ConsumerStatefulWidget {
  final double width;
  final double height;
  final bool showThoughtBubbles;
  final bool allowDecoration;
  final VoidCallback? onEnvironmentTap;

  const MascotEnvironmentWidget({
    super.key,
    required this.width,
    required this.height,
    this.showThoughtBubbles = true,
    this.allowDecoration = true,
    this.onEnvironmentTap,
  });

  @override
  ConsumerState<MascotEnvironmentWidget> createState() => _MascotEnvironmentWidgetState();
}

class _MascotEnvironmentWidgetState extends ConsumerState<MascotEnvironmentWidget> {
  bool _isEditMode = false;
  PlacedDecoration? _selectedDecoration;

  @override
  Widget build(BuildContext context) {
    final decorationState = ref.watch(decorationSystemWithPrefsProvider);
    final mascotState = ref.watch(mascotServiceProvider);
    
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            PandoraColors.primary50,
            PandoraColors.primary100,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: PandoraColors.primary200,
          width: 2,
        ),
      ),
      child: Stack(
        children: [
          // Environment background
          _buildEnvironmentBackground(),
          
          // Placed decorations
          ...decorationState.placedDecorations.map((decoration) => 
            _buildPlacedDecoration(decoration)),
          
          // Mascot with thought bubble
          _buildMascotWithBubble(mascotState),
          
          // Interaction zones
          if (widget.allowDecoration) _buildInteractionZones(),
          
          // Edit mode overlay
          if (_isEditMode) _buildEditModeOverlay(),
        ],
      ),
    );
  }

  Widget _buildEnvironmentBackground() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            PandoraColors.primary50.withValues(alpha: 0.3),
            PandoraColors.primary100.withValues(alpha: 0.1),
          ],
        ),
      ),
      child: CustomPaint(
        painter: EnvironmentBackgroundPainter(),
        size: Size(widget.width, widget.height),
      ),
    );
  }

  Widget _buildPlacedDecoration(PlacedDecoration decoration) {
    final decorationItem = ref.read(decorationSystemWithPrefsProvider.notifier)
        .state.availableItems.firstWhere(
          (item) => item.id == decoration.decorationItemId,
          orElse: () => throw Exception('Decoration item not found'),
        );

    return Positioned(
      left: decoration.x,
      top: decoration.y,
      child: GestureDetector(
        onTap: _isEditMode ? () => _selectDecoration(decoration) : null,
        onLongPress: _isEditMode ? () => _removeDecoration(decoration) : null,
        child: Transform.rotate(
          angle: decoration.rotation,
          child: Transform.scale(
            scale: decoration.scale,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: _selectedDecoration?.id == decoration.id
                    ? Border.all(color: PandoraColors.primary500, width: 2)
                    : null,
              ),
              child: _buildDecorationIcon(decorationItem),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDecorationIcon(DecorationItem item) {
    // For now, use emoji icons. In a real app, you'd use actual images
    String emoji;
    switch (item.type) {
      case DecorationType.plant:
        emoji = '🌱';
        break;
      case DecorationType.light:
        emoji = '💡';
        break;
      case DecorationType.book:
        emoji = '📚';
        break;
      case DecorationType.furniture:
        emoji = '🪑';
        break;
      case DecorationType.art:
        emoji = '🖼️';
        break;
      case DecorationType.toy:
        emoji = '🧸';
        break;
      case DecorationType.food:
        emoji = '🍰';
        break;
      case DecorationType.accessory:
        emoji = '🖼️';
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: PandoraColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: PandoraColors.shadowColor,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          emoji,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  Widget _buildMascotWithBubble(MascotState mascotState) {
    return Positioned(
      right: 20,
      bottom: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Thought bubble
          if (widget.showThoughtBubbles)
            ThoughtBubbleWidget(
              width: 180,
              height: 50,
            ),
          
          // Mascot
          LivingMascotWithCloudWidget(
            size: MascotSize.large,
            position: MascotPosition.center,
            showMessage: false,
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionZones() {
    return Positioned.fill(
      child: GestureDetector(
        onTap: (details) {
          if (_isEditMode) {
            _showDecorationMenu(details.localPosition);
          } else {
            widget.onEnvironmentTap?.call();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }

  Widget _buildEditModeOverlay() {
    return Positioned(
      top: 10,
      right: 10,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: PandoraColors.primary500,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.edit,
              color: PandoraColors.white,
              size: 16,
            ),
            const SizedBox(width: 4),
            const Text(
              'Edit Mode',
              style: TextStyle(
                color: PandoraColors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => setState(() => _isEditMode = false),
              child: const Icon(
                Icons.close,
                color: PandoraColors.white,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectDecoration(PlacedDecoration decoration) {
    setState(() {
      _selectedDecoration = decoration;
    });
  }

  void _removeDecoration(PlacedDecoration decoration) {
    ref.read(decorationSystemWithPrefsProvider.notifier)
        .removeDecoration(decoration.id);
    setState(() {
      _selectedDecoration = null;
    });
  }

  void _showDecorationMenu(Offset position) {
    showModalBottomSheet(
      context: context,
      builder: (context) => _buildDecorationMenu(position),
    );
  }

  Widget _buildDecorationMenu(Offset position) {
    final decorationState = ref.watch(decorationSystemWithPrefsProvider);
    final unlockedItems = decorationState.availableItems
        .where((item) => item.isUnlocked)
        .toList();

    return Container(
      height: 300,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Place Decoration',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: unlockedItems.length,
              itemBuilder: (context, index) {
                final item = unlockedItems[index];
                return GestureDetector(
                  onTap: () {
                    _placeDecoration(item, position);
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: PandoraColors.primary50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: PandoraColors.primary200),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _getDecorationEmoji(item.type),
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _placeDecoration(DecorationItem item, Offset position) {
    ref.read(decorationSystemWithPrefsProvider.notifier)
        .placeDecoration(item.id, position.dx, position.dy);
  }

  String _getDecorationEmoji(DecorationType type) {
    switch (type) {
      case DecorationType.plant:
        return '🌱';
      case DecorationType.light:
        return '💡';
      case DecorationType.book:
        return '📚';
      case DecorationType.furniture:
        return '🪑';
      case DecorationType.art:
        return '🖼️';
      case DecorationType.toy:
        return '🧸';
      case DecorationType.food:
        return '🍰';
      case DecorationType.accessory:
        return '🖼️';
    }
  }

  /// Toggle edit mode
  void toggleEditMode() {
    setState(() {
      _isEditMode = !_isEditMode;
      if (!_isEditMode) {
        _selectedDecoration = null;
      }
    });
  }
}

/// Environment Background Painter
class EnvironmentBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = PandoraColors.primary100.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    // Draw some decorative elements
    final path = Path();
    
    // Draw a simple pattern
    for (int i = 0; i < 5; i++) {
      final x = (size.width / 6) * (i + 1);
      final y = size.height / 2;
      final radius = 20.0;
      
      canvas.drawCircle(
        Offset(x, y),
        radius,
        paint..color = PandoraColors.primary200.withValues(alpha: 0.1),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Decoration Shop Widget
class DecorationShopWidget extends ConsumerWidget {
  const DecorationShopWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decorationState = ref.watch(decorationSystemWithPrefsProvider);
    final decorationService = ref.read(decorationSystemWithPrefsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Decoration Shop'),
        backgroundColor: PandoraColors.primary500,
        foregroundColor: PandoraColors.white,
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: PandoraColors.warning500,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.monetization_on, size: 16),
                const SizedBox(width: 4),
                Text(
                  '${decorationState.gold}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category tabs
            _buildCategoryTabs(),
            const SizedBox(height: 16),
            
            // Items grid
            Expanded(
              child: _buildItemsGrid(decorationState, decorationService),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: DecorationType.values.map((type) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Chip(
              label: Text(_getTypeName(type)),
              backgroundColor: PandoraColors.primary100,
              labelStyle: const TextStyle(color: PandoraColors.primary700),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildItemsGrid(DecorationSystemState state, DecorationSystemService service) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: state.availableItems.length,
      itemBuilder: (context, index) {
        final item = state.availableItems[index];
        return _buildItemCard(item, state, service);
      },
    );
  }

  Widget _buildItemCard(DecorationItem item, DecorationSystemState state, DecorationSystemService service) {
    final canAfford = state.gold >= item.price;
    final isUnlocked = item.isUnlocked;

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item icon
            Expanded(
              child: Center(
                child: Text(
                  _getDecorationEmoji(item.type),
                  style: const TextStyle(fontSize: 48),
                ),
              ),
            ),
            
            // Item name
            Text(
              item.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            // Item description
            Text(
              item.description,
              style: TextStyle(
                color: PandoraColors.neutral600,
                fontSize: 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            const SizedBox(height: 8),
            
            // Price and action
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${item.price} Gold',
                  style: TextStyle(
                    color: canAfford ? PandoraColors.success600 : PandoraColors.error600,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isUnlocked)
                  const Icon(
                    Icons.check_circle,
                    color: PandoraColors.success500,
                    size: 20,
                  )
                else
                  ElevatedButton(
                    onPressed: canAfford ? () => service.purchaseItem(item.id) : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PandoraColors.primary500,
                      foregroundColor: PandoraColors.white,
                      minimumSize: const Size(60, 32),
                    ),
                    child: const Text('Buy'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getTypeName(DecorationType type) {
    switch (type) {
      case DecorationType.plant:
        return 'Plants';
      case DecorationType.light:
        return 'Lights';
      case DecorationType.book:
        return 'Books';
      case DecorationType.furniture:
        return 'Furniture';
      case DecorationType.art:
        return 'Art';
      case DecorationType.toy:
        return 'Toys';
      case DecorationType.food:
        return 'Food';
      case DecorationType.accessory:
        return 'Accessories';
    }
  }

  String _getDecorationEmoji(DecorationType type) {
    switch (type) {
      case DecorationType.plant:
        return '🌱';
      case DecorationType.light:
        return '💡';
      case DecorationType.book:
        return '📚';
      case DecorationType.furniture:
        return '🪑';
      case DecorationType.art:
        return '🖼️';
      case DecorationType.toy:
        return '🧸';
      case DecorationType.food:
        return '🍰';
      case DecorationType.accessory:
        return '🖼️';
    }
  }
}
