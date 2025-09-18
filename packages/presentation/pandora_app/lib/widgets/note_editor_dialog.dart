import 'package:flutter/material.dart';
import 'package:design_tokens/design_tokens.dart';
import 'package:common_entities/common_entities.dart';

class NoteEditorDialog extends StatefulWidget {
  final Note? note;
  final Function(Note) onSave;

  const NoteEditorDialog({
    super.key,
    this.note,
    required this.onSave,
  });

  @override
  State<NoteEditorDialog> createState() => _NoteEditorDialogState();
}

class _NoteEditorDialogState extends State<NoteEditorDialog> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late TextEditingController _categoryController;
  late TextEditingController _tagsController;
  
  int _priority = 0;
  String? _color;
  String? _icon;
  bool _isPinned = false;
  bool _isArchived = false;

  @override
  void initState() {
    super.initState();
    
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(text: widget.note?.content ?? '');
    _categoryController = TextEditingController(text: widget.note?.category ?? '');
    _tagsController = TextEditingController(text: widget.note?.tags.join(', ') ?? '');
    
    if (widget.note != null) {
      _priority = widget.note!.priority;
      _color = widget.note!.color;
      _icon = widget.note!.icon;
      _isPinned = widget.note!.isPinned;
      _isArchived = widget.note!.isArchived;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _categoryController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Header
            Row(
              children: [
                Text(
                  widget.note == null ? 'Create Note' : 'Edit Note',
                  style: PandoraTextStyles.headlineSmall,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Form
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                        hintText: 'Enter note title...',
                      ),
                      style: PandoraTextStyles.titleMedium,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Content
                    TextField(
                      controller: _contentController,
                      decoration: const InputDecoration(
                        labelText: 'Content',
                        border: OutlineInputBorder(),
                        hintText: 'Enter note content...',
                        alignLabelWithHint: true,
                      ),
                      maxLines: 10,
                      style: PandoraTextStyles.bodyMedium,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Category and Tags Row
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _categoryController,
                            decoration: const InputDecoration(
                              labelText: 'Category',
                              border: OutlineInputBorder(),
                              hintText: 'e.g., Work, Personal',
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: _tagsController,
                            decoration: const InputDecoration(
                              labelText: 'Tags',
                              border: OutlineInputBorder(),
                              hintText: 'tag1, tag2, tag3',
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Priority and Options
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            value: _priority,
                            decoration: const InputDecoration(
                              labelText: 'Priority',
                              border: OutlineInputBorder(),
                            ),
                            items: const [
                              DropdownMenuItem(value: 0, child: Text('None')),
                              DropdownMenuItem(value: 1, child: Text('High')),
                              DropdownMenuItem(value: 2, child: Text('Medium')),
                              DropdownMenuItem(value: 3, child: Text('Low')),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _priority = value ?? 0;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _color,
                            decoration: const InputDecoration(
                              labelText: 'Color',
                              border: OutlineInputBorder(),
                            ),
                            items: const [
                              DropdownMenuItem(value: null, child: Text('Default')),
                              DropdownMenuItem(value: 'red', child: Text('Red')),
                              DropdownMenuItem(value: 'blue', child: Text('Blue')),
                              DropdownMenuItem(value: 'green', child: Text('Green')),
                              DropdownMenuItem(value: 'yellow', child: Text('Yellow')),
                              DropdownMenuItem(value: 'purple', child: Text('Purple')),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _color = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Options
                    Row(
                      children: [
                        Checkbox(
                          value: _isPinned,
                          onChanged: (value) {
                            setState(() {
                              _isPinned = value ?? false;
                            });
                          },
                        ),
                        const Text('Pin to top'),
                        const SizedBox(width: 24),
                        Checkbox(
                          value: _isArchived,
                          onChanged: (value) {
                            setState(() {
                              _isArchived = value ?? false;
                            });
                          },
                        ),
                        const Text('Archive'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _saveNote,
                  child: Text(widget.note == null ? 'Create' : 'Update'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _saveNote() {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title')),
      );
      return;
    }

    final tags = _tagsController.text
        .split(',')
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty)
        .toList();

    final note = Note(
      id: widget.note?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      content: _contentController.text.trim(),
      category: _categoryController.text.trim().isEmpty ? null : _categoryController.text.trim(),
      tags: tags,
      priority: _priority,
      color: _color,
      icon: _icon,
      isPinned: _isPinned,
      isArchived: _isArchived,
      createdAt: widget.note?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );

    widget.onSave(note);
    Navigator.pop(context);
  }
}
