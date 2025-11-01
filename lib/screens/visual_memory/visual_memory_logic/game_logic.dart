import 'dart:math';
import 'package:flutter/material.dart';
import 'package:game_testing/router.dart';
//import '../visual_memory_result_screen.dart';

class VisualMemoryGameLogic {
  VisualMemoryGameLogic({
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
    tileStatus = List<int?>.filled(gridSize * gridSize, null, growable: true);
  }

  final String difficulty;
  final VoidCallback notifyParent;

  int level = 0;
  late int _lives;
  int _placeholder_level_decider = 1;
  int gridSize = 3;
  int tilesToRemember = 2;
  List<int> indexOfHighlightedTiles = [];
  List<int> correctTiles = [];
  List<int> selectedTiles = [];
  List<int?> tileStatus = [];
  bool isShowingTiles = false;

  int get lives => _lives;

  Future<void> evaluate(var value) async {
    int index = value as int;
    selectedTiles[index] = 1;
    if (correctTiles[index] == 1) {
      tileStatus[index] = 1;
      indexOfHighlightedTiles.remove(index);
    } else {
      tileStatus[index] = 0;
      _lives -= 1;
    }
    notifyParent();
    if (indexOfHighlightedTiles.isEmpty) {
      await Future.delayed(Duration(milliseconds: 500), () {
        clearGame();
      });
      await Future.delayed(const Duration(milliseconds: 500), () {
        gameSetup();
      });
    } else if (_lives == 0) {
      visualMemoryGoRouter.go('/result?level=$level&difficulty=$difficulty&game_path=visual_memory');
    }
  }

  void gameSetup() {
    if (_placeholder_level_decider == gridSize) {
      gridSize++;
      _placeholder_level_decider = 1;
    } else {
      _placeholder_level_decider++;
    }
    tilesToRemember++;
    level++;

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
    isShowingTiles = true;
    notifyParent();
    Future.delayed(Duration(milliseconds: ((level + 3) * 125).toInt()), () {
      isShowingTiles = false;
      notifyParent();
    });
  }

  void clearGame() {
    indexOfHighlightedTiles.clear();
    correctTiles.clear();
    selectedTiles.clear();
    tileStatus.clear();
    for (int i = 0; i < gridSize * gridSize; i++) {
      tileStatus.add(null);
    }
    notifyParent();
  }
}

