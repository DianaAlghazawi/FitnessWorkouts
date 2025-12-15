import '../entities/workout_entity.dart';
import '../repositories/workout_repository.dart';

class GetWorkoutDetails {
  final WorkoutRepository repository;

  GetWorkoutDetails(this.repository);

  Future<WorkoutEntity?> call(int id) async {
    return await repository.getWorkoutById(id);
  }
}
