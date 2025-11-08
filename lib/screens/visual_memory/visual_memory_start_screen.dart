import 'package:flutter/material.dart';
import '../../router.dart';
import '../common/game_template/game_start_screen.dart';

class VisualMemoryStartScreen extends StatelessWidget {
  const VisualMemoryStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GameStartScreen(
      name: 'Visual Memory',
      description: 'A pattern will be shown on the square grid for few moments Replicate the pattern by clicking on the squares',
      icon: 'https://static.thenounproject.com/png/4411488-200.png',
      gamePath: RoutePath.visualMemoryGameScreen,
    );
  }
}
