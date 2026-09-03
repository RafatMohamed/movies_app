import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_border_radius.dart';
import 'package:movies_app/core/utilities/app_colors.dart';

class AuthInputTheme extends StatelessWidget {
  const AuthInputTheme({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppBorderRadius.r16);

    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(color: AppColors.white),
          border: OutlineInputBorder(borderRadius: radius, borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderRadius: radius, borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderRadius: radius, borderSide: BorderSide.none),
          errorBorder: OutlineInputBorder(
            borderRadius: radius,
            borderSide: const BorderSide(color: AppColors.red),
          ),
        ),
      ),
      child: child,
    );
  }
}
