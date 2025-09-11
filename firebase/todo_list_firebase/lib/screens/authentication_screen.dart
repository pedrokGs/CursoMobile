import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_firebase/screens/login_screen.dart';
import 'package:todo_list_firebase/screens/tarefas_screen.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot) {
      if(snapshot.hasData){
        return TarefasScreen();
      }
      return LoginScreen();
    },);
  }
}