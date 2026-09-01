import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_assets.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/widgets/custom_movie_card.dart';
import 'package:movies_app/models/film_model.dart';
import 'package:movies_app/core/utilities/app_padding.dart';

class HistoryListSection extends StatelessWidget {
  const HistoryListSection({super.key,});
  @override
  Widget build(BuildContext context) {
    final List<FilmModel> historyList = [];
    return Container(
      color: AppColors.deepBlack,
      child: historyList.isEmpty
          ? Center(child: Image.asset(AppAssets.emptyMoviesImage))
          : GridView.builder(
              padding: const EdgeInsets.all(AppPadding.p16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                mainAxisExtent: MediaQuery.sizeOf(context).height * .22,
              ),
              itemCount: historyList.length,
              itemBuilder: (_, index) => CustomMovieCard(
                pathImage: historyList[index].image,
                rate: historyList[index].rate,
              ),
            ),
    );
  }
}
