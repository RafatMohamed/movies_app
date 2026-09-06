import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:movies_app/core/widgets/custom_movie_card.dart';
import '../../../../core/models/movie_list_model.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key, required this.movies});
  final List<MovieListItemModel> movies;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: .zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .7,
        crossAxisSpacing: AppPadding.p20,
        mainAxisSpacing: AppPadding.p16,
      ),
      itemCount: movies.length,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return CustomMovieCard(
          pathImage: movies[index].largeCoverImage,
          rate: movies[index].rating.toString(),
          movieId: movies[index].id,
        );
      },
    );
  }
}
