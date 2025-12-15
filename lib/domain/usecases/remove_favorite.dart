import '../repositories/favorite_repository.dart';

class RemoveFavorite {
  final FavoriteRepository repository;

  RemoveFavorite(this.repository);

  Future<void> call(int workoutId) async {
    await repository.removeFavorite(workoutId);
  }
}
