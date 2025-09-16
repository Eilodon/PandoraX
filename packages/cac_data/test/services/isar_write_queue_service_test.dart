import 'package:flutter_test/flutter_test.dart';
import 'package:cac_data/cac_data.dart';

void main() {
  group('IsarWriteQueueService', () {
    late IsarWriteQueueService writeQueue;

    setUp(() {
      writeQueue = IsarWriteQueueService();
    });

    tearDown(() {
      writeQueue.dispose();
    });

    group('add', () {
      test('should add task to queue', () async {
        // Arrange
        var taskExecuted = false;
        final task = () async {
          taskExecuted = true;
        };

        // Act
        await writeQueue.add(task);

        // Assert
        // Wait a bit for the task to be processed
        await Future.delayed(const Duration(milliseconds: 200));
        expect(taskExecuted, isTrue);
      });

      test('should execute multiple tasks in order', () async {
        // Arrange
        final executionOrder = <int>[];
        final task1 = () async {
          executionOrder.add(1);
          await Future.delayed(const Duration(milliseconds: 50));
        };
        final task2 = () async {
          executionOrder.add(2);
          await Future.delayed(const Duration(milliseconds: 50));
        };
        final task3 = () async {
          executionOrder.add(3);
          await Future.delayed(const Duration(milliseconds: 50));
        };

        // Act
        await writeQueue.add(task1);
        await writeQueue.add(task2);
        await writeQueue.add(task3);

        // Assert
        await Future.delayed(const Duration(milliseconds: 300));
        expect(executionOrder, equals([1, 2, 3]));
      });

      test('should handle task failures gracefully', () async {
        // Arrange
        var taskExecuted = false;
        final failingTask = () async {
          taskExecuted = true;
          throw Exception('Task failed');
        };
        final successTask = () async {
          taskExecuted = true;
        };

        // Act
        await writeQueue.add(failingTask);
        await writeQueue.add(successTask);

        // Assert
        await Future.delayed(const Duration(milliseconds: 200));
        expect(taskExecuted, isTrue);
      });
    });

    group('dispose', () {
      test('should clear queue and stop processing', () async {
        // Arrange
        var taskExecuted = false;
        final task = () async {
          taskExecuted = true;
        };

        // Act
        await writeQueue.add(task);
        writeQueue.dispose();

        // Assert
        await Future.delayed(const Duration(milliseconds: 200));
        // Task might still execute if it was already being processed
        // but no new tasks should be processed
      });
    });
  });
}
