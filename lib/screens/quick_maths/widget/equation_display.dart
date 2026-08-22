import 'package:flutter/material.dart';
import 'package:game_testing/theme/responsive_config.dart';
import 'package:provider/provider.dart';
import '../quick_maths_logic/level_state.dart';
import 'equation_data.dart';


class MathEquationCard extends StatelessWidget {
  final EquationData eq; // The correct result of the equation
  final String operator;
  final String playerAnswer;
  final String askingPosition;
  final bool? isCorrect; // null = pending, true = correct, false = wrong

  MathEquationCard({
    super.key,
    required this.eq,
    required this.operator,
    required this.playerAnswer,
    required this.askingPosition,
    this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    // If parent didn't pass isCorrect explicitly, read it from provider so this widget updates reactively.
    final bool? effectiveIsCorrect =
        context.watch<QuickMathsLevelState>().isCorrect;

    Color answerColor;
    if (context.watch<QuickMathsLevelState>().isCorrect == null) {
      answerColor = Color(0xFF00E5FF); // pending / cyan
    } else if (context.watch<QuickMathsLevelState>().isCorrect == true) {
      answerColor = Color(0xFF76FF03); // correct (green)
    } else {
      answerColor = Color(0xFFFF1744); // wrong (red)
    }

    // Outer container border color: green when correct, red when wrong, default otherwise
    final Color outerBorderColor = effectiveIsCorrect == true
        ? answerColor
        : (effectiveIsCorrect == false ? Color(0xFFFF1744) : Color(0xFF2C3444));

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      // compact padding
      decoration: BoxDecoration(
        color: Color(0xFF121826).withOpacity(0.8), // surfaceDarkVariant
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: outerBorderColor,
          width: 2,
        ),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                flexibleEqPart(
                    answerColor: answerColor,
                    playerAnswer: playerAnswer,
                    askedPosition: askingPosition,
                    widgetPosition: "a",
                    eq: eq),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  // tighter spacing
                  child: Text(
                    operator == '*' ? '×' : operator,
                    style: TextStyle(
                      color: Color(0xFF00E5FF), // accent color
                      fontSize: 40, // reduced
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                  ),
                ),

                flexibleEqPart(
                    answerColor: answerColor,
                    playerAnswer: playerAnswer,
                    askedPosition: askingPosition,
                    widgetPosition: "b",
                    eq: eq),
              ],
            ),

            SizedBox(
              height: ResponsiveConfig.spacing(context, size: SpacingSize.m),
            ),

            // --- Divider ---
            Container(
              width: 48,
              height: 3,
              decoration: BoxDecoration(
                color: Color(0xFF2C3444),
                borderRadius: BorderRadius.circular(2),
              ),
            ),


            SizedBox(
              height: ResponsiveConfig.spacing(context, size: SpacingSize.m),
            ),

            // --- Player Answer Box ---
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  // tighter spacing
                  child: Text(
                    "=",
                    style: TextStyle(
                      color: Color(0xFF00E5FF), // accent color
                      fontSize: 40, // reduced
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                  ),
                ),
                flexibleEqPart(
                    answerColor: answerColor,
                    playerAnswer: playerAnswer,
                    askedPosition: askingPosition,
                    widgetPosition: "res",
                    eq: eq),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class flexibleEqPart extends StatelessWidget {
  const flexibleEqPart({
    super.key,
    required this.answerColor,
    required this.playerAnswer,
    required this.eq,
    required this.askedPosition,
    required this.widgetPosition,
  });

  final Color answerColor;
  final String playerAnswer;
  final String askedPosition;
  final EquationData eq;
  final String widgetPosition;

  @override
  Widget build(BuildContext context) {
    if (!(askedPosition == widgetPosition)) {
      return Text(
        widgetPosition == "a"
            ? eq.firstNumber.toString()
            : widgetPosition == "b"
                ? eq.secondNumber.toString()
                : eq.result.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 50, // reduced
          fontWeight: FontWeight.w900,
          letterSpacing: -1,
        ),
        maxLines: 1,
      );
    } else {
      return Container(
        padding: ResponsiveConfig.edgeInsetsSymmetric(context,
            horizontal: SpacingSize.l, vertical: SpacingSize.s),
        // reduced
        decoration: BoxDecoration(
          color: Color(0xFF05070C), // backgroundDarkDimmed
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: answerColor,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: answerColor,
              blurRadius: 16,
              spreadRadius: -4,
            ),
          ],
        ),
        child: Text(
          playerAnswer.isEmpty ? '?' : playerAnswer,
          style: TextStyle(
            color: playerAnswer.isEmpty ? Colors.white : answerColor,
            fontSize: 50, // reduced
            fontWeight: FontWeight.w900,
            // shadows: [
            //   if (effectiveIsCorrect != null)
            //     Shadow(
            //       color: answerColor,
            //       blurRadius: 12,
            //     ),
            // ],
          ),
          maxLines: 1,
        ),
      );
    }
  }
}
