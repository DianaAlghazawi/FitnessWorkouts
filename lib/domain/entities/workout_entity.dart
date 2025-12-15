class WorkoutEntity {
  final int id;
  final String title;
  final String category;
  final String description;
  final int duration;
  final String difficulty;
  final List<WorkoutStep> steps;
  final int calories;
  final String assetPath;

  const WorkoutEntity({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.duration,
    required this.difficulty,
    required this.steps,
    required this.calories,
    required this.assetPath,
  });
}

class WorkoutStep {
  final int step;
  final String instruction;

  const WorkoutStep({
    required this.step,
    required this.instruction,
  });
}
