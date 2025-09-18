import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:formativa_cinefavorite/screens/authentication/login_screen.dart';
import 'package:formativa_cinefavorite/screens/home_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot) {
      if(snapshot.hasData){
        return HomeScreen();
      }
      return LoginScreen();
    },);
  }
}