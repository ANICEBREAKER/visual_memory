import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:game_testing/theme/app_colors.dart';
import '../../router.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    //timeDilation = 2;
    return Scaffold(
      backgroundColor: AppColors.surfaceDarkVariant,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // center children horizontally so the top icon Container keeps its explicit width
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
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
              width: 150.0,
              height: 150.0,
              child: Center(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 90.0,
                    width: 90.0,
                    child: Icon(
                      Icons.extension,
                      size: 90.0,
                      color: AppColors.primaryDarkVariant,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Center(
              child: DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textPrimaryDark,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText('Smart Games')
                    ],
                    totalRepeatCount: 1,
                  )
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Center(
              child: DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textSecondaryDark,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText('Train your brain with fun!')
                    ],
                    totalRepeatCount: 1,
                  )
              ),
            ),
            SizedBox(
              height: 80.0,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primaryDarkVariant, AppColors.secondaryDarkVariant],
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
                  onPressed: (){
                    context.go(RoutePath.login.path);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    'Log In →',
                    style: TextStyle(
                      color: AppColors.textPrimaryDark,
                      fontSize: 25.0,
                    ),
                  )
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            // ElevatedButton(
            //     onPressed: (){
            //       context.go(RoutePath.register.path);
            //     },
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.lightBlueAccent,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(30.0),
            //       ),
            //     ),
            //     child: Text('Registration')
            // ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primaryDarkVariant, AppColors.secondaryDarkVariant],
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
              // also make registration button full-width
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: (){
                    context.go(RoutePath.register.path);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    'Registration →',
                    style: TextStyle(
                      color: AppColors.textPrimaryDark,
                      fontSize: 25.0,
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//wwwwwwwwwwwwwwaa