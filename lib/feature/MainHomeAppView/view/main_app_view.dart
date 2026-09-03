import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:movies_app/feature/explore_tap/view/explore_tap.dart';
import 'package:movies_app/feature/home_tap/view/home_tap.dart';
import 'package:movies_app/feature/profile_tab/view/profile_tab.dart';

import '../../../core/widgets/default_bottom_nav_bar.dart';
import '../../Search/view/search_view.dart';

class MainAppView extends StatefulWidget {
  const MainAppView({super.key});

  @override
  State<MainAppView> createState() => _MainAppViewState();
}

class _MainAppViewState extends State<MainAppView> {
  int _currentIndex = 0;

  late final List<Widget> _screens = [
    HomeTap(onSeeMoreClicked: updateCurrentIndex),
    const SearchView(),
    const ExploreTap(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(index: _currentIndex, children: _screens),
          Positioned(
            bottom: AppPadding.p16,
            left: AppPadding.p10,
            right: AppPadding.p10,
            child: DefaultBottomNavigationBar(
              currentIndex: _currentIndex,
              onCurrentIndexChange: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void updateCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
