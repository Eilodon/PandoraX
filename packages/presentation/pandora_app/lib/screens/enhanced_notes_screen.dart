import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:design_tokens/design_tokens.dart';
import 'package:common_entities/common_entities.dart';
import '../providers/note_provider_v2.dart';
import '../widgets/note_card.dart';
import '../widgets/note_editor_dialog.dart';
import '../widgets/note_search_bar.dart';
import '../widgets/note_filter_chips.dart';

class EnhancedNotesScreen extends ConsumerStatefulWidget {
  const EnhancedNotesScreen({super.key});

  @override
  ConsumerState<EnhancedNotesScreen> createState() => _EnhancedNotesScreenState();
}

class _EnhancedNotesScreenState extends ConsumerState<EnhancedNotesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _sortBy = 'updatedAt';
  bool _sortAscending = false;
  String? _selectedCategory;
  String? _selectedTag;

  @override
  void initState() {
    super.initState();
    // Load notes when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(noteProvider.notifier).loadNotes();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noteState = ref.watch(noteProvider);
    final noteNotifier = ref.read(noteProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        backgroundColor: PandoraColors.primary,
        foregroundColor: PandoraColors.onPrimary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchDialog(),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(),
          ),
          PopupMenuButton<String>(
            onSelected: (value) => _handleSortOption(value),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'updatedAt',
                child: Text('Sort by Updated'),
              ),
              const PopupMenuItem(
                value: 'createdAt',
                child: Text('Sort by Created'),
              ),
              const PopupMenuItem(
                value: 'title',
                child: Text('Sort by Title'),
              ),
              const PopupMenuItem(
                value: 'priority',
                child: Text('Sort by Priority'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Bar
          Container(
            padding: const EdgeInsets.all(16),
            color: PandoraColors.surface,
            child: Column(
              children: [
                NoteSearchBar(
                  controller: _searchController,
                  onSearchChanged: (query) {
                    noteNotifier.searchNotes(query);
                  },
                ),
                const SizedBox(height: 12),
                NoteFilterChips(
                  selectedCategory: _selectedCategory,
                  selectedTag: _selectedTag,
                  onCategoryChanged: (category) {
                    setState(() => _selectedCategory = category);
                    noteNotifier.filterByCategory(category);
                  },
                  onTagChanged: (tag) {
                    setState(() => _selectedTag = tag);
                    noteNotifier.filterByTag(tag);
                  },
                ),
              ],
            ),
          ),
          
          // Notes List
          Expanded(
            child: _buildNotesList(noteState, noteNotifier),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateNoteDialog(),
        backgroundColor: PandoraColors.primary,
        child: const Icon(Icons.add, color: PandoraColors.onPrimary),
      ),
    );
  }

  Widget _buildNotesList(NoteState noteState, NoteNotifier noteNotifier) {
    if (noteState.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (noteState.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: PandoraColors.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Error loading notes',
              style: PandoraTextStyles.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              noteState.error!,
              style: PandoraTextStyles.bodyMedium.copyWith(
                color: PandoraColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => noteNotifier.loadNotes(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (noteState.filteredNotes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.note_add,
              size: 64,
              color: PandoraColors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              noteState.notes.isEmpty ? 'No notes yet' : 'No notes found',
              style: PandoraTextStyles.titleMedium.copyWith(
                color: PandoraColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              noteState.notes.isEmpty
                  ? 'Tap the + button to create your first note'
                  : 'Try adjusting your search or filters',
              style: PandoraTextStyles.bodyMedium.copyWith(
                color: PandoraColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    // Sort notes
    final sortedNotes = _sortNotes(noteState.filteredNotes);

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sortedNotes.length,
      itemBuilder: (context, index) {
        final note = sortedNotes[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: NoteCard(
            note: note,
            onTap: () => _showEditNoteDialog(note),
            onPin: () => noteNotifier.togglePin(note.id),
            onArchive: () => noteNotifier.toggleArchive(note.id),
            onDelete: () => _showDeleteConfirmation(note),
          ),
        );
      },
    );
  }

  List<Note> _sortNotes(List<Note> notes) {
    final sortedNotes = List<Note>.from(notes);
    
    switch (_sortBy) {
      case 'updatedAt':
        sortedNotes.sort((a, b) => _sortAscending
            ? a.updatedAt.compareTo(b.updatedAt)
            : b.updatedAt.compareTo(a.updatedAt));
        break;
      case 'createdAt':
        sortedNotes.sort((a, b) => _sortAscending
            ? a.createdAt.compareTo(b.createdAt)
            : b.createdAt.compareTo(a.createdAt));
        break;
      case 'title':
        sortedNotes.sort((a, b) => _sortAscending
            ? a.title.compareTo(b.title)
            : b.title.compareTo(a.title));
        break;
      case 'priority':
        sortedNotes.sort((a, b) => _sortAscending
            ? a.priority.compareTo(b.priority)
            : b.priority.compareTo(a.priority));
        break;
    }
    
    return sortedNotes;
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Notes'),
        content: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search by title or content...',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () {
              _searchController.clear();
              ref.read(noteProvider.notifier).searchNotes('');
              Navigator.pop(context);
            },
            child: const Text('Clear'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Notes'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('All Categories'),
              leading: Radio<String?>(
                value: null,
                groupValue: _selectedCategory,
                onChanged: (value) {
                  setState(() => _selectedCategory = value);
                  ref.read(noteProvider.notifier).filterByCategory(value);
                  Navigator.pop(context);
                },
              ),
            ),
            // TODO: Add category options
            ListTile(
              title: const Text('All Tags'),
              leading: Radio<String?>(
                value: null,
                groupValue: _selectedTag,
                onChanged: (value) {
                  setState(() => _selectedTag = value);
                  ref.read(noteProvider.notifier).filterByTag(value);
                  Navigator.pop(context);
                },
              ),
            ),
            // TODO: Add tag options
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _selectedCategory = null;
                _selectedTag = null;
              });
              ref.read(noteProvider.notifier).filterByCategory(null);
              ref.read(noteProvider.notifier).filterByTag(null);
              Navigator.pop(context);
            },
            child: const Text('Clear All'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _handleSortOption(String option) {
    setState(() {
      if (_sortBy == option) {
        _sortAscending = !_sortAscending;
      } else {
        _sortBy = option;
        _sortAscending = false;
      }
    });
  }

  void _showCreateNoteDialog() {
    showDialog(
      context: context,
      builder: (context) => NoteEditorDialog(
        onSave: (note) {
          ref.read(noteProvider.notifier).createNote(note);
        },
      ),
    );
  }

  void _showEditNoteDialog(Note note) {
    showDialog(
      context: context,
      builder: (context) => NoteEditorDialog(
        note: note,
        onSave: (updatedNote) {
          ref.read(noteProvider.notifier).updateNote(updatedNote);
        },
      ),
    );
  }

  void _showDeleteConfirmation(Note note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Note'),
        content: Text('Are you sure you want to delete "${note.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(noteProvider.notifier).deleteNote(note.id);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: PandoraColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
