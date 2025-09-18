import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:design_tokens/design_tokens.dart';
import 'package:pandora_ui/pandora_ui.dart';
import 'package:core_utils/core_utils.dart';
import 'package:common_entities/common_entities.dart';
import '../providers/note_provider.dart';

/// Home screen for PandoraX
///
/// This is the main screen of the application, showcasing the
/// "Thân Tâm Hợp Nhất" philosophy through beautiful UI design.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    AppLogger.info('🏠 Home screen initialized');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  /// Build app bar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('PandoraX'),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: _onSearchPressed,
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: _onSettingsPressed,
        ),
      ],
    );
  }

  /// Build main body
  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildNotesTab();
      case 1:
        return _buildAiTab();
      case 2:
        return _buildVoiceTab();
      case 3:
        return _buildProfileTab();
      default:
        return _buildNotesTab();
    }
  }

  /// Build notes tab
  Widget _buildNotesTab() {
    return Padding(
      padding: PandoraSpacing.screenPaddingEdgeInsets,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Notes',
            style: PandoraTypography.headlineLarge,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _buildNotesList(),
          ),
        ],
      ),
    );
  }

  /// Build notes list
  Widget _buildNotesList() {
    return Consumer(
      builder: (context, ref, child) {
        final notesAsync = ref.watch(noteListProvider);

        return notesAsync.when(
          data: (notes) {
            if (notes.isEmpty) {
              return _buildEmptyState();
            }

            return RefreshIndicator(
              onRefresh: () async {
                await ref.read(noteNotifierProvider.notifier).refresh();
              },
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return _buildNoteCard(note);
                },
              ),
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
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
                  'Failed to load notes',
                  style: PandoraTypography.headlineSmall.copyWith(
                    color: PandoraColors.error,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  style: PandoraTypography.bodyMedium.copyWith(
                    color: PandoraColors.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    ref.read(noteNotifierProvider.notifier).refresh();
                  },
                  child: Text('Retry'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Build empty state
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.note_add,
            size: 64,
            color: PandoraColors.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'No notes yet',
            style: PandoraTypography.headlineSmall.copyWith(
              color: PandoraColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the + button to create your first note',
            style: PandoraTypography.bodyMedium.copyWith(
              color: PandoraColors.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Build note card
  Widget _buildNoteCard(Note note) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: note.isPinned
            ? Icon(
                Icons.push_pin,
                color: PandoraColors.primary,
                size: 20,
              )
            : null,
        title: Text(
          note.title,
          style: PandoraTypography.titleMedium,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.preview,
              style: PandoraTypography.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (note.category != null || note.tags != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  if (note.category != null) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: PandoraColors.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        note.category!,
                        style: PandoraTypography.labelSmall.copyWith(
                          color: PandoraColors.onPrimaryContainer,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  if (note.tags != null && note.tags!.isNotEmpty) ...[
                    Expanded(
                      child: Wrap(
                        spacing: 4,
                        children: note.tags!.take(2).map((tag) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: PandoraColors.secondaryContainer,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '#$tag',
                            style: PandoraTypography.labelSmall.copyWith(
                              color: PandoraColors.onSecondaryContainer,
                            ),
                          ),
                        )).toList(),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) => _onNoteAction(value, note),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'pin',
              child: Row(
                children: [
                  Icon(
                    note.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(note.isPinned ? 'Unpin' : 'Pin'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit, size: 16),
                  const SizedBox(width: 8),
                  Text('Edit'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, size: 16, color: PandoraColors.error),
                  const SizedBox(width: 8),
                  Text('Delete', style: TextStyle(color: PandoraColors.error)),
                ],
              ),
            ),
          ],
          child: Icon(
            Icons.more_vert,
            color: PandoraColors.onSurfaceVariant,
          ),
        ),
        onTap: () => _onNoteTapped(note),
      ),
    );
  }

  /// Build AI tab
  Widget _buildAiTab() {
    return Padding(
      padding: PandoraSpacing.screenPaddingEdgeInsets,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AI Assistant',
            style: PandoraTypography.headlineLarge,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.smart_toy,
                    size: 64,
                    color: PandoraColors.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'AI Features Coming Soon',
                    style: PandoraTypography.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Chat with AI, get summaries, and more',
                    style: PandoraTypography.bodyMedium.copyWith(
                      color: PandoraColors.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build voice tab
  Widget _buildVoiceTab() {
    return Padding(
      padding: PandoraSpacing.screenPaddingEdgeInsets,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Voice Notes',
            style: PandoraTypography.headlineLarge,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.mic,
                    size: 64,
                    color: PandoraColors.secondary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Voice Features Coming Soon',
                    style: PandoraTypography.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Record voice notes and convert to text',
                    style: PandoraTypography.bodyMedium.copyWith(
                      color: PandoraColors.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build profile tab
  Widget _buildProfileTab() {
    return Padding(
      padding: PandoraSpacing.screenPaddingEdgeInsets,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Profile',
            style: PandoraTypography.headlineLarge,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: PandoraColors.primary,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: PandoraColors.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'User Profile',
                    style: PandoraTypography.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Manage your account and settings',
                    style: PandoraTypography.bodyMedium.copyWith(
                      color: PandoraColors.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build bottom navigation bar
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onTabTapped,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: PandoraColors.primary,
      unselectedItemColor: PandoraColors.onSurfaceVariant,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.note),
          label: 'Notes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.smart_toy),
          label: 'AI',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mic),
          label: 'Voice',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }

  /// Build floating action button
  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: _onCreateNotePressed,
      backgroundColor: PandoraColors.primary,
      foregroundColor: PandoraColors.onPrimary,
      child: const Icon(Icons.add),
    );
  }

  /// Handle tab tap
  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /// Handle search pressed
  void _onSearchPressed() {
    AppLogger.info('🔍 Search pressed');
    // TODO: Implement search functionality
  }

  /// Handle settings pressed
  void _onSettingsPressed() {
    AppLogger.info('⚙️ Settings pressed');
    // TODO: Implement settings functionality
  }

  /// Handle create note pressed
  void _onCreateNotePressed() {
    AppLogger.info('➕ Create note pressed');
    // TODO: Implement create note functionality
  }

  /// Handle note tapped
  void _onNoteTapped(Note note) {
    AppLogger.info('📝 Note tapped: ${note.title}');
    // TODO: Implement note detail functionality
    _showNoteDetail(note);
  }

  /// Handle note action
  void _onNoteAction(String action, Note note) {
    switch (action) {
      case 'pin':
        _togglePin(note);
        break;
      case 'edit':
        _editNote(note);
        break;
      case 'delete':
        _deleteNote(note);
        break;
    }
  }

  /// Show note detail
  void _showNoteDetail(Note note) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          padding: PandoraSpacing.screenPaddingEdgeInsets,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: PandoraColors.outline,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                note.title,
                style: PandoraTypography.headlineMedium,
              ),
              const SizedBox(height: 8),
              if (note.category != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: PandoraColors.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    note.category!,
                    style: PandoraTypography.labelMedium.copyWith(
                      color: PandoraColors.onPrimaryContainer,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Text(
                    note.content,
                    style: PandoraTypography.bodyLarge,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Toggle pin status
  void _togglePin(Note note) {
    // TODO: Implement pin toggle
    AppLogger.info('📌 Toggle pin for note: ${note.title}');
  }

  /// Edit note
  void _editNote(Note note) {
    // TODO: Implement note editing
    AppLogger.info('✏️ Edit note: ${note.title}');
  }

  /// Delete note
  void _deleteNote(Note note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Note'),
        content: Text('Are you sure you want to delete "${note.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement note deletion
              AppLogger.info('🗑️ Delete note: ${note.title}');
            },
            child: Text('Delete', style: TextStyle(color: PandoraColors.error)),
          ),
        ],
      ),
    );
  }
}
