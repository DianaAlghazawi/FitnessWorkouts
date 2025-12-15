import '../repositories/history_repository.dart';

class GetTotalStats {
  final HistoryRepository repository;

  GetTotalStats(this.repository);

  Future<Map<String, dynamic>> call() async {
    return await repository.getTotalStats();
  }
}
