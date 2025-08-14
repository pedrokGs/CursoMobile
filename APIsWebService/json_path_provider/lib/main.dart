import 'package:flutter/material.dart';
import 'package:json_path_provider/providers/produto_provider.dart';
import 'package:json_path_provider/providers/theme_provider.dart';
import 'package:json_path_provider/theme/app_colors.dart';
import 'package:json_path_provider/theme/app_text_themes.dart';
import 'package:json_path_provider/views/produto_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeProvider()), ChangeNotifierProvider(create: (_) => ProdutoProvider())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;

    return MaterialApp(
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder()},
        ),
        textTheme: TextTheme(
          headlineLarge: AppTextThemes.headingLarge,
          headlineMedium: AppTextThemes.headingMedium,
          bodyLarge: AppTextThemes.bodyLarge,
          bodyMedium: AppTextThemes.bodyMedium,
          bodySmall: AppTextThemes.bodySmall,
        ),
        colorScheme: AppColors.getColorScheme(false),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        textTheme: TextTheme(
          headlineLarge: AppTextThemes.headingLarge,
          headlineMedium: AppTextThemes.headingMedium,
          bodyLarge: AppTextThemes.bodyLarge,
          bodyMedium: AppTextThemes.bodyMedium,
          bodySmall: AppTextThemes.bodySmall,
        ),
        colorScheme: AppColors.getColorScheme(true),
        useMaterial3: true,
      ),
      themeMode: themeProvider.themeMode,
      initialRoute: "/",
      routes: {"/": (context) => ProdutoScreen()},
    );
  }
}
