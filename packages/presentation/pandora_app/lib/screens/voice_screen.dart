import 'package:flutter/material.dart';
import 'package:design_tokens/design_tokens.dart';
import '../services/voice_service.dart';

class VoiceScreen extends StatefulWidget {
  const VoiceScreen({super.key});

  @override
  State<VoiceScreen> createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen> {
  bool _isRecording = false;
  bool _isPlaying = false;
  String _transcribedText = '';
  final List<VoiceNote> _voiceNotes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Notes'),
        backgroundColor: PandoraColors.primary,
        foregroundColor: PandoraColors.onPrimary,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Voice recording section
          Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Recording button
                GestureDetector(
                  onTap: _toggleRecording,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isRecording ? PandoraColors.error : PandoraColors.primary,
                      boxShadow: [
                        BoxShadow(
                          color: (_isRecording ? PandoraColors.error : PandoraColors.primary)
                              .withValues(alpha: 0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Icon(
                      _isRecording ? Icons.stop : Icons.mic,
                      size: 48,
                      color: PandoraColors.onPrimary,
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Status text
                Text(
                  _isRecording ? 'Recording... Tap to stop' : 'Tap to start recording',
                  style: PandoraTextStyles.titleMedium.copyWith(
                    color: PandoraColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 16),
                
                // Transcribed text
                if (_transcribedText.isNotEmpty) ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: PandoraColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: PandoraColors.outline),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Transcribed Text:',
                          style: PandoraTextStyles.labelMedium.copyWith(
                            color: PandoraColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _transcribedText,
                          style: PandoraTextStyles.bodyMedium,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            ElevatedButton.icon(
                              onPressed: _saveAsNote,
                              icon: const Icon(Icons.save),
                              label: const Text('Save as Note'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: PandoraColors.primary,
                                foregroundColor: PandoraColors.onPrimary,
                              ),
                            ),
                            const SizedBox(width: 8),
                            TextButton.icon(
                              onPressed: _clearText,
                              icon: const Icon(Icons.clear),
                              label: const Text('Clear'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          // Voice notes list
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Voice Notes',
                    style: PandoraTextStyles.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: _voiceNotes.isEmpty
                        ? Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.record_voice_over,
                    size: 64,
                    color: PandoraColors.textSecondary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No voice notes yet',
                    style: PandoraTextStyles.titleMedium.copyWith(
                      color: PandoraColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start recording to create your first voice note',
                    style: PandoraTextStyles.bodyMedium.copyWith(
                      color: PandoraColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
                          )
                        : ListView.builder(
                            itemCount: _voiceNotes.length,
                            itemBuilder: (context, index) {
                              final note = _voiceNotes[index];
                              return _buildVoiceNoteCard(note, index);
                            },
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

  Widget _buildVoiceNoteCard(VoiceNote note, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.record_voice_over,
                  color: PandoraColors.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    note.title,
                    style: PandoraTextStyles.titleMedium,
                  ),
                ),
                IconButton(
                  onPressed: () => _playVoiceNote(note),
                  icon: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    color: PandoraColors.primary,
                  ),
                ),
                IconButton(
                  onPressed: () => _deleteVoiceNote(index),
                  icon: Icon(
                    Icons.delete,
                    color: PandoraColors.error,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (note.transcription.isNotEmpty) ...[
              Text(
                note.transcription,
                style: PandoraTextStyles.bodyMedium.copyWith(
                  color: PandoraColors.textSecondary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
            ],
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 14,
                  color: PandoraColors.textSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  _formatDuration(note.duration),
                  style: PandoraTextStyles.labelSmall.copyWith(
                    color: PandoraColors.textSecondary,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.calendar_today,
                  size: 14,
                  color: PandoraColors.textSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  _formatDate(note.createdAt),
                  style: PandoraTextStyles.labelSmall.copyWith(
                    color: PandoraColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _toggleRecording() {
    setState(() {
      _isRecording = !_isRecording;
    });

    if (_isRecording) {
      _startRecording();
    } else {
      _stopRecording();
    }
  }

  void _startRecording() async {
    try {
      final voiceService = VoiceService();
      await voiceService.startRecording();
      
      if (mounted) {
        setState(() {
          _isRecording = true;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to start recording: $e')),
        );
      }
    }
  }

  void _stopRecording() async {
    try {
      final voiceService = VoiceService();
      final transcription = await voiceService.stopRecording();
      
      if (mounted) {
        setState(() {
          _isRecording = false;
          _transcribedText = transcription;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isRecording = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to stop recording: $e')),
        );
      }
    }
  }

  void _playVoiceNote(VoiceNote note) async {
    try {
      final voiceService = VoiceService();
      
      if (_isPlaying) {
        await voiceService.stopPlaying();
        setState(() {
          _isPlaying = false;
        });
      } else {
        await voiceService.playVoiceNote(note.id);
        setState(() {
          _isPlaying = true;
        });
        
        // Auto-stop after duration
        Future.delayed(Duration(seconds: note.duration), () {
          if (mounted) {
            setState(() {
              _isPlaying = false;
            });
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isPlaying = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to play voice note: $e')),
        );
      }
    }
  }

  void _saveAsNote() {
    if (_transcribedText.isEmpty) return;

    final note = VoiceNote(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Voice Note ${_voiceNotes.length + 1}',
      transcription: _transcribedText,
      duration: 30, // Simulated duration
      createdAt: DateTime.now(),
    );

    setState(() {
      _voiceNotes.add(note);
      _transcribedText = '';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Voice note saved!')),
    );
  }

  void _clearText() {
    setState(() {
      _transcribedText = '';
    });
  }

  void _deleteVoiceNote(int index) {
    setState(() {
      _voiceNotes.removeAt(index);
    });
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

class VoiceNote {
  final String id;
  final String title;
  final String transcription;
  final int duration; // in seconds
  final DateTime createdAt;

  VoiceNote({
    required this.id,
    required this.title,
    required this.transcription,
    required this.duration,
    required this.createdAt,
  });
}
