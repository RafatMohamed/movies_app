import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_assets.dart';
import 'package:movies_app/core/utilities/app_border_radius.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:movies_app/core/utilities/app_them.dart';
import 'package:svg_flutter/svg.dart';

class CustomMovieDetailsImage extends StatelessWidget {
  const CustomMovieDetailsImage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: width,
      height: height * 0.8,
      child: Stack(
        alignment: .center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadiusGeometry.directional(
              bottomStart: Radius.circular(AppBorderRadius.r16),
              bottomEnd:  Radius.circular(AppBorderRadius.r16),
            ),
            child: Image.asset(
              "assets/images/png/onBoarding1.png",
              fit: .fill,
              width: width,
              height: height * 0.8,
            ),
          ),
          const Positioned(
            left: AppPadding.p16,
            right: AppPadding.p16,
            top: AppPadding.p32,
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                DefaultIconDetails(pathIcon: AppAssets.arrowBackDetails),
                DefaultIconDetails(pathIcon: AppAssets.archiveSvg),
              ],
            ),
          ),
           Image.asset(
            AppAssets.watchPlaying,
            width: width * 0.25,
            fit: .scaleDown,
          ),
          Positioned(
            left: AppPadding.p16,
            right: AppPadding.p16,
            bottom: AppPadding.p8,
            child: Column(
              mainAxisAlignment: .center,
              children: [
                Text(
                  "Doctor Strange in the Multiverse of Madness",
                  style: textTheme.labelMedium,
                  textAlign: .center,
                ),
                 Text(
                  "2020",
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
