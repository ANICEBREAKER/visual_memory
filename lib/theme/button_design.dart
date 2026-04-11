import 'package:flutter/material.dart';
import 'package:game_testing/theme/responsive_config.dart';
import 'package:go_router/go_router.dart';
import '../router.dart';
import 'app_colors.dart';
import 'app_theme.dart';

// import '../router.dart';
// import 'app_colors.dart';
// class DifficultyButton extends StatelessWidget {
//   final String label;
//   final RoutePath gamePath;
//
//   const DifficultyButton({
//     required this.label,
//     required this.gamePath,
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(
//         label,
//         style: TextStyle(
//           fontSize: 20.0,
//           fontWeight: FontWeight.w900,
//           color: AppColors.textPrimaryDark,
//         ),
//       ),
//       subtitle: Text('Insert player record on difficulty $label here',
//         style: TextStyle(
//           fontSize: 15.0,
//           fontWeight: FontWeight.w900,
//           color: Colors.white,
//         ),
//       ),
//       leading: Container(
//         width: 50,
//         height: 50,
//         decoration: BoxDecoration(
//           color: AppColors.primaryDarkVariant,
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         child: Center(
//             child:
//             Icon(Icons.square_rounded, color: Colors.white)),
//       ),
//       trailing: Icon(Icons.turn_right, color: Colors.white),
//       onTap: () {
//         context.go('${gamePath.path}?difficulty=$label');
//       },
//       tileColor: label == 'Easy' ? AppColors.easyDifficulty : (label == 'Medium' ? AppColors.mediumDifficulty : AppColors.hardDifficulty),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20.0),
//         side: BorderSide(
//           color: AppColors.borderDark,
//           width: 2.0,
//         ),
//       ),
//     );
//   }
// }
//
// Dart
class DifficultyButton extends StatelessWidget {
  final String label;
  final RoutePath gamePath;
  final IconData icon;
  //final String highScore;

  const DifficultyButton({
    required this.label,
    required this.gamePath,
    required this.icon,
    //required this.highScore,

    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color color = (label == 'Easy' ? AppColors.easyDifficulty : (label == 'Medium' ? AppColors.mediumDifficulty : AppColors.hardDifficulty));
    return InkWell(
      onTap: () => context.go('${gamePath.path}?difficulty=$label'),
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: 84,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              blurRadius: 20,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: Icon(icon, color: Colors.white, size: 28),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(label, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text('High Score: 20', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.9))),
                    ),
                  ],
                ),
              ],
            ),
            Icon(Icons.play_arrow, color: Colors.white.withOpacity(0.8), size: 28),
          ],
        ),
      ),
    );
  }
}

class BasicBlueButton extends StatelessWidget {
  const BasicBlueButton({
    super.key,
    required this.route,
    required this.label,
  });

  final RoutePath route;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryDarkVariant,
            AppColors.secondaryDarkVariant
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,

        ),
        //border: Border.all(color: AppColors.borderDark, width: 1.0),
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDarkVariant.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      // ensure the button container fills available width even when Column is centered
      width: double.infinity,
      child: ElevatedButton(
          onPressed: () {
            context.go(route.path);
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(width: 0)
            ),
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            // minimumSize: Size.fromHeight(100)
          ),
          child: Padding(
            padding: ResponsiveConfig.padding(context, size: PaddingSize.xxs),
            child: Text(
              label,
              style: AppTheme.blueButtonTextStyle(context),
            ),
          )),
    );
  }
}
