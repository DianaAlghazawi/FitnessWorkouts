import '../entities/history_entity.dart';
import '../repositories/history_repository.dart';

class GetHistory {
  final HistoryRepository repository;

  GetHistory(this.repository);

  Future<List<HistoryEntity>> call() async {
    return await repository.getAllHistory();
  }
}
