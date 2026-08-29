import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:movies_app/feature/explore_tap/view/widgets/tab_item.dart';
import 'package:movies_app/feature/explore_tap/view/widgets/tab_view_by_genre.dart';

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
    return SafeArea(
      child: Column(
        children: [
          TabBar(
            labelPadding: const EdgeInsetsDirectional.only(end: AppPadding.p8),
            padding: const EdgeInsetsDirectional.only(start: AppPadding.p16),
            tabAlignment: .start,
            indicatorColor: Colors.transparent,
            dividerColor: Colors.transparent,
            controller: tabController,
            isScrollable: true,
            tabs: generes
                .map(
                  (genre) => TabItem(
                    genre: genre,
                    isSelected: generes.indexOf(genre) == tabController.index,
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
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
