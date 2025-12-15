import '../repositories/favorite_repository.dart';

class AddFavorite {
  final FavoriteRepository repository;

  AddFavorite(this.repository);

  Future<void> call(int workoutId) async {
    await repository.addFavorite(workoutId);
  }
}
