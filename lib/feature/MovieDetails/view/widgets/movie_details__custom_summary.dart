import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:movies_app/feature/MovieDetails/view/widgets/custom_read_more_text.dart';
import '../../../../l10n/generated/app_localizations.dart';

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
        Text(
          AppLocalizations.of(context).summary,
          style: textTheme.labelMedium,
        ),
        CustomReadMoreTextTranslate(text: summary),
      ],
    );
  }
}
