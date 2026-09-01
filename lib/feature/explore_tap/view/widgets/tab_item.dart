import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_padding.dart';

class TabItem extends StatelessWidget {
  final String genre;
 final bool isSelected;
 const TabItem({super.key, required this.genre, required this.isSelected});
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        vertical: 4,
        horizontal: AppPadding.p10,
      ),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.gold : Colors.transparent,
        borderRadius: BorderRadius.circular(AppPadding.p16),
        border: Border.all(
          color: isSelected ? Colors.transparent : AppColors.gold,
          width: 1.5,
        ),
      ),
      child: Text(
        genre,
        style: textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: isSelected ? AppColors.deepBlack : AppColors.gold,
        ),
      ),
    );
  }
}
