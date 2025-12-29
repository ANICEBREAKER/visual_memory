import 'dart:math';
import 'package:flutter/material.dart';
import 'package:game_testing/screens/quick_maths/widget/equation_data.dart';
import 'package:game_testing/screens/quick_maths/widget/equation_tile.dart';

class EquationList extends StatelessWidget {
  final List<EquationData> equations;
  final double tileHeight;
  final double verticalSpacing;
  final double horizontalSpacing;

  const EquationList({
    super.key,
    required this.equations,
    required this.tileHeight,
    this.verticalSpacing = 8,
    this.horizontalSpacing = 12,
  });

  @override
  Widget build(BuildContext context) {
    if (equations.isEmpty) {
      return const Center(child: Text("No equations"));
    }

    // Show only up to 3 follow-up tiles (top tile is shown separately)
    final followUpCount = max(0, equations.length - 1);
    final visibleCount = min(3, followUpCount);

    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: verticalSpacing),
      shrinkWrap: true,
      itemCount: visibleCount,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final eq = equations[index + 1];
        // Wrap each tile in a fixed-height box so the overall layout is stable
        return SizedBox(
          height: tileHeight,
          child: EquationTile(
            eq: eq,
            index: index + 1,
            playerAnswer: "?",
            verticalEmptySpace: verticalSpacing / 2,
            horizontalEmptySpace: horizontalSpacing / 2,
            isMainEquation: false,
          ),
        );
      },
    );
  }
}
