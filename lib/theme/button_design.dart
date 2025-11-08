import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router.dart';
class DifficultyButton extends StatelessWidget {
  final String label;
  final difficulty_color;
  final RoutePath gamePath;

  const DifficultyButton({
    required this.label,
    required this.difficulty_color,
    required this.gamePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.go(gamePath.path + '?difficulty=$label');
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

