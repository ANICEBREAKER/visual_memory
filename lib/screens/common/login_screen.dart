import 'package:flutter/material.dart';
import 'package:game_testing/service/auth_service.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../router.dart';


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
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    //child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(hintText: 'Enter your email'),
                style: TextStyle(color: Colors.black87),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                },
                decoration: InputDecoration(hintText: 'Enter your password'),
                style: TextStyle(color: Colors.black87),
              ),
              SizedBox(
                height: 24.0,
              ),
              ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      final AuthResponse res = await supabase.signIn(
                        email, password,
                      );
                      final Session? session = res.session;
                      final User? user = res.user;
                      if (user != null) {
                        print('Log in successfully!');
                        context.go(RoutePath.menu.path);
                      }
                    } catch (e) {
                      print(e);
                      setState(() {
                        error = e.toString();
                      });
                    }
                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: Text('Log in'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
              ),
              SizedBox(height: 16,),
              Text(error, style: TextStyle(color: Colors.red))
            ],
          ),
        ),
      ),
    );
  }
}
