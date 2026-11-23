import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/cubit/watch_list_cubit/watch_list_cubit/watch_list_cubit.dart';
import 'package:movies_app/core/utilities/app_assets.dart';
import 'package:movies_app/core/utilities/app_border_radius.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_locale_controller.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:movies_app/core/utilities/app_them.dart';
import 'package:movies_app/core/widgets/movie_card_shemmer.dart';
import 'package:movies_app/feature/MovieDetails/model/model_name/movie_details_model.dart';
import 'package:movies_app/feature/MovieDetails/view_model/state_mangment.dart';
import 'package:svg_flutter/svg.dart';

class CustomMovieDetailsImage extends StatelessWidget {
  const CustomMovieDetailsImage({super.key, required this.movie});
  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool isAr = AppLocaleController.instance.value.languageCode == "ar";
    return SizedBox(
      width: width,
      height: height * 0.8,
      child: Stack(
        alignment: .center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadiusGeometry.directional(
              bottomStart: Radius.circular(AppBorderRadius.r16),
              bottomEnd: Radius.circular(AppBorderRadius.r16),
            ),
            child: CachedNetworkImage(
              imageUrl: movie.largeCoverImage,
              width: width,
              height: height * 0.8,
              placeholder: (_, _) => const MovieCardShimmer(),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.image_not_supported),
              imageBuilder: (context, imageProvider) => Stack(
                fit: StackFit.expand,
                children: [
                  Image(image: imageProvider, fit: BoxFit.cover),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.3),
                          Colors.black.withValues(alpha: 0.85),
                        ],
                        stops: const [0.3, 0.65, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: AppPadding.p16,
            right: AppPadding.p16,
            top: AppPadding.p32,
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context, true);
                  },
                  child: DefaultIconDetails(
                    pathIcon: !isAr
                        ? AppAssets.arrowBackDetails
                        : AppAssets.arrowBackAr,
                  ),
                ),
                BlocListener<WatchMovieToggleCubit, WatchMovieToggleState>(
                  listener: (context, state) {
                    if (state is MovieToggleFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 2),
                          dismissDirection: .horizontal,
                          behavior: .floating,
                          width: double.infinity,
                          padding: const EdgeInsetsDirectional.only(
                            bottom: AppPadding.p20,
                          ),
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              state.errorMessage,
                              textAlign: .center,
                              style: textTheme.labelMedium,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  child: GestureDetector(
                    onTap: () {
                      context.read<WatchMovieToggleCubit>().toggleWatched(
                        movie: movie,
                      );
                    },
                    child: DefaultIconDetails(
                      pathIcon:
                          context.watch<WatchMovieToggleCubit>().isInWatched
                          ? AppAssets.archiveSvg
                          : AppAssets.watchListIConSvg,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              try {
                await BlocProvider.of<MovieDetailsCubit>(
                  context,
                  listen: false,
                ).launchMovie(
                  url: "https://www.youtube.com/watch?v=${movie.ytTrailerCode}",
                );
              } catch (error) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 2),
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
            child: Image.asset(
              AppAssets.watchPlaying,
              width: width * 0.25,
              fit: .scaleDown,
            ),
          ),
          Positioned(
            left: AppPadding.p16,
            right: AppPadding.p16,
            bottom: AppPadding.p8,
            child: Column(
              mainAxisAlignment: .center,
              children: [
                Text(
                  movie.titleEnglish,
                  style: textTheme.labelMedium,
                  textAlign: .center,
                  maxLines: 2,
                  overflow: .ellipsis,
                ),
                Text(
                  movie.year.toString(),
                  style: textTheme.labelSmall?.copyWith(
                    fontWeight: .bold,
                    color: const Color(0xffADADAD),
                  ),
                  textAlign: .center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DefaultIconDetails extends StatelessWidget {
  const DefaultIconDetails({super.key, required this.pathIcon});
  final String pathIcon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: SvgPicture.asset(
        pathIcon,
        colorFilter: const ColorFilter.mode(AppColors.white, .srcIn),
        fit: .scaleDown,
        width: 24,
        height: 24,
      ),
    );
  }
}
