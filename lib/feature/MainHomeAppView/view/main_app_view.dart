import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:movies_app/feature/explore_tap/view/explore_tap.dart';
import 'package:movies_app/feature/home_tap/view/home_tap.dart';
import 'package:movies_app/feature/profile_tab/view/profile_tab.dart';

import '../../../core/widgets/default_bottom_nav_bar.dart';
import '../../Search/view/search_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeTap(),
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
}
