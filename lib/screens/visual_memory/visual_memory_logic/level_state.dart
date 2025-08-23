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
}
