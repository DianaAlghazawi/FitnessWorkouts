import '../../domain/entities/workout_entity.dart';

class WorkoutModel extends WorkoutEntity {
  const WorkoutModel({
    required super.id,
    required super.title,
    required super.category,
    required super.description,
    required super.duration,
    required super.difficulty,
    required super.steps,
    required super.calories,
    required super.assetPath,
  });

  factory WorkoutModel.fromMap(Map<String, dynamic> map) {
    return WorkoutModel(
      id: map['id'] as int,
      title: map['title'] as String,
      category: map['category'] as String,
      description: map['description'] as String,
      duration: map['duration'] as int,
      difficulty: map['difficulty'] as String,
      steps: _parseSteps(map['steps'] as String),
      calories: map['calories'] as int,
      assetPath: map['assetPath'] as String,
    );
  }

  // Parsing our custom format back to WorkoutStep objects
  // Had to handle edge cases where parsing might fail
  static List<WorkoutStep> _parseSteps(String stepsJson) {
    final steps = <WorkoutStep>[];
    final parts = stepsJson.split('||');

    for (final part in parts) {
      final colonIndex = part.indexOf(':');
      if (colonIndex > 0) {
        final stepNum = int.tryParse(part.substring(0, colonIndex));
        final instruction = part.substring(colonIndex + 1);
        // Skip invalid steps instead of crashing
        if (stepNum != null) {
          steps.add(WorkoutStep(step: stepNum, instruction: instruction));
        }
      }
    }

    return steps;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'description': description,
      'duration': duration,
      'difficulty': difficulty,
      'steps': steps.map((s) => '${s.step}:${s.instruction}').join('||'),
      'calories': calories,
      'assetPath': assetPath,
    };
  }
}
