import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:movies_app/core/utilities/app_assets.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:movies_app/core/widgets/custom_movie_card.dart';
import 'package:movies_app/core/widgets/movie_card_shemmer.dart';
import '../../../../core/models/film_model.dart';
import 'package:movies_app/l10n/generated/app_localizations.dart';
import 'package:movies_app/core/utilities/app_locale_controller.dart';
  
class WatchingNowSection extends StatelessWidget {
  final List<FilmModel> movies = FilmModel.filmList;
  final void Function(int index) onSeeMoreClicked;

  WatchingNowSection({required this.onSeeMoreClicked, super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.127,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Image.asset(AppAssets.watchNowImage, fit: BoxFit.cover)],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            vertical: 12,
            horizontal: AppPadding.p16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                                 Text(
                      AppLocalizations.of(context)!.seeMore,
                      style: textTheme.titleLarge?.copyWith(
                  color: AppColors.white,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
              InkWell(
                onTap: () {
                  onSeeMoreClicked(2);
                },
                child: Row(
                  children: [
                                        Text(
                      'Action',
                      style: textTheme.titleLarge?.copyWith(
                        color: AppColors.gold,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                                        const Gap(AppPadding.p4),
                    Icon(
                      AppLocaleController.instance.value.languageCode == 'ar'
                          ? Icons.arrow_back
                          : Icons.arrow_forward,
                      size: 16,
                      color: AppColors.gold,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (movies.isNotEmpty)
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: ListView.separated(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: AppPadding.p16,
              ),
              separatorBuilder: (context, index) => const Gap(16),
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: CustomMovieCard(
                    pathImage: movies[index].image,
                    rate: movies[index].rate,
                  ),
                );
              },
            ),
          ),
        if (movies.isEmpty)
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: ListView.separated(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: AppPadding.p16,
              ),
              separatorBuilder: (context, index) => const Gap(16),
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: const MovieCardShimmer(),
                );
              },
            ),
          ),

        const Gap(16),
      ],
    );
  }
}
