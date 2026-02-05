
import 'package:flutter/material.dart';

class HVLoading extends StatelessWidget {
  final String? message;
  const HVLoading({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          if (message != null) ...[
            const SizedBox(height: 12),
            Text(message!, style: t.textTheme.bodyMedium),
          ]
        ],
      ),
    );
  }
}
