import '../entities/workout_entity.dart';
import '../repositories/workout_repository.dart';

class GetWorkoutsByCategory {
  final WorkoutRepository repository;

  GetWorkoutsByCategory(this.repository);

  Future<List<WorkoutEntity>> call(String category) async {
    return await repository.getWorkoutsByCategory(category);
  }
}
