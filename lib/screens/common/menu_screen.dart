import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/game_list.dart';
import '../../router.dart';
import '../../theme/app_colors.dart';
import '../../theme/responsive_config.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceDarkVariant,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications, color: Colors.white,)),
          IconButton(onPressed: () {}, icon: Icon(Icons.settings, color: Colors.white,))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Smart Games',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textPrimaryDark,
                  ),
                ),
              ),
              SizedBox(height: 4.0),
              Center(
                child: Text(
                  'Let\'s train your brain today!',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textSecondaryDark,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: ResponsiveConfig.padding(context, size: PaddingSize.m),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: ResponsiveConfig.spacing(context, size: SpacingSize.l),
                  children: [
                    Expanded(
                      child: MenuStatWidget(
                        title: 'Streak',
                        statIcon: Icons.local_fire_department,
                        progressText: '5 days in a row',
                      ),
                    ),
                    Expanded(
                      child: MenuStatWidget(
                        title: 'Ranking',
                        statIcon: Icons.leaderboard,
                        progressText: '#1234',
                      ),
                    ),
                  ]
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Center(
                      child: Text(
                        'Game of the Day!',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: AppColors.textPrimaryDark,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        //Insert past games route here
                      },
                      child: Text(
                        'View Past Games',
                        style: TextStyle(
                            color: AppColors.primaryDarkVariant, fontSize: 10.0),
                      ),
                    ),
                  ),
                ],
              ),
              // ListTile(
              //   title: Text(dummyGames[0].name, style: Theme.of(context).textTheme.labelMedium,),
              //   subtitle: Text(dummyGames[0].description, style: Theme.of(context).textTheme.labelSmall),
              //   leading: Icon(Icons.square_rounded, color: Colors.black,),
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => dummyGames[0].destination),
              //     );
              //   },
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(10.0),
              //   ),
              // ),
              // SizedBox(height: 15),
              // ListTile(
              //   leading: Icon(Icons.format_line_spacing),
              //   title: Text(
              //     'Check out other games',
              //     style: Theme.of(context).textTheme.labelMedium
              //   ),
              //   subtitle: Text('Sample text here', style: Theme.of(context).textTheme.labelSmall),
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(10.0),
              //   ),
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => TempGameScreen()),
              //     );
              //   },
              // ),
              //Insert the daily widget here
              SizedBox(
                height: 30.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryDarkVariant,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryDarkVariant.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(ResponsiveConfig.spacing(context, size: SpacingSize.m)),
                  child: ElevatedButton(
                    onPressed: () {
                      context.go(RoutePath.visualMemoryStartScreen.path);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [

                          ],
                        ),
                        Icon(Icons.square_rounded, size: 100.0, color: Colors.white),
                        SizedBox(height: 10),
                        Text(dummyGames[0].name, style: TextStyle(fontSize: ResponsiveConfig.textSize(context, size: TextSize.xl), color: Colors.white, fontWeight: FontWeight.w800)),
                        SizedBox(height: 5),
                        Text(dummyGames[0].description, style: TextStyle(fontSize: ResponsiveConfig.textSize(context, size: TextSize.l), color: Colors.white))
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: IconButton(
                  style: IconButton.styleFrom(
                      backgroundColor: AppColors.primaryDarkVariant,
                      shadowColor: AppColors.secondaryDarkVariant
                  ),
                  iconSize: 50.0,
                  icon: Icon(Icons.play_arrow, color: Colors.white),
                  onPressed: () {
                    context.go(RoutePath.gameSelection.path);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuStatWidget extends StatelessWidget {
  MenuStatWidget({
    super.key,
    required this.title,
    required this.statIcon,
    required this.progressText
  });

  String progressText;
  String title;
  IconData statIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceDarkVariant,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
            color: AppColors.primaryDarkVariant, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDarkVariant.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: ResponsiveConfig.padding(context, size: PaddingSize.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceDarkVariant,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                    color: AppColors.primaryDarkVariant, width: 2.0),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryDarkVariant.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(statIcon, size: 40.0, color: AppColors.primaryDarkVariant)
            ), //color: AppColors.primaryDarkVariant
            SizedBox(height: ResponsiveConfig.spacing(context, size: SpacingSize.s)),
            Text(
              title,
                style: TextStyle(fontSize: ResponsiveConfig.textSize(context, size: TextSize.xl))
            ), //style: TextStyle(color: AppColors.textPrimaryDark)
            SizedBox(height: ResponsiveConfig.spacing(context, size: SpacingSize.xs)),
            Text(
                progressText,
                style: TextStyle(fontSize: ResponsiveConfig.textSize(context, size: TextSize.l))
            )
          ],
        ),
      ),
    );
  }
}
