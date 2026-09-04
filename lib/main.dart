import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movies_app/core/ChachRemote/is_first_open_app.dart';
import 'package:movies_app/core/utilities/app_locale_controller.dart';
import 'package:movies_app/core/utilities/app_text.dart';
import 'package:movies_app/feature/MainHomeAppView/view/main_app_view.dart';
import 'package:movies_app/feature/MovieDetails/view/movie_details_view.dart';
import 'package:movies_app/feature/Onboarding/view/onboarding_view.dart';
import 'package:movies_app/feature/Splash/view/splash_view.dart';
import 'package:movies_app/feature/forget_password/view/forget_password_view.dart';
import 'package:movies_app/feature/login/view/login_view.dart';
import 'package:movies_app/feature/register/view/register_view.dart';
import 'core/utilities/app_them.dart';
import 'feature/Onboarding/view/starting_view.dart';
import 'feature/update_profile/view/update_profile_view.dart';
import 'l10n/generated/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsFirstOpenApp.initSharedStorge();
  await AppLocaleController.initialize();
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

    return ValueListenableBuilder<Locale>(
      valueListenable: AppLocaleController.instance,
      builder: (context, locale, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          locale: locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocaleController.supportedLocales,

          builder: DevicePreview.appBuilder,

          darkTheme: AppThem.darkThem,

          themeMode: .dark,

          routes: routeApp,

          initialRoute: IsFirstOpenApp.getIsFirstOpen()
              ? AppOnRouteText.mainAppName
              : AppOnRouteText.startingViewAppName,
          //home: AppOnRouteText.mainAppName,
          //  home: ProfileTab(),
        );
      },
    );
  }
}
