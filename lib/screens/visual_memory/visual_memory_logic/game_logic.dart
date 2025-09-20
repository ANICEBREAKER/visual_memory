import 'dart:math';
import 'package:flutter/material.dart';

class VisualMemoryGameLogic {
  VisualMemoryGameLogic({
    required this.onLose,
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
  final VoidCallback onLose;
  final VoidCallback notifyParent;

  int level = 0;
  late int _lives;
  int gridSize = 2;
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
        indexOfHighlightedTiles.clear();
        correctTiles.clear();
        selectedTiles.clear();
        tileStatus.clear();
        for (int i = 0; i < gridSize * gridSize; i++) {
          tileStatus.add(null);
        }
        notifyParent();
      });
      await Future.delayed(const Duration(milliseconds: 500), () {
        gameSetup();
      });
    } else if (_lives == 0) {
      onLose();
    }
  }

  void gameSetup() {
    tilesToRemember++;
    level++;
    if (gridSize < 6 && tilesToRemember * 1.25 > (gridSize * gridSize) / 2) {
      gridSize++;
    }
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
}

