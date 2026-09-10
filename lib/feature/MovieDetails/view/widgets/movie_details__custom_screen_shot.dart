import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_border_radius.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:movies_app/core/utilities/app_them.dart';
import 'package:movies_app/l10n/generated/app_localizations.dart';

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
          Text(AppLocalizations.of(context).screen_shots, style: textTheme.labelMedium),
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
    return Container(
      width: width,
      height: height * 0.2,
      decoration: BoxDecoration(
        color: AppColors.lightBlack,
        borderRadius: BorderRadius.circular(AppBorderRadius.r16),
        image: DecorationImage(image: NetworkImage(pathImage), fit: .fill),
      ),
    );
  }
}
