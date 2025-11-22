import 'package:flutter/material.dart';
import 'package:game_testing/level_state_interface.dart';
import 'package:game_testing/screens/quick_maths/quick_maths_logic/game_logic.dart';

import '../widget/equation_tiles.dart';


class QuickMathsLevelState extends ChangeNotifier implements LevelStateInterface {
  QuickMathsLevelState({required this.difficulty}) {
    _logic = QuickMathsGameLogic(
      difficulty: difficulty,
      notifyParent: notifyListeners,
    );
  }

  final String difficulty;
  late QuickMathsGameLogic _logic;
  List<EquationTiles> equations = [];
  // Expose state from logic

  @override
  void evaluate(value) async {
    await _logic.evaluate(value);
  }

  @override
  void gameSetup() {
    _logic.clearGame();
    _logic.gameSetup();
  }
}