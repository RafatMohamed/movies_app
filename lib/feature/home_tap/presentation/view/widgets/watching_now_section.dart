import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:movies_app/core/utilities/app_assets.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:movies_app/core/widgets/custom_movie_card.dart';
import 'package:movies_app/core/widgets/movie_card_shemmer.dart';
import 'package:movies_app/feature/home_tap/presentation/view_model/home_tab_cubit.dart';
import 'package:movies_app/feature/home_tap/presentation/view_model/home_tab_state.dart';
import '../../../../../core/models/film_model.dart';
import 'package:movies_app/l10n/generated/app_localizations.dart';

import '../../../../../core/utilities/app_locale_controller.dart';

class WatchingNowSection extends StatefulWidget {
  final void Function(int index) onSeeMoreClicked;

  const WatchingNowSection({required this.onSeeMoreClicked, super.key});

  @override
  State<WatchingNowSection> createState() => _WatchingNowSectionState();
}

class _WatchingNowSectionState extends State<WatchingNowSection> {
  final List<FilmModel> movies = [];
  late HomeTabCubit myCubit;
  @override
  void initState() {
    myCubit = context.read<HomeTabCubit>();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.127,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Image.asset(AppAssets.watchNowImage, fit: BoxFit.cover)],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            vertical: 12,
            horizontal: AppPadding.p16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<HomeTabCubit, HomeTabState>(
                builder: (_, state) {
                  if (state is HomeTabLoading) {
                    return Text(
                      "genere",
                      style: textTheme.titleLarge?.copyWith(
                        color: AppColors.white,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    );
                  }
                  if (state is HomeTabLoaded) {
                    return Text(
                      myCubit.myGenereList[myCubit.currentGenereIndex],
                      style: textTheme.titleLarge?.copyWith(
                        color: AppColors.white,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    );
                  }
                  if (state is HomeTabOnScrollLoading) {
                    return Text(
                      myCubit.myGenereList[myCubit.currentGenereIndex],
                      style: textTheme.titleLarge?.copyWith(
                        color: AppColors.white,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    );
                  }
                  if (state is HomeTabEror) {
                    return Text(
                      'genre',
                      style: textTheme.titleLarge?.copyWith(
                        color: AppColors.white,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
              InkWell(
                onTap: () {
                  widget.onSeeMoreClicked(2);
                },
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context).seeMore,
                      style: textTheme.titleLarge?.copyWith(
                        color: AppColors.gold,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Gap(AppPadding.p4),
                    const Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: AppColors.gold,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<HomeTabCubit, HomeTabState>(
          builder: (context, state) {
            if (state is HomeTabLoaded) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: ListView.separated(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppPadding.p16,
                  ),
                  separatorBuilder: (context, index) => const Gap(16),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.watchingNowMovies.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: CustomMovieCard(
                        movieId: state.watchingNowMovies[index].id ?? 0,
                        pathImage:
                            state.watchingNowMovies[index].largeCoverImage ??
                            '',
                        rate: state.watchingNowMovies[index].rating.toString(),
                      ),
                    );
                  },
                ),
              );
            }
            if (state is HomeTabLoading) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: ListView.separated(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppPadding.p16,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => const Gap(16),
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: const MovieCardShimmer(),
                    );
                  },
                ),
              );
            }

            return const SizedBox();
          },
        ),

        const Gap(16),
      ],
    );
  }
}
