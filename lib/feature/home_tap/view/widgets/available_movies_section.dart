import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_assets.dart';
import 'package:movies_app/core/widgets/custom_movie_card.dart';
import 'package:movies_app/models/film_model.dart';

class AvailableMoviesSection extends StatelessWidget {
  final List<FilmModel> movies = FilmModel.FilmList;

  CarouselSliderController controller = CarouselSliderController();
  @override
  Widget build(BuildContext context) {
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
