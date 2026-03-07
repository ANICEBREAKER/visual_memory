import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router.dart';
import 'app_colors.dart';
class DifficultyButton extends StatelessWidget {
  final String label;
  final RoutePath gamePath;

  const DifficultyButton({
    required this.label,
    required this.gamePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // return ElevatedButton(
    //   onPressed: () {
    //     context.go(gamePath.path + '?difficulty=$label');
    //   },
    //   style: ElevatedButton.styleFrom(
    //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    //       backgroundColor: difficulty_color
    //   ),
    //   child: Text(
    //     label,
    //     style: Theme.of(context).textTheme.labelSmall,
    //   ),
    // );
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
          color: AppColors.textPrimaryDark,
        ),
      ),
      subtitle: Text('Insert player record on difficulty $label here',
        style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
      ),
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.primaryDarkVariant,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
            child:
            Icon(Icons.square_rounded, color: Colors.white)),
      ),
      trailing: Icon(Icons.turn_right, color: Colors.white),
      onTap: () {
        context.go('${gamePath.path}?difficulty=$label');
      },
      tileColor: label == 'Easy' ? AppColors.easyDifficulty : (label == 'Medium' ? AppColors.mediumDifficulty : AppColors.hardDifficulty),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(
          color: AppColors.borderDark,
          width: 2.0,
        ),
      ),
    );
  }
}

