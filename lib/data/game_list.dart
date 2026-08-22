import 'package:flutter/material.dart';
import 'package:game_testing/screens/color_shift/color_shift_start_screen.dart';
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

enum GameName {
  visual_memory("Visual memory"),
  quick_maths("Quick maths"),
  blink_count("Blink Count"),
  color_shift("Color Shift"),
  word_scramble("Word Scramble"),
  logic_flow("Logic Flow");

  final String displayName;
  const GameName(this.displayName);
}

// Dummy list of games
List<GameTileItem> dummyGames = [
  // --- Games from your image ---
  GameTileItem(
      name: GameName.visual_memory.displayName,
      description: "Memorize patterns on a square grid",
      icon: Icons.grid_view_rounded,
      destination: VisualMemoryStartScreen(),
      iconColor: AppColors.iconMemory,
      displayColor: AppColors.iconMemoryBg,
      gamePath: RoutePath.visualMemoryGameScreen,
      active: true,
    modes: [
      GameMode(
        name: "Standard",
        icon: Icon(Icons.grid_view_rounded),
        description: "The classic mode",
      ),
      GameMode(
        name: "Inverted",
        icon: Icon(Icons.grid_view_outlined),
        description: "Click on the tiles that DID NOT light up.",
      )
    ]
  ),
  GameTileItem(
    name: GameName.quick_maths.displayName,
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
      name: GameName.color_shift.displayName,
      description: "See the Color. Do not let your eyes trick your mind.",
      icon: Icons.format_color_text_rounded,
      iconColor: AppColors.iconColor,
      displayColor: AppColors.iconColorBg,
      gamePath: RoutePath.colorShiftGameScreen,
      destination: ColorShiftStartScreen(),
      active: true,
    modes: [
      GameMode(
        name: "Standard",
        icon: Icon(Icons.whatshot_rounded),
        description: "Keep going until time runs out, only the color of the text matters",
      ),
      GameMode(
        name: "Rule Flip",
        icon: Icon(Icons.published_with_changes_outlined),
        description: "Keep going until time runs out!",
      ),
      GameMode(
        name: "Vocal",
        icon: Icon(Icons.mic_rounded),
        description: "Read the color. Speak it out.",
      ),
    ]
  ),

  //Non active games
  GameTileItem(
      name: GameName.blink_count.displayName,
      description: "Count the number of circles in the container",
      icon: Icons.bubble_chart,
      iconColor: AppColors.iconBlink,
      displayColor: AppColors.iconBlinkBg,
      active: true),
  GameTileItem(
      name: GameName.word_scramble.displayName,
      description: "Unscramble the letters to form a word",
      icon: Icons.sort_by_alpha_rounded,
      // A ladder icon
      iconColor: AppColors.iconWord,
      displayColor: AppColors.iconWordBg,
      active: false),
  GameTileItem(
      name: GameName.logic_flow.displayName,
      description: "Be quick! Match the dots in the grid!",
      icon: Icons.psychology_rounded,
      // A color palette icon
      iconColor: AppColors.iconLogic,
      displayColor: AppColors.iconLogicBg,
      active: false),
];
