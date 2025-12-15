import '../../domain/entities/history_entity.dart';
import '../../domain/repositories/history_repository.dart';
import '../datasources/history_local_datasource.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryLocalDataSource _localDataSource;

  HistoryRepositoryImpl(this._localDataSource);

  @override
  Future<void> addHistory({
    required int workoutId,
    required int date,
    required int duration,
    required int calories,
  }) async {
    await _localDataSource.addHistory(
      workoutId: workoutId,
      date: date,
      duration: duration,
      calories: calories,
    );
  }

  @override
  Future<List<HistoryEntity>> getAllHistory() async {
    return await _localDataSource.getAllHistory();
  }

  @override
  Future<Map<String, dynamic>> getTotalStats() async {
    return await _localDataSource.getTotalStats();
  }
}
