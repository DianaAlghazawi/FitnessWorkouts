import '../entities/workout_entity.dart';

abstract class FavoriteRepository {
  Future<List<WorkoutEntity>> getAllFavorites();
  Future<bool> isFavorite(int workoutId);
  Future<void> addFavorite(int workoutId);
  Future<void> removeFavorite(int workoutId);
}
