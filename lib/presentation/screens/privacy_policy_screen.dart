import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Last Updated: ${DateTime.now().toString().split(' ')[0]}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '1. Data Collection',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Offline Fitness Workouts does not collect, store, or transmit any personal data. '
              'All workout data, favorites, and progress tracking are stored locally on your device only.',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            Text(
              '2. Permissions',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This app requires zero permissions. It does not access:\n'
              '• Camera\n'
              '• Contacts\n'
              '• Location\n'
              '• Storage (external)\n'
              '• Phone\n'
              '• SMS\n'
              '• Notifications',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            Text(
              '3. Offline Operation',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This app works completely offline. It does not require an internet connection '
              'and does not make any network requests.',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            Text(
              '4. Data Storage',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'All data is stored locally on your device using SQLite database. '
              'Your data never leaves your device and is not shared with any third parties.',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            Text(
              '5. Third-Party Services',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This app does not use any third-party analytics, advertising, or tracking services.',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            Text(
              '6. Children\'s Privacy',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Since we do not collect any data, this app is safe for users of all ages.',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            Text(
              '7. Changes to Privacy Policy',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'We may update this privacy policy from time to time. Any changes will be reflected in this document.',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            Text(
              'Contact',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'If you have any questions about this privacy policy, please contact us through the app store.',
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

