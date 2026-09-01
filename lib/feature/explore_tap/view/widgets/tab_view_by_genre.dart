import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:movies_app/core/widgets/custom_movie_card.dart';
import 'package:movies_app/models/film_model.dart';

class TabViewByGenre extends StatelessWidget {
 final String genere;
  const TabViewByGenre({super.key, required this.genere});
  @override
  Widget build(BuildContext context) {
    final List<FilmModel> filmList = FilmModel.filmList;
    return GridView.builder(
      itemCount: filmList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: MediaQuery.sizeOf(context).height * .33,
        crossAxisCount: 2,
        crossAxisSpacing: AppPadding.p20,
        mainAxisSpacing: AppPadding.p8,
      ),
      itemBuilder: (_, index) => CustomMovieCard(
        pathImage: filmList[index].image,
        rate: filmList[index].rate,
      ),
    );
  }
}
