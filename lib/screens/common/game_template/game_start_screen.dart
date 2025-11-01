import 'package:flutter/material.dart';
import 'package:game_testing/theme/button_design.dart';

class GameStartScreen extends StatelessWidget {
  final String name;
  final String description;
  final String icon;
  const GameStartScreen({super.key, required this.name, required this.description, required this.icon});

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
            Image.network(icon, color: Colors.white,),
            Text(
              name,
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
            SizedBox(height: 20),
            Text(
              description,
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
