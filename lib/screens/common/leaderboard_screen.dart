import 'package:flutter/material.dart';
import 'package:game_testing/theme/app_colors.dart';
import '../../theme/app_theme.dart';

class LeaderboardScreen extends StatefulWidget {
  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  String chosenTimeFrame = 'all_time'; // default value
  @override
  Widget build(BuildContext context) {
    //timeDilation = 2;
    return Scaffold(
        backgroundColor: AppColors.backgroundDarkDimmed,
        appBar: AppBar(
          leading: IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.arrow_back, color: Colors.white,)),
          //title: Center(child: Text("Leaderboard", style: AppTheme.subtitleTextStyle(context))),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.settings, color: Colors.white,)),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FittedBox(child: Text("Leaderboard", style: AppTheme.subtitleTextStyle(context))),
                        FittedBox(child: Text("Current rankings", style: AppTheme.descriptionTextStyle(context))),
                      ],
                    ),
                    Expanded(
                      child: DropdownButton(
                          items: [
                            DropdownMenuItem(value: 'all_time', child: Text('All Time')),
                            DropdownMenuItem(value: 'this_month', child: Text('This Month')),
                            DropdownMenuItem(value: 'this_week', child: Text('This Week')),
                            DropdownMenuItem(value: 'today', child: Text('Today')),
                          ],
                          onChanged: (value) {
                            setState(() {
                              chosenTimeFrame = value!;
                            });
                          },
                        value: chosenTimeFrame,
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 25,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(child: Text("${index + 1}")),
                          title: Text("Player ${index + 1}"),
                          trailing: Text("${(25 - index) * 1000}"),
                          style: ListTileStyle.list,
                        ),
                      ),
                    ),
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),

                  ),
                ),
                Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Text("N")),
                    title: Text("You"),
                    trailing: Text("12345"),
                    style: ListTileStyle.list,
                  ),
                ),
                Row(

                ),
              ]),
        ));
  }
}
