import 'package:flutter/material.dart';
import 'package:game_testing/screens/visual_memory/visual_memory_logic/level_state.dart';
import 'package:game_testing/player_progress/player_progress.dart';
import 'package:game_testing/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../router.dart';
import '../../theme/app_colors.dart';
import '../../theme/responsive_config.dart';

class VisualMemoryGameScreen extends StatefulWidget {
  const VisualMemoryGameScreen({super.key, required this.difficulty});
  final String difficulty;

  @override
  State<VisualMemoryGameScreen> createState() => _VisualMemoryGameScreenState();
}

class _VisualMemoryGameScreenState extends State<VisualMemoryGameScreen> {
  int levels = 1;
  int lives = 0;

  @override
  void initState() {
    super.initState();
    lives = widget.difficulty == "Easy"
        ? 3
        : widget.difficulty == "Medium"
            ? 2
            : 1;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VisualMemoryLevelState>(context, listen: false).gameSetup();
    });
  }



  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    // Responsive paddings and spacings
    final horizontalPadding = screenWidth * 0.07; // 7% of width
    final gridSpacing = screenWidth * 0.010; // ~2% of width
    final gridPadding = screenHeight * 0.015; // ~1.5% of height

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.go(RoutePath.menu.path);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02), // 2% of width
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: ResponsiveConfig.padding(context, size: PaddingSize.m),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                decoration: BoxDecoration(
                  color: AppColors.surfaceDarkVariant,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.borderDark),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'LEVEL',
                          style: AppTheme.descriptionTextStyle(context),
                        ),
                        Text(
                            'LIVES',
                            style: AppTheme.descriptionTextStyle(context)
                        ),
                      ],
                    ),
                    SizedBox(height: ResponsiveConfig.spacing(context, size: SpacingSize.xxs),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          context.watch<VisualMemoryLevelState>().level.toString().padLeft(2, '0'),
                          style: AppTheme.subtitleTextStyle(context),
                        ),
                        Row(
                            children: [
                              Row(
                                children: [
                                  LivesIcon(livesNeeded: 3,),
                                  LivesIcon(livesNeeded: 2,),
                                  LivesIcon(livesNeeded: 1,),
                                ],
                              )
                            ]
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.01),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {

                  int crossAxisCount = context.watch<VisualMemoryLevelState>().gridSize;
                  int itemCount = crossAxisCount * crossAxisCount;
                  int rowCount = crossAxisCount;

                  // Calculate available width and height for the grid
                  double availableWidth = constraints.maxWidth - 2 * horizontalPadding;
                  double availableHeight = constraints.maxHeight - 2 * gridPadding;

                  // Calculate the maximum square size that fits both width and height
                  double maxSquareWidth = (availableWidth - (crossAxisCount - 1) * gridSpacing) / crossAxisCount;
                  double maxSquareHeight = (availableHeight - (rowCount - 1) * gridSpacing) / rowCount;
                  double squareSize = maxSquareWidth < maxSquareHeight ? maxSquareWidth : maxSquareHeight;

                  // Calculate the grid's total width and height to fit all squares
                  double gridWidth = squareSize * crossAxisCount + (crossAxisCount - 1) * gridSpacing;
                  double gridHeight = squareSize * rowCount + (rowCount - 1) * gridSpacing;

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: gridPadding,
                    ),
                    child: Center(
                      child: SizedBox(
                        width: gridWidth,
                        height: gridHeight,
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                          child: SizedBox(
                          child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: gridSpacing,
                              mainAxisSpacing: gridSpacing,
                              childAspectRatio: 1,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return Consumer<VisualMemoryLevelState>(
                                builder: (context, levelState, child) {
                                  return InkWell(
                                    onTap: () {
                                      if (levelState.isShowingTiles) return;
                                      levelState.evaluate(index);
                                    },
                                    customBorder: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(squareSize * 0.2),
                                    ),
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(squareSize * 0.2),
                                        color: levelState.isShowingTiles
                                            ? (levelState.indexOfHighlightedTiles.contains(index)
                                                ? AppColors.correctAnswer
                                                : Colors.grey[300])
                                        : (levelState.tileStatus[index] == null
                                            ? Colors.grey[300]
                                            : levelState.tileStatus[index] == 1
                                                ? AppColors.correctAnswer
                                                : AppColors.wrongAnswer)
                                      ),
                                      child: Center(
                                        // child: Text(
                                        //   'Item $index',
                                        //   style: TextStyle(
                                        //     fontSize: squareSize * 0.25,
                                        //     color: Colors.black,
                                        //   ),
                                        // ), Only used for debug purposes, or cheating
                                      ),
                                    ),
                                  );
                                }
                              );
                            },
                            itemCount: itemCount,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                          ),
                                                    ),
                      ),
                    ),
                  )
                  );
                },
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            ElevatedButton(
              onPressed: () {
                final level = context.read<VisualMemoryLevelState>().level;
                context.push('/result?game_path=visual_memory&level=$level&difficulty=${widget.difficulty}');
              },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: screenHeight * 0.015),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.015)),
                  backgroundColor: Colors.orangeAccent),
              child: Text(
                'Quit',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LivesIcon extends StatelessWidget {
  const LivesIcon({
    super.key,
    required this.livesNeeded
  });

  final int livesNeeded;

  @override
  Widget build(BuildContext context) {
    return Icon(
      context.watch<VisualMemoryLevelState>().lives >= livesNeeded ? Icons.favorite : Icons.heart_broken_outlined,
      color: AppColors.iconLogic,
      size: ResponsiveConfig.iconSize(context, size: IconSize.l),
    );
  }
}