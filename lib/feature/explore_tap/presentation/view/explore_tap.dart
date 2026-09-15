import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:movies_app/feature/explore_tap/presentation/view/widgets/tab_item.dart';
import 'package:movies_app/feature/explore_tap/presentation/view/widgets/tab_view_by_genre.dart';
import 'package:movies_app/feature/home_tap/presentation/view_model/home_tab_cubit.dart';
import 'package:movies_app/feature/home_tap/presentation/view_model/home_tab_state.dart';
import 'package:movies_app/l10n/generated/app_localizations.dart';

class ExploreTap extends StatefulWidget {
  const ExploreTap({super.key});

  @override
  State<ExploreTap> createState() => _ExploreTapState();
}

class _ExploreTapState extends State<ExploreTap>
    with SingleTickerProviderStateMixin {
  List<String> generes = [
    "Action",
    "Adventure",
    "Animation",
    "Biography",
    "Comedy",
    "Crime",
    "Documentary",
    "Drama",
    "Family",
    "Fantasy",
    "Horror",
    "Music",
    "Musical",
    "Mystery",
    "Romance",
    "Sci-Fi",
    "Sport",
    "Thriller",
    "War",
  ];

  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: generes.length, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    List<String> displayGenres = [
      l10n.action,
      l10n.adventure,
      l10n.animation,
      l10n.biography,
      l10n.comedy,
      l10n.crime,
      l10n.documentary,
      l10n.drama,
      l10n.family,
      l10n.fantasy,
      l10n.horror,
      l10n.music,
      l10n.musical,
      l10n.mystery,
      l10n.romance,
      l10n.sciFi,
      l10n.sport,
      l10n.thriller,
      l10n.war,
    ];

    return SafeArea(
      child: BlocListener<HomeTabCubit, HomeTabState>(
        listener: (context, state) {
          if (state is SeeMorePressed) {
            tabController.animateTo(generes.indexOf(state.currentGenere));
          }
        },
        child: Column(
          children: [
            TabBar(
              labelPadding: const EdgeInsetsDirectional.only(
                end: AppPadding.p8,
              ),
              padding: const EdgeInsetsDirectional.only(start: AppPadding.p16),
              tabAlignment: .start,
              indicatorColor: Colors.transparent,
              dividerColor: Colors.transparent,
              controller: tabController,
              isScrollable: true,
              tabs: displayGenres
                  .map(
                    (genre) => TabItem(
                      genre: genre,
                      isSelected:
                          displayGenres.indexOf(genre) == tabController.index,
                    ),
                  )
                  .toList(),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: generes
                    .map(
                      (genre) => Padding(
                        padding: const EdgeInsets.all(AppPadding.p24),
                        child: TabViewByGenre(genere: genre),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
