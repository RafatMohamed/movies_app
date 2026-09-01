import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/feature/Onboarding/view/starting_view.dart';
import 'package:movies_app/feature/Splash/view/splash_view.dart';
import 'package:movies_app/feature/MovieDetails/view/movie_details_view.dart';
import 'core/utilities/app_them.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) {
        return const MoviesApp();
      },
    ),
  );
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      locale: DevicePreview.locale(context),

      builder: DevicePreview.appBuilder,

      darkTheme: AppThem.darkThem,
      themeMode: .dark,
      home: const SplashView(),
      home: const MovieDetailsView(),
      //home: const MainView(),
      //  home: ProfileTab(),
    );
  }
}
