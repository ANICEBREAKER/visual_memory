import 'package:flutter/material.dart';
import 'package:game_testing/screens/menu_screen.dart';
import 'package:game_testing/screens/visual_memory/visual_memory_game_screen.dart';
import 'package:game_testing/screens/visual_memory/visual_memory_result_screen.dart';
import 'package:game_testing/screens/visual_memory/visual_memory_start_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        scaffoldBackgroundColor: Colors.blue,
        appBarTheme: AppBarTheme(color: Colors.blue),
        textTheme: TextTheme().copyWith(
          bodyLarge: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
          bodyMedium: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
          bodySmall: TextStyle(
              fontSize: 16,
              color: Colors.white
          ),
          labelSmall: TextStyle(
              fontSize: 16,
              //color: Colors.black
          ),
          labelMedium: TextStyle(
            fontSize: 20,
            //color: Colors.black,
            fontWeight: FontWeight.bold
          )
        ),
        useMaterial3: true,
      ),
      home: VisualMemoryStartScreen(),
    );
  }
}
