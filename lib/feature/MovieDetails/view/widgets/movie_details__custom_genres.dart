import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_border_radius.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_padding.dart';

class CustomMovieDetailsGenres extends StatelessWidget {
  const CustomMovieDetailsGenres({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> genresType =[
      "Action",
      "Horror",
      "Adventure",
      "Sci-Fi",
      "Fantasy",
      "Action",
      "Horror",
    ];
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: .start,
      spacing: AppPadding.p10,
      children: [
        Text("Genres", style: textTheme.labelMedium),
        GridView.builder(
          padding: .zero,
          itemCount: genresType.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2,
            crossAxisSpacing: AppPadding.p20,
            mainAxisSpacing: AppPadding.p16,
          ),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return DefaultBuildCardGenres(
              typeGenres: genresType[index],
            );
          },
        ),
      ],
    );
  }
}

class DefaultBuildCardGenres extends StatelessWidget {
  const DefaultBuildCardGenres({
    super.key, required this.typeGenres,
  });
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
          fontWeight: .w400
        ),
        maxLines: 1,
        overflow: .ellipsis,
      ),
    );
  }
}
