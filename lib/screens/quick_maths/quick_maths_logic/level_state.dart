import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:game_testing/level_state_interface.dart';
import '../../../router.dart' show visualMemoryGoRouter;
import '../widget/equation_data.dart';

class QuickMathsLevelState extends ChangeNotifier
    implements LevelStateInterface {
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

  // Flag for hardest division (2‑digit divisor & quotient)
  bool hardDivision = false;

  // Timer / progress related
  Timer? _timer;
  int level = 0;
  final int totalSeconds = 10; // seconds per equation
  double timeRemaining = 10;
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
    //print(lives);
    if (parsed == correct) {
      // correct answer
      level += 1;
      equations.removeAt(0);
      generateEquation(level + 19);
      // reset timer for next equation
      timeRemaining = totalSeconds.toDouble();
    } else {
      // incorrect answer -> lose a life
      lives -= 1;
      if (lives <= 0) {
        stopTimer();
        visualMemoryGoRouter.go(
            '/result?level=$level&difficulty=$difficulty&game_path=quick_maths');
        notifyListeners();
        return;
      }
      timeRemaining = totalSeconds.toDouble();
    }
    notifyListeners(); //
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

  void updateDifficulty(int index) {
    // ----- Operators -------------------------------------------------
    if (index >= 20 && !ops.contains('×')) ops.add('×');
    if (index >= 107 && !ops.contains('÷')) ops.add('÷');

    // ----- Addition / Subtraction ranges ----------------------------
    if (index >= 300) {
      aAddBound = 9999;
      bAddBound = 9999;
    } else if (index >= 180) {
      aAddBound = 999;
      bAddBound = 999;
    } else if (index >= 54) {
      aAddBound = 99;
      bAddBound = 99;
    } else if (index >= 53) {
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
      aMultBound = 99;
      bMultBound = 99;
    } else if (index >= 75) {
      // Intermediate: a = 10..20, b = 2..9
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
      // HARDEST: divisor and result are both 2‑digit numbers
      hardDivision = true;
      // simple bounds no longer used
    } else if (index >= 135) {
      hardDivision = false;
      bDivBound = 20;
      resDivBound = 12;
    } else if (index >= 107) {
      hardDivision = false;
      bDivBound = 12;
      resDivBound = 12;
    } else {
      hardDivision = false;
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
      if (hardDivision) {
        // Hardest: divisor and quotient are both 2‑digit numbers (10‑99)
        do {
          b = rng.nextInt(90) + 10; // 10‑99
          result = rng.nextInt(90) + 10; // 10‑99
          a = result * b;
          // Prevent overflow (should be within 4 digits)
        } while (a > 9999); // safety, though max is 99*99=9801
      } else {
        // Simple division: exact, no remainder
        do {
          b = rng.nextInt(bDivBound + 1);
        } while (b < 2);
        result = rng.nextInt(resDivBound + 1);
        if (result == 0) result = 1;
        a = result * b;
      }
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
      timeRemaining -= 0.1;
      if (timeRemaining <= 0) {
        // time ran out for current equation
        lives -= 1;
        if (lives <= 0) {
          stopTimer();
          visualMemoryGoRouter.go(
              '/result?level=$level&difficulty=$difficulty&game_path=quick_maths');
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
