import 'package:flutter/material.dart';
import 'package:game_testing/screens/quick_maths/quick_maths_logic/level_state.dart';
import 'package:game_testing/screens/quick_maths/widget/equation_tile.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../../router.dart';
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
            SizedBox(height: screenHeight * 0.005),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text("Levels: ${context.watch<QuickMathsLevelState>().level}",
                        style: Theme.of(context).textTheme.labelSmall),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                        "Lives: ${'🖤' * context.watch<QuickMathsLevelState>().lives}${'🤍' * (3 - context.watch<QuickMathsLevelState>().lives)}"),
                  ),
                ],
              ),
            ), // Displaying levels and lives
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
            Expanded(
              flex: 10,
              child: Container(
                color: Colors.grey[700],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      EquationTile(eq: context.watch<QuickMathsLevelState>().equations.first, index: 0, playerAnswer: playerAnswer, verticalEmptySpace: 6, horizontalEmptySpace: 8,),
                      Expanded(child: EquationList(equations: context.watch<QuickMathsLevelState>().equations)),
                    ],
                  )
                ),
              ),
            ), //Displaying equations
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
                  padding: EdgeInsets.all(8),
                  child: SimpleNumpad(
                    buttonWidth: 40,
                    buttonHeight: screenHeight * 0.022, // TODO: Make responsive height for buttons
                    gridSpacing: 5,
                    buttonBorderRadius: 5,
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
                          if (playerAnswer.length == 1) {
                            playerAnswer = "";
                          } else {
                            playerAnswer.substring(0, playerAnswer.length - 1);
                          }
                          return;
                        } else {
                          playerAnswer += str;
                        }
                      });
                      // try parse and evaluate
                      final parsed = int.tryParse(playerAnswer);
                      if (parsed != null && context.read<QuickMathsLevelState>().equations.first.result.toString().length == parsed.toString().length) {
                        context.read<QuickMathsLevelState>().evaluate(parsed);
                        playerAnswer = "";
                      }
                    },
                  ),
                ),
            )
            ) //At the bottom of the screen showing numpad
          ],
        ),
      ),
    );
  }
}
