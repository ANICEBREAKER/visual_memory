import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:game_testing/level_state_interface.dart';
import '../../../data/game_list.dart';
import '../../../router.dart' show goRouter;
import '../widget/equation_data.dart';

class QuickMathsLevelState extends ChangeNotifier
    implements LevelStateInterface {
  QuickMathsLevelState({required this.difficulty, required this.mode}){
    isSurvivalMode = mode.toLowerCase() == 'survival';
    if (isSurvivalMode) {
      lives = 1;
      addedTimePerCorrect = difficulty == "Easy" ? 5 : difficulty == "Medium" ? 4 : 3;
    } else {
      lives = difficulty == "Easy" ? 3 : difficulty == "Medium" ? 2 : 1;
      timeRemaining = totalSeconds.toDouble();
    }
  }

  final String difficulty;
  final String mode;
  late bool isSurvivalMode;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  List<EquationData> equations = [];
  late int lives;
  late int correct;

  // Current available operators
  List<String> ops = ["+", "-"];

  // Bounds for addition / subtraction
  int aAddBound = 10;
  int bAddBound = 10;

  // Bounds for multiplication (simple & hard)
  int aMultBound = 10;
  int bMultBound = 10;

  // Bounds for simple division (divisor & quotient)
  int bDivBound = 10;
  int resDivBound = 10;


  // Timer / progress related
  Timer? _timer;
  int level = 0;
  final int totalSeconds = 30; // seconds per equation, for survival mode this is the initial total time limit
  late int addedTimePerCorrect; // seconds added per correct answer in survival mode
  int subtractedTimePerWrong = 5; // seconds subtracted per wrong answer in survival mode
  int subtractTotalSeconds = 5;
  double timeRemaining = 15;
  final int totalSteps = 100;

  int get currentStep {
    final step = (timeRemaining / totalSeconds * totalSteps).round();
    if (step < 0) return 0;
    if (step > totalSteps) return totalSteps;
    return step;
  }

  bool? isCorrect;

  bool _isAnimating = false;

  @override
  Future<void> evaluate(value) async {
    // Prevent evaluating while an animation is showing or if no equations
    if (_isAnimating || equations.isEmpty) {
      notifyListeners();
      return;
    }

    // Parse the input value
    int? parsed;
    if (value == null) {
      parsed = null;
    } else if (value is int) {
      parsed = value;
    } else if (value is String) {
      parsed = int.tryParse(value);
    }

    final correctAnswer = equations.first.result;
    final bool correct = (parsed != null && parsed == correctAnswer);

    // Begin feedback animation
    _isAnimating = true;
    isCorrect = correct;
    stopTimer(); // Freeze timer while showing feedback
    notifyListeners();

    // Show feedback for 500ms
    await Future.delayed(const Duration(milliseconds: 500));

    if (correct) {
      // Scenario: Correct answer
      level += 1;
      equations.removeAt(0);
      generateEquation(level + 19);

      if (isSurvivalMode) {
        // Survival mode: Add time, capped at totalSeconds
        timeRemaining = (timeRemaining + addedTimePerCorrect > totalSeconds)
            ? totalSeconds.toDouble()
            : timeRemaining + addedTimePerCorrect;
      } else {
        // Non-survival mode: Reset timer to full time
        timeRemaining = totalSeconds.toDouble();
      }
    } else {
      // Scenario: Incorrect answer or timeout
      if (isSurvivalMode) {
        // Survival mode: Subtract time or end game
        if (timeRemaining - subtractedTimePerWrong > 0) {
          timeRemaining -= subtractedTimePerWrong;
        } else {
          // Out of time: End game
          timeRemaining = 0;
          stopTimer();
          goRouter.go(
              '/result?level=$level&difficulty=$difficulty&game_path=${GameName.quick_maths.displayName}');
          return;
        }
      } else {
        // Non-survival mode: Lose a life or end game
        lives -= 1;
        if (lives <= 0) {
          stopTimer();
          goRouter.go(
              '/result?level=$level&difficulty=$difficulty&game_path=${GameName.quick_maths.displayName}');
          return;
        } else {
          // Reset timer for next attempt
          timeRemaining = totalSeconds.toDouble();
        }
      }
    }

    // Clear animation state and resume timer
    isCorrect = null;
    _isAnimating = false;
    notifyListeners();
    startTimer();
  }

  @override
  void gameSetup() {
    level = 0;
    equations.clear();
    stopTimer();
    for (int i = 0; i < 20; i++) {
      generateEquation(i);
    }

    if (!isSurvivalMode) {
      timeRemaining = totalSeconds.toDouble();
    }

    isCorrect = null;
    notifyListeners();
    startTimer();
  }

  void updateDifficulty(int index) {
    // ----- Operators -------------------------------------------------
    if (index >= 20 && !ops.contains('×')) ops.add('×');
    if (index >= 30 && !ops.contains('÷')) ops.add('÷');

    // ----- Addition / Subtraction ranges ----------------------------
    if (index >= 120) {
      aAddBound = 999;
      bAddBound = 99;
    } else if (index >= 54) {
      aAddBound = 99;
      bAddBound = 99;
    } else if (index >= 25) {
      aAddBound = 20;
      bAddBound = 20;
    } else if (index >= 12) {
      aAddBound = 15;
      bAddBound = 15;
    } else {
      aAddBound = 10;
      bAddBound = 10;
    }

    // ----- Multiplication ranges ------------------------------------
    if (index >= 182) {
      // HARDEST: both a and b are 2‑digit numbers (10‑99)
      aMultBound = 50;
      bMultBound = 10;
    } else if (index >= 75) {
      aMultBound = 20;
      bMultBound = 9;
    } else if (index >= 38) {
      aMultBound = 12;
      bMultBound = 12;
    } else {
      aMultBound = 10;
      bMultBound = 10;
    }

    // ----- Division ranges & mode ----------------------------------
    if (index >= 182) {
      // HARDEST: both divisor and quotient are 2‑digit numbers (10‑99)
      bDivBound = 50;
      resDivBound = 10;
    } else if (index >= 135) {
      bDivBound = 20;
      resDivBound = 12;
    } else if (index >= 107) {
      bDivBound = 12;
      resDivBound = 12;
    } else {
      bDivBound = 10;
      resDivBound = 10;
    }
  }

  void generateEquation(int index) {
    updateDifficulty(index);

    final rng = Random();
    String op = ops[rng.nextInt(ops.length)];

    int a = 0;
    int b = 0;
    int result = 0;

    if (op == '+') {
      a = rng.nextInt(aAddBound + 1);
      b = rng.nextInt(bAddBound + 1);
      result = a + b;
    } else if (op == '-') {
      a = rng.nextInt(aAddBound + 1);
      b = rng.nextInt(bAddBound + 1);
      // Ensure non‑negative result
      if (a < b) {
        int tmp = a;
        a = b;
        b = tmp;
      }
      result = a - b;
    } else if (op == '×') {
      if (index >= 75 && index < 182) {
        // Special intermediate: a = 10‑20, b = 2‑9
        a = rng.nextInt(11) + 10; // 10..20
        b = rng.nextInt(8) + 2; // 2..9
      } else {
        a = rng.nextInt(aMultBound + 1);
        b = rng.nextInt(bMultBound + 1);
        // At hardest (index >=182): both become 10‑99 automatically
        if (index >= 182) {
          // Ensure both are at least 10 (2‑digit)
          if (a < 10) a += 10;
          if (b < 10) b += 10;
          // Clamp to 99
          if (a > 99) a = 99;
          if (b > 99) b = 99;
        }
      }
      result = a * b;
    } else {
      // op == '÷'
      do {
        b = rng.nextInt(bDivBound + 1);
      } while (b < 2);
      result = rng.nextInt(resDivBound + 1);
      if (result == 0) result = 1;
      a = result * b;
    }

    final tile = EquationData(
        firstNumber: a, secondNumber: b, operator: op, result: result);
    listKey.currentState?.insertItem(equations.length - 1);
    equations.add(tile);
  }

  void startTimer() {
    _timer?.cancel();
    // tick every 100ms for smoother progress
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      // If an animation is running, don't decrement timer here.
      if (_isAnimating) return;

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
}
