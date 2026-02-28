import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:game_testing/service/auth_service.dart';
import '../../router.dart';
import '../../theme/app_colors.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool isLoading = false;
  String email = "";
  String password = "";
  String error = "";
  final SupabaseService supabase = SupabaseService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceDarkVariant,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
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
                    SizedBox(height: 24.0),
                    Center(
                      child: Text(
                        'Smart Games',
                        style: TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.w900,
                          color: AppColors.textPrimaryDark,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Center(
                      child: Text(
                        'Create your account',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textSecondaryDark,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.0),

                    // Email field
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email, color: AppColors.textSecondaryDark),
                        hintText: 'Enter your email',
                        filled: true,
                        fillColor: AppColors.backgroundDarkDimmed,
                        contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: TextStyle(color: AppColors.textPrimaryDark, fontSize: 18.0),
                    ),
                    SizedBox(height: 8.0),

                    // Password field
                    TextField(
                      obscureText: true,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: AppColors.textSecondaryDark),
                        hintText: 'Enter your password',
                        filled: true,
                        fillColor: AppColors.backgroundDarkDimmed,
                        contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: TextStyle(color: AppColors.textPrimaryDark, fontSize: 18.0),
                    ),
                    SizedBox(height: 12.0),

                    // Registration button (preserve original signUp logic)
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
                            error = "";
                          });
                          try {
                            final AuthResponse res = await supabase.signUp(
                              email, password,
                            );
                            final Session? session = res.session;
                            final User? user = res.user;
                            if (user != null) {
                              context.go(RoutePath.menu.path);
                            }
                          } catch (e) {
                            setState(() {
                              error = e.toString();
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
                          'Register →',
                          style: TextStyle(
                            color: AppColors.textPrimaryDark,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 8.0),
                    if (error.isNotEmpty)
                      Text(error, style: TextStyle(color: Colors.red)),
                    SizedBox(height: 12.0),

                    // Blue highlighted tappable line to go back to login
                    Container(
                      width: double.infinity,
                      color: AppColors.selectedItemBackground,
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: TextButton(
                        onPressed: () {
                          context.go(RoutePath.login.path);
                        },
                        child: Text(
                          "Already have an account? Log in →",
                          style: TextStyle(
                            color: AppColors.link,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
