import 'package:flutter/material.dart';
import 'package:game_testing/screens/quick_maths/quick_maths_logic/level_state.dart';
import 'package:game_testing/screens/quick_maths/widget/equation_tile.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../../router.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../../theme/responsive_config.dart';
import '../quick_maths/widget/simple_numpad.dart';
import 'widget/equation_list.dart';

class QuickMathsGameScreen extends StatefulWidget {
  QuickMathsGameScreen({super.key, required this.difficulty});
  String difficulty = 'Easy';

  @override
  State<QuickMathsGameScreen> createState() => _QuickMathsGameScreenState();
}

class _QuickMathsGameScreenState extends State<QuickMathsGameScreen> {

  String playerAnswer = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<QuickMathsLevelState>(context, listen: false).gameSetup();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    // Responsive tile height for equations (will be clamped)
    double tileHeight = screenHeight * 0.09; // ~9% of height per tile
    if (tileHeight < 56) tileHeight = 56;
    if (tileHeight > 96) tileHeight = 96;

    final equations = context.watch<QuickMathsLevelState>().equations;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Provider.of<QuickMathsLevelState>(context, listen: false).stopTimer();
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
            SizedBox(height: screenHeight * 0.005),
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
                        Text('LIVES',
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
                              .watch<QuickMathsLevelState>()
                              .level
                              .toString()
                              .padLeft(2, '0'),
                          style: AppTheme.subtitleTextStyle(context),
                        ),
                        Row(children: [
                          Row(
                            children: [
                              LivesIcon(
                                livesNeeded: 3,
                              ),
                              LivesIcon(
                                livesNeeded: 2,
                              ),
                              LivesIcon(
                                livesNeeded: 1,
                              ),
                            ],
                          )
                        ]),
                      ],
                    ),
                  ],
                ),
              ),
            ), //Displaying Level & Lives
            SizedBox(height: screenHeight * 0.0025),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: StepProgressIndicator(
                        totalSteps: context.watch<QuickMathsLevelState>().totalSteps,
                        currentStep: context.watch<QuickMathsLevelState>().currentStep, // pulled from logic
                        size: 8,
                        padding: 0,
                        selectedColor: Colors.green,
                        unselectedColor: Colors.red,
                        roundedEdges: Radius.circular(10),
                      ),
                    ),
                  ],
                )
              ),
            ), //Displaying timer
            SizedBox(height: screenHeight * 0.005),
            // Equations area: fixed height to show at most 4 tiles (1 top + 3 follow-ups)
            // Expanded(
            //   flex: 6,
            //   //height: tileHeight * 4 + 16, // extra padding
            //   child: Container(
            //     color: Colors.grey[700],
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           // Top/current tile with fade-out + slide transition on change
            //           SizedBox(
            //             height: tileHeight,
            //             child: AnimatedSwitcher(
            //               duration: const Duration(milliseconds: 500),
            //               transitionBuilder: (child, animation) {
            //                 // Combined slide up for incoming, fade for outgoing
            //                 final inAnimation = Tween<Offset>(
            //                   begin: const Offset(0, 0.2),
            //                   end: Offset.zero,
            //                 ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));
            //                 return SlideTransition(position: inAnimation, child: FadeTransition(opacity: animation, child: child));
            //               },
            //               child: (equations.isNotEmpty)
            //                   ? SizedBox(
            //                       key: ValueKey(equations.first.hashCode),
            //                       height: tileHeight,
            //                       child: EquationTile(
            //                         eq: equations.first,
            //                         index: 0,
            //                         playerAnswer: playerAnswer,
            //                         verticalEmptySpace: 4,
            //                         horizontalEmptySpace: 6,
            //                         isMainEquation: true
            //                       ),
            //                     )
            //                   : SizedBox(
            //                       key: const ValueKey('empty_top'),
            //                       height: tileHeight,
            //                       child: const SizedBox.shrink(),
            //                     ),
            //             ),
            //           ),
            //           const SizedBox(height: 3),
            //           // Follow-up list (max 3) wrapped in AnimatedSwitcher so the block animates up when the top changes
            //           Expanded(
            //             child: AnimatedSwitcher(
            //               duration: const Duration(milliseconds: 350),
            //               transitionBuilder: (child, animation) {
            //                 final offset = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
            //                     .animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));
            //                 return SlideTransition(position: offset, child: FadeTransition(opacity: animation, child: child));
            //               },
            //               child: SizedBox(
            //                 key: ValueKey(equations.length), // rebuild when equations length changes
            //                 height: tileHeight * 3,
            //                 child: EquationList(
            //                   equations: equations,
            //                   tileHeight: tileHeight,
            //                   verticalSpacing: 6,
            //                   horizontalSpacing: 48,
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ],
            //       )
            //     ),
            //   ),
            // ), //Displaying equations
            Expanded(
              flex: 6,
              child: EquationList(
                equations: equations,
                tileHeight: tileHeight,
                verticalSpacing: 6,
                horizontalSpacing: 48,
                playerAnswer: playerAnswer,
                listKey: Provider.of<QuickMathsLevelState>(context, listen: false).listKey,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Expanded(
              flex: 6,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[600],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: SimpleNumpad(
                    buttonBorderRadius: 8,
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black.withAlpha(200),
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                    useBackspace: true,
                    optionText: 'Clear',
                    onPressed: (str) {
                      // handle special keys
                      setState(() {
                        if (str == 'Clear') {
                          playerAnswer = "";
                        } else if (str == 'BACKSPACE') {
                          if (playerAnswer.isNotEmpty) {
                            playerAnswer = playerAnswer.substring(0, playerAnswer.length - 1);
                          }
                          return;
                        } else {
                          playerAnswer += str;
                        }
                      });
                      // try parse and evaluate
                      final parsed = int.tryParse(playerAnswer);
                      if (parsed != null && context.read<QuickMathsLevelState>().equations.isNotEmpty && context.read<QuickMathsLevelState>().equations.first.result.toString().length == parsed.toString().length) {
                        context.read<QuickMathsLevelState>().evaluate(parsed);
                        playerAnswer = "";
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LivesIcon extends StatelessWidget {
  const LivesIcon({super.key, required this.livesNeeded});

  final int livesNeeded;

  @override
  Widget build(BuildContext context) {
    return Icon(
      context.watch<QuickMathsLevelState>().lives >= livesNeeded
          ? Icons.favorite
          : Icons.heart_broken_outlined,
      color: AppColors.iconLogic,
      size: ResponsiveConfig.iconSize(context, size: IconSize.l),
    );
  }
}
