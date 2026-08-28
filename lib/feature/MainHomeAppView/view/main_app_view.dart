import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_padding.dart';

import '../../../core/widgets/default_bottom_nav_bar.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const Placeholder(),
    const Placeholder(),
    const Placeholder(),
    const Placeholder(),
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

