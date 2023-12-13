import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../generated/locales.g.dart';
import '../settings.dto.dart';

/// Fvm Settings Scene
class FvmSettingsScene extends StatelessWidget {
  /// Constructor
  const FvmSettingsScene(
    this.settings,
    this.onSave, {
    Key? key,
  }) : super(key: key);

  /// Settings
  final AllSettings settings;

  /// Save handler
  final Function() onSave;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: ListView(
        children: [
          // Text('FVM', style: Theme.of(context).textTheme.titleLarge),
          // const SizedBox(height: 20),
          SwitchListTile(
            title: Text(
              LocaleKeys.labels_settings_skipSetupFlutterOnInstall.tr,
              // context
              //   .i18n('modules:settings.scenes.skipSetupFlutterOnInstall')
            ),
            subtitle: Text(
              LocaleKeys.labels_settings_thisWillOnlyCloneFlutterAndNotInstall
                      .tr +
                  LocaleKeys
                      .labels_settings_dependenciesAfterANewVersionIsInstalled
                      .tr,

              // context.i18n(
              //         'modules:settings.scenes.thisWillOnlyCloneFlutterAndNotInstall') +
              //     context.i18n(
              //         'modules:settings.scenes.dependenciesAfterANewVersionIsInstalled'),
            ),
            value: settings.fvm.skipSetup,
            onChanged: (value) {
              settings.fvm.skipSetup = value;
              onSave();
            },
          ),
        ],
      ),
    );
  }
}
