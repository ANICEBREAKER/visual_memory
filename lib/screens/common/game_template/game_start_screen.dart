import 'package:flutter/material.dart';
import 'package:game_testing/theme/button_design.dart';
import 'package:game_testing/theme/responsive_config.dart';
import 'package:go_router/go_router.dart';
import '../../../data/game_list.dart';
import '../../../router.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';

class GameStartScreen extends StatefulWidget {
  final int gameIndex;
  const GameStartScreen({super.key, required this.gameIndex});

  @override
  State<GameStartScreen> createState() => _GameStartScreenState();
}

class _GameStartScreenState extends State<GameStartScreen> {
  // Default selection: "Standard"
  Set<String> selected = {'Standard'};

  @override
  Widget build(BuildContext context) {
    final String chosenGameMode = selected.isNotEmpty ? selected.first : 'Standard';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.arrow_back, color: Colors.white,)),
        actions: [
          IconButton(onPressed: () {context.push('/leaderboard?index=${widget.gameIndex}');}, icon: Icon(Icons.leaderboard, color: Colors.white,)),
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
              width: ResponsiveConfig.iconSize(context, size: IconSize.xxl)*1.5,
              height: ResponsiveConfig.iconSize(context, size: IconSize.xxl)*1.5,
              child: Center(
                child: Icon(
                  dummyGames[widget.gameIndex].icon,
                  size: ResponsiveConfig.iconSize(context, size: IconSize.xxl),
                  color: AppColors.primaryDarkVariant,
                ),
              ),
            ),
            SizedBox(height: ResponsiveConfig.spacing(context, size: SpacingSize.l),),
            Text(
              dummyGames[widget.gameIndex].name,
              style: AppTheme.titleTextStyle(context),
            ),
            Padding(
              padding: ResponsiveConfig.padding(context, size: PaddingSize.xxs),
              child: Text(
                dummyGames[widget.gameIndex].description,
                textAlign: TextAlign.center,
                style: AppTheme.descriptionTextStyle(context),
              ),
            ),

            // Build SegmentedButton from provided modes (if any)
            if (dummyGames[widget.gameIndex].allGameModes.isNotEmpty)
              Padding(
                padding: ResponsiveConfig.padding(context, size: PaddingSize.xs),
                child: SegmentedButton<String>(
                  multiSelectionEnabled: false,
                  segments: dummyGames[widget.gameIndex].allGameModes!.map((mode) {
                    return ButtonSegment<String>(
                      value: mode.name,
                      label: Text(mode.name),
                      icon: mode.icon,
                    );
                  }).toList(),
                  selected: selected,
                  onSelectionChanged: (Set<String> newSelection) {
                    setState(() {
                      selected = newSelection;
                    });
                  },
                ),
              ),

            Padding(
              padding: ResponsiveConfig.padding(context, size: PaddingSize.m),
              child: Column(
                children: [
                  Text(
                    'Select your difficulty',
                    style: AppTheme.cardTitleTextStyle(context),
                  ),
                  DifficultyButton(
                    label: 'Easy',
                    gamePath: dummyGames[widget.gameIndex].gamePath,
                    icon: Icons.sentiment_satisfied,
                    chosenGameMode: chosenGameMode,
                  ),
                  SizedBox(height: ResponsiveConfig.spacing(context, size: SpacingSize.xxs)),
                  DifficultyButton(
                    label: 'Medium',
                    gamePath: dummyGames[widget.gameIndex].gamePath,
                    icon: Icons.sentiment_neutral,
                    chosenGameMode: chosenGameMode,
                  ),
                  SizedBox(height: ResponsiveConfig.spacing(context, size: SpacingSize.xxs)),
                  DifficultyButton(
                    label: 'Hard',
                    gamePath: dummyGames[widget.gameIndex].gamePath,
                    icon: Icons.sentiment_dissatisfied,
                    chosenGameMode: chosenGameMode,
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
