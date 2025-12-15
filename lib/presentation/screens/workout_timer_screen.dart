import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/date_utils.dart' as app_date_utils;
import '../../domain/entities/workout_entity.dart';
import '../widgets/timer_widget.dart';
import '../../core/di/providers.dart' as di;

class WorkoutTimerScreen extends ConsumerStatefulWidget {
  final WorkoutEntity workout;

  const WorkoutTimerScreen({
    super.key,
    required this.workout,
  });

  @override
  ConsumerState<WorkoutTimerScreen> createState() => _WorkoutTimerScreenState();
}

class _WorkoutTimerScreenState extends ConsumerState<WorkoutTimerScreen> {
  Timer? _timer;
  int _currentSeconds = 0;
  int _currentStepIndex = 0;
  bool _isRunning = false;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _currentSeconds = widget.workout.duration * 60;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    // Handle resume vs fresh start
    if (_isPaused) {
      _isPaused = false;
      _isRunning = true;
    } else {
      _isRunning = true;
    }

    // Cancel any existing timer first (safety check)
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentSeconds > 0) {
        setState(() {
          _currentSeconds--;
        });
      } else {
        // Timer finished!
        _completeWorkout();
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _isPaused = true;
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _currentSeconds = widget.workout.duration * 60;
      _currentStepIndex = 0;
      _isRunning = false;
      _isPaused = false;
    });
  }

  void _completeWorkout() {
    _timer?.cancel();
    // Log the completed workout to history
    final date = app_date_utils.DateUtils.getCurrentTimestamp();
    ref.read(di.logHistoryProvider).call(
      workoutId: widget.workout.id,
      date: date,
      duration: widget.workout.duration,
      calories: widget.workout.calories,
    );
    // TODO: Maybe add a celebration animation here?

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Workout Complete!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 64),
            const SizedBox(height: 16),
            Text('You completed ${widget.workout.title}'),
            const SizedBox(height: 8),
            Text('Duration: ${widget.workout.duration} minutes'),
            const SizedBox(height: 8),
            Text('Calories burned: ${widget.workout.calories}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  void _nextStep() {
    if (_currentStepIndex < widget.workout.steps.length - 1) {
      setState(() {
        _currentStepIndex++;
      });
    }
  }

  void _previousStep() {
    if (_currentStepIndex > 0) {
      setState(() {
        _currentStepIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentStep = widget.workout.steps[_currentStepIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workout.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TimerWidget(
                    seconds: _currentSeconds,
                    isRunning: _isRunning,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Step ${_currentStepIndex + 1} of ${widget.workout.steps.length}',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            currentStep.instruction,
                            style: theme.textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: _currentStepIndex > 0 ? _previousStep : null,
                        icon: const Icon(Icons.arrow_back),
                        tooltip: 'Previous step',
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        onPressed:
                            _currentStepIndex < widget.workout.steps.length - 1
                                ? _nextStep
                                : null,
                        icon: const Icon(Icons.arrow_forward),
                        tooltip: 'Next step',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!_isRunning && !_isPaused)
                  FilledButton.icon(
                    onPressed: _startTimer,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Start'),
                  )
                else if (_isRunning)
                  FilledButton.icon(
                    onPressed: _pauseTimer,
                    icon: const Icon(Icons.pause),
                    label: const Text('Pause'),
                  )
                else
                  FilledButton.icon(
                    onPressed: _startTimer,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Resume'),
                  ),
                const SizedBox(width: 16),
                OutlinedButton.icon(
                  onPressed: _resetTimer,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
