import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_firebase/firebase_options.dart';
import 'package:todo_list_firebase/providers/theme_provider.dart';
import 'package:todo_list_firebase/screens/authentication_screen.dart';
import 'package:todo_list_firebase/screens/login_screen.dart';
import 'package:todo_list_firebase/screens/register_screen.dart';
import 'package:todo_list_firebase/screens/tarefas_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider<ThemeProvider>(create: (context) => ThemeProvider(),
    child: TodoListApp(),)
    );
}

class TodoListApp extends StatelessWidget {
  const TodoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Lista de tarefas',
      initialRoute: "/auth",
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeProvider.currentTheme,
      routes: {
        '/auth': (context) => AuthenticationScreen(),
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginScreen(),
        '/tarefas': (context) => TarefasScreen(),
      },
    );
  }
}