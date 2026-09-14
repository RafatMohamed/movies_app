import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:movies_app/core/widgets/custom_movie_card.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../model/model_name/movie_suggestion_model.dart';

class CustomMovieDetailsSimilar extends StatelessWidget {
  const CustomMovieDetailsSimilar({super.key, required this.moviesSuggestion});
  final List<MovieSuggestionItem> moviesSuggestion;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: .start,
      spacing: AppPadding.p10,
      children: [
        Text(
          AppLocalizations.of(context).similar,
          style: textTheme.labelMedium,
        ),
        GridView.builder(
          padding: .zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: .7,
            crossAxisSpacing: AppPadding.p20,
            mainAxisSpacing: AppPadding.p16,
          ),
          itemCount: moviesSuggestion.length,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final MovieSuggestionItem movieItem = moviesSuggestion[index];
            return CustomMovieCard(
              movieId: movieItem.id,
              pathImage: movieItem.mediumCoverImage,
              rate: movieItem.rating.toString(),
            );
          },
        ),
      ],
    );
  }
}
