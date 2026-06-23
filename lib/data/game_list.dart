import 'package:flutter/material.dart';
import 'package:game_testing/screens/visual_memory/visual_memory_start_screen.dart';
import 'package:game_testing/screens/quick_maths/quick_maths_start_screen.dart';
import '../../theme/app_colors.dart';
import '../router.dart';

// The class for a game item
class GameTileItem {
  final String name;
  final String description;
  final IconData icon;
  final Widget destination;
  final Color? iconColor;
  final Color? displayColor;
  final RoutePath gamePath;
  final bool active;
  final List<GameMode> allGameModes;

  GameTileItem({
    required this.name,
    required this.description,
    required this.icon,
    this.destination = const Placeholder(), // Default destination
    required this.iconColor,
    required this.displayColor,
    this.gamePath = RoutePath.menu, // Default path
    required this.active,
    List<GameMode>? modes,
  }) : allGameModes = modes ??
            [
              GameMode(
                name: "Standard",
                icon: Icon(Icons.timer),
                description: "Standard mode",
              )
            ];
}

class GameMode {
  final String name;
  final Icon icon;
  final String description;

  GameMode({
    required this.name,
    required this.icon,
    required this.description,
  });
}

// Dummy list of games
List<GameTileItem> dummyGames = [
  // --- Games from your image ---
  GameTileItem(
      name: "Visual memory",
      description: "Memorize patterns on a grid of squares",
      icon: Icons.grid_view_rounded,
      destination: VisualMemoryStartScreen(),
      iconColor: AppColors.iconMemory,
      displayColor: AppColors.iconMemoryBg,
      gamePath: RoutePath.visualMemoryGameScreen,
      active: true),
  GameTileItem(
    name: "Quick maths",
    description: "Solve as many math equations quickly!",
    icon: Icons.calculate_rounded,
    // A calculator icon
    destination: QuickMathsStartScreen(),
    iconColor: AppColors.iconMath,
    displayColor: AppColors.iconMathBg,
    gamePath: RoutePath.quickMathsGameScreen,
    active: true,
    modes: [
      GameMode(
        name: "Standard",
        icon: Icon(Icons.timer),
        description: "The classic mode",
      ),
      GameMode(
        name: "Survival",
        icon: Icon(Icons.whatshot_rounded),
        description: "Keep going until time runs out!",
      ),
    ],
  ),
  GameTileItem(
      name: "Flashing tiles",
      description: "Remember the patterns of the tiles flashing",
      icon: Icons.bolt_rounded,
      // A grid icon
      iconColor: AppColors.iconTiles,
      displayColor: AppColors.iconTilesBg,
      active: false),
  GameTileItem(
      name: "Word Scramble",
      description: "Unscramble the letters to form a word",
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
