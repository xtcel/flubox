import 'package:flutter/material.dart';
import 'package:fvm/fvm.dart';

import 'check_version_page.dart';
import 'download_version.dart';
import 'env_config_page.dart';

/// 版本管理页面

class VersionManagerPage extends StatefulWidget {
  const VersionManagerPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _VersionManagerState();
  }
}

class _VersionManagerState extends State<VersionManagerPage>
    with TickerProviderStateMixin {
  String currentVersion = "";
  TabController? _tabController;

  final List<Tab> tabs = <Tab>[
    const Tab(text: "环境配置"),
    const Tab(
      text: '版本切换',
    ),
    const Tab(
      text: '版本管理',
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: null,
        automaticallyImplyLeading: false,
        title: _buildTopNavigationBar(navIndex),
      ),
      body: TabBarView(
          controller: _tabController,
          children: tabs.map((Tab tab) {
            if (tab.text == "环境配置") {
              return const EnvConfigPage();
            } else if (tab.text == "版本切换") {
              return const CheckVersionPage();
            } else {
              return const DownloadVersionWidget();
            }
          }).toList()),
    );
  }

  Widget _buildTopNavigationBar(int index) {
    return TabBar(
        tabs: tabs,
        controller: _tabController,
        isScrollable: false,
        indicatorColor: Colors.red,
        labelColor: Colors.black,
        onTap: (index) => _onTabTap(index));
  }

  void _onTabTap(int index) {
    setState(() {
      navIndex = index;
    });
  }
}
