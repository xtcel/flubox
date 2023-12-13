import 'package:file_selector/file_selector.dart';
import 'package:flubox/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/package_info_util.dart';
import '../settings.dto.dart';
import '../settings.utils.dart';
import '../settings_controller.dart';

/// Settings section general
class SettingsSectionGeneral extends StatelessWidget {
  /// Constructor
  const SettingsSectionGeneral(
    this.settings,
    this.onSave, {
    Key? key,
  }) : super(key: key);

  /// Settings
  final AllSettings settings;

  /// On save handler
  final void Function() onSave;

  @override
  Widget build(BuildContext context) {
    void handleReset() async {
      // flutter defined function
      await showDialog(
        context: context,
        builder: (context) {
          // return object of type Dialog
          return AlertDialog(
            title: Text(
              LocaleKeys.tips_settings_areYouSureYouWantToResetSettings.tr,
            ),
            content: Text(LocaleKeys
                .tips_settings_thisWillOnlyResetSidekickSpecificPreferences.tr),
            buttonPadding: const EdgeInsets.all(15),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(LocaleKeys.buttons_cancel),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  settings.sidekick = SidekickSettings();
                  onSave();
                  // notify(context.i18n(
                  //     'modules:settings.scenes.appSettingsHaveBeenReset'));
                },
                child: Text(LocaleKeys.buttons_confirm.tr),
              ),
            ],
          );
        },
      );
    }

    // 获取版本号
    // final packageVersion = await PackageInfo.fromPlatform().version;
    final SettingsController settingsController =
        Get.find<SettingsController>();

    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: ListView(
        children: [
          // Text(LocaleKeys.labels_settings_general.tr,
          //     style: Theme.of(context).textTheme.titleLarge),
          // const SizedBox(height: 20),
          ListTile(
            title: Text(LocaleKeys.labels_settings_theme.tr),
            subtitle: Text(LocaleKeys
                .labels_settings_selectAThemeOrSwitchAccordingToSystemSettings
                .tr),
            trailing: DropdownButton<String>(
              underline: Container(),
              isDense: true,
              value: settings.sidekick.themeMode,
              items: [
                DropdownMenuItem(
                  value: SettingsThemeMode.system,
                  child: Text(
                    LocaleKeys.labels_settings_system.tr,
                  ),
                ),
                DropdownMenuItem(
                  value: SettingsThemeMode.light,
                  child: Text(
                    LocaleKeys.labels_settings_light.tr,
                  ),
                ),
                DropdownMenuItem(
                  value: SettingsThemeMode.dark,
                  child: Text(
                    LocaleKeys.labels_settings_dark.tr,
                  ),
                ),
              ],
              onChanged: (themeMode) async {
                settings.sidekick.themeMode = themeMode as String;
                settingsController.changeTheme(themeMode);
                onSave();
              },
            ),
          ),
          const Divider(),
          ListTile(
            title: Text(
              LocaleKeys.labels_settings_ideSelection.tr,
            ),
            subtitle: Text(
              LocaleKeys
                  .labels_settings_whatIdeDoYouWantToOpenYourProjectsWith.tr,
            ),
            trailing: DropdownButton(
              underline: Container(),
              isDense: true,
              value: settings.sidekick.ide ?? 'none',
              items: [
                const DropdownMenuItem(
                  value: 'none',
                  child: Text('None'),
                ),
                ...supportedIDEs
                    .map((e) => DropdownMenuItem(
                          value: e.name,
                          child: Row(
                            children: [
                              e.icon,
                              const SizedBox(
                                width: 10,
                              ),
                              Text(e.name),
                            ],
                          ),
                        ))
                    .toList()
              ],
              onChanged: (val) async {
                if (val == "Custom") {
                  final file = await openFile();
                  if (file != null) {
                    settings.sidekick.customIdeLocation = file.path;
                  } else {
                    return;
                  }
                }
                settings.sidekick.ide = val == 'none' ? null : val as String;
                onSave();
              },
            ),
          ),
          const Divider(),
          ListTile(
            title: Text(LocaleKeys.labels_settings_language.tr),
            trailing: DropdownButton<Locale>(
              underline: Container(),
              isDense: true,
              value: settings.sidekick.locale, // ?? Get.deviceLocale
              items: AppTranslation.translations.keys.map((localeKey) {
                final languageCode = localeKey.split('_').first;
                final countryCode = localeKey.split('_').last;

                final locale = Locale(languageCode, countryCode);
                return DropdownMenuItem(
                  value: locale,
                  child: Text(
                    "languages_$localeKey".tr,
                  ),
                );
              }).toList(),
              onChanged: (locale) async {
                settings.sidekick.locale = locale;
                Get.updateLocale(locale!);
                onSave();
              },
            ),
          ),
          const Divider(),
          ListTile(
            title: Text(LocaleKeys.labels_version.tr),
            trailing: Text(PackageInfoUtil.version),
          ),
          const Divider(),
          ListTile(
            title: Text(
              LocaleKeys.labels_settings_resetToDefaultSettings.tr,
            ),
            trailing: OutlinedButton(
              onPressed: handleReset,
              child: Text(LocaleKeys.labels_settings_reset.tr),
            ),
          ),
        ],
      ),
    );
  }
}
