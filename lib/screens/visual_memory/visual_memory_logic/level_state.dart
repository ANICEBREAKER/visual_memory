import 'package:flutter/material.dart';
import 'package:game_testing/level_state_interface.dart';
import 'package:game_testing/screens/visual_memory/visual_memory_logic/game_logic.dart';

class VisualMemoryLevelState extends ChangeNotifier implements LevelStateInterface {
  VisualMemoryLevelState({required this.difficulty}) {
    _logic = VisualMemoryGameLogic(
      difficulty: difficulty,
      notifyParent: notifyListeners,
    );
  }

  final String difficulty;
  late VisualMemoryGameLogic _logic;

  // Expose state from logic
  int get level => _logic.level;
  int get lives => _logic.lives;
  int get gridSize => _logic.gridSize;
  int get tilesToRemember => _logic.tilesToRemember;
  List<int> get indexOfHighlightedTiles => _logic.indexOfHighlightedTiles;
  List<int> get correctTiles => _logic.correctTiles;
  List<int> get selectedTiles => _logic.selectedTiles;
  List<int?> get tileStatus => _logic.tileStatus;
  bool get isShowingTiles => _logic.isShowingTiles;

  @override
  void evaluate(var value) async {
    await _logic.evaluate(value);
  }

  @override
  void gameSetup() {

    _logic.clearGame();
    _logic.gameSetup();
  }
}