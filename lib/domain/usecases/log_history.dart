import '../repositories/history_repository.dart';

class LogHistory {
  final HistoryRepository repository;

  LogHistory(this.repository);

  Future<void> call({
    required int workoutId,
    required int date,
    required int duration,
    required int calories,
  }) async {
    await repository.addHistory(
      workoutId: workoutId,
      date: date,
      duration: duration,
      calories: calories,
    );
  }
}
