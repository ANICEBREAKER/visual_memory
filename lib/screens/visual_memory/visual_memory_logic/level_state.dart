import 'dart:math';
import 'package:flutter/material.dart';
import 'package:game_testing/level_state_interface.dart';

class VisualMemoryLevelState extends ChangeNotifier
    implements LevelStateInterface {
  VisualMemoryLevelState({required this.onLose, required this.difficulty}) {
    if (difficulty == "Easy") {
      _lives = 3;
    } else if (difficulty == "Medium") {
      _lives = 2;
    } else {
      _lives = 1;
    }
  }

  final String difficulty;
  final VoidCallback onLose;
  int _level = 0;
  late int _lives;
  final int gridSize = 4; // 4x4 grid
  final int tilesToRemember = 8; // Number of tiles to remember (Used for debugging)
  List<int> indexOfHighlightedTiles = [
  ]; // List to store highlighted tile positions
  List<int> correctTiles = [
  ]; // List to store correct tile positions (0: wrong, 1: correct)
  List<int> selectedTiles = [
  ]; // List to store user selected tile positions (0: not selected, 1: selected)
  List<int?> tileStatus = [
  ]; // List to store tile status (null: unselected, 0: correct, 1: wrong)

  @override
  void lostALive() {
    _lives -= 1;
    notifyListeners();
  }

  @override
  void setProgress(int value) {
    _level = value;
    notifyListeners();
  }

  @override
  void evaluate() {
    if (_lives == 0) {
      onLose();
    }
  }

  void initialGameSetup() {
    // Initialize game state, e.g., generate random tiles to remember
    while (indexOfHighlightedTiles.length < tilesToRemember) {
      var intValue = Random().nextInt(gridSize * gridSize);
      if (!indexOfHighlightedTiles.contains(intValue)) {
        indexOfHighlightedTiles.add(intValue);
      }
    }
    indexOfHighlightedTiles.sort();
    for (int i = 0; i < gridSize * gridSize; i++) {
      if (indexOfHighlightedTiles.contains(i)) {
        correctTiles.add(1);
      } else {
        correctTiles.add(0);
      }
      selectedTiles.add(0);
    }
    print("Index of highlighted tiles: $indexOfHighlightedTiles");
    print("Correct tiles: $correctTiles");
    print("Selected tiles: $selectedTiles");
    notifyListeners();
  }

}