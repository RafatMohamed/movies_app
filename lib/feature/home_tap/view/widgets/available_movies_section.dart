import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_assets.dart';
import 'package:movies_app/core/widgets/custom_movie_card.dart';
import 'package:movies_app/models/film_model.dart';

class AvailableMoviesSection extends StatefulWidget {
  const AvailableMoviesSection({super.key});

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
        CarouselSlider.builder(
          options: CarouselOptions(
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
      ],
    );
  }
}
