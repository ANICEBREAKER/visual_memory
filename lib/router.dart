import 'package:flutter/material.dart';
import 'package:game_testing/screens/visual_memory/visual_memory_logic/level_state.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'screens/visual_memory/visual_memory_game_screen.dart';
import 'screens/visual_memory/visual_memory_result_screen.dart';
import 'screens/visual_memory/visual_memory_start_screen.dart';

final GoRouter visualMemoryGoRouter = GoRouter(
  routes: <RouteBase>[
GoRoute(
path: '/',
  builder: (BuildContext context, GoRouterState state) {
    return const VisualMemoryStartScreen();
  },
  routes: <RouteBase>[
    GoRoute(
      path: '/game',
      builder: (BuildContext context, GoRouterState state) {
        final difficulty = state.uri.queryParameters['difficulty'] ?? 'Easy';
        return ChangeNotifierProvider<VisualMemoryLevelState>(
          create: (_) =>
              VisualMemoryLevelState(
                difficulty: difficulty,
              ),
          child: VisualMemoryGameScreen(difficulty: difficulty),
        );
      },
    ),
    GoRoute(
      path: '/result',
      builder: (BuildContext context, GoRouterState state) {
        final level = int.tryParse(state.uri.queryParameters['level'] ?? '0') ?? 0;
        return VisualMemoryResultScreen(level: level, difficulty: state.uri.queryParameters['difficulty'].toString());
      },
    ),
  ],
)]);