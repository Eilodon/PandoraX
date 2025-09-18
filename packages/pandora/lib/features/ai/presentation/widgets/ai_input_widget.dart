import 'package:flutter/material.dart';

/// AI Input Widget for chat input
class AIInputWidget extends StatefulWidget {
  final TextEditingController controller;
  final bool isLoading;
  final Function(String) onSend;
  final VoidCallback? onVoiceInput;
  final VoidCallback? onAttachFile;
  final String? hintText;
  final int? maxLines;
  final bool enableVoiceInput;
  final bool enableFileAttachment;

  const AIInputWidget({
    super.key,
    required this.controller,
    required this.isLoading,
    required this.onSend,
    this.onVoiceInput,
    this.onAttachFile,
    this.hintText,
    this.maxLines,
    this.enableVoiceInput = true,
    this.enableFileAttachment = true,
  });

  @override
  State<AIInputWidget> createState() => _AIInputWidgetState();
}

class _AIInputWidgetState extends State<AIInputWidget> {
  bool _isExpanded = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isExpanded = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: _isExpanded 
              ? Theme.of(context).primaryColor
              : Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildInputRow(),
          if (_isExpanded) _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildInputRow() {
    return Row(
      children: [
        if (widget.enableFileAttachment) ...[
          IconButton(
            onPressed: widget.onAttachFile,
            icon: Icon(
              Icons.attach_file,
              color: Colors.grey[600],
            ),
          ),
        ],
        Expanded(
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            maxLines: widget.maxLines ?? 4,
            minLines: 1,
            decoration: InputDecoration(
              hintText: widget.hintText ?? 'Type your message...',
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            onSubmitted: (value) {
              if (value.trim().isNotEmpty && !widget.isLoading) {
                widget.onSend(value);
              }
            },
          ),
        ),
        if (widget.enableVoiceInput) ...[
          IconButton(
            onPressed: widget.isLoading ? null : widget.onVoiceInput,
            icon: Icon(
              Icons.mic,
              color: widget.isLoading ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
        ],
        _buildSendButton(),
      ],
    );
  }

  Widget _buildSendButton() {
    final canSend = widget.controller.text.trim().isNotEmpty && !widget.isLoading;
    
    return Container(
      margin: const EdgeInsets.all(8),
      child: Material(
        color: canSend ? Theme.of(context).primaryColor : Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: canSend ? () => widget.onSend(widget.controller.text) : null,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: widget.isLoading
                ? const Padding(
                    padding: EdgeInsets.all(12),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Icon(
                    Icons.send,
                    color: canSend ? Colors.white : Colors.grey[500],
                    size: 20,
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          _buildActionButton(
            icon: Icons.clear,
            label: 'Clear',
            onTap: () {
              widget.controller.clear();
              _focusNode.unfocus();
            },
          ),
          const SizedBox(width: 16),
          _buildActionButton(
            icon: Icons.history,
            label: 'History',
            onTap: _showHistory,
          ),
          const Spacer(),
          _buildActionButton(
            icon: Icons.settings,
            label: 'Settings',
            onTap: _showSettings,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: Colors.grey[600],
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showHistory() {
    // TODO: Implement history
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Chat history coming soon!')),
    );
  }

  void _showSettings() {
    // TODO: Implement settings
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('AI settings coming soon!')),
    );
  }
}

/// Voice Input Widget
class VoiceInputWidget extends StatefulWidget {
  final Function(String) onResult;
  final VoidCallback? onCancel;

  const VoiceInputWidget({
    super.key,
    required this.onResult,
    this.onCancel,
  });

  @override
  State<VoiceInputWidget> createState() => _VoiceInputWidgetState();
}

class _VoiceInputWidgetState extends State<VoiceInputWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.scale(
                scale: _isListening ? _animation.value : 1.0,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: _isListening ? Colors.red : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _isListening ? Icons.mic : Icons.mic_none,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Text(
            _isListening ? 'Listening...' : 'Tap to start recording',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            _isListening 
                ? 'Speak clearly into your microphone'
                : 'Hold to record, release to stop',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: widget.onCancel,
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _toggleListening,
                child: Text(_isListening ? 'Stop' : 'Start'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _toggleListening() {
    setState(() {
      _isListening = !_isListening;
    });

    if (_isListening) {
      _animationController.repeat(reverse: true);
      _startListening();
    } else {
      _animationController.stop();
      _stopListening();
    }
  }

  void _startListening() {
    // TODO: Implement actual voice recognition
    // For now, simulate after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && _isListening) {
        widget.onResult('This is a simulated voice input result');
        setState(() {
          _isListening = false;
        });
        _animationController.stop();
      }
    });
  }

  void _stopListening() {
    // TODO: Implement actual voice recognition stop
  }
}
