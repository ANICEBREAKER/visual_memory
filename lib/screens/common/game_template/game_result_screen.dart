import 'package:flutter/material.dart';
import 'package:game_testing/player_progress/player_progress.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../helper/connection_checker.dart';
import '../../../router.dart';

class GameResultScreen extends StatefulWidget {
  final int level;
  final String difficulty;
  final String game_path;
  const GameResultScreen({super.key, required this.level, required this.difficulty, required this.game_path});

  @override
  State<GameResultScreen> createState() =>
      _QuickMathsResultScreen();
}

class _QuickMathsResultScreen extends State<GameResultScreen> {
  bool isConnectedWithInternet = false;

  @override
  void initState() {
    print("Player score: ${widget.level}");
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<PlayerProgress>().reset();
      await context.read<PlayerProgress>().getLatestFromStore( widget.game_path, widget.difficulty);
      if (mounted) {
        //print("Stored high score: ${context.read<PlayerProgress>().highestLevelReached}");
        context.read<PlayerProgress>().setLevelReached(widget.level, widget.game_path, widget.difficulty);
      } else {
        //print("Widget not mounted, cannot access context.");
        return;
      }
    });
    hasSecureInternetConnection().then((value) {
      setState(() {
        isConnectedWithInternet = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.go(RoutePath.menu.path);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Your level was: ${widget.level}',
                  style: Theme.of(context).textTheme.bodyLarge),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.orangeAccent,
                margin: EdgeInsets.all(20),
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text('Level ${widget.level}',
                        style: Theme.of(context).textTheme.bodyMedium)),
              ), // Level Showing
              Text(
                context.watch<PlayerProgress>().isNewHighScore ? 'New High Score!' : 'Good job!',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 20),
              ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: Icon(
                  Icons.ads_click_outlined,
                  size: 50,
                ),
                title: Text(
                  context.watch<PlayerProgress>().isNewHighScore
                      ? 'Congrats on the high score, think you can beat it?'
                      : 'Wanna try again to beat your high score of Level ${context.watch<PlayerProgress>().highestLevelReached} ?',
                  style: Theme.of(context).textTheme.labelSmall,
                  //highestLevelReached
                ),
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: Icon(
                  Icons.thumb_up_sharp,
                  size: 50,
                ),
                title: Text(
                  isConnectedWithInternet
                      ? 'You were better than xx% of players! That\'s good!'
                      : 'You did pretty well, you should be proud!',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.go(RoutePath.gameSelection.path);
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    backgroundColor: Colors.orangeAccent),
                child: Text(
                  'Try again?',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Placeholder()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    backgroundColor: Colors.orangeAccent),
                child: Text(
                  'View Leaderboard',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
