import 'package:flutter/material.dart';
import 'package:design_tokens/design_tokens.dart';

class NoteFilterChips extends StatelessWidget {
  final String? selectedCategory;
  final String? selectedTag;
  final ValueChanged<String?> onCategoryChanged;
  final ValueChanged<String?> onTagChanged;

  const NoteFilterChips({
    super.key,
    required this.selectedCategory,
    required this.selectedTag,
    required this.onCategoryChanged,
    required this.onTagChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // Category filter
          FilterChip(
            label: const Text('All Categories'),
            selected: selectedCategory == null,
            onSelected: (selected) {
              onCategoryChanged(selected ? null : selectedCategory);
            },
            selectedColor: PandoraColors.primary.withValues(alpha: 0.2),
            checkmarkColor: PandoraColors.primary,
          ),
          
          const SizedBox(width: 8),
          
          // TODO: Add dynamic category chips
          // For now, show some example categories
          ...['Work', 'Personal', 'Ideas', 'Shopping'].map((category) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(category),
                selected: selectedCategory == category,
                onSelected: (selected) {
                  onCategoryChanged(selected ? category : null);
                },
                selectedColor: PandoraColors.primary.withValues(alpha: 0.2),
                checkmarkColor: PandoraColors.primary,
              ),
            );
          }),
          
          const SizedBox(width: 16),
          
          // Tag filter
          FilterChip(
            label: const Text('All Tags'),
            selected: selectedTag == null,
            onSelected: (selected) {
              onTagChanged(selected ? null : selectedTag);
            },
            selectedColor: PandoraColors.secondary.withValues(alpha: 0.2),
            checkmarkColor: PandoraColors.secondary,
          ),
          
          const SizedBox(width: 8),
          
          // TODO: Add dynamic tag chips
          // For now, show some example tags
          ...['urgent', 'important', 'todo', 'meeting'].map((tag) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(tag),
                selected: selectedTag == tag,
                onSelected: (selected) {
                  onTagChanged(selected ? tag : null);
                },
                selectedColor: PandoraColors.secondary.withValues(alpha: 0.2),
                checkmarkColor: PandoraColors.secondary,
              ),
            );
          }),
        ],
      ),
    );
  }
}
