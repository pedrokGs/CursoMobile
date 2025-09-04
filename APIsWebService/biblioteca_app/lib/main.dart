import 'package:biblioteca_app/providers/book_provider.dart';
import 'package:biblioteca_app/providers/theme_provider.dart';
import 'package:biblioteca_app/screens/main_screen.dart';
import 'package:biblioteca_app/themes/app_colors.dart';
import 'package:biblioteca_app/themes/app_text_themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ChangeNotifierProvider(create: (_) => BookProvider()),
  ], child: BibliotecaApp(),)
  
  );
}

class BibliotecaApp extends StatelessWidget {
  const BibliotecaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = _themeProvider.themeMode == ThemeMode.dark;

    return MaterialApp(
      theme: ThemeData(colorScheme: AppColors.getColorScheme(isDark), textTheme: AppTextThemes.getTextTheme()),
      darkTheme: ThemeData(colorScheme: AppColors.getColorScheme(isDark), textTheme: AppTextThemes.getTextTheme()),
      themeMode: _themeProvider.themeMode,
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => MainScreen(),
      },
    );
  }
}
