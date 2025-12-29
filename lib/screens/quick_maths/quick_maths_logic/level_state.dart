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
      generateEquation(level + 19);
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
      generateEquation(i);
    }
    timeRemaining = totalSeconds.toDouble();
    notifyListeners();
    startTimer();
  }

  void generateEquation(int index) {
    final rng = Random();

    String op;
    int a;
    int b;

    if (index < 10) {
      // First 10: only + and -, numbers between 0..10
      op = rng.nextBool() ? '+' : '-';
      a = rng.nextInt(11); // 0..10
      b = rng.nextInt(11); // 0..10
    } else if (index < 20) {
      // Next 10: introduce multiplication (1..10), + and - still 0..10
      final ops = ['+', '-', '×'];
      op = ops[rng.nextInt(ops.length)];
      if (op == '×') {
        a = rng.nextInt(10) + 1; // 1..10
        b = rng.nextInt(10) + 1; // 1..10
      } else {
        a = rng.nextInt(21); // 0..20
        b = rng.nextInt(21); // 0..20
      }
    } else {
      // index >= 20: + and - use 1..30, multiplication: 1..10 * 1..20
      final ops = ['+', '-', '×'];
      op = ops[rng.nextInt(ops.length)];
      if (op == '×') {
        a = rng.nextInt(11); // 0..10
        b = rng.nextInt(20) + 1; // 1..20
      } else {
        a = rng.nextInt(31); // 0..30
        b = rng.nextInt(31); // 0..30
      }
    }

    // For subtraction, ensure non-negative result
    if (op == '-' && a < b) {
      final tmp = a;
      a = b;
      b = tmp;
    }

    int result;
    if (op == '+') {
      result = a + b;
    } else if (op == '-') {
      result = a - b;
    } else {
      result = a * b;
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