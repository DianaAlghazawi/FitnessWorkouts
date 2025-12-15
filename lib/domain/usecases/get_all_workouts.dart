import '../entities/workout_entity.dart';
import '../repositories/workout_repository.dart';

// Simple use case - just fetches all workouts
// Following clean architecture pattern here
class GetAllWorkouts {
  final WorkoutRepository repository;

  GetAllWorkouts(this.repository);

  Future<List<WorkoutEntity>> call() async {
    // Direct pass-through for now
    return await repository.getAllWorkouts();
  }
}
