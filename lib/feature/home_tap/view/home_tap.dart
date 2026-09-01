import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/feature/home_tap/view/widgets/available_movies_section.dart';
import 'package:movies_app/feature/home_tap/view/widgets/watching_now_section.dart';
import 'package:movies_app/models/film_model.dart';

class HomeTap extends StatefulWidget {
  const HomeTap({super.key});

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  int currentIndex = 0;

  final filmList = FilmModel.filmList;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(filmList[currentIndex].image),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.deepBlack.withValues(alpha: 0.8),
                  AppColors.deepBlack.withValues(alpha: 0.6),
                  AppColors.deepBlack.withValues(alpha: 1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [const AvailableMoviesSection(), WatchingNowSection()],
            ),
          ),
        ],
      ),
    );
  }
}
