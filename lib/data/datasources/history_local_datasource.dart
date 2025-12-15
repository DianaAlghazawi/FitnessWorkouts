import '../models/history_model.dart';
import '../../core/database/history_dao.dart';

class HistoryLocalDataSource {
  final HistoryDao _historyDao;

  HistoryLocalDataSource(this._historyDao);

  Future<void> addHistory({
    required int workoutId,
    required int date,
    required int duration,
    required int calories,
  }) async {
    await _historyDao.addHistory(
      workoutId: workoutId,
      date: date,
      duration: duration,
      calories: calories,
    );
  }

  Future<List<HistoryModel>> getAllHistory() async {
    final maps = await _historyDao.getAllHistory();
    return maps.map((map) => HistoryModel.fromMap(map)).toList();
  }

  Future<Map<String, dynamic>> getTotalStats() async {
    return await _historyDao.getTotalStats();
  }
}
