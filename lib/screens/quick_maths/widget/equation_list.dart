import 'package:flutter/material.dart';
import 'package:game_testing/screens/quick_maths/widget/equation_tiles.dart';

class EquationList extends StatelessWidget {
  final List<EquationTiles> equations;
  const EquationList({super.key, required this.equations});

  @override
  Widget build(BuildContext context) {
    if (equations.isEmpty) {
      return const Center(child: Text("No equations"));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: equations.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final eq = equations[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
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
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '${eq.firstNumber} ${eq.operator} ${eq.secondNumber} = ?',
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
      },
    );
  }
}
