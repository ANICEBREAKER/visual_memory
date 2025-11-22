import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:game_testing/router.dart';
import 'package:game_testing/screens/quick_maths/widget/equation_tiles.dart';
import 'package:game_testing/screens/quick_maths/quick_maths_logic/level_state.dart';

class QuickMathsGameLogic {
  QuickMathsGameLogic({
    required this.difficulty,
    required this.notifyParent,
  }) {
    if (difficulty == "Easy") {
      _lives = 3;
    } else if (difficulty == "Medium") {
      _lives = 2;
    } else {
      _lives = 1;
    }
    timeRemaining = totalSeconds.toDouble();
  }

  final String difficulty;
  final VoidCallback notifyParent;

  int level = 1;
  late int _lives;

  // Timer / progress related
  Timer? _timer;
  final int totalSeconds = 10; // seconds per equation
  double timeRemaining = 10.0;
  final int totalSteps = 100;

  int get lives => _lives;
  int get currentStep {
    final step = (timeRemaining / totalSeconds * totalSteps).round();
    if (step < 0) return 0;
    if (step > totalSteps) return totalSteps;
    return step;
  }

  Future<void> evaluate(var value) async {
    // If check answer
    // Answer is correct then you would level+1 and next tile, delete old tile, but if not the game continues
    // Check if time remaining equals zero, if it is then lives -1, and reset time, and the player still answers

    if (equations.isEmpty) {
      notifyParent();
      return;
    }

    int? parsed;
    if (value is int) {
      parsed = value;
    } else if (value is String) {
      parsed = int.tryParse(value);
    }

    final correct = equations.first.compute();

    if (parsed != null && parsed == correct) {
      // correct answer
      level += 1;
      // remove the solved equation and generate a new one to keep list length steady
      equations.removeAt(0);
      generateEquation();
      // reset timer for next equation
      timeRemaining = totalSeconds.toDouble();
    } else {
      // incorrect answer -> lose a life
      _lives -= 1;
      if (_lives <= 0) {
        stopTimer();
        // Navigate to result (include game_path)
        visualMemoryGoRouter.go('/result?level=$level&difficulty=$difficulty&game_path=quick_maths');
        notifyParent();
        return;
      }
      // keep the same equation but reset timer so player can try again
      timeRemaining = totalSeconds.toDouble();
    }

    notifyParent();
  }

  void clearGame() {
    level = 0;
    _lives = 0;
    equations.clear();
    stopTimer();
  }

  void gameSetup() {
    //Should make about 20 of these in advance
    //Add them to new list
    equations.clear();
    for (int i = 0; i < 20; i++) {
      generateEquation();
    }
    timeRemaining = totalSeconds.toDouble();
    notifyParent();
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

    final tile = EquationTiles(firstNumber: a, secondNumber: b, operator: op);
    equations.add(tile);
    notifyParent();
  }

  void startTimer() {
    _timer?.cancel();
    // tick every 100ms for smoother progress
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      timeRemaining -= 0.1;
      if (timeRemaining <= 0) {
        // time ran out for current equation
        _lives -= 1;
        if (_lives <= 0) {
          stopTimer();
          visualMemoryGoRouter.go('/result?level=$level&difficulty=$difficulty&game_path=quick_maths');
          notifyParent();
          return;
        } else {
          // reset timer but keep the same equation so player can still answer
          timeRemaining = totalSeconds.toDouble();
        }
      }
      notifyParent();
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }
}
