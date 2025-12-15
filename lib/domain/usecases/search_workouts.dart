import '../entities/workout_entity.dart';
import '../repositories/workout_repository.dart';

class SearchWorkouts {
  final WorkoutRepository repository;

  SearchWorkouts(this.repository);

  Future<List<WorkoutEntity>> call(String query) async {
    return await repository.searchWorkouts(query);
  }
}
