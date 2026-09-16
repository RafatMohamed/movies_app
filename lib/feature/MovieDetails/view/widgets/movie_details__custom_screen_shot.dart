import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_border_radius.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:movies_app/core/utilities/app_them.dart';
import 'package:movies_app/l10n/generated/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

import '../../model/model_name/movie_details_model.dart';

class CustomMovieDetailsScreenShot extends StatelessWidget {
  const CustomMovieDetailsScreenShot({super.key, required this.movie});
  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    final List<String> screenShotImages = [
      movie.largeScreenshotImage1,
      movie.largeScreenshotImage2,
      movie.largeScreenshotImage3,
    ];
    bool getPathIsEmpty() {
      for (int i = 0; i < screenShotImages.length; i++) {
        if (screenShotImages[i].isEmpty) {
          return false;
        }
      }
      return true;
    }

    final TextTheme textTheme = Theme.of(context).textTheme;
    return Visibility(
      visible: getPathIsEmpty(),
      child: Column(
        crossAxisAlignment: .start,
        spacing: AppPadding.p10,
        children: [
          Text(
            AppLocalizations.of(context).screen_shots,
            style: textTheme.labelMedium,
          ),
          ...List.generate(screenShotImages.length, (index) {
            return DefaultScreenShotImage(pathImage: screenShotImages[index]);
          }),
        ],
      ),
    );
  }
}

class DefaultScreenShotImage extends StatelessWidget {
  const DefaultScreenShotImage({super.key, required this.pathImage});
  final String pathImage;
  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    return CachedNetworkImage(
      errorWidget: (context, url, error) => const SizedBox(),
      placeholder: (context, url) => SizedBox(
        height: height * 0.2,
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: double.infinity,
            height: height * 0.2,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      imageUrl: pathImage,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height * 0.2,
        decoration: BoxDecoration(
          color: AppColors.lightBlack,
          borderRadius: BorderRadius.circular(AppBorderRadius.r16),
          image: DecorationImage(image: imageProvider, fit: .fill),
        ),
      ),
    );
  }

  Widget errorMsg(String msg, double height) {
    return Container(
      width: double.infinity,
      height: height * 0.2,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 40, color: Colors.grey.shade500),
          const SizedBox(height: 8),
          Text(
            msg,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
