import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_padding.dart';

class CustomMovieDetailsSummary extends StatelessWidget {
  const CustomMovieDetailsSummary({super.key, required this.summary});
  final String summary;
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: .start,
      spacing: AppPadding.p10,
      children: [
        Text("Summary", style: textTheme.labelMedium),
        Text(
          summary,
          style: textTheme.titleLarge?.copyWith(
            color: AppColors.white,
            fontWeight: .w400,
          ),
          textAlign: .start,
        ),
      ],
    );
  }
}
