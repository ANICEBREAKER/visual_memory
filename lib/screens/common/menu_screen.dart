import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/game_list.dart';
import '../../router.dart';
import '../../theme/app_colors.dart';
import '../../theme/responsive_config.dart';
import '../../theme/app_theme.dart';

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
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications, color: Colors.white,)),
          IconButton(onPressed: () {}, icon: Icon(Icons.settings, color: Colors.white,))
        ],
      ),
      body: Center(
        child: Padding(
          padding: ResponsiveConfig.edgeInsetsSymmetric(
            context,
            horizontal: SpacingSize.l,
            vertical: SpacingSize.none,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

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

              SizedBox(height: ResponsiveConfig.spacing(context, size: SpacingSize.l)),

              // Title / subtitle
              Center(child: Text('Smart Games', style: AppTheme.titleTextStyle(context))),
              SizedBox(height: ResponsiveConfig.spacing(context, size: SpacingSize.xxs)),
              Center(child: Text("Let's train your brain today!", style: AppTheme.descriptionTextStyle(context))),

              SizedBox(height: ResponsiveConfig.spacing(context, size: SpacingSize.m)),

              // Stats row
              Row(
                children: [
                  Expanded(
                    child: MenuStatWidget(
                      title: 'Streak',
                      statIcon: Icons.local_fire_department,
                      progressText: '5 days in a row',
                    ),
                  ),
                  SizedBox(width: ResponsiveConfig.spacing(context, size: SpacingSize.m)),
                  Expanded(
                    child: MenuStatWidget(
                      title: 'Ranking',
                      statIcon: Icons.leaderboard,
                      progressText: '#1234',
                    ),
                  ),
                ],
              ),

              SizedBox(height: ResponsiveConfig.spacing(context, size: SpacingSize.m)),

              // Game of the Day header
              // FittedBox(
              //   fit: BoxFit.fitWidth,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text('Game of the Day', style: AppTheme.subtitleTextStyle(context)),
              //       TextButton(
              //         onPressed: () {},
              //         child: Text('Past Games', style: AppTheme.textButtonTextStyle(context)),
              //       ),
              //     ],
              //   ),
              // ),

              SizedBox(height: ResponsiveConfig.spacing(context, size: SpacingSize.s)),

              // Featured game card (large)
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                    ),
                    borderRadius: BorderRadius.circular(ResponsiveConfig.cornerRadiusValue(context, size: RadiusSize.l)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(ResponsiveConfig.spacing(context, size: SpacingSize.l)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: ResponsiveConfig.spacing(context, size: SpacingSize.s),
                                vertical: ResponsiveConfig.spacing(context, size: SpacingSize.xs),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(ResponsiveConfig.cornerRadiusValue(context, size: RadiusSize.s)),
                              ),
                              child: Text('FEATURED', style: AppTheme.cardSubtitleTextStyle(context).copyWith(color: Colors.white)),
                            ),
                            const Icon(Icons.favorite_border_rounded, color: Colors.white),
                          ],
                        ),
                        SizedBox(height: ResponsiveConfig.spacing(context, size: SpacingSize.m)),
                        Center(child: Icon(Icons.grid_view_rounded, color: Colors.white, size: ResponsiveConfig.iconSize(context, size: IconSize.xl))),
                        SizedBox(height: ResponsiveConfig.spacing(context, size: SpacingSize.m)),
                        Text('Visual Memory', style: AppTheme.descriptionTextStyle(context).copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                        SizedBox(height: ResponsiveConfig.spacing(context, size: SpacingSize.s)),
                        Text(
                          'Memorize patterns on a grid of squares to improve your short-term recall.',
                          style: AppTheme.cardSubtitleTextStyle(context).copyWith(color: Colors.white.withOpacity(0.9)),
                        ),
                        SizedBox(height: ResponsiveConfig.spacing(context, size: SpacingSize.l)),
                        SizedBox(
                          width: double.infinity,
                          height: ResponsiveConfig.iconSize(context, size: IconSize.xl),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF42A5F5),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(ResponsiveConfig.cornerRadiusValue(context, size: RadiusSize.l)),
                              ),
                              padding: EdgeInsets.symmetric(vertical: ResponsiveConfig.spacing(context, size: SpacingSize.s)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.play_arrow_rounded),
                                SizedBox(width: ResponsiveConfig.spacing(context, size: SpacingSize.s)),
                                Text('Play Now', style: AppTheme.blueButtonTextStyle(context)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: ResponsiveConfig.spacing(context, size: SpacingSize.l)),

              Center(
                child: IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.primaryDarkVariant,
                    shadowColor: AppColors.secondaryDarkVariant,
                    fixedSize: Size(56, 56),
                  ),
                  iconSize: ResponsiveConfig.iconSize(context, size: IconSize.xl),
                  icon: const Icon(Icons.play_arrow, color: Colors.white),
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
        borderRadius: BorderRadius.circular(ResponsiveConfig.cornerRadiusValue(context, size: RadiusSize.l)),
        border: Border.all(color: AppColors.primaryDarkVariant, width: 2.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(ResponsiveConfig.spacing(context, size: SpacingSize.s)),
            decoration: BoxDecoration(
              color: AppColors.primaryDarkVariant.withOpacity(0.12),
              borderRadius: BorderRadius.circular(ResponsiveConfig.cornerRadiusValue(context, size: RadiusSize.m)),
            ),
            child: Icon(statIcon, size: ResponsiveConfig.iconSize(context, size: IconSize.m), color: AppColors.primaryDarkVariant),
          ),
          SizedBox(height: ResponsiveConfig.spacing(context, size: SpacingSize.m)),
          Text(title, style: AppTheme.cardTitleTextStyle(context)),
          SizedBox(height: ResponsiveConfig.spacing(context, size: SpacingSize.xs)),
          Text(progressText, style: AppTheme.cardSubtitleTextStyle(context)),
        ],
      ),
    );
  }
}
