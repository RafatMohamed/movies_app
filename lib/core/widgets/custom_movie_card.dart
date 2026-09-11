import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_text.dart';
import 'package:movies_app/core/widgets/movie_card_shemmer.dart';
import '../utilities/app_assets.dart';
import '../utilities/app_border_radius.dart';
import '../utilities/app_padding.dart';
import '../utilities/app_them.dart';

class CustomMovieCard extends StatelessWidget {
  const CustomMovieCard({
    super.key,
    required this.pathImage,
    required this.rate,
    this.movieId = 600,
    this.refresh
  });
  final String pathImage;
  final String rate;
  final int movieId;
  final Function()? refresh;
  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () async{
       final result = await Navigator.pushNamed(
          context,
          AppOnRouteText.detailsMoviesName,
          arguments: movieId,
        );
       if(result ==true && context.mounted){
         return refresh?.call();
       }
      },
      child: Stack(
        alignment: .topStart,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(AppBorderRadius.r16),
            child: CachedNetworkImage(
              imageUrl: pathImage,
              fit: .cover,
              width: width,
              height: .infinity,
              progressIndicatorBuilder: (context, url, progress) {
                return const MovieCardShimmer();
              },
              errorWidget: (context, url, error) => const Placeholder(),
            ),
          ),
          Positioned.directional(
            textDirection: Directionality.of(context),
            start: AppPadding.p8,
            top: AppPadding.p8,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppBorderRadius.r8),
                color: AppColors.deepBlack.withValues(alpha: 0.7),
              ),
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: AppPadding.p8,
                vertical: AppPadding.p4,
              ),
              child: Row(
                mainAxisSize: .min,
                children: [
                  Text(
                    rate,
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: .w400,
                      color: AppColors.white,
                    ),
                  ),
                  const Gap(AppPadding.p8),
                  SvgPicture.asset(
                    AppAssets.starIcon,
                    colorFilter: const ColorFilter.mode(AppColors.gold, .srcIn),
                    fit: .scaleDown,
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}