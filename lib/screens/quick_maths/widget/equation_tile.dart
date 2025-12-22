import 'package:flutter/material.dart';
import 'package:game_testing/screens/quick_maths/widget/equation_data.dart';

class EquationTile extends StatelessWidget {
  const EquationTile({
    super.key,
    required this.eq,
    required this.index,
    required this.playerAnswer,
    required this.verticalEmptySpace,
    required this.horizontalEmptySpace
  });
  final EquationData eq;
  final int index;
  final String playerAnswer;
  final double verticalEmptySpace;
  final double horizontalEmptySpace;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: verticalEmptySpace, horizontal: horizontalEmptySpace),
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.blueAccent,
              child: Text(
                '${index + 1}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(width: 12,),
            Expanded(
              child: Text(
                '${eq.firstNumber} ${eq.operator} ${eq.secondNumber} = ${playerAnswer}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

