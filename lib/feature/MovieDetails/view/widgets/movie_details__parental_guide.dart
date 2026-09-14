import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:movies_app/feature/MovieDetails/view/widgets/custom_read_more_text.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../model/model_name/parental_guide_model.dart';

class CustomMovieParentalGuide extends StatelessWidget {
  const CustomMovieParentalGuide({super.key, required this.parentalGuides});
  final List<ParentalGuideItem> parentalGuides;
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: .start,
      spacing: AppPadding.p10,
      children: [
        Text(
          AppLocalizations.of(context).parental_guide,
          style: textTheme.labelMedium,
        ),
        ...List.generate(parentalGuides.length, (index) {
          return ListTile(
            titleTextStyle: textTheme.titleLarge?.copyWith(
              color: AppColors.white,
              fontWeight: .w400,
            ),
            subtitleTextStyle: textTheme.titleLarge?.copyWith(
              color: AppColors.white.withValues(alpha: 0.6),
              fontWeight: .w400,
            ),
            title: CustomReadMoreTextTranslate(
              text: parentalGuides[index].parentalGuideText,
            ),
          );
        }),
      ],
    );
  }
}
