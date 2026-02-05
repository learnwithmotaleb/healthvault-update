
import 'package:flutter/material.dart';

class HVSectionHeader extends StatelessWidget {
  final String title;
  final String? trailingText;
  final VoidCallback? onAction;

  const HVSectionHeader({super.key, required this.title, this.trailingText, this.onAction});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text(title, style: t.textTheme.titleMedium),
          const Spacer(),
          if (trailingText != null)
            TextButton(onPressed: onAction, child: Text(trailingText!)),
        ],
      ),
    );
  }
}
