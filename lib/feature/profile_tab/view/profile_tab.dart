import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/feature/profile_tab/view/widgets/button_section.dart';
import 'package:movies_app/feature/profile_tab/view/widgets/header_section.dart';
import 'package:movies_app/feature/profile_tab/view/widgets/tabs_view_section.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColors.lightBlack,
        child: NestedScrollView(
          controller: _scrollController,
          body: const TabsViewSection(),
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: AnimatedBuilder(
                animation: _scrollController,
                builder: (context, child) {
                  final offset = _scrollController.hasClients
                      ? _scrollController.offset
                      : 0.0;
                  final double opacity =
                      (1.0 - (offset / 200)).clamp(0.0, 1.0);

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
