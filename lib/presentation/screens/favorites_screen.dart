import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/navigation/app_routes.dart';
import '../state/workout_state.dart';
import '../widgets/workout_card.dart';
import '../../core/di/providers.dart' as di;

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: favoritesAsync.when(
        data: (favorites) {
          // Show empty state if no favorites yet
          if (favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 64,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No favorites yet',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add workouts to favorites to see them here',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final workout = favorites[index];
              return WorkoutCard(
                workout: workout,
                isFavorite: true,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.workoutDetails,
                    arguments: workout.id,
                  );
                },
                onFavoriteTap: () async {
                  // Remove from favorites and refresh
                  await ref.read(di.removeFavoriteProvider).call(workout.id);
                  // Invalidate to refresh the list
                  ref.invalidate(favoritesProvider);
                  ref.invalidate(workoutIsFavoriteProvider(workout.id));
                },
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
    );
  }
}
