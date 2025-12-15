import 'database_helper.dart';

class WorkoutDao {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<List<Map<String, dynamic>>> getAllWorkouts() async {
    final db = await _dbHelper.database;
    return await db.query(
      DatabaseHelper.workoutsTable,
      orderBy: 'title ASC',
    );
  }

  Future<List<Map<String, dynamic>>> getWorkoutsByCategory(
      String category) async {
    final db = await _dbHelper.database;
    return await db.query(
      DatabaseHelper.workoutsTable,
      where: 'category = ?',
      whereArgs: [category],
      orderBy: 'title ASC',
    );
  }

  Future<List<Map<String, dynamic>>> getWorkoutsByDifficulty(
      String difficulty) async {
    final db = await _dbHelper.database;
    return await db.query(
      DatabaseHelper.workoutsTable,
      where: 'difficulty = ?',
      whereArgs: [difficulty],
      orderBy: 'title ASC',
    );
  }

  Future<List<Map<String, dynamic>>> searchWorkouts(String query) async {
    final db = await _dbHelper.database;
    return await db.query(
      DatabaseHelper.workoutsTable,
      where: 'title LIKE ? OR description LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'title ASC',
    );
  }

  Future<Map<String, dynamic>?> getWorkoutById(int id) async {
    final db = await _dbHelper.database;
    final results = await db.query(
      DatabaseHelper.workoutsTable,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return results.isEmpty ? null : results.first;
  }

  Future<List<Map<String, dynamic>>> getWorkoutsByCategoryAndDifficulty(
    String category,
    String difficulty,
  ) async {
    final db = await _dbHelper.database;
    return await db.query(
      DatabaseHelper.workoutsTable,
      where: 'category = ? AND difficulty = ?',
      whereArgs: [category, difficulty],
      orderBy: 'title ASC',
    );
  }
}
