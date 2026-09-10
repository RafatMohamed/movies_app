import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:movies_app/feature/explore_tap/view/explore_tap.dart';
import 'package:movies_app/feature/home_tap/presentation/view/home_tap.dart';
import 'package:movies_app/feature/home_tap/presentation/view_model/home_tab_cubit.dart';
import 'package:movies_app/feature/home_tap/presentation/view_model/home_tab_state.dart';
import 'package:movies_app/feature/profile_tab/view/profile_tab.dart';
import '../../../core/utilities/package_utilies/get_it.dart';
import '../../../core/widgets/default_bottom_nav_bar.dart';
import '../../Search/view/search_view.dart';
import '../../Search/view_model/state_mangment.dart';

class MainAppView extends StatefulWidget {
  const MainAppView({super.key});

  @override
  State<MainAppView> createState() => _MainAppViewState();
}

class _MainAppViewState extends State<MainAppView> {
  int _currentIndex = 0;

  late final List<Widget> _screens = [
    HomeTap(onSeeMoreClicked: updateCurrentIndex),
    BlocProvider(
      create: (context) => getIt<MovieSearchCubit>(),
      child: const SearchView(),
    ),
    const ExploreTap(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<HomeTabCubit>(),
        child: Builder(
          builder: (context) {
            return Stack(
              children: [
                IndexedStack(index: _currentIndex, children: _screens),
                Positioned(
                  bottom: AppPadding.p16,
                  left: AppPadding.p10,
                  right: AppPadding.p10,
                  child: DefaultBottomNavigationBar(
                    currentIndex: _currentIndex,
                    onCurrentIndexChange: (index) {
                      if (context.read<HomeTabCubit>().state is! HomeTabEror) {
                        context
                            .read<HomeTabCubit>()
                            .increaseCurrentIndexOFGenere();
                        if (index == 0 && _currentIndex != index) {
                          context
                              .read<HomeTabCubit>()
                              .filterMovieByGenreOnNavigation();
                        }
                      }
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void updateCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
