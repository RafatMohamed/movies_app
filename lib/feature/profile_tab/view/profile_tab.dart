import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/feature/profile_tab/view/widgets/button_section.dart';
import 'package:movies_app/feature/profile_tab/view/widgets/header_section.dart';
import 'package:movies_app/feature/profile_tab/view/widgets/tabs_view_section.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColors.lightBlack,
        child: NestedScrollView(
          body: const TabsViewSection(),
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const Gap(36),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .19,
                    child: HeaderSection(),
                  ),
                  ButtonSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
