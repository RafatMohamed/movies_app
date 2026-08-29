import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:movies_app/core/widgets/custom_movie_card.dart';

class CustomMovieDetailsSimilar extends StatelessWidget {
  const CustomMovieDetailsSimilar({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: .start,
      spacing: AppPadding.p10,
      children: [
        Text("Similar", style: textTheme.labelMedium),
        GridView.builder(
          padding: .zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: .7,
            crossAxisSpacing: AppPadding.p20,
            mainAxisSpacing: AppPadding.p16,
          ),
          itemCount: 4,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return const CustomMovieCard(
              pathImage: "assets/images/png/onBoarding1.png",
              rate: "5",
            );
          },
        ),
      ],
    );
  }
}
