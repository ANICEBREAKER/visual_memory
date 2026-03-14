import 'package:flutter/material.dart';
import 'package:game_testing/theme/button_design.dart';
import 'package:game_testing/theme/responsive_config.dart';

import '../../../router.dart';
import '../../../theme/app_colors.dart';

class GameStartScreen extends StatelessWidget {
  final String name;
  final String description;
  final String icon;
  final RoutePath gamePath;
  const GameStartScreen({super.key, required this.name, required this.description, required this.icon, required this.gamePath});

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
            SizedBox(height: ResponsiveConfig.spacing(context, size: SpacingSize.xs)),
            Padding(
              padding: ResponsiveConfig.padding(context, size: PaddingSize.l),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white
                ),
              ),
            ),
            SizedBox(height: ResponsiveConfig.spacing(context, size: SpacingSize.xxs)),
            Text(
              'Select your difficulty',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: ResponsiveConfig.padding(context, size: PaddingSize.m),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: ResponsiveConfig.spacing(context, size: SpacingSize.xs),
                children: [
                  DifficultyButton(
                    label: 'Easy',
                    gamePath: gamePath,
                    icon: Icons.sentiment_satisfied,
                  ),
                  SizedBox(width: 20),
                  DifficultyButton(
                    label: 'Medium',
                    gamePath: gamePath,
                    icon: Icons.sentiment_neutral,
                  ),
                  SizedBox(width: 20),
                  DifficultyButton(
                    label: 'Hard',
                    gamePath: gamePath,
                    icon: Icons.sentiment_dissatisfied,
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            TextButton(
              onPressed: () {
                Placeholder();
              },
              child: Text(
                'View Leaderboard',
                style: TextStyle(
                    color: AppColors.primaryDarkVariant, fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
