import 'package:flutter/material.dart';
import 'package:game_testing/theme/button_design.dart';
import 'package:go_router/go_router.dart';
import '../../../data/game_list.dart';
import '../../../router.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/responsive_config.dart';
import '../../../theme/app_theme.dart';
import '../game_selection_screen.dart';
import 'menu_widgets.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDarkDimmed,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDarkVariant,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                AlertDialog();
              },
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                context.go(RoutePath.settings.path);
              },
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ))
        ],
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: ResponsiveConfig.edgeInsetsSymmetric(
            context,
            horizontal: SpacingSize.l,
            vertical: SpacingSize.none,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
              children: [
                SizedBox(
                    height:
                        ResponsiveConfig.spacing(context, size: SpacingSize.l)),
                // Title / subtitle
                Text('Brain Train',
                    style: AppTheme.titleTextStyle(context)),
                SizedBox(
                    height: ResponsiveConfig.spacing(context,
                        size: SpacingSize.xxs)),
                Text("Let's train your brain today!",
                    style: AppTheme.descriptionTextStyle(context)),
                SizedBox(
                    height:
                        ResponsiveConfig.spacing(context, size: SpacingSize.m)),
                NDayStreakCard(),
                SizedBox(
                    height:
                        ResponsiveConfig.spacing(context, size: SpacingSize.m)),
                TodaysCognitiveRoutineCard(),
                SizedBox(
                    height:
                        ResponsiveConfig.spacing(context, size: SpacingSize.l)),
                Text("Quick Play",
                    style: AppTheme.subtitleTextStyle(context)),
                SizedBox(
                    height:
                        ResponsiveConfig.spacing(context, size: SpacingSize.s)),
                // Quick Play section with available games
                ...dummyGames
                    .where((game) => game.active) // Only include active games
                    .take(4) // Limit to 4 games
                    .map((game) => Padding(
                          padding: ResponsiveConfig.padding(context,
                              size: PaddingSize.xs),
                          child: GameListTile(index: dummyGames.indexOf(game)),
                        ))
                    .toList(),
                SizedBox(
                    height:
                        ResponsiveConfig.spacing(context, size: SpacingSize.l)),
                // Replace IconButton with BasicBlueButton
                BasicBlueButton(
                  route: RoutePath.gameSelection,
                  label: "Browse all Games",
                ),
                SizedBox(
                    height:
                    ResponsiveConfig.spacing(context, size: SpacingSize.l)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// MenuStatWidget (updated to use ResponsiveConfig/AppColors)
class MenuStatWidget extends StatelessWidget {
  MenuStatWidget({
    super.key,
    required this.title,
    required this.statIcon,
    required this.progressText,
  });

  String progressText;
  String title;
  IconData statIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ResponsiveConfig.padding(context, size: PaddingSize.m),
      decoration: BoxDecoration(
        color: AppColors.surfaceDarkVariant,
        borderRadius: BorderRadius.circular(
            ResponsiveConfig.cornerRadiusValue(context, size: RadiusSize.l)),
        border: Border.all(color: AppColors.primaryDarkVariant, width: 2.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(
                ResponsiveConfig.spacing(context, size: SpacingSize.s)),
            decoration: BoxDecoration(
              color: AppColors.primaryDarkVariant.withOpacity(0.12),
              borderRadius: BorderRadius.circular(
                  ResponsiveConfig.cornerRadiusValue(context,
                      size: RadiusSize.m)),
            ),
            child: Icon(statIcon,
                size: ResponsiveConfig.iconSize(context, size: IconSize.m),
                color: AppColors.primaryDarkVariant),
          ),
          SizedBox(
              height: ResponsiveConfig.spacing(context, size: SpacingSize.m)),
          Text(title, style: AppTheme.cardTitleTextStyle(context)),
          SizedBox(
              height: ResponsiveConfig.spacing(context, size: SpacingSize.xs)),
          Text(progressText, style: AppTheme.cardSubtitleTextStyle(context)),
        ],
      ),
    );
  }
}

// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children: [
//     IconButton(
//       onPressed: () {},
//       icon: const Icon(Icons.arrow_back, color: Colors.white),
//     ),
//     Row(
//       children: [
//         Stack(
//           children: [
//             const Icon(Icons.notifications_none_rounded, color: Colors.white, size: 28),
//             Positioned(
//               right: 2,
//               top: 2,
//               child: Container(
//                 width: 8,
//                 height: 8,
//                 decoration: const BoxDecoration(
//                   color: AppColors.mediumDifficulty,
//                   shape: BoxShape.circle,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(width: ResponsiveConfig.spacing(context, size: SpacingSize.m)),
//         Container(
//           padding: EdgeInsets.all(ResponsiveConfig.spacing(context, size: SpacingSize.xs)),
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             border: Border.all(color: AppColors.primaryDark, width: 2),
//           ),
//           child: const CircleAvatar(
//             radius: 18,
//             backgroundColor: AppColors.surfaceDarkVariant,
//             child: Icon(Icons.person, color: Color(0xFFFFD180)),
//           ),
//         ),
//       ],
//     ),
//   ],
// ),
// Stats row
// Row(
//   children: [
//     Expanded(
//       child: MenuStatWidget(
//         title: 'Streak',
//         statIcon: Icons.local_fire_department,
//         progressText: '5 days in a row',
//       ),
//     ),
//     SizedBox(
//         width: ResponsiveConfig.spacing(context,
//             size: SpacingSize.m)),
//     Expanded(
//       child: MenuStatWidget(
//         title: 'Ranking',
//         statIcon: Icons.leaderboard,
//         progressText: '#1234',
//       ),
//     ),
//   ],
// ),

// Featured game card (large)
// Container(
//   width: double.infinity,
//   decoration: BoxDecoration(
//     gradient: const LinearGradient(
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//       colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
//     ),
//     borderRadius: BorderRadius.circular(
//         ResponsiveConfig.cornerRadiusValue(context,
//             size: RadiusSize.l)),
//   ),
//   child: Padding(
//     padding: EdgeInsets.all(
//         ResponsiveConfig.spacing(context, size: SpacingSize.l)),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Container(
//               padding: EdgeInsets.symmetric(
//                 horizontal: ResponsiveConfig.spacing(context,
//                     size: SpacingSize.s),
//                 vertical: ResponsiveConfig.spacing(context,
//                     size: SpacingSize.xs),
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.12),
//                 borderRadius: BorderRadius.circular(
//                     ResponsiveConfig.cornerRadiusValue(context,
//                         size: RadiusSize.s)),
//               ),
//               child: Text('FEATURED',
//                   style: AppTheme.cardSubtitleTextStyle(context)
//                       .copyWith(color: Colors.white)),
//             ),
//             const Icon(Icons.favorite_border_rounded,
//                 color: Colors.white),
//           ],
//         ),
//         SizedBox(
//             height: ResponsiveConfig.spacing(context,
//                 size: SpacingSize.m)),
//         Center(
//             child: Icon(Icons.grid_view_rounded,
//                 color: Colors.white,
//                 size: ResponsiveConfig.iconSize(context,
//                     size: IconSize.xl))),
//         SizedBox(
//             height: ResponsiveConfig.spacing(context,
//                 size: SpacingSize.m)),
//         Text('Visual Memory',
//             style: AppTheme.descriptionTextStyle(context)
//                 .copyWith(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold)),
//         SizedBox(
//             height: ResponsiveConfig.spacing(context,
//                 size: SpacingSize.s)),
//         Text(
//           'Memorize patterns on a grid of squares to improve your short-term recall.',
//           style: AppTheme.cardSubtitleTextStyle(context)
//               .copyWith(color: Colors.white.withOpacity(0.9)),
//         ),
//         SizedBox(
//             height: ResponsiveConfig.spacing(context,
//                 size: SpacingSize.l)),
//         SizedBox(
//           width: double.infinity,
//           height: ResponsiveConfig.iconSize(context,
//               size: IconSize.xl),
//           child: ElevatedButton(
//             onPressed: () {context.go(RoutePath.visualMemoryStartScreen.path);},
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF42A5F5),
//               foregroundColor: Colors.white,
//               elevation: 0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(
//                     ResponsiveConfig.cornerRadiusValue(context,
//                         size: RadiusSize.l)),
//               ),
//               padding: EdgeInsets.symmetric(
//                   vertical: ResponsiveConfig.spacing(context,
//                       size: SpacingSize.s)),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(Icons.play_arrow_rounded),
//                 SizedBox(
//                     width: ResponsiveConfig.spacing(context,
//                         size: SpacingSize.s)),
//                 Text('Play Now',
//                     style: AppTheme.blueButtonTextStyle(context)),
//               ],
//             ),
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
