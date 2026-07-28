import 'package:flutter/material.dart';
import 'package:game_testing/router.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../../theme/responsive_config.dart';
import '../quick_maths/quick_maths_game_screen.dart';
import 'color_shift_logic/level_state.dart';

class ColorShiftGameScreen extends StatefulWidget {
  const ColorShiftGameScreen({super.key});

  @override
  State<ColorShiftGameScreen> createState() => _ColorShiftGameScreenState();
}

class _ColorShiftGameScreenState extends State<ColorShiftGameScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ColorShiftLevelState>(context, listen: false).gameSetup();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.read<ColorShiftLevelState>().stopTimer();
            context.go(RoutePath.menu.path); // TODO: Change this sometime
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: ResponsiveConfig.padding(context, size: PaddingSize.s),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: ResponsiveConfig.edgeInsetsSymmetric(
                context,
                horizontal: SpacingSize.none,
                vertical: SpacingSize.s,
              ),
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
                        Text('',
                            style: AppTheme.descriptionTextStyle(context)),
                      ],
                    ),
                    SizedBox(
                      height: ResponsiveConfig.spacing(context,
                          size: SpacingSize.xxs),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          context
                              .watch<ColorShiftLevelState>()
                              .level
                              .toString()
                              .padLeft(2, '0'),
                          style: AppTheme.subtitleTextStyle(context),
                        ),
                        Row(),
                      ],
                    ),
                  ],
                ),
              ),
            ), //Displaying Level & Lives
            SizedBox(
              height: ResponsiveConfig.spacing(context, size: SpacingSize.s),
            ),
            //Timer
            Padding(
              padding: ResponsiveConfig.edgeInsetsSymmetric(
                context,
                horizontal: SpacingSize.none,
                vertical: SpacingSize.s,
              ),
              child: ProgressBarCountdown( //May need to move the time to a widget file
                total: context
                    .watch<ColorShiftLevelState>()
                    .totalSeconds
                    .toDouble(),
                remaining:
                    context.watch<ColorShiftLevelState>().timeRemaining,
                backgroundColor: AppColors.surfaceDarkVariant,
                color: AppColors.primaryDarkVariant,
                height: 8,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Padding(
              padding: ResponsiveConfig.edgeInsetsSymmetric(
                context,
                horizontal: SpacingSize.none,
                vertical: SpacingSize.s,
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                decoration: BoxDecoration(
                  color: AppColors.surfaceDarkVariant,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.borderDark),
                ),
                child: Center(
                  child: Text(
                    context.watch<ColorShiftLevelState>().displayedText.toUpperCase(),
                    style: TextStyle(
                      fontSize: ResponsiveConfig.textSize(context, size: TextSize.fourxl), // 100
                      fontWeight: FontWeight.w900,
                      color: context.watch<ColorShiftLevelState>().getTextColor(), // Use mapped color
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: ResponsiveConfig.spacing(context, size: SpacingSize.s),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 3 columns
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1, // Square cells
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  final colorName = context.watch<ColorShiftLevelState>().colorList[index];
                  return Visibility(
                    visible: index < context.watch<ColorShiftLevelState>().colorsInPlay,
                    child: InkWell(
                      onTap: () {
                        context.read<ColorShiftLevelState>().evaluate(colorName);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.surfaceDarkVariant,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.borderDark
                          ),
                        ),
                        child: Center(
                          child: Text(
                            colorName.toUpperCase(),
                            style: TextStyle(
                              fontSize: ResponsiveConfig.textSize(context, size: TextSize.l),
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryDarkVariant,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
