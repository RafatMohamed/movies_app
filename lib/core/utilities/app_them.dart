import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_colors.dart';

class AppThem {
  // static ThemeData lightThem = ThemeData();
  static ThemeData darkThem = ThemeData(
    scaffoldBackgroundColor: AppColors.deepBlack,
    fontFamily: "Roboto",
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.gold,
      selectionColor: AppColors.gold,
      selectionHandleColor: AppColors.gold,
    ),
    textTheme: const TextTheme(
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
      bodyMedium: TextStyle(
        fontSize: 18,
        fontWeight: .normal,
        color: AppColors.white,
      ),

      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: .w600,
        color: AppColors.deepBlack,
      ),
      titleMedium: TextStyle(
        fontSize: 15,
        fontWeight: .w400,
        color: AppColors.gold,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: .w400,
        color: AppColors.gold,
      ),
    ),
  );
}

extension ScreenUtilsContext on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;
}
