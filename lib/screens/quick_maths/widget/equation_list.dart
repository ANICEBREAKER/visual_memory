import 'package:flutter/material.dart';
import 'package:game_testing/screens/quick_maths/widget/equation_data.dart';
import 'package:game_testing/screens/quick_maths/widget/equation_tile.dart';

class EquationList extends StatelessWidget {
  final List<EquationData> equations;
  const EquationList({super.key, required this.equations});

  @override
  Widget build(BuildContext context) {
    if (equations.isEmpty) {
      return const Center(child: Text("No equations"));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      shrinkWrap: true,
      itemCount: equations.length - 1,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final eq = equations[index + 1];
        return EquationTile(eq: eq, index: index + 1, playerAnswer: "?", verticalEmptySpace: 9, horizontalEmptySpace: 12,);
      },
    );
  }
}
