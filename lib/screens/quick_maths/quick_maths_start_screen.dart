import 'package:flutter/material.dart';
import '../../router.dart';
import '../common/game_template/game_start_screen.dart';

class QuickMathsStartScreen extends StatelessWidget {
  const QuickMathsStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GameStartScreen(
      name: 'Quick Maths',
      description: ' Solve simple math questions, as easy as that, but can you handle the time pressure?',
      icon: 'https://static.thenounproject.com/png/4411488-200.png',
      gamePath: RoutePath.quickMathsGameScreen,
    );
  }
}
