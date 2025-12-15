import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = 'fitness_workouts.db';
  static const _databaseVersion = 1;

  static const workoutsTable = 'workouts';
  static const favoritesTable = 'favorites';
  static const historyTable = 'history';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Creating workouts table - storing all workout data locally
    // Using TEXT for steps since SQLite doesn't have native JSON support
    await db.execute('''
      CREATE TABLE $workoutsTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        category TEXT NOT NULL,
        description TEXT NOT NULL,
        duration INTEGER NOT NULL,
        difficulty TEXT NOT NULL,
        steps TEXT NOT NULL,
        calories INTEGER NOT NULL,
        assetPath TEXT NOT NULL
      )
    ''');

    // Favorites - simple table, just workout IDs
    // TODO: Maybe add timestamp later to show when favorited?
    await db.execute('''
      CREATE TABLE $favoritesTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        workoutId INTEGER NOT NULL,
        FOREIGN KEY (workoutId) REFERENCES $workoutsTable (id) ON DELETE CASCADE,
        UNIQUE(workoutId)
      )
    ''');

    // History tracking - stores completed workouts
    // Using INTEGER for date (timestamp) for easier querying
    await db.execute('''
      CREATE TABLE $historyTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        workoutId INTEGER NOT NULL,
        date INTEGER NOT NULL,
        duration INTEGER NOT NULL,
        calories INTEGER NOT NULL,
        FOREIGN KEY (workoutId) REFERENCES $workoutsTable (id) ON DELETE CASCADE
      )
    ''');

    // Populate with initial workout data
    // In production, you might want to load from a file instead
    await _insertSampleWorkouts(db);
  }

  Future<void> _insertSampleWorkouts(Database db) async {
    final workouts = _getSampleWorkouts();
    final batch = db.batch();

    for (final workout in workouts) {
      batch.insert(workoutsTable, workout);
    }

    await batch.commit(noResult: true);
  }

  List<Map<String, dynamic>> _getSampleWorkouts() {
    return [
      // Full Body Workouts
      {
        'title': 'Full Body Blast',
        'category': 'Full Body',
        'description':
            'A comprehensive full body workout targeting all major muscle groups.',
        'duration': 30,
        'difficulty': 'Medium',
        'steps': _jsonEncode([
          {
            'step': 1,
            'instruction': 'Warm up with 5 minutes of light jogging in place'
          },
          {'step': 2, 'instruction': 'Perform 3 sets of 12 push-ups'},
          {'step': 3, 'instruction': 'Do 3 sets of 15 squats'},
          {'step': 4, 'instruction': 'Complete 3 sets of 10 burpees'},
          {
            'step': 5,
            'instruction': 'Hold plank position for 60 seconds, 3 times'
          },
          {'step': 6, 'instruction': 'Cool down with 5 minutes of stretching'},
        ]),
        'calories': 250,
        'assetPath': 'assets/workouts/full_body_blast.png',
      },
      {
        'title': 'Total Body Strength',
        'category': 'Full Body',
        'description':
            'Build strength across your entire body with this intense workout.',
        'duration': 45,
        'difficulty': 'Hard',
        'steps': _jsonEncode([
          {'step': 1, 'instruction': 'Warm up: 5 minutes dynamic stretching'},
          {'step': 2, 'instruction': '4 sets of 10 push-ups with variations'},
          {'step': 3, 'instruction': '4 sets of 20 squats'},
          {'step': 4, 'instruction': '3 sets of 15 lunges per leg'},
          {'step': 5, 'instruction': '4 sets of 12 mountain climbers'},
          {'step': 6, 'instruction': '3 sets of 10 burpees'},
          {
            'step': 7,
            'instruction': 'Hold side plank 45 seconds each side, 3 sets'
          },
          {'step': 8, 'instruction': 'Cool down: 10 minutes stretching'},
        ]),
        'calories': 380,
        'assetPath': 'assets/workouts/total_body_strength.png',
      },
      {
        'title': 'Quick Full Body',
        'category': 'Full Body',
        'description':
            'A quick 20-minute full body workout perfect for busy days.',
        'duration': 20,
        'difficulty': 'Easy',
        'steps': _jsonEncode([
          {'step': 1, 'instruction': '2 minutes light warm-up'},
          {'step': 2, 'instruction': '2 sets of 10 push-ups'},
          {'step': 3, 'instruction': '2 sets of 15 squats'},
          {'step': 4, 'instruction': '2 sets of 30-second planks'},
          {'step': 5, 'instruction': '2 sets of 10 jumping jacks'},
          {'step': 6, 'instruction': '5 minutes cool down'},
        ]),
        'calories': 150,
        'assetPath': 'assets/workouts/quick_full_body.png',
      },
      // Abs & Core
      {
        'title': 'Core Crusher',
        'category': 'Abs & Core',
        'description':
            'Intense core workout to strengthen your abs and improve stability.',
        'duration': 25,
        'difficulty': 'Hard',
        'steps': _jsonEncode([
          {
            'step': 1,
            'instruction': 'Warm up with 3 minutes of light movement'
          },
          {'step': 2, 'instruction': '3 sets of 20 crunches'},
          {'step': 3, 'instruction': '3 sets of 15 leg raises'},
          {'step': 4, 'instruction': 'Hold plank for 60 seconds, 4 times'},
          {'step': 5, 'instruction': '3 sets of 20 Russian twists'},
          {'step': 6, 'instruction': '3 sets of 15 bicycle crunches'},
          {
            'step': 7,
            'instruction': 'Hold side plank 45 seconds each side, 3 sets'
          },
          {'step': 8, 'instruction': 'Cool down with core stretches'},
        ]),
        'calories': 200,
        'assetPath': 'assets/workouts/core_crusher.png',
      },
      {
        'title': 'Abs Beginner',
        'category': 'Abs & Core',
        'description': 'Perfect introduction to core strengthening exercises.',
        'duration': 15,
        'difficulty': 'Easy',
        'steps': _jsonEncode([
          {'step': 1, 'instruction': '2 minutes warm-up'},
          {'step': 2, 'instruction': '2 sets of 10 crunches'},
          {'step': 3, 'instruction': '2 sets of 30-second planks'},
          {'step': 4, 'instruction': '2 sets of 10 leg raises'},
          {'step': 5, 'instruction': '2 sets of 10 Russian twists'},
          {'step': 6, 'instruction': '5 minutes cool down'},
        ]),
        'calories': 100,
        'assetPath': 'assets/workouts/abs_beginner.png',
      },
      {
        'title': 'Six Pack Abs',
        'category': 'Abs & Core',
        'description': 'Advanced ab workout to sculpt your six-pack.',
        'duration': 30,
        'difficulty': 'Hard',
        'steps': _jsonEncode([
          {'step': 1, 'instruction': '5 minutes dynamic warm-up'},
          {'step': 2, 'instruction': '4 sets of 25 crunches'},
          {'step': 3, 'instruction': '4 sets of 20 leg raises'},
          {'step': 4, 'instruction': 'Hold plank 90 seconds, 4 times'},
          {'step': 5, 'instruction': '4 sets of 30 Russian twists'},
          {'step': 6, 'instruction': '4 sets of 20 bicycle crunches'},
          {'step': 7, 'instruction': '3 sets of 15 reverse crunches'},
          {
            'step': 8,
            'instruction': 'Hold side plank 60 seconds each side, 3 sets'
          },
          {'step': 9, 'instruction': 'Cool down: 10 minutes stretching'},
        ]),
        'calories': 250,
        'assetPath': 'assets/workouts/six_pack_abs.png',
      },
      // Arms & Shoulders
      {
        'title': 'Arm Strength Builder',
        'category': 'Arms & Shoulders',
        'description':
            'Build strong, toned arms and shoulders with bodyweight exercises.',
        'duration': 25,
        'difficulty': 'Medium',
        'steps': _jsonEncode([
          {'step': 1, 'instruction': '5 minutes arm circles and warm-up'},
          {'step': 2, 'instruction': '3 sets of 12 push-ups'},
          {'step': 3, 'instruction': '3 sets of 10 tricep dips'},
          {
            'step': 4,
            'instruction': '3 sets of 15 arm circles forward and backward'
          },
          {'step': 5, 'instruction': '3 sets of 10 pike push-ups'},
          {
            'step': 6,
            'instruction': '3 sets of 30-second wall sits with arm raises'
          },
          {'step': 7, 'instruction': 'Cool down: 5 minutes arm stretches'},
        ]),
        'calories': 180,
        'assetPath': 'assets/workouts/arm_strength_builder.png',
      },
      {
        'title': 'Shoulder Sculptor',
        'category': 'Arms & Shoulders',
        'description': 'Target your shoulders for definition and strength.',
        'duration': 20,
        'difficulty': 'Easy',
        'steps': _jsonEncode([
          {'step': 1, 'instruction': '3 minutes warm-up'},
          {'step': 2, 'instruction': '3 sets of 15 arm circles'},
          {'step': 3, 'instruction': '3 sets of 10 pike push-ups'},
          {
            'step': 4,
            'instruction': '3 sets of 12 shoulder taps in plank position'
          },
          {
            'step': 5,
            'instruction': '3 sets of 15 lateral arm raises (simulated)'
          },
          {'step': 6, 'instruction': 'Cool down: 5 minutes stretching'},
        ]),
        'calories': 120,
        'assetPath': 'assets/workouts/shoulder_sculptor.png',
      },
      {
        'title': 'Power Arms',
        'category': 'Arms & Shoulders',
        'description': 'Intense arm and shoulder workout for maximum strength.',
        'duration': 35,
        'difficulty': 'Hard',
        'steps': _jsonEncode([
          {'step': 1, 'instruction': '5 minutes comprehensive warm-up'},
          {'step': 2, 'instruction': '4 sets of 15 push-ups'},
          {'step': 3, 'instruction': '4 sets of 12 diamond push-ups'},
          {'step': 4, 'instruction': '4 sets of 15 tricep dips'},
          {'step': 5, 'instruction': '4 sets of 10 pike push-ups'},
          {'step': 6, 'instruction': '4 sets of 20 shoulder taps'},
          {
            'step': 7,
            'instruction': '3 sets of 30-second plank with arm raises'
          },
          {'step': 8, 'instruction': 'Cool down: 10 minutes stretching'},
        ]),
        'calories': 300,
        'assetPath': 'assets/workouts/power_arms.png',
      },
      // Legs & Glutes
      {
        'title': 'Leg Day Power',
        'category': 'Legs & Glutes',
        'description':
            'Build strong legs and glutes with this comprehensive workout.',
        'duration': 30,
        'difficulty': 'Medium',
        'steps': _jsonEncode([
          {'step': 1, 'instruction': '5 minutes leg warm-up'},
          {'step': 2, 'instruction': '3 sets of 20 squats'},
          {'step': 3, 'instruction': '3 sets of 15 lunges per leg'},
          {'step': 4, 'instruction': '3 sets of 20 glute bridges'},
          {'step': 5, 'instruction': '3 sets of 15 calf raises'},
          {'step': 6, 'instruction': '3 sets of 20 sumo squats'},
          {'step': 7, 'instruction': 'Cool down: 10 minutes leg stretches'},
        ]),
        'calories': 280,
        'assetPath': 'assets/workouts/leg_day_power.png',
      },
      {
        'title': 'Glute Builder',
        'category': 'Legs & Glutes',
        'description': 'Focus on building strong, toned glutes.',
        'duration': 25,
        'difficulty': 'Easy',
        'steps': _jsonEncode([
          {'step': 1, 'instruction': '3 minutes warm-up'},
          {'step': 2, 'instruction': '3 sets of 20 glute bridges'},
          {
            'step': 3,
            'instruction': '3 sets of 15 single-leg glute bridges per leg'
          },
          {'step': 4, 'instruction': '3 sets of 20 squats'},
          {'step': 5, 'instruction': '3 sets of 15 lunges per leg'},
          {'step': 6, 'instruction': 'Cool down: 5 minutes stretching'},
        ]),
        'calories': 200,
        'assetPath': 'assets/workouts/glute_builder.png',
      },
      {
        'title': 'Leg Burner',
        'category': 'Legs & Glutes',
        'description': 'Intense leg workout to push your limits.',
        'duration': 40,
        'difficulty': 'Hard',
        'steps': _jsonEncode([
          {'step': 1, 'instruction': '5 minutes dynamic warm-up'},
          {'step': 2, 'instruction': '4 sets of 25 squats'},
          {'step': 3, 'instruction': '4 sets of 20 lunges per leg'},
          {'step': 4, 'instruction': '4 sets of 25 glute bridges'},
          {'step': 5, 'instruction': '4 sets of 20 jump squats'},
          {'step': 6, 'instruction': '4 sets of 15 single-leg squats per leg'},
          {'step': 7, 'instruction': '3 sets of 30 calf raises'},
          {'step': 8, 'instruction': 'Cool down: 10 minutes stretching'},
        ]),
        'calories': 400,
        'assetPath': 'assets/workouts/leg_burner.png',
      },
      // Stretching & Flexibility
      {
        'title': 'Morning Stretch',
        'category': 'Stretching & Flexibility',
        'description': 'Gentle morning stretches to start your day right.',
        'duration': 15,
        'difficulty': 'Easy',
        'steps': _jsonEncode([
          {'step': 1, 'instruction': 'Neck rolls: 10 circles each direction'},
          {'step': 2, 'instruction': 'Shoulder rolls: 10 forward and backward'},
          {'step': 3, 'instruction': 'Arm stretches: hold each arm 30 seconds'},
          {'step': 4, 'instruction': 'Forward fold: hold 60 seconds'},
          {'step': 5, 'instruction': 'Quad stretch: 30 seconds each leg'},
          {'step': 6, 'instruction': 'Hamstring stretch: 30 seconds each leg'},
          {'step': 7, 'instruction': 'Spinal twist: 30 seconds each side'},
        ]),
        'calories': 50,
        'assetPath': 'assets/workouts/morning_stretch.png',
      },
      {
        'title': 'Full Body Flexibility',
        'category': 'Stretching & Flexibility',
        'description':
            'Comprehensive stretching routine for improved flexibility.',
        'duration': 30,
        'difficulty': 'Medium',
        'steps': _jsonEncode([
          {'step': 1, 'instruction': '5 minutes light warm-up'},
          {'step': 2, 'instruction': 'Neck and shoulder stretches: 2 minutes'},
          {'step': 3, 'instruction': 'Arm and chest stretches: 3 minutes'},
          {'step': 4, 'instruction': 'Spine mobility: 5 minutes'},
          {'step': 5, 'instruction': 'Hip flexor stretches: 5 minutes'},
          {
            'step': 6,
            'instruction':
                'Leg stretches (quads, hamstrings, calves): 8 minutes'
          },
          {'step': 7, 'instruction': 'Cool down: 2 minutes'},
        ]),
        'calories': 80,
        'assetPath': 'assets/workouts/full_body_flexibility.png',
      },
      {
        'title': 'Yoga Flow',
        'category': 'Stretching & Flexibility',
        'description': 'Flowing yoga-inspired stretches for mind and body.',
        'duration': 25,
        'difficulty': 'Medium',
        'steps': _jsonEncode([
          {'step': 1, 'instruction': 'Mountain pose: 1 minute'},
          {'step': 2, 'instruction': 'Forward fold: 1 minute'},
          {'step': 3, 'instruction': 'Downward dog: 1 minute'},
          {'step': 4, 'instruction': 'Warrior poses: 2 minutes each side'},
          {'step': 5, 'instruction': 'Triangle pose: 1 minute each side'},
          {'step': 6, 'instruction': 'Child\'s pose: 2 minutes'},
          {'step': 7, 'instruction': 'Seated forward fold: 2 minutes'},
          {'step': 8, 'instruction': 'Spinal twist: 1 minute each side'},
          {'step': 9, 'instruction': 'Savasana: 3 minutes'},
        ]),
        'calories': 100,
        'assetPath': 'assets/workouts/yoga_flow.png',
      },
    ];
  }

  // Custom encoding since we don't need full JSON parsing
  // Using || separator - simple but works for our use case
  // Could use proper JSON but this is lighter weight
  String _jsonEncode(List<Map<String, dynamic>> data) {
    return data.map((e) => '${e['step']}:${e['instruction']}').join('||');
  }
}
