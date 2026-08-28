import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_colors.dart';

class AppThem {
  // static ThemeData lightThem = ThemeData();
  static ThemeData darkThem = ThemeData(
    fontFamily: "Roboto",
    textTheme: TextTheme(
      labelLarge: TextStyle(
        fontSize: 36,
        fontWeight: .w500, //medium
        color: AppColors.white,
      ),
      labelMedium: TextStyle(
        fontSize: 24,
        fontWeight: .bold,
        color: AppColors.white,
      ),
      labelSmall: TextStyle(
        fontSize: 20,
        fontWeight: .w400, //regular
        color: AppColors.white,
      ),

      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: .w600,
        color: AppColors.deepBlack
      ),
      titleMedium: TextStyle(
        fontSize: 15,
        fontWeight: .w400,
        color: AppColors.gold
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: .w400,
        color: AppColors.gold
      ),

    ),
  );
}
