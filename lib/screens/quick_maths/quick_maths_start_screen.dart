import 'package:flutter/material.dart';
import 'package:game_testing/theme/button_design.dart';

class QuickMathsStartScreen extends StatelessWidget {
  const QuickMathsStartScreen({super.key});

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
              'Quick Maths',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Solve simple math questions, but can you handle the time pressure?',
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
