import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:movies_app/core/utilities/app_them.dart';
import 'package:movies_app/core/widgets/custom_button_app.dart';
import 'package:movies_app/feature/MovieDetails/model/model_name/movie_details_model.dart';
import 'package:movies_app/feature/MovieDetails/model/model_name/parental_guide_model.dart';
import 'package:movies_app/feature/MovieDetails/view_model/movie_details_state.dart';
import 'package:movies_app/feature/MovieDetails/view_model/state_mangment.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../model/model_name/movie_suggestion_model.dart';
import 'movie_details__custom_cast.dart';
import 'movie_details__custom_genres.dart';
import 'movie_details__custom_img.dart';
import 'movie_details__custom_info_popular.dart';
import 'movie_details__custom_screen_shot.dart';
import 'movie_details__custom_similar.dart';
import 'movie_details__custom_summary.dart';
import 'movie_details__parental_guide.dart';

class MovieDetailsViewBody extends StatelessWidget {
  const MovieDetailsViewBody({super.key,});
  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
      builder: (context, state) {
        if (state is MovieDetailsLoadingState) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade800,
            highlightColor: AppColors.caviar,
            child: CustomBodyDetails(
              height: height,
              movieDetails: MovieModel.empty(),
              textTheme: textTheme,
              moviesSuggestion: const [],
              moviesGuide: const [],
            ),
          );
        }
        if (state is MovieDetailsFailerState) {
          return Center(
            child: Text(state.messageError, style: textTheme.labelMedium),
          );
        }
        if (state is MovieDetailsSuccessState) {
          final MovieModel movieDetails = state.movieDetails.data.movie;
          final List<MovieSuggestionItem> moviesSuggestion =
              state.movieSuggestion.data.movies;
          final List<ParentalGuideItem> moviesGuide =
              state.movieParentalGuide.data.parentalGuides;
          return CustomBodyDetails(
            height: height,
            movieDetails: movieDetails,
            textTheme: textTheme,
            moviesSuggestion: moviesSuggestion,
            moviesGuide: moviesGuide,
          );
        }
        return Container(color: AppColors.gold, height: 100, width: 100);
      },
    );
  }
}

class CustomBodyDetails extends StatelessWidget {
  const CustomBodyDetails({
    super.key,
    required this.height,
    required this.movieDetails,
    required this.textTheme,
    required this.moviesSuggestion,
    required this.moviesGuide,
  });

  final double height;
  final MovieModel movieDetails;
  final TextTheme textTheme;
  final List<MovieSuggestionItem> moviesSuggestion;
  final List<ParentalGuideItem> moviesGuide;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations translate = AppLocalizations.of(context);
    return Column(
      spacing: height * (AppPadding.p16 / height),
      children: [
        CustomMovieDetailsImage(movie: movieDetails),
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppPadding.p16,
          ),
          child: Column(
            spacing: height * (AppPadding.p16 / height),
            children: [
              CustomButtonApp(
                onTap: () async{
                  try {
                  await BlocProvider.of<MovieDetailsCubit>(
                      context,
                      listen: false,
                    ).launchMovie(
                      url: movieDetails.ytTrailerCode,
                    );
                  } catch (error) {
                    if(!context.mounted)return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration:const Duration(seconds:2),
                        dismissDirection: .horizontal,
                        behavior: .floating,
                        width: double.infinity,
                        padding: const EdgeInsetsDirectional.only(
                          bottom: AppPadding.p20,
                        ),
                        content: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            textAlign: .center,
                            error.toString(),
                            style: textTheme.labelMedium,
                          ),
                        ),
                      ),
                    );
                  }
                },
                text: translate.watch,
                background: AppColors.red,
                textStyle: textTheme.labelSmall,
              ),
              CustomMovieDetailsInfoPopular(movie: movieDetails),
              CustomMovieDetailsScreenShot(movie: movieDetails),
              CustomMovieDetailsSimilar(moviesSuggestion: moviesSuggestion),
              CustomMovieDetailsSummary(summary: movieDetails.descriptionFull),
              CustomMovieParentalGuide(parentalGuides: moviesGuide),
              CustomMovieDetailsCast(cast: movieDetails.cast),
              CustomMovieDetailsGenres(genres: movieDetails.genres),
            ],
          ),
        ),
      ],
    );
  }
}
