import '../entities/workout_entity.dart';

abstract class WorkoutRepository {
  Future<List<WorkoutEntity>> getAllWorkouts();
  Future<List<WorkoutEntity>> getWorkoutsByCategory(String category);
  Future<List<WorkoutEntity>> getWorkoutsByDifficulty(String difficulty);
  Future<List<WorkoutEntity>> searchWorkouts(String query);
  Future<WorkoutEntity?> getWorkoutById(int id);
  Future<List<WorkoutEntity>> getWorkoutsByCategoryAndDifficulty(
    String category,
    String difficulty,
  );
}
