// 设置页面

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fvm/fvm.dart';
import 'package:get/get.dart';

import '../../generated/locales.g.dart';
import '../version_manager/flutter_config.service.dart';
import 'scenes/flutter_settings.scene.dart';
import 'scenes/fvm_settings.scene.dart';
import 'scenes/general_settings.scene.dart';
import 'settings.dto.dart';
import 'settings.service.dart';
import 'settings_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with TickerProviderStateMixin {
  final SettingsController settingsController = Get.put(SettingsController());

  TabController? _tabController;

  final List<Tab> tabs = <Tab>[
    Tab(
      text: LocaleKeys.labels_settings_general.tr,
    ),
    Tab(
      text: LocaleKeys.labels_settings_fvm.tr,
    ),
    Tab(
      text: LocaleKeys.labels_settings_flutter.tr,
    ),
  ];

  int tabbarIndex = 0;

  late AllSettings settings;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: tabs.length, vsync: this);

    final sidekickSettings = SettingsService.read();
    settings = AllSettings.create(sidekick: sidekickSettings);

    loadSettings();
  }

  void loadSettings() async {
    /// Update app state right away
    final sidekickSettings = SettingsService.read();

    //Go get async state
    final fvmSettings = await FVMClient.readSettings();
    final flutterSettings = await FlutterConfigService.getFlutterConfig();
    settings = AllSettings(
      // Set state
      sidekick: sidekickSettings,
      fvm: fvmSettings,
      flutter: FlutterSettings.fromMap(flutterSettings),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text('设置', style: Theme.of(context).textTheme.titleMedium)
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.0,
                  child: TabBar(
                      tabs: tabs,
                      controller: _tabController,
                      isScrollable: false,
                      automaticIndicatorColorAdjustment: false,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: theme.primaryColor,
                      labelColor: theme.primaryColor,
                      unselectedLabelColor: theme.textTheme.titleMedium?.color,
                      onTap: (index) {}),
                ),
              ],
            ),
            const Divider(
              thickness: 1,
              height: 1,
            ),
            GetBuilder<SettingsController>(builder: (controller) {
              return Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SettingsSectionGeneral(
                        controller.state.settings, handleSave),
                    FvmSettingsScene(controller.state.settings, handleSave),
                    SettingsSectionFlutter(
                        controller.state.settings, handleSave),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Future<void> handleSave() async {
    final savedMessage = LocaleKeys.labels_settings_settingsHaveBeenSaved.tr;
    final errorMessage = LocaleKeys.labels_settings_couldNotSaveSettings.tr;
    try {
      await settingsController.save(settings);
      EasyLoading.showSuccess(savedMessage);
    } on Exception catch (e) {
      EasyLoading.showError(errorMessage);
      // notifyError(errorMessage);
      EasyLoading.showError(e.toString());
    }
  }
}

class ColoredTabBar extends StatelessWidget implements PreferredSizeWidget {
  final PreferredSizeWidget tabBar;
  final Color color;

  const ColoredTabBar({super.key, required this.tabBar, required this.color});

  @override
  Widget build(BuildContext context) {
    return Ink(
      color: color,
      child: tabBar,
    );
  }

  @override
  Size get preferredSize => tabBar.preferredSize;
}
