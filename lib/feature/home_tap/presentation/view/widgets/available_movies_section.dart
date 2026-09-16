import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utilities/app_assets.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/helper/custom_error_msg.dart';
import 'package:movies_app/core/widgets/custom_movie_card.dart';
import 'package:movies_app/core/widgets/movie_card_shemmer.dart';
import 'package:movies_app/feature/home_tap/presentation/view_model/home_tab_cubit.dart';
import 'package:movies_app/feature/home_tap/presentation/view_model/home_tab_state.dart';

class AvailableMoviesSection extends StatefulWidget {
  final void Function(int index) onPageChanged;
  const AvailableMoviesSection({required this.onPageChanged, super.key});

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
    // bool isArabic= AppLocalizations.of(context).localeName=="ar";
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
        BlocConsumer<HomeTabCubit, HomeTabState>(
          buildWhen: (previous, current) => current is! SeeMorePressed,
          listener: (context, state) {
            if (state is HomeTabEror) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: AppColors.caviar,
                  content: CustomErrorBuilder(
                    errorMsg: state.messege,
                    onTapAgain: () {
                      Navigator.pop(context);
                      context.read<HomeTabCubit>().getMoviesFirstPage();
                    },
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is HomeTabLoaded) {
              return Directionality(
                textDirection: Directionality.of(context),
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                    reverse: false,
                    initialPage: 0,
                    scrollDirection: .horizontal,
                    onPageChanged: (index, reason) {
                      widget.onPageChanged.call(index);
                    },
                    enableInfiniteScroll: false,
                    height: MediaQuery.of(context).size.height * .40,
                    viewportFraction: 0.55,
                    enlargeCenterPage: true,
                  ),
                  carouselController: controller,
                  itemCount: state.movies.length,
                  itemBuilder: (_, index, _) {
                    if (index >= state.movies.length) {
                      return const SizedBox();
                    }
                    final movie = state.movies[index];
                    return CustomMovieCard(
                      movieId: movie.id ?? 0,
                      pathImage: movie.largeCoverImage ?? '',
                      rate: movie.rating?.toString() ?? '0.0',
                    );
                  },
                ),
              );
            }
            if (state is HomeTabLoading) {
              return CarouselSlider.builder(
                options: CarouselOptions(
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  enableInfiniteScroll: true,
                  height: MediaQuery.of(context).size.height * .40,
                  viewportFraction: 0.55,
                  enlargeCenterPage: true,
                ),
                carouselController: controller,
                itemCount: 3,
                itemBuilder: (_, index, _) => const MovieCardShimmer(),
              );
            }

            if (state is HomeTabEror) {
              return CarouselSlider.builder(
                options: CarouselOptions(
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  enableInfiniteScroll: true,
                  height: MediaQuery.of(context).size.height * .40,
                  viewportFraction: 0.55,
                  enlargeCenterPage: true,
                ),
                carouselController: controller,
                itemCount: 3,
                itemBuilder: (_, index, _) => const MovieCardShimmer(),
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}
