import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:game_testing/level_state_interface.dart';
import '../../../router.dart' show visualMemoryGoRouter;
import '../widget/equation_data.dart';


class QuickMathsLevelState extends ChangeNotifier implements LevelStateInterface {
  QuickMathsLevelState({required this.difficulty}) {
    if (difficulty == "Easy") {
      lives = 3;
    } else if (difficulty == "Medium") {
      lives = 2;
    } else {
      lives = 1;
    }
    timeRemaining = totalSeconds.toDouble();
  }

  final String difficulty;
  List<EquationData> equations = [];
  late int lives;
  late int correct;

  // Timer / progress related
  Timer? _timer;
  int level = 0;
  final int totalSeconds = 10; // seconds per equation
  double timeRemaining = 10.0;
  final int totalSteps = 100;

  int get currentStep {
    final step = (timeRemaining / totalSeconds * totalSteps).round();
    if (step < 0) return 0;
    if (step > totalSteps) return totalSteps;
    return step;
  }


  @override
  void evaluate(value) async {
    if (equations.isEmpty) {
      notifyListeners();
      return;
    }

    int? parsed;
    if (value is int) {
      parsed = value;
    } else if (value is String) {
      parsed = int.tryParse(value);
    }

    correct = equations.first.result;
    print(lives);
    if (parsed == correct) {
      // correct answer
      level += 1;
      // remove the solved equation and generate a new one to keep list length steady
      equations.removeAt(0);
      generateEquation();
      // reset timer for next equation
      timeRemaining = totalSeconds.toDouble();
    } else {
      // incorrect answer -> lose a life
      lives -= 1;
      if (lives <= 0) {
        stopTimer();
        // Navigate to result (include game_path)
        visualMemoryGoRouter.go('/result?level=$level&difficulty=$difficulty&game_path=quick_maths');
        notifyListeners();
        return;
      }
      // keep the same equation but reset timer so player can try again
      timeRemaining = totalSeconds.toDouble();
    }

    notifyListeners();
  }

  @override
  void gameSetup() {
    level = 0;
    equations.clear();
    stopTimer();
    for (int i = 0; i < 20; i++) {
      generateEquation();
    }
    timeRemaining = totalSeconds.toDouble();
    notifyListeners();
    startTimer();
  }

  void generateEquation() {
    final rng = Random();
    // choose operator
    final ops = ['+', '-', '×'];
    final op = ops[rng.nextInt(ops.length)];
    int a = rng.nextInt(12) + 1; // 1..12
    int b = rng.nextInt(12) + 1;

    // For subtraction, ensure non-negative result
    if (op == '-' && a < b) {
      final tmp = a;
      a = b;
      b = tmp;
    }

    int result;

    switch (op) {
      case '+':
        result = a + b;
      case '-':
        result = a - b;
      case '×':
      case '*':
        result = a * b;
      default:
        result = 0 ;
    }

    final tile = EquationData(firstNumber: a, secondNumber: b, operator: op, result: result);
    equations.add(tile);
    notifyListeners();
  }

  void startTimer() {
    _timer?.cancel();
    // tick every 100ms for smoother progress
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      timeRemaining -= 0.1;
      if (timeRemaining <= 0) {
        // time ran out for current equation
        lives -= 1;
        if (lives <= 0) {
          stopTimer();
          visualMemoryGoRouter.go('/result?level=$level&difficulty=$difficulty&game_path=quick_maths');
          notifyListeners();
          return;
        } else {
          // reset timer but keep the same equation so player can still answer
          timeRemaining = totalSeconds.toDouble();
        }
      }
      notifyListeners();
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }
}