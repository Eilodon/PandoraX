import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

abstract class DeltaApplier {
  Future<void> apply(File base, Stream<List<int>> patchStream, File outFile, String? expectedSha256);
  Future<bool> canApply(File base, Stream<List<int>> patchStream);
  String get name;
}

class BsDiffApplier implements DeltaApplier {
  @override
  String get name => 'BsDiff40';

  @override
  Future<void> apply(File base, Stream<List<int>> patchStream, File outFile, String? expectedSha256) async {
    try {
      // Read patch data
      final patchBytes = await patchStream.toList();
      final patchData = Uint8List.fromList(patchBytes.expand((x) => x).toList());
      
      // Read base file
      final baseBytes = await base.readAsBytes();
      
      // Apply BsDiff40 patch
      final newBytes = await _applyBsDiff40(baseBytes, patchData);
      
      // Write to output file
      await outFile.writeAsBytes(newBytes);
      
      // Verify checksum if provided
      if (expectedSha256 != null) {
        final actualSha256 = await _sha256(outFile);
        if (actualSha256.toLowerCase() != expectedSha256.toLowerCase()) {
          await outFile.delete();
          throw DeltaException('SHA-256 mismatch after patch application');
        }
      }
    } catch (e) {
      if (e is DeltaException) rethrow;
      throw DeltaException('Failed to apply delta patch: $e');
    }
  }

  @override
  Future<bool> canApply(File base, Stream<List<int>> patchStream) async {
    try {
      // Read patch header to verify format
      final patchBytes = await patchStream.take(32).toList();
      final header = Uint8List.fromList(patchBytes.expand((x) => x).toList());
      
      if (header.length < 32) return false;
      
      // Check BsDiff40 magic number
      final magic = String.fromCharCodes(header.sublist(0, 8));
      return magic == 'BSDIFF40';
    } catch (e) {
      return false;
    }
  }

  Future<Uint8List> _applyBsDiff40(Uint8List oldData, Uint8List patchData) async {
    if (patchData.length < 32) {
      throw DeltaException('Invalid patch file: too short');
    }

    // Read header
    final header = patchData.sublist(0, 32);
    final magic = String.fromCharCodes(header.sublist(0, 8));
    
    if (magic != 'BSDIFF40') {
      throw DeltaException('Invalid patch magic: $magic');
    }

    final ctrlLen = _readLong64(header, 8);
    final diffLen = _readLong64(header, 16);
    final newSize = _readLong64(header, 24);

    if (newSize < 0 || newSize > 1024 * 1024 * 1024) { // 1GB limit
      throw DeltaException('Invalid new size: $newSize');
    }

    if (ctrlLen < 0 || diffLen < 0) {
      throw DeltaException('Invalid control or diff length');
    }

    // Read control, diff, and extra blocks
    final ctrlBlock = patchData.sublist(32, 32 + ctrlLen.toInt());
    final diffBlock = patchData.sublist(32 + ctrlLen.toInt(), 32 + ctrlLen.toInt() + diffLen.toInt());
    final extraBlock = patchData.sublist(32 + ctrlLen.toInt() + diffLen.toInt());

    final newData = Uint8List(newSize.toInt());

    int oldPos = 0;
    int newPos = 0;
    int ctrlPos = 0;
    int diffPos = 0;
    int extraPos = 0;

    while (newPos < newSize) {
      if (ctrlPos + 24 > ctrlBlock.length) {
        throw DeltaException('Control block overrun');
      }

      final addLen = _readLong64(ctrlBlock, ctrlPos).toInt();
      ctrlPos += 8;
      final copyLen = _readLong64(ctrlBlock, ctrlPos).toInt();
      ctrlPos += 8;
      final seekLen = _readLong64(ctrlBlock, ctrlPos).toInt();
      ctrlPos += 8;

      // Add diff data to old data
      if (diffPos + addLen > diffBlock.length) {
        throw DeltaException('Diff block overrun');
      }

      for (int i = 0; i < addLen; i++) {
        final oldByte = (oldPos + i < oldData.length) ? oldData[oldPos + i] : 0;
        newData[newPos + i] = (diffBlock[diffPos + i] + oldByte) & 0xFF;
      }

      newPos += addLen;
      oldPos += addLen;
      diffPos += addLen;

      // Copy extra block
      if (extraPos + copyLen > extraBlock.length) {
        throw DeltaException('Extra block overrun');
      }

      for (int i = 0; i < copyLen; i++) {
        newData[newPos + i] = extraBlock[extraPos + i];
      }

      newPos += copyLen;
      extraPos += copyLen;
      oldPos += seekLen;

      if (oldPos < 0) {
        throw DeltaException('Negative old position');
      }
    }

    return newData;
  }

  int _readLong64(Uint8List data, int offset) {
    int result = 0;
    for (int i = 0; i < 8; i++) {
      result |= (data[offset + i] & 0xFF) << (i * 8);
    }
    
    // Handle sign extension for 64-bit
    if ((result & 0x8000000000000000) != 0) {
      result = result | 0xFFFFFFFF00000000;
    }
    
    return result;
  }

  Future<String> _sha256(File file) async {
    final bytes = await file.readAsBytes();
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}

class DeltaException implements Exception {
  final String message;
  const DeltaException(this.message);
  
  @override
  String toString() => 'DeltaException: $message';
}

/// Delta update manager
class DeltaUpdateManager {
  final List<DeltaApplier> _appliers;

  DeltaUpdateManager({
    List<DeltaApplier>? appliers,
  }) : _appliers = appliers ?? [BsDiffApplier()];

  Future<bool> canApplyDelta(File base, Stream<List<int>> patchStream) async {
    for (final applier in _appliers) {
      try {
        if (await applier.canApply(base, patchStream)) {
          return true;
        }
      } catch (e) {
        // Continue to next applier
      }
    }
    return false;
  }

  Future<void> applyDelta(File base, Stream<List<int>> patchStream, File outFile, String? expectedSha256) async {
    for (final applier in _appliers) {
      try {
        if (await applier.canApply(base, patchStream)) {
          await applier.apply(base, patchStream, outFile, expectedSha256);
          return;
        }
      } catch (e) {
        // Continue to next applier
      }
    }
    throw DeltaException('No compatible delta applier found');
  }

  List<String> get supportedFormats => _appliers.map((a) => a.name).toList();
}
