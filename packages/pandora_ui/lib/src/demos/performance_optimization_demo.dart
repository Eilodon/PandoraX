import 'package:flutter/material.dart';
import '../services/performance_optimization_service.dart';
import '../services/memory_management_service.dart';
import '../services/animation_optimization_service.dart';
import '../enums/common_enums.dart';
import '../components/performance/performance_optimized_card.dart';
import '../tokens/color_tokens.dart';
import '../tokens/typography_tokens.dart';
import '../tokens/spacing_tokens.dart';

/// Performance Optimization Demo
/// 
/// Comprehensive demo showcasing Phase 3 performance optimization features
/// including animation optimization, memory management, and rendering optimization
class PerformanceOptimizationDemo extends StatefulWidget {
  const PerformanceOptimizationDemo({super.key});

  @override
  State<PerformanceOptimizationDemo> createState() => _PerformanceOptimizationDemoState();
}

class _PerformanceOptimizationDemoState extends State<PerformanceOptimizationDemo>
    with TickerProviderStateMixin {
  late AnimationController _mainAnimationController;
  late AnimationController _staggeredAnimationController;
  late AnimationController _shimmerAnimationController;
  
  final ScrollController _scrollController = ScrollController();
  final List<String> _performanceMetrics = [];
  
  bool _isMonitoring = false;
  bool _showPerformanceMonitor = false;
  bool _showMemoryMonitor = false;
  bool _showAnimationMonitor = false;
  
  int _cardCount = 10;
  bool _enableCaching = true;
  bool _enableLazyLoading = true;
  bool _enableAnimations = true;
  bool _enableGPUAcceleration = true;
  MemoryOptimizationLevel _memoryLevel = MemoryOptimizationLevel.medium;
  AnimationType _animationType = AnimationType.medium;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeServices();
  }

  @override
  void dispose() {
    _mainAnimationController.dispose();
    _staggeredAnimationController.dispose();
    _shimmerAnimationController.dispose();
    _scrollController.dispose();
    _cleanupServices();
    super.dispose();
  }

  void _initializeAnimations() {
    _mainAnimationController = AnimationOptimizationService.createOptimizedController(
      vsync: this,
      type: AnimationType.medium,
    );
    
    _staggeredAnimationController = AnimationOptimizationService.createOptimizedController(
      vsync: this,
      type: AnimationType.small,
    );
    
    _shimmerAnimationController = AnimationOptimizationService.createOptimizedController(
      vsync: this,
      type: AnimationType.medium,
    );
  }

  void _initializeServices() {
    PerformanceOptimizationService.initializePerformanceMonitoring();
    MemoryManagementService.initialize();
    AnimationOptimizationService.initialize();
  }

  void _cleanupServices() {
    PerformanceOptimizationService.stopPerformanceMonitoring();
    MemoryManagementService.stop();
    AnimationOptimizationService.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PandoraColors.neutral50,
      appBar: AppBar(
        title: const Text('Performance Optimization Demo'),
        backgroundColor: PandoraColors.primary500,
        foregroundColor: PandoraColors.white,
        actions: [
          IconButton(
            icon: Icon(_isMonitoring ? Icons.stop : Icons.play_arrow),
            onPressed: _toggleMonitoring,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showSettings,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildPerformanceMonitors(),
              const SizedBox(height: 24),
              _buildControls(),
              const SizedBox(height: 24),
              _buildPerformanceCards(),
              const SizedBox(height: 24),
              _buildAnimationShowcase(),
              const SizedBox(height: 24),
              _buildMemoryShowcase(),
              const SizedBox(height: 24),
              _buildPerformanceMetrics(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [PandoraColors.primary500, PandoraColors.primary600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: PandoraColors.primary500.withValues(alpha:(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Performance Optimization Demo',
            style: PandoraTypography.headlineMedium.copyWith(
              color: PandoraColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Phase 3: Advanced Performance Optimization',
            style: PandoraTypography.titleMedium.copyWith(
              color: PandoraColors.white.withValues(alpha:(0.9),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: PandoraColors.white.withValues(alpha:(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.speed,
                  color: PandoraColors.white,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'This demo showcases advanced performance optimization features including animation optimization, memory management, and rendering optimization.',
                    style: PandoraTypography.bodyMedium.copyWith(
                      color: PandoraColors.white.withValues(alpha:(0.9),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceMonitors() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Performance Monitors',
          style: PandoraTypography.titleLarge.copyWith(
            color: PandoraColors.neutral900,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildMonitorCard(
                title: 'Performance',
                icon: Icons.speed,
                isEnabled: _showPerformanceMonitor,
                onToggle: () => setState(() => _showPerformanceMonitor = !_showPerformanceMonitor),
                child: _showPerformanceMonitor
                    ? PerformanceOptimizationService.createPerformanceMonitor()
                    : const SizedBox.shrink(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildMonitorCard(
                title: 'Memory',
                icon: Icons.memory,
                isEnabled: _showMemoryMonitor,
                onToggle: () => setState(() => _showMemoryMonitor = !_showMemoryMonitor),
                child: _showMemoryMonitor
                    ? MemoryManagementService.createMemoryMonitor()
                    : const SizedBox.shrink(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildMonitorCard(
                title: 'Animation',
                icon: Icons.animation,
                isEnabled: _showAnimationMonitor,
                onToggle: () => setState(() => _showAnimationMonitor = !_showAnimationMonitor),
                child: _showAnimationMonitor
                    ? AnimationOptimizationService.createAnimationMonitor()
                    : const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMonitorCard({
    required String title,
    required IconData icon,
    required bool isEnabled,
    required VoidCallback onToggle,
    required Widget child,
  }) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isEnabled ? PandoraColors.primary50 : PandoraColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isEnabled ? PandoraColors.primary500 : PandoraColors.neutral300,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: isEnabled ? PandoraColors.primary500 : PandoraColors.neutral600,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: PandoraTypography.titleSmall.copyWith(
                    color: isEnabled ? PandoraColors.primary700 : PandoraColors.neutral700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Icon(
                  isEnabled ? Icons.visibility : Icons.visibility_off,
                  color: isEnabled ? PandoraColors.primary500 : PandoraColors.neutral600,
                  size: 16,
                ),
              ],
            ),
            if (isEnabled) ...[
              const SizedBox(height: 12),
              child,
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildControls() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PandoraColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: PandoraColors.neutral200.withValues(alpha:(0.5),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Performance Controls',
            style: PandoraTypography.titleLarge.copyWith(
              color: PandoraColors.neutral900,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildControlRow(
            title: 'Card Count',
            child: Slider(
              value: _cardCount.toDouble(),
              min: 5,
              max: 50,
              divisions: 9,
              label: _cardCount.toString(),
              onChanged: (value) => setState(() => _cardCount = value.round()),
            ),
          ),
          _buildControlRow(
            title: 'Enable Caching',
            child: Switch(
              value: _enableCaching,
              onChanged: (value) => setState(() => _enableCaching = value),
            ),
          ),
          _buildControlRow(
            title: 'Enable Lazy Loading',
            child: Switch(
              value: _enableLazyLoading,
              onChanged: (value) => setState(() => _enableLazyLoading = value),
            ),
          ),
          _buildControlRow(
            title: 'Enable Animations',
            child: Switch(
              value: _enableAnimations,
              onChanged: (value) => setState(() => _enableAnimations = value),
            ),
          ),
          _buildControlRow(
            title: 'Enable GPU Acceleration',
            child: Switch(
              value: _enableGPUAcceleration,
              onChanged: (value) => setState(() => _enableGPUAcceleration = value),
            ),
          ),
          _buildControlRow(
            title: 'Memory Level',
            child: DropdownButton<MemoryOptimizationLevel>(
              value: _memoryLevel,
              onChanged: (value) => setState(() => _memoryLevel = value!),
              items: MemoryOptimizationLevel.values.map((level) {
                return DropdownMenuItem(
                  value: level,
                  child: Text(level.name.toUpperCase()),
                );
              }).toList(),
            ),
          ),
          _buildControlRow(
            title: 'Animation Type',
            child: DropdownButton<AnimationType>(
              value: _animationType,
              onChanged: (value) => setState(() => _animationType = value!),
              items: AnimationType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.name.toUpperCase()),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlRow({
    required String title,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              title,
              style: PandoraTypography.bodyMedium.copyWith(
                color: PandoraColors.neutral700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _buildPerformanceCards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Performance Optimized Cards',
          style: PandoraTypography.titleLarge.copyWith(
            color: PandoraColors.neutral900,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
          ),
          itemCount: _cardCount,
          itemBuilder: (context, index) {
            return PerformanceOptimizedCard(
              variant: PerformanceCardVariant.values[index % PerformanceCardVariant.values.length],
              size: PerformanceCardSize.medium,
              enableCaching: _enableCaching,
              cacheKey: 'demo_card_$index',
              enableLazyLoading: _enableLazyLoading,
              isVisible: true,
              enableAnimations: _enableAnimations,
              animationType: _animationType,
              enableMemoryOptimization: true,
              memoryOptimizationLevel: _memoryLevel,
              onTap: () => _addPerformanceMetric('Card $index tapped'),
              leading: Icon(
                Icons.star,
                color: PandoraColors.white,
                size: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Card $index',
                    style: PandoraTypography.titleMedium.copyWith(
                      color: PandoraColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Performance optimized',
                    style: PandoraTypography.bodySmall.copyWith(
                      color: PandoraColors.white.withValues(alpha:(0.8),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAnimationShowcase() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Animation Showcase',
          style: PandoraTypography.titleLarge.copyWith(
            color: PandoraColors.neutral900,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildAnimationCard(
                title: 'Fade Animation',
                child: AnimationOptimizationService.createFadeAnimation(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: PandoraColors.primary500,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Fade',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  controller: _mainAnimationController,
                  type: _animationType,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildAnimationCard(
                title: 'Scale Animation',
                child: AnimationOptimizationService.createScaleAnimation(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: PandoraColors.secondary500,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Scale',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  controller: _mainAnimationController,
                  type: _animationType,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildAnimationCard(
                title: 'Shimmer Animation',
                child: AnimationOptimizationService.createShimmerAnimation(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: PandoraColors.success500,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Shimmer',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  controller: _shimmerAnimationController,
                  type: _animationType,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Center(
          child: ElevatedButton(
            onPressed: _startAnimations,
            style: ElevatedButton.styleFrom(
              backgroundColor: PandoraColors.primary500,
              foregroundColor: PandoraColors.white,
            ),
            child: const Text('Start Animations'),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimationCard({
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PandoraColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: PandoraColors.neutral200.withValues(alpha:(0.5),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: PandoraTypography.titleSmall.copyWith(
              color: PandoraColors.neutral900,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildMemoryShowcase() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Memory Management Showcase',
          style: PandoraTypography.titleLarge.copyWith(
            color: PandoraColors.neutral900,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildMemoryCard(
                title: 'Cached Widget',
                child: MemoryManagementService.createMemoryEfficientWidget(
                  key: 'cached_demo',
                  builder: () => Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: PandoraColors.warning500,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Cached',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildMemoryCard(
                title: 'Lazy Widget',
                child: MemoryManagementService.createLazyWidget(
                  key: 'lazy_demo',
                  builder: () => Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: PandoraColors.error500,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Lazy',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  isVisible: true,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildMemoryCard(
                title: 'Optimized Image',
                child: MemoryManagementService.createOptimizedImage(
                  imagePath: 'assets/images/placeholder.png',
                  width: 100,
                  height: 100,
                  cacheKey: 'demo_image',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMemoryCard({
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PandoraColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: PandoraColors.neutral200.withValues(alpha:(0.5),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: PandoraTypography.titleSmall.copyWith(
              color: PandoraColors.neutral900,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildPerformanceMetrics() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PandoraColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: PandoraColors.neutral200.withValues(alpha:(0.5),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Performance Metrics',
            style: PandoraTypography.titleLarge.copyWith(
              color: PandoraColors.neutral900,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          if (_performanceMetrics.isEmpty)
            Text(
              'No metrics recorded yet. Interact with the demo to see performance data.',
              style: PandoraTypography.bodyMedium.copyWith(
                color: PandoraColors.neutral600,
                fontStyle: FontStyle.italic,
              ),
            )
          else
            Column(
              children: _performanceMetrics.map((metric) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: PandoraColors.primary500,
                        size: 8,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          metric,
                          style: PandoraTypography.bodyMedium.copyWith(
                            color: PandoraColors.neutral700,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  void _toggleMonitoring() {
    setState(() {
      _isMonitoring = !_isMonitoring;
    });
    
    if (_isMonitoring) {
      _addPerformanceMetric('Performance monitoring started');
    } else {
      _addPerformanceMetric('Performance monitoring stopped');
    }
  }

  void _showSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Performance Settings'),
        content: const Text('Performance settings dialog would go here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _startAnimations() {
    _mainAnimationController.forward().then((_) {
      _mainAnimationController.reverse();
    });
    
    _staggeredAnimationController.forward().then((_) {
      _staggeredAnimationController.reverse();
    });
    
    _shimmerAnimationController.repeat();
    
    _addPerformanceMetric('Animations started');
  }

  void _addPerformanceMetric(String metric) {
    setState(() {
      _performanceMetrics.add('${DateTime.now().toString().substring(11, 19)}: $metric');
      if (_performanceMetrics.length > 20) {
        _performanceMetrics.removeAt(0);
      }
    });
  }
}
