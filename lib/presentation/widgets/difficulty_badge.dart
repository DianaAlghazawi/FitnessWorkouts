import 'package:flutter/material.dart';

class DifficultyBadge extends StatelessWidget {
  final String difficulty;

  const DifficultyBadge({
    super.key,
    required this.difficulty,
  });

  // Color coding for difficulty levels
  // Green = easy, Orange = medium, Red = hard
  Color get _color {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'hard':
        return Colors.red;
      default:
        // Fallback to grey if unknown difficulty
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _color, width: 1),
      ),
      child: Text(
        difficulty,
        style: TextStyle(
          color: _color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
