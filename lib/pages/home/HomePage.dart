import 'dart:io';

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

import '../projects/projects_page.dart';
import '../tools/tools_page.dart';
import '../version_manager/version_manager_page.dart';

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
          VersionManagerPage(),
          ToolsPage(),
          VersionManagerPage(),
        ],
      )),
    ]));
  }

  void _onDestinationSelected(int value) {
    _controller.jumpToPage(value); // tag1
    if (value < 3) {
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

  final List<NavigationRailDestination> destinations = const [
    NavigationRailDestination(
        icon: Icon(Icons.apps_rounded), label: Text("Projects")),
    NavigationRailDestination(
        icon: Icon(Icons.settings_suggest_rounded), label: Text("Evn")),
    NavigationRailDestination(
        icon: Icon(Icons.construction_rounded), label: Text("Tools"))
  ];

  Widget loginWidget() {
    return const Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 40, bottom: 20.0),
        child: Column(
          children: [
            FlutterLogo(),
            SizedBox(
              height: 10,
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
