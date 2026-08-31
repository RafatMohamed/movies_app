import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/feature/Splash/view/widgets/splash_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.deepBlack,
      body: Center(child: SplashViewBody()),
    );
  }
}
