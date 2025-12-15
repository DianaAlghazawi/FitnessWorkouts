import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/navigation/app_routes.dart';
import '../../core/utils/constants.dart';
import '../widgets/category_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        // Main app title
        title: const Text('Offline Fitness Workouts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.favorites);
            },
            tooltip: 'Favorites',
          ),
          IconButton(
            icon: const Icon(Icons.trending_up),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.progress);
            },
            tooltip: 'Progress',
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.settings);
            },
            tooltip: 'Settings',
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
        ),
        itemCount: AppConstants.categories.length,
        itemBuilder: (context, index) {
          final category = AppConstants.categories[index];
          return CategoryCard(
            title: category,
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.workoutList,
                arguments: category,
              );
            },
          );
        },
      ),
    );
  }
}
