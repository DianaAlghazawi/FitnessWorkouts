import '../models/workout_model.dart';
import '../../core/database/favorite_dao.dart';

class FavoriteLocalDataSource {
  final FavoriteDao _favoriteDao;

  FavoriteLocalDataSource(this._favoriteDao);

  Future<List<WorkoutModel>> getAllFavorites() async {
    final maps = await _favoriteDao.getAllFavorites();
    return maps.map((map) => WorkoutModel.fromMap(map)).toList();
  }

  Future<bool> isFavorite(int workoutId) async {
    return await _favoriteDao.isFavorite(workoutId);
  }

  Future<void> addFavorite(int workoutId) async {
    await _favoriteDao.addFavorite(workoutId);
  }

  Future<void> removeFavorite(int workoutId) async {
    await _favoriteDao.removeFavorite(workoutId);
  }
}
