class HistoryEntity {
  final int id;
  final int workoutId;
  final int date;
  final int duration;
  final int calories;
  final String? workoutTitle;
  final String? workoutCategory;

  const HistoryEntity({
    required this.id,
    required this.workoutId,
    required this.date,
    required this.duration,
    required this.calories,
    this.workoutTitle,
    this.workoutCategory,
  });
}
