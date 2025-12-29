import 'package:flutter/material.dart';
import 'package:game_testing/screens/quick_maths/widget/equation_data.dart';

class EquationTile extends StatelessWidget {
  const EquationTile({
    super.key,
    required this.eq,
    required this.index,
    required this.playerAnswer,
    required this.verticalEmptySpace,
    required this.horizontalEmptySpace,
    required this.isMainEquation,
  });
  final EquationData eq;
  final int index;
  final String playerAnswer;
  final double verticalEmptySpace;
  final double horizontalEmptySpace;
  final bool isMainEquation;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: verticalEmptySpace, horizontal: horizontalEmptySpace),
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(
            //   '${index + 1}.',
            //   style: const TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.w600,
            //     color: Colors.black87,
            //   ),
            // ),
            //SizedBox(width: 12,),
            Container(
              height: isMainEquation ? 70 : 50,
              width: isMainEquation ? 70 : 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.blueAccent, width: 2),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '${eq.firstNumber}',
                  style: TextStyle(color: Colors.black, fontSize: isMainEquation ? 30 : 20),
                ),
              ),
            ),
            SizedBox(width: 6,),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                eq.operator,
                style: TextStyle(
                  fontSize: isMainEquation ? 30 : 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(width: 6,),
            Container(
              height: isMainEquation ? 70 : 50,
              width: isMainEquation ? 70 : 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.blueAccent, width: 2),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '${eq.secondNumber}',
                  style: TextStyle(color: Colors.black, fontSize: isMainEquation ? 30 : 20),
                ),
              ),
            ),
            SizedBox(width: 6,),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "=",
                style: TextStyle(
                  fontSize: isMainEquation ? 30 : 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(width: 6,),
            Container(
              height: isMainEquation ? 70 : 50,
              width: isMainEquation ? 70 : 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.blueAccent, width: 2),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  playerAnswer,
                  style: TextStyle(color: Colors.black, fontSize: isMainEquation ? 30 : 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
