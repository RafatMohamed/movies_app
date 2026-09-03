import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/feature/profile_tab/view/widgets/history_list_section.dart';
import 'package:movies_app/feature/profile_tab/view/widgets/profile_tab_item.dart';
import 'package:movies_app/feature/profile_tab/view/widgets/watch_list._section.dart';
import 'package:movies_app/l10n/generated/app_localizations.dart';

class TabsViewSection extends StatefulWidget {
  const TabsViewSection({super.key});

  @override
  State<TabsViewSection> createState() => _TabsViewSectionState();
}

class _TabsViewSectionState extends State<TabsViewSection>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsetsGeometry.only(top: 14),
      child: Column(
        children: [
          TabBar(
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            dividerColor: Colors.transparent,
            indicatorColor: AppColors.gold,
            indicatorSize: .tab,
            controller: tabController,
            tabs: [
              ProfileTabItem(
                iconPath: 'assets/icons/watch_list.svg',
                text: l10n.watchList,
              ),
              ProfileTabItem(
                iconPath: 'assets/icons/file_svg.svg',
                text: l10n.history,
              ),
            ],
          ),
          Expanded(
            child: Container(
              color: AppColors.lightBlack,
              child: TabBarView(
                controller: tabController,
                children: const [WatchListSection(), HistoryListSection()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}