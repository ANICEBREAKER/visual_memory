import 'package:flutter/material.dart';
import 'package:game_testing/screens/common/game_template/game_result_screen.dart';
import 'package:game_testing/screens/common/login_screen.dart';
import 'package:game_testing/screens/common/registration_screen.dart';
import 'package:game_testing/screens/common/game_selection_screen.dart';
import 'package:game_testing/screens/common/settings_screen.dart';
import 'package:game_testing/screens/common/welcome_screen.dart';
import 'package:game_testing/screens/quick_maths/quick_maths_logic/level_state.dart';
import 'package:game_testing/screens/visual_memory/visual_memory_logic/level_state.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'screens/visual_memory/visual_memory_game_screen.dart';
import 'screens/visual_memory/visual_memory_start_screen.dart';
import 'screens/common/menu_screen.dart';
import 'screens/quick_maths/quick_maths_start_screen.dart';
import 'screens/quick_maths/quick_maths_game_screen.dart';

enum RoutePath {
  root(path: '/'),
  visualMemoryStartScreen(path: '/visualMemoryStartScreen'),
  visualMemoryGameScreen(path: '/visualMemoryGameScreen'),
  quickMathsStartScreen(path: '/quickMathsStartScreen'),
  quickMathsGameScreen(path: '/quickMathsGameScreen'),
  result(path: '/result'),
  login(path: '/login'),
  register(path: '/register'),
  settings(path: '/settings'),
  menu(path: '/menu'),
  gameSelection(path: '/gameSelection');

  final String path;

  const RoutePath({required this.path});

  //String get name => toString().split('.').last;
}

final GoRouter visualMemoryGoRouter = GoRouter(routes: <RouteBase>[
  GoRoute(
    path: RoutePath.root.path,
    builder: (BuildContext context, GoRouterState state) {
      return WelcomeScreen();
    },
    routes: <RouteBase>[

      //Visual Memory
      GoRoute(
          path: RoutePath.visualMemoryStartScreen.path,
          builder: (BuildContext context, GoRouterState state) =>
              VisualMemoryStartScreen()),
      GoRoute(
        path: RoutePath.visualMemoryGameScreen.path,
        builder: (BuildContext context, GoRouterState state) {
          final difficulty = state.uri.queryParameters['difficulty'] ?? 'Easy';
          return ChangeNotifierProvider<VisualMemoryLevelState>(
            create: (_) => VisualMemoryLevelState(
              difficulty: difficulty,
            ),
            child: VisualMemoryGameScreen(difficulty: difficulty),
          );
        },
      ),


      // Quick Maths
      GoRoute(
          path: RoutePath.quickMathsStartScreen.path,
          builder: (BuildContext context, GoRouterState state) =>
              QuickMathsStartScreen()),
      GoRoute(
          path: RoutePath.quickMathsGameScreen.path,
        builder: (BuildContext context, GoRouterState state) {
          final difficulty = state.uri.queryParameters['difficulty'] ?? 'Easy';
          final isSurvivalMode = state.uri.queryParameters['isSurvivalMode'] == "true"; // Default to false if not provided
          print("isSurvivalMode: $isSurvivalMode"); // Debug print to check the value
          return ChangeNotifierProvider<QuickMathsLevelState>(
            create: (_) => QuickMathsLevelState(
              difficulty: difficulty,
              isSurvivalMode: isSurvivalMode, //For now, this will be a variable once the segmentedButton is set up
            ),
            child: QuickMathsGameScreen(difficulty: difficulty),
          );
        },
      ),

      // Common Routes
      GoRoute(
        path: RoutePath.result.path,
        builder: (BuildContext context, GoRouterState state) {
          final level =
              int.tryParse(state.uri.queryParameters['level'] ?? '0') ?? 0;
          return GameResultScreen(
            level: level,
            difficulty: state.uri.queryParameters['difficulty'].toString(),
            game_path: state.uri.queryParameters['game_path'].toString(),
          );
        },
      ),
      GoRoute(
          path: RoutePath.login.path,
          builder: (BuildContext context, GoRouterState state) =>
              LoginScreen()),
      GoRoute(
          path: RoutePath.register.path,
          builder: (BuildContext context, GoRouterState state) =>
              RegistrationScreen()),
      GoRoute(
          path: RoutePath.settings.path,
          builder: (BuildContext context, GoRouterState state) =>
              SettingsScreen()),
      GoRoute(
          path: RoutePath.menu.path,
          builder: (BuildContext context, GoRouterState state) =>
              MenuScreen()),
      GoRoute(
          path: RoutePath.gameSelection.path,
          builder: (BuildContext context, GoRouterState state) =>
              TempGameScreen()),
    ],
  )
]);
