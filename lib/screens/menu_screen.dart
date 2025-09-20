import 'package:flutter/material.dart';
import 'package:game_testing/screens/temp_game_screen.dart';

import '../data/game_list.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.settings, color: Colors.white,))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Image.network('https://spng.pngfind.com/pngs/s/470-4706698_png-file-svg-jigsaw-puzzle-piece-png-transparent.png', color: Colors.white,),
              SizedBox(height: 20),
              Text(
                'Smart Games',
                style: Theme.of(context).textTheme.bodyLarge
              ),
              SizedBox(height: 20),
              Text(
                'Check out our game of the day',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text(dummyGames[0].name, style: Theme.of(context).textTheme.labelMedium,),
                subtitle: Text(dummyGames[0].description, style: Theme.of(context).textTheme.labelSmall),
                leading: Icon(Icons.square_rounded, color: Colors.black,),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => dummyGames[0].destination),
                  );
                },
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              SizedBox(height: 15),
              ListTile(
                leading: Icon(Icons.format_line_spacing),
                title: Text(
                  'Check out other games',
                  style: Theme.of(context).textTheme.labelMedium
                ),
                subtitle: Text('Sample text here', style: Theme.of(context).textTheme.labelSmall),
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TempGameScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
