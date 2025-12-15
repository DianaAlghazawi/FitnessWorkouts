import '../models/workout_model.dart';
import '../../core/database/workout_dao.dart';

// Data source for workouts - handles local database operations
// Keeping it simple for now, might add caching later if needed
class WorkoutLocalDataSource {
  final WorkoutDao _workoutDao;

  WorkoutLocalDataSource(this._workoutDao);

  // Get all workouts from local DB
  Future<List<WorkoutModel>> getAllWorkouts() async {
    final maps = await _workoutDao.getAllWorkouts();
    // Convert maps to models - straightforward mapping
    return maps.map((map) => WorkoutModel.fromMap(map)).toList();
  }

  Future<List<WorkoutModel>> getWorkoutsByCategory(String category) async {
    final maps = await _workoutDao.getWorkoutsByCategory(category);
    return maps.map((map) => WorkoutModel.fromMap(map)).toList();
  }

  Future<List<WorkoutModel>> getWorkoutsByDifficulty(String difficulty) async {
    final maps = await _workoutDao.getWorkoutsByDifficulty(difficulty);
    return maps.map((map) => WorkoutModel.fromMap(map)).toList();
  }

  Future<List<WorkoutModel>> searchWorkouts(String query) async {
    final maps = await _workoutDao.searchWorkouts(query);
    return maps.map((map) => WorkoutModel.fromMap(map)).toList();
  }

  // Get single workout by ID - returns null if not found
  // Had to handle null case here since DB might not have the workout
  Future<WorkoutModel?> getWorkoutById(int id) async {
    final map = await _workoutDao.getWorkoutById(id);
    return map != null ? WorkoutModel.fromMap(map) : null;
  }

  Future<List<WorkoutModel>> getWorkoutsByCategoryAndDifficulty(
    String category,
    String difficulty,
  ) async {
    final maps = await _workoutDao.getWorkoutsByCategoryAndDifficulty(
        category, difficulty);
    return maps.map((map) => WorkoutModel.fromMap(map)).toList();
  }
}
