import 'package:flutter/material.dart';

// Assuming AppColors is defined as we discussed
// class AppColors { ... }

class MathEquationCard extends StatelessWidget {
  final String firstNumber;
  final String secondNumber;
  final String operator;
  final String playerAnswer;
  final bool? isCorrect; // null = pending, true = correct, false = wrong

   MathEquationCard({
    super.key,
    required this.firstNumber,
    required this.secondNumber,
    required this.operator,
    required this.playerAnswer,
    this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the color of the player's answer based on the condition
    Color answerColor;
    if (isCorrect == null) {
      answerColor =  Color(0xFF00E5FF); // primaryDark / Cyan for pending
    } else if (isCorrect == true) {
      answerColor =  Color(0xFF76FF03); // correctAnswer (Pastel Green)
    } else {
      answerColor =  Color(0xFFFF1744); // wrongAnswer (Pastel Red)
    }

    // Outer container border color: green when correct, red when wrong, default otherwise
    final Color outerBorderColor = isCorrect == true
        ? answerColor.withOpacity(0.35)
        : (isCorrect == false ? Color(0xFFFF1744).withOpacity(0.5) : Color(0xFF2C3444));

    return Container(
      width: double.infinity,
      padding:  EdgeInsets.symmetric(vertical: 16, horizontal: 16), // compact padding
      decoration: BoxDecoration(
        color:  Color(0xFF121826).withOpacity(0.8), // surfaceDarkVariant
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: outerBorderColor,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Numbers row: use Flexible+FittedBox to scale down if needed
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  child: Text(
                    firstNumber,
                    style:  TextStyle(
                      color: Colors.white,
                      fontSize: 56, // reduced
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1,
                    ),
                    maxLines: 1,
                  ),
                ),
              ),

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 12), // tighter spacing
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    operator == '*' ? '×' : operator,
                    style:  TextStyle(
                      color: Color(0xFF00E5FF), // accent color
                      fontSize: 34, // reduced
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                  ),
                ),
              ),

              Flexible(
                fit: FlexFit.tight,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  child: Text(
                    secondNumber,
                    style:  TextStyle(
                      color: Colors.white,
                      fontSize: 56, // reduced
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1,
                    ),
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),

           SizedBox(height: 12), // reduced

          // --- Divider ---
          Container(
            width: 48,
            height: 3,
            decoration: BoxDecoration(
              color:  Color(0xFF2C3444),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

           SizedBox(height: 12), // reduced

          // --- Player Answer Box ---
          Container(
            padding:  EdgeInsets.symmetric(horizontal: 28, vertical: 12), // reduced
            decoration: BoxDecoration(
              color:  Color(0xFF05070C), // backgroundDarkDimmed
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: answerColor.withOpacity(0.3),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: answerColor.withOpacity(0.08),
                  blurRadius: 16,
                  spreadRadius: -4,
                ),
              ],
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                playerAnswer.isEmpty ? '?' : playerAnswer,
                style: TextStyle(
                  color: playerAnswer.isEmpty ? Colors.white.withOpacity(0.25) : answerColor,
                  fontSize: 48, // reduced
                  fontWeight: FontWeight.bold,
                  shadows: [
                    if (isCorrect != null)
                      Shadow(
                        color: answerColor.withOpacity(0.45),
                        blurRadius: 12,
                      ),
                  ],
                ),
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
