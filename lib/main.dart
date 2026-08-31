import 'package:flutter/material.dart';
import 'package:movies_app/feature/Onboarding/view/starting_view.dart';
import 'package:movies_app/feature/Splash/view/splash_view.dart';
import 'core/utilities/app_them.dart';
import 'feature/MainHomeAppView/view/main_app_view.dart';

void main() {
  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: AppThem.darkThem,
      themeMode: .dark,
      home: const SplashView(),
    );
  }
}
