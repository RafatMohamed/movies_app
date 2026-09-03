import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/feature/profile_tab/view/widgets/button_section.dart';
import 'package:movies_app/feature/profile_tab/view/widgets/header_section.dart';
import 'package:movies_app/feature/profile_tab/view/widgets/tabs_view_section.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});
  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return SafeArea(
      child: Container(
        color: AppColors.lightBlack,
        child: NestedScrollView(
          controller: scrollController,
          body: const TabsViewSection(),
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: AnimatedBuilder(
                animation: scrollController,
                builder: (context, child) {
                  double opacity =
                      1.0 - (scrollController.offset / 200).clamp(0.0, 1.0);

                  return Opacity(opacity: opacity, child: child);
                },
                child: Column(
                  children: [
                    const Gap(36),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * .17,
                      child: const HeaderSection(),
                    ),
                    const Gap(16),
                    const ButtonSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
