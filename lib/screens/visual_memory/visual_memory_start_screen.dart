import 'package:flutter/material.dart';
import 'package:game_testing/data/game_list.dart';
import '../../router.dart';
import '../common/game_template/game_start_screen.dart';

class VisualMemoryStartScreen extends StatelessWidget {
  const VisualMemoryStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GameStartScreen(
      gameIndex: 0,
    );
  }
}
