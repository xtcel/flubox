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
          SwitchListTile(
            title: Text(
              LocaleKeys.labels_settings_skipSetupFlutterOnInstall.tr,
            ),
            subtitle: Text(
              LocaleKeys.labels_settings_thisWillOnlyCloneFlutterAndNotInstall
                      .tr +
                  LocaleKeys
                      .labels_settings_dependenciesAfterANewVersionIsInstalled
                      .tr,
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
