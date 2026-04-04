import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:game_testing/player_progress/player_progress.dart';
import 'package:game_testing/router.dart';
import 'package:game_testing/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://ypqciufahmsfdyuqhthx.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlwcWNpdWZhaG1zZmR5dXFodGh4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjAxNjY3NTQsImV4cCI6MjA3NTc0Mjc1NH0.21rND-lcELGmzWbQ8FLBbzG85w419s2P2zgaPQmS5s8',
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => PlayerProgress()),
    ],
    child: DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: AppTheme.light(context),
      darkTheme: AppTheme.dark(context),
      themeMode: ThemeMode.dark,
      routerConfig: visualMemoryGoRouter,
      //useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      //   scaffoldBackgroundColor: Colors.blue,
      //   appBarTheme: AppBarTheme(color: Colors.blue),
      //   textTheme: TextTheme().copyWith(
      //     bodyLarge: TextStyle(
      //         fontSize: 40,
      //         fontWeight: FontWeight.bold,
      //         color: Colors.white
      //     ),
      //     bodyMedium: TextStyle(
      //         fontSize: 30,
      //         fontWeight: FontWeight.bold,
      //         color: Colors.white
      //     ),
      //     bodySmall: TextStyle(
      //         fontSize: 16,
      //         color: Colors.white
      //     ),
      //     labelSmall: TextStyle(
      //         fontSize: 16,
      //         //color: Colors.black
      //     ),
      //     labelMedium: TextStyle(
      //       fontSize: 20,
      //       //color: Colors.black,
      //       fontWeight: FontWeight.bold
      //     )
      //   ),
      //   useMaterial3: true,
      // ),
    );
  }
}