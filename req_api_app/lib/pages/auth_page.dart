import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:req_api_app/admin/HomePage.dart';
import 'package:req_api_app/user/HomePage.dart';
import 'login_or_register.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            if (snapshot.data!.email != "admin@gmail.com") {
              return HomeScreenUser();
            }
            return HomeScreenAdmin();
          }

          // user is NOT logged in
          else {
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
