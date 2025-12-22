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
            Text(
              '${index + 1}.',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(width: 12,),
            Container(
              height: 35,
              width: 35,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.blueAccent, width: 2),
              ),
              child: Text(
                '${eq.firstNumber}',
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            SizedBox(width: 6,),
            Text(
              '${eq.operator}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(width: 6,),
            Container(
              height: 35,
              width: 35,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.blueAccent, width: 2),
              ),
              child: Text(
                '${eq.secondNumber}',
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            SizedBox(width: 6,),
            Text(
              "=",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(width: 6,),
            Container(
              height: 35,
              width: 35,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.blueAccent, width: 2),
              ),
              child: Text(
                '${playerAnswer}',
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            // Expanded(
            //   child: Text(
            //     '${eq.firstNumber} ${eq.operator} ${eq.secondNumber} = ${playerAnswer}',
            //     style: const TextStyle(
            //       fontSize: 18,
            //       fontWeight: FontWeight.w600,
            //       color: Colors.black87,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

