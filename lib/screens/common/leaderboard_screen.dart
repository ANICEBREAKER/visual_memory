import 'package:flutter/material.dart';
import 'package:game_testing/data/game_list.dart';
import 'package:game_testing/theme/app_colors.dart';
import 'package:game_testing/theme/responsive_config.dart';
import '../../theme/app_theme.dart';

class LeaderboardScreen extends StatefulWidget {
  final int initialGameIndex;
  const LeaderboardScreen({super.key, this.initialGameIndex = 0});

  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  int selectedGameIndex = 0; // The current selected game

  @override
  void initState() {
    super.initState();
    selectedGameIndex = widget.initialGameIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundDarkDimmed,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.share,
                  color: Colors.white,
                )),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    height:
                        ResponsiveConfig.spacing(context, size: SpacingSize.m)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                            child: Text("Leaderboard",
                                style: AppTheme.subtitleTextStyle(context))),
                        FittedBox(
                            child: Text("Current rankings",
                                style: AppTheme.descriptionTextStyle(context))),
                      ],
                    ),
                    StyledLeaderboardDropdown(),
                  ],
                ),
                SizedBox(
                    height:
                        ResponsiveConfig.spacing(context, size: SpacingSize.s)),
                Expanded(
                  child: ListView.builder(
                    itemCount: 25,
                    itemBuilder: (context, index) {
                      // determine rank-based colors (1st, 2nd, 3rd)
                      final bool isFirst = index == 0;
                      final bool isSecond = index == 1;
                      final bool isThird = index == 2;

                      final Color textColor = isFirst
                          ? AppColors.firstText
                          : isSecond
                              ? AppColors.secondText
                              : isThird
                                  ? AppColors.thirdText
                                  : AppColors.textPrimaryDark;

                      final Color borderColor = isFirst
                          ? AppColors.firstBorder
                          : isSecond
                              ? AppColors.secondBorder
                              : isThird
                                  ? AppColors.thirdBorder
                                  : AppColors.gameCardBorder;

                      final Color tintColor = isFirst
                          ? AppColors.firstTint
                          : isSecond
                              ? AppColors.secondTint
                              : isThird
                                  ? AppColors.thirdTint
                                  : AppColors.transparent;

                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: Card(
                          color: AppColors.gameCardBackground,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: borderColor, width: 1.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: tintColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: AppColors.transparent,
                                child: Text("${index + 1}",
                                    style: TextStyle(
                                        color: textColor,
                                        fontSize: ResponsiveConfig.textSize(
                                            context,
                                            size: TextSize.l),
                                        fontWeight: FontWeight.bold)),
                              ),
                              title: Text("Player ${index + 1}",
                                  style: TextStyle(color: textColor)),
                              trailing: Text("${(25 - index) * 1000}",
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: ResponsiveConfig.textSize(
                                          context,
                                          size: TextSize.m),
                                      fontWeight: FontWeight.bold)),
                              style: ListTileStyle.list,
                            ),
                          ),
                        ),
                      );
                    },
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                  ),
                ),
                SizedBox(
                    height:
                    ResponsiveConfig.spacing(context, size: SpacingSize.s)),
                Card(
                  color: AppColors.gameCardBackground,
                  shape: RoundedRectangleBorder(
                    side:
                        BorderSide(color: AppColors.primaryDarkVariant, width: 1.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.transparent,
                        child: Text("N",
                            style: TextStyle(
                                color: AppColors.textPrimaryDark,
                                fontSize: ResponsiveConfig.textSize(context,
                                    size: TextSize.l),
                                fontWeight: FontWeight.bold)),
                      ),
                      title: Text("You",
                          style: TextStyle(color: AppColors.textPrimaryDark)),
                      trailing: Text("1000",
                          style: TextStyle(
                              color: AppColors.textPrimaryDark,
                              fontSize: ResponsiveConfig.textSize(context,
                                  size: TextSize.m),
                              fontWeight: FontWeight.bold)),
                      style: ListTileStyle.list,
                    ),
                  ),
                ),
                // Horizontal game selector: give the horizontal ListView a fixed height so it has a bounded cross-axis.
                SizedBox(
                    height:
                    ResponsiveConfig.spacing(context, size: SpacingSize.m)),
                SizedBox(
                  height: ResponsiveConfig.iconSize(context, size: IconSize.s) * 2.4 +
                      ResponsiveConfig.spacing(context, size: SpacingSize.s),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: dummyGames.length,
                    padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveConfig.spacing(context, size: SpacingSize.m) / 2),
                    itemBuilder: (context, index) {
                      final bool isSelected = index == selectedGameIndex;
                      return Padding(
                        padding: EdgeInsets.only(
                            right: ResponsiveConfig.spacing(context, size: SpacingSize.s)),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedGameIndex = index;
                            });
                            // Switch games
                          },
                          child: Container(
                            width:
                                ResponsiveConfig.iconSize(context, size: IconSize.s) * 3,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceDarkVariant,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color: isSelected ? AppColors.primaryDarkVariant : AppColors.placeholder, width: 2.0),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color:
                              //         AppColors.primaryDarkVariant.withOpacity(0.5),
                              //     spreadRadius: 2,
                              //     blurRadius: 5,
                              //     offset: Offset(0, 3),
                              //   ),
                              // ],
                            ),
                            child: Center(
                              child: Icon(
                                dummyGames[index].icon,
                                size:
                                    ResponsiveConfig.iconSize(context, size: IconSize.m),
                                color: isSelected ? AppColors.primaryDarkVariant : AppColors.placeholder,
                              ),
                            ),
                          ),
                        ),
                      );
                    },

                  ),
                ),
              ]),
        ));
  }
}

// Styled dropdown widget implementation
class StyledLeaderboardDropdown extends StatefulWidget {
  const StyledLeaderboardDropdown({super.key});

  @override
  State<StyledLeaderboardDropdown> createState() =>
      _StyledLeaderboardDropdownState();
}

class _StyledLeaderboardDropdownState extends State<StyledLeaderboardDropdown> {
  String chosenTimeFrame = 'this_week';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF121826), // surfaceDarkVariant
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: const Color(0xFF2C3444), width: 1.5), // borderDark
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: chosenTimeFrame,
          dropdownColor: const Color(0xFF121826),
          // Match container background
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: Color(0xFF00E5FF)),
          // primaryDark / Cyan
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          items: const [
            DropdownMenuItem(value: 'all_time', child: Text('All Time')),
            DropdownMenuItem(value: 'this_month', child: Text('This Month')),
            DropdownMenuItem(value: 'this_week', child: Text('This Week')),
            DropdownMenuItem(value: 'today', child: Text('Today')),
          ],
          onChanged: (value) {
            if (value != null) {
              setState(() {
                chosenTimeFrame = value;
              });
            }
          },
          selectedItemBuilder: (BuildContext context) {
            return ['all_time', 'this_month', 'this_week', 'today']
                .map((String value) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _getLabel(value),
                  style: const TextStyle(
                    color: Color(0xFF00E5FF),
                    // Highlight selected text with neon blue
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }).toList();
          },
        ),
      ),
    );
  }

  String _getLabel(String value) {
    switch (value) {
      case 'all_time':
        return 'All Time';
      case 'this_month':
        return 'This Month';
      case 'this_week':
        return 'This Week';
      case 'today':
        return 'Today';
      default:
        return '';
    }
  }
}
