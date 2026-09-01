import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_text.dart';
import 'package:movies_app/feature/MainHomeAppView/view/main_app_view.dart';
import 'package:movies_app/feature/MovieDetails/view/movie_details_view.dart';
import 'package:movies_app/feature/Onboarding/view/onboarding_view.dart';
import 'package:movies_app/feature/Splash/view/splash_view.dart';
import 'package:movies_app/feature/forget_password/view/forget_password_view.dart';
import 'package:movies_app/feature/login/view/login_view.dart';
import 'package:movies_app/feature/profile/view/update_profile_view.dart';
import 'package:movies_app/feature/register/view/register_view.dart';
import 'core/utilities/app_them.dart';
import 'feature/Onboarding/view/starting_view.dart';

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
    Map<String, WidgetBuilder> routeApp = {
      AppOnRouteText.splashName: (context) => const SplashView(),
      AppOnRouteText.startingViewAppName: (context) => const StartingView(),
      AppOnRouteText.onBoardingName: (context) => const OnboardingView(),
      AppOnRouteText.loginName: (context) => const LoginView(),
      AppOnRouteText.registerName: (context) => const RegisterView(),
      AppOnRouteText.forgetPasswordName: (context) =>
          const ForgetPasswordView(),
      AppOnRouteText.updateProfileName: (context) => const UpdateProfileView(),
      AppOnRouteText.mainAppName: (context) => const MainAppView(),
      AppOnRouteText.detailsMoviesName: (context) => const MovieDetailsView(),
    };

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      locale: DevicePreview.locale(context),

      builder: DevicePreview.appBuilder,

      darkTheme: AppThem.darkThem,

      themeMode: .dark,

      routes: routeApp,

      initialRoute: AppOnRouteText.loginName,
      //home: AppOnRouteText.mainAppName,
      //  home: ProfileTab(),
    );
  }
}
