import 'dart:math';
import 'package:flutter/material.dart';
import 'package:game_testing/router.dart';

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
  }

  final String difficulty;
  final VoidCallback notifyParent;

  int level = 0;
  late int _lives;

  int get lives => _lives;

  Future<void> evaluate(var value) async {
    // If check answer
    // Answer is correct then you would level+1 and next tile, delete old tile, but if not the game continues
    // Check if time remaining equals zero, if it is then lives -1, and reset time, and the player still answers
    notifyParent();
    if (_lives == 0) {
      visualMemoryGoRouter.go('/result?level=$level&difficulty=$difficulty&game_path=quick_maths'); //We will have to change this later
    }
  }

  void clearGame() {

  }

  void gameSetup() {
    //Should make about 20 of these in advance
    //Add them to new list
  }

  void generateEquation() {
    
  }

}

