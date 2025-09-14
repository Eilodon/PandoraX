import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:alarm_domain/alarm_domain.dart';
import 'package:pandora_ui/pandora_ui.dart';
import '../../ai/application/ai_summarizer/ai_summarizer_providers.dart';
import 'reminder_form_screen.dart';
import 'smart_reminder_screen.dart';
import 'location_reminder_screen.dart';

class NoteDetailScreen extends ConsumerWidget {
  final Note note;

  const NoteDetailScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aiState = ref.watch(aiSummarizerProvider);
    final aiNotifier = ref.read(aiSummarizerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LocationReminderScreen(note: note),
                ),
              );
            },
            tooltip: 'Location Reminder',
          ),
          IconButton(
            icon: const Icon(Icons.smart_toy),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SmartReminderScreen(note: note),
                ),
              );
            },
            tooltip: 'Smart Reminder',
          ),
          IconButton(
            icon: const Icon(Icons.alarm_add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ReminderFormScreen(note: note),
                ),
              );
            },
            tooltip: 'Tạo nhắc nhở',
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Navigate to edit screen
            },
          ),
          if (note.pinned)
            const Icon(Icons.push_pin, color: Colors.orange),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(PTokens.spacingLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Note content
            PandoraCard(
              variant: PandoraCardVariant.elevated,
              child: Padding(
                padding: const EdgeInsets.all(PTokens.spacingLg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.title,
                      style: PTokens.typography.headlineSmall,
                    ),
                    const SizedBox(height: PTokens.spacingSm),
                    Text(
                      note.content,
                      style: PTokens.typography.bodyLarge,
                    ),
                    const SizedBox(height: PTokens.spacingLg),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: PandoraColors.neutral500,
                        ),
                        const SizedBox(width: PTokens.spacingXs),
                        Text(
                          'Created: ${_formatDateTime(note.createdAt)}',
                          style: PTokens.typography.labelSmall.copyWith(
                            color: PandoraColors.neutral500,
                          ),
                        ),
                        const Spacer(),
                        if (note.updatedAt != note.createdAt) ...[
                          Icon(
                            Icons.update,
                            size: 16,
                            color: PandoraColors.neutral500,
                          ),
                          const SizedBox(width: PTokens.spacingXs),
                          Text(
                            'Updated: ${_formatDateTime(note.updatedAt)}',
                            style: PTokens.typography.labelSmall.copyWith(
                              color: PandoraColors.neutral500,
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (note.reminderTime != null) ...[
                      const SizedBox(height: PTokens.spacingSm),
                      Row(
                        children: [
                          Icon(
                            Icons.alarm,
                            size: 16,
                            color: PandoraColors.warning500,
                          ),
                          const SizedBox(width: PTokens.spacingXs),
                          Text(
                            'Nhắc nhở: ${_formatDateTime(note.reminderTime!)}',
                            style: PTokens.typography.labelSmall.copyWith(
                              color: PandoraColors.warning500,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: PTokens.spacingLg),

            // AI Summary Section
            PandoraCard(
              variant: PandoraCardVariant.elevated,
              child: Padding(
                padding: const EdgeInsets.all(PTokens.spacingLg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.auto_awesome, color: PandoraColors.primary500),
                        const SizedBox(width: PTokens.spacingSm),
                        Text(
                          'AI Summary',
                          style: PTokens.typography.titleMedium,
                        ),
                        const Spacer(),
                        PandoraButton.icon(
                          onPressed: aiState.maybeWhen(
                            loading: () => null,
                            orElse: () => () => aiNotifier.summarizeText(note.content),
                          ),
                          icon: aiState.maybeWhen(
                            loading: () => const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                            orElse: () => const Icon(Icons.auto_awesome),
                          ),
                          child: Text(
                            aiState.maybeWhen(
                              loading: () => 'Summarizing...',
                              orElse: () => 'Summarize',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: PTokens.spacingLg),
                    
                    // Summary content
                    aiState.when(
                      initial: () => PandoraContainer(
                        variant: PandoraContainerVariant.filled,
                        child: Padding(
                          padding: const EdgeInsets.all(PTokens.spacingLg),
                          child: Text(
                            'Click "Summarize" to generate an AI summary of this note.',
                            style: PTokens.typography.bodyMedium.copyWith(
                              fontStyle: FontStyle.italic,
                              color: PandoraColors.neutral500,
                            ),
                          ),
                        ),
                      ),
                      loading: () => PandoraContainer(
                        variant: PandoraContainerVariant.filled,
                        backgroundColor: PandoraColors.primary50,
                        child: Padding(
                          padding: const EdgeInsets.all(PTokens.spacingLg),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                              const SizedBox(width: PTokens.spacingMd),
                              Text(
                                'Generating summary...',
                                style: PTokens.typography.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                      success: (summary) => PandoraContainer(
                        variant: PandoraContainerVariant.filled,
                        backgroundColor: PandoraColors.success50,
                        borderColor: PandoraColors.success200,
                        child: Padding(
                          padding: const EdgeInsets.all(PTokens.spacingLg),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: PandoraColors.success700,
                                    size: 20,
                                  ),
                                  const SizedBox(width: PTokens.spacingSm),
                                  Text(
                                    'Summary Generated',
                                    style: PTokens.typography.labelLarge.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: PandoraColors.success700,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: PTokens.spacingSm),
                              Text(
                                summary,
                                style: PTokens.typography.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                      error: (message) => PandoraContainer(
                        variant: PandoraContainerVariant.filled,
                        backgroundColor: PandoraColors.error50,
                        borderColor: PandoraColors.error200,
                        child: Padding(
                          padding: const EdgeInsets.all(PTokens.spacingLg),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.error,
                                    color: PandoraColors.error700,
                                    size: 20,
                                  ),
                                  const SizedBox(width: PTokens.spacingSm),
                                  Text(
                                    'Error',
                                    style: PTokens.typography.labelLarge.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: PandoraColors.error700,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: PTokens.spacingSm),
                              Text(
                                message,
                                style: PTokens.typography.bodyMedium,
                              ),
                              const SizedBox(height: PTokens.spacingMd),
                              PandoraButton(
                                onPressed: () => aiNotifier.summarizeText(note.content),
                                variant: PandoraButtonVariant.outlined,
                                size: PandoraButtonSize.sm,
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
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

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
