import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../injection.dart';
import '../../../services/interfaces/ai_service.dart';

/// Screen for AI-powered note enhancement features
class NoteEnhancementScreen extends StatefulWidget {
  final String initialContent;
  final Function(String) onContentUpdated;

  const NoteEnhancementScreen({
    super.key,
    required this.initialContent,
    required this.onContentUpdated,
  });

  @override
  State<NoteEnhancementScreen> createState() => _NoteEnhancementScreenState();
}

class _NoteEnhancementScreenState extends State<NoteEnhancementScreen> {
  final TextEditingController _contentController = TextEditingController();
  late AIService _aiService;
  
  bool _isLoading = false;
  bool _isAIAvailable = false;
  String _aiStatus = 'Checking...';
  
  // Enhancement results
  String? _summary;
  String? _enhancedContent;
  List<String> _titleSuggestions = [];
  List<String> _tags = [];

  @override
  void initState() {
    super.initState();
    _contentController.text = widget.initialContent;
    _initializeAI();
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _initializeAI() async {
    try {
      _aiService = getIt<AIService>();
      
      if (!_aiService.isAvailable) {
        await _aiService.initialize();
      }
      
      setState(() {
        _isAIAvailable = _aiService.isAvailable;
        _aiStatus = _aiService.status;
      });
    } catch (e) {
      setState(() {
        _isAIAvailable = false;
        _aiStatus = 'Error: $e';
      });
    }
  }

  Future<void> _generateSummary() async {
    if (!_isAIAvailable || _contentController.text.trim().isEmpty) return;

    setState(() => _isLoading = true);
    
    try {
      final summary = await _aiService.summarizeNote(_contentController.text);
      setState(() {
        _summary = summary;
      });
    } catch (e) {
      _showErrorSnackBar('Failed to generate summary: $e');
    }
    
    setState(() => _isLoading = false);
  }

  Future<void> _enhanceContent() async {
    if (!_isAIAvailable || _contentController.text.trim().isEmpty) return;

    setState(() => _isLoading = true);
    
    try {
      final enhanced = await _aiService.enhanceContent(_contentController.text);
      setState(() {
        _enhancedContent = enhanced;
      });
    } catch (e) {
      _showErrorSnackBar('Failed to enhance content: $e');
    }
    
    setState(() => _isLoading = false);
  }

  Future<void> _generateTitleSuggestions() async {
    if (!_isAIAvailable || _contentController.text.trim().isEmpty) return;

    setState(() => _isLoading = true);
    
    try {
      final suggestions = await _aiService.generateTitleSuggestions(_contentController.text);
      setState(() {
        _titleSuggestions = suggestions;
      });
    } catch (e) {
      _showErrorSnackBar('Failed to generate title suggestions: $e');
    }
    
    setState(() => _isLoading = false);
  }

  Future<void> _generateTags() async {
    if (!_isAIAvailable || _contentController.text.trim().isEmpty) return;

    setState(() => _isLoading = true);
    
    try {
      final tags = await _aiService.generateTags(_contentController.text);
      setState(() {
        _tags = tags;
      });
    } catch (e) {
      _showErrorSnackBar('Failed to generate tags: $e');
    }
    
    setState(() => _isLoading = false);
  }

  Future<void> _runAllEnhancements() async {
    if (!_isAIAvailable || _contentController.text.trim().isEmpty) return;

    setState(() => _isLoading = true);
    
    try {
      // Run all enhancements in parallel
      final results = await Future.wait([
        _aiService.summarizeNote(_contentController.text),
        _aiService.enhanceContent(_contentController.text),
        _aiService.generateTitleSuggestions(_contentController.text),
        _aiService.generateTags(_contentController.text),
      ]);

      setState(() {
        _summary = results[0] as String;
        _enhancedContent = results[1] as String;
        _titleSuggestions = results[2] as List<String>;
        _tags = results[3] as List<String>;
      });
    } catch (e) {
      _showErrorSnackBar('Failed to run enhancements: $e');
    }
    
    setState(() => _isLoading = false);
  }

  void _applyEnhancement(String content) {
    _contentController.text = content;
    widget.onContentUpdated(content);
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard')),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Note Enhancement'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _initializeAI,
            tooltip: 'Refresh AI Status',
          ),
        ],
      ),
      body: Column(
        children: [
          // AI Status
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: _isAIAvailable 
                ? Colors.green.withOpacity(0.1)
                : Colors.orange.withOpacity(0.1),
            child: Row(
              children: [
                Icon(
                  _isAIAvailable ? Icons.smart_toy : Icons.warning,
                  color: _isAIAvailable ? Colors.green : Colors.orange,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'AI Status: $_aiStatus',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                if (_isLoading)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Original Content
                  _buildSection(
                    title: 'Original Content',
                    child: TextField(
                      controller: _contentController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your note content here...',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 8,
                      onChanged: (value) {
                        // Clear previous results when content changes
                        setState(() {
                          _summary = null;
                          _enhancedContent = null;
                          _titleSuggestions.clear();
                          _tags.clear();
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Enhancement Actions
                  _buildSection(
                    title: 'AI Enhancements',
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _isAIAvailable && !_isLoading 
                              ? _runAllEnhancements 
                              : null,
                          icon: const Icon(Icons.auto_fix_high),
                          label: const Text('Enhance All'),
                        ),
                        OutlinedButton.icon(
                          onPressed: _isAIAvailable && !_isLoading 
                              ? _generateSummary 
                              : null,
                          icon: const Icon(Icons.summarize),
                          label: const Text('Summary'),
                        ),
                        OutlinedButton.icon(
                          onPressed: _isAIAvailable && !_isLoading 
                              ? _enhanceContent 
                              : null,
                          icon: const Icon(Icons.edit_note),
                          label: const Text('Enhance'),
                        ),
                        OutlinedButton.icon(
                          onPressed: _isAIAvailable && !_isLoading 
                              ? _generateTitleSuggestions 
                              : null,
                          icon: const Icon(Icons.title),
                          label: const Text('Titles'),
                        ),
                        OutlinedButton.icon(
                          onPressed: _isAIAvailable && !_isLoading 
                              ? _generateTags 
                              : null,
                          icon: const Icon(Icons.label),
                          label: const Text('Tags'),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Results
                  if (_summary != null) ...[
                    _buildResultSection(
                      title: 'Summary',
                      content: _summary!,
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: () => _copyToClipboard(_summary!),
                          tooltip: 'Copy Summary',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],

                  if (_enhancedContent != null) ...[
                    _buildResultSection(
                      title: 'Enhanced Content',
                      content: _enhancedContent!,
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: () => _copyToClipboard(_enhancedContent!),
                          tooltip: 'Copy Enhanced Content',
                        ),
                        IconButton(
                          icon: const Icon(Icons.check),
                          onPressed: () => _applyEnhancement(_enhancedContent!),
                          tooltip: 'Apply Enhancement',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],

                  if (_titleSuggestions.isNotEmpty) ...[
                    _buildSection(
                      title: 'Title Suggestions',
                      child: Column(
                        children: _titleSuggestions.map((title) => 
                          ListTile(
                            title: Text(title),
                            trailing: IconButton(
                              icon: const Icon(Icons.copy),
                              onPressed: () => _copyToClipboard(title),
                            ),
                            onTap: () => _copyToClipboard(title),
                          ),
                        ).toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  if (_tags.isNotEmpty) ...[
                    _buildSection(
                      title: 'Suggested Tags',
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _tags.map((tag) => 
                          Chip(
                            label: Text(tag),
                            onDeleted: () => _copyToClipboard(tag),
                            deleteIcon: const Icon(Icons.copy, size: 16),
                          ),
                        ).toList(),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Bottom Actions
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onContentUpdated(_contentController.text);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Apply Changes'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget _buildResultSection({
    required String title,
    required String content,
    List<Widget> actions = const [],
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ...actions,
              ],
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(content),
            ),
          ],
        ),
      ),
    );
  }
}
