import 'package:flutter/material.dart';
import '../../../data/game_list.dart';
import '../../../level_state_interface.dart';
import 'dart:async'; //Clock
import 'dart:math';

import '../../../router.dart'; //Random


class ColorShiftLevelState extends ChangeNotifier implements LevelStateInterface {
  ColorShiftLevelState({required this.usingPatterns, required this.difficulty}) {}

  final bool usingPatterns;
  final String difficulty;
  final rng = Random();

  // Lives & Level
  int lives = 3;
  int level = 0;

  // Colors
  int colorsInPlay = 4;
  List<String> colorList = ['red', 'blue', 'yellow','green', 'purple', 'orange'];
  String displayedText = '';
  String textColor = '';


  // Timer related
  Timer? _timer;
  double totalSeconds = 15; // seconds per question
  double timeRemaining = 15; //remaining time
  double addedTimePerCorrect = 3; // seconds added per correct answer in survival mode
  double subtractedTimePerWrong = 4; // seconds subtracted per wrong answer in survival mode
  final int totalSteps = 100;

  int get currentStep {
    final step = (timeRemaining / totalSeconds * totalSteps).round();
    if (step < 0) return 0;
    if (step > totalSteps) return totalSteps;
    return step;
  }

  @override
  void evaluate(value) {
    stopTimer();
    notifyListeners();
    if (value == textColor) {

      if (timeRemaining + addedTimePerCorrect > totalSeconds) {
        timeRemaining = totalSeconds.toDouble();
      } else {
        timeRemaining += addedTimePerCorrect;
      }

      level += 1;
      if (level == 5) {
        colorsInPlay = 5;
      } else if (level == 10) {
        colorsInPlay = 6;
      }

      if (level % 10 == 0 && level >= 10) {
        totalSeconds *= 0.8;
        timeRemaining *= 0.8;
        addedTimePerCorrect *= 0.8;
      }

      newPrompt();
      notifyListeners();
      startTimer();
    } else {
      if (timeRemaining - subtractedTimePerWrong > 0) {
        timeRemaining -= subtractedTimePerWrong;
        notifyListeners();
        startTimer();
        return;
      } else {
        timeRemaining = 0;
        stopTimer();
        goRouter.go(
            '/result?level=$level&difficulty=$difficulty&game_path=${GameName.color_shift.displayName}');
        return;
      }
    }
  }

  @override
  void gameSetup() {
    level = 0;
    lives = 3;
    newPrompt();
    stopTimer();
    notifyListeners();
    startTimer();
  }

  void newPrompt() {
    displayedText = colorList[rng.nextInt(colorsInPlay)];
    textColor = colorList[rng.nextInt(colorsInPlay)];
  }

  void startTimer() {
    _timer?.cancel();
    // tick every 100ms for smoother progress
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      // If an animation is running, don't decrement timer here.
      // if (_isAnimating) return;

      timeRemaining -= 0.1;
      if (timeRemaining <= 0) {
        // treat timeout as a wrong answer and route through evaluate flow
        // unified evaluate handles both survival and normal modes (including navigation)
        evaluate(null);
        return;
      }
      notifyListeners();
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  // Helper method to map color strings to Flutter Color objects
  Color getTextColor() {
    switch (textColor) {
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'yellow':
        return Colors.yellow;
      case 'green':
        return Colors.green;
      case 'purple':
        return Colors.purple;
      case 'orange':
        return Colors.orange;
      default:
        return Colors.black; // Fallback color
    }
  }
}