import 'package:flutter/material.dart';
import 'package:game_testing/service/auth_service.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../router.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../../theme/responsive_config.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  String email = "";
  String password = "";
  String error = "";
  final SupabaseService supabase = SupabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDarkDimmed,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Padding(
          padding: ResponsiveConfig.padding(context, size: PaddingSize.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                      color: AppColors.primaryDarkVariant,
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
              SizedBox(height: 24.0),
              Center(
                child: Text(
                  'Smart Games',
                  style: AppTheme.titleTextStyle(context),
                ),
              ),
              SizedBox(height: 8.0),
              Center(
                child: Text(
                  'Train your brain with fun!',
                  style: AppTheme.descriptionTextStyle(context),
                ),
              ),
              SizedBox(height: 12.0),
              // Email field: larger input, prefix icon, filled background
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                  email = value;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(
                      Icons.email, color: AppColors.textSecondaryDark),
                  hintText: 'Enter your email',
                  filled: true,
                  fillColor: AppColors.surfaceDarkVariant,
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 18.0, horizontal: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(
                    color: AppColors.textPrimaryDark, fontSize: 18.0),
              ),
              SizedBox(height: ResponsiveConfig.spacing(context, size: SpacingSize.m)),
              // Password field: larger input, lock icon, filled background
              TextField(
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(
                      Icons.lock, color: AppColors.textSecondaryDark),
                  hintText: 'Enter your password',
                  filled: true,
                  fillColor: AppColors.surfaceDarkVariant,
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 18.0, horizontal: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(
                    color: AppColors.textPrimaryDark, fontSize: 18.0),
              ),
              SizedBox(height: 8.0),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // ...existing navigation or recovery logic...
                  },
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero, minimumSize: Size(0, 0)),
                  child: Text(
                    'Forgot your password?',
                    style: AppTheme.textButtonTextStyle(context),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryDarkVariant,
                      AppColors.secondaryDarkVariant
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
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
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      final AuthResponse res = await supabase.signIn(
                        email,
                        password,
                      );
                      final Session? session = res.session;
                      final User? user = res.user;
                      if (user != null) {
                        print('Log in successfully!');
                        context.go(RoutePath.menu.path);
                      }
                    } on AuthException catch (e) {
                      print(e.message);    // Human-readable message
                      setState(() {
                        error = e.message.toString();
                      });
                    } catch (e) {
                      print(e);
                      setState(() {
                        error = "Unknown error, retry later";
                      });
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14.0),
                  ),
                  child: Text(
                    'Log In →',
                    style: AppTheme.blueButtonTextStyle(context),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                error,
                style: AppTheme.errorTextStyle(context),
              ),
              SizedBox(height: 2.0),
              TextButton(
                onPressed: () {
                  context.go(RoutePath.register.path); // or Navigator.push(...)
                },
                child: Text(
                  'Have no account? Register →',
                  style: AppTheme.textButtonTextStyle(context)
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
