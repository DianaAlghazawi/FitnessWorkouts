import '../../domain/entities/workout_entity.dart';
import '../../domain/repositories/favorite_repository.dart';
import '../datasources/favorite_local_datasource.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteLocalDataSource _localDataSource;

  FavoriteRepositoryImpl(this._localDataSource);

  @override
  Future<List<WorkoutEntity>> getAllFavorites() async {
    return await _localDataSource.getAllFavorites();
  }

  @override
  Future<bool> isFavorite(int workoutId) async {
    return await _localDataSource.isFavorite(workoutId);
  }

  @override
  Future<void> addFavorite(int workoutId) async {
    await _localDataSource.addFavorite(workoutId);
  }

  @override
  Future<void> removeFavorite(int workoutId) async {
    await _localDataSource.removeFavorite(workoutId);
  }
}
