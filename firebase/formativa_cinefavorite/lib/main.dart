import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:formativa_cinefavorite/firebase_options.dart';
import 'package:formativa_cinefavorite/screens/authentication/auth_screen.dart';
import 'package:formativa_cinefavorite/screens/authentication/login_screen.dart';
import 'package:formativa_cinefavorite/screens/authentication/register_screen.dart';
import 'package:formativa_cinefavorite/screens/home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/auth",
      routes: {
        "/auth": (context) => AuthScreen(),
        "/login": (context) => LoginScreen(),
        "/home": (context) => HomeScreen(),
        "/register": (context) => RegisterScreen()
      },
    );
  }
}
