import 'dart:convert';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Decoration Item Types
enum DecorationType {
  plant,      // Cây cảnh
  light,      // Đèn
  book,       // Sách
  furniture,  // Đồ nội thất
  art,        // Tranh ảnh
  toy,        // Đồ chơi
  food,       // Thức ăn
  accessory,  // Phụ kiện
}

/// Decoration Item
class DecorationItem {
  final String id;
  final String name;
  final String description;
  final DecorationType type;
  final int price;
  final String iconPath;
  final String animationPath;
  final List<String> tags;
  final bool isUnlocked;
  final DateTime? purchaseDate;

  const DecorationItem({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.price,
    required this.iconPath,
    required this.animationPath,
    required this.tags,
    this.isUnlocked = false,
    this.purchaseDate,
  });

  DecorationItem copyWith({
    String? id,
    String? name,
    String? description,
    DecorationType? type,
    int? price,
    String? iconPath,
    String? animationPath,
    List<String>? tags,
    bool? isUnlocked,
    DateTime? purchaseDate,
  }) {
    return DecorationItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      price: price ?? this.price,
      iconPath: iconPath ?? this.iconPath,
      animationPath: animationPath ?? this.animationPath,
      tags: tags ?? this.tags,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      purchaseDate: purchaseDate ?? this.purchaseDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type.name,
      'price': price,
      'iconPath': iconPath,
      'animationPath': animationPath,
      'tags': tags,
      'isUnlocked': isUnlocked,
      'purchaseDate': purchaseDate?.toIso8601String(),
    };
  }

  factory DecorationItem.fromJson(Map<String, dynamic> json) {
    return DecorationItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      type: DecorationType.values.firstWhere((e) => e.name == json['type']),
      price: json['price'],
      iconPath: json['iconPath'],
      animationPath: json['animationPath'],
      tags: List<String>.from(json['tags']),
      isUnlocked: json['isUnlocked'] ?? false,
      purchaseDate: json['purchaseDate'] != null 
          ? DateTime.parse(json['purchaseDate'])
          : null,
    );
  }
}

/// Placed Decoration (item placed in the environment)
class PlacedDecoration {
  final String id;
  final String decorationItemId;
  final double x;
  final double y;
  final double rotation;
  final double scale;
  final DateTime placedAt;

  const PlacedDecoration({
    required this.id,
    required this.decorationItemId,
    required this.x,
    required this.y,
    this.rotation = 0.0,
    this.scale = 1.0,
    required this.placedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'decorationItemId': decorationItemId,
      'x': x,
      'y': y,
      'rotation': rotation,
      'scale': scale,
      'placedAt': placedAt.toIso8601String(),
    };
  }

  factory PlacedDecoration.fromJson(Map<String, dynamic> json) {
    return PlacedDecoration(
      id: json['id'],
      decorationItemId: json['decorationItemId'],
      x: json['x'].toDouble(),
      y: json['y'].toDouble(),
      rotation: json['rotation']?.toDouble() ?? 0.0,
      scale: json['scale']?.toDouble() ?? 1.0,
      placedAt: DateTime.parse(json['placedAt']),
    );
  }
}

/// Decoration System State
class DecorationSystemState {
  final int gold;
  final List<DecorationItem> availableItems;
  final List<PlacedDecoration> placedDecorations;
  final bool isLoading;
  final String? error;

  const DecorationSystemState({
    this.gold = 0,
    this.availableItems = const [],
    this.placedDecorations = const [],
    this.isLoading = false,
    this.error,
  });

  DecorationSystemState copyWith({
    int? gold,
    List<DecorationItem>? availableItems,
    List<PlacedDecoration>? placedDecorations,
    bool? isLoading,
    String? error,
  }) {
    return DecorationSystemState(
      gold: gold ?? this.gold,
      availableItems: availableItems ?? this.availableItems,
      placedDecorations: placedDecorations ?? this.placedDecorations,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

/// Decoration System Service
class DecorationSystemService extends StateNotifier<DecorationSystemState> {
  final SharedPreferences _prefs;
  final Random _random = Random();

  DecorationSystemService(this._prefs) : super(const DecorationSystemState()) {
    _loadState();
    _initializeDefaultItems();
  }

  /// Load state from SharedPreferences
  Future<void> _loadState() async {
    try {
      final gold = _prefs.getInt('decoration_gold') ?? 100; // Start with 100 gold
      final availableItemsJson = _prefs.getStringList('decoration_available_items') ?? [];
      final placedDecorationsJson = _prefs.getStringList('decoration_placed_items') ?? [];

      final availableItems = availableItemsJson
          .map((json) => DecorationItem.fromJson(jsonDecode(json)))
          .toList();

      final placedDecorations = placedDecorationsJson
          .map((json) => PlacedDecoration.fromJson(jsonDecode(json)))
          .toList();

      state = state.copyWith(
        gold: gold,
        availableItems: availableItems,
        placedDecorations: placedDecorations,
      );
    } catch (e) {
      state = state.copyWith(error: 'Failed to load decoration state: $e');
    }
  }

  /// Save state to SharedPreferences
  Future<void> _saveState() async {
    try {
      await _prefs.setInt('decoration_gold', state.gold);
      
      final availableItemsJson = state.availableItems
          .map((item) => jsonEncode(item.toJson()))
          .toList();
      await _prefs.setStringList('decoration_available_items', availableItemsJson);

      final placedDecorationsJson = state.placedDecorations
          .map((decoration) => jsonEncode(decoration.toJson()))
          .toList();
      await _prefs.setStringList('decoration_placed_items', placedDecorationsJson);
    } catch (e) {
      state = state.copyWith(error: 'Failed to save decoration state: $e');
    }
  }

  /// Initialize default decoration items
  void _initializeDefaultItems() {
    if (state.availableItems.isNotEmpty) return;

    final defaultItems = [
      // Plants
      DecorationItem(
        id: 'plant_1',
        name: 'Cây xương rồng nhỏ',
        description: 'Một cây xương rồng dễ thương, không cần tưới nước nhiều!',
        type: DecorationType.plant,
        price: 50,
        iconPath: 'assets/decorations/plant_1.png',
        animationPath: 'assets/lottie/plant_1.json',
        tags: ['nature', 'cute', 'low-maintenance'],
        isUnlocked: true,
      ),
      DecorationItem(
        id: 'plant_2',
        name: 'Cây hoa hồng',
        description: 'Một cây hoa hồng đỏ thắm, tỏa hương thơm ngát.',
        type: DecorationType.plant,
        price: 120,
        iconPath: 'assets/decorations/plant_2.png',
        animationPath: 'assets/lottie/plant_2.json',
        tags: ['nature', 'beautiful', 'fragrant'],
      ),
      DecorationItem(
        id: 'plant_3',
        name: 'Cây bonsai',
        description: 'Một cây bonsai tinh tế, thể hiện sự kiên nhẫn.',
        type: DecorationType.plant,
        price: 300,
        iconPath: 'assets/decorations/plant_3.png',
        animationPath: 'assets/lottie/plant_3.json',
        tags: ['nature', 'elegant', 'zen'],
      ),

      // Lights
      DecorationItem(
        id: 'light_1',
        name: 'Đèn bàn nhỏ',
        description: 'Một chiếc đèn bàn ấm áp, tạo không khí thư giãn.',
        type: DecorationType.light,
        price: 80,
        iconPath: 'assets/decorations/light_1.png',
        animationPath: 'assets/lottie/light_1.json',
        tags: ['warm', 'cozy', 'reading'],
        isUnlocked: true,
      ),
      DecorationItem(
        id: 'light_2',
        name: 'Đèn LED màu',
        description: 'Đèn LED đổi màu, tạo không gian sáng tạo.',
        type: DecorationType.light,
        price: 150,
        iconPath: 'assets/decorations/light_2.png',
        animationPath: 'assets/lottie/light_2.json',
        tags: ['colorful', 'creative', 'modern'],
      ),

      // Books
      DecorationItem(
        id: 'book_1',
        name: 'Sách triết học',
        description: 'Một cuốn sách triết học cổ điển, mở mang tâm trí.',
        type: DecorationType.book,
        price: 60,
        iconPath: 'assets/decorations/book_1.png',
        animationPath: 'assets/lottie/book_1.json',
        tags: ['knowledge', 'wisdom', 'classic'],
        isUnlocked: true,
      ),
      DecorationItem(
        id: 'book_2',
        name: 'Tạp chí nghệ thuật',
        description: 'Tạp chí nghệ thuật đương đại, truyền cảm hứng.',
        type: DecorationType.book,
        price: 40,
        iconPath: 'assets/decorations/book_2.png',
        animationPath: 'assets/lottie/book_2.json',
        tags: ['art', 'inspiration', 'contemporary'],
      ),

      // Furniture
      DecorationItem(
        id: 'furniture_1',
        name: 'Ghế đọc sách',
        description: 'Một chiếc ghế êm ái, hoàn hảo cho việc đọc sách.',
        type: DecorationType.furniture,
        price: 200,
        iconPath: 'assets/decorations/furniture_1.png',
        animationPath: 'assets/lottie/furniture_1.json',
        tags: ['comfortable', 'reading', 'relaxing'],
      ),
      DecorationItem(
        id: 'furniture_2',
        name: 'Bàn làm việc',
        description: 'Bàn làm việc gọn gàng, tăng năng suất.',
        type: DecorationType.furniture,
        price: 250,
        iconPath: 'assets/decorations/furniture_2.png',
        animationPath: 'assets/lottie/furniture_2.json',
        tags: ['productive', 'organized', 'work'],
      ),

      // Art
      DecorationItem(
        id: 'art_1',
        name: 'Tranh phong cảnh',
        description: 'Bức tranh phong cảnh đẹp, mang lại cảm giác bình yên.',
        type: DecorationType.art,
        price: 180,
        iconPath: 'assets/decorations/art_1.png',
        animationPath: 'assets/lottie/art_1.json',
        tags: ['peaceful', 'beautiful', 'nature'],
      ),
      DecorationItem(
        id: 'art_2',
        name: 'Tranh trừu tượng',
        description: 'Tranh trừu tượng hiện đại, kích thích tư duy.',
        type: DecorationType.art,
        price: 220,
        iconPath: 'assets/decorations/art_2.png',
        animationPath: 'assets/lottie/art_2.json',
        tags: ['abstract', 'modern', 'thought-provoking'],
      ),

      // Toys
      DecorationItem(
        id: 'toy_1',
        name: 'Gấu bông',
        description: 'Chú gấu bông dễ thương, mang lại niềm vui.',
        type: DecorationType.toy,
        price: 70,
        iconPath: 'assets/decorations/toy_1.png',
        animationPath: 'assets/lottie/toy_1.json',
        tags: ['cute', 'comforting', 'fun'],
        isUnlocked: true,
      ),
      DecorationItem(
        id: 'toy_2',
        name: 'Robot nhỏ',
        description: 'Robot nhỏ thông minh, có thể di chuyển.',
        type: DecorationType.toy,
        price: 400,
        iconPath: 'assets/decorations/toy_2.png',
        animationPath: 'assets/lottie/toy_2.json',
        tags: ['smart', 'interactive', 'tech'],
      ),

      // Food
      DecorationItem(
        id: 'food_1',
        name: 'Bánh ngọt',
        description: 'Chiếc bánh ngọt thơm ngon, tạo cảm giác ấm áp.',
        type: DecorationType.food,
        price: 30,
        iconPath: 'assets/decorations/food_1.png',
        animationPath: 'assets/lottie/food_1.json',
        tags: ['sweet', 'warm', 'comforting'],
        isUnlocked: true,
      ),
      DecorationItem(
        id: 'food_2',
        name: 'Trái cây tươi',
        description: 'Giỏ trái cây tươi ngon, tốt cho sức khỏe.',
        type: DecorationType.food,
        price: 45,
        iconPath: 'assets/decorations/food_2.png',
        animationPath: 'assets/lottie/food_2.json',
        tags: ['healthy', 'fresh', 'natural'],
      ),

      // Accessories
      DecorationItem(
        id: 'accessory_1',
        name: 'Khung ảnh',
        description: 'Khung ảnh đẹp, lưu giữ kỷ niệm.',
        type: DecorationType.accessory,
        price: 35,
        iconPath: 'assets/decorations/accessory_1.png',
        animationPath: 'assets/lottie/accessory_1.json',
        tags: ['memories', 'personal', 'sentimental'],
        isUnlocked: true,
      ),
      DecorationItem(
        id: 'accessory_2',
        name: 'Đồng hồ treo tường',
        description: 'Đồng hồ cổ điển, vừa đẹp vừa hữu ích.',
        type: DecorationType.accessory,
        price: 90,
        iconPath: 'assets/decorations/accessory_2.png',
        animationPath: 'assets/lottie/accessory_2.json',
        tags: ['classic', 'useful', 'elegant'],
      ),
    ];

    state = state.copyWith(availableItems: defaultItems);
    _saveState();
  }

  /// Add gold (earned from completing tasks)
  Future<void> addGold(int amount) async {
    state = state.copyWith(gold: state.gold + amount);
    await _saveState();
  }

  /// Purchase a decoration item
  Future<bool> purchaseItem(String itemId) async {
    final item = state.availableItems.firstWhere(
      (item) => item.id == itemId,
      orElse: () => throw Exception('Item not found'),
    );

    if (state.gold < item.price) {
      state = state.copyWith(error: 'Not enough gold!');
      return false;
    }

    if (item.isUnlocked) {
      state = state.copyWith(error: 'Item already purchased!');
      return false;
    }

    // Update item as unlocked
    final updatedItems = state.availableItems.map((i) {
      if (i.id == itemId) {
        return i.copyWith(
          isUnlocked: true,
          purchaseDate: DateTime.now(),
        );
      }
      return i;
    }).toList();

    state = state.copyWith(
      gold: state.gold - item.price,
      availableItems: updatedItems,
    );

    await _saveState();
    return true;
  }

  /// Place a decoration in the environment
  Future<void> placeDecoration(String itemId, double x, double y) async {
    final item = state.availableItems.firstWhere(
      (item) => item.id == itemId && item.isUnlocked,
      orElse: () => throw Exception('Item not found or not unlocked'),
    );

    final placedDecoration = PlacedDecoration(
      id: '${itemId}_${DateTime.now().millisecondsSinceEpoch}',
      decorationItemId: itemId,
      x: x,
      y: y,
      placedAt: DateTime.now(),
    );

    state = state.copyWith(
      placedDecorations: [...state.placedDecorations, placedDecoration],
    );

    await _saveState();
  }

  /// Remove a decoration from the environment
  Future<void> removeDecoration(String placedDecorationId) async {
    state = state.copyWith(
      placedDecorations: state.placedDecorations
          .where((decoration) => decoration.id != placedDecorationId)
          .toList(),
    );

    await _saveState();
  }

  /// Get available items by type
  List<DecorationItem> getItemsByType(DecorationType type) {
    return state.availableItems.where((item) => item.type == type).toList();
  }

  /// Get unlocked items
  List<DecorationItem> getUnlockedItems() {
    return state.availableItems.where((item) => item.isUnlocked).toList();
  }

  /// Get items by price range
  List<DecorationItem> getItemsByPriceRange(int minPrice, int maxPrice) {
    return state.availableItems.where((item) => 
        item.price >= minPrice && item.price <= maxPrice).toList();
  }

  /// Search items by tags
  List<DecorationItem> searchItemsByTags(List<String> tags) {
    return state.availableItems.where((item) => 
        item.tags.any((tag) => tags.contains(tag))).toList();
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// Provider for Decoration System Service
final decorationSystemProvider = StateNotifierProvider<DecorationSystemService, DecorationSystemState>((ref) {
  // This would need to be injected properly in a real app
  throw UnimplementedError('DecorationSystemService requires SharedPreferences injection');
});

/// Provider for SharedPreferences
final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

/// Provider for Decoration System Service with SharedPreferences
final decorationSystemWithPrefsProvider = StateNotifierProvider<DecorationSystemService, DecorationSystemState>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider).value;
  if (prefs == null) {
    throw StateError('SharedPreferences not available');
  }
  return DecorationSystemService(prefs);
});
