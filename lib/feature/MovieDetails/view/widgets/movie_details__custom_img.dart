import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              fit: .cover,
              width: width,
              height: height * 0.8,
              placeholder: (_, _) {
                return const MovieCardShimmer();
              },
              errorWidget: (context, url, error) =>
                  const Icon(Icons.image_not_supported),
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
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 24,
                    width: 24,
                    color: Colors.transparent,
                    alignment: .centerStart,
                    child: DefaultIconDetails(
                      pathIcon: !isAr
                          ? AppAssets.arrowBackDetails
                          : AppAssets.arrowBackAr,
                    ),
                  ),
                ),
                const DefaultIconDetails(pathIcon: AppAssets.archiveSvg),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async{
              try {
                await BlocProvider.of<MovieDetailsCubit>(
                  context,
                  listen: false,
                ).launchMovie(
                  url: movie.ytTrailerCode,
                );
              } catch (error) {
                if(!context.mounted)return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds:2),
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
    return SvgPicture.asset(
      pathIcon,
      colorFilter: const ColorFilter.mode(AppColors.white, .srcIn),
      fit: .scaleDown,
      width: 24,
      height: 24,
    );
  }
}
