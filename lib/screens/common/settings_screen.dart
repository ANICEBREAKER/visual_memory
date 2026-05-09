import 'package:flutter/material.dart';
import 'package:game_testing/main.dart';

import '../../theme/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
        ],
      ),
      body: Center(
        child: Column(
          children: [
            //Later
          ],
        ),
      ),
    );
  }
}
