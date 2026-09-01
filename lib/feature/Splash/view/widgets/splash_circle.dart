import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_colors.dart';

class SplashCircle extends StatelessWidget {
  const SplashCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        border: Border(
          top: BorderSide(width: 4, color: AppColors.gold),
          left: BorderSide(width: 4, color: AppColors.gold),
          right: BorderSide(width: 4, color: AppColors.gold),
          bottom: BorderSide(width: 4, color: AppColors.gold),
        ),
      ),
    );
  }
}
