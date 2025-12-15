import 'database_helper.dart';

class HistoryDao {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<void> addHistory({
    required int workoutId,
    required int date,
    required int duration,
    required int calories,
  }) async {
    final db = await _dbHelper.database;
    await db.insert(
      DatabaseHelper.historyTable,
      {
        'workoutId': workoutId,
        'date': date,
        'duration': duration,
        'calories': calories,
      },
    );
  }

  Future<List<Map<String, dynamic>>> getAllHistory() async {
    final db = await _dbHelper.database;
    return await db.rawQuery('''
      SELECT h.*, w.title, w.category
      FROM ${DatabaseHelper.historyTable} h
      INNER JOIN ${DatabaseHelper.workoutsTable} w ON h.workoutId = w.id
      ORDER BY h.date DESC
    ''');
  }

  Future<Map<String, dynamic>> getTotalStats() async {
    final db = await _dbHelper.database;
    final result = await db.rawQuery('''
      SELECT 
        COUNT(*) as totalWorkouts,
        SUM(duration) as totalMinutes,
        SUM(calories) as totalCalories
      FROM ${DatabaseHelper.historyTable}
    ''');

    if (result.isEmpty) {
      return {
        'totalWorkouts': 0,
        'totalMinutes': 0,
        'totalCalories': 0,
      };
    }

    return {
      'totalWorkouts': result.first['totalWorkouts'] ?? 0,
      'totalMinutes': result.first['totalMinutes'] ?? 0,
      'totalCalories': result.first['totalCalories'] ?? 0,
    };
  }

  Future<List<Map<String, dynamic>>> getHistoryByDateRange(
      int startDate, int endDate) async {
    final db = await _dbHelper.database;
    return await db.rawQuery('''
      SELECT h.*, w.title, w.category
      FROM ${DatabaseHelper.historyTable} h
      INNER JOIN ${DatabaseHelper.workoutsTable} w ON h.workoutId = w.id
      WHERE h.date >= ? AND h.date <= ?
      ORDER BY h.date DESC
    ''', [startDate, endDate]);
  }
}
