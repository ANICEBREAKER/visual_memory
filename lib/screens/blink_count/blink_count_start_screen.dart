import 'package:flutter/material.dart';
import '../common/game_template/game_start_screen.dart';

class BlinkCountStartScreen extends StatelessWidget {
  const BlinkCountStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GameStartScreen(gameIndex: 3);
  }
}
