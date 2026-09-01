import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:movies_app/core/utilities/app_them.dart';
import 'package:movies_app/core/widgets/custom_button_app.dart';
import 'movie_details__custom_cast.dart';
import 'movie_details__custom_genres.dart';
import 'movie_details__custom_img.dart';
import 'movie_details__custom_info_popular.dart';
import 'movie_details__custom_screen_shot.dart';
import 'movie_details__custom_similar.dart';
import 'movie_details__custom_summary.dart';

class MovieDetailsViewBody extends StatelessWidget {
  const MovieDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final height =context.height;
    return Column(
      spacing: height*(AppPadding.p16/height),
      children: [
       const CustomMovieDetailsImage(),
        Padding(
          padding:const  EdgeInsetsDirectional.symmetric(
            horizontal: AppPadding.p16
          ),
          child: Column(
            spacing: height*(AppPadding.p16/height),
            children: [
              CustomButtonApp(onTap: () {}, text: "watch", background: AppColors.red),
              const CustomMovieDetailsInfoPopular(),
              const Gap(AppPadding.p16),
              const CustomMovieDetailsScreenShot(),
              const Gap(AppPadding.p16),
              const CustomMovieDetailsSimilar(),
              const Gap(AppPadding.p16),
              const CustomMovieDetailsSummary(),
              const Gap(AppPadding.p16),
              const CustomMovieDetailsCast(),
              const Gap(AppPadding.p16),
              const CustomMovieDetailsGenres(),
              const Gap(AppPadding.p16),
            ],
          ),
        )
      ],
    );
  }
}
