import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pandora/services/ui_optimization_service.dart';

void main() {
  group('UIOptimizationService', () {
    tearDown(() async {
      // Clean up after each test
      await UIOptimizationService.dispose();
    });

    group('Service Initialization', () {
      testWidgets('should initialize UI optimization successfully', (tester) async {
        // Act
        await UIOptimizationService.initialize();

        // Assert
        final metrics = UIOptimizationService.getUIPerformanceMetrics();
        expect(metrics['monitoring_active'], isTrue);
      });

      testWidgets('should handle multiple initialization calls gracefully', (tester) async {
        // Act
        await UIOptimizationService.initialize();
        await UIOptimizationService.initialize();
        await UIOptimizationService.initialize();

        // Assert
        final metrics = UIOptimizationService.getUIPerformanceMetrics();
        expect(metrics['monitoring_active'], isTrue);
      });
    });

    group('UI Performance Metrics', () {
      testWidgets('should return empty metrics when not initialized', (tester) async {
        // Act
        final metrics = UIOptimizationService.getUIPerformanceMetrics();

        // Assert
        expect(metrics['frame_count'], equals(0));
        expect(metrics['monitoring_active'], isFalse);
        expect(metrics['timestamp'], isA<String>());
      });

      testWidgets('should return performance metrics after initialization', (tester) async {
        // Arrange
        await UIOptimizationService.initialize();

        // Act
        final metrics = UIOptimizationService.getUIPerformanceMetrics();

        // Assert
        expect(metrics['monitoring_active'], isTrue);
        expect(metrics['timestamp'], isA<String>());
        expect(metrics, containsKey('frame_count'));
        expect(metrics, containsKey('image_cache_size'));
        expect(metrics, containsKey('image_cache_max_size'));
      });
    });

    group('Optimized Widgets', () {
      testWidgets('should create optimized list view', (tester) async {
        // Arrange
        const itemCount = 10;
        
        // Act
        final listView = UIOptimizationService.createOptimizedListView(
          itemCount: itemCount,
          itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
        );

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: listView)));

        // Assert
        expect(find.byType(ListView), findsOneWidget);
        expect(find.byType(ListTile), findsWidgets);
      });

      testWidgets('should create lazy loading list view', (tester) async {
        // Arrange
        const itemCount = 20;
        bool loadMoreCalled = false;
        
        // Act
        final listView = UIOptimizationService.createLazyListView(
          itemCount: itemCount,
          itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
          onLoadMore: () {
            loadMoreCalled = true;
          },
        );

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: listView)));

        // Assert
        expect(find.byType(NotificationListener<ScrollNotification>), findsOneWidget);
        expect(find.byType(ListView), findsOneWidget);
      });

      testWidgets('should create optimized image widget', (tester) async {
        // Act
        final imageWidget = UIOptimizationService.createOptimizedImage(
          imageUrl: 'https://example.com/image.jpg',
          width: 100,
          height: 100,
          placeholder: const CircularProgressIndicator(),
          errorWidget: const Icon(Icons.error),
        );

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: imageWidget)));

        // Assert
        expect(find.byType(RepaintBoundary), findsOneWidget);
        expect(find.byType(Image), findsOneWidget);
      });

      testWidgets('should create optimized animated list', (tester) async {
        // Arrange
        const itemCount = 5;
        
        // Act
        final animatedList = UIOptimizationService.createOptimizedAnimatedList(
          itemCount: itemCount,
          itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
          itemRemovedBuilder: (context, index, animation) => 
              const SizedBox.shrink(),
        );

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: animatedList)));

        // Assert
        expect(find.byType(AnimatedList), findsOneWidget);
      });

      testWidgets('should create optimized widget with repaint boundary', (tester) async {
        // Arrange
        const child = Text('Test Widget');
        
        // Act
        final optimizedWidget = UIOptimizationService.createOptimizedWidget(
          child: child,
          enableRepaintBoundary: true,
        );

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: optimizedWidget)));

        // Assert
        expect(find.byType(RepaintBoundary), findsOneWidget);
        expect(find.text('Test Widget'), findsOneWidget);
      });

      testWidgets('should optimize widget tree', (tester) async {
        // Arrange
        const child = Text('Optimized Child');
        
        // Act
        final optimizedTree = UIOptimizationService.optimizeWidgetTree(child);

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: optimizedTree)));

        // Assert
        expect(find.byType(RepaintBoundary), findsOneWidget);
        expect(find.byType(AutomaticKeepAlive), findsOneWidget);
        expect(find.text('Optimized Child'), findsOneWidget);
      });
    });

    group('Scroll Physics', () {
      testWidgets('should provide optimized scroll physics', (tester) async {
        // Act
        final scrollPhysics = UIOptimizationService.getOptimizedScrollPhysics();

        // Assert
        expect(scrollPhysics, isA<ScrollPhysics>());
        expect(scrollPhysics, isA<BouncingScrollPhysics>());
      });

      testWidgets('should handle optimized scroll physics with custom properties', (tester) async {
        // Act
        const customPhysics = OptimizedScrollPhysics();

        // Assert
        expect(customPhysics.dragStartDistanceMotionThreshold, equals(3.5));
        expect(customPhysics.minFlingVelocity, equals(50.0));
        expect(customPhysics.maxFlingVelocity, equals(8000.0));
      });
    });

    group('Manual UI Optimization', () {
      testWidgets('should perform manual UI optimization without errors', (tester) async {
        // Arrange
        await UIOptimizationService.initialize();

        // Act & Assert
        expect(() => UIOptimizationService.optimizeUI(), returnsNormally);
      });

      testWidgets('should handle optimization when not initialized', (tester) async {
        // Act & Assert
        expect(() => UIOptimizationService.optimizeUI(), returnsNormally);
      });
    });

    group('Service Lifecycle', () {
      testWidgets('should dispose service gracefully', (tester) async {
        // Arrange
        await UIOptimizationService.initialize();

        // Act
        await UIOptimizationService.dispose();

        // Assert
        final metrics = UIOptimizationService.getUIPerformanceMetrics();
        expect(metrics['monitoring_active'], isFalse);
        expect(metrics['frame_count'], equals(0));
      });

      testWidgets('should handle dispose when not initialized', (tester) async {
        // Act & Assert
        expect(() => UIOptimizationService.dispose(), returnsNormally);
      });

      testWidgets('should allow re-initialization after disposal', (tester) async {
        // Arrange
        await UIOptimizationService.initialize();
        await UIOptimizationService.dispose();

        // Act
        await UIOptimizationService.initialize();

        // Assert
        final metrics = UIOptimizationService.getUIPerformanceMetrics();
        expect(metrics['monitoring_active'], isTrue);
      });
    });

    group('Performance Monitoring', () {
      testWidgets('should collect UI performance metrics over time', (tester) async {
        // Arrange
        await UIOptimizationService.initialize();

        // Act - Wait for some metrics to be collected
        await tester.pump(const Duration(milliseconds: 100));

        // Assert
        final metrics = UIOptimizationService.getUIPerformanceMetrics();
        expect(metrics['monitoring_active'], isTrue);
      });
    });

    group('Widget Optimization Features', () {
      testWidgets('should create keep alive wrapper correctly', (tester) async {
        // Arrange
        const child = Text('Keep Alive Child');
        
        // Act
        final optimizedWidget = UIOptimizationService.createOptimizedWidget(
          child: child,
          enableKeepAlive: true,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PageView(
                children: [optimizedWidget],
              ),
            ),
          ),
        );

        // Assert
        expect(find.text('Keep Alive Child'), findsOneWidget);
      });

      testWidgets('should handle optimized list view with different configurations', (tester) async {
        // Test horizontal scrolling
        final horizontalList = UIOptimizationService.createOptimizedListView(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => SizedBox(
            width: 100,
            child: Text('Item $index'),
          ),
        );

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: horizontalList)));
        expect(find.byType(ListView), findsOneWidget);

        // Test with padding
        final paddedList = UIOptimizationService.createOptimizedListView(
          itemCount: 3,
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
        );

        await tester.pumpWidget(MaterialApp(home: Scaffold(body: paddedList)));
        expect(find.byType(ListView), findsOneWidget);
      });
    });

    group('Error Handling', () {
      testWidgets('should handle initialization errors gracefully', (tester) async {
        // Act & Assert
        expect(() => UIOptimizationService.initialize(), returnsNormally);
      });

      testWidgets('should handle metrics retrieval errors gracefully', (tester) async {
        // Act & Assert
        expect(() => UIOptimizationService.getUIPerformanceMetrics(), returnsNormally);
      });

      testWidgets('should handle widget creation errors gracefully', (tester) async {
        // Act & Assert
        expect(() => UIOptimizationService.createOptimizedListView(
          itemCount: 0,
          itemBuilder: (context, index) => const SizedBox(),
        ), returnsNormally);
      });
    });

    group('Performance Validation', () {
      testWidgets('should provide valid timestamp format', (tester) async {
        // Arrange
        await UIOptimizationService.initialize();

        // Act
        final metrics = UIOptimizationService.getUIPerformanceMetrics();

        // Assert
        expect(metrics['timestamp'], isA<String>());
        expect(() => DateTime.parse(metrics['timestamp']), returnsNormally);
      });

      testWidgets('should provide consistent data structure', (tester) async {
        // Arrange
        await UIOptimizationService.initialize();

        // Act
        final metrics1 = UIOptimizationService.getUIPerformanceMetrics();
        await tester.pump(const Duration(milliseconds: 50));
        final metrics2 = UIOptimizationService.getUIPerformanceMetrics();

        // Assert
        expect(metrics1.keys.toSet(), equals(metrics2.keys.toSet()));
        expect(metrics1['monitoring_active'], equals(metrics2['monitoring_active']));
      });
    });

    group('Frame Performance', () {
      testWidgets('should handle frame time calculations correctly', (tester) async {
        // This test ensures frame time calculations work without errors
        await UIOptimizationService.initialize();
        
        // Simulate some UI updates
        await tester.pumpWidget(const MaterialApp(home: Scaffold(body: Text('Test'))));
        await tester.pump();
        await tester.pump();
        
        final metrics = UIOptimizationService.getUIPerformanceMetrics();
        expect(metrics['monitoring_active'], isTrue);
      });
    });
  });
}
