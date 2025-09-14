// file: packages/pandora_ui/lib/src/widgets/security_cue.dart
import 'package:flutter/material.dart';
import 'package:pandora_ui/src/tokens.dart';

enum SecurityLevel { onDevice, hybrid, cloud }

class SecurityCue extends StatelessWidget {
  final SecurityLevel level;
  const SecurityCue({super.key, required this.level});

  IconData get _icon {
    switch (level) {
      case SecurityLevel.onDevice: return Icons.shield_outlined;
      case SecurityLevel.hybrid: return Icons.sync_lock_outlined;
      case SecurityLevel.cloud: return Icons.cloud_outlined;
    }
  }

  Color get _color {
    switch (level) {
      case SecurityLevel.onDevice: return AppColors.secureOnDevice;
      case SecurityLevel.hybrid: return AppColors.secureHybrid;
      case SecurityLevel.cloud: return AppColors.secureCloud;
    }
  }

  String get _text {
    switch (level) {
      case SecurityLevel.onDevice: return "On-Device";
      case SecurityLevel.hybrid: return "Hybrid";
      case SecurityLevel.cloud: return "Cloud";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon( _icon, color: _color, size: PTokens.icon.size - 4, ),
        const SizedBox(width: PTokens.spacingXs),
        Text(_text, style: PTokens.typography.label.copyWith(color: _color, fontSize: 12)),
      ],
    );
  }
}
