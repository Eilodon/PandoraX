import 'package:flutter/material.dart';
import 'package:pandora_ui/pandora_ui.dart';

/// Simple main entry point cho demo không cần dependencies phức tạp
void main() {
  runApp(SimpleNotesApp());
}

class SimpleNotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes Demo',
      theme: createPandoraLightTheme(),
      darkTheme: createPandoraTheme(),
      themeMode: ThemeMode.system,
      home: SimpleNotesScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SimpleNote {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final bool pinned;

  SimpleNote({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    this.pinned = false,
  });
}

class SimpleNotesScreen extends StatefulWidget {
  @override
  State<SimpleNotesScreen> createState() => _SimpleNotesScreenState();
}

class _SimpleNotesScreenState extends State<SimpleNotesScreen> {
  List<SimpleNote> notes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadSampleNotes();
  }

  void loadSampleNotes() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        notes = generateSampleNotes();
        isLoading = false;
      });
    });
  }

  List<SimpleNote> generateSampleNotes() {
    final now = DateTime.now();
    return [
      SimpleNote(
        id: '1',
        title: '🚀 Flutter Notes App Demo',
        content: 'Ứng dụng ghi chú thông minh với:\n• AI Chat\n• Speech Recognition\n• Cloud Sync\n• Beautiful UI',
        createdAt: now.subtract(Duration(days: 2)),
        pinned: true,
      ),
      SimpleNote(
        id: '2',
        title: '📚 Learning Plan',
        content: 'Kế hoạch học Flutter và Dart:\n1. Widget basics\n2. State management\n3. Navigation\n4. API integration',
        createdAt: now.subtract(Duration(days: 1)),
      ),
      SimpleNote(
        id: '3',
        title: '🛒 Shopping List',
        content: 'Cần mua:\n• Sữa tươi\n• Bánh mì\n• Trứng gà\n• Rau củ',
        createdAt: now.subtract(Duration(hours: 12)),
      ),
      SimpleNote(
        id: '4',
        title: '💡 App Ideas',
        content: 'Ý tưởng ứng dụng mới:\n• Smart Home Controller\n• Language Learning Tool\n• Productivity Suite',
        createdAt: now.subtract(Duration(hours: 6)),
        pinned: true,
      ),
      SimpleNote(
        id: '5',
        title: '🎯 Goals for 2025',
        content: 'Mục tiêu năm 2025:\n• Launch 3 Flutter apps\n• Learn AI/ML\n• Contribute to open source\n• Build a team',
        createdAt: now.subtract(Duration(hours: 2)),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.note, color: Colors.blue),
            SizedBox(width: 8),
            Text('Notes Demo'),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.orange.shade300),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.science, size: 16, color: Colors.orange.shade700),
                SizedBox(width: 4),
                Text(
                  'DEMO',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Loading demo notes...',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'This is a demo version with sample data',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            )
          : notes.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.note_add, size: 80, color: Colors.grey[400]),
                      SizedBox(height: 24),
                      Text(
                        'No notes yet',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Tap the + button to create your first note',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(Duration(seconds: 1));
                    setState(() {
                      notes = generateSampleNotes();
                    });
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      final note = notes[index];
                      return Card(
                        elevation: 2,
                        margin: EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SimpleNoteDetailScreen(note: note),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Theme.of(context).primaryColor,
                                      child: Text(
                                        note.title.isNotEmpty ? note.title[0].toUpperCase() : '?',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              if (note.pinned) ...[
                                                Icon(Icons.push_pin, size: 16, color: Colors.orange),
                                                SizedBox(width: 4),
                                              ],
                                              Expanded(
                                                child: Text(
                                                  note.title,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            '${note.createdAt.day}/${note.createdAt.month}/${note.createdAt.year}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    PopupMenuButton<String>(
                                      onSelected: (value) {
                                        switch (value) {
                                          case 'edit':
                                            _showEditDialog(note);
                                            break;
                                          case 'delete':
                                            _deleteNote(note);
                                            break;
                                          case 'pin':
                                            _togglePin(note);
                                            break;
                                        }
                                      },
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          value: 'edit',
                                          child: Row(
                                            children: [
                                              Icon(Icons.edit, size: 18),
                                              SizedBox(width: 8),
                                              Text('Edit'),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: 'pin',
                                          child: Row(
                                            children: [
                                              Icon(
                                                note.pinned ? Icons.push_pin_outlined : Icons.push_pin,
                                                size: 18,
                                              ),
                                              SizedBox(width: 8),
                                              Text(note.pinned ? 'Unpin' : 'Pin'),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: 'delete',
                                          child: Row(
                                            children: [
                                              Icon(Icons.delete, size: 18, color: Colors.red),
                                              SizedBox(width: 8),
                                              Text('Delete', style: TextStyle(color: Colors.red)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                Text(
                                  note.content,
                                  style: TextStyle(
                                    fontSize: 14,
                                    height: 1.4,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Voice Recording FAB
          FloatingActionButton(
            heroTag: "voice",
            mini: true,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SimpleVoiceScreen()),
              );
            },
            backgroundColor: Colors.purple,
            child: Icon(Icons.mic, color: Colors.white),
            tooltip: 'Voice Recording Demo',
          ),
          SizedBox(height: 8),
          
          // AI Chat FAB
          FloatingActionButton(
            heroTag: "chat",
            mini: true,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SimpleAiChatScreen()),
              );
            },
            backgroundColor: Colors.blue,
            child: Icon(Icons.chat, color: Colors.white),
            tooltip: 'AI Chat Demo',
          ),
          SizedBox(height: 8),
          
          // Add Note FAB
          FloatingActionButton(
            heroTag: "add",
            onPressed: () {
              _showAddNoteDialog();
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.add, color: Colors.white),
            tooltip: 'Add Note',
          ),
        ],
      ),
    );
  }

  void _showAddNoteDialog() {
    final titleController = TextEditingController();
    final contentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Create New Note'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                textCapitalization: TextCapitalization.sentences,
              ),
              SizedBox(height: 16),
              TextField(
                controller: contentController,
                decoration: InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.notes),
                ),
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                setState(() {
                  notes.insert(
                    0,
                    SimpleNote(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: titleController.text,
                      content: contentController.text,
                      createdAt: DateTime.now(),
                    ),
                  );
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Note created successfully!')),
                );
              }
            },
            child: Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(SimpleNote note) {
    final titleController = TextEditingController(text: note.title);
    final contentController = TextEditingController(text: note.content);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Note'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: contentController,
                decoration: InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.notes),
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                final index = notes.indexWhere((n) => n.id == note.id);
                if (index != -1) {
                  notes[index] = SimpleNote(
                    id: note.id,
                    title: titleController.text,
                    content: contentController.text,
                    createdAt: note.createdAt,
                    pinned: note.pinned,
                  );
                }
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Note updated successfully!')),
              );
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteNote(SimpleNote note) {
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
          ElevatedButton(
            onPressed: () {
              setState(() {
                notes.removeWhere((n) => n.id == note.id);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Note deleted successfully!')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _togglePin(SimpleNote note) {
    setState(() {
      final index = notes.indexWhere((n) => n.id == note.id);
      if (index != -1) {
        notes[index] = SimpleNote(
          id: note.id,
          title: note.title,
          content: note.content,
          createdAt: note.createdAt,
          pinned: !note.pinned,
        );
        // Sort: pinned notes first
        notes.sort((a, b) {
          if (a.pinned && !b.pinned) return -1;
          if (!a.pinned && b.pinned) return 1;
          return b.createdAt.compareTo(a.createdAt);
        });
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(note.pinned ? 'Note unpinned' : 'Note pinned')),
    );
  }
}

class SimpleNoteDetailScreen extends StatelessWidget {
  final SimpleNote note;

  const SimpleNoteDetailScreen({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Share feature (Demo mode)')),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Edit mode (Demo)')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Note header
            Row(
              children: [
                if (note.pinned) ...[
                  Icon(Icons.push_pin, color: Colors.orange),
                  SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    note.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Created: ${note.createdAt.day}/${note.createdAt.month}/${note.createdAt.year} at ${note.createdAt.hour.toString().padLeft(2, '0')}:${note.createdAt.minute.toString().padLeft(2, '0')}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 24),
            
            // Note content
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Text(
                note.content,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  height: 1.6,
                ),
              ),
            ),
            SizedBox(height: 24),
            
            // AI Summary section
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.auto_awesome, color: Colors.blue),
                        SizedBox(width: 8),
                        Text(
                          'AI Summary',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Generate an AI-powered summary of this note to quickly understand the key points.',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _showAiSummaryDialog(context, note);
                        },
                        icon: Icon(Icons.auto_awesome),
                        label: Text('Generate Summary'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAiSummaryDialog(BuildContext context, SimpleNote note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.auto_awesome, color: Colors.blue),
            SizedBox(width: 8),
            Text('AI Summary'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'AI-Generated Summary:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Text(
                  'This note discusses "${note.title}" with ${note.content.split(' ').length} words. '
                  'Key themes include productivity, planning, and organization. '
                  'The content suggests actionable steps and clear objectives.\n\n'
                  '(This is a demo summary generated for demonstration purposes)',
                  style: TextStyle(height: 1.4),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Summary copied to clipboard!')),
              );
            },
            child: Text('Copy'),
          ),
        ],
      ),
    );
  }
}

class SimpleAiChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Chat Demo'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.smart_toy, size: 80, color: Colors.blue),
                  SizedBox(height: 24),
                  Text(
                    'AI Chat Assistant',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'This is a demo of the AI chat feature. In the full version, you can chat with AI to get help with your notes, generate content, and more.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 32),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Try asking:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text('• "Summarize my notes"'),
                        Text('• "Help me organize my ideas"'),
                        Text('• "Create a todo list"'),
                        Text('• "Generate content ideas"'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                FloatingActionButton(
                  mini: true,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('AI: Hello! I\'m ready to help you with your notes. (Demo mode)'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  },
                  child: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SimpleVoiceScreen extends StatefulWidget {
  @override
  State<SimpleVoiceScreen> createState() => _SimpleVoiceScreenState();
}

class _SimpleVoiceScreenState extends State<SimpleVoiceScreen>
    with TickerProviderStateMixin {
  bool isRecording = false;
  late AnimationController _animationController;
  String transcribedText = '';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voice Recording Demo'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Container(
                        width: 120 + (_animationController.value * 20),
                        height: 120 + (_animationController.value * 20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isRecording
                              ? Colors.purple.withValues(alpha: 0.3)
                              : Colors.purple.withValues(alpha: 0.1),
                          border: Border.all(
                            color: Colors.purple,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.mic,
                          size: 60,
                          color: Colors.purple,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 32),
                  Text(
                    isRecording ? 'Recording...' : 'Voice Recording Demo',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    isRecording
                        ? 'Speak clearly into your device microphone'
                        : 'Tap the button below to start recording',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 32),
                  if (transcribedText.isNotEmpty) ...[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.purple.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.purple.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Transcribed Text:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            transcribedText,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Create note from transcribed text
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Note created from voice recording!')),
                          );
                        },
                        icon: Icon(Icons.note_add),
                        label: Text('Create Note from Text'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _toggleRecording,
                icon: Icon(isRecording ? Icons.stop : Icons.mic),
                label: Text(isRecording ? 'Stop Recording' : 'Start Recording'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isRecording ? Colors.red : Colors.purple,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleRecording() {
    setState(() {
      isRecording = !isRecording;
    });

    if (isRecording) {
      _animationController.repeat(reverse: true);
      // Simulate recording for 3 seconds
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          isRecording = false;
          transcribedText = 'This is a demo transcription of your voice recording. '
              'In the full version, this would be the actual text from speech recognition.';
        });
        _animationController.stop();
      });
    } else {
      _animationController.stop();
    }
  }
}
