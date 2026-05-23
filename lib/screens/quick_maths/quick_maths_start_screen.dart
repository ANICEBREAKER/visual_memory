import 'package:flutter/material.dart';
import '../../router.dart';
import '../common/game_template/game_start_screen.dart';

class QuickMathsStartScreen extends StatelessWidget {
  const QuickMathsStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GameStartScreen(
      name: 'Quick Maths',
      description: ' Solve increasingly difficult equations under time pressure. Sharpen your mental math skills and challenge yourself to beat the clock!',
      icon: Icons.calculate_rounded,
      gamePath: RoutePath.quickMathsGameScreen,
    );
  }
}
