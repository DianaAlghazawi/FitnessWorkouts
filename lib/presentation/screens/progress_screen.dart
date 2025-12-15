import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/date_utils.dart' as app_date_utils;
import '../state/workout_state.dart';
import '../widgets/progress_chart.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(totalStatsProvider);
    final historyAsync = ref.watch(historyProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress'),
      ),
      body: Column(
        children: [
          // Stats overview - showing totals
          // Could add charts here later if needed
          Padding(
            padding: const EdgeInsets.all(16),
            child: statsAsync.when(
              data: (stats) => Row(
                children: [
                  Expanded(
                    child: ProgressChart(
                      label: 'Workouts',
                      value: stats['totalWorkouts'] as int? ?? 0,
                      unit: 'completed',
                      icon: Icons.fitness_center,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ProgressChart(
                      label: 'Minutes',
                      value: stats['totalMinutes'] as int? ?? 0,
                      unit: 'trained',
                      icon: Icons.access_time,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ProgressChart(
                      label: 'Calories',
                      value: stats['totalCalories'] as int? ?? 0,
                      unit: 'burned',
                      icon: Icons.local_fire_department,
                    ),
                  ),
                ],
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Text('Error: $error'),
            ),
          ),
          // History List
          Expanded(
            child: historyAsync.when(
              data: (history) {
                if (history.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history,
                          size: 64,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No workout history',
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Complete workouts to see your progress here',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    final item = history[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: theme.colorScheme.primaryContainer,
                          child: Icon(
                            Icons.fitness_center,
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        ),
                        title: Text(item.workoutTitle ?? 'Unknown Workout'),
                        subtitle: Text(
                          app_date_utils.DateUtils.formatDate(item.date),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${item.duration} min',
                              style: theme.textTheme.bodySmall,
                            ),
                            Text(
                              '${item.calories} cal',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text('Error: $error'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

