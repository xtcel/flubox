import 'dart:io';

import 'package:flubox/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../projects/projects_page.dart';
import '../settings/settings_page.dart';
import '../tools/tools_index_page.dart';
import '../version_manager/environments_page.dart';
import 'widgets/app_bottom_bar.dart';

/// 首页

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final PageController _controller = PageController();
  final ValueNotifier<int> _selectIndex = ValueNotifier(0);
  bool extended = false;
  final kEnvVars = Platform.environment;

  @override
  void initState() {
    // TODO: implement initState
    print("kEnvVars: $kEnvVars");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const AppBottomBar(),
        body: Row(children: [
          ValueListenableBuilder<int>(
            valueListenable: _selectIndex,
            builder: (_, index, __) => LeftNavigation(
              selectedIndex: index,
              extended: extended,
              onLeadingButton: () {
                extended = !extended;
                setState(() {});
              },
              onDestinationSelected: _onDestinationSelected,
            ),
          ),
          Expanded(
              child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _controller,
            children: const [
              ProjectsPage(),
              EnvironmentsPage(),
              ToolsIndexPage(),
              SettingsPage(),
            ],
          )),
        ]));
  }

  void _onDestinationSelected(int value) {
    _controller.jumpToPage(value); // tag1
    if (value < 4) {
      _selectIndex.value = value; //tag2
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _selectIndex.dispose();
    super.dispose();
  }
}

class LeftNavigation extends StatelessWidget {
  const LeftNavigation(
      {required this.selectedIndex,
      required this.extended,
      this.onLeadingButton,
      this.onDestinationSelected,
      super.key});
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;
  final bool extended;
  final GestureTapCallback? onLeadingButton;

  @override
  Widget build(BuildContext context) {
    List<NavigationRailDestination> destinations = [
      NavigationRailDestination(
          icon: const Icon(Icons.apps_rounded),
          label: Text(LocaleKeys.labels_projects.tr)),
      NavigationRailDestination(
          icon: const Icon(Icons.settings_suggest_rounded),
          label: Text(LocaleKeys.labels_environments.tr)),
      NavigationRailDestination(
          icon: const Icon(Icons.construction_rounded),
          label: Text(LocaleKeys.labels_tools.tr)),
      NavigationRailDestination(
          icon: const Icon(Icons.settings),
          label: Text(LocaleKeys.buttons_settings.tr))
    ];

    return NavigationRail(
      leading: loginWidget(),
      extended: extended,
      minExtendedWidth: 156,
      onDestinationSelected: onDestinationSelected,
      elevation: 1,
      destinations: destinations,
      trailing: leadingButton(), // trailingWidget(),
      selectedIndex: selectedIndex,
    );
  }

  Widget loginWidget() {
    return const Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 40, bottom: 20.0),
        child: Column(
          children: [
            Image(
              image: AssetImage("assets/images/logo.png"),
              width: 50,
              height: 50,
            ),
            SizedBox(
              height: 5,
            ),
            Text("FluBox")
          ],
        ),
      ),
    );
  }

  Widget leadingButton() {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: InkWell(
            onTap: onLeadingButton,
            child: Icon(
              extended
                  ? Icons.format_indent_decrease_rounded
                  : Icons.format_indent_increase_rounded,
              color: const Color(0xFFD8D8D8),
            ),
          ),
        ),
      ),
    );
  }
}
