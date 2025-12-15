import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';

class FavoriteDao {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<List<Map<String, dynamic>>> getAllFavorites() async {
    final db = await _dbHelper.database;
    return await db.rawQuery('''
      SELECT w.* FROM ${DatabaseHelper.workoutsTable} w
      INNER JOIN ${DatabaseHelper.favoritesTable} f ON w.id = f.workoutId
      ORDER BY w.title ASC
    ''');
  }

  Future<bool> isFavorite(int workoutId) async {
    final db = await _dbHelper.database;
    final results = await db.query(
      DatabaseHelper.favoritesTable,
      where: 'workoutId = ?',
      whereArgs: [workoutId],
      limit: 1,
    );
    return results.isNotEmpty;
  }

  Future<void> addFavorite(int workoutId) async {
    final db = await _dbHelper.database;
    await db.insert(
      DatabaseHelper.favoritesTable,
      {'workoutId': workoutId},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> removeFavorite(int workoutId) async {
    final db = await _dbHelper.database;
    await db.delete(
      DatabaseHelper.favoritesTable,
      where: 'workoutId = ?',
      whereArgs: [workoutId],
    );
  }
}
