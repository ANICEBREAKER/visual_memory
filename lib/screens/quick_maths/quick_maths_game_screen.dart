import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../../router.dart';
import '../quick_maths/widget/simple_numpad.dart';

class QuickMathsGameScreen extends StatefulWidget {
  const QuickMathsGameScreen({super.key});

  @override
  State<QuickMathsGameScreen> createState() => _QuickMathsGameScreenState();
}

class _QuickMathsGameScreenState extends State<QuickMathsGameScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    // // Responsive paddings and spacings
    // final horizontalPadding = screenWidth * 0.07; // 7% of width
    // final gridSpacing = screenWidth * 0.010; // ~2% of width
    // final gridPadding = screenHeight * 0.015; // ~1.5% of height
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
                    child: Text("Levels: ",
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
                    child: Text("Lives: 🖤🖤🖤")
                    // Text(
                    //     context.watch<VisualMemoryLevelState>().lives == 3
                    //         ? "Lives: 🖤🖤🖤"
                    //         : context.watch<VisualMemoryLevelState>().lives == 2
                    //         ? "Lives: 🖤🖤🤍"
                    //         : context.watch<VisualMemoryLevelState>().lives == 1
                    //         ? "Lives: 🖤🤍🤍"
                    //         : "Lives: 🤍🤍🤍",
                    //     style: Theme.of(context).textTheme.labelSmall
                    // ),
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
                    Center(
                      child: StepProgressIndicator(
                        totalSteps: 100,
                        currentStep: 32, //Import variables from quick maths logic
                        size: 8,
                        fallbackLength: screenWidth*0.91,
                        padding: 0,
                        selectedColor: Colors.red,
                        unselectedColor: Colors.green,
                        roundedEdges: Radius.circular(10),
                      )
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
                      print(str);
                      //Insert logic/function to handle numpad input
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
