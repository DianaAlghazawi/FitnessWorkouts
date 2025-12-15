import '../entities/workout_entity.dart';
import '../repositories/favorite_repository.dart';

class GetFavorites {
  final FavoriteRepository repository;

  GetFavorites(this.repository);

  Future<List<WorkoutEntity>> call() async {
    return await repository.getAllFavorites();
  }
}
