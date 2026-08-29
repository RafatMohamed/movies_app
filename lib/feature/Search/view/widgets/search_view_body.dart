import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_assets.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:movies_app/core/widgets/custom_movie_card.dart';

class SearchViewBody extends StatelessWidget {
  SearchViewBody({required this.moviesResult});
  List<String>? moviesResult;
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
      itemCount: moviesResult!.length,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return CustomMovieCard(pathImage: moviesResult![index], rate: "5");
      },
    );
  }
}
