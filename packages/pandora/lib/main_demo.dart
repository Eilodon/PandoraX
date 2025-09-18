import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pandora_ui/pandora_ui.dart';
import 'demo/demo_mode.dart';
import 'demo/demo_data.dart';

/// Main entry point cho demo mode - không cần Firebase hay dependency injection phức tạp
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Enable demo mode ngay từ đầu
  await DemoModeManager.enableDemoMode();
  
  runApp(const ProviderScope(child: DemoApp()));
}

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pandora Demo',
      theme: createPandoraLightTheme(),
      darkTheme: createPandoraTheme(),
      themeMode: ThemeMode.system,
      home: const DemoNotesScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DemoNotesScreen extends StatefulWidget {
  const DemoNotesScreen({super.key});

  @override
  State<DemoNotesScreen> createState() => _DemoNotesScreenState();
}

class _DemoNotesScreenState extends State<DemoNotesScreen> {
  late List<dynamic> demoNotes;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadDemoData();
  }

  void loadDemoData() {
    // Simulate loading
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        demoNotes = DemoDataGenerator.generateDemoNotes();
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.science, color: Colors.orange),
            SizedBox(width: 8),
            Text('Notes Demo'),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            margin: EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange.shade300),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.science, size: 16, color: Colors.orange.shade700),
                SizedBox(width: 4),
                Text(
                  'DEMO MODE',
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
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading demo data...'),
                ],
              ),
            )
          : demoNotes.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.note_add, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'No notes yet',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      SizedBox(height: 8),
                      Text('Tap the + button to create your first note'),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: demoNotes.length,
                  itemBuilder: (context, index) {
                    final note = demoNotes[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Text(
                            note.title[0].toUpperCase(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(
                          note.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 4),
                            Text(
                              note.content,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                if (note.pinned)
                                  Icon(Icons.push_pin, size: 16, color: Colors.orange),
                                if (note.pinned) SizedBox(width: 4),
                                Text(
                                  'Created: ${note.createdAt.day}/${note.createdAt.month}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Row(
                                children: [
                                  Icon(Icons.edit),
                                  SizedBox(width: 8),
                                  Text('Edit'),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              child: Row(
                                children: [
                                  Icon(Icons.delete),
                                  SizedBox(width: 8),
                                  Text('Delete'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DemoNoteDetailScreen(note: note),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Voice Recording FAB
          FloatingActionButton(
            heroTag: "voice",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DemoVoiceScreen()),
              );
            },
            backgroundColor: Colors.purple,
            child: Icon(Icons.mic, color: Colors.white),
            tooltip: 'Voice Recording',
          ),
          SizedBox(width: 12),
          
          // AI Chat FAB
          FloatingActionButton(
            heroTag: "chat", 
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DemoAiChatScreen()),
              );
            },
            backgroundColor: Colors.blue,
            child: Icon(Icons.chat, color: Colors.white),
            tooltip: 'AI Chat',
          ),
          SizedBox(width: 12),
          
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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Create New Note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Note created! (Demo mode)')),
              );
            },
            child: Text('Create'),
          ),
        ],
      ),
    );
  }
}

class DemoNoteDetailScreen extends StatelessWidget {
  final dynamic note;

  const DemoNoteDetailScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Details'),
        actions: [
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
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  note.content,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.smart_toy, color: Colors.blue),
                        SizedBox(width: 8),
                        Text(
                          'AI Summary',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text('Click "Summarize" to generate an AI summary of this note.'),
                    SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('AI Summary generated! (Demo mode)')),
                        );
                      },
                      icon: Icon(Icons.auto_awesome),
                      label: Text('Summarize'),
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
}

class DemoAiChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.chat, size: 64, color: Colors.blue),
                  SizedBox(height: 16),
                  Text(
                    'AI Chat Demo',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: 8),
                  Text('This is a demo of the AI chat feature'),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('AI response: Hello! How can I help you? (Demo)')),
                      );
                    },
                    child: Text('Send Demo Message'),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Message sent! (Demo mode)')),
                    );
                  },
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DemoVoiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voice Recording'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.mic, size: 64, color: Colors.purple),
            SizedBox(height: 16),
            Text(
              'Voice Recording Demo',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 8),
            Text('This is a demo of the voice recording feature'),
            SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Recording started! (Demo mode)')),
                );
              },
              icon: Icon(Icons.mic),
              label: Text('Start Recording'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Recording stopped! Text: "This is demo text" (Demo mode)')),
                );
              },
              child: Text('Stop Recording'),
            ),
          ],
        ),
      ),
    );
  }
}
