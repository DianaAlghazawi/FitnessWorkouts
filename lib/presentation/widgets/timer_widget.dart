import 'package:flutter/material.dart';

class TimerWidget extends StatelessWidget {
  final int seconds;
  final bool isRunning;

  const TimerWidget({
    super.key,
    required this.seconds,
    this.isRunning = false,
  });

  String get _formattedTime {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.colorScheme.primaryContainer,
        border: Border.all(
          color: theme.colorScheme.primary,
          width: 4,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _formattedTime,
            style: theme.textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
          if (isRunning)
            Text(
              'Running',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
        ],
      ),
    );
  }
}
