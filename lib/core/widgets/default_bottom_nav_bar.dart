import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_assets.dart';
import 'package:movies_app/core/utilities/app_border_radius.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:svg_flutter/svg.dart';

class DefaultBottomNavigationBar extends StatelessWidget {
  const DefaultBottomNavigationBar({super.key,required this.currentIndex, required this.onCurrentIndexChange});
  final int currentIndex ;
  final Function(int index) onCurrentIndexChange;
  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarModel> itemsNav = [
      BottomNavigationBarModel(
        iconPath:AppAssets.homeIcon,
        label: "Home",
      ),
      BottomNavigationBarModel(
        iconPath: AppAssets.searchIcon,
        label: 'Search',
      ),
      BottomNavigationBarModel(
        iconPath:  AppAssets.exploreIcon,
        label: "Explore",
      ),
      BottomNavigationBarModel(
        iconPath: AppAssets.profileIcon,
        label: "Profile",
      ),
    ];
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppBorderRadius.r20),
      child: Container(
        height: 70,
        padding:  const EdgeInsets.symmetric(horizontal: AppPadding.p24),
        decoration:  ShapeDecoration(
          gradient: LinearGradient(colors: [
            AppColors.deepBlack.withValues(
                alpha: 0.5
            ),AppColors.lightBlack.withValues(
                alpha: 0.5
            ),AppColors.white.withValues(
                alpha: 0.2
            ),
          ],
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
          ),
          shadows:  [
            BoxShadow(
              color: AppColors.deepBlack.withValues(alpha: 0.05),
            ),
          ],
          shape: const Border(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
          itemsNav.map((item) {
            final index = itemsNav.indexOf(item);
            final isSelected = index == currentIndex;
            return GestureDetector(
              onTap: () {
               onCurrentIndexChange(index);
              },
              child: AnimatedContainer(
                curve: Curves.linear,
                duration: const Duration(milliseconds: 50),
                alignment: AlignmentDirectional.center,
                child:SvgPicture.asset(
                  itemsNav[index].iconPath,
                  fit: .scaleDown,
                  width: 30,
                  height: 30,
                  colorFilter: ColorFilter.mode(isSelected?AppColors.gold:AppColors.white, .srcIn),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class BottomNavigationBarModel {
  final String label;
  final String iconPath;

  BottomNavigationBarModel({
    required this.label,
    required this.iconPath,
  });
}