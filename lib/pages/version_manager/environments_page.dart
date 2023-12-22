import 'package:flubox/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:fvm/fvm.dart';
import 'package:get/get.dart';

import 'check_version_page.dart';
import 'download_version_page.dart';
import 'env_config_page.dart';

/// 环境页面

class EnvironmentsPage extends StatefulWidget {
  const EnvironmentsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _VersionManagerState();
  }
}

class _VersionManagerState extends State<EnvironmentsPage>
    with TickerProviderStateMixin {
  String currentVersion = "";
  TabController? _tabController;

  final List<Tab> tabs = <Tab>[
    Tab(
      text: LocaleKeys.labels_switch_version.tr,
    ),
    Tab(
      text: LocaleKeys.labels_donwload_version.tr,
    ),
    Tab(
      text: LocaleKeys.labels_env_variables.tr,
    ),
  ];

  int navIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: tabs.length, vsync: this);

    getFlutterReleases();

    // currentVersion = FVMClient.getGlobalVersionSync() ?? "";
    // setState(() {});
  }

  void getFlutterReleases() async {
    CacheVersion? globalVersion = await FVMClient.getGlobal();
    print("global version: $globalVersion");
    currentVersion = globalVersion?.name ?? "";

    List<CacheVersion> versions = await FVMClient.getCachedVersions();
    print("cached versions :$versions");

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(LocaleKeys.labels_environments.tr,
                  style: Theme.of(context).textTheme.titleMedium)
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          _buildTopNavigationBar(navIndex),
          Divider(
            height: 1,
            thickness: 1,
            color: Theme.of(context).dividerColor,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                CheckVersionPage(),
                DownloadVersionPage(),
                EnvConfigPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopNavigationBar(int index) {
    final theme = Theme.of(context);
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      SizedBox(
          width: MediaQuery.of(context).size.width / 2.0,
          child: TabBar(
              tabs: tabs,
              controller: _tabController,
              isScrollable: false,
              automaticIndicatorColorAdjustment: false,
              indicatorColor: theme.primaryColor,
              labelColor: theme.primaryColor,
              unselectedLabelColor: theme.textTheme.titleMedium?.color,
              indicatorSize: TabBarIndicatorSize.label,
              onTap: (index) => _onTabTap(index)))
    ]);
  }

  void _onTabTap(int index) {
    setState(() {
      navIndex = index;
    });
  }
}
