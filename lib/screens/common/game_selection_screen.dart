import 'package:flutter/material.dart';
import 'package:game_testing/data/game_list.dart';
import 'package:game_testing/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import '../../router.dart';
import '../../theme/app_colors.dart';
import '../../theme/responsive_config.dart';

class TempGameScreen extends StatefulWidget {
  const TempGameScreen({super.key});

  @override
  State<TempGameScreen> createState() => _TempGameScreenState();
}

class _TempGameScreenState extends State<TempGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDarkDimmed,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.go(RoutePath.menu.path);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Center(
          child: Text(
            'Select game',
            style: AppTheme.subtitleTextStyle(context)
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ))
        ],
      ),
      body: Padding(
        padding: ResponsiveConfig.padding(context, size: PaddingSize.m),
        child: Column(children: [
          Expanded(
            child: ListView.builder(
                itemCount: dummyGames.length,
                itemBuilder: (context, index) => Padding(
                      padding: ResponsiveConfig.padding(context, size: PaddingSize.xs),
                      child: GameListTile(index: index), // Use the new widget
                    )),
          ),
        ]),
      ),
    );
  }
}

// New reusable widget
class GameListTile extends StatelessWidget {
  final int index;

  const GameListTile({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: dummyGames[index].active ? 1 : 0.25,
      child: ListTile(
        title: Text(
          dummyGames[index].name,
          style: AppTheme.cardTitleTextStyle(context),
        ),
        subtitle: Text(
          dummyGames[index].description,
          style: AppTheme.cardSubtitleTextStyle(context),
        ),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: dummyGames[index].displayColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
              child: Icon(dummyGames[index].icon, color: dummyGames[index].iconColor)),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => dummyGames[index].destination),
          );
        },
        enabled: dummyGames[index].active,
        tileColor: AppColors.surfaceDarkVariant,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(
            color: AppColors.borderDark,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
