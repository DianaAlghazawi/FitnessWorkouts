import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/navigation/app_routes.dart';
import '../state/workout_state.dart';
import '../widgets/difficulty_badge.dart';
import '../../core/di/providers.dart' as di;

class WorkoutDetailsScreen extends ConsumerWidget {
  final int workoutId;

  const WorkoutDetailsScreen({
    super.key,
    required this.workoutId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutAsync = ref.watch(workoutDetailsProvider(workoutId));
    final isFavoriteAsync = ref.watch(workoutIsFavoriteProvider(workoutId));
    final theme = Theme.of(context);

    return Scaffold(
      body: workoutAsync.when(
        data: (workout) {
          // Handle case where workout doesn't exist
          if (workout == null) {
            return const Center(child: Text('Workout not found'));
          }
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(workout.title),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          theme.colorScheme.primary,
                          theme.colorScheme.secondary,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.fitness_center,
                        size: 80,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ),
                ),
                actions: [
                  isFavoriteAsync.when(
                    data: (isFavorite) => IconButton(
                      icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border),
                      color: isFavorite ? Colors.red : null,
                      onPressed: () async {
                        if (isFavorite) {
                          await ref
                              .read(di.removeFavoriteProvider)
                              .call(workoutId);
                        } else {
                          await ref
                              .read(di.addFavoriteProvider)
                              .call(workoutId);
                        }
                        ref.invalidate(workoutIsFavoriteProvider(workoutId));
                        ref.invalidate(favoritesProvider);
                      },
                      tooltip: isFavorite
                          ? 'Remove from favorites'
                          : 'Add to favorites',
                    ),
                    loading: () => const SizedBox(),
                    error: (_, __) => const SizedBox(),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          DifficultyBadge(difficulty: workout.difficulty),
                          const Spacer(),
                          Icon(Icons.access_time,
                              size: 20,
                              color: theme.colorScheme.onSurfaceVariant),
                          const SizedBox(width: 4),
                          Text('${workout.duration} min'),
                          const SizedBox(width: 16),
                          Icon(Icons.local_fire_department,
                              size: 20,
                              color: theme.colorScheme.onSurfaceVariant),
                          const SizedBox(width: 4),
                          Text('${workout.calories} cal'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Description',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        workout.description,
                        style: theme.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Steps',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Display each step with a numbered circle
                      ...workout.steps.map((step) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Step number badge
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${step.step}',
                                  style: TextStyle(
                                    color: theme.colorScheme.onPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                step.instruction,
                                style: theme.textTheme.bodyLarge,
                              ),
                            ),
                          ],
                        ),
                      )),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: FilledButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.workoutTimer,
                              arguments: workout,
                            );
                          },
                          icon: const Icon(Icons.play_arrow),
                          label: const Text('Start Workout'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        error: (error, stack) => Scaffold(
          body: Center(
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
    );
  }
}
