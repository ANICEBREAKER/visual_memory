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
  //int _level = 0;
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
  ]; // List to store tile status (null: unselected, 1: correct, 0: wrong)



  @override
  void evaluate(var value) {
    int index = value as int;
    selectedTiles[index] = 1; // Mark the tile as selected
    if (correctTiles[index] == 1) {
      tileStatus[index] = 1; // Correct selection
      indexOfHighlightedTiles.remove(index); // Remove from highlighted list
    } else {
      tileStatus[index] = 0; // Wrong selection
      _lives -= 1; // Decrement lives on wrong selection
    }
    notifyListeners();
    if (indexOfHighlightedTiles.isEmpty) {
      print("Level completed!");
    } else
    if (_lives == 0) {
      onLose();
    }
  }

  @override
  void gameSetup() { //Considering rename since this is levelSetup not the game setup
    //Clear previous state
    indexOfHighlightedTiles.clear();
    correctTiles.clear();
    selectedTiles.clear();
    tileStatus.clear();
    notifyListeners();
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
      tileStatus.add(null);
    }
    // Debug prints
    print("Lives: $_lives");
    print("Index of highlighted tiles: $indexOfHighlightedTiles");
    print("Correct tiles: $correctTiles");
    print("Selected tiles: $selectedTiles");
    notifyListeners();
  }

}