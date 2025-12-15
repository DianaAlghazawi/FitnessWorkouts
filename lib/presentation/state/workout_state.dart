import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/workout_entity.dart';
import '../../domain/entities/history_entity.dart';
import '../../core/di/providers.dart' as di;

final workoutsProvider = FutureProvider<List<WorkoutEntity>>((ref) async {
  final useCase = ref.read(di.getAllWorkoutsProvider);
  return await useCase();
});

final workoutsByCategoryProvider =
    FutureProvider.family<List<WorkoutEntity>, String>((ref, category) async {
  final useCase = ref.read(di.getWorkoutsByCategoryProvider);
  return await useCase(category);
});

final workoutDetailsProvider =
    FutureProvider.family<WorkoutEntity?, int>((ref, id) async {
  final useCase = ref.read(di.getWorkoutDetailsProvider);
  return await useCase(id);
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchResultsProvider = FutureProvider<List<WorkoutEntity>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) {
    final useCase = ref.read(di.getAllWorkoutsProvider);
    return await useCase();
  }
  final useCase = ref.read(di.searchWorkoutsProvider);
  return await useCase(query);
});

final selectedDifficultyProvider = StateProvider<String?>((ref) => null);

final filteredWorkoutsProvider =
    FutureProvider.family<List<WorkoutEntity>, String>((ref, category) async {
  final difficulty = ref.watch(selectedDifficultyProvider);
  if (difficulty == null) {
    final useCase = ref.read(di.getWorkoutsByCategoryProvider);
    return await useCase(category);
  }
  // For simplicity, we'll filter client-side
  final useCase = ref.read(di.getWorkoutsByCategoryProvider);
  final workouts = await useCase(category);
  return workouts.where((w) => w.difficulty == difficulty).toList();
});

final favoritesProvider = FutureProvider<List<WorkoutEntity>>((ref) async {
  final useCase = ref.read(di.getFavoritesProvider);
  return await useCase();
});

final workoutIsFavoriteProvider =
    FutureProvider.family<bool, int>((ref, workoutId) async {
  final useCase = ref.read(di.isFavoriteProvider);
  return await useCase(workoutId);
});

final historyProvider = FutureProvider<List<HistoryEntity>>((ref) async {
  final useCase = ref.read(di.getHistoryProvider);
  return await useCase();
});

final totalStatsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final useCase = ref.read(di.getTotalStatsProvider);
  return await useCase();
});

// Theme Mode Provider
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system) {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeIndex = prefs.getInt('theme_mode') ?? 0;
    state = ThemeMode.values[themeModeIndex];
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme_mode', mode.index);
  }
}

final themeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});
