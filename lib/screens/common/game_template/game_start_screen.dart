import 'package:flutter/material.dart';
import 'package:game_testing/theme/button_design.dart';
import 'package:game_testing/theme/responsive_config.dart';

import '../../../router.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';

class GameStartScreen extends StatefulWidget {
  final String name;
  final String description;
  final IconData icon;
  final RoutePath gamePath;
  final bool hasSurvivalMode; // Placeholder for future use
  const GameStartScreen({super.key, required this.name, required this.description, required this.icon, required this.gamePath, required this.hasSurvivalMode});

  @override
  State<GameStartScreen> createState() => _GameStartScreenState();
}

class _GameStartScreenState extends State<GameStartScreen> {
  Set<String> selected = {'standard'}; // Default selection for segmented button

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
            Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceDarkVariant,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                    color: AppColors.primaryDarkVariant, width: 2.0),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryDarkVariant.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              width: ResponsiveConfig.iconSize(context, size: IconSize.xxl)*1.75,
              height: ResponsiveConfig.iconSize(context, size: IconSize.xxl)*1.75,
              child: Center(
                child: Icon(
                  widget.icon,
                  size: ResponsiveConfig.iconSize(context, size: IconSize.xxl),
                  color: AppColors.primaryDarkVariant,
                ),
              ),
            ),
            SizedBox(height: ResponsiveConfig.spacing(context, size: SpacingSize.l),),
            Text(
              widget.name,
              style: AppTheme.titleTextStyle(context),
            ),
            Padding(
              padding: ResponsiveConfig.padding(context, size: PaddingSize.xxs),
              child: Text(
                widget.description,
                textAlign: TextAlign.center,
                style: AppTheme.descriptionTextStyle(context),
              ),
            ),
            if (widget.hasSurvivalMode) SegmentedButton(
                multiSelectionEnabled: false,
                segments: <ButtonSegment<String>>[
                  ButtonSegment(value: 'standard', label: Text('Standard'), icon: Icon(Icons.timer)),
                  ButtonSegment(value: 'survival', label: Text('Survival'), icon: Icon(Icons.lock_clock)),
                ],
              selected: selected,
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  print(newSelection);
                  selected = newSelection;
                  print("Check condition: ${selected.contains('survival')}");
                });
              },
            ),
            Padding(
              padding: ResponsiveConfig.padding(context, size: PaddingSize.m),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: ResponsiveConfig.spacing(context, size: SpacingSize.xs),
                children: [
                  Text(
                    'Select your difficulty',
                    style: AppTheme.cardTitleTextStyle(context),
                  ),
                  DifficultyButton(
                    label: 'Easy',
                    gamePath: widget.gamePath,
                    icon: Icons.sentiment_satisfied,
                    isSurvivalMode: selected.contains('survival'),
                  ),
                  SizedBox(height: ResponsiveConfig.spacing(context, size: SpacingSize.xxs),),
                  DifficultyButton(
                    label: 'Medium',
                    gamePath: widget.gamePath,
                    icon: Icons.sentiment_neutral,
                    isSurvivalMode: selected.contains('survival'),
                  ),
                  SizedBox(height: ResponsiveConfig.spacing(context, size: SpacingSize.xxs),),
                  DifficultyButton(
                    label: 'Hard',
                    gamePath: widget.gamePath,
                    icon: Icons.sentiment_dissatisfied,
                    isSurvivalMode: selected.contains('survival'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            // TextButton(
            //   onPressed: () {
            //     Placeholder();
            //   },
            //   child: Text(
            //     'View Leaderboard',
            //     style: TextStyle(
            //         color: AppColors.primaryDarkVariant, fontSize: 18.0),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
