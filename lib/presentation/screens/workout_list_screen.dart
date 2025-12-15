import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/navigation/app_routes.dart';
import '../../core/utils/constants.dart';
import '../state/workout_state.dart';
import '../widgets/workout_card.dart';

class WorkoutListScreen extends ConsumerStatefulWidget {
  final String category;

  const WorkoutListScreen({
    super.key,
    required this.category,
  });

  @override
  ConsumerState<WorkoutListScreen> createState() => _WorkoutListScreenState();
}

class _WorkoutListScreenState extends ConsumerState<WorkoutListScreen> {
  @override
  Widget build(BuildContext context) {
    final workoutsAsync = ref.watch(filteredWorkoutsProvider(widget.category));
    final selectedDifficulty = ref.watch(selectedDifficultyProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: Column(
        children: [
          // Difficulty filter chips - horizontal scrollable
          // Could make this a dropdown but chips are more visual
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: [
                _buildFilterChip('All', null, selectedDifficulty),
                ...AppConstants.difficulties.map(
                  (difficulty) => _buildFilterChip(
                      difficulty, difficulty, selectedDifficulty),
                ),
              ],
            ),
          ),
          // Workouts List
          Expanded(
            child: workoutsAsync.when(
              data: (workouts) {
                if (workouts.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.fitness_center,
                          size: 64,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No workouts found',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: workouts.length,
                  itemBuilder: (context, index) {
                    final workout = workouts[index];
                    return WorkoutCard(
                      workout: workout,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.workoutDetails,
                          arguments: workout.id,
                        );
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
                    const Icon(Icons.error_outline,
                        size: 64, color: Colors.red),
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

  Widget _buildFilterChip(String label, String? value, String? selected) {
    final isSelected = value == null ? selected == null : selected == value;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          ref.read(selectedDifficultyProvider.notifier).state = value;
        },
      ),
    );
  }
}
