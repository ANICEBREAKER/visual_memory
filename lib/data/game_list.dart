import 'package:flutter/material.dart';
import 'package:game_testing/screens/visual_memory/visual_memory_start_screen.dart';
import 'package:game_testing/screens/quick_maths/quick_maths_start_screen.dart';
import '../../theme/app_colors.dart';

// The class for a game item
class GameTileItem {
  final String name;
  final String description;
  final IconData icon;
  final Widget destination;
  final Color? iconColor;
  final Color? displayColor;
  final bool active;
  //final List<String> gameModes;
  final bool hasSurvivalMode; // Placeholder for future use

  GameTileItem({
    required this.name,
    required this.description,
    required this.icon,
    this.destination = const Placeholder(), // Default destination
    required this.iconColor,
    required this.displayColor,
    required this.active,
    //required this.gameModes,
    this.hasSurvivalMode = false,
  });
}

// Dummy list of games
List<GameTileItem> dummyGames = [
  // --- Games from your image ---
  GameTileItem(
      name: "Visual memory",
      description: "Memorize patterns on a grid of squares",
      icon: Icons.grid_view_rounded,
      // A brain/memory icon
      destination: VisualMemoryStartScreen(),
      iconColor: AppColors.iconMemory,
      displayColor: AppColors.iconMemoryBg,
    active: true
  ),
  GameTileItem(
      name: "Quick maths",
      description: "Solve as many math equations quickly!",
      icon: Icons.calculate_rounded,
      // A calculator icon
      destination: QuickMathsStartScreen(),
      iconColor: AppColors.iconMath,
      displayColor: AppColors.iconMathBg,
      active: true,
      hasSurvivalMode: true,
  ),
  GameTileItem(
      name: "Flashing tiles",
      description: "Remember the patterns of the tiles flashing",
      icon: Icons.bolt_rounded,
      // A grid icon
      iconColor: AppColors.iconTiles,
      displayColor: AppColors.iconTilesBg,
    active: false
  ),
  GameTileItem(
      name: "Word Ladder",
      description: "Change one letter to form a new word",
      icon: Icons.sort_by_alpha_rounded,
      // A ladder icon
      iconColor: AppColors.iconWord,
      displayColor: AppColors.iconWordBg,
      active: false),
  GameTileItem(
      name: "Color Match",
      description: "Match the color to its name against the clock",
      icon: Icons.palette_rounded,
      // A color palette icon
      iconColor: AppColors.iconColor,
      displayColor: AppColors.iconColorBg,
      active: false),
  GameTileItem(
      name: "Logic Flow",
      description: "Be quick! Match the dots in the grid!",
      icon: Icons.psychology_rounded,
      // A color palette icon
      iconColor: AppColors.iconLogic,
      displayColor: AppColors.iconLogicBg,
      active: false),
];

