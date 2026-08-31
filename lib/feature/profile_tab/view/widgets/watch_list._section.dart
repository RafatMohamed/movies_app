import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_assets.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/widgets/custom_movie_card.dart';
import 'package:movies_app/models/film_model.dart';
import 'package:movies_app/core/utilities/app_padding.dart';

class WatchListSection extends StatelessWidget {
  WatchListSection({super.key});
  List<FilmModel> watchedList = FilmModel.FilmList;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.deepBlack,
      child: watchedList.isEmpty
          ? Center(child: Image.asset(AppAssets.emptyMoviesImage))
          : GridView.builder(
              padding: const EdgeInsets.all(AppPadding.p16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                mainAxisExtent: MediaQuery.sizeOf(context).height * .22,
              ),
              itemCount: watchedList.length,
              itemBuilder: (_, index) => CustomMovieCard(
                pathImage: watchedList[index].image,
                rate: watchedList[index].rate,
              ),
            ),
    );
  }
}
