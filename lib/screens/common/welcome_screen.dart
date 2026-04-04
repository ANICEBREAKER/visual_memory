import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:game_testing/theme/app_colors.dart';
import '../../router.dart';
import '../../theme/app_theme.dart';
import '../../theme/button_design.dart';
import '../../theme/responsive_config.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    //timeDilation = 2;
    return Scaffold(
        backgroundColor: AppColors.backgroundDarkDimmed,
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
                      style: AppTheme.titleTextStyle(context),
                      child: AnimatedTextKit(
                        animatedTexts: [TyperAnimatedText('Smart Games')],
                        totalRepeatCount: 1,
                      )),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Center(
                  child: DefaultTextStyle(
                      style: AppTheme.descriptionTextStyle(context),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText('Train your brain with fun!')
                        ],
                        totalRepeatCount: 1,
                      )),
                ),
                SizedBox(
                  height: 50.0,
                ),
                BasicBlueButton(
                  label: "Log In →",
                  route: RoutePath.login,
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
                BasicBlueButton(
                  label: "Registration →",
                  route: RoutePath.register,
                ),
                SizedBox(
                  height: 30.0,
                ),
                Center(
                  child: Text(
                    'or log in with',
                    style: TextStyle(
                      fontSize: ResponsiveConfig.textSize(context, size: TextSize.l),
                      fontWeight: FontWeight.w900,
                      color: AppColors.textSecondaryDark,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.secondaryDarkVariant,
                        shadowColor: AppColors.primaryDarkVariant
                      ),
                      icon: Icon(Icons.login, color: Colors.white),
                      onPressed: () {
                        // Implement Google login functionality here
                      },
                    ),
                    SizedBox(width: 20.0),
                    IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.secondaryDarkVariant,
                        shadowColor: AppColors.primaryDarkVariant
                      ),
                      icon: Icon(Icons.login, color: Colors.white),
                      onPressed: () {
                        // Implement Github login functionality here
                      },
                    ),
                    SizedBox(width: 20.0),
                    IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.secondaryDarkVariant,
                        shadowColor: AppColors.primaryDarkVariant
                      ),
                      icon: Icon(Icons.login, color: Colors.white),
                      onPressed: () {
                        // Implement Github login functionality here
                      },
                    ),
                  ],
                ),
              ]),
        ));
  }
}