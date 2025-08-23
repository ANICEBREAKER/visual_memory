import 'package:flutter/material.dart';
import 'package:game_testing/screens/visual_memory/visual_memory_start_screen.dart';

// The class for a game item
class GameTileItem {
  final String name;
  final String description;
  final String icon; // Link from online (SVG or PNG)
  final Widget destination;

  GameTileItem({
    required this.name,
    required this.description,
    required this.icon,
    this.destination = const Placeholder(), // Default destination
  });
}

// Dummy list of games
List<GameTileItem> dummyGames = [
  // --- Games from your image ---
  GameTileItem(
    name: "Visual memory",
    description: "Memorize patterns on a grid of squares",
    icon: "https://static.thenounproject.com/png/4411488-200.png", // A brain/memory icon
    destination: VisualMemoryStartScreen(),
  ),
  GameTileItem(
    name: "Flashing tiles",
    description: "Remember the patterns of the tiles flashing",
    icon: "https://static.thenounproject.com/png/4411488-200.png", // A grid icon
  ),
  GameTileItem(
    name: "Quick maths",
    description: "Solve as many math equations as fast as you can!",
    icon: "https://static.thenounproject.com/png/4411488-200.png", // A calculator icon
  ),

  GameTileItem(
    name: "Word Ladder",
    description: "Change one letter to form a new word",
    icon: "https://static.thenounproject.com/png/4411488-200.png", // A ladder icon
  ),
  GameTileItem(
    name: "Color Match",
    description: "Match the color to its name against the clock",
    icon: "https://static.thenounproject.com/png/4411488-200.png", // A color palette icon
  ),
];