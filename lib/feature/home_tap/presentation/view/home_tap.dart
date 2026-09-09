import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/widgets/movie_card_shemmer.dart';
import 'package:movies_app/feature/home_tap/presentation/view/widgets/available_movies_section.dart';
import 'package:movies_app/feature/home_tap/presentation/view/widgets/watching_now_section.dart';
import 'package:movies_app/feature/home_tap/presentation/view_model/home_tab_cubit.dart';
import 'package:movies_app/feature/home_tap/presentation/view_model/home_tab_state.dart';

// ignore: must_be_immutable
class HomeTap extends StatefulWidget {
  void Function(int index) onSeeMoreClicked;
  HomeTap({required this.onSeeMoreClicked, super.key});

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  late int currentIndex;
  @override
  void initState() {
    currentIndex = 0;
    context.read<HomeTabCubit>().getMoviesFirstPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          BlocBuilder<HomeTabCubit, HomeTabState>(
            builder: (context, state) {
              if (state is HomeTabLoading) {
                return const MovieCardShimmer(height: .infinity);
              }

              if (state is HomeTabLoaded) {
                return CachedNetworkImage(
                  imageUrl: state.movies[currentIndex].largeCoverImage ?? '',
                  imageBuilder: (_, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  progressIndicatorBuilder: (context, url, progress) =>
                      const MovieCardShimmer(),
                  errorWidget: (context, url, error) => const SizedBox(),
                );
              }
              if (state is HomeTabEror) {
                return Container(color: Colors.transparent);
              }
              return const SizedBox();
            },
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
              children: [
                AvailableMoviesSection(onPageChanged: updateCurrentIndex),
                WatchingNowSection(onSeeMoreClicked: widget.onSeeMoreClicked),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void updateCurrentIndex(int index) {
    currentIndex = index;
    setState(() {});
  }
}
