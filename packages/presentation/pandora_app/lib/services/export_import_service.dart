import 'dart:convert';
import 'dart:io';
import 'package:common_entities/common_entities.dart';
import 'package:core_utils/core_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// Service for handling note export and import operations
class ExportImportService {
  static final ExportImportService _instance = ExportImportService._internal();
  factory ExportImportService() => _instance;
  ExportImportService._internal();

  /// Export notes to JSON format
  Future<String> exportNotesToJson(List<Note> notes) async {
    try {
      AppLogger.info('📤 Exporting ${notes.length} notes to JSON...');
      
      final exportData = {
        'version': '1.0',
        'exportDate': DateTime.now().toIso8601String(),
        'totalNotes': notes.length,
        'notes': notes.map((note) => {
          'id': note.id,
          'title': note.title,
          'content': note.content,
          'category': note.category,
          'tags': note.tags,
          'isPinned': note.isPinned,
          'isArchived': note.isArchived,
          'createdAt': note.createdAt.toIso8601String(),
          'updatedAt': note.updatedAt.toIso8601String(),
        }).toList(),
      };
      
      final jsonString = const JsonEncoder.withIndent('  ').convert(exportData);
      AppLogger.success('Notes exported to JSON successfully');
      return jsonString;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to export notes to JSON', e, stackTrace);
      rethrow;
    }
  }

  /// Export notes to CSV format
  Future<String> exportNotesToCsv(List<Note> notes) async {
    try {
      AppLogger.info('📤 Exporting ${notes.length} notes to CSV...');
      
      final csvBuffer = StringBuffer();
      
      // CSV Header
      csvBuffer.writeln('Title,Content,Category,Tags,Is Pinned,Is Archived,Created At,Updated At');
      
      // CSV Data
      for (final note in notes) {
        final title = _escapeCsvField(note.title);
        final content = _escapeCsvField(note.content);
        final category = _escapeCsvField(note.category ?? '');
        final tags = _escapeCsvField(note.tags.join('; '));
        final isPinned = note.isPinned ? 'Yes' : 'No';
        final isArchived = note.isArchived ? 'Yes' : 'No';
        final createdAt = note.createdAt.toIso8601String();
        final updatedAt = note.updatedAt.toIso8601String();
        
        csvBuffer.writeln('$title,$content,$category,$tags,$isPinned,$isArchived,$createdAt,$updatedAt');
      }
      
      AppLogger.success('Notes exported to CSV successfully');
      return csvBuffer.toString();
    } catch (e, stackTrace) {
      AppLogger.error('Failed to export notes to CSV', e, stackTrace);
      rethrow;
    }
  }

  /// Export notes to TXT format
  Future<String> exportNotesToTxt(List<Note> notes) async {
    try {
      AppLogger.info('📤 Exporting ${notes.length} notes to TXT...');
      
      final txtBuffer = StringBuffer();
      
      txtBuffer.writeln('PANDORA NOTES EXPORT');
      txtBuffer.writeln('===================');
      txtBuffer.writeln('Export Date: ${DateTime.now().toString()}');
      txtBuffer.writeln('Total Notes: ${notes.length}');
      txtBuffer.writeln('');
      
      for (int i = 0; i < notes.length; i++) {
        final note = notes[i];
        txtBuffer.writeln('NOTE ${i + 1}');
        txtBuffer.writeln('==========');
        txtBuffer.writeln('Title: ${note.title}');
        if (note.category != null) {
          txtBuffer.writeln('Category: ${note.category}');
        }
        if (note.tags.isNotEmpty) {
          txtBuffer.writeln('Tags: ${note.tags.join(', ')}');
        }
        txtBuffer.writeln('Created: ${note.createdAt.toString()}');
        txtBuffer.writeln('Updated: ${note.updatedAt.toString()}');
        txtBuffer.writeln('Pinned: ${note.isPinned ? 'Yes' : 'No'}');
        txtBuffer.writeln('Archived: ${note.isArchived ? 'Yes' : 'No'}');
        txtBuffer.writeln('');
        txtBuffer.writeln('Content:');
        txtBuffer.writeln(note.content);
        txtBuffer.writeln('');
        txtBuffer.writeln('---');
        txtBuffer.writeln('');
      }
      
      AppLogger.success('Notes exported to TXT successfully');
      return txtBuffer.toString();
    } catch (e, stackTrace) {
      AppLogger.error('Failed to export notes to TXT', e, stackTrace);
      rethrow;
    }
  }

  /// Import notes from JSON format
  Future<List<Note>> importNotesFromJson(String jsonData) async {
    try {
      AppLogger.info('📥 Importing notes from JSON...');
      
      final Map<String, dynamic> data = json.decode(jsonData);
      final List<dynamic> notesData = data['notes'] ?? [];
      
      final List<Note> notes = [];
      for (final noteData in notesData) {
        try {
          final note = Note(
            id: noteData['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
            title: noteData['title'] ?? 'Untitled',
            content: noteData['content'] ?? '',
            category: noteData['category'],
            tags: List<String>.from(noteData['tags'] ?? []),
            isPinned: noteData['isPinned'] ?? false,
            isArchived: noteData['isArchived'] ?? false,
            createdAt: DateTime.parse(noteData['createdAt'] ?? DateTime.now().toIso8601String()),
            updatedAt: DateTime.parse(noteData['updatedAt'] ?? DateTime.now().toIso8601String()),
          );
          notes.add(note);
        } catch (e) {
          AppLogger.warning('Failed to parse note: $e');
        }
      }
      
      AppLogger.success('Imported ${notes.length} notes from JSON');
      return notes;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to import notes from JSON', e, stackTrace);
      rethrow;
    }
  }

  /// Import notes from CSV format
  Future<List<Note>> importNotesFromCsv(String csvData) async {
    try {
      AppLogger.info('📥 Importing notes from CSV...');
      
      final lines = csvData.split('\n');
      if (lines.isEmpty) {
        return [];
      }
      
      final List<Note> notes = [];
      
      // Skip header line
      for (int i = 1; i < lines.length; i++) {
        final line = lines[i].trim();
        if (line.isEmpty) continue;
        
        try {
          final fields = _parseCsvLine(line);
          if (fields.length >= 8) {
            final note = Note(
              id: DateTime.now().millisecondsSinceEpoch.toString() + '_$i',
              title: _unescapeCsvField(fields[0]),
              content: _unescapeCsvField(fields[1]),
              category: _unescapeCsvField(fields[2]).isEmpty ? null : _unescapeCsvField(fields[2]),
              tags: _unescapeCsvField(fields[3]).isEmpty ? [] : _unescapeCsvField(fields[3]).split(';').map((e) => e.trim()).toList(),
              isPinned: fields[4].toLowerCase() == 'yes',
              isArchived: fields[5].toLowerCase() == 'yes',
              createdAt: DateTime.tryParse(fields[6]) ?? DateTime.now(),
              updatedAt: DateTime.tryParse(fields[7]) ?? DateTime.now(),
            );
            notes.add(note);
          }
        } catch (e) {
          AppLogger.warning('Failed to parse CSV line $i: $e');
        }
      }
      
      AppLogger.success('Imported ${notes.length} notes from CSV');
      return notes;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to import notes from CSV', e, stackTrace);
      rethrow;
    }
  }

  /// Save export data to file
  Future<String> saveExportToFile(String data, String format) async {
    try {
      AppLogger.info('💾 Saving export data to file...');
      
      final directory = await getApplicationDocumentsDirectory();
      final fileName = 'pandora_notes_export_${DateTime.now().millisecondsSinceEpoch}.$format';
      final file = File('${directory.path}/$fileName');
      
      await file.writeAsString(data);
      
      AppLogger.success('Export saved to: ${file.path}');
      return file.path;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to save export to file', e, stackTrace);
      rethrow;
    }
  }

  /// Share export data
  Future<void> shareExport(String data, String format) async {
    try {
      AppLogger.info('📤 Sharing export data...');
      
      final fileName = 'pandora_notes_export_${DateTime.now().millisecondsSinceEpoch}.$format';
      
      // Save to temporary file
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/$fileName');
      await file.writeAsString(data);
      
      // Share the file
      await Share.shareXFiles([XFile(file.path)], text: 'Pandora Notes Export');
      
      AppLogger.success('Export shared successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to share export', e, stackTrace);
      rethrow;
    }
  }

  /// Pick file for import
  Future<String?> pickImportFile() async {
    try {
      AppLogger.info('📁 Picking file for import...');
      
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json', 'csv', 'txt'],
        allowMultiple: false,
      );
      
      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        if (file.path != null) {
          AppLogger.success('File picked: ${file.name}');
          return file.path;
        }
      }
      
      AppLogger.warning('No file selected');
      return null;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to pick import file', e, stackTrace);
      return null;
    }
  }

  /// Read file content
  Future<String> readFileContent(String filePath) async {
    try {
      AppLogger.info('📖 Reading file content: $filePath');
      
      final file = File(filePath);
      final content = await file.readAsString();
      
      AppLogger.success('File content read successfully');
      return content;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to read file content', e, stackTrace);
      rethrow;
    }
  }

  /// Escape CSV field
  String _escapeCsvField(String field) {
    if (field.contains(',') || field.contains('"') || field.contains('\n')) {
      return '"${field.replaceAll('"', '""')}"';
    }
    return field;
  }

  /// Unescape CSV field
  String _unescapeCsvField(String field) {
    if (field.startsWith('"') && field.endsWith('"')) {
      return field.substring(1, field.length - 1).replaceAll('""', '"');
    }
    return field;
  }

  /// Parse CSV line
  List<String> _parseCsvLine(String line) {
    final List<String> fields = [];
    bool inQuotes = false;
    StringBuffer currentField = StringBuffer();
    
    for (int i = 0; i < line.length; i++) {
      final char = line[i];
      
      if (char == '"') {
        if (inQuotes && i + 1 < line.length && line[i + 1] == '"') {
          // Escaped quote
          currentField.write('"');
          i++; // Skip next quote
        } else {
          // Toggle quote state
          inQuotes = !inQuotes;
        }
      } else if (char == ',' && !inQuotes) {
        // Field separator
        fields.add(currentField.toString());
        currentField.clear();
      } else {
        currentField.write(char);
      }
    }
    
    // Add last field
    fields.add(currentField.toString());
    
    return fields;
  }
}
