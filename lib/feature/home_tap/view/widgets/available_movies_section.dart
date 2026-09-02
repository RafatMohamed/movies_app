import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_assets.dart';
import 'package:movies_app/core/widgets/custom_movie_card.dart';
import 'package:movies_app/core/widgets/movie_card_shemmer.dart';
import '../../../../core/models/film_model.dart';

// ignore: must_be_immutable
class AvailableMoviesSection extends StatefulWidget {
  void Function(int index) onPageChanged;
  AvailableMoviesSection({required this.onPageChanged, super.key});

  @override
  State<AvailableMoviesSection> createState() => _AvailableMoviesSectionState();
}

class _AvailableMoviesSectionState extends State<AvailableMoviesSection> {
  late final CarouselSliderController controller;
  @override
  void initState() {
    controller = CarouselSliderController();
    super.initState();
  }

  @override
  void dispose() {
    controller.stopAutoPlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<FilmModel> movies = FilmModel.filmList;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppAssets.availableNowImage, width: 200, height: 300),
            ],
          ),
        ),
        if (movies.isNotEmpty)
          CarouselSlider.builder(
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                widget.onPageChanged.call(index);
              },
              enableInfiniteScroll: true,
              height: MediaQuery.of(context).size.height * .40,
              viewportFraction: 0.55,
              enlargeCenterPage: true,
            ),
            carouselController: controller,
            itemCount: movies.length,
            itemBuilder: (_, index, _) => CustomMovieCard(
              pathImage: movies[index].image,
              rate: movies[index].rate,
            ),
          ),
        if (movies.isEmpty)
          CarouselSlider.builder(
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                widget.onPageChanged.call(index);
              },
              enableInfiniteScroll: true,
              height: MediaQuery.of(context).size.height * .40,
              viewportFraction: 0.55,
              enlargeCenterPage: true,
            ),
            carouselController: controller,
            itemCount: 5,
            itemBuilder: (_, index, _) => const MovieCardShimmer(),
          ),
      ],
    );
  }
}
