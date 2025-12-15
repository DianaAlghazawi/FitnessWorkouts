import '../../domain/entities/workout_entity.dart';
import '../../domain/repositories/workout_repository.dart';
import '../datasources/workout_local_datasource.dart';

// Repository implementation - bridges domain and data layers
// Simple pass-through for now since we're only using local data
class WorkoutRepositoryImpl implements WorkoutRepository {
  final WorkoutLocalDataSource _localDataSource;

  WorkoutRepositoryImpl(this._localDataSource);

  @override
  Future<List<WorkoutEntity>> getAllWorkouts() async {
    return await _localDataSource.getAllWorkouts();
  }

  @override
  Future<List<WorkoutEntity>> getWorkoutsByCategory(String category) async {
    return await _localDataSource.getWorkoutsByCategory(category);
  }

  @override
  Future<List<WorkoutEntity>> getWorkoutsByDifficulty(String difficulty) async {
    return await _localDataSource.getWorkoutsByDifficulty(difficulty);
  }

  @override
  Future<List<WorkoutEntity>> searchWorkouts(String query) async {
    return await _localDataSource.searchWorkouts(query);
  }

  @override
  Future<WorkoutEntity?> getWorkoutById(int id) async {
    return await _localDataSource.getWorkoutById(id);
  }

  @override
  Future<List<WorkoutEntity>> getWorkoutsByCategoryAndDifficulty(
    String category,
    String difficulty,
  ) async {
    return await _localDataSource.getWorkoutsByCategoryAndDifficulty(
        category, difficulty);
  }
}
