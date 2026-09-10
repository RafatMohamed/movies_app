import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_border_radius.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_padding.dart';

import '../../../../l10n/generated/app_localizations.dart';

class CustomMovieDetailsGenres extends StatelessWidget {
  const CustomMovieDetailsGenres({super.key, required this.genres});
  final List<String> genres;
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: .start,
      spacing: AppPadding.p10,
      children: [
        Text(AppLocalizations.of(context).genres, style: textTheme.labelMedium),
        GridView.builder(
          padding: .zero,
          itemCount: genres.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2,
            crossAxisSpacing: AppPadding.p20,
            mainAxisSpacing: AppPadding.p16,
          ),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return DefaultBuildCardGenres(typeGenres: genres[index]);
          },
        ),
      ],
    );
  }
}

class DefaultBuildCardGenres extends StatelessWidget {
  const DefaultBuildCardGenres({super.key, required this.typeGenres});
  final String typeGenres;
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsetsDirectional.all(AppPadding.p10),
      decoration: BoxDecoration(
        color: AppColors.lightBlack,
        borderRadius: BorderRadius.circular(AppBorderRadius.r12),
      ),
      alignment: .center,
      child: Text(
        typeGenres,
        style: textTheme.titleLarge?.copyWith(
          color: AppColors.white,
          fontWeight: .w400,
        ),
        maxLines: 1,
        overflow: .ellipsis,
      ),
    );
  }
}
