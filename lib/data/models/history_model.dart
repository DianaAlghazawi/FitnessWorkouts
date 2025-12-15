import '../../domain/entities/history_entity.dart';

class HistoryModel extends HistoryEntity {
  const HistoryModel({
    required super.id,
    required super.workoutId,
    required super.date,
    required super.duration,
    required super.calories,
    super.workoutTitle,
    super.workoutCategory,
  });

  factory HistoryModel.fromMap(Map<String, dynamic> map) {
    return HistoryModel(
      id: map['id'] as int,
      workoutId: map['workoutId'] as int,
      date: map['date'] as int,
      duration: map['duration'] as int,
      calories: map['calories'] as int,
      workoutTitle: map['title'] as String?,
      workoutCategory: map['category'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'workoutId': workoutId,
      'date': date,
      'duration': duration,
      'calories': calories,
    };
  }
}
