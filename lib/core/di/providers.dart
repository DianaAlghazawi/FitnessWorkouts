import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database_helper.dart';
import '../database/workout_dao.dart';
import '../database/favorite_dao.dart';
import '../database/history_dao.dart';
import '../../data/datasources/workout_local_datasource.dart';
import '../../data/datasources/favorite_local_datasource.dart';
import '../../data/datasources/history_local_datasource.dart';
import '../../data/repositories/workout_repository_impl.dart';
import '../../data/repositories/favorite_repository_impl.dart';
import '../../data/repositories/history_repository_impl.dart';
import '../../domain/usecases/get_all_workouts.dart';
import '../../domain/usecases/get_workouts_by_category.dart';
import '../../domain/usecases/search_workouts.dart';
import '../../domain/usecases/get_workout_details.dart';
import '../../domain/usecases/get_favorites.dart';
import '../../domain/usecases/add_favorite.dart';
import '../../domain/usecases/remove_favorite.dart';
import '../../domain/usecases/is_favorite.dart';
import '../../domain/usecases/log_history.dart';
import '../../domain/usecases/get_history.dart';
import '../../domain/usecases/get_total_stats.dart';

// Database singleton - using instance pattern
// This ensures we only have one DB connection
final databaseHelperProvider = Provider<DatabaseHelper>((ref) {
  return DatabaseHelper.instance;
});

// DAOs
final workoutDaoProvider = Provider<WorkoutDao>((ref) {
  return WorkoutDao();
});

final favoriteDaoProvider = Provider<FavoriteDao>((ref) {
  return FavoriteDao();
});

final historyDaoProvider = Provider<HistoryDao>((ref) {
  return HistoryDao();
});

// Data Sources
final workoutLocalDataSourceProvider = Provider<WorkoutLocalDataSource>((ref) {
  return WorkoutLocalDataSource(ref.read(workoutDaoProvider));
});

final favoriteLocalDataSourceProvider =
    Provider<FavoriteLocalDataSource>((ref) {
  return FavoriteLocalDataSource(ref.read(favoriteDaoProvider));
});

final historyLocalDataSourceProvider = Provider<HistoryLocalDataSource>((ref) {
  return HistoryLocalDataSource(ref.read(historyDaoProvider));
});

// Repositories
final workoutRepositoryProvider = Provider<WorkoutRepositoryImpl>((ref) {
  return WorkoutRepositoryImpl(ref.read(workoutLocalDataSourceProvider));
});

final favoriteRepositoryProvider = Provider<FavoriteRepositoryImpl>((ref) {
  return FavoriteRepositoryImpl(ref.read(favoriteLocalDataSourceProvider));
});

final historyRepositoryProvider = Provider<HistoryRepositoryImpl>((ref) {
  return HistoryRepositoryImpl(ref.read(historyLocalDataSourceProvider));
});

// Use Cases
final getAllWorkoutsProvider = Provider<GetAllWorkouts>((ref) {
  return GetAllWorkouts(ref.read(workoutRepositoryProvider));
});

final getWorkoutsByCategoryProvider = Provider<GetWorkoutsByCategory>((ref) {
  return GetWorkoutsByCategory(ref.read(workoutRepositoryProvider));
});

final searchWorkoutsProvider = Provider<SearchWorkouts>((ref) {
  return SearchWorkouts(ref.read(workoutRepositoryProvider));
});

final getWorkoutDetailsProvider = Provider<GetWorkoutDetails>((ref) {
  return GetWorkoutDetails(ref.read(workoutRepositoryProvider));
});

final getFavoritesProvider = Provider<GetFavorites>((ref) {
  return GetFavorites(ref.read(favoriteRepositoryProvider));
});

final addFavoriteProvider = Provider<AddFavorite>((ref) {
  return AddFavorite(ref.read(favoriteRepositoryProvider));
});

final removeFavoriteProvider = Provider<RemoveFavorite>((ref) {
  return RemoveFavorite(ref.read(favoriteRepositoryProvider));
});

final isFavoriteProvider = Provider<IsFavorite>((ref) {
  return IsFavorite(ref.read(favoriteRepositoryProvider));
});

final logHistoryProvider = Provider<LogHistory>((ref) {
  return LogHistory(ref.read(historyRepositoryProvider));
});

final getHistoryProvider = Provider<GetHistory>((ref) {
  return GetHistory(ref.read(historyRepositoryProvider));
});

final getTotalStatsProvider = Provider<GetTotalStats>((ref) {
  return GetTotalStats(ref.read(historyRepositoryProvider));
});
