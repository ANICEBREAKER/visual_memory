import 'package:flutter/material.dart';
import 'package:game_testing/player_progress/player_progress.dart';
import 'package:game_testing/screens/visual_memory/visual_memory_logic/level_state.dart';
import 'package:game_testing/screens/visual_memory/visual_memory_start_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../menu_screen.dart';

class VisualMemoryResultScreen extends StatefulWidget {
  final int level;
  final String difficulty;
  const VisualMemoryResultScreen({super.key, required this.level, required this.difficulty});

  @override
  State<VisualMemoryResultScreen> createState() =>
      _VisualMemoryResultScreenState();
}

class _VisualMemoryResultScreenState extends State<VisualMemoryResultScreen> {
  bool isConnectedWithInternet = false;

  @override
  void initState() {
    print("Player score: ${widget.level}");
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<PlayerProgress>().getLatestFromStore( 'visual_memory', widget.difficulty);
      if (mounted) {
        context.read<PlayerProgress>().setLevelReached(widget.level, 'visual_memory', widget.difficulty);
      } else {
        print("Widget not mounted, cannot access context.");
        return;
      }
    });
    hasSecureInternetConnection().then((value) {
      setState(() {
        isConnectedWithInternet = value;
      });
    });
    print("Stored high score: ${context.read<PlayerProgress>().highestLevelReached}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.go('/');
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
                  context.go('/');
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

  Future<bool> hasSecureInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    try {
      final response = await http.get(Uri.parse('https://google.com'));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
