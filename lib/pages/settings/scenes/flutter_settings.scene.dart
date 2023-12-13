import 'package:flutter/material.dart';
import 'package:fvm/fvm.dart';
import 'package:get/get.dart';
import '../../../generated/locales.g.dart';
import '../settings.dto.dart';

/// Flutter settings section
class SettingsSectionFlutter extends StatefulWidget {
  const SettingsSectionFlutter(this.settings, this.onSave, {super.key});

  /// Settings
  final AllSettings settings;

  final void Function() onSave;

  @override
  State<StatefulWidget> createState() {
    return SettingsSectionFlutterState(settings: settings);
  }
}

class SettingsSectionFlutterState extends State<StatefulWidget> {
  SettingsSectionFlutterState({required this.settings});

  /// Settings
  final AllSettings settings;
  bool fvmFlutterActivated = false;

  @override
  void initState() {
    // TODO: implement initState
    // settings = widget.settings;

    final globalVersion = FVMClient.getGlobalVersionSync();
    fvmFlutterActivated = globalVersion != null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final releases = ref.watch(releasesStateProvider);
    // final deactivate = !releases.hasGlobal;

    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: ListView(
        children: [
          // Text('Flutter', style: Theme.of(context).textTheme.titleLarge),
          // const SizedBox(height: 20),
          fvmFlutterActivated
              ? Container()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // TODO: Move this into a separate component
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange.withOpacity(0.1),
                        border: Border.all(
                          color: Colors.deepOrange,
                          width: 0.5,
                        ),
                      ),
                      child: Text(
                        LocaleKeys
                            .labels_settings_flutterSDKGlobalDescription.tr,
                        // context.i18n(
                        //     'modules:settings.scenes.flutterSDKGlobalDescription'),
                      ),
                    ),
                    const SizedBox(height: 20)
                  ],
                ),
          SwitchListTile(
            title: Text(
              LocaleKeys.labels_settings_analyticsCrashReporting.tr,
              // context
              //   .i18n('modules:settings.scenes.analyticsCrashReporting')
            ),
            subtitle: Text(
              LocaleKeys.labels_settings_analyticsCrashReportSubtitle.tr,
              // context
              //     .i18n('modules:settings.scenes.analyticsCrashReportSubtitle'),
            ),
            value: settings.flutter.analytics,
            onChanged: !fvmFlutterActivated
                ? null
                : (value) {
                    settings.flutter.analytics = value;
                    onSave();
                  },
          ),
          const SizedBox(height: 20),
          Text(
            LocaleKeys.labels_settings_platforms.tr,
            style: Theme.of(context).textTheme.headlineMedium,
          ), // context.i18n('modules:settings.scenes.platforms')
          const SizedBox(height: 20),
          SwitchListTile(
            title: Text(
              LocaleKeys.labels_settings_web.tr,
            ), // context.i18n('modules:settings.scenes.web')
            value: settings.flutter.web,
            onChanged: !fvmFlutterActivated
                ? null
                : (value) {
                    settings.flutter.web = value;
                    onSave();
                  },
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('MacOS'),
            value: settings.flutter.macos,
            onChanged: !fvmFlutterActivated
                ? null
                : (value) {
                    settings.flutter.macos = value;
                    onSave();
                  },
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('Windows'),
            value: settings.flutter.windows,
            onChanged: !fvmFlutterActivated
                ? null
                : (value) {
                    settings.flutter.windows = value;
                    onSave();
                  },
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('Linux'),
            value: settings.flutter.linux,
            onChanged: !fvmFlutterActivated
                ? null
                : (value) {
                    settings.flutter.linux = value;
                    onSave();
                  },
          ),
        ],
      ),
    );
  }

  void onSave() {}
}
