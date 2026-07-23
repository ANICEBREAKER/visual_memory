import 'package:flutter/material.dart';
import '../common/game_template/game_start_screen.dart';

class ColorShiftStartScreen extends StatelessWidget {
  const ColorShiftStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GameStartScreen(gameIndex: 2);
  }
}
