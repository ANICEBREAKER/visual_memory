import 'package:flutter/material.dart';
import 'package:game_testing/screens/visual_memory/visual_memory_game_screen.dart';
import 'package:game_testing/screens/visual_memory/visual_memory_logic/level_state.dart';
import 'package:game_testing/screens/visual_memory/visual_memory_result_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class VisualMemoryStartScreen extends StatelessWidget {
  const VisualMemoryStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.arrow_back, color: Colors.white,)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.settings, color: Colors.white,))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network('https://static.thenounproject.com/png/4411488-200.png', color: Colors.white,),
            Text(
              'Visual memory',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
            SizedBox(height: 20),
            Text(
              'A pattern will be shown on the square grid for few moments Replicate the pattern by clicking on the squares',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                  color: Colors.white
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Select your difficulty',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DifficultyButton(
                  label: 'Easy',
                  difficulty_color: Colors.greenAccent,
                ),
                SizedBox(width: 20),
                DifficultyButton(
                  label: 'Medium',
                  difficulty_color: Colors.yellowAccent,
                ),
                SizedBox(width: 20),
                DifficultyButton(
                  label: 'Hard',
                  difficulty_color: Colors.redAccent,
                ),
              ],
            ),
            SizedBox(height: 15),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                backgroundColor: Colors.white,
              ),
              child: Text(
                'View leaderboard',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DifficultyButton extends StatelessWidget {
  final String label;
  final difficulty_color;

  const DifficultyButton({
    required this.label,
    required this.difficulty_color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.go('/game?difficulty=$label');
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: difficulty_color
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}

