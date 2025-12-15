import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/database/database_helper.dart';
import 'core/navigation/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/workout_list_screen.dart';
import 'presentation/screens/workout_details_screen.dart';
import 'presentation/screens/workout_timer_screen.dart';
import 'presentation/screens/favorites_screen.dart';
import 'presentation/screens/progress_screen.dart';
import 'presentation/screens/settings_screen.dart';
import 'presentation/screens/privacy_policy_screen.dart';
import 'presentation/state/workout_state.dart' as state;
import 'domain/entities/workout_entity.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize database
  await DatabaseHelper.instance.database;
  
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(state.themeModeProvider);

    return MaterialApp(
      title: 'Offline Fitness Workouts',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.workoutList: (context) {
          final category = ModalRoute.of(context)!.settings.arguments as String;
          return WorkoutListScreen(category: category);
        },
        AppRoutes.workoutDetails: (context) {
          final workoutId = ModalRoute.of(context)!.settings.arguments as int;
          return WorkoutDetailsScreen(workoutId: workoutId);
        },
        AppRoutes.workoutTimer: (context) {
          final workout = ModalRoute.of(context)!.settings.arguments as WorkoutEntity;
          return WorkoutTimerScreen(workout: workout);
        },
        AppRoutes.favorites: (context) => const FavoritesScreen(),
        AppRoutes.progress: (context) => const ProgressScreen(),
        AppRoutes.settings: (context) => const SettingsScreen(),
        AppRoutes.privacy: (context) => const PrivacyPolicyScreen(),
      },
    );
  }
}
