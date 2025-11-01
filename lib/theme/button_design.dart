import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class DifficultyButton extends StatelessWidget {
  final String label;
  final difficulty_color;

  const DifficultyButton({
    required this.label,
    required this.difficulty_color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.go('/game?difficulty=$label');
      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: difficulty_color
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}

