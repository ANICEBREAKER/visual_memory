import 'package:flutter/material.dart';
import '../../router.dart';
import '../common/game_template/game_start_screen.dart';

class QuickMathsStartScreen extends StatelessWidget {
  const QuickMathsStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GameStartScreen(
      gameIndex: 1,
    );
  }
}
