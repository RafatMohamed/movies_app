import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../app_padding.dart';

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: Center(
        child: CircularProgressIndicator(
          color: AppColors.gold,
          constraints: BoxConstraints(
            maxHeight: 30,
            maxWidth: 30,
            minWidth: 24,
            minHeight: 24,
          ),
          backgroundColor: AppColors.deepSeaBlue,
        ),
      ),
    );
  }
}
