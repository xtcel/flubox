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
        appBar: BrnAppBar(
          title: "Flutools",
          automaticallyImplyLeading: false,
          actions: [
            // 设置按钮
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.settings,
                  color: Colors.grey,
                ))
          ],
        ),
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
      leading: leadingButton(),
      extended: extended,
      minExtendedWidth: 156,
      onDestinationSelected: onDestinationSelected,
      elevation: 1,
      destinations: destinations,
      trailing: trailingWidget(),
      selectedIndex: selectedIndex,
    );
  }

  final List<NavigationRailDestination> destinations = const [
    NavigationRailDestination(
        icon: Icon(Icons.message_outlined), label: Text("项目")),
    NavigationRailDestination(icon: Icon(Icons.games_sharp), label: Text("代码")),
    NavigationRailDestination(
        icon: Icon(Icons.calendar_month), label: Text("工具"))
  ];

  Widget leadingButton() {
    return InkWell(
      onTap: onLeadingButton,
      child: const Icon(
        Icons.menu_open,
        color: Colors.grey,
      ),
    );
  }

  Widget trailingWidget() {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: InkWell(
          onTap: () {
            onDestinationSelected?.call(destinations.length);
          },
          child: const Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: FlutterLogo(),
          ),
        ),
      ),
    );
  }
}
