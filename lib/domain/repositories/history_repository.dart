import '../entities/history_entity.dart';

abstract class HistoryRepository {
  Future<void> addHistory({
    required int workoutId,
    required int date,
    required int duration,
    required int calories,
  });
  Future<List<HistoryEntity>> getAllHistory();
  Future<Map<String, dynamic>> getTotalStats();
}
