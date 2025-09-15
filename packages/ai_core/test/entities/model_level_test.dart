import 'package:flutter_test/flutter_test.dart';
import 'package:ai_core/ai_core.dart';

void main() {
  group('ModelLevel', () {
    test('should have correct properties for tiny model', () {
      expect(ModelLevel.tiny.name, 'tiny');
      expect(ModelLevel.tiny.sizeBytes, 50 * 1024 * 1024);
      expect(ModelLevel.tiny.modelId, 'phi-3-tiny');
      expect(ModelLevel.tiny.description, 'Basic tasks - Quick responses, simple summaries');
    });

    test('should have correct properties for mini model', () {
      expect(ModelLevel.mini.name, 'mini');
      expect(ModelLevel.mini.sizeBytes, 200 * 1024 * 1024);
      expect(ModelLevel.mini.modelId, 'phi-3-mini');
      expect(ModelLevel.mini.description, 'Intermediate tasks - Chat conversations, content enhancement');
    });

    test('should have correct properties for full model', () {
      expect(ModelLevel.full.name, 'full');
      expect(ModelLevel.full.sizeBytes, 850 * 1024 * 1024);
      expect(ModelLevel.full.modelId, 'phi-3-full');
      expect(ModelLevel.full.description, 'Advanced tasks - Complex reasoning, creative writing');
    });

    test('should generate correct key', () {
      expect(ModelLevel.tiny.key, 'phi-3-tiny_2025.01');
      expect(ModelLevel.mini.key, 'phi-3-mini_2025.01');
      expect(ModelLevel.full.key, 'phi-3-full_2025.01');
    });

    test('should display correct size', () {
      expect(ModelLevel.tiny.sizeDisplay, '50 MB');
      expect(ModelLevel.mini.sizeDisplay, '200 MB');
      expect(ModelLevel.full.sizeDisplay, '850 MB');
    });

    test('should have correct display name', () {
      expect(ModelLevel.tiny.displayName, 'TINY');
      expect(ModelLevel.mini.displayName, 'MINI');
      expect(ModelLevel.full.displayName, 'FULL');
    });

    test('should include all models in all list', () {
      expect(ModelLevel.all.length, 3);
      expect(ModelLevel.all, contains(ModelLevel.tiny));
      expect(ModelLevel.all, contains(ModelLevel.mini));
      expect(ModelLevel.all, contains(ModelLevel.full));
    });
  });
}
