import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_service_clima/providers/clima_provider.dart';
import 'package:web_service_clima/providers/theme_provider.dart';
import 'package:web_service_clima/screens/main_screen.dart';
import 'package:web_service_clima/themes/app_colors.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeProvider()), ChangeNotifierProvider(create: (_) => ClimaProvider())],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;
    return MaterialApp(
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder()},
        ),
        colorScheme: AppColors.getColorScheme(isDark),
      ),
      darkTheme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder()},
        ),
        colorScheme: AppColors.getColorScheme(isDark),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      themeMode: themeProvider.themeMode,
      routes: {"/": (context) => MainScreen()},
    );
  }
}
